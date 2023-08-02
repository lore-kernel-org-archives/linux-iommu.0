Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE2979FF
	for <iommu@lists.linux.dev>; Wed,  2 Aug 2023 17:09:19 +0000 (UTC)
Received: from rrs24-12-35.corp.microsoft.com (unknown [131.107.147.181])
	by linux.microsoft.com (Postfix) with ESMTPSA id E1D3F238C432;
	Wed,  2 Aug 2023 10:09:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E1D3F238C432
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1690996159;
	bh=34PwN6LabNXeFf++2y+BLpbiwBMV7JSsPbGv6UCAaSw=;
	h=From:To:Cc:Subject:Date:From;
	b=XRzNVaSQ4ySOx7wyo3Mll6BVJmW7zsC91pHcJ9VLU4XAv3DJED05WO/2LPWJRtLQ4
	 yxJlFF7405ukJMEk85abNHR46tnmD7h4BmMydMgUTcNiK00X1eLFhECuMsFhiePa6J
	 k0C3KJfyvyEWQowCFETmuYlqXa8hlEEUt099Hoa8=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
To: stable@vger.kernel.org
Cc: easwar.hariharan@microsoft.com,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Subject: [PATCH v2 6.1 0/4] ARM SMMUv3 errata for 6.1
Date: Wed,  2 Aug 2023 17:09:07 +0000
Message-Id: <20230802170911.1593275-1-eahariha@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: iommu@lists.linux.dev

Changelog:
==========
v1 -> v2:
 - Backport other relevant errata patches from the same series as MMU-700 erratum 2812531
 - v1 link: https://lore.kernel.org/stable/20230724185107.1675882-1-eahariha@linux.microsoft.com/T/#u

Robin Murphy (4):
  iommu/arm-smmu-v3: Work around MMU-600 erratum 1076982
  iommu/arm-smmu-v3: Document MMU-700 erratum 2812531
  iommu/arm-smmu-v3: Add explicit feature for nesting
  iommu/arm-smmu-v3: Document nesting-related errata

 Documentation/arm64/silicon-errata.rst      |  4 ++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 50 +++++++++++++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  8 ++++
 3 files changed, 62 insertions(+)

-- 
2.25.1

