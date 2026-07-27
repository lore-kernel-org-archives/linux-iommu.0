Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C56392C2F
	for <iommu@lists.linux.dev>; Mon, 27 Jul 2026 12:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785153819; cv=none; b=k5p8ie+OWGnG0KFkgbuNyijMdZH3zyktiI7c0FuvpRWlj1QKe9W8Fa+Kbto891Kx6i/h8pxc87kM/CApJOdwvOOKEdLykp38lVcO087jQPu9WMAW9AyR0nXmWMIJlgL4m0SetCMHoY828Ly+kkZ8b9XnckFrIQIAA6HDwaOsa3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785153819; c=relaxed/simple;
	bh=UuZ5SNCWn87Voxt+QpWuTLGoK25xwa8suwRocSvq+Hk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qtgYxIAlcz3/6bCUyFGQnG1L4J7QFJVpVH5hk9xzSyv8iis2BE9U9du1g6WazZIBh7NDYy+CL08BJcExw9/ZavGvld8eGcryNrf0tMfF3YccCTO8pAoAmVFNRp9XyxUu2Rl+13dffvQ6sapaP42p8eiWtGVkfNkhUWJyF1gpWzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=dCinzq0C; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="dCinzq0C"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 17DC3143D;
	Mon, 27 Jul 2026 05:03:32 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3847A3F86F;
	Mon, 27 Jul 2026 05:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785153816; bh=UuZ5SNCWn87Voxt+QpWuTLGoK25xwa8suwRocSvq+Hk=;
	h=From:To:Cc:Subject:Date:From;
	b=dCinzq0CNKlyA2GBwBXlZL1JJGGe8RTvzTBN4JxAwVMBbKgSn1lIqxfhnsfiDgoR0
	 s/Cq6FpE9cCv62ZQsXlc5n/Zo0XOOCN7SJj7KHYKeNpGGVA6aLDsNgqiNTE5VpU2HM
	 QTobcbGVRIJ8ZsEwhiF1PKXYeSVVx2hTc4T8nnaQ=
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org,
	catalin.marinas@arm.com,
	joro@8bytes.org
Cc: jpb@kernel.org,
	jgg@nvidia.com,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 0/2] iommu/arm-smmu-v3: Fix SVA vs. HAFT issues
Date: Mon, 27 Jul 2026 13:03:27 +0100
Message-ID: <cover.1785153415.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.54.0.dirty
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v1: https://lore.kernel.org/all/878cd6bcbbe2d5677d2f63da13294c148268552c.1782927917.git.robin.murphy@arm.com/
v2: https://lore.kernel.org/all/cover.1784814923.git.robin.murphy@arm.com/

Further to v2, work around the contentious CD update.

Thanks,
Robin.


Robin Murphy (2):
  arm64: Add override for MMFR1.HAFDBS
  iommu/arm-smmu-v3: Add HAFT support for SVA

 .../admin-guide/kernel-parameters.txt         |  3 +++
 arch/arm64/kernel/pi/idreg-override.c         |  2 ++
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 24 +++++++++++--------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  9 ++++++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  3 +++
 5 files changed, 30 insertions(+), 11 deletions(-)

-- 
2.54.0.dirty

