Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDFD47884B
	for <iommu@lists.linux.dev>; Fri, 21 Aug 2026 13:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787318894; cv=none; b=PPYt8G4pGIEGbRNG31sNX9rXIp0ElnZCLtz6jVHEsSon2eb2MIdTxxw5GSDeh/jnYYWvHM0scN53H5YDiwxEsSDs+v+d5P1sxroCS426GR3W8MSZ3VP1dwydruiJky7FwRkUJv3iUWGn2+E6mCfZR+RVkL0wf1MF3tXvh8YnEEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787318894; c=relaxed/simple;
	bh=4hXPQELO5qitzA3apTLerr45guYer49u0OK1Y1Bv5C0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PBANik2G/WzmZ4rMMsSQ0fkuHGazml6XMgqN9QiPL1OF8sm8eRoNOQVWGRZEaFNXf3M/bNhUQBBIT5lheiwCiG/S0YLNOmTwwLR/23SVCOSeLNduEvBEVVtwmRj9LoLiIVcHyvP1+92JUG5A9q6xlRFLWFW4W51qVbNz/iBtKXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=R1IS2xea; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="R1IS2xea"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1787318884; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=g5oPgxu2ndRm+j5xlzJz/oZjwxExHiD5E49g/zXenDU=;
	b=R1IS2xeas9h7NcC4W1q054Hujb6pSik8Uaght1A5Eyo8K9/fdQvnYnVuooeI8kSsRA54ifSgq3TNcwKB6eKTRyK5PBh7XrfmBACun/DZLBQJx9usAFHzLZDXXc9WZCPBESGznqGK/BEZoaXZTehqZybngIlh6ScxPX/VWwarDFw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=24;SR=0;TI=SMTPD_---0X9MSFGg_1787318880;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0X9MSFGg_1787318880 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 21 Aug 2026 21:28:02 +0800
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
	andrew.jones@oss.qualcomm.com,
	anup@brainfault.org,
	jgg@nvidia.com,
	jgg@ziepe.ca,
	kevin.tian@intel.com,
	atish.patra@linux.dev,
	skhawaja@google.com,
	vasant.hegde@amd.com
Cc: fangyu.yu@linux.alibaba.com,
	guoren@kernel.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [RFC PATCH v3 04/10] iommu/riscv: use data structure instead of individual values
Date: Fri, 21 Aug 2026 21:27:44 +0800
Message-Id: <20260821132749.82070-5-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260821132749.82070-1-fangyu.yu@linux.alibaba.com>
References: <20260821132749.82070-1-fangyu.yu@linux.alibaba.com>
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
Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
---
 drivers/iommu/riscv/iommu.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index a6c8307e82ea..c5b6214ee672 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -1165,7 +1165,7 @@ static void riscv_iommu_iodir_iotinval(struct riscv_iommu_device *iommu,
  * interim translation faults.
  */
 static void riscv_iommu_iodir_update(struct riscv_iommu_device *iommu,
-				     struct device *dev, u64 fsc, u64 ta)
+				     struct device *dev, struct riscv_iommu_dc *new_dc)
 {
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct riscv_iommu_dc *dc;
@@ -1204,10 +1204,10 @@ static void riscv_iommu_iodir_update(struct riscv_iommu_device *iommu,
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
@@ -1288,22 +1288,22 @@ static int riscv_iommu_attach_paging_domain(struct iommu_domain *iommu_domain,
 	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
 	struct riscv_iommu_info *info = dev_iommu_priv_get(dev);
 	struct pt_iommu_riscv_64_hw_info pt_info;
-	u64 fsc, ta;
+	struct riscv_iommu_dc dc = {0};
 
 	pt_iommu_riscv_64_hw_info(&domain->riscvpt, &pt_info);
 
 	if (!riscv_iommu_pt_supported(iommu, pt_info.fsc_iosatp_mode))
 		return -ENODEV;
 
-	fsc = FIELD_PREP(RISCV_IOMMU_PC_FSC_MODE, pt_info.fsc_iosatp_mode) |
+	dc.fsc = FIELD_PREP(RISCV_IOMMU_PC_FSC_MODE, pt_info.fsc_iosatp_mode) |
 	      FIELD_PREP(RISCV_IOMMU_PC_FSC_PPN, pt_info.ppn);
-	ta = FIELD_PREP(RISCV_IOMMU_PC_TA_PSCID, domain->pscid) |
+	dc.ta = FIELD_PREP(RISCV_IOMMU_PC_TA_PSCID, domain->pscid) |
 	     RISCV_IOMMU_PC_TA_V;
 
 	if (riscv_iommu_bond_link(domain, dev))
 		return -ENOMEM;
 
-	riscv_iommu_iodir_update(iommu, dev, fsc, ta);
+	riscv_iommu_iodir_update(iommu, dev, &dc);
 	riscv_iommu_bond_unlink(info->domain, dev);
 	info->domain = domain;
 
@@ -1378,9 +1378,12 @@ static int riscv_iommu_attach_blocking_domain(struct iommu_domain *iommu_domain,
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
 
@@ -1400,8 +1403,12 @@ static int riscv_iommu_attach_identity_domain(struct iommu_domain *iommu_domain,
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
2.50.1

