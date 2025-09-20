Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEED12D7D41
	for <iommu@lists.linux.dev>; Sat, 20 Sep 2025 20:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758400739; cv=none; b=q6DfJzh6zFubNp+yTV6LnvX2NcVlcsufpFA9dusB7Mdcf2hcEL2EhmNI2J6WYYEks/ICRnnhBbLLgU4owvxtSRXmzMiqdHtAOT0SoxuVqQ/TiSq1HPSr17JLOcngdBUzf1hGz5oqQb7/7qsn4zqCDZSI2E7q0EvMI1WFigtO+10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758400739; c=relaxed/simple;
	bh=FYh0M9S8lqaZUVwPflZkoaMdoFI/RTpU9RBLhPrKLAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EuhHVYri+UN+yO2vAH9lwXSzeTfhOd50hISRkNAvQ0yzesrWVKTCDR2iDohp1iyKygH7Gjuchqf4uCqQTiFL7qQyJfNWlMyrQHJ47itF9FhRvL1xeqUZceygo5xNCFihEsbWawAGDLd+dFGMPACuCRzVsHXIXKHbFYlA+8rlvuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=klvvoeny; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="klvvoeny"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-4248a13fbe9so7503115ab.1
        for <iommu@lists.linux.dev>; Sat, 20 Sep 2025 13:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1758400737; x=1759005537; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vZPFm4Y9icCAth6wrzJMUkgkEfNQH2w/TjaKN8QVYFg=;
        b=klvvoenyPdSsWIdr/lrU4rAZM3QB13S8tGvv9oJHo+S0B54Lx/Fc83gwNkow/VM76l
         OdvYErWZ0LDVqvfIXXUo4g1CPmpryvSBmWrRkF7kLtWhfLQr+4ctYKjm8o3Y+VUftmwX
         1jtbXh2kqc6Sdbjx0nzgXkIGsyU/+aJCfvLVUe9idPavXmWFc97dm85ivL81nE32pEaY
         sL5CyTl8wU5IEvU87cVdXJdoFgt/7nEqxwppxyy+cLSRyzWDBwC0+rLJFeIM7KqgUkVy
         4xSvzNnGqgM6fvDKQunblpCg2w03ZX1dTM3bcW6n+D6WAXn07wpGvuvY64otHKA+UpvL
         vbzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758400737; x=1759005537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vZPFm4Y9icCAth6wrzJMUkgkEfNQH2w/TjaKN8QVYFg=;
        b=m24obWK+5U0FpyvofdQC2ZRAv2TCkStKCiBlxel0gv+UZT/uqq7qkH1YRA/nEUEDan
         mmPUA3lMqi1nBp+ubSOwcjCbITBS0ln2Uc8xUEt/1HonQLI7q+5HWwv03WKnyPOjs/Lu
         CcvhjwWGaGceDPqaYSNHn+w2UECRsIFpLJxoNgQkhqMz7B9qi4IFqKP5P2CPUOgMQ2yo
         MWZs74wUeKR7OovZkcao/z0Ah0YNVVj9xoCXimR0eGKuMpsnWWcdTEoOvMIWVGE6pRpB
         m7rq0IiMWljwYQYoUAVO0ran3Hjg6FUIrhQNDWedZPndfAcRNU3LBCrvoFSMM+QjV9Cf
         ot0w==
X-Gm-Message-State: AOJu0YyMuj4Cbg8lelcP+DZw9XOuGf53cKUtTwnc0bBMuTUbJ3Hh5QOs
	K8Q45byasRdtQGFHjqdQbEkvd6rmSSOXAdQXdjgA0xzwADpRO+S26CKjMY8Bpc68psrA5DU3Mvp
	nzI8o4Z4=
X-Gm-Gg: ASbGncv6cUYWpyc2es90Ncd3czm/gpi6z+luyPIZ3cptfXz8rrypxCQKinhvWTiMe39
	AOJmgQ4MTDdSk+rwV8w8t1om9u2tu9A7pAUu41+OtH9ORWmjJN18x8a6EVlX+buJGsmc0MgePrL
	j5lmnTJC/vjVknCDgtxgvRS1i1WR4Su0SzhA+c43MXZxN+wK7KydI/xswVhKXLBBtGnSfu4e+qM
	wqsT29ntAF/HUUXS91Pgj4gjEBhCcoOOt+7U7677623bJNR9R9/T6YEDLpX7WjMyNILsQUZp4kS
	3KpnzcnSd5rKISAdLbuPgJPOC4jUhaWudNhwAY8MB3NELl8a3+i8rbeKmyZeD+Yh/zvc3jyxauI
	7nN/JGfZ9pZfC3gfuEIZAJ2RQ
X-Google-Smtp-Source: AGHT+IFXBb6vr/8D7CZ5otepQnRcmkVx5TB79A7j3YsaSno67UMLJAS4DCtxM6o0ZN+HnZGFA1J8HQ==
X-Received: by 2002:a05:6e02:17c9:b0:405:5e08:a3e4 with SMTP id e9e14a558f8ab-42481911882mr110200895ab.1.1758400737038;
        Sat, 20 Sep 2025 13:38:57 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-4244afaa351sm39931395ab.29.2025.09.20.13.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Sep 2025 13:38:56 -0700 (PDT)
From: Andrew Jones <ajones@ventanamicro.com>
To: iommu@lists.linux.dev,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: jgg@nvidia.com,
	zong.li@sifive.com,
	tjeznach@rivosinc.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	anup@brainfault.org,
	atish.patra@linux.dev,
	tglx@linutronix.de,
	alex.williamson@redhat.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	alex@ghiti.fr
