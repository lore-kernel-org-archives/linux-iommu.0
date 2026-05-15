Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BA53EEAD6
	for <iommu@lists.linux.dev>; Fri, 15 May 2026 21:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778879715; cv=none; b=n+KnyJVQrBtYXwVXSP1THrB6Hq9Dn21jUWP4YK6L+47uYBHAQIajtL+b6MjH1hpcRggfgWl9hE2L6BZwTOt62D0PfApshrJHKHeE9b8iVyW2J3e+YpxVfACQ0o7qn3KyqF4BzpjdrRq3WTZLxm1oOqzkOUGDJv3w0ehwtBLWImU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778879715; c=relaxed/simple;
	bh=9qOiZjuMb85ewhTujam6wtmPKlWhsGUjRgHlaJ5hOXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TzRpRDM8QBQg3SgLXOz8TuuaJ0FG2PM9qf8i6Uo2d3lnjqpO58GkX7Ze6UGQwUoDqkRWgh1zH+yxYcdmZ713LqyzexP8KNCUZiKf2rZkZii3c4AiMSsx5SL66o0ejQ69b3f57XxjPOc1vR63rMG4ObygKDvmE7w4trJkovwxey8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XceXWAiz; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XceXWAiz"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2ef2a1cc06dso1356944eec.0
        for <iommu@lists.linux.dev>; Fri, 15 May 2026 14:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778879712; x=1779484512; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EseM1chjBypSoW0cp1ToXZvQ5KcO5EkTarmMMC63WUM=;
        b=XceXWAizcP4q/xZOMjqEqCFKyLgMmBrUQW260XmqblCETNG7jgvlRQLRydfU00mL6q
         2AAhNpc0R7o3gKETT5aX5i6rQ/kv/HQWYbIDEi+DMcxEgfbSbgc3MuEYgiud1TgxgeM6
         Ueivup8l8CAnVyWJGvWWH4K4Np/0BG6eSVdGPXby8//J1W7UaCLd6I1DTmg9PvsGIO1N
         SnpzVvjuGslLQIeGGTffHxEXbiFX7sSaVOHgbsYROE88kkG2EInKBBi8/B89Nwi7gcnc
         H1eVR7QgutdDludSy4oQ+EXoauX5z7YFhci3my/x1bFFALD60SfAj9sn7vcnEOvqorrX
         RSKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778879712; x=1779484512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EseM1chjBypSoW0cp1ToXZvQ5KcO5EkTarmMMC63WUM=;
        b=DgkLKgJDn5bHFoBR0Dq3CBKt9z2THpvpFYSYDFCn4ar47+zHGVTl18Fuvg/yb2F9hi
         cRtnMfYOO+oAA5cbUjS6WLwNMx5HNAgmqTGhMn+mq+aRk0Yx80vvVdgEYlP8dlAK5fbU
         1cE0xhEU4nTIqY9qNy7UWGyhFid/0h7cBQR0wMLTe9i+nUaSYOrFdtaY8diQVrofcJjn
         yeNaIy0H00y32RIhxQm5+t36L1OCvGcHQw5fc+Iy430WWZ0ZI3EugvBmCWe7FkRF0F6K
         bed+c0kqgZkIiD7ouZIURdTw/PMfxyxsvZ2W5bKPy4nRw2DhOjgrpBncxsMPNiSG0OCE
         Cqng==
X-Forwarded-Encrypted: i=1; AFNElJ9xngdzHRLh3k16ZuBEebZKczPC8S4j/5LchHzkWTi8zPB5yPiSqBnKJRc4eksEGAwAsnFHQg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwU954SUgDlVi4dPf5mzMiSk9QQkqWVBMdb+cmBZXRQaSIAaC2x
	n/25urW4B7gDlz1Mz9V/9ftf2x1u9LUsUCasoPvbiwn6az85AyGAR4Ct
