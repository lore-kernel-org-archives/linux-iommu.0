Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A596D22259B
	for <iommu@lists.linux.dev>; Mon, 20 Oct 2025 22:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761000239; cv=none; b=Hh8opHY7bevhc9IwtFWnD65Mdlu67Uq9mCYBiRiYx1wS3Gz531mG27bsUIEtdVZ3Uq+pcgT+xenenZx8adKj5yn5UhvJCW/nDTuuE1/75t69Vdih1xtdIs8ZICYqhKJZavw6jyvdERkpZgyg0La2ENWGsO6djmlynKQTi11NxGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761000239; c=relaxed/simple;
	bh=4vwBQXMF89yRgenBAM8z1rVKwRuGAGV2j0K6ZHxJ5yo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sy3naKIcSf8VUoeQ4kcfoS46PyXpgjw06PiilzmTHrvPK+ZB3gzWZKYrLJD8l+5jwXOOMz7ZypNbcynkmUMNjSisr2Thk8WmNnBphuH5o4hpdl635lOjStEn6ChXM/jWViG6ipW+0Asw+ap6kXvy6+bOg2487JWV2QB+8WazIT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=YJUYGL1+; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="YJUYGL1+"
Received: from DESKTOP-0403QTC.corp.microsoft.com (unknown [20.236.10.163])
	by linux.microsoft.com (Postfix) with ESMTPSA id AABE6201DAC1;
	Mon, 20 Oct 2025 15:43:55 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AABE6201DAC1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1761000235;
	bh=Pk+hmvk+GZ5gPHSTP84Aa7rETr4kHC1bVEeC2ISi53U=;
	h=From:To:Cc:Subject:Date:From;
	b=YJUYGL1+86ATh0+gbWGw6dNvUeCOm6FyRKRR6mTZ6eNKIuM6OrRQDRDufNVF29ee8
	 KrVPAPN3KqD3oyYjqbAtRrRTL10e8ltpbsGmGlFkUUZPRgfL5EoLYrZjSdCdHUQIWN
	 dFxcUa68HoGLJJr0UKN7Yy5PUQFB4kTAytJ5LloM=
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: linux-kernel@vger.kernel.org,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Mostafa Saleh <smostafa@google.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Cc: Jacob Pan <jacob.pan@linux.microsoft.com>,
	Zhang Yu <zhangyu1@linux.microsoft.com>,
	Jean Philippe-Brucker <jean-philippe@linaro.org>,
	Alexander Grest <Alexander.Grest@microsoft.com>
Subject: [PATCH v2 0/2] SMMU v3 CMDQ fix and improvement
Date: Mon, 20 Oct 2025 15:43:51 -0700
Message-Id: <20251020224353.1408-1-jacob.pan@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Will et al,

These two patches are derived from testing SMMU driver with smaller CMDQ
sizes where we see soft lockups.

This happens on HyperV emulated SMMU v3 as well as baremetal ARM servers
with artificially reduced queue size and microbenchmark to stress test
concurrency.

Thanks,

Jacob 

Alexander Grest (1):
  iommu/arm-smmu-v3: Improve CMDQ lock fairness and efficiency

Jacob Pan (1):
  iommu/arm-smmu-v3: Fix CMDQ timeout warning

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 97 ++++++++++-----------
 1 file changed, 47 insertions(+), 50 deletions(-)

-- 
2.43.0

