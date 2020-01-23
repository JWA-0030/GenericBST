// Jesse Alsing

// COP 3503, Fall 2017

// ====================
// GenericBST: BST.java
// ====================
// Basic binary search tree (BST) implementation that supports insert() and
// delete() operations. This framework is provide for you to modify as part of
// Programming Assignment #2.


import java.io.*;
import java.util.*;

// Here we create our node structure for each of our Nodes of type T
class Node<T>
{
	T data;
	Node<T> left, right;

	Node(T data)
	{
		this.data = data;
	}
}

// So we need to let our generic T use the compareTo method by extending
// its inputs to generics
public class GenericBST< T extends Comparable<T>>
{
	
	// Declare the root node
	private Node<T> root;
	
	
	public void insert(T data)
	{
		root = insert(root, data);
	}
	
	// We go to the appropriate node to insert our new node 
	private Node<T> insert(Node<T> root, T data)
	{
		if (root == null)
		{
			return new Node<>(data);
		}
		else if (data.compareTo(root.data)< 0)
		{
			root.left = insert(root.left, data);
		}
		else if (data.compareTo(root.data) > 0)
		{
			root.right = insert(root.right, data);
		}
		else
		{
			// Stylistically, I have this here to explicitly state that we are
			// disallowing insertion of duplicate values. This is unconventional
			// and a bit cheeky.
			;
		}

		return root;
	}

	public void delete(T data)
	{
		root = delete(root, data);
	}
	// We need to iterate to the right node to be deleted
	private Node<T> delete(Node<T> root, T data)
	{
		if (root == null)
		{
			return null;
		}
		else if (data.compareTo(root.data) < 0)
		{
			root.left = delete(root.left, data);
		}
		else if (data.compareTo(root.data) > 0)
		{
			root.right = delete(root.right, data);
		}
		else
		{
			if (root.left == null && root.right == null)
			{
				return null;
			}
			else if (root.right == null)
			{
				return root.left;
			}
			else if (root.left == null)
			{
				return root.right;
			}
			else
			{
				root.data = findMax(root.left);
				root.left = delete(root.left, root.data);
			}
		}

		return root;
	}

	// This method assumes root is non-null, since this is only called by
	// delete() on the left subtree, and only when that subtree is non-empty.
	private T findMax(Node<T> root)
	{
		while (root.right != null)
		{
			root = root.right;
		}

		return root.data;
	}

	// Returns true if the value is contained in the BST, false otherwise.
	public boolean contains(T data)
	{
		return contains(root, data);
	}
	// We iterate to the right location and if the if statements dont run 
	// we know the node we are at is the right node
	private boolean contains(Node<T> root, T data)
	{
		if (root == null)
		{
			return false;
		}
		else if (data.compareTo(root.data) < 0)
		{
			return contains(root.left, data);
		}
		else if (data.compareTo(root.data) > 0)
		{
			return contains(root.right, data);
		}
		else
		{
			return true;
		}
	}

	public void inorder()
	{
		System.out.print("In-order Traversal:");
		inorder(root);
		System.out.println();
	}
	// For the inorder traversal we go down the left children then to the
	// root then down the right tree
	private void inorder(Node<T> root)
	{
		if (root == null)
			return;

		inorder(root.left);
		System.out.print(" " + root.data);
		inorder(root.right);
	}

	public void preorder()
	{
		System.out.print("Pre-order Traversal:");
		preorder(root);
		System.out.println();
	}
	// For preorder traversal we print at the root then down the left and 
	// right children
	private void preorder(Node<T> root)
	{
		if (root == null)
			return;

		System.out.print(" " + root.data);
		preorder(root.left);
		preorder(root.right);
	}

	public void postorder()
	{
		System.out.print("Post-order Traversal:");
		postorder(root);
		System.out.println();
	}
	// for post order traversal we iterate the the last children nodes 
	// to the left then to the right then recursively print back up
	private void postorder(Node<T> root)
	{
		if (root == null)
			return;

		postorder(root.left);
		postorder(root.right);
		System.out.print(" " + root.data);
	}
	public static double difficultyRating(){
		
		return 2.3;
	}
	
	public static double hoursSpent(){
		
		return 2.5;
	}

}
