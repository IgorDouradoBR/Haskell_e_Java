-- Desenvolvido por:
-- Victor dos Santos Melo
-- victor.melo.001@acad.pucrs.br

import Data.Tree
import Data.List
import Data.Function

-- Para testar a codificação, usar a função huffman. input1 e input2 podem ser utilizados como entrada.
-- ex: huffman input1

input1 = [('a',0.4),('b',0.2),('c',0.2),('d',0.1),('e',0.1)]
input2 = [('a',45.0),('b',13.0),('c',12.0),('d',16.0),('e',9.0),('f',5.0)]

huffman:: [(Char,Double)] -> [(Char,String)]
huffman (x:xs) = huffmanAux (x:xs) False where
        huffmanAux:: [(Char,Double)] -> Bool -> [(Char,String)]
        huffmanAux (x:xs) False = huffmanAux (sortBy (compare `on` (snd)) (x:xs)) True
        huffmanAux (x:xs) True = genCode (genTree (x:xs) Nothing)

--Gera árvore binária a partir de lista dos caracteres e suas frequências
genTree::[(Char,Double)] -> Maybe (Tree (Maybe Char,Double)) -> Tree (Maybe Char,Double)
genTree list Nothing = genTreeAux (getTreeList list) ((length list)-1) where
	-- Gera árvore binária a partir de lista de árvores
    genTreeAux::[(Tree (Maybe Char, Double), Double)] -> Int -> Tree (Maybe Char, Double)
    genTreeAux ((tree,freq):xs) 0 = tree
    genTreeAux ((t1,freq1):(t2,freq2):tail) n = genTreeAux (sortBy (compare `on` (snd)) ((mergeBinTrees (t1,freq1) (t2,freq2)):tail)) (n-1)

-- Une duas árvores binárias em uma, criando uma nova raiz e adicionando cada subárvore em um lado.
mergeBinTrees::(Tree (Maybe Char, Double),Double) -> (Tree (Maybe Char, Double),Double) -> (Tree (Maybe Char, Double),Double)
mergeBinTrees (t1,freq1) (t2,freq2) = (Node (Nothing,freq1+freq2) [t1,t2],freq1+freq2)

-- Recebe lista de nodos e suas frequências e retorna lista de árvores destes nodos e suas frequências (converte caracter para árvore)
getTreeList::[(Char,Double)] -> [(Tree (Maybe Char, Double), Double)]
getTreeList [] = []
getTreeList ((c,f):xs) = ((Node (Just c,f) []),f):(getTreeList xs)

-- Gera o código de Huffman a partir de uma árvore binária
genCode::Tree (Maybe Char, Double) -> [(Char,String)]
genCode tree = genCodeAux tree "" where
    genCodeAux::Tree (Maybe Char, Double) -> String -> [(Char,String)]
    genCodeAux (Node (Nothing, f) [sub1,sub2]) str = (genCodeAux sub1 (str++"0"))++(genCodeAux sub2 (str++"1"))
    genCodeAux (Node (Nothing, f) [Node (Just v,freq) []]) str= [(v,str++"0")]
    genCodeAux (Node (Just char, freq) []) str = [(char,str)]
