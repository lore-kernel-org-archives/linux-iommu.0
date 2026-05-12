Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC20384CF2
	for <iommu@lists.linux.dev>; Tue, 12 May 2026 07:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778571725; cv=none; b=lXOQpgRveoc0mMOiD4P8pxqVVHJ8jQR6kE2OX5jAX1LaVEd75oe/BpuOYiExw/7c+70cmc5qQGYn21iMaD/tNQCYbnSkVPFJ7/PyVfhWrmR8yWpGX97tWChngqHoEn96356Rr97Ujm1zaxZnVSqqM8mpt2GeZovftLwUVfSZ0SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778571725; c=relaxed/simple;
	bh=kmAC7beraB5lHR1DgYB/DZuEs9utuUEPmLdsGUjAoxE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jmL5Q1O1TLmgl6g9x8tvo++IvZrgln1Kb9gZ8MI+UrswQ4csXKz3/e9hYK/gWO+uDX/YI81PeZyUvPSGJZMlUnYWYf8VkET10n3wGfGvdbDubyW4s5wMJIMgZKsrwT+sbwk8xvNBPR7QXh+z1ySMghZkGQLkf/OnDGlOYAZpWRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=hGOKuetY; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="hGOKuetY"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1778571713; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=iGZ65kdo1hvMwcfP8gimQwDdAcnQW+BXaCkGVek8pE8=;
	b=hGOKuetYkTqckxM7S3qM2EKdu5GNwTZF6bgFqOPBLBlKMNwG0jNSvK9GdMsc+1IbRdVvJ2vATHPCO4UN1eQN5Flupl2pxqdqReqRg1zpBZM7PSUQObeqjmFqwAfbqXbajJJ8QLqnj8B/D37l5ad9F+s4TRXCYSR0VbnjDeTEego=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R721e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=25;SR=0;TI=SMTPD_---0X2puQM0_1778571710;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0X2puQM0_1778571710 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 12 May 2026 15:41:52 +0800
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
Subject: [PATCH v4 0/2] iommu/riscv: Support Svpbmt memory types in generic_pt
Date: Tue, 12 May 2026 15:41:40 +0800
Message-Id: <20260512074142.16356-1-fangyu.yu@linux.alibaba.com>
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
Changes in v4:
    - Fix build warning on 32-bit configurations by using BIT_ULL() for RISCVPT_NC and RISCVPT_IO. 
    - Link to v3:
      https://lore.kernel.org/linux-riscv/20260417140746.97817-1-fangyu.yu@linux.alibaba.com/
---
Changes in v3:
    - Include RISCVPT_NC and RISCVPT_IO in riscvpt_attr_from_entry()
      so iommupt KUnit tests preserve these descriptor bits..
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

