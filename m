Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA2F3537C4
	for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 11:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776164549; cv=none; b=jKtvMKSHSiZBQPZvnH8BgTFT02Xl53elf6AyQP4CD1MGH2TIelE1mTy8/F/+wF0MDpZy4ft3JpDzabEjQpatTtt9q1hb0To1Vr3bGv01r43ZR5w4izms28/QJ8FkVTZF7j8Inkmbiuo3hJMUer2yf0vnN6V+8lX7BDukI9MQX9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776164549; c=relaxed/simple;
	bh=bUZjuwRqxe0zG75VdEd4j9GQcZjsplatMJu7LC7SuF4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Kj6OXHQndGNdIyyPhXSw3f29fx3Z3cPcqRAJedwDgsPogzE0dfmI1QqOKYdJoby43OiPzzxDftjCp7L8H/jduGO/PhuRJid46C3a2GQKmPh6rXq0ChsB/1y7RQChbSHW1Qb6/hdwreOI/G11H+aQrtrfXMhrtccQDXCQWAPLfYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=EphP+C9A; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="EphP+C9A"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1776164538; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=nQO0WEe8PRJEZNBo6ma9yL1pusW/StlSU4Ir3Mof4CQ=;
	b=EphP+C9ABrK2oP7xBJsPD/yuECum1ltzxm417J43klgX5i8ytUm3yKmGqKnIpG585AVeJu9CqJxCe01DCE1CrFR0E7vCCuXG5XgT5X3hdl7WFW1TGOqoVlLDiAyLHEtyaKIEcoKK65K/Q80o83aRuXu+VUwsog5yOxirwDfaEGc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R751e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0X11DRSf_1776164534;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0X11DRSf_1776164534 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 14 Apr 2026 19:02:16 +0800
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
Subject: [PATCH v2 0/2] iommu/riscv: Support Svpbmt memory types in generic_pt
Date: Tue, 14 Apr 2026 19:02:10 +0800
Message-Id: <20260414110212.79526-1-fangyu.yu@linux.alibaba.com>
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

This series builds on top of the new RISC-V IOMMU page table patches:
https://patch.msgid.link/r/0-v3-9dbf0a72a51c+302-iommu_pt_riscv_jgg@nvidia.com

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

 drivers/iommu/generic_pt/fmt/riscv.h | 8 ++++++++
 drivers/iommu/riscv/iommu.c          | 2 ++
 include/linux/generic_pt/common.h    | 4 ++++
 3 files changed, 14 insertions(+)

-- 
2.50.1

