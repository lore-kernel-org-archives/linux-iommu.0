Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D763F86F6
	for <iommu@lists.linux.dev>; Fri, 15 May 2026 21:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778879700; cv=none; b=YrMg2oBvG4Xhro6m2xTniSs7+wJiqHAlAp5Q5MIz2FOmbox9N6GXt8SnfHZu+L+bn3qQHKDUNp7guNvdZz+ltMJ8U72BD405TmucqH3VLYh423DNn2+znrG211d/DY441lbm0FGk3bWX2B2W16PTVWNbayHFGht+MTz/PSChexs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778879700; c=relaxed/simple;
	bh=/w4xIQd+FodWBf21xbEabPQcoqxxR+rnVAOAKm/PKP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uTWQylY8aZ+sVlGQJvAEquF6rMdIML+mnoWeJQq+hnfmoRIvfRJFB923Z0dlgsr16N8tSGPQwgOFkfn0onQBonCLS5Xgbd/f5YkbEvSCMvVQVHUe7XdWo/GJn30u1+oupez0cfJVGoUj9jaLbc5VmUEzG1PoSQZ/UezPLdQd+lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=scBD4Gcq; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="scBD4Gcq"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-30246cfd41aso1511248eec.1
        for <iommu@lists.linux.dev>; Fri, 15 May 2026 14:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778879698; x=1779484498; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aFOHDGCsOHbtZzrbMRrMDpLy4uq6fKhTRLiSKMVovBw=;
        b=scBD4GcqcV/XjJb5XJN4k3UnrQ5DyX57zw24gKWo89DDlm+JHDDMQ/in5xbXouWNMt
         yCi3NNg9K0dH59ghvFQHBzpwsMorzb6rpbPXLl7GQ9c950FRWLg+RZUUCIa/p6bD3eRZ
         lvy2/qYRryp33IS4REGDr0Q5iKOf28eOfLyAjKfIuelCvqAJve+1BQTNVdO3aIV6eJ4r
         bB7FqI4ZuEPZpKLuJ4AJCc9L2e20TeqQQwQakaAdU52LX96uRKrGNWn1JiOhhJHRKzXJ
         a7ygmrd9wx5WpolaMWv75yjsoB+AAiD6ywgSIOqzGM38ltt3KXCj9B75sH5ozlUdNG/A
         NT6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778879698; x=1779484498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aFOHDGCsOHbtZzrbMRrMDpLy4uq6fKhTRLiSKMVovBw=;
        b=o5di18PoyfFKzsP+fu4gqXW6ouqcVY6KsWhO6urp5VRlp0txcgmWWFmiBsJ/bG4d2j
         zp4iBsFNtiR82EgXXV8PN9XebQXS7k0vom2SdDtreuSbPP8YHCv1I3THll291k5H8l3J
         g4M1aSOTCbEfai8aN9GL6EBKzm5Quhar/YJQjg5cvlxKkTmw09eY62oCdfrtwS4AJ8Jw
         2ZonwUqpPR7q6K2SL9YQnAxq2aIDNFrGVs6/9gfEt5h28HpoCEgcqPImxIPXYpzn6vR4
         81OJ1pCaB9vNnMCGGxhoCtvPGDsZpXKV5L19dgVBNV2ZYZUyg35/2g/pNIPUHHlp1BJF
         sBZA==
X-Forwarded-Encrypted: i=1; AFNElJ9hsZw9+T2S4k1FU51FHMgtuEKs18P7bGcMoHvUaOjmcep9WX2WEMRW2ODbSUvOxHbWD0rQXA==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywp4EPXhvlaCqCeAb/WT4+f7Saj4yIMXBsBQzplpOaFmn2zeTaG
	UiuXQYI9Z6NzzMRy+oMHsrHfRjXXAJoyx3cocMptLPCqXdXqikxrjhxk
X-Gm-Gg: Acq92OFhPDB2x6+idtqaKj4HKUtD9Dk6hRdj0ZwzdZyIGjcdjpGTF6oKvteQk66b9ba
	Y+9woYq67dGvLmL9HZJ9tXdEp4zEwGuhCN3pPhruGxvA0dMVWojXCfS5VCRrAtwtA3Mcuz0FfFH
	BJsyPcwmYo4WK7/rCgQp6TQkfuSxv2WuhvDOjKn8claVqk1+xburFPDBIeZlWpvRdqsaNQJMsQL
	ygiN0S0AuV0J7u4PzrK5gPNLTV+qWraZ8RXPUeMAlE01fnHR+JydxRqqeLBXOVI1/FSFP/Q+RsY
	IhrrnX3AWWHB6CtcFyQnvuWchAUPKGNUO0WG9RMa6VUtVX5IN/q5/xApUDZhA0kiWw33KYwa7rE
	5bMzH1Mldc8MnHKeE+2lu1YxFZ+Lj1BuhilzhXFRHnnRwJvbxVGk0ykqaL2ZdoWarZBRLRWR9N2
	e606QspM3yNItozvLPl/okCyRJBBI7Re42D9ukEnYmBA==
X-Received: by 2002:a05:693c:8386:20b0:2df:919f:ce59 with SMTP id 5a478bee46e88-30398678a48mr2108609eec.19.1778879698427;
        Fri, 15 May 2026 14:14:58 -0700 (PDT)
Received: from mimas.lan ([2603:8000:df01:38f7:a6bb:6dff:fecf:e71a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-302973bbd50sm7961724eec.20.2026.05.15.14.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 14:14:58 -0700 (PDT)
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
Subject: [PATCH v16 16/38] x86: Secure Launch Kconfig
Date: Fri, 15 May 2026 14:13:48 -0700
Message-ID: <20260515211410.31440-17-ross.philipson@gmail.com>
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

Add an x86 Kconfig option for compiling in/out the Secure Launch feature.
Secure Launch is controlled by a single on/off boolean.

Signed-off-by: Ross Philipson <ross.philipson@gmail.com>
---
 arch/x86/Kconfig | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index e2df1b147184..fd9edb0651d9 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1989,6 +1989,21 @@ config EFI_RUNTIME_MAP
 
 	  See also Documentation/ABI/testing/sysfs-firmware-efi-runtime-map.
 
+config SECURE_LAUNCH
+	bool "Secure Launch DRTM support"
+	depends on X86_64 && X86_X2APIC && TCG_TIS && TCG_CRB
+	select CRYPTO_LIB_SHA1
+	select CRYPTO_LIB_SHA256
+	select CRYPTO_LIB_SHA512
+	help
+	  The Secure Launch feature allows a kernel to be launched directly
+	  through a vendor neutral DRTM (Dynamic Root of Trust for Measurement)
+	  solution, with Intel TXT being one example. The DRTM establishes an
+	  environment where the CPU measures the kernel image, employing the TPM,
+	  before starting it. Secure Launch then continues the measurement chain
+	  over kernel configuration information and other launch artifacts (e.g.
+	  any initramfs image).
+
 source "kernel/Kconfig.hz"
 
 config ARCH_SUPPORTS_KEXEC
-- 
2.47.3

