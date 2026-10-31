Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793435443;
	b=MImS7uQlwgfJm91AKABuJ034Ssx1BDJYUc8v+wkcVov2mwhUTE96YY+xtyH0rYMvjfeA
	 du0XDH1O4XxokS5Qpu3koFodi+WygOFFxBRid/ITQpDKkSn2ek8uOk2Spf0pZ1O47WVO4
	 F0dAGWKn7Zq2a7yagm9GvT5eUOlqTRt8XJA1k18szaOgzn/9ksCumnpadQFnvgY/UNWY4
	 BVvynySGxlplbPY4PeX3QmHrYghKCa/SUaVr+oga/OLZqo6ckkePqjhmwlC8ndRLbC+N0
	 90lmTFDgi/GK0EPSVO+e4JvH5cRrQUv7hYeCF6acVAWi/1duCugkHDX8cfxuq8pVFRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793435443;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=poUnffyIB/bwk8j0vsXO25pCI+FN7LS0EV9Cq22HVUY=;
	b=XvziKwmpZzC6IYN48QAsbD2gyJEbQi1KT+88fz3LmBkztjLQSD4n3dOWQpElKPvXzlgg
	 ouZb+xnsgzVQt3Oc37/05oPFbyM52iVHVWeFodaDFbVjvVArLIrfbimbzPMqMbLYgYWTn
	 cLlCY1V+qyNTPIcKE78Qm6OAsUrwD+qP0lnCXEBs5snzwYaOjDpCjkyQeCgaz4SfEkZpq
	 we0n7b81+lnH6KUGf3h8UslE957dHmAVFKX2AvdXIInidjO1p2Gw3kgVongdMPXYejOq+
	 wxNGGZgbTaRbk3/zwjBlKbMd16keQJMUbVLFYoLOsN8kYzGjrfYo2dCGjKPAHfOEJkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=mjiL8xV0;
	arc=none smtp.remote-ip=115.124.30.124
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BE060A261F
	for <iommu@lists.linux.dev>; Sat, 31 Oct 2026 08:30:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18BE060A261F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=mjiL8xV0
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793435434; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=poUnffyIB/bwk8j0vsXO25pCI+FN7LS0EV9Cq22HVUY=;
	b=mjiL8xV0R8zDdyzHmlR/fRdzXHhTW4XsREw8Iimy5MIfNdM1/MYl2KBrzXC8quEOMKELatQE5RSnkMZ1fRcMOTF7Z6h6tSFroE8HJmpUsUY85hdVMZYmCbamBCeHdB870djhj6wBRHjrMCgPo5q4AA3mH0YdfGC+Fpqmm+MfGIQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R611e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=28;SR=0;TI=SMTPD_---0XDo-2ma_1793435431;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0XDo-2ma_1793435431 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 31 Oct 2026 16:30:32 +0800
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
	kvm-riscv@lists.infradead.org
Subject: [PATCH v6 07/10] iommu/riscv: Add domain_alloc_paging_flags for second-stage domain
Date: Sat, 31 Oct 2026 16:30:11 +0800
Message-Id: <20261031083014.15040-8-fangyu.yu@linux.alibaba.com>
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

From: Fangyu Yu <fangyu.yu@linux.alibaba.com>

Replace .domain_alloc_paging with .domain_alloc_paging_flags so callers
can pass allocation flags to select the appropriate page-table type.

When IOMMU_HWPT_ALLOC_NEST_PARENT or IOMMU_HWPT_ALLOC_DIRTY_TRACKING is
set in @flags, allocate a second-stage (iohgatp) domain.

When @flags is 0 the behaviour is identical to the previous
domain_alloc_paging: first-stage (iosatp) domain.

Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/riscv/iommu.c | 107 ++++++++++++++++++++++++++++--------
 1 file changed, 84 insertions(+), 23 deletions(-)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index 162752bb698e..082f55c44d20 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -1381,25 +1381,74 @@ static const struct iommu_domain_ops riscv_iommu_paging_domain_ops = {
 	.flush_iotlb_all = riscv_iommu_iotlb_flush_all,
 };
 
