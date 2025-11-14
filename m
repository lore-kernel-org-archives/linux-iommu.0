Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651F12BEC22
	for <iommu@lists.linux.dev>; Fri, 14 Nov 2025 17:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763140642; cv=none; b=oGoR0zpw8AOXqEBMhsymMggXsafLfVJ5xz/7G1dei+HemFYKUKyy1vXeIKs4rbOkDnd+LHD6c2MBeXuZdYZHXyneGJsrg0wrlCCb1EPEZBg7LI7hrnGI0WllPPF8WYS2SGxrBUQtIHu9jIIIb2hLTDcrU3VSgpwisxNjR8RFoPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763140642; c=relaxed/simple;
	bh=gAq2buTxZSVFTH91MZ3zQkGjXmp3rZfGBl2s8pwH/gY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sa4qZLS4kZfBCPOFw2DjlmfBX3VBDhwRPQ1UTBWes92WPjaknmmuoycVDaDiE3879kcmMTpo+eyXjYIJJLN/V18AWPfAns6vIY5fJbhf4wwdtRueId5HPqZSdEW/UqnQ/QFftJfv7UaSPn0T7GqrK27Cvlzv/DXOWEGzOlGidXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=YrUjOpjq; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="YrUjOpjq"
Received: from DESKTOP-0403QTC.corp.microsoft.com (unknown [20.236.11.102])
	by linux.microsoft.com (Postfix) with ESMTPSA id 58976201AE5A;
	Fri, 14 Nov 2025 09:17:20 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 58976201AE5A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1763140640;
	bh=JCff6g9uda7lsIqptMpfRdmqluxHFqgcSao2IfacIeA=;
	h=From:To:Cc:Subject:Date:From;
	b=YrUjOpjqikUgV4DMUfw5d5PsiWg9zvHGwA6lyQ8Wp3+lMP1i9GCnEFLrUmvIFResQ
	 WnA0+mtIxyo0jwLxznfIGlecArgRPmopKrDMEkE9c9seDjwWpCugLx/8rEvqE4NfMf
	 DRmtN40+wPhOM3ECdinp5JqvcLmVudOa17dbqR5c=
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
Subject: [PATCH v4 0/2] SMMU v3 CMDQ fix and improvement
Date: Fri, 14 Nov 2025 09:17:16 -0800
Message-Id: <20251114171718.42215-1-jacob.pan@linux.microsoft.com>
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

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 72 +++++++++++----------
 1 file changed, 37 insertions(+), 35 deletions(-)

-- 
2.43.0

