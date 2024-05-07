Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F145D15FCF1
	for <iommu@lists.linux.dev>; Tue,  7 May 2024 14:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715091976; cv=none; b=u+R9KvOnOaE8B6JcXTc2V1aeIXKgsoSEg31cOaCeIuRXVVYSI5Pl7qM6oytGwKBDtVBdtutgB5Y3KtX/3RhKILhYzjk65O+pxyYL3i3umSAEIUCpZ0LNf2JfXkGEy8F3fzs1RHCa3qOEbstaT65igqkxbn2OzezEddu8hRjvWFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715091976; c=relaxed/simple;
	bh=dle2cRslL/eml8rQHKVoHJTE4hJnwycWESm76X81LvU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=l3FAAKMQo43W3CznA8aECQByn3GFKed+ouJbRdaCpFughBkTTk00k/aOsQJqBbOJB6/VqdTbtMPIMrV6ijmjcZd2PHLB1Rlo9/wDRqjUDaRZotxWeC4duGrFQVIxFKRKwfB14lBQcZWckVu8MQwawrrHLMp6X/9qEfeqNKBbS/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=ZUIWJfcH; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ZUIWJfcH"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6f44a2d1e3dso2701167b3a.3
        for <iommu@lists.linux.dev>; Tue, 07 May 2024 07:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1715091974; x=1715696774; darn=lists.linux.dev;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Q5Yiv5A35fqkZLewYyNasBxNRcaYrtDBJ52Nob0v8A4=;
        b=ZUIWJfcHgaW9O6Lp6Mlyg+NGXin0sBCJU3cirvYv71rP1ZKp5lK3uMqUdcOhjJhBE6
         bTdH5kI4e5ZFPFhCAlWjOuxeCluZxzxKTYgf288mx2ZRMiZguxNG8r0o2Pmv7BpFjSOT
         xFaN4rkVQIdwxMRhe6CX4vRPUDT+tv9D1fqJFmivdDZLw//JQmb4lM4X82B/K5OG4jW2
         BMIc/HZfOA2BWCGGmN88wKeSFfj4ffIHdiQpVpNx/cwpXVjmu1OS0r7LDpuhWAXQ8c9T
         S1yCkV9tLOFuDOYnIh1iilWYEEu7MPe7Z14uHbb9jQ4+oyhBg/QVatPpagi7mZlZaazO
         /QJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715091974; x=1715696774;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q5Yiv5A35fqkZLewYyNasBxNRcaYrtDBJ52Nob0v8A4=;
        b=hUPAbxKn0fxxt/30iXPO1zwD/CkpKUUg6ekNB9f6B8Ky8g2g2eCHclU/ptb2t+czJH
         YMDnd9UC07df+pO3azoCrVqsRv4wDWEwk0pSJmhzxBi8EI86fbDRh++i/yMOqVrACFTq
         t2W3QcGu6hZtiuyS0lpPi1CoSVQeWx6Y85vfsUqu/3az1TgRHhwO2lsGAA1QiHiFMGkg
         c88wbiNvq9/oI39KiVU6SF2GP9pgUIqReNaLnlOu+yJr0WfC03KhcfosQ0mSLdVKbnYF
         NIdiYSiVGBn0EcgixSffObOEYE1kySfz7fcrLvI+v10doK99Z5aFpgLGZ4GMQI2m7Ngb
         zgbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFAPqmFK5NHxRnbkYQ6R/DmDFT4K8uFbVLNwFkHw0KsSWlQqtn7MvgRNlzeRn0O+IHCPwKhmXwShBdAUKAruFJJjFbPHw=
X-Gm-Message-State: AOJu0YwUljcZJL8lxpK0yXlPNqeVsLT04dxTJ+9GCXF6KGI4mAosA9XK
	qjoGlvLBXGZocd2ClGPe9cgZmd5KTC9CHA7jpi1nODJ5rjIHpVxp8TGu4Mq3Wo8=
X-Google-Smtp-Source: AGHT+IHdg7+7I4bSI4CruHY7MHG+tPkBhVw4YY0PCUXdy/YjCBHjgssv5B+jlzNMBIZ1jyV/U90aVQ==
X-Received: by 2002:a05:6a00:4f82:b0:6ed:21b2:cb17 with SMTP id ld2-20020a056a004f8200b006ed21b2cb17mr14575610pfb.4.1715091972855;
        Tue, 07 May 2024 07:26:12 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id i22-20020aa79096000000b006f44bcbe7e3sm7687554pfa.201.2024.05.07.07.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 07:26:12 -0700 (PDT)
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
Subject: [PATCH RFC RESEND 3/6] iommu/riscv: support GSCID
Date: Tue,  7 May 2024 22:25:57 +0800
Message-Id: <20240507142600.23844-4-zong.li@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240507142600.23844-1-zong.li@sifive.com>
References: <20240507142600.23844-1-zong.li@sifive.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

This patch adds a global ID Allocator for GSCID and a wrap for setting
up GSCID in IOTLB invalidation command.

Set up iohgatp to enable second stage table and flus stage-2 table if
the GSCID is allocated.

