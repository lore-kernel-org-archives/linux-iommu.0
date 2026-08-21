Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E89E39B94F
	for <iommu@lists.linux.dev>; Fri, 21 Aug 2026 13:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787318905; cv=none; b=IVoeAgCSiLwoRQi9HGOqp3jtkYjhvXceek92W2Ez/ZTB1Dui/8ibdYITi7WFnFqGBEQAOoeB/0tPrKpaSaKh85bi0We7cFCurdC8Q+MjD7VqFddw7X41OIluoDZ7VbBYpEu8dLu4qzol8BC5ZCAaWwgX31wM6TPYm04rQouAX8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787318905; c=relaxed/simple;
	bh=UJS9DOCrsoCGIwsSYHWDVLuRjPpoOj+rrTHKwDqF2vs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WsW6JHI/Z5CS+wNIxc2HfH9AhCAwmT1U0Yrfb8AZeOyB3xshu/QhMjO8qVTWhL/0JXL+cLCx5Z3f8oncHwE/QzjN+ArMMF1r6ixUD2/syqNR/01dtXzF13gaUNI3rAQ1/wClmR8l/ebutiZeHx9RArE62WK59VN+ACiv6i2WS38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=kZ/5OA0v; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="kZ/5OA0v"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1787318894; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=bJah1AVjklnltP+n9003t/Lfq0Y0xBXEyF9SiWfTvEg=;
	b=kZ/5OA0v/1UfbbHPIaxolWHcVgbrwo3ygYq9TeWxbzmHmgi9vqsFJT1g8VnwJ9yPvMqTOscZ70jCqjz38pjcicGuyLzLSdO9ZD4ka9B0LH99PjeZYJynbmD7xzfJ2c8xluOFLIfAMSbjA0HGIOBUybXvBWt8RLPnLmZDqOA/NRw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=24;SR=0;TI=SMTPD_---0X9MSFIz_1787318890;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0X9MSFIz_1787318890 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 21 Aug 2026 21:28:12 +0800
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
Subject: [RFC PATCH v3 09/10] iommu/riscv: Add dirty tracking support for second-stage domains
Date: Fri, 21 Aug 2026 21:27:49 +0800
Message-Id: <20260821132749.82070-10-fangyu.yu@linux.alibaba.com>
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
index f01fd4e2f840..41b593def1f5 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -1352,6 +1352,21 @@ static int riscv_iommu_attach_paging_domain(struct iommu_domain *iommu_domain,
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
@@ -1442,6 +1457,8 @@ riscv_iommu_domain_alloc_paging_flags(struct device *dev, u32 flags,
 			goto err_free;
 		}
 		cfg.common.features |= BIT(PT_FEAT_RISCV_S2);
+		if (iommu->caps & RISCV_IOMMU_CAPABILITIES_AMO_HWAD)
+			domain->domain.dirty_ops = &riscv_iommu_dirty_ops;
 		break;
 	default:
 		ret = -EOPNOTSUPP;
@@ -1517,9 +1534,13 @@ static struct iommu_group *riscv_iommu_device_group(struct device *dev)
 
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

