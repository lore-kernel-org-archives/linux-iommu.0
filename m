Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A993ED5DE
	for <iommu@lists.linux.dev>; Thu,  7 May 2026 11:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778153847; cv=none; b=R9/GW2A3QGcCnj7c8cSJk6cYEnlb/ckROPSCbuUP7urg2wtPhB9ZJOJhJFD7nETgYZiPHwzrwVWp6/KSIHCJUSy3KgYHmSYa5stP6IBjCi3gkSZQ0/2HjtiSKqbZcLOZ+9EhgB+Qvpl3g2cuTJ+2l8Des8adbLMUN/hIalwAsbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778153847; c=relaxed/simple;
	bh=pdT7jqaAaQjXrLDxPcXMYYjXh6e3rWtPFl0ETtBT2bk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cMSRHZQeZx4SEw2EBepXb9COVkd90+2M4knKCeeWujRQZ6Q0D8ozWsZ3iqUn4kimZLGng5rajMel7YKwf+CqxD9QrJy5NEJ+mD5rH+vLhFBuGC1XRQfAXvcNCqLaphLIIKNxkAcWbGy0EJ0ti7mFdMVzEiTtoamLXq6Zy0g0vAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=LIp0wB84; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="LIp0wB84"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1778153843; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=E95HEUv+RbcOdtj9NlIbuNX1uhYBJ2+6cETCe8Jytbc=;
	b=LIp0wB842VwYXNykg3LzL+cSLtQFHJ/rPPmgLW6WdtO/C9mzVgzpaqHOfoq11IMfNXlYusEEUKuXo8mAFPZtuV8hcPpyML6jlKMYTeFiXQixG2hrmmuo85Pm4M0Hi/MjUjuy26nFDdRMNO5lXCXRHezQGRUSYaaklhOt9p0HmI0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R261e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=24;SR=0;TI=SMTPD_---0X2UVF1L_1778153840;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0X2UVF1L_1778153840 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 07 May 2026 19:37:21 +0800
From: fangyu.yu@linux.alibaba.com
To: joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	tjeznach@rivosinc.com,
	jgg@ziepe.ca,
	kevin.tian@intel.com,
	baolu.lu@linux.intel.com,
	vasant.hegde@amd.com,
	anup@brainfault.org,
	atish.patra@linux.dev,
	skhawaja@google.com,
	jgg@nvidia.com
Cc: guoren@kernel.org,
	andrew.jones@oss.qualcomm.com,
	kvm@vger.kernel.org,
	iommu@lists.linux.dev,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Fangyu Yu <fangyu.yu@linux.alibaba.com>
Subject: [RFC PATCH v2 07/10] iommu/riscv: Add domain_alloc_paging_flags for second-stage domain
Date: Thu,  7 May 2026 19:37:03 +0800
Message-Id: <20260507113706.11400-8-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260507113706.11400-1-fangyu.yu@linux.alibaba.com>
References: <20260507113706.11400-1-fangyu.yu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
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
---
 drivers/iommu/riscv/iommu.c | 90 +++++++++++++++++++++++++++----------
 1 file changed, 67 insertions(+), 23 deletions(-)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index e883ace2f4f1..ebf42f74e194 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -1255,25 +1255,21 @@ static const struct iommu_domain_ops riscv_iommu_paging_domain_ops = {
 	.flush_iotlb_all = riscv_iommu_iotlb_flush_all,
 };
 