Subject: [RFC PATCH v2 03/18] iommu/riscv: Use data structure instead of individual values
Date: Sat, 20 Sep 2025 15:38:53 -0500
Message-ID: <20250920203851.2205115-23-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250920203851.2205115-20-ajones@ventanamicro.com>
References: <20250920203851.2205115-20-ajones@ventanamicro.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zong Li <zong.li@sifive.com>

The parameter will be increased when we need to set up more fields
in the device context. Use a data structure to wrap them up.

Signed-off-by: Zong Li <zong.li@sifive.com>
Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
---
 drivers/iommu/riscv/iommu.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index 901d02529a26..a44c67a848fa 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -988,7 +988,7 @@ static void riscv_iommu_iotlb_inval(struct riscv_iommu_domain *domain,
  * interim translation faults.
  */
 static void riscv_iommu_iodir_update(struct riscv_iommu_device *iommu,
-				     struct device *dev, u64 fsc, u64 ta)
+				     struct device *dev, struct riscv_iommu_dc *new_dc)
 {
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct riscv_iommu_dc *dc;
@@ -1022,10 +1022,10 @@ static void riscv_iommu_iodir_update(struct riscv_iommu_device *iommu,
 	for (i = 0; i < fwspec->num_ids; i++) {
 		dc = riscv_iommu_get_dc(iommu, fwspec->ids[i]);
 		tc = READ_ONCE(dc->tc);
-		tc |= ta & RISCV_IOMMU_DC_TC_V;
+		tc |= new_dc->ta & RISCV_IOMMU_DC_TC_V;
 
-		WRITE_ONCE(dc->fsc, fsc);
-		WRITE_ONCE(dc->ta, ta & RISCV_IOMMU_PC_TA_PSCID);
+		WRITE_ONCE(dc->fsc, new_dc->fsc);
+		WRITE_ONCE(dc->ta, new_dc->ta & RISCV_IOMMU_PC_TA_PSCID);
 		/* Update device context, write TC.V as the last step. */
 		dma_wmb();
 		WRITE_ONCE(dc->tc, tc);
@@ -1304,20 +1304,20 @@ static int riscv_iommu_attach_paging_domain(struct iommu_domain *iommu_domain,
 	struct riscv_iommu_domain *domain = iommu_domain_to_riscv(iommu_domain);
 	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
 	struct riscv_iommu_info *info = dev_iommu_priv_get(dev);
-	u64 fsc, ta;
+	struct riscv_iommu_dc dc = {0};
 
 	if (!riscv_iommu_pt_supported(iommu, domain->pgd_mode))
 		return -ENODEV;
 
-	fsc = FIELD_PREP(RISCV_IOMMU_PC_FSC_MODE, domain->pgd_mode) |
-	      FIELD_PREP(RISCV_IOMMU_PC_FSC_PPN, virt_to_pfn(domain->pgd_root));
-	ta = FIELD_PREP(RISCV_IOMMU_PC_TA_PSCID, domain->pscid) |
-	     RISCV_IOMMU_PC_TA_V;
+	dc.fsc = FIELD_PREP(RISCV_IOMMU_PC_FSC_MODE, domain->pgd_mode) |
+		 FIELD_PREP(RISCV_IOMMU_PC_FSC_PPN, virt_to_pfn(domain->pgd_root));
+	dc.ta = FIELD_PREP(RISCV_IOMMU_PC_TA_PSCID, domain->pscid) |
+			   RISCV_IOMMU_PC_TA_V;
 
 	if (riscv_iommu_bond_link(domain, dev))
 		return -ENOMEM;
 
-	riscv_iommu_iodir_update(iommu, dev, fsc, ta);
+	riscv_iommu_iodir_update(iommu, dev, &dc);
 	riscv_iommu_bond_unlink(info->domain, dev);
 	info->domain = domain;
 
@@ -1408,9 +1408,12 @@ static int riscv_iommu_attach_blocking_domain(struct iommu_domain *iommu_domain,
 {
 	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
 	struct riscv_iommu_info *info = dev_iommu_priv_get(dev);
+	struct riscv_iommu_dc dc = {0};
+
+	dc.fsc = RISCV_IOMMU_FSC_BARE;
 
 	/* Make device context invalid, translation requests will fault w/ #258 */
-	riscv_iommu_iodir_update(iommu, dev, RISCV_IOMMU_FSC_BARE, 0);
+	riscv_iommu_iodir_update(iommu, dev, &dc);
 	riscv_iommu_bond_unlink(info->domain, dev);
 	info->domain = NULL;
 
@@ -1429,8 +1432,12 @@ static int riscv_iommu_attach_identity_domain(struct iommu_domain *iommu_domain,
 {
 	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
 	struct riscv_iommu_info *info = dev_iommu_priv_get(dev);
+	struct riscv_iommu_dc dc = {0};
+
+	dc.fsc = RISCV_IOMMU_FSC_BARE;
+	dc.ta = RISCV_IOMMU_PC_TA_V;
 
-	riscv_iommu_iodir_update(iommu, dev, RISCV_IOMMU_FSC_BARE, RISCV_IOMMU_PC_TA_V);
+	riscv_iommu_iodir_update(iommu, dev, &dc);
 	riscv_iommu_bond_unlink(info->domain, dev);
 	info->domain = NULL;
 
-- 
2.49.0

