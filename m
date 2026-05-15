Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75173EFFCF
	for <iommu@lists.linux.dev>; Fri, 15 May 2026 21:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778879692; cv=none; b=eiC7thWTPxph4afK945HiTotXCfqhgBrKNV0J6bb5C06KdcI0X4CUPihrcDNjdmw4CD1nCNm4gEu/TyZdbQ3C23hwGQP2tK50sl0K7t98Ci+pqjiU/bBAOkVfAy5ZrSxd6eG6wD5HegcLXO0v2ZGOx0UZMKzCm3kL0sbGekpEUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778879692; c=relaxed/simple;
	bh=AEsIZBvhIg+ptwqhrgMw5/o+SifZBkqY2LGhfABVAgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JgGs/VIQHJ3PjWimDWR0n4VP54twdhpPibuvctM7adYW8FhZOPFckoSotZ1LHGKAkEBYzrI0o2TmrKvYpY+nBSWGkqw1nrbjWdieSVPN+TJsbwd+Y6ErqXBqIqUaWX9hTAz/ky1VK0GqRBKa2BveRQSboPW9rZchSRwYkS/J4FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oC864Nzm; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oC864Nzm"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2f0ad52830cso402581eec.1
        for <iommu@lists.linux.dev>; Fri, 15 May 2026 14:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778879690; x=1779484490; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JUJQNdeVMNwfKTOPs21LgA+X7O3xhgiTOeD6RQEitLA=;
        b=oC864Nzm0GpBWa/uTyIQE/8nX36yJ3lAgBT9S62lESmVMSlhdKD9g/KWfgsXYS230Q
         UwxrRCdbTstpluaxpdPkWuXpuNNllnlwuqQ+vtyaGkTC/oMTbhSXkPEgSZ8cWHPGOUUm
         hDXlK1wCmqhdGYa5NILjdrVO5nsPu3bcy32xCMdsPvi2ikeKo0vZad/HnyY8yOO8Tgzc
         wG2QP+ryDGxYbhUs7HfOrAqOz4yMGFuwTB1nDX2eMwZaTHn1OZVwoCpuknosPGI1VVx0
         iI+Jn++LgAfJNFy2km9ZRYags8Pt5V2mgGKYrl4ixTc4gDoGldcYKZ76UbOYLFtGlvHN
         VWLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778879690; x=1779484490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JUJQNdeVMNwfKTOPs21LgA+X7O3xhgiTOeD6RQEitLA=;
        b=IItKGwnNBTY8UPHrr5d/cqiScGORF4+W3HXPVsCNgsNm31c8sasaWZ1ax1yOBQTopa
         F6suL3I71ccTXvgx85mYfEoOILcuCPGtccBW57aWkvtH7VOb29jlF4pXxJLZlKC0q6i0
         Fqh0ijtYaf2X1Iemrj6pNovP4usTHNYy4yhjoVZcZQ1Sp9JWr6hGS5+IojQvEt+Nz/3C
         v5QRmf77IXPzylvVQLtppUQ8G3poc/0VTAgvqcagU2wVQdiaTvF2LKGwa+FfjPccOVOI
         iwxqfY2X88xKwoXOoB2hgn6EdLuBYBcm0yeytbmvQr4C/6uy7Ic5Wal8yx8DdoT9HNZo
         w1aQ==
X-Forwarded-Encrypted: i=1; AFNElJ9em6e/xAAPC88J9r5dQPqlSOPDVmR4GJjeyF9fVzyXfoh7ZH+Hy1Ik83KnTAbAIwfzu8xWHA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyri/BwSAuZp68VLpAEW3giBN/2hVMxV786mWKCdZKJMean93Mq
	D4pC2EcguXoXT1I7xwvY6DCQugp62VPEY8mWLH+thpVaxlrK4NJbuWXw
X-Gm-Gg: Acq92OFAoslJ0ILgT6cK+s0PBsrOMoUXijSRdpgau0DSfJrkrDYdJG68jL0d0kzR2lG
	AVAu++JUGHaNoc3wK47TjKLWPHtm5KK62/C3DG4ctd/xPsVwNBMxPa7K08KV3jpmywuY2nCZQPK
	HkqcrwZoiSx3/t4f6i9SN40vO5Ode6kCK0maW7LXN7LXqcAj7Zwa7TIus7ZzUjowhzmsW7eR3Cv
	gFdIUm43ZAB6vtF+MgnxXkHHEewbqE7yaoYGDmFHhvqBGLT02NMbBhQ2yeDka+o427ZO/smbgek
	T7ZVMvoam60yyvUBYhBKMU1/BI5BIk9MoEyA7qhJSsbaa1/PQImCO7CTz3ElWkkLnVpHuzG+jcg
	Ng3LLPwjkgVqgXIyMc14QxrAtGkEoUqvG7xvjQGV0Y/byO+itYRs4tDI4PA3pMFvBZv1hMTJdVa
	BOr5QJEqY4ET3H+ddLsU5NxKaJDDdizqA=
