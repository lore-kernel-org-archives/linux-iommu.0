Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5113615C0
	for <iommu@lists.linux.dev>; Fri,  8 Nov 2024 18:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731090627; cv=none; b=l04x0GIujFgrpk9wGG270oAv6h/hNwzokQXFt/UbrhH5BO0ASAxuZ1rimR7zeFzQZuYy+HFndML5ZBI2Aa2fHJGgZ7mDKIAphYqCrR33qc8TnxKcOOvxX6Pox7rvQYmuSjs8JwE8lIiBwBpGmH7RngxpU4Sx2LFcQ2HHNsl2i+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731090627; c=relaxed/simple;
	bh=dDleA5uOP0s0HOuHKtbRQ7li9mRsWf8fsdo+Iot3J8E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OTvaaxLvxOnb4UcCHSufhkDhLGzSo841JHZ/rCYvAL2i+1jTVqsrCU/piUQxsv+nqQMA2SKwKSak8RJg8xnas51OjF0bNnQiV2aVw9iCLphmhe30yXC+imj3YAeJSCfUsSQFlzm4WvbgVqxOB53I7I/lHCw5eUG6BnQS6HxcFyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F0D2A497;
	Fri,  8 Nov 2024 10:30:53 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2DF633F6A8;
	Fri,  8 Nov 2024 10:30:23 -0800 (PST)
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org,
	joro@8bytes.org
Cc: iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/3] iommu/arm-smmu: Minor probe_device related improvements
Date: Fri,  8 Nov 2024 18:30:14 +0000
Message-Id: <cover.1731088789.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

Just a few tweaks to the SMMU drivers and core code which have fallen
out of some hacking on the __iommu_probe_device() path.

Cheers,
Robin.



Robin Murphy (3):
  iommu/arm-smmu: Make instance lookup robust
  iommu/arm-smmu-v3: Clean up iopf queue on probe failure
  iommu: Manage driver probe deferral better

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 19 ++++++++-----
 drivers/iommu/arm/arm-smmu/arm-smmu.c       | 31 ++++++++++-----------
 drivers/iommu/iommu.c                       |  2 +-
 drivers/iommu/of_iommu.c                    |  2 --
 4 files changed, 27 insertions(+), 27 deletions(-)

-- 
2.39.2.101.g768bb238c484.dirty

