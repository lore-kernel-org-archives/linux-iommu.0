Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.132
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793435434;
	b=3V9P1DZyQEcsofKYHHPtKDCPfITiOcp/y3O7pQgDi+25oIxVC2FL99bgQN2g7eyQGgT7
	 XROZpiDLy1fpx8XtKmJr6KNOmdIaHk9gMO6x2njFme2PqVGcv6R51vVsFyIZ3jBC1RJNE
	 DWu7z4pAeqoHt1MvFkhJWBNxCH30nmEZDgbBS1EJxkHrrpySyOeVZZoBypd4Qj5Rm/qG7
	 85wxW+LPhP/h9wdcNVdfPw2TSHRBbjOPlznt+Jbp1xMcbkLXZ8O4wxoyjuPh3THOFADpE
	 OSX3Na3ZFptjOH5MvQocSKW3K34j/G7HMXzul5svsDZPizevLG+LEIu9Cs8SL+Yoh0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793435434;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=2u8/u9G5SH4+6OdVjzAF+I+EdRFtvLlxHvJVumgznCk=;
	b=Sv1Eby+xtNHewSWeW7wLVW6iaAqSh/Vle8zchJkOQJAmptRQENL5BGJ7UygL7BXYLVbo
	 RdSqSw3mLkrRn7v4/wY6+g7LlL4NXQgt7hXEyW4g2go/Cmlr4WJMGurFS31VK45FbbtqG
	 E0Swry2dvz07a3JR7gKa8R/1PFmlHyDuWOYiwCL+G7hhR4z+Nq2QNUYqCAEKf4yupgQaY
	 8kuxUR+A/IhpVBnNgMmKs8SMWhRU591TIfX0SmiXbmZsZninoKm1xpueW792g9rXRdy/n
	 j31ta28H6Ce7u6cP9oywABVz5f4KmrCBapbZd9FBX+XiddzBzTgJV1KzG2iWyUwzmbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=m1eJ0EiD;
	arc=none smtp.remote-ip=115.124.30.132
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32EA5606A338
	for <iommu@lists.linux.dev>; Sat, 31 Oct 2026 08:30:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32EA5606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=m1eJ0EiD
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793435431; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=2u8/u9G5SH4+6OdVjzAF+I+EdRFtvLlxHvJVumgznCk=;
	b=m1eJ0EiDbwC7FY+WFD0MrtmbabTV26fXS22j8PHfzfPT6UOrCTVxovu1vSZ9bavEf+2//HtsgZoBHW+Mgu5YNJUTSiOs1cZPoEd+qtr2DumPPVgTKdLdt2KM1wxJvZttAmLZDodbiiEBiUAWfgP/S255u1rMacUdgQgqlkAXtiM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=29;SR=0;TI=SMTPD_---0XDo-2lV_1793435427;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0XDo-2lV_1793435427 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 31 Oct 2026 16:30:28 +0800
From: fangyu.yu@linux.alibaba.com
To: tomasz.jeznach@linux.dev,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	baolu.lu@linux.intel.com,
	jroedel@suse.de,
	zong.li@sifive.com,
	andrew.jones@linux.dev,
	anup@brainfault.org,
	jgg@nvidia.com,
	jgg@ziepe.ca,
	kevin.tian@intel.com,
	atish.patra@linux.dev,
	skhawaja@google.com,
	vasant.hegde@amd.com,
	joerg.roedel@amd.com,
	tanchi25@mails.ucas.ac.cn,
	gong.shuai@sanechips.com.cn
Cc: fangyu.yu@linux.alibaba.com,
	guoren@kernel.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	kvm-riscv@lists.infradead.org,
	Nutty Liu <nutty.liu@hotmail.com>
Subject: [PATCH v6 05/10] iommu/riscv: support GSCID and GVMA invalidation command
Date: Sat, 31 Oct 2026 16:30:09 +0800
Message-Id: <20261031083014.15040-6-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20261031083014.15040-1-fangyu.yu@linux.alibaba.com>
References: <20261031083014.15040-1-fangyu.yu@linux.alibaba.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zong Li <zong.li@sifive.com>

This patch adds a ID Allocator for GSCID and a wrap for setting up
GSCID in IOTLB invalidation command.

Set up iohgatp to enable second stage table and flush stage-2 table if
the GSCID is set.

