Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C294C77CA
	for <iommu@lists.linux.dev>; Fri, 15 May 2026 21:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778879717; cv=none; b=J8UYPIiUSYPGwOl+Nj6NN5iQ0iSE0uA20//3BYEAsNuoCe0x7Ffj80BBbAXK6QNlca1m7dnTmK2L7gbbQ/IK5gYdeTqZ5Axotn6dGcJeuvr4YPjk9ExcFk7qe75U/G36ZUn7bgFWW3Z9RWO8miBYm0nPL5BNlPiPyrrmElkBfCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778879717; c=relaxed/simple;
	bh=7BAv62SCJAZd+nbTYMXdF5QJlgc01qXtbND56r+tijw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lNJcCsdun2MRF/kjlkExLmXWh891G0pHUTbK6GIWxW2ssQvnEt8eVF2rcjH+z/e+rtl7+P7t0yE5H6H8sjfM36/knTmUAuu3/bYde55QwnSES0x6TJUbeXDeetMgVls8JdYm0FtQrNKsMrqnmrmXRYS7nOgNQJnDm2FuD3SV9fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n9I/z8aL; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n9I/z8aL"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-30246cfd41aso1512866eec.1
        for <iommu@lists.linux.dev>; Fri, 15 May 2026 14:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778879715; x=1779484515; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RpW1a/fScKIJOJjIsuP4+bGqNlbA4fQX64i8+rdO0zg=;
        b=n9I/z8aLThkXHFqoWgS3+ySKMibyIPYbBeOQOwcDRCYi1TkS0DH6hOKy/PSGHQjOok
         lzqAYC5TCBqsH8ZlMWcTpQuGvrIMm5dHTolx/w0B1a8qy39S0nrT+C/EIPyolZg3m+AI
         XNvQMDRmGgtKEz1Wa43SqU2J9aqSCedXYnnQgjmZExkfn2YUFioy4m4H5vMmRt/EmKnk
         8cFcO+czIcG3p69TYtX18bwlpyMbPCi7MxqneoNLZ3ZMn+AlEWYvmhQrBzU1U7Zz28Vz
         YZhUvzBJ8iUwSqUkBnl/RRDlQxFUJhihXSLNUFUhm8tKGyUrEeynY9a7WUuc+iLZ5bYT
         K9Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778879715; x=1779484515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RpW1a/fScKIJOJjIsuP4+bGqNlbA4fQX64i8+rdO0zg=;
        b=T5ueWnWc6U3iPJwzJf3SscjAbsTlIFGNWJC38CjCaMIrKokOyzu/tsBj3tkIq9Urhc
         LHZsvb1H1+hzpFyja3Aurf8rJcvKB9IWA7m7Wei2zqSNDPAKkycUiP338m/aUK7V/pjW
         EIp+aM6Wzc5FPSgP3Y+EEA36EIPEgL8JmKD6tYsLX1FrbslPk6U4SWTQewC6ztVWPHqx
         mKMzQbelvQRF+lgkNbzVQiH/yHevcJEN2/rjksQaqjIoMZgSAreGNnqaGW9hXk6spnBm
         s1GmxCjLN0XTuGe1mhmxczKIh/B6N4Fx2tLbWxib5DVOccV5OJYn7O0BMdEhKk1r4sVz
         qHJA==
X-Forwarded-Encrypted: i=1; AFNElJ8ffEFkyGINK44FetQMjiJPzWIEHD6z9SAE9iSksnvuOUnyFCReenE3/lcYJcoaXhAF9fnh9w==@lists.linux.dev
X-Gm-Message-State: AOJu0YwyPyE8Uzge/db4Nlbj/KEfIzqAU0665H4x1MPgDjq9+SVDEOMt
	9+ZG8d6h261+C1kJ1RGGbF9s30b3/auMn8qQNHSzkYKI1m10ltNDwd0m
