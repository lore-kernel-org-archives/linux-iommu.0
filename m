Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221AE379C28
	for <iommu@lists.linux.dev>; Tue, 12 May 2026 07:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778571722; cv=none; b=Wm84dl3l+tvVQ7/AcYTDPlnIYxB48WUdG563WqXjFdrHb/rtKKhcLdvVjVhRhNgvtD5vZArwPtNX/IOgd0uEOWOukbyvwHCNLamzeQ4gOAJKUH8HWB7XE+kHoVpsYqghGZkqJF515OQEwHbzKQEUyyjiIBTtnb6JiMflJs1JvBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778571722; c=relaxed/simple;
	bh=S1KAa2hsg2t5OftD1qgj3EN+hxREsBlG2ozkwRkJzto=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FmM0jTcVJ4kIRDsC8wDtZ9blVaoj5mvGBObAWJkJYF2a4R+k9Ulnp6rms6MVdtqM60n31pIpdP1u/9LSLYHOQCjUaqkQBODnIR7cfABapV9V1jHsb5riwlkayzlCYlpfg87lz9aIEZYEE4AA8mD/F2g/kOJIZ17Mpc6ejA3T/uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Y9GUNCON; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Y9GUNCON"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1778571715; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=i04ZuxIi3jt4m8VWianwNO2YFQpZ5BInIfUiKWtaoro=;
	b=Y9GUNCONnLHKa7y/tKpkzm8dCjA0cu1wlRnPZXcVPeJ2u8VkuFheFi5ZdszceNBovGGOT6r65F7QikU5lf6uoGarlOBp3NW8PcSh3RRah63qoHBfoJBVym/r8FuA0ZaK6+rEQihrMX5mACpbfXcG/rHYv/WNlbxUuVNdNbdXb50=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=25;SR=0;TI=SMTPD_---0X2puQMt_1778571712;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0X2puQMt_1778571712 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 12 May 2026 15:41:53 +0800
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
	jgg@nvidia.com,
	nutty.liu@hotmail.com
Cc: guoren@kernel.org,
	andrew.jones@oss.qualcomm.com,
	kvm@vger.kernel.org,
	iommu@lists.linux.dev,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Fangyu Yu <fangyu.yu@linux.alibaba.com>
Subject: [PATCH v4 1/2] iommu/riscv: Advertise Svpbmt support to generic page table
Date: Tue, 12 May 2026 15:41:41 +0800
Message-Id: <20260512074142.16356-2-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260512074142.16356-1-fangyu.yu@linux.alibaba.com>
References: <20260512074142.16356-1-fangyu.yu@linux.alibaba.com>
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

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Reviewed-by: Guo Ren <guoren@kernel.org>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
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