The GSCID of domain should be freed when release domain. GSCID will be
allocated for parent domain in nested IOMMU process.

Signed-off-by: Zong Li <zong.li@sifive.com>
Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
---
 drivers/iommu/riscv/iommu-bits.h |  7 ++++
 drivers/iommu/riscv/iommu.c      | 62 ++++++++++++++++++++++++++------
 2 files changed, 58 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/riscv/iommu-bits.h b/drivers/iommu/riscv/iommu-bits.h
index f2ef9bd3cde9..65d1f2250011 100644
--- a/drivers/iommu/riscv/iommu-bits.h
+++ b/drivers/iommu/riscv/iommu-bits.h
@@ -720,6 +720,13 @@ static inline void riscv_iommu_cmd_inval_vma(struct riscv_iommu_command *cmd)
 	cmd->dword1 = 0;
 }
 
+static inline void riscv_iommu_cmd_inval_gvma(struct riscv_iommu_command *cmd)
+{
+	cmd->dword0 = FIELD_PREP(RISCV_IOMMU_CMD0_OPCODE, RISCV_IOMMU_CMD_IOTINVAL_OPCODE) |
+		      FIELD_PREP(RISCV_IOMMU_CMD0_FUNC, RISCV_IOMMU_CMD_IOTINVAL_FUNC_GVMA);
+	cmd->dword1 = 0;
+}
+
 static inline void riscv_iommu_cmd_inval_set_addr(struct riscv_iommu_command *cmd,
 						  u64 addr)
 {
diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index 918fce4aa8c4..162752bb698e 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -49,6 +49,10 @@
 static DEFINE_IDA(riscv_iommu_pscids);
 #define RISCV_IOMMU_MAX_PSCID		(BIT(20) - 1)
 
+/* IOMMU GSCID allocation namespace. */
+static DEFINE_IDA(riscv_iommu_gscids);
+#define RISCV_IOMMU_MAX_GSCID		(BIT(16) - 1)
+
 /* Device resource-managed allocations */
 struct riscv_iommu_devres {
 	void *addr;
@@ -842,6 +846,7 @@ struct riscv_iommu_domain {
 	struct list_head bonds;
 	spinlock_t lock;		/* protect bonds list updates. */
 	int pscid;
+	int gscid;
 };
 PT_IOMMU_CHECK_DOMAIN(struct riscv_iommu_domain, riscvpt.iommu, domain);
 
@@ -1004,7 +1009,7 @@ static void riscv_iommu_tlbi_calc(struct riscv_iommu_tlbi *tlbi,
 }
 
 static void riscv_iommu_iotlb_inval_iommu(struct riscv_iommu_device *iommu,
-					  int pscid,
+					  int pscid, int gscid,
 					  struct riscv_iommu_tlbi *tlbi)
 {
 	bool use_nl = tlbi->non_leaf &&
@@ -1012,8 +1017,13 @@ static void riscv_iommu_iotlb_inval_iommu(struct riscv_iommu_device *iommu,
 	struct riscv_iommu_command cmd;
 	unsigned int i;
 
-	riscv_iommu_cmd_inval_vma(&cmd);
-	riscv_iommu_cmd_inval_set_pscid(&cmd, pscid);
+	if (gscid) {
+		riscv_iommu_cmd_inval_gvma(&cmd);
+		riscv_iommu_cmd_inval_set_gscid(&cmd, gscid);
+	} else {
+		riscv_iommu_cmd_inval_vma(&cmd);
+		riscv_iommu_cmd_inval_set_pscid(&cmd, pscid);
+	}
 
 	/*
 	 * If non-leaf entries were changed and the IOMMU doesn't
@@ -1097,7 +1107,7 @@ static void riscv_iommu_iotlb_inval(struct riscv_iommu_domain *domain,
 		if (iommu == prev)
 			continue;
 
-		riscv_iommu_iotlb_inval_iommu(iommu, domain->pscid, &tlbi);
+		riscv_iommu_iotlb_inval_iommu(iommu, domain->pscid, domain->gscid, &tlbi);
 		prev = iommu;
 	}
 
@@ -1231,6 +1241,7 @@ static void riscv_iommu_iodir_update(struct riscv_iommu_device *iommu,
 
 		WRITE_ONCE(dc->fsc, new_dc->fsc);
 		WRITE_ONCE(dc->ta, new_dc->ta & RISCV_IOMMU_PC_TA_PSCID);
+		WRITE_ONCE(dc->iohgatp, new_dc->iohgatp);
 		/* Update device context, write TC.V as the last step. */
 		dma_wmb();
 		WRITE_ONCE(dc->tc, tc);
@@ -1281,16 +1292,19 @@ static void riscv_iommu_free_paging_domain(struct iommu_domain *iommu_domain)
 
 	WARN_ON(!list_empty(&domain->bonds));
 
-	if ((int)domain->pscid > 0)
+	if (domain->pscid > 0)
 		ida_free(&riscv_iommu_pscids, domain->pscid);
+	if (domain->gscid > 0)
+		ida_free(&riscv_iommu_gscids, domain->gscid);
 
 	pt_iommu_deinit(&domain->riscvpt.iommu);
 	kfree(domain);
 }
 
-static bool riscv_iommu_pt_supported(struct riscv_iommu_device *iommu, int pgd_mode)
+static bool riscv_iommu_fsc_supported(struct riscv_iommu_device *iommu,
+				      int mode)
 {
-	switch (pgd_mode) {
+	switch (mode) {
 	case RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV39:
 		return iommu->caps & RISCV_IOMMU_CAPABILITIES_SV39;
 
@@ -1303,6 +1317,22 @@ static bool riscv_iommu_pt_supported(struct riscv_iommu_device *iommu, int pgd_m
 	return false;
 }
 
+static bool riscv_iommu_iohgatp_supported(struct riscv_iommu_device *iommu,
+					  int mode)
+{
+	switch (mode) {
+	case RISCV_IOMMU_DC_IOHGATP_MODE_SV39X4:
+		return iommu->caps & RISCV_IOMMU_CAPABILITIES_SV39X4;
+
+	case RISCV_IOMMU_DC_IOHGATP_MODE_SV48X4:
+		return iommu->caps & RISCV_IOMMU_CAPABILITIES_SV48X4;
+
+	case RISCV_IOMMU_DC_IOHGATP_MODE_SV57X4:
+		return iommu->caps & RISCV_IOMMU_CAPABILITIES_SV57X4;
+	}
+	return false;
+}
+
 static int riscv_iommu_attach_paging_domain(struct iommu_domain *iommu_domain,
 					    struct device *dev,
 					    struct iommu_domain *old)
@@ -1315,11 +1345,21 @@ static int riscv_iommu_attach_paging_domain(struct iommu_domain *iommu_domain,
 
 	pt_iommu_riscv_64_hw_info(&domain->riscvpt, &pt_info);
 
-	if (!riscv_iommu_pt_supported(iommu, pt_info.fsc_iosatp_mode))
-		return -ENODEV;
+	if (domain->gscid) {
+		if (!riscv_iommu_iohgatp_supported(iommu, pt_info.iohgatp_mode))
+			return -ENODEV;
+
+		dc.iohgatp =
+			FIELD_PREP(RISCV_IOMMU_DC_IOHGATP_MODE, pt_info.iohgatp_mode) |
+			FIELD_PREP(RISCV_IOMMU_DC_IOHGATP_GSCID, domain->gscid) |
+			FIELD_PREP(RISCV_IOMMU_DC_IOHGATP_PPN, pt_info.ppn);
+	} else {
+		if (!riscv_iommu_fsc_supported(iommu, pt_info.fsc_iosatp_mode))
+			return -ENODEV;
 
-	dc.fsc = FIELD_PREP(RISCV_IOMMU_PC_FSC_MODE, pt_info.fsc_iosatp_mode) |
-	      FIELD_PREP(RISCV_IOMMU_PC_FSC_PPN, pt_info.ppn);
+		dc.fsc = FIELD_PREP(RISCV_IOMMU_PC_FSC_MODE, pt_info.fsc_iosatp_mode) |
+			 FIELD_PREP(RISCV_IOMMU_PC_FSC_PPN, pt_info.ppn);
+	}
 	dc.ta = FIELD_PREP(RISCV_IOMMU_PC_TA_PSCID, domain->pscid) |
 	     RISCV_IOMMU_PC_TA_V;
 
-- 
2.50.1

