Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD7427E1DC
	for <iommu@lists.linux.dev>; Fri, 17 Apr 2026 14:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776434889; cv=none; b=JOoqyT/t1xRxnBmYm3YJ0HTYsF/YJePxFqnEwSF9dEuAskN+umXzuKVMES7GtI+rCmQOBjO6h+uYObyj8X8ATQym6SpQWXQi0gIlajeVGoi4uuQbyXAFUXCCsoPbcG47egOjsXDnOVhk4Th5pVlqpp4PDyw1p0JRE0qPNzWRXhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776434889; c=relaxed/simple;
	bh=Xuo1/0PKFNCoZe2fFxPpdFOjn17kbjpmZkq6qKlrG/E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=J5r23Q4FzY91h24FDUlhKC3hBF95Jb4neV2bESxAC1pYdBNAEUB2p3NwJt87aYzrvRwnv5zFGyQMF3DEpF+D9XojvZVhszNqhaLn4nNRYx0LQohdsM2jNcgHWoYNFZKZntZpFc1YsIPb6qepWOV/xUwFhMicDqsSGwfIxPdzTEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=wCmax/q7; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="wCmax/q7"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1776434884; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=JxadIha1lW8Xw4rX95A+w2xRIU9Sj1dceq09MZ3+JCA=;
	b=wCmax/q7lT+YBDBMwXbPqykPHxFn9nkquj2KmqR2jBXdd+6qx9+e+Oz8cVOqdK4bRqMpeGKJgJ8VFh6UMle3X7mb530jd583c1Yg9xUZuP/uciIsTStLg5wLoZJMazmSie1LVCnI5FIvEXEMnLre/igiDSgBf5nsqymY4v3o72Q=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0X1BSP8P_1776434881;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0X1BSP8P_1776434881 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 17 Apr 2026 22:08:03 +0800
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
Subject: [PATCH v3 0/2] iommu/riscv: Support Svpbmt memory types in generic_pt
Date: Fri, 17 Apr 2026 22:07:44 +0800
Message-Id: <20260417140746.97817-1-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fangyu Yu <fangyu.yu@linux.alibaba.com>

RISC-V Svpbmt adds page-based memory types (PBMT) to PTEs, allowing
mappings to be tagged as e.g. normal memory, non-cacheable memory, or
I/O.

This series wires the RISC-V IOMMU Svpbmt capability into generic_pt
and uses PBMT to encode device memory attributes for IOMMU mappings.

---
Changes in v3:
    - Include RISCVPT_NC and RISCVPT_IO in riscvpt_attr_from_entry()
      to keep iommupt KUnit tests in sync.
    - Link to v2:
      https://lore.kernel.org/linux-riscv/20260414110212.79526-1-fangyu.yu@linux.alibaba.com
---
Changes in v2:
    - Add a comment for PT_FEAT_RISCV_SVPBMT (per Kevin and Jason).
    - Clarify PBMT encoding condition, sort PBMT-related bits by
      position, and drop the redundant PBMT clear(per Kevin).
    - Link to v1:
      https://lore.kernel.org/linux-iommu/20260411022223.91029-1-fangyu.yu@linux.alibaba.com/

Fangyu Yu (2):
  iommu/riscv: Advertise Svpbmt support to generic page table
  iommupt: Encode IOMMU_MMIO/IOMMU_CACHE via RISC-V Svpbmt bits

 drivers/iommu/generic_pt/fmt/riscv.h | 11 ++++++++++-
 drivers/iommu/riscv/iommu.c          |  2 ++
 include/linux/generic_pt/common.h    |  4 ++++
 3 files changed, 16 insertions(+), 1 deletion(-)

-- 
2.50.1