X-Gm-Gg: Acq92OGBtn1ZKORDvztSDnm9LrvxwC9i5VQ8wCBKaqylOQipw6Oe9qKCljvhZ3pBgzd
	zHYjhFRfKKU3vBNwR1303279w2UtJDJ9xwIwzsMvZMIdR+E4WTXfPOPFqWMZInc8UmftvGI5QPL
	hoBLwT+4zBYBxOXC2VTYA+CmWIyw5TwT8ZtK+mMhnPtFRW2n/X29B2u1vZempwFy58T2Eu9Z0V+
	Mo64KjJnDfZgqQzVsS7Jxne5bLXCUTe8iBJ4PeyyOLkVWWViQTRqJPsXtQUws5vY44yoYJt6fuG
	B37rVI3hNpsHzxOUnd6ydnNgEKKdOWRAN7VNoHxEtzduMEQNCBOolemOn1KYTgZFf8ddGefNZ/6
	fgIIU6PYR3zocPYDNgHv+wn8KfcgmmyJ2q2Qw7HbRU9WcFThuYfic7K58A8AxUo/6A9I7pN+q/Q
	8pqnVdJMgp76wxyO2gpDx2Tq2R8Ph8YmY=
X-Received: by 2002:a05:7300:a94b:b0:2be:142f:d499 with SMTP id 5a478bee46e88-30398678a39mr2873251eec.16.1778879715061;
        Fri, 15 May 2026 14:15:15 -0700 (PDT)
Received: from mimas.lan ([2603:8000:df01:38f7:a6bb:6dff:fecf:e71a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-302978ad18asm8003208eec.26.2026.05.15.14.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 14:15:14 -0700 (PDT)
From: Ross Philipson <ross.philipson@gmail.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-integrity@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-efi@vger.kernel.org,
	iommu@lists.linux.dev
Cc: ross.philipson@gmail.com,
	dpsmith@apertussolutions.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	hpa@zytor.com,
	dave.hansen@linux.intel.com,
	ardb@kernel.org,
	mjg59@srcf.ucam.org,
	James.Bottomley@hansenpartnership.com,
	peterhuewe@gmx.de,
	jarkko@kernel.org,
	jgg@ziepe.ca,
	luto@amacapital.net,
	nivedita@alum.mit.edu,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	corbet@lwn.net,
	ebiederm@xmission.com,
	dwmw2@infradead.org,
	baolu.lu@linux.intel.com,
	kanth.ghatraju@oracle.com,
	daniel.kiper@oracle.com,
	andrew.cooper3@citrix.com,
	trenchboot-devel@googlegroups.com
Subject: [PATCH v16 22/38] lib/crypto: Add SHA512 support for pre-boot environments
Date: Fri, 15 May 2026 14:13:54 -0700
Message-ID: <20260515211410.31440-23-ross.philipson@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260515211410.31440-1-ross.philipson@gmail.com>
References: <20260515211410.31440-1-ross.philipson@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow the SHA512 library code in lib/crypto/sha512.c to be used in
pre-boot environments. Use the __DISABLE_EXPORTS macro to disable
function exports and define the proper values for that environment
as was done earlier for SHA256.

Signed-off-by: Ross Philipson <ross.philipson@gmail.com>
---
 lib/crypto/sha512.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/lib/crypto/sha512.c b/lib/crypto/sha512.c
index 605eab51aabd..160e81d86da6 100644
--- a/lib/crypto/sha512.c
+++ b/lib/crypto/sha512.c
@@ -133,7 +133,7 @@ sha512_blocks_generic(struct sha512_block_state *state,
 	} while (--nblocks);
 }
 
-#ifdef CONFIG_CRYPTO_LIB_SHA512_ARCH
+#if defined(CONFIG_CRYPTO_LIB_SHA512_ARCH) && !defined(__DISABLE_EXPORTS)
 #include "sha512.h" /* $(SRCARCH)/sha512.h */
 #else
 #define sha512_blocks sha512_blocks_generic
@@ -250,6 +250,12 @@ void sha512(const u8 *data, size_t len, u8 out[SHA512_DIGEST_SIZE])
 }
 EXPORT_SYMBOL_GPL(sha512);
 
+/*
+ * Pre-boot environments (as indicated by __DISABLE_EXPORTS being defined)
+ * don't need the SHA2 HMAC support code.
+ */
+#ifndef __DISABLE_EXPORTS
+
 static void __hmac_sha512_preparekey(struct sha512_block_state *istate,
 				     struct sha512_block_state *ostate,
 				     const u8 *raw_key, size_t raw_key_len,
@@ -406,6 +412,8 @@ void hmac_sha512_usingrawkey(const u8 *raw_key, size_t raw_key_len,
 }
 EXPORT_SYMBOL_GPL(hmac_sha512_usingrawkey);
 
+#endif /* !__DISABLE_EXPORTS */
+
 #if defined(sha512_mod_init_arch) || defined(CONFIG_CRYPTO_FIPS)
 static int __init sha512_mod_init(void)
 {
-- 
2.47.3