-static struct iommu_domain *riscv_iommu_alloc_paging_domain(struct device *dev)
+static int riscv_iommu_init_domain_s1(struct device *dev,
+				      struct riscv_iommu_domain *domain,
+				      struct pt_iommu_riscv_64_cfg *cfg)
 {
-	struct pt_iommu_riscv_64_cfg cfg = {};
-	struct riscv_iommu_domain *domain;
-	struct riscv_iommu_device *iommu;
-	int ret;
+	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
 
-	iommu = dev_to_iommu(dev);
+	cfg->common.features |= BIT(PT_FEAT_SIGN_EXTEND);
 	if (iommu->caps & RISCV_IOMMU_CAPABILITIES_SV57) {
-		cfg.common.hw_max_vasz_lg2 = 57;
+		cfg->common.hw_max_vasz_lg2 = 57;
 	} else if (iommu->caps & RISCV_IOMMU_CAPABILITIES_SV48) {
-		cfg.common.hw_max_vasz_lg2 = 48;
+		cfg->common.hw_max_vasz_lg2 = 48;
 	} else if (iommu->caps & RISCV_IOMMU_CAPABILITIES_SV39) {
-		cfg.common.hw_max_vasz_lg2 = 39;
+		cfg->common.hw_max_vasz_lg2 = 39;
 	} else {
 		dev_err(dev, "cannot find supported page table mode\n");
-		return ERR_PTR(-ENODEV);
+		return -ENODEV;
 	}
-	cfg.common.hw_max_oasz_lg2 = 56;
+
+	domain->pscid = ida_alloc_range(&riscv_iommu_pscids, 1,
+					RISCV_IOMMU_MAX_PSCID, GFP_KERNEL);
+	if (domain->pscid < 0)
+		return -ENOMEM;
+
+	return 0;
+}
+
+/*
+ * Second-stage (iohgatp) page table for KVM VFIO device pass-through and dirty
+ * tracking. The GPA space is 2 bits wider than the corresponding first-stage VA
+ * space (x4 root page table), so hw_max_vasz_lg2 values are 41/50/59.
+ */
+static int riscv_iommu_init_domain_s2(struct device *dev,
+				      struct riscv_iommu_domain *domain,
+				      struct pt_iommu_riscv_64_cfg *cfg)
+{
+	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
+
+	cfg->common.features |= BIT(PT_FEAT_RISCV_S2);
+	if (iommu->caps & RISCV_IOMMU_CAPABILITIES_SV57X4) {
+		cfg->common.hw_max_vasz_lg2 = 59;
+	} else if (iommu->caps & RISCV_IOMMU_CAPABILITIES_SV48X4) {
+		cfg->common.hw_max_vasz_lg2 = 50;
+	} else if (iommu->caps & RISCV_IOMMU_CAPABILITIES_SV39X4) {
+		cfg->common.hw_max_vasz_lg2 = 41;
+	} else {
+		dev_err(dev, "cannot find supported page table mode\n");
+		return -ENODEV;
+	}
+
+	domain->gscid = ida_alloc_range(&riscv_iommu_gscids, 1,
+					RISCV_IOMMU_MAX_GSCID, GFP_KERNEL);
+	if (domain->gscid < 0)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static struct iommu_domain *
+riscv_iommu_domain_alloc_paging_flags(struct device *dev, u32 flags,
+				      const struct iommu_user_data *user_data)
+{
+	struct pt_iommu_riscv_64_cfg cfg = {};
+	struct riscv_iommu_domain *domain;
+	struct riscv_iommu_device *iommu;
+	int ret;
+
+	if (user_data)
+		return ERR_PTR(-EOPNOTSUPP);
 
 	domain = kzalloc_obj(*domain);
 	if (!domain)
@@ -1407,12 +1456,13 @@ static struct iommu_domain *riscv_iommu_alloc_paging_domain(struct device *dev)
 
 	INIT_LIST_HEAD_RCU(&domain->bonds);
 	spin_lock_init(&domain->lock);
+	iommu = dev_to_iommu(dev);
+	cfg.common.hw_max_oasz_lg2 = 56;
 	/*
 	 * 6.4 IOMMU capabilities [..] IOMMU implementations must support the
 	 * Svnapot standard extension for NAPOT Translation Contiguity.
 	 */
-	cfg.common.features = BIT(PT_FEAT_SIGN_EXTEND) |
-			      BIT(PT_FEAT_FLUSH_RANGE) |
+	cfg.common.features = BIT(PT_FEAT_FLUSH_RANGE) |
 			      BIT(PT_FEAT_RISCV_SVNAPOT_64K) |
 			      BIT(PT_FEAT_DETAILED_GATHER);
 	if (iommu->caps & RISCV_IOMMU_CAPABILITIES_SVPBMT)
@@ -1420,19 +1470,30 @@ static struct iommu_domain *riscv_iommu_alloc_paging_domain(struct device *dev)
 	domain->riscvpt.iommu.nid = dev_to_node(iommu->dev);
 	domain->domain.ops = &riscv_iommu_paging_domain_ops;
 
-	domain->pscid = ida_alloc_range(&riscv_iommu_pscids, 1,
-					RISCV_IOMMU_MAX_PSCID, GFP_KERNEL);
-	if (domain->pscid < 0) {
-		riscv_iommu_free_paging_domain(&domain->domain);
-		return ERR_PTR(-ENOMEM);
+	switch (flags) {
+	case 0:
+		ret = riscv_iommu_init_domain_s1(dev, domain, &cfg);
+		break;
+	case IOMMU_HWPT_ALLOC_NEST_PARENT:
+	case IOMMU_HWPT_ALLOC_DIRTY_TRACKING:
+	case IOMMU_HWPT_ALLOC_DIRTY_TRACKING | IOMMU_HWPT_ALLOC_NEST_PARENT:
+		ret = riscv_iommu_init_domain_s2(dev, domain, &cfg);
+		break;
+	default:
+		ret = -EOPNOTSUPP;
+		break;
 	}
+	if (ret)
+		goto err_free;
 
 	ret = pt_iommu_riscv_64_init(&domain->riscvpt, &cfg, GFP_KERNEL);
-	if (ret) {
-		riscv_iommu_free_paging_domain(&domain->domain);
-		return ERR_PTR(ret);
-	}
+	if (ret)
+		goto err_free;
 	return &domain->domain;
+
+err_free:
+	riscv_iommu_free_paging_domain(&domain->domain);
+	return ERR_PTR(ret);
 }
 
 static int riscv_iommu_attach_blocking_domain(struct iommu_domain *iommu_domain,
@@ -1567,7 +1628,7 @@ static const struct iommu_ops riscv_iommu_ops = {
 	.identity_domain = &riscv_iommu_identity_domain,
 	.blocked_domain = &riscv_iommu_blocking_domain,
 	.release_domain = &riscv_iommu_blocking_domain,
-	.domain_alloc_paging = riscv_iommu_alloc_paging_domain,
+	.domain_alloc_paging_flags = riscv_iommu_domain_alloc_paging_flags,
 	.device_group = riscv_iommu_device_group,
 	.probe_device = riscv_iommu_probe_device,
 	.release_device	= riscv_iommu_release_device,
-- 
2.50.1