The GSCID of domain should be freed when release domain. GSCID will be
allocated for parent domain in nested IOMMU process.

Signed-off-by: Zong Li <zong.li@sifive.com>
---
 drivers/iommu/riscv/iommu-bits.h |  7 +++
 drivers/iommu/riscv/iommu.c      | 81 ++++++++++++++++++++++----------
 2 files changed, 62 insertions(+), 26 deletions(-)

diff --git a/drivers/iommu/riscv/iommu-bits.h b/drivers/iommu/riscv/iommu-bits.h
index 11351cf6c710..62b1ee387357 100644
--- a/drivers/iommu/riscv/iommu-bits.h
+++ b/drivers/iommu/riscv/iommu-bits.h
@@ -728,6 +728,13 @@ static inline void riscv_iommu_cmd_inval_vma(struct riscv_iommu_command *cmd)
 	cmd->dword1 = 0;
 }
 
+static inline void riscv_iommu_cmd_inval_gvma(struct riscv_iommu_command *cmd)
+{
+	cmd->dword0 = FIELD_PREP(RISCV_IOMMU_CMD_OPCODE, RISCV_IOMMU_CMD_IOTINVAL_OPCODE) |
+		      FIELD_PREP(RISCV_IOMMU_CMD_FUNC, RISCV_IOMMU_CMD_IOTINVAL_FUNC_GVMA);
+	cmd->dword1 = 0;
+}
+
 static inline void riscv_iommu_cmd_inval_set_addr(struct riscv_iommu_command *cmd,
 						  u64 addr)
 {
diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index e0bf74a9c64d..d38e09b138b6 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -45,6 +45,10 @@
 static DEFINE_IDA(riscv_iommu_pscids);
 #define RISCV_IOMMU_MAX_PSCID		(BIT(20) - 1)
 
+/* IOMMU GSCID allocation namespace. */
+static DEFINE_IDA(riscv_iommu_gscids);
+#define RISCV_IOMMU_MAX_GSCID		(BIT(16) - 1)
+
 /* Device resource-managed allocations */
 struct riscv_iommu_devres {
 	void *addr;
@@ -826,6 +830,7 @@ struct riscv_iommu_domain {
 	struct list_head bonds;
 	spinlock_t lock;		/* protect bonds list updates. */
 	int pscid;
+	int gscid;
 	int numa_node;
 	int amo_enabled:1;
 	unsigned int pgd_mode;
@@ -919,29 +924,43 @@ static void riscv_iommu_iotlb_inval(struct riscv_iommu_domain *domain,
 	rcu_read_lock();
 
 	prev = NULL;
-	list_for_each_entry_rcu(bond, &domain->bonds, list) {
-		iommu = dev_to_iommu(bond->dev);
 
-		/*
-		 * IOTLB invalidation request can be safely omitted if already sent
-		 * to the IOMMU for the same PSCID, and with domain->bonds list
-		 * arranged based on the device's IOMMU, it's sufficient to check
-		 * last device the invalidation was sent to.
-		 */
-		if (iommu == prev)
-			continue;
-
-		riscv_iommu_cmd_inval_vma(&cmd);
-		riscv_iommu_cmd_inval_set_pscid(&cmd, domain->pscid);
-		if (len && len >= RISCV_IOMMU_IOTLB_INVAL_LIMIT) {
-			for (iova = start; iova < end; iova += PAGE_SIZE) {
-				riscv_iommu_cmd_inval_set_addr(&cmd, iova);
+	/*
+	 * Host domain needs to flush entries in stage-2 for MSI mapping.
+	 * However, device is bound to s1 domain instead of s2 domain.
+	 * We need to flush mapping without looping devices of s2 domain
+	 */
+	if (domain->gscid) {
+		riscv_iommu_cmd_inval_gvma(&cmd);
+		riscv_iommu_cmd_inval_set_gscid(&cmd, domain->gscid);
+		riscv_iommu_cmd_send(iommu, &cmd, 0);
+		riscv_iommu_cmd_iofence(&cmd);
+		riscv_iommu_cmd_send(iommu, &cmd, RISCV_IOMMU_QUEUE_TIMEOUT);
+	} else {
+		list_for_each_entry_rcu(bond, &domain->bonds, list) {
+			iommu = dev_to_iommu(bond->dev);
+
+			/*
+			 * IOTLB invalidation request can be safely omitted if already sent
+			 * to the IOMMU for the same PSCID, and with domain->bonds list
+			 * arranged based on the device's IOMMU, it's sufficient to check
+			 * last device the invalidation was sent to.
+			 */
+			if (iommu == prev)
+				continue;
+
+			riscv_iommu_cmd_inval_vma(&cmd);
+			riscv_iommu_cmd_inval_set_pscid(&cmd, domain->pscid);
+			if (len && len >= RISCV_IOMMU_IOTLB_INVAL_LIMIT) {
+				for (iova = start; iova < end; iova += PAGE_SIZE) {
+					riscv_iommu_cmd_inval_set_addr(&cmd, iova);
+					riscv_iommu_cmd_send(iommu, &cmd, 0);
+				}
+			} else {
 				riscv_iommu_cmd_send(iommu, &cmd, 0);
 			}
-		} else {
-			riscv_iommu_cmd_send(iommu, &cmd, 0);
+			prev = iommu;
 		}
-		prev = iommu;
 	}
 
 	prev = NULL;
@@ -972,7 +991,7 @@ static void riscv_iommu_iotlb_inval(struct riscv_iommu_domain *domain,
  * interim translation faults.
  */
 static void riscv_iommu_iodir_update(struct riscv_iommu_device *iommu,
-				     struct device *dev, u64 fsc, u64 ta)
+				     struct device *dev, u64 fsc, u64 ta, u64 iohgatp)
 {
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct riscv_iommu_dc *dc;
@@ -1012,6 +1031,7 @@ static void riscv_iommu_iodir_update(struct riscv_iommu_device *iommu,
 		/* Update device context, write TC.V as the last step. */
 		WRITE_ONCE(dc->fsc, fsc);
 		WRITE_ONCE(dc->ta, ta & RISCV_IOMMU_PC_TA_PSCID);
+		WRITE_ONCE(dc->iohgatp, iohgatp);
 		WRITE_ONCE(dc->tc, tc);
 	}
 }
@@ -1271,6 +1291,9 @@ static void riscv_iommu_free_paging_domain(struct iommu_domain *iommu_domain)
 	if ((int)domain->pscid > 0)
 		ida_free(&riscv_iommu_pscids, domain->pscid);
 
+	if ((int)domain->gscid > 0)
+		ida_free(&riscv_iommu_gscids, domain->gscid);
+
 	riscv_iommu_pte_free(domain, _io_pte_entry(pfn, _PAGE_TABLE), NULL);
 	kfree(domain);
 }
@@ -1296,7 +1319,7 @@ static int riscv_iommu_attach_paging_domain(struct iommu_domain *iommu_domain,
 	struct riscv_iommu_domain *domain = iommu_domain_to_riscv(iommu_domain);
 	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
 	struct riscv_iommu_info *info = dev_iommu_priv_get(dev);
-	u64 fsc, ta;
+	u64 fsc = 0, iohgatp = 0, ta;
 
 	if (!riscv_iommu_pt_supported(iommu, domain->pgd_mode))
 		return -ENODEV;
@@ -1314,12 +1337,18 @@ static int riscv_iommu_attach_paging_domain(struct iommu_domain *iommu_domain,
 	 */
 	riscv_iommu_iotlb_inval(domain, 0, ULONG_MAX);
 
-	fsc = FIELD_PREP(RISCV_IOMMU_PC_FSC_MODE, domain->pgd_mode) |
-	      FIELD_PREP(RISCV_IOMMU_PC_FSC_PPN, virt_to_pfn(domain->pgd_root));
+	if (domain->gscid)
+		iohgatp = FIELD_PREP(RISCV_IOMMU_DC_IOHGATP_MODE, domain->pgd_mode) |
+			  FIELD_PREP(RISCV_IOMMU_DC_IOHGATP_GSCID, domain->gscid) |
+			  FIELD_PREP(RISCV_IOMMU_DC_IOHGATP_PPN, virt_to_pfn(domain->pgd_root));
+	else
+		fsc = FIELD_PREP(RISCV_IOMMU_PC_FSC_MODE, domain->pgd_mode) |
+		      FIELD_PREP(RISCV_IOMMU_PC_FSC_PPN, virt_to_pfn(domain->pgd_root));
+
 	ta = FIELD_PREP(RISCV_IOMMU_PC_TA_PSCID, domain->pscid) |
 	     RISCV_IOMMU_PC_TA_V;
 
-	riscv_iommu_iodir_update(iommu, dev, fsc, ta);
+	riscv_iommu_iodir_update(iommu, dev, fsc, ta, iohgatp);
 	riscv_iommu_bond_unlink(info->domain, dev);
 	info->domain = domain;
 
@@ -1422,7 +1451,7 @@ static int riscv_iommu_attach_blocking_domain(struct iommu_domain *iommu_domain,
 	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
 	struct riscv_iommu_info *info = dev_iommu_priv_get(dev);
 
-	riscv_iommu_iodir_update(iommu, dev, RISCV_IOMMU_FSC_BARE, 0);
+	riscv_iommu_iodir_update(iommu, dev, RISCV_IOMMU_FSC_BARE, 0, 0);
 	riscv_iommu_bond_unlink(info->domain, dev);
 	info->domain = NULL;
 
@@ -1442,7 +1471,7 @@ static int riscv_iommu_attach_identity_domain(struct iommu_domain *iommu_domain,
 	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
 	struct riscv_iommu_info *info = dev_iommu_priv_get(dev);
 
-	riscv_iommu_iodir_update(iommu, dev, RISCV_IOMMU_FSC_BARE, RISCV_IOMMU_PC_TA_V);
+	riscv_iommu_iodir_update(iommu, dev, RISCV_IOMMU_FSC_BARE, RISCV_IOMMU_PC_TA_V, 0);
 	riscv_iommu_bond_unlink(info->domain, dev);
 	info->domain = NULL;
 
-- 
2.17.1