X-Gm-Gg: Acq92OE7xiv4CTJH648OHxKCkFvLMR7hstG1Dm3voFeyVAsS++m0moEuERUIpJ4Vkcm
	JAPeTa0ZdNWzwdnqbMKVgSwesVKd8F8CM/+pJsaOEXnQg+WilNnEDFKiCoFdGP/Za468v58qjbb
	XsyEJn2wwcolDuSyrmHvCaOva0yviADNdkDWPeZf3Pza7defMjk09rPpLmvh56vvUgMcYR1kQ4q
	53H/o8XIkffvJ7TxIzHIV8P33GGwPhSulZPve/gPFnX+H0o7JQJHk2jGUgBPuoEt3uFZIYc6ik4
	qp2xgz5d48MyxeDwJvBLpm82heivnqc7K1AhKS9GW6QnOj/AatOoT3WKUZp6+OfFi5iM6sZTag6
	jZhPV7KjgwTRJmB3cxHYIv7RcuWG4xI8rSHHUJqUNvdVwZylNMLNmKOcV2dRDz7KDfECwcW4nrQ
	FZtCYDJnBjNj3iml7Q71t381F7OwaJwSA=
X-Received: by 2002:a05:7301:19a5:b0:2ed:e17:d50d with SMTP id 5a478bee46e88-3039868c8bcmr2807177eec.32.1778879712290;
        Fri, 15 May 2026 14:15:12 -0700 (PDT)
Received: from mimas.lan ([2603:8000:df01:38f7:a6bb:6dff:fecf:e71a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-302978ad18asm8003129eec.26.2026.05.15.14.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 14:15:11 -0700 (PDT)
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
Subject: [PATCH v16 21/38] lib/crypto: Add SHA1 support for pre-boot environments
Date: Fri, 15 May 2026 14:13:53 -0700
Message-ID: <20260515211410.31440-22-ross.philipson@gmail.com>
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

Allow the SHA1 library code in lib/crypto/sha1.c to be used in
pre-boot environments. Use the __DISABLE_EXPORTS macro to disable
function exports and define the proper values for that environment
as was done earlier for SHA256.

Acked-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Ross Philipson <ross.philipson@gmail.com>
---
 lib/crypto/sha1.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/lib/crypto/sha1.c b/lib/crypto/sha1.c
index daf18c862fdf..f30b5ff3b31e 100644
--- a/lib/crypto/sha1.c
+++ b/lib/crypto/sha1.c
@@ -125,7 +125,7 @@ static void __maybe_unused sha1_blocks_generic(struct sha1_block_state *state,
 	memzero_explicit(workspace, sizeof(workspace));
 }
 
-#ifdef CONFIG_CRYPTO_LIB_SHA1_ARCH
+#if defined(CONFIG_CRYPTO_LIB_SHA1_ARCH) && !defined(__DISABLE_EXPORTS)
 #include "sha1.h" /* $(SRCARCH)/sha1.h */
 #else
 #define sha1_blocks sha1_blocks_generic
@@ -207,6 +207,12 @@ void sha1(const u8 *data, size_t len, u8 out[SHA1_DIGEST_SIZE])
 }
 EXPORT_SYMBOL_GPL(sha1);
 
+/*
+ * Pre-boot environments (as indicated by __DISABLE_EXPORTS being defined)
+ * don't need the SHA1 HMAC support code.
+ */
+#ifndef __DISABLE_EXPORTS
+
 static void __hmac_sha1_preparekey(struct sha1_block_state *istate,
 				   struct sha1_block_state *ostate,
 				   const u8 *raw_key, size_t raw_key_len)
@@ -302,6 +308,8 @@ void hmac_sha1_usingrawkey(const u8 *raw_key, size_t raw_key_len,
 }
 EXPORT_SYMBOL_GPL(hmac_sha1_usingrawkey);
 
+#endif /* !__DISABLE_EXPORTS */
+
 #if defined(sha1_mod_init_arch) || defined(CONFIG_CRYPTO_FIPS)
 static int __init sha1_mod_init(void)
 {
-- 
2.47.3

