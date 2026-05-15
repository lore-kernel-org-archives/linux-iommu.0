Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C933F5BFB
	for <iommu@lists.linux.dev>; Fri, 15 May 2026 21:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778879726; cv=none; b=u6YjS8sdsFHZW2FVQi1nnX6vbm+gc2QiYhDwLUcvxb6s2VfcNAwNpI/HRiNB4Rj9L6/VAf927BSJIGN9lR+LTkUyoHKjuG/Tt/txWOqrDKcraoWnunEO9DBj+9jAFHH99IM3JKW8LR0mELIMY1Wxv0T3Us90f+bYnDaZbhZuF7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778879726; c=relaxed/simple;
	bh=DULLarGA3N2WbmTOoIAH6Z6cAJNNwTwfc+oSbMTDbH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ADWLd8wGDrkEFjdQMcA1+/gqXHukfs5qDG9K2el6NshuM6gZAfa32NCVZoMq43VK/EigCuMRhm80trM4TMU6NNtGrXkC8/7g38QEnNHwPuyX7UF0NGoideY3pJI/Hlx2lX+7w1D9EXu52kI1mN0QV+nfXh7R6Wg4mPP3aSNqJN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eo5tk0tI; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eo5tk0tI"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-30246cfd41aso1513774eec.1
        for <iommu@lists.linux.dev>; Fri, 15 May 2026 14:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778879723; x=1779484523; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ER4IWQsMKw/HNZSo0sHiz6UgahZlpRSMvCUCrr/URAk=;
        b=eo5tk0tIC6w07stG/iaJ9oOOWzsdMRfyPdEBmlJOxFELi+kK3KSakAsvn1soZ4hxAZ
         k1trPHYe4e0krzDIppx1X182z1FolgZdkAdKrh/Ed/8dXVVTejrdzuO5bz4Z+bM08jYM
         ayfY8aeq2Bnzof3cu5MYvwP87abbdXcuh14XQ55dULzq8MgFVynby8og8y7IuTk9LaNK
         tVld/xYbbAN9LEXmfn9J8ogucOKeAms07iNYbWI8pzmCgS/kVhxBCDTCEXKymfDdw1cM
         xJBMIdYJMDAO9Iqo1FY7dVxwt+cYaPhpms/9uB6E1R0+OTN9Vpw1BbsX+PK0RFlCisfp
         i4fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778879723; x=1779484523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ER4IWQsMKw/HNZSo0sHiz6UgahZlpRSMvCUCrr/URAk=;
        b=GRG7fgrWCo4st+1Wz/zSyLiTuMOAsYYXRPsaJ/hb0aw820Qpfih9TxiJ/ou73Z8dPM
         x64QNxnlKHGcjATgXJYQypbn9TxBp+QM46yiBLkPMs0zhUQjrwvSozvgH7X5hPdBQ0F2
         qDl0Ls61uzZvGaaQO/G6EcIQ7Zkl67SPD+O1wXwMHPH93PKlvmsDjwHNCKWzzz5kxMz0
         W7DtacxIJ6QyFNXEKSS4XVlH49ODJvurwtsBNjUJb8eM/Llf7uowsbxwctKslbtH7x3d
         ku64Oa1XUTVDSOw0+HiFRUTGL1kIXFxGDORTypSywa2G9fMn95pkhQyZdz5t6uRAg5As
         Iu9Q==
X-Forwarded-Encrypted: i=1; AFNElJ8Yi5mnscIdcmranToHeEKOKo5wAkR7iyNKgl4dIOlw8Xu+pdqUjHUwT2y/Ra9vhU35HLr2sQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzZHDSGuYEIO2KAeObF5cO9wNtHUSEwSlO1DjqnQT3Xp5v2qcEi
	fmeDWIdGWWnr+utQPy1dTPRJhtToUr946vlvzwrWD/b/tC6mi5W1CYiF
