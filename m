Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1E915E90
	for <iommu@lists.linux.dev>; Fri, 14 Jun 2024 14:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718374939; cv=none; b=u56NJcCFe8rYZf83+rvaKiIJtXR3fSk5et2JqcGpz/kKg40vWjYjDg6VePRUGTzC+MIOJ7VEXZRG7E9yYlPztw6B58swzAzwEIi/xM7wQdgYcIUIL5YIP5xqg7uJL8uSIBj8McKp/DaAaFRJTx0T4qHOm4T7vxEHhE9oTng4PfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718374939; c=relaxed/simple;
	bh=7AgwP/NIXpZI892UfooA/8JyK1Fg8ru9MhfleWRh558=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=ZOQbn9bbJI40NgcbMjGCD6q3Ya2duiC/hIdzwG8uEpkqBEbki7lKgemJWAAMC48h80ri5tzBRtVWFPIyPCLa+2hU3ieVBKAfa5eaA9pDC2QJxfOtR/rqH6JbudrQJd9oByXPhX30zK6vC8suQ+RDBi/S0VryJR7eDC7v5Oqnn8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=JVmgUAAl; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="JVmgUAAl"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1f6fada63a6so18615115ad.3
        for <iommu@lists.linux.dev>; Fri, 14 Jun 2024 07:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1718374937; x=1718979737; darn=lists.linux.dev;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KYeKWdSVxdzca9c5AXktAohba5fPqz4T3QpSza6gBEI=;
        b=JVmgUAAl9qYbV9UBBGJBFZCJ9o5WUVEDZM1rKeVIdaFtJMRrmnkS/FD+XqtTwQa1Mt
         R3Nokszlx722ZHuaPPPooqQdiszfxnQ8lf5uMpGfn+iQzDQ7eLMKZ4sunA+RvXzNe4iA
         ZhmvUUOzU86cc4bx0aec+QfKk041uV6p25Q9DpjPK6ZayD4xyhVNufAF3zrou2rHwfCP
         A5XK+ZGOoqaBwyADZdYLJZbJRBVn7bKyZwX415CQiO42G0U7qBvFgG541ppu7bLx+5LI
         OkMP8JLSa374Oow63CCVRa2ZnG5I2zjP8IrmQLpm/D1LH4dH0YeVr/swloMnwysd6bQ4
         Xn1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718374937; x=1718979737;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KYeKWdSVxdzca9c5AXktAohba5fPqz4T3QpSza6gBEI=;
        b=I+AcatizSVahGBEz5WRYQBuq59AyVtR+jyGSSU8ieuZnVMDcs1IAxjwWs8ckg17MXB
         b0Vjgd6MvLs/hXf3F42+o9XnVyEOlLOwjS4fkgHkG1nd2kk9FrijimDzqyJX7fUBUrWr
         ixffelfBZhXMU0lJ7CPlduamufKDVh0VmEidkITtW0M1QFx32pfsD2oAymd+pmnqM+bd
         crvyxMEzXr9KoZAhLkmINL3CiQh7hdWcQF4jLk/1teoGS5bWX0i93uIcIHRF1euHHudW
         vkRsgxsBNIYvY0ZuF/6la+uIaAldCX+1lRSXo1pcChBb5t3NYhsnLvbATeBlfmUQ7ZYE
         ZT8w==
X-Forwarded-Encrypted: i=1; AJvYcCUx2JjKsXWHRgHoyeJViC1eR0epODSJ9jWFoaeFV8NfWogZ82AXbQjrnrgyuqV6hbOkSYmhfhsB84Ks8V9PxvLlFiK01V0=
X-Gm-Message-State: AOJu0YxBf+3ceXunhxDs6NI+Lk/8TC32lp/uls+7wlxBSjHgqFK6NQ+0
	VuVLFSjuh+vMvR2g+lFmzAXqFBNdOgzPUafFNAy76x1LSYyeIQeovky4NrzBTRl3Gy0g1SyNhA7
	ShJ4=
X-Google-Smtp-Source: AGHT+IEaapuErqClzYkwdWIAoziKliaNOF4tmsWVaA2CtvzOJToxjwlNEcROXRtWO3Y8fdwM3JdA+g==
X-Received: by 2002:a17:903:1250:b0:1f7:2050:9a76 with SMTP id d9443c01a7336-1f8625c0d68mr33773445ad.8.1718374937555;
        Fri, 14 Jun 2024 07:22:17 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e559d9sm32522005ad.35.2024.06.14.07.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 07:22:17 -0700 (PDT)
From: Zong Li <zong.li@sifive.com>
To: joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	tjeznach@rivosinc.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	jgg@ziepe.ca,
	kevin.tian@intel.com,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org
Cc: Zong Li <zong.li@sifive.com>
Subject: [RFC PATCH v2 03/10] iommu/riscv: use data structure instead of individual values
Date: Fri, 14 Jun 2024 22:21:49 +0800
Message-Id: <20240614142156.29420-4-zong.li@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240614142156.29420-1-zong.li@sifive.com>
References: <20240614142156.29420-1-zong.li@sifive.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The parameter will be increased when we need to set up more
bit fields in the device context. Use a data structure to
wrap them up.

Signed-off-by: Zong Li <zong.li@sifive.com>
---
 drivers/iommu/riscv/iommu.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index 1716b2251f38..9aeb4b20c145 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -1045,7 +1045,7 @@ static void riscv_iommu_iotlb_inval(struct riscv_iommu_domain *domain,
  * interim translation faults.
  */
 static void riscv_iommu_iodir_update(struct riscv_iommu_device *iommu,
-				     struct device *dev, u64 fsc, u64 ta)
+				     struct device *dev, struct riscv_iommu_dc *new_dc)
 {
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct riscv_iommu_dc *dc;
@@ -1079,10 +1079,10 @@ static void riscv_iommu_iodir_update(struct riscv_iommu_device *iommu,
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
@@ -1369,20 +1369,20 @@ static int riscv_iommu_attach_paging_domain(struct iommu_domain *iommu_domain,
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
 
@@ -1484,9 +1484,12 @@ static int riscv_iommu_attach_blocking_domain(struct iommu_domain *iommu_domain,
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
 
@@ -1505,8 +1508,12 @@ static int riscv_iommu_attach_identity_domain(struct iommu_domain *iommu_domain,
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
2.17.1

