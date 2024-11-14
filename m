Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D609B18C343
	for <iommu@lists.linux.dev>; Thu, 14 Nov 2024 16:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731601137; cv=none; b=YHt+NJNdO9CrmTuos5L9s4MIPthRiNJ2qctlilloVKvrJWocgLWCi5IGXpBIrkSIrIT4j8ubJm6M+/lGktUjZIY9uQ6Ra1TcCBtiirZncPlkFhUS2iUcL1o4irHUjjiLyoFEK5VTyyxCTFBTuaLFa2YIUzo8NLd3EWXU6RsBj4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731601137; c=relaxed/simple;
	bh=Eb4pr4WluxpATHyk/B5wEDuQM3N608Zzf1YYtlCp/dw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WQwkYnjmy+KfbgSxZKj8ewDOjnMtu0v6Nx8S2yxmi6nDQ8boCUZIDYgO01B6xp0BYj33lSt4MoECfhdgnc9ujQSBvofvzbPx0NRLKGmqanzaQhjD6soxVQFw6fiSUMkXCpGGpWApBLL+uoRjtE+VIKk+LbiX1GHw9fn8NsEWG4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=iyN72h4h; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="iyN72h4h"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-53d9ff8ef3aso854954e87.1
        for <iommu@lists.linux.dev>; Thu, 14 Nov 2024 08:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1731601134; x=1732205934; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ro7v641M+HDwWifuZZcr9Q07sHhkgURxU5TLhKMU2Mo=;
        b=iyN72h4hg3hkZcv7FcqDqtEFDSyerOo/gLfaSsEIotHq6/Zo01YDuy48ahRr/meMqY
         M8YzzYbaXQDgDym7cr+974bhDMAHjXPmsIO7MwiNfYC/av/XrC64l/WtJee40aHr0eG7
         fKHBghNNkv28WpegtDjWvBqfBedTtYUQugafUThHz3EOHWdZKHVeAFuo17rdXR9D3is2
         rhkDVBkU4HAS/aJH32n1uJNrqLk/RKbsZ27oqRKbsjwFaJENyYyxUuA/W2U6fbIU5k6x
         KA+SnhoX0n7N5HCuq4vSX30NrqAVCUPpE/VtTRkvun/zo6sU2AlUH9lQ84IuGijOfo7D
         3d+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731601134; x=1732205934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ro7v641M+HDwWifuZZcr9Q07sHhkgURxU5TLhKMU2Mo=;
        b=dx07J4NQnnYteKO12r2TB2HGx1xJvfrM/e2e6Iu4DLb4T9zpYWXQ9SMxxDsRaXAt7f
         rDhNT1SllJ3zDZHFuCC8OJAHAuBeg0cJWAcvXFDLh7i/d5Yxn2AQ/D3X1wFsbGHMQ0I4
         6XwcWcGC93+Sh/n856Y8qoodWX+21hiZrItAIccJ5b4wBIoYTu1Abq7yjyOV9LomoMdV
         OrP0X6Q3LJLhycaTSpU4Qw2uJzeSpHWGTRIHyaJxsXQZ8bQhNgcwSVru7W7yoOQjBlEX
         valHk5bLZoxzaOI10IMDh9QIkAtH3kP1DU7LhEoEliMXW0gd4hyR5bfUo11Ra8QyssPX
         Wu1A==
X-Gm-Message-State: AOJu0YzjAV20pS51aWZEqh1ICuhBmsatBjnEWvcQdysl78p13PvlFY24
	2nMVDRQE70keSZMLR0Mv3GamU2oVfsX1VC1XLi0HZkkPAamkK3RTuvfSqTQCvYPLUfG07exJp6s
	+l8k=
X-Google-Smtp-Source: AGHT+IErvh7GZ5g5xv9y/mHNwbC72YxK/U2el7s2R5QBHLBxBaMXMwoD7jtczGtgvCVqx0SU+SjOAw==
X-Received: by 2002:a05:6512:baa:b0:53d:a34d:9faa with SMTP id 2adb3069b0e04-53da34da11emr2749757e87.45.1731601133876;
        Thu, 14 Nov 2024 08:18:53 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da265e16sm28762605e9.12.2024.11.14.08.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 08:18:53 -0800 (PST)
From: Andrew Jones <ajones@ventanamicro.com>
To: iommu@lists.linux.dev,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: tjeznach@rivosinc.com,
	zong.li@sifive.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	anup@brainfault.org,
	atishp@atishpatra.org,
	tglx@linutronix.de,
	alex.williamson@redhat.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu
Subject: [RFC PATCH 05/15] iommu/riscv: use data structure instead of individual values
Date: Thu, 14 Nov 2024 17:18:50 +0100
Message-ID: <20241114161845.502027-22-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241114161845.502027-17-ajones@ventanamicro.com>
References: <20241114161845.502027-17-ajones@ventanamicro.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zong Li <zong.li@sifive.com>

The parameter will be increased when we need to set up more
bit fields in the device context. Use a data structure to
wrap them up.

Signed-off-by: Zong Li <zong.li@sifive.com>
Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
---
 drivers/iommu/riscv/iommu.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index 3fe4ceba8dd3..9d7945dc3c24 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -1001,7 +1001,7 @@ static void riscv_iommu_iotlb_inval(struct riscv_iommu_domain *domain,
  * interim translation faults.
  */
 static void riscv_iommu_iodir_update(struct riscv_iommu_device *iommu,
-				     struct device *dev, u64 fsc, u64 ta)
+				     struct device *dev, struct riscv_iommu_dc *new_dc)
 {
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct riscv_iommu_dc *dc;
@@ -1035,10 +1035,10 @@ static void riscv_iommu_iodir_update(struct riscv_iommu_device *iommu,
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
@@ -1315,20 +1315,20 @@ static int riscv_iommu_attach_paging_domain(struct iommu_domain *iommu_domain,
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
 
@@ -1419,9 +1419,12 @@ static int riscv_iommu_attach_blocking_domain(struct iommu_domain *iommu_domain,
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
 
@@ -1440,8 +1443,12 @@ static int riscv_iommu_attach_identity_domain(struct iommu_domain *iommu_domain,
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
2.47.0

