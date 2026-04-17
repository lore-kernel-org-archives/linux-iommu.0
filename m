Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37441369985
	for <iommu@lists.linux.dev>; Fri, 17 Apr 2026 14:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776434898; cv=none; b=kYzjIHs3D9m9kxVlksujlgGH8K0SePxJud2LvMpUntF9opzbkef5Y+mz5WeTjPpwRYS4vSx1PNPf6S+PsW187MrV/uk1/XW1Vt5llOX5wlJkXdfE0fakrM2xNt9rxA3t3pxp+oexBMU1Q/NA8yO4sDCR+PfoYDlzBSXM7dcubzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776434898; c=relaxed/simple;
	bh=mPhwWG8stDgzfJqkWaeE2DqE8r3nf41zhEAocre/Z1c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GS5TOzMPJDrSpI80XjnS0XonIdKSm8GNjYec5/c4Nsz1cQZfraIMKaVNTATikc65T9MZEivcFBych0fYErh8Kt/vqESz8J+xnLu1ccGZnO9sVPnWGri/ADcpYqtOf1GRSiuBjP1hTsRt8+3g15BUH6Jh1egyr5JKPIMxeOxu7OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=GKGfQxww; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="GKGfQxww"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1776434886; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=eRBiDugkSgMWef5zGsxjLEV8tSokc5DBUdZvmJMWCbw=;
	b=GKGfQxww5U5gV4aRHF0b3pn7sSGP47cxzn9TgD2ispXN7EUA9nm4Nfv45ivwQBp6tVNZR2typ6jJWUWjk3qS38fdjCXpNGZaHMnDSZB3ZPhRcYG8aSA0J8g8YcXIFJpDBsGCgf6KB10JnI5cPCNuPQYLSciGmys1n4OGbnXnM5E=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0X1BSP9G_1776434883;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0X1BSP9G_1776434883 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 17 Apr 2026 22:08:04 +0800
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
	nutty.liu@hotmail.com,
	jgg@nvidia.com
Cc: guoren@kernel.org,
	iommu@lists.linux.dev,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Fangyu Yu <fangyu.yu@linux.alibaba.com>
Subject: [PATCH v3 1/2] iommu/riscv: Advertise Svpbmt support to generic page table
Date: Fri, 17 Apr 2026 22:07:45 +0800
Message-Id: <20260417140746.97817-2-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260417140746.97817-1-fangyu.yu@linux.alibaba.com>
References: <20260417140746.97817-1-fangyu.yu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fangyu Yu <fangyu.yu@linux.alibaba.com>

The RISC-V IOMMU can optionally support Svpbmt page-based memory types
in its page table format. When present,the generic page table code can
use this capability to encode memory attributes (e.g. MMIO vs normal
memory) in PTEs.

Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Reviewed-by: Guo Ren <guoren@kernel.org>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 drivers/iommu/riscv/iommu.c       | 2 ++
 include/linux/generic_pt/common.h | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index a31f50bbad35..6c324f9fdc53 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -1268,6 +1268,8 @@ static struct iommu_domain *riscv_iommu_alloc_paging_domain(struct device *dev)
 	cfg.common.features = BIT(PT_FEAT_SIGN_EXTEND) |
 			      BIT(PT_FEAT_FLUSH_RANGE) |
 			      BIT(PT_FEAT_RISCV_SVNAPOT_64K);
+	if (iommu->caps & RISCV_IOMMU_CAPABILITIES_SVPBMT)
+		cfg.common.features |= BIT(PT_FEAT_RISCV_SVPBMT);
 	domain->riscvpt.iommu.nid = dev_to_node(iommu->dev);
 	domain->domain.ops = &riscv_iommu_paging_domain_ops;
 
diff --git a/include/linux/generic_pt/common.h b/include/linux/generic_pt/common.h
index fc5d0b5edadc..2683e5b38998 100644
--- a/include/linux/generic_pt/common.h
+++ b/include/linux/generic_pt/common.h
@@ -188,6 +188,10 @@ enum {
 	 * Support the 64k contiguous page size following the Svnapot extension.
 	 */
 	PT_FEAT_RISCV_SVNAPOT_64K = PT_FEAT_FMT_START,
+	/*
+	 * Support Svpbmt extension: encode page-based memory type (PBMT) in PTEs.
+	 */
+	PT_FEAT_RISCV_SVPBMT,
 
 };
 
-- 
2.50.1

