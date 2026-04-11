Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762E01E376C
	for <iommu@lists.linux.dev>; Sat, 11 Apr 2026 02:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775874157; cv=none; b=pNPcVHiQQCcKPdPdjI9HgkIOeIREe15FpZMMq9nh6o6SgJlLIpuc6uOz90ZZVhuo8ht3GqhBXIq7/IJ/LTl8HbwSaFlCsr1IX0KL52hp/wHICU8zChN8D9cI9N/1VuxL9sR2K/m1fVU/7+4foJno5YEYY1q4Mx5WRANx19RqdKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775874157; c=relaxed/simple;
	bh=uDmgou8cV9j995XJJlidkFrJvFWu5yVrSrmrGZy80Ds=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e1vSIkYeMWcvmjCIvvqJfezFjFb7aNrQalLyKA+4+N5a8NdO+E7vr7i7TcWRRHp9yjZ/aBuEBXKcTAndRHKqILvxREEUWm6HA0RIUnhrK3Bepe4afGLFQvSkHOrGCT2Fi8D1CYyjK38yDTeg6KhE7F5GyrFBWjL+mViiZuZ1Fyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=XYXgnG31; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="XYXgnG31"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1775874152; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=OH5/TUCPHpy8sy8haBbJAQ5yBUA8WaHxyR6Sehfd16w=;
	b=XYXgnG31M5b0ZtkLYJdAVRc1DGhMC+UqYJWrNpk+m+P9pDrf5rhPja7wMyrajSDCC2okrukL3e97M3K7f13S8jGpjR2IlFEoKMXQxJ6LYTy5ZkRLqhAvNtrVm2VNIdD/naVn+j3tMhbgNmiLiSY9q67SXF8yZCb9OqrtJBeowb0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0X0miYSJ_1775874149;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0X0miYSJ_1775874149 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 11 Apr 2026 10:22:30 +0800
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
	vasant.hegde@amd.com
Cc: guoren@kernel.org,
	iommu@lists.linux.dev,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Fangyu Yu <fangyu.yu@linux.alibaba.com>
Subject: [PATCH 2/2] iommupt: Encode IOMMU_MMIO/IOMMU_CACHE via RISC-V Svpbmt bits
Date: Sat, 11 Apr 2026 10:22:23 +0800
Message-Id: <20260411022223.91029-3-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260411022223.91029-1-fangyu.yu@linux.alibaba.com>
References: <20260411022223.91029-1-fangyu.yu@linux.alibaba.com>
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
  - !IOMMU_CACHE -> PBMT=NC
  - otherwise    -> PBMT=Normal (PBMT=0)

Clear the PBMT field before applying the selected encoding, and only
touch PBMT when PT_FEAT_RISCV_SVPBMT is advertised.

Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
---
 drivers/iommu/generic_pt/fmt/riscv.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/iommu/generic_pt/fmt/riscv.h b/drivers/iommu/generic_pt/fmt/riscv.h
index a7fef6266a36..02051bb3c6e5 100644
--- a/drivers/iommu/generic_pt/fmt/riscv.h
+++ b/drivers/iommu/generic_pt/fmt/riscv.h
@@ -58,6 +58,8 @@ enum {
 	RISCVPT_G = BIT(5),
 	RISCVPT_A = BIT(6),
 	RISCVPT_D = BIT(7),
+	RISCVPT_NC = BIT(61),
+	RISCVPT_IO = BIT(62),
 	RISCVPT_RSW = GENMASK(9, 8),
 	RISCVPT_PPN32 = GENMASK(31, 10),
 
@@ -237,6 +239,13 @@ static inline int riscvpt_iommu_set_prot(struct pt_common *common,
 		pte |= RISCVPT_R;
 	if (!(iommu_prot & IOMMU_NOEXEC))
 		pte |= RISCVPT_X;
+	if (common->features & BIT(PT_FEAT_RISCV_SVPBMT)) {
+		pte &= ~RISCVPT_PBMT;
+		if (iommu_prot & IOMMU_MMIO)
+			pte |= RISCVPT_IO;
+		else if (!(iommu_prot & IOMMU_CACHE))
+			pte |= RISCVPT_NC;
+	}
 
 	/* Caller must specify a supported combination of flags */
 	if (unlikely((pte & (RISCVPT_X | RISCVPT_W | RISCVPT_R)) == 0))
-- 
2.50.1

