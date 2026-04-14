Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB2A3D6685
	for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 11:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776164550; cv=none; b=rSYpIR+4XPqB9OeoSd/Xt1TCU5TYM6x40lnWfnEuYSqRRFHN5jE2RXt9WmA6aASJrU8ZpDkwbn5PnIwHItCLXsKqg3o74Y/lYYYb/lhElfcg1caG/yFwRIxaPqMfI6ha6YeUVkHnJfErgFS9piW97mZhrKYrTVAyAYhVOKSpmeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776164550; c=relaxed/simple;
	bh=uiTsf+KCrYkj+tgmyKtbgQQNPklFPB2vi6KEjFAsivo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N70magVfe5GhuiPk2n2oWEACPnuj63m07AcYCWh+UORgrSGpUfMf/W9et6CpfTL+EhUR3AEeXE0Ox8xgEMlVmbuPQiLdkVaNm2olTBmOIEwE/HEvoCmTBIXnPzB21kyJ8iaehe2bzlacjzaaiqGv5NxRGKREwKzJEWC332jKXC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=lxQUSKgK; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="lxQUSKgK"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1776164541; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=1oJx6C7bTbqFRerwQikbn4XOKcny9PNxkWumn9MgJrw=;
	b=lxQUSKgKK+uuPFV7OC5gntI+tS3ui9yZWJHWyjuA2avlX9iyakJ73IYXCa1BoGqevhh+/l4cJqfLHnhtko4IFDfRmhRjq9nkp5y+mdYtyqReOutjR+Bvk2gwS+7ci31ow/DKIWe0UlIv0USSqLBQlg0kL2FrexsHrYFVVZDED78=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0X11DRTQ_1776164538;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0X11DRTQ_1776164538 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 14 Apr 2026 19:02:19 +0800
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
Subject: [PATCH v2 2/2] iommupt: Encode IOMMU_MMIO/IOMMU_CACHE via RISC-V Svpbmt bits
Date: Tue, 14 Apr 2026 19:02:12 +0800
Message-Id: <20260414110212.79526-3-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260414110212.79526-1-fangyu.yu@linux.alibaba.com>
References: <20260414110212.79526-1-fangyu.yu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fangyu Yu <fangyu.yu@linux.alibaba.com>

When the RISC-V IOMMU page table format support Svpbmt, PBMT provides
a way to tag mappings with page-based memory types. Encode memory type
via PBMT in RISC-V IOMMU PTEs:

  - IOMMU_MMIO   -> PBMT=IO
  - !IOMMU_MMIO && !IOMMU_CACHE -> PBMT=NC
  - otherwise    -> PBMT=Normal (PBMT=0)

Only touch PBMT when PT_FEAT_RISCV_SVPBMT is advertised.

Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Reviewed-by: Guo Ren <guoren@kernel.org>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
---
 drivers/iommu/generic_pt/fmt/riscv.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iommu/generic_pt/fmt/riscv.h b/drivers/iommu/generic_pt/fmt/riscv.h
index a7fef6266a36..57e51e5def9f 100644
--- a/drivers/iommu/generic_pt/fmt/riscv.h
+++ b/drivers/iommu/generic_pt/fmt/riscv.h
@@ -64,6 +64,8 @@ enum {
 	RISCVPT_PPN64 = GENMASK_ULL(53, 10),
 	RISCVPT_PPN64_64K = GENMASK_ULL(53, 14),
 	RISCVPT_PBMT = GENMASK_ULL(62, 61),
+	RISCVPT_NC = BIT(61),
+	RISCVPT_IO = BIT(62),
 	RISCVPT_N = BIT_ULL(63),
 
 	/* Svnapot encodings for ppn[0] */
@@ -237,6 +239,12 @@ static inline int riscvpt_iommu_set_prot(struct pt_common *common,
 		pte |= RISCVPT_R;
 	if (!(iommu_prot & IOMMU_NOEXEC))
 		pte |= RISCVPT_X;
+	if (common->features & BIT(PT_FEAT_RISCV_SVPBMT)) {
+		if (iommu_prot & IOMMU_MMIO)
+			pte |= RISCVPT_IO;
+		else if (!(iommu_prot & IOMMU_CACHE))
+			pte |= RISCVPT_NC;
+	}
 
 	/* Caller must specify a supported combination of flags */
 	if (unlikely((pte & (RISCVPT_X | RISCVPT_W | RISCVPT_R)) == 0))
-- 
2.50.1

