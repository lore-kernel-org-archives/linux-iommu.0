Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C27280329
	for <iommu@lists.linux.dev>; Sat, 11 Apr 2026 02:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775874158; cv=none; b=UNElrN/taHCQmO5JHNdW+anNkuiiuGnMzMhB5wOyM5vW2ryG4GAK2vANkF4gWHJ+08hgQ+1x1RTxIa18KHCSExJdZo886dif9wE78WuYqxAxDe74g3OlcfvVA09pRQ39ZtaG6hCH/BNh0RvBmAu2oU1iDoaB51ucgvzex0pFZ3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775874158; c=relaxed/simple;
	bh=M9HhZeC0XLaaiy0Flp4HbgH8X5/5aJ5iImyy9KKucKU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kXWwLNfvSPqcs6V9EMWwAdAfJnepUfU+wZlsMfAMAQ7Rqu4UOPhZ7lrsG/z5Q3joLGdCTMFXHzO+rJN1Nk9etDM0nethc7OqRL5qvJiOCEkoxJWr6AQHO0RS8JQE1KKSqxwppAJNYGVcMYh0s3SFUumYCPdRWKynWL9at8go4eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=EJFiq69E; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="EJFiq69E"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1775874149; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=srznzHOaf7pJe5RveLZK1Z8x+0sCvPrzabLNg0ujS6M=;
	b=EJFiq69EAoktDtXRV5CV6TjDPwlpfUVjMD92YILpFOU0aSbSDC/7AHOk2uH1sQZkVsJdmPmDxd0yTEdlX9VYMn0U53sB5SeCas3mVnMagP1KOP7OYrQmIKLq8RyJ7BL6cBfofX+V5No5KQDqP8SNH+utXyrrS6Fyqy12US+Hd4w=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0X0miYQU_1775874145;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0X0miYQU_1775874145 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 11 Apr 2026 10:22:28 +0800
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
Subject: [PATCH 0/2] iommu/riscv: Support Svpbmt memory types in generic_pt
Date: Sat, 11 Apr 2026 10:22:21 +0800
Message-Id: <20260411022223.91029-1-fangyu.yu@linux.alibaba.com>
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

Fangyu Yu (2):
  iommu/riscv: Advertise Svpbmt support to generic page table
  iommupt: Encode IOMMU_MMIO/IOMMU_CACHE via RISC-V Svpbmt bits

 drivers/iommu/generic_pt/fmt/riscv.h | 9 +++++++++
 drivers/iommu/riscv/iommu.c          | 2 ++
 include/linux/generic_pt/common.h    | 1 +
 3 files changed, 12 insertions(+)

-- 
2.50.1

