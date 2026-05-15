Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A733ECBE4
	for <iommu@lists.linux.dev>; Fri, 15 May 2026 21:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778879688; cv=none; b=b/qYrKrRjS8WxN7ksFjJN6pGSxd5sY47d0o/vrRzqYzuGCXpW+cxdF3laudFLCKSYjDydltxJFRaThUexq8IIL0uksfODG7yV0AFtz0XFD/r852tzh5f31c7PR44Ey56DoCpvukwn5SARCAYTH7hkpmpFm7mFp4DrXdKWknHE10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778879688; c=relaxed/simple;
	bh=Ty5sURnTFWVnfbnIBPkCCksC+Y0itcL3NCDAmhozFyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p65qqL9taLftlqnkvmMyS1iABbcK+6C7AXLRbUNBfns2P7pBVSzU0g1mlHhqVcDELzbAp8M9OAatHbIVJY3NtKHjZMyBeTvkUsRnLBpMiJinYVTapHGQ7QT2XFg8l0fNApP7jFj6ez7hhFQNSUcFCngv1XWNQnAYBozY+t7XWbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ase81DSP; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ase81DSP"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1329fc4bf77so360446c88.1
        for <iommu@lists.linux.dev>; Fri, 15 May 2026 14:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778879684; x=1779484484; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MWgkYkzNwtEfRsNqnMWcy72BtOHvVyAwK+VJB1q1fiM=;
        b=ase81DSPlSbVeRXkFzazJw/WgISQNh/ZBVPvGZdpnl0GiMtRDNZRWg4ksGjua1x+bs
         pu5/pGq9ECYbAME6m3kL4X9YOogoDNIXwVdxjLWQYy9VpdhEddQ7VGIXz/QRooEJarTh
         snYVHw5bQEc0XPhcGef4E6eyvFYmn9Gx6GQmr+Ws+jSS8bTJw/auFvRfCmm5ktUqM2Kj
         BEnASf9lxtRTf1sGK6pJWOU4DMXOT6q5js0/ykvwM0UqdxRUz/+Qk6Ex3qhk6ls9Ufw8
         WdSW4Y0sKOCTuhMdC/BcqoO7DhDGCANpUs/GZylndmrOtU7HmkXtSqK40Fa0xoBknDAb
         j8bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778879684; x=1779484484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MWgkYkzNwtEfRsNqnMWcy72BtOHvVyAwK+VJB1q1fiM=;
        b=Mq1uWR1dblOhQOSLzjHCuiNWfVMIwUeS40Jh6B8Aq9KsD/5fH2Iukk73xLBJdrSAGG
         nMAlSwwsDH/IUYlIGUGQtqTF5OPpkT8hYpuCt/OoIdyEDY73ig8xdMaEYNPc581F9kUD
         m3m3rmJwWbOvX4Vui2a4cOTQUQ/EDwZ8hKDhb/DVz1PfbudS1ne3ab5WZnu6FD3wX4tU
         d3F0HTtx5Th4woofuTs1EaNV5mW7KQvxfyzYhLGsSYsd07LBTpszmd3GfEBYnHQCfbnd
         Vn8BGXulWf6Wl8qTRXj4kqq4AyUI+0PwyEVlNFXQsqNSjLwePYXZco7CqxFl7RhNtOHo
         HGmA==
X-Forwarded-Encrypted: i=1; AFNElJ8nrC8ezDcsx/v9HLJn7c+S7B/7oxLiaKBzHd8bKb5tpuIOGXZcTyjxTEnUOzKbTera+AEsGA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzATHn4NytW6hGalZV7kaHnRgxC2cFhWf5d+PXbvtFx+w1UKfOu
	jyDn4crmQlgIqoFwe4Vm3kMfBi4Jw1jHUUFh27w2BxT7X+HG9mJ2f4cP
X-Gm-Gg: Acq92OHGBSy+FS0M5kQ9dLTyYpQPEO7OnwaBMMu5M8GY9eVwMLPBWMCVik6wzivvi9H
	GuPa610MjROX5yL/ZYgU0qYxRnK2uCKlNrXtS9nF/ccVSrqj1EzDPQzqheJUMZDio5TudZ/fmbi
	0MpHvMm3sefCWBFqvXaoZ/IUxL6yrupxFbp3/tYCcJTq6OdIoDfGkym2jtRTSX69WSsqN07JbY5
	UZpW5OC6kWycoHJl6Zl5BiO6Tng8iWT91BvEdtx26ByDpgJLCjxG+3YAgvj4/Wfr65f8x9Foch/
	Fl34Xf+qOqM3UTwMR9obMONswgzMCzOsYG6WF//6yb3eIiaU0pPJzYn4m9JY6BkgP0RJmUYQkPd
	Gqhle0rr8Q1oG8Xfos7YXRV0g2abqXxUMGuMQXOxFG1B4sOqQYhf18qsiAtcqwpBB+pRXLoSY38
	9FPGePN89/5dNZDZsX1FvjpOmxO8Yl06d+4BNSpRLRlA==
X-Received: by 2002:a05:7022:928:b0:130:ca3d:fa74 with SMTP id a92af1059eb24-13504a545d4mr2603120c88.42.1778879684210;
        Fri, 15 May 2026 14:14:44 -0700 (PDT)
Received: from mimas.lan ([2603:8000:df01:38f7:a6bb:6dff:fecf:e71a])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cbdcf140sm11364153c88.5.2026.05.15.14.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 14:14:43 -0700 (PDT)
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
Subject: [PATCH v16 11/38] tpm/tpm_tis: Close all localities
Date: Fri, 15 May 2026 14:13:43 -0700
Message-ID: <20260515211410.31440-12-ross.philipson@gmail.com>
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

Close all the localities while initializing the TPM driver. The addition
of TCG DRTM support requires this.

Co-developed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
Signed-off-by: Ross Philipson <ross.philipson@gmail.com>
---
 drivers/char/tpm/tpm_tis_core.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index e2a1769081b1..1fbb74a565f4 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -1111,7 +1111,7 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
 	u32 intmask;
 	u32 clkrun_val;
 	u8 rid;
-	int rc, probe;
+	int rc, probe, i;
 	struct tpm_chip *chip;
 
 	chip = tpmm_chip_alloc(dev, &tpm_tis);
@@ -1176,6 +1176,15 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
 		goto out_err;
 	}
 
+	/*
+	 * In order to comply with the TCG DRTM specification, relinquish all
+	 * the localities.
+	 */
+	for (i = 0; i <= TPM_MAX_LOCALITY; i++) {
+		if (check_locality(chip, i))
+			tpm_tis_relinquish_locality(chip, i);
+	}
+
 	/* Take control of the TPM's interrupt hardware and shut it off */
 	rc = tpm_tis_read32(priv, TPM_INT_ENABLE(priv->locality), &intmask);
 	if (rc < 0)
-- 
2.47.3

