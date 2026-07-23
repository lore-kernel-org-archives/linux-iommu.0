Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B3326A0A7
	for <iommu@lists.linux.dev>; Thu, 23 Jul 2026 14:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784816393; cv=none; b=YjTGhlMccc+qFqXqDF6sM9P8wJJy+SHotOwTORugc5bhULvXwgfftTQ5oFOZarlglfN+ewhEaxfU7e6UT1N+VoU7rG1Z9mSqnjXd7ykJu+WTck9iKypAUdnYjTJdnIEVn57TTsRgAiIGex5xvwO6P8sjGURNVlADl9XqH53Qa9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784816393; c=relaxed/simple;
	bh=xotGZCcqGk4Abt5amgAtbtEB69CUE008GfZhtAtUor8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VT6kumw5oWQlqc1++bFR7e/F1z+TAjtxKngjOS5K9vYhhf39zUgyVpv80G0r/0V0sW46z7rIuecHVA4c/I14Q3fsG4HhxFsCERYyHKnQQAR2DpkrvJUwaa+oVmtrv1ETm1KDdxN3SxSrhQ3rkRytiYF3TDKBb/8N6rZ6WnR3WdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=vTsWg/h+; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="vTsWg/h+"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 07B471477;
	Thu, 23 Jul 2026 07:19:46 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 091D03F59E;
	Thu, 23 Jul 2026 07:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784816390; bh=xotGZCcqGk4Abt5amgAtbtEB69CUE008GfZhtAtUor8=;
	h=From:To:Cc:Subject:Date:From;
	b=vTsWg/h+6NaqsdqnazNd81BA5VKVRkVpxobgONsG0oHUSLSI7QJZRRM3uUKG7XOpl
	 O0BqmyIr2Y5SqrV1ITi890y+nUIEvHiHl2o40kuE6r/YBOvx4gXuS/6VAktN+VEDsv
	 fLCgQwEX2sgTtE547hUgAlXJ1owsHwvWTYoZ7FII=
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org,
	catalin.marinas@arm.com,
	joro@8bytes.org
Cc: jpb@kernel.org,
	jgg@nvidia.com,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 0/2] iommu/arm-smmu-v3: Fix SVA vs. HAFT issues
Date: Thu, 23 Jul 2026 15:19:42 +0100
Message-ID: <cover.1784814923.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.54.0.dirty
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v1: https://lore.kernel.org/all/878cd6bcbbe2d5677d2f63da13294c148268552c.1782927917.git.robin.murphy@arm.com/

Per the discussion on v1, the aim here is just to make things safe and
functionally correct for now, and now with a command-line option for
distro users to get themselves out of a corner if they really need to,
I think that's reasonable enough for HAFT being a very new feature.

Thanks,
Robin.


Robin Murphy (2):
  arm64: Add override for MMFR1.HAFDBS
  iommu/arm-smmu-v3: Add HAFT support for SVA

 Documentation/admin-guide/kernel-parameters.txt | 3 +++
 arch/arm64/kernel/pi/idreg-override.c           | 2 ++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 5 +++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c     | 9 ++++++++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h     | 3 +++
 5 files changed, 21 insertions(+), 1 deletion(-)

-- 
2.54.0.dirty

