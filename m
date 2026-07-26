Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D587937C118
	for <iommu@lists.linux.dev>; Sun, 26 Jul 2026 07:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785051829; cv=none; b=IOAGjRAw0slqRLRX+uClD5WWrVx6dxfbAUb00IrL4IhucVp4NKbLu2zIkpHkOhdWnsQNLaoM9LvaeccOFBzT91d2iqtQFcQ3Xjn3nTa5rPOfMi01jTh8TX083fq5yZVJpyiCpx5ch9n9uc8kN3w6vQXzlCJdnh5G3DqZwK/RRKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785051829; c=relaxed/simple;
	bh=rX23anuRm7/SV4zM1LsThFTYYmUKuhtA/Q8SO2mvdSs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DASYZywxkinaDzIrouQXddEoqYs+SqSJn/gA5TKUnUea6ZTdP+SEriaHLKTN0BKgus6qQ4t/4+m1krpAZau82NyDyIbdLgACBn/81mOZx+wJm8RfQlGuZU8hMlAuSg4gUTXu7qv5aocG4pwEpf0n7VGXgFJTs6+lelKe8D2Qca8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=oS1zTu8o; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="oS1zTu8o"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1785051818; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=q0kp//E9FrXAKe+p3yGv6DuibFFV0Uf3nPCQs9TUpjY=;
	b=oS1zTu8o93yA8QrwxPUKessdjAm/H9e4wz/cG4f+s+7NMSdaKlJ90fyRltIfq616XP1xFFzv0MV9z7oPVNBW8ouGGiE2YjYY80FQ0tcZFntSaEUyu5TRzmXVuJYW/WjtPa3HLa64OIKS47UtnhnR/QL8of9xuMDgdd6fQDMtMnY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0X7n2n9p_1785051814;
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0X7n2n9p_1785051814 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 26 Jul 2026 15:43:35 +0800
From: Shuai Xue <xueshuai@linux.alibaba.com>
To: joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	jgg@ziepe.ca,
	kevin.tian@intel.com
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	oliver.yang@linux.alibaba.com,
	zhuo.song@linux.alibaba.com,
	xueshuai@linux.alibaba.com
Subject: [PATCH 0/4] iommu: Fix SVA, iommufd, and iommupt error paths
Date: Sun, 26 Jul 2026 15:43:28 +0800
Message-Id: <cover.1785050951.git.xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes four independent error-path/lifetime issues in the
IOMMU core helpers, iommufd, and generic page table code.

Patch 1 fixes an SVA race where an attach handle becomes visible before
handle->dev is initialized. A racing bind can reuse the handle and later
unbind can dereference a NULL handle->dev.

Patches 2 and 3 fix iommufd reference/lock leaks. Patch 2 avoids taking
an object reference for internal accesses that are skipped by the unmap
notification path. Patch 3 releases the current IOAS rwsem and object
reference if xa_store() fails before the IOAS is inserted into the
unwind list.

Patch 4 fixes the generic page table iova_to_phys() op to return 0 on
range validation failures. Returning a negative errno from a phys_addr_t
function can make callers consume a bogus physical address.

All patches are small fixes with Fixes tags and Cc: stable.

Shuai Xue (4):
  iommu/sva: Set handle->dev before the SVA handle is visible
  iommufd: Avoid locking internal accesses during unmap
  iommufd: Release current IOAS on xa_store() failure
  iommupt: Return zero for invalid iova_to_phys() ranges

 drivers/iommu/generic_pt/iommu_pt.h | 2 +-
 drivers/iommu/iommu-sva.c           | 2 +-
 drivers/iommu/iommufd/device.c      | 4 ++--
 drivers/iommu/iommufd/ioas.c        | 2 ++
 4 files changed, 6 insertions(+), 4 deletions(-)

-- 
2.39.3