-static struct iommu_domain *riscv_iommu_alloc_paging_domain(struct device *dev)
+static struct iommu_domain *riscv_iommu_domain_alloc_paging_flags(
+		struct device *dev, u32 flags,
+		const struct iommu_user_data *user_data)
 {
 	struct pt_iommu_riscv_64_cfg cfg = {};
 	struct riscv_iommu_domain *domain;
 	struct riscv_iommu_device *iommu;
 	int ret;
+	const u32 supported_flags = IOMMU_HWPT_ALLOC_DIRTY_TRACKING |
+				    IOMMU_HWPT_ALLOC_NEST_PARENT;
 
-	iommu = dev_to_iommu(dev);
-	if (iommu->caps & RISCV_IOMMU_CAPABILITIES_SV57) {
-		cfg.common.hw_max_vasz_lg2 = 57;
-	} else if (iommu->caps & RISCV_IOMMU_CAPABILITIES_SV48) {
-		cfg.common.hw_max_vasz_lg2 = 48;
-	} else if (iommu->caps & RISCV_IOMMU_CAPABILITIES_SV39) {
-		cfg.common.hw_max_vasz_lg2 = 39;
-	} else {
-		dev_err(dev, "cannot find supported page table mode\n");
-		return ERR_PTR(-ENODEV);
-	}
-	cfg.common.hw_max_oasz_lg2 = 56;
+	if (flags & ~supported_flags)
+		return ERR_PTR(-EOPNOTSUPP);
+	if (user_data)
+		return ERR_PTR(-EOPNOTSUPP);
 
 	domain = kzalloc_obj(*domain);
 	if (!domain)
@@ -1281,6 +1277,8 @@ static struct iommu_domain *riscv_iommu_alloc_paging_domain(struct device *dev)
 
 	INIT_LIST_HEAD_RCU(&domain->bonds);
 	spin_lock_init(&domain->lock);
+	iommu = dev_to_iommu(dev);
+	cfg.common.hw_max_oasz_lg2 = 56;
 	/*
 	 * 6.4 IOMMU capabilities [..] IOMMU implementations must support the
 	 * Svnapot standard extension for NAPOT Translation Contiguity.
@@ -1291,19 +1289,65 @@ static struct iommu_domain *riscv_iommu_alloc_paging_domain(struct device *dev)
 	domain->riscvpt.iommu.nid = dev_to_node(iommu->dev);
 	domain->domain.ops = &riscv_iommu_paging_domain_ops;
 
-	domain->pscid = ida_alloc_range(&riscv_iommu_pscids, 1,
-					RISCV_IOMMU_MAX_PSCID, GFP_KERNEL);
-	if (domain->pscid < 0) {
-		riscv_iommu_free_paging_domain(&domain->domain);
-		return ERR_PTR(-ENOMEM);
+	switch (flags) {
+	case 0:
+		if (iommu->caps & RISCV_IOMMU_CAPABILITIES_SV57) {
+			cfg.common.hw_max_vasz_lg2 = 57;
+		} else if (iommu->caps & RISCV_IOMMU_CAPABILITIES_SV48) {
+			cfg.common.hw_max_vasz_lg2 = 48;
+		} else if (iommu->caps & RISCV_IOMMU_CAPABILITIES_SV39) {
+			cfg.common.hw_max_vasz_lg2 = 39;
+		} else {
+			ret = -ENODEV;
+			goto err_free;
+		}
+		domain->pscid = ida_alloc_range(&riscv_iommu_pscids, 1,
+						RISCV_IOMMU_MAX_PSCID, GFP_KERNEL);
+		if (domain->pscid < 0) {
+			ret = -ENOMEM;
+			goto err_free;
+		}
+		break;
+	case IOMMU_HWPT_ALLOC_NEST_PARENT:
+	case IOMMU_HWPT_ALLOC_DIRTY_TRACKING:
+	case IOMMU_HWPT_ALLOC_DIRTY_TRACKING | IOMMU_HWPT_ALLOC_NEST_PARENT:
+		/*
+		 * Second-stage (iohgatp) page table for KVM VFIO device
+		 * pass-through and dirty tracking. The GPA space is 2 bits
+		 * wider than the corresponding first-stage VA space (x4 root
+		 * page table), so hw_max_vasz_lg2 values are 41/50/59.
+		 */
+		if (iommu->caps & RISCV_IOMMU_CAPABILITIES_SV57X4) {
+			cfg.common.hw_max_vasz_lg2 = 59;
+		} else if (iommu->caps & RISCV_IOMMU_CAPABILITIES_SV48X4) {
+			cfg.common.hw_max_vasz_lg2 = 50;
+		} else if (iommu->caps & RISCV_IOMMU_CAPABILITIES_SV39X4) {
+			cfg.common.hw_max_vasz_lg2 = 41;
+		} else {
+			ret = -ENODEV;
+			goto err_free;
+		}
+		domain->gscid = ida_alloc_range(&riscv_iommu_gscids, 1,
+						RISCV_IOMMU_MAX_GSCID, GFP_KERNEL);
+		if (domain->gscid < 0) {
+			ret = -ENOMEM;
+			goto err_free;
+		}
+		cfg.common.features |= BIT(PT_FEAT_RISCV_S2);
+		break;
+	default:
+		ret = -EOPNOTSUPP;
+		goto err_free;
 	}
 
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
@@ -1438,7 +1482,7 @@ static const struct iommu_ops riscv_iommu_ops = {
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

