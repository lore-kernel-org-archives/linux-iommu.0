Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC121F09AD
	for <iommu@lists.linux.dev>; Sun,  8 Feb 2026 14:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770561746; cv=none; b=n8IYz86G5+25+SykkcZg0hPYXCQm8L3Ri7sKGXwt3qPB81doZFypL7VBUJkUZ9A5zD5PbT7qvFbymmRXrG7b72KBbE6b47Dnyv/VDSfOHHzD1FKWzN4d/jsIakmBYC3JgkODbZk9/a4KD//U6gPZhUbBPld4KVVwpAN9JYqGNgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770561746; c=relaxed/simple;
	bh=uQNCMIejCFMybMdP04uk4/a0U/aKySltIw8fzAwGPLI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TSUY5E73S5rQOxIdBXyCOzEIZ+ljLNcJ96wMDptqOcg4J6XNmcDJemAeqo/kovNBgyJsn/Zsswr8OkkoOIRxBXpSbuvyYPhnSX27zD1syG56HgzJraBpjYBjB2CxFrRKLFjTkJXt8Qt70mmB1TvcXmpAsGWXmf+YAaGl1F/bqrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=lHjwjZfM; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="lHjwjZfM"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1770561743; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=dZsF7c/aL+ja/nJWbNKTWO6qdxxmo/bPtv/d90lMG5U=;
	b=lHjwjZfMlvWrOiuXlC6FOz+hBZjrKDN7NbuYt1TDeFkfESWaOdId4bF3gt4ggjEPXY2o4TcOD+8xE55CTbQU2RohFaUBpgdHV7v+KoUi/NOEyxsBK+014IdaleizKCRKqz1EkJdxlycvEXiGhEi9ftyLt2S6RIrL8JVQ124q/p0=
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0WylHpC7_1770561740 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 08 Feb 2026 22:42:22 +0800
From: fangyu.yu@linux.alibaba.com
To: tjeznach@rivosinc.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	andrew.jones@oss.qualcomm.com
Cc: guoren@kernel.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Fangyu Yu <fangyu.yu@linux.alibaba.com>
Subject: [PATCH 0/2] iommu/riscv: support range and non-leaf IOTLB invalidation
Date: Sun,  8 Feb 2026 22:42:11 +0800
Message-Id: <20260208144213.94856-1-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fangyu Yu <fangyu.yu@linux.alibaba.com>

This series adds support for two RISC-V IOMMU v1.0.1 invalidation extensions in
the RISC-V IOMMU driver:

  - Address Range Invalidation (capabilities.S), which allows encoding a NAPOT
    address range in the IOTINVAL.{VMA,GVMA} ADDR operand when the S bit is set,
    reducing the number of invalidation commands for large or superpage-backed
    mappings.

  - Non-leaf PTE Invalidation (capabilities.NL), which allows IOTINVAL.VMA with
    AV=1 and NL=1 to invalidate cached non-leaf PTE information for the given
    IOVA, addressing cases where updating mappings replaces a non-leaf entry.

Patch 1 introduces the missing capability/operand definitions and switches the
IOTLB invalidation path to use NAPOT range invalidations when supported.

Patch 2 adds the NL capability/operand definitions and extends the invalidation
path to optionally request non-leaf invalidation. When map_pages() replaces
non-leaf page-table entries, the driver invalidates the affected IOVA range with
non-leaf semantics.

No functional changes are expected on hardware that does not advertise these
capabilities; the driver continues to fall back to the existing invalidation
behavior.

Fangyu Yu (2):
  iommu/riscv: Add NAPOT range invalidation support for IOTINVAL
  iommu/riscv: Add non-leaf invalidation support

 drivers/iommu/riscv/iommu-bits.h |  17 +++++
 drivers/iommu/riscv/iommu.c      | 111 +++++++++++++++++++++++++++++--
 2 files changed, 124 insertions(+), 4 deletions(-)

-- 
2.50.1

