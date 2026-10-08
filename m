Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30EB26FA4B
	for <iommu@lists.linux.dev>; Thu,  8 Oct 2026 14:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791468029; cv=none; b=fpw8i7wt9HxXtpKuG5v+j8HA+2BnWvgozuRZ14MDTwMnPsrxkNDN7ZR1MOdSzJjhtoHu0nDegiX/O2topzPaAqciNogroq7crbAN6hnr0/ipvvE414eNtOwhTXIq69waMnvvpgkb9oZlMuorfobO07efzsUbwZoYv/iOMsaQf8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791468029; c=relaxed/simple;
	bh=b30BF064L6H8MGZ61C8L/nvtO3ny+4+nYm+uc7KOSKw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Z/XvtZBHuddgDOHOKG5swN4jC+ow0ODN4hmixrRwTYMeWZApnkWAhokyNdK1x7uwcbuQ1mvph7oF3PvENox1V7FKEvU5Wv9lDX241bmByFH5dcL9qE/ySQscoz2jq/j8QnYWZciayIytAZ2Bn5FW/64Cu0eT+qxrhr8c2melPF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=e1eLbpL1; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="e1eLbpL1"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1791468021; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=rZAOc+mYe3cY1Z5TiO6j3GRrj0kPXBVOgAxhQWLGsmQ=;
	b=e1eLbpL19UWneGlOJyaJgIdHJnUTjOHRW+/24skkeDs4DsBaCNf+t8Mfbt70kPWBFBCH/gB9rWiJ7WwXxksBruj1sakeZunc/7sNooBHWF/CetZ6d9j8XOX3WBCVsfh1gvGAo1zKTqRFw32CCh718XrdRWDgsiYKqWGvKKz6YEE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0XCQTvlb_1791468019;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0XCQTvlb_1791468019 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 08 Oct 2026 22:00:20 +0800
From: fangyu.yu@linux.alibaba.com
To: tomasz.jeznach@linux.dev,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	jroedel@suse.de,
	zong.li@sifive.com,
	andrew.jones@oss.qualcomm.com,
	jgg@nvidia.com,
	jgg@ziepe.ca
Cc: fangyu.yu@linux.alibaba.com,
	guoren@kernel.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	kvm-riscv@lists.infradead.org
Subject: [RFC PATCH 0/3] iommu/riscv: Add irqbypass support without MSI page table
Date: Thu,  8 Oct 2026 21:59:58 +0800
Message-Id: <20261008140001.94508-1-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fangyu Yu <fangyu.yu@linux.alibaba.com>

The MSI page table is an optional feature of the RISC-V IOMMU
specification. Hardware without the MSI_FLAT capability has no such
table, and MSI writes from devices are translated by the second-stage
page table like any other DMA.

Since the second-stage page table governs where those MSI writes land,
forwarding is still possible without an MSI page table: map the guest
IMSIC GPA to the host IMSIC HPA in the second-stage domain and device
MSI writes reach the vCPU's interrupt file directly, bypassing the host
MSI path entirely.

This patch implements irqbypass using second-stage page table, so it
is a functional supplement for IOMMU without MSI page table.

This series is based on Andrew Jones' v3 irqbypass support series [1]

[1] https://lore.kernel.org/linux-riscv/20260928143113.49838-1-andrew.jones@oss.qualcomm.com/

Fangyu Yu (3):
  iommu/riscv: Add guest IMSIC GPA mapping helpers
  iommu/riscv: Extract IRQ forwarding payload validation
  iommu/riscv: Support IRQ forwarding without MSI page tables

 drivers/iommu/riscv/iommu-ir.c | 179 +++++++++++++++++++++++++++++++--
 drivers/iommu/riscv/iommu.c    |  94 +++++++++++++++++
 drivers/iommu/riscv/iommu.h    |  12 +++
 3 files changed, 276 insertions(+), 9 deletions(-)

-- 
2.50.1

