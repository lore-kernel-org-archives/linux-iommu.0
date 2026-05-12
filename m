Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B0E481225
	for <iommu@lists.linux.dev>; Tue, 12 May 2026 07:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778571729; cv=none; b=KM8OofluFGI/2Ma5vSFR0wlf4xsIg6/cHQWqiV5JTXY5lqlShUZofOjPr2X//zHv1q3zYjKHzrMs6aR7aDHqk9L2eTsKrz1L7NxFpy/wLD8NIGBOxV2fbTbZptFOpVpbJ2pSgYZhhZlWEaV+dJtdicHvffncQVsQbnRxwKiuA9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778571729; c=relaxed/simple;
	bh=f7BjFLEDmKzCfcaI0RT94K69Drl++QNC56ZYMtUEJwo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uhRnXrfvyxsPonLhgkjvUE2hZIKHt492ZRXyCBqeKnBi76vMILIIlkf9j4b/6ajKHM1EyCtagmQim3asS5xyg4OcbWA4FfMhskIUa35JrlZfXYjF0/yavfKeX9LtZtgGYWoB22eCLbdq6lJfNvtVguuccOYSwGGnaoiR8PoOv/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=kj/80AVg; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="kj/80AVg"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1778571717; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=+9HQQIBfEhfwMc3uGZK7qS8juRrVA4rZdGkcmvlp+jQ=;
	b=kj/80AVgiDQzMz/SjYsQiMh0Q2hmBTI+VfJcze4M5oav5vRcBV5N/LETmGuQAZcPtYMYiWfkjSEQrdncb8DqV1TnBiL3S2bl029D7M7rU9OHDZdW2pTRv6PvBJfwl1IKCrXwvVY5C49toKx9BORSHI54dN7izSmO8kzOyYMlkvs=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=25;SR=0;TI=SMTPD_---0X2puQNT_1778571714;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0X2puQNT_1778571714 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 12 May 2026 15:41:55 +0800
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
Subject: [PATCH v4 2/2] iommupt: Encode IOMMU_MMIO/IOMMU_CACHE via RISC-V Svpbmt bits
Date: Tue, 12 May 2026 15:41:42 +0800
Message-Id: <20260512074142.16356-3-fangyu.yu@linux.alibaba.com>
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

When the RISC-V IOMMU page table format support Svpbmt, PBMT provides
a way to tag mappings with page-based memory types. Encode memory type
via PBMT in RISC-V IOMMU PTEs:

  - IOMMU_MMIO   -> PBMT=IO
  - !IOMMU_MMIO && !IOMMU_CACHE -> PBMT=NC
  - otherwise    -> PBMT=Normal (PBMT=0)

Only touch PBMT when PT_FEAT_RISCV_SVPBMT is advertised.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Reviewed-by: Guo Ren <guoren@kernel.org>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
---
 drivers/iommu/generic_pt/fmt/riscv.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/generic_pt/fmt/riscv.h b/drivers/iommu/generic_pt/fmt/riscv.h
index a7fef6266a36..ae9a76514416 100644
--- a/drivers/iommu/generic_pt/fmt/riscv.h
+++ b/drivers/iommu/generic_pt/fmt/riscv.h
@@ -64,6 +64,8 @@ enum {
 	RISCVPT_PPN64 = GENMASK_ULL(53, 10),
 	RISCVPT_PPN64_64K = GENMASK_ULL(53, 14),
 	RISCVPT_PBMT = GENMASK_ULL(62, 61),
+	RISCVPT_NC = BIT_ULL(61),
+	RISCVPT_IO = BIT_ULL(62),
 	RISCVPT_N = BIT_ULL(63),
 
 	/* Svnapot encodings for ppn[0] */
@@ -201,7 +203,8 @@ static inline void riscvpt_attr_from_entry(const struct pt_state *pts,
 {
 	attrs->descriptor_bits =
 		pts->entry & (RISCVPT_R | RISCVPT_W | RISCVPT_X | RISCVPT_U |
-			      RISCVPT_G | RISCVPT_A | RISCVPT_D);
+			      RISCVPT_G | RISCVPT_A | RISCVPT_D | RISCVPT_NC |
+			      RISCVPT_IO);
 }
 #define pt_attr_from_entry riscvpt_attr_from_entry
 
@@ -237,6 +240,12 @@ static inline int riscvpt_iommu_set_prot(struct pt_common *common,
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

