Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3060A314A82
	for <iommu@lists.linux.dev>; Wed,  5 Nov 2025 19:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762369604; cv=none; b=VJ5p3FfypiMZ8nIPMG6OtQfWPdbyU8upTku2o+nVRaqJ+ODdFKbxeMcDab4a5/iJJqHNsnOwJs6feYIyDlxcFTTilSuBSa1L1anAdjvdZQydix3ZWl5wn2GUslFzccQ45b3x7OW8SOtzPcafSoO7jh8vCzqiGb1a+r9NsNutO3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762369604; c=relaxed/simple;
	bh=ml7U1rpJGnGnBz5uXhKURx2Le0KM4QUiOupT0ekigfs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kJauubs1Hcv0FiypNbe9KGSg0xD6nfXIW5tsGnbqGcEL03c2X7pJhWDX0AzrgaUtyMxeNetaDYmPIuPXiU8sbTgtrC4Rv6MbA+pLZhsxHwODXBwPsTYt7XyvJoI8JJsz4rhBY4sm/tMEXgLyudbH40Rulr9uR332LNDVMUzZMxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=rUZtdjJL; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="rUZtdjJL"
Received: from DESKTOP-0403QTC.corp.microsoft.com (unknown [20.236.11.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id 56B5B211D8B1;
	Wed,  5 Nov 2025 11:06:41 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 56B5B211D8B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1762369601;
	bh=soKtQEHSTH0EKkfguo3Zbqya4px3IKSED90Pu4k4Nys=;
	h=From:To:Cc:Subject:Date:From;
	b=rUZtdjJLauRH77VLb3VQ8iJu53HrqAd0+lrcMaxXUQoCwvm7DOaLVFY0Xh9YR1jy+
	 Sy3d+aEaO6mMuP9eZJkH3LygkcAeuqjRnR41+vTAuyxl0ZXE4yDkL5dsrv2MGgdjoE
	 emb3mkpyf+RUJMG9sg6+EcyDlIudNkSbRvIxFows=
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
Subject: [PATCH v3 0/2] SMMU v3 CMDQ fix and improvement
Date: Wed,  5 Nov 2025 11:06:36 -0800
Message-Id: <20251105190638.23172-1-jacob.pan@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Will et al,

These two patches address logic issues that occur when SMMU CMDQ spaces
are nearly exhausted at runtime. The problems become more pronounced
when multiple CPUs submit to a single queue, a common scenario under SVA
when shared buffers (used by both CPU and device) are being unmapped.


Thanks,

Jacob 



Alexander Grest (1):
  iommu/arm-smmu-v3: Improve CMDQ lock fairness and efficiency

Jacob Pan (1):
  iommu/arm-smmu-v3: Fix CMDQ timeout warning

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 74 +++++++++++----------
 1 file changed, 40 insertions(+), 34 deletions(-)

-- 
2.43.0