X-Gm-Gg: Acq92OFCPCDTW5pXIynalO5HS/Mnkk8MlIyaAIiWKTP/E242moMBQiTBI7qHZvVPcrw
	MS51GXGldTJ55N481Jv0CmfkEHsZ+glHEJTZF7xwH2ozVEmRHM0Ceq3y0NHGa79TwJf4MmTOYfk
	NrL2aj8WpKwDMEQwLQGbW/33nU/mWnATmGLgO+L3IJClAEYx8wWVtojFw6K+Bxn87rW087nkLVI
	bEwYRggtq5OBHjB34Fy5SgH31iXc69EfqEb2RYUsrDNXOZ0H+ScBaAN6SaWvqCVJTLZW0Lbs6fU
	dhywbCis0imV9lCUnt4p9H+vx0W7EeTCc5wv3jqjUQgvWSsEaI6jIeHe/ace7pdyXVN957zzsuK
	a9EI9BgRgglAhrk+qRQ9rP5iWddTlyYZsijte4sx2pNcMeslYkbQQgIAPYFMQxbmnMhznAFyvAo
	JCb136IQ46AIc55edtWK3Hsaz0QhT8BGI1LnCVXoP0ew==
X-Received: by 2002:a05:7301:4184:b0:2f4:3a9c:818c with SMTP id 5a478bee46e88-303986b1521mr2959973eec.29.1778879723496;
        Fri, 15 May 2026 14:15:23 -0700 (PDT)
Received: from mimas.lan ([2603:8000:df01:38f7:a6bb:6dff:fecf:e71a])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cbcb9ef5sm10736508c88.2.2026.05.15.14.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 14:15:23 -0700 (PDT)
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
Subject: [PATCH v16 25/38] x86/boot: Slight refactor of the 5 level paging logic
Date: Fri, 15 May 2026 14:13:57 -0700
Message-ID: <20260515211410.31440-26-ross.philipson@gmail.com>
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

From: Ard Biesheuvel <ardb@kernel.org>

In preparation for adding Secure Launch support, which will require that
the number of paging levels remains untouched, tweak the logic slightly
so that the slaunch check can be inserted easily.

No functional change intended.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ross Philipson <ross.philipson@gmail.com>
---
 arch/x86/boot/compressed/pgtable_64.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
index 0e89e197e112..3e9d651da73e 100644
--- a/arch/x86/boot/compressed/pgtable_64.c
+++ b/arch/x86/boot/compressed/pgtable_64.c
@@ -102,6 +102,7 @@ static unsigned long find_trampoline_placement(void)
 
 asmlinkage void configure_5level_paging(struct boot_params *bp, void *pgtable)
 {
+	bool l5_enabled = native_read_cr4() & X86_CR4_LA57;
 	void (*toggle_la57)(void *cr3);
 	bool l5_required = false;
 
@@ -118,10 +119,12 @@ asmlinkage void configure_5level_paging(struct boot_params *bp, void *pgtable)
 	 *     + CPUID leaf 7 is supported
 	 *     + the leaf has the feature bit set
 	 */
-	if (!cmdline_find_option_bool("no5lvl") &&
-	    native_cpuid_eax(0) >= 7 && (native_cpuid_ecx(7) & BIT(16))) {
-		l5_required = true;
+	if (native_cpuid_eax(0) < 7 || !(native_cpuid_ecx(7) & BIT(16)))
+		return;
+
+	l5_required = !cmdline_find_option_bool("no5lvl");
 
+	if (l5_required) {
 		/* Initialize variables for 5-level paging */
 		__pgtable_l5_enabled = 1;
 		pgdir_shift = 48;
@@ -132,7 +135,7 @@ asmlinkage void configure_5level_paging(struct boot_params *bp, void *pgtable)
 	 * The trampoline will not be used if the paging mode is already set to
 	 * the desired one.
 	 */
-	if (l5_required == !!(native_read_cr4() & X86_CR4_LA57))
+	if (l5_required == l5_enabled)
 		return;
 
 	trampoline_32bit = (unsigned long *)find_trampoline_placement();
-- 
2.47.3

