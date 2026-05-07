Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D79E3E928B
	for <iommu@lists.linux.dev>; Thu,  7 May 2026 11:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778153853; cv=none; b=oDbFk8mQvoW5vL6Vk0ULf1UMOIPq/fZ5Vn7+PLbpFr6OjiEaawb24lxk25tcDJ4BI3spacAcZHuzj2cs6wwatw3wENPFNeiKjzeU8N3kw0xdUsTFz0M76PSfLwV3Xw+/ReIEyPiRp32lNrz/OD9EbV3yOAsWN9W2CS0ncc8buLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778153853; c=relaxed/simple;
	bh=ZyXErRgSeRi8Vb/chLbgc5T4YKtqYWjqc6cFpWaklCc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mAMhnLy4zFK4d7YhOOYYnin2w0nq0oSOGpnuWEzZbHrW4cVKUqd+AXu8oaA4hkbT0cINlI3SEqIvLVLECng9GOTf+TR/NcInH14EB9msyZAqfvl4xba3JQ366LDviUM2AKtRf6+7XLmj8F5wR0lH0Ty+OMeMikaBK0SjNjdOgbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=BN2xGRmR; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="BN2xGRmR"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1778153848; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=ymvPBhIqjH6VI2cF6B82ob0998YC79NL7DciLWQChAk=;
	b=BN2xGRmRiLIaqS+Z/xeyjmS1v47o01BbFjcKj7sTqGGnkGSbMtE+wYTgrS4wJTzv1vXI6ogiLiE3KwUizdK5RTP6PJGrd+qY7LSSzdCm2Mwr8hdn9AHjYJ/1KycQOrXDTXTgnxDi0cpKxwC4BJ7XYyoWkArvyMKrVE2gRAO8ehM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=24;SR=0;TI=SMTPD_---0X2UVF2E_1778153843;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0X2UVF2E_1778153843 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 07 May 2026 19:37:24 +0800
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
Subject: [RFC PATCH v2 09/10] iommu/riscv: Add dirty tracking support for second-stage domains
Date: Thu,  7 May 2026 19:37:05 +0800
Message-Id: <20260507113706.11400-10-fangyu.yu@linux.alibaba.com>
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

Add hardware dirty tracking support for second-stage (iohgatp) domains
used in KVM VFIO device pass-through.

The RISC-V IOMMU can automatically set the dirty bit in PTEs on write
access when DC.tc.GADE is set and the hardware has AMO_HWAD capability.
Wire this up to the iommufd dirty tracking interface:

  - riscv_iommu_set_dirty_tracking(): Always enabled dirty tracking for
    second-stage domain.

  - riscv_iommu_dirty_ops: Exposes set_dirty_tracking and the generic
    page-table read_and_clear_dirty via IOMMU_PT_DIRTY_OPS(riscv_64).

  - domain_alloc_paging_flags: Assigns dirty_ops to second-stage domains
    when AMO_HWAD is advertised in hardware capabilities.

  - riscv_iommu_capable: Reports IOMMU_CAP_DIRTY_TRACKING when
    AMO_HWAD is present.

Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
---
 drivers/iommu/riscv/iommu.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index 4adf2b6be89b..b7944149dcfe 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -1249,6 +1249,21 @@ static int riscv_iommu_attach_paging_domain(struct iommu_domain *iommu_domain,
 	return 0;
 }
 
+static int riscv_iommu_set_dirty_tracking(struct iommu_domain *iommu_domain,
+					  bool enable)
+{
+	/*
+	 * Always enabled and the dirty bitmap is cleared prior to
+	 * set_dirty_tracking().
+	 */
+	return 0;
+}
+
+static const struct iommu_dirty_ops riscv_iommu_dirty_ops = {
+	IOMMU_PT_DIRTY_OPS(riscv_64),
+	.set_dirty_tracking = riscv_iommu_set_dirty_tracking,
+};
+
 static const struct iommu_domain_ops riscv_iommu_paging_domain_ops = {
 	IOMMU_PT_DOMAIN_OPS(riscv_64),
 	.attach_dev = riscv_iommu_attach_paging_domain,
@@ -1336,6 +1351,8 @@ static struct iommu_domain *riscv_iommu_domain_alloc_paging_flags(
 			goto err_free;
 		}
 		cfg.common.features |= BIT(PT_FEAT_RISCV_S2);
+		if (iommu->caps & RISCV_IOMMU_CAPABILITIES_AMO_HWAD)
+			domain->domain.dirty_ops = &riscv_iommu_dirty_ops;
 		break;
 	default:
 		ret = -EOPNOTSUPP;
@@ -1411,9 +1428,13 @@ static struct iommu_group *riscv_iommu_device_group(struct device *dev)
 
 static bool riscv_iommu_capable(struct device *dev, enum iommu_cap cap)
 {
+	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
+
 	switch (cap) {
 	case IOMMU_CAP_CACHE_COHERENCY:
 		return true;
+	case IOMMU_CAP_DIRTY_TRACKING:
+		return !!(iommu->caps & RISCV_IOMMU_CAPABILITIES_AMO_HWAD);
 	default:
 		return false;
 	}
-- 
2.50.1

