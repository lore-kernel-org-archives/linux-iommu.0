Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCEF62DF6E3
	for <iommu@lists.linux.dev>; Mon,  8 Dec 2025 21:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765229341; cv=none; b=d364rkk2bArZ2d3Sf6IOC6IYLt+mAHQ4+4128xEqipH09PJvgzUzLdd8szNlnsM4rRBJho7aUaPXPaviADA2+1L3SF8GFqGKXnkwLXChokUYgEAoCMfwS2j/m/BFl13n02bhit+aeHXZKCWOrDScB1NMa1VHkn0AhxXg+AgxtWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765229341; c=relaxed/simple;
	bh=nFInDP3mPNM7J7N5KgSbkGnQVYPRXohLd4vMO6f6jOk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YBZeTWhJ6TM3B6mdxvUTCkJtZxpD9klx+OgpLoloGyFxEp/lqhfBWjI0i8A6Nd2lHvuW4Vlt/bAkUqNdJNmXAkYmmHWXZIlcVaSTZRqUsbZSQmBjQY3gy3a8jgehWU+H3AO8ZDljaXSrGfNJYGzEgR5NWXaOugRckllz7saU5z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=FCUCEKxa; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="FCUCEKxa"
Received: from DESKTOP-0403QTC.corp.microsoft.com (unknown [52.148.138.235])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7B433201D81D;
	Mon,  8 Dec 2025 13:28:58 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7B433201D81D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1765229338;
	bh=ENikNJCcQzEWhl8vRIqUo0vh+vljWMQtBvjD3YN4GlY=;
	h=From:To:Cc:Subject:Date:From;
	b=FCUCEKxaHm2500jsNI05c4FqeaQypI8P78bPCcPrvX4VbpmyAqvHrZdO/UnXPEHU6
	 +d639ZziVZnGyy8HmJIBTwFHBdYdJ+2p/2LzHWffbAMxUyTa2CqjCmdALf7T8lBhMW
	 Kcn8DbEniEkcGxPBKicIOi14CZ+2ZbvE6BiQ/hEE=
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
Subject: [PATCH v5 0/3] SMMU v3 CMDQ fix and improvement
Date: Mon,  8 Dec 2025 13:28:54 -0800
Message-Id: <20251208212857.13101-1-jacob.pan@linux.microsoft.com>
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

Jacob Pan (2):
  iommu/arm-smmu-v3: Parameterize wfe for CMDQ polling
  iommu/arm-smmu-v3: Fix CMDQ timeout warning

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 90 +++++++++++----------
 1 file changed, 49 insertions(+), 41 deletions(-)

-- 
2.43.0

