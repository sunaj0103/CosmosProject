package com.cosmos.web.member;

import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.NoSuchAlgorithmException;
import java.security.PrivateKey;
import java.security.PublicKey;

import javax.crypto.Cipher;

public class RSA {
	private PublicKey publicKey;
	private PrivateKey privateKey;

	/**
	 * 키 쌍 생성
	 */
	public KeyPair keyGen() {
		KeyPair keyPair = null;

		try {
			KeyPairGenerator keyPairGen = KeyPairGenerator.getInstance("RSA");
			keyPair = keyPairGen.generateKeyPair();

			publicKey = keyPair.getPublic();
			privateKey = keyPair.getPrivate();

		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}

		return keyPair;
	}

	public PublicKey getPublic() {
		return publicKey;
	}

	public PrivateKey getPrivate() {
		return privateKey;
	}

	/**
	 * 암호화
	 */
	public byte[] encryptRSA(byte[] input, PublicKey publicKey) throws Exception {
		byte[] encrypted = null;

		try {
			Cipher cipher = Cipher.getInstance("RSA");
			cipher.init(Cipher.ENCRYPT_MODE, publicKey);
			encrypted = cipher.doFinal(input);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return encrypted;
	}

	/**
	 * 암호화
	 */
	public byte[] encryptRSA(byte[] input, PrivateKey privateKey) throws Exception {
		byte[] encrypted = null;

		try {
			Cipher cipher = Cipher.getInstance("RSA");
			cipher.init(Cipher.ENCRYPT_MODE, privateKey);
			encrypted = cipher.doFinal(input);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return encrypted;
	}

	/**
	 * 복호화
	 */
	public byte[] decryptRSA(byte[] input, PrivateKey privateKey) throws Exception {
		byte[] decrypted = null;
		try {
			Cipher cipher = Cipher.getInstance("RSA");
			cipher.init(Cipher.DECRYPT_MODE, privateKey);
			decrypted = cipher.doFinal(input);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return decrypted;
	}

	/**
	 * 복호화
	 */
	public byte[] decryptRSA(byte[] input, PublicKey publicKey) throws Exception {
		byte[] decrypted = null;
		try {
			Cipher cipher = Cipher.getInstance("RSA");
			cipher.init(Cipher.DECRYPT_MODE, publicKey);
			decrypted = cipher.doFinal(input);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return decrypted;
	}

}