X-Received: by 2002:a05:7300:4307:b0:2ea:5057:a331 with SMTP id 5a478bee46e88-30398655963mr2890920eec.21.1778879689799;
        Fri, 15 May 2026 14:14:49 -0700 (PDT)
Received: from mimas.lan ([2603:8000:df01:38f7:a6bb:6dff:fecf:e71a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30294adddaasm8120311eec.13.2026.05.15.14.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 14:14:49 -0700 (PDT)
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
Subject: [PATCH v16 13/38] tpm/tpm_tis: Allow locality to be set to a different value
Date: Fri, 15 May 2026 14:13:45 -0700
Message-ID: <20260515211410.31440-14-ross.philipson@gmail.com>
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

From: "Daniel P. Smith" <dpsmith@apertussolutions.com>

Provide a one-time function tpm_chip_set_locality() for setting the
correct locality needed by DRTM launches.

Co-developed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
Signed-off-by: Ross Philipson <ross.philipson@gmail.com>
---
 drivers/char/tpm/tpm-chip.c     | 35 ++++++++++++++++++++++++++++++++-
 drivers/char/tpm/tpm_tis_core.c |  2 ++
 include/linux/tpm.h             |  4 ++++
 3 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index 0719577e584d..a9620b27b63d 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -44,7 +44,7 @@ static int tpm_request_locality(struct tpm_chip *chip)
 	if (!chip->ops->request_locality)
 		return 0;
 
-	rc = chip->ops->request_locality(chip, 0);
+	rc = chip->ops->request_locality(chip, chip->kernel_locality);
 	if (rc < 0)
 		return rc;
 
@@ -343,6 +343,7 @@ struct tpm_chip *tpm_chip_alloc(struct device *pdev,
 	}
 
 	chip->locality = -1;
+	chip->kernel_locality = 0;
 	return chip;
 
 out:
@@ -658,3 +659,35 @@ void tpm_chip_unregister(struct tpm_chip *chip)
 	tpm_del_char_device(chip);
 }
 EXPORT_SYMBOL_GPL(tpm_chip_unregister);
+
+/**
+ * tpm_chip_set_locality() - Set the TPM locality the kernel uses
+ * @chip:	&tpm_chip instance
+ * @locality:   new locality
+ *
+ * This a one time function to set the locality the kernel driver
+ * uses. Returns zero or POSIX error on failure.
+ */
+int tpm_chip_set_locality(struct tpm_chip *chip, u8 locality)
+{
+	int ret;
+
+	if (locality >= TPM_MAX_LOCALITY)
+		return -EINVAL;
+
+	ret = tpm_try_get_ops(chip);
+	if (ret)
+		return ret;
+
+	if (!(chip->flags & TPM_CHIP_FLAG_SET_LOCALITY_ENABLED)) {
+		tpm_put_ops(chip);
+		return -EPERM;
+	}
+
+	chip->kernel_locality = locality;
+	chip->flags &= ~TPM_CHIP_FLAG_SET_LOCALITY_ENABLED;
+	tpm_put_ops(chip);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(tpm_chip_set_locality);
diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 70aba05f4ee1..cf6d929ce5aa 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -1125,6 +1125,8 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
 	if (IS_ERR(chip))
 		return PTR_ERR(chip);
 
+	chip->flags |= TPM_CHIP_FLAG_SET_LOCALITY_ENABLED;
+
 #ifdef CONFIG_ACPI
 	chip->acpi_dev_handle = acpi_dev_handle;
 #endif
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 0db277af45c3..4a26a49040b9 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -159,6 +159,8 @@ struct tpm_chip {
 
 	/* active locality */
 	int locality;
+	/* the locality used by kernel */
+	u8 kernel_locality;
 
 #ifdef CONFIG_TCG_TPM2_HMAC
 	/* details for communication security via sessions */
@@ -197,6 +199,7 @@ enum tpm_chip_flags {
 	TPM_CHIP_FLAG_HWRNG_DISABLED		= BIT(9),
 	TPM_CHIP_FLAG_DISABLE			= BIT(10),
 	TPM_CHIP_FLAG_SYNC			= BIT(11),
+	TPM_CHIP_FLAG_SET_LOCALITY_ENABLED	= BIT(12),
 };
 
 #define to_tpm_chip(d) container_of(d, struct tpm_chip, dev)
@@ -244,6 +247,7 @@ static inline ssize_t tpm_ret_to_err(ssize_t ret)
 extern int tpm_is_tpm2(struct tpm_chip *chip);
 extern __must_check int tpm_try_get_ops(struct tpm_chip *chip);
 extern void tpm_put_ops(struct tpm_chip *chip);
+int tpm_chip_set_locality(struct tpm_chip *chip, u8 locality);
 extern ssize_t tpm_transmit_cmd(struct tpm_chip *chip, struct tpm_buf *buf,
 				size_t min_rsp_body_length, const char *desc);
 extern int tpm_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
-- 
2.47.3

