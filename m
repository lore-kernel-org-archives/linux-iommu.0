Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2290A1DDED
	for <iommu@lists.linux.dev>; Thu, 20 Jul 2023 23:30:08 +0000 (UTC)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id AB9B6236EBE2;
	Thu, 20 Jul 2023 16:23:52 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AB9B6236EBE2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1689895432;
	bh=SA9Rg3cMgQ7b1lFGvwN/QhJbcx0qd36JOXDv4dAQXxY=;
	h=From:To:Cc:Subject:Date:From;
	b=cVupQpfkOgBO/eAATTcmC1NeKzfe8T3WsdUXDeZPP7LR4RW3+9TH2nGRt3emkuyYJ
	 Q38NW7QQpLKa1Sn/BKofbm4IIths4zBfi1zkNRXn4/MHO/c26lOcnBj2SGHgnTsxCP
	 rnzqimOFAkzmLzcF671NKwvUXJTiOUFl9SwVTU+U=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
To: stable@vger.kernel.org
Cc: easwar.hariharan@microsoft.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	corbet@lwn.net,
	robin.murphy@arm.com,
	joro@8bytes.org,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Subject: [PATCH 5.15 0/4] ARM64 errata for stable kernel 5.15 and above
Date: Thu, 20 Jul 2023 16:23:30 -0700
Message-Id: <1689895414-17425-1-git-send-email-eahariha@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

From: Easwar Hariharan <easwar.hariharan@microsoft.com>

This series works around a few ARM64 errata. Please pick these up for
v6.1 and v6.4 as well.

Cc: Catalin Marinas <catalin.marinas@arm.com> 
Cc: Will Deacon <will@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: iommu@lists.linux.dev
Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
---
Robin Murphy (1):
  iommu/arm-smmu-v3: Document MMU-700 erratum 2812531

Suzuki K Poulose (3):
  arm64: errata: Add detection for TRBE overwrite in FILL mode
  arm64: errata: Add workaround for TSB flush failures
  arm64: errata: Add detection for TRBE write to out-of-range

 Documentation/arm64/silicon-errata.rst      |  16 +++
 arch/arm64/Kconfig                          | 115 ++++++++++++++++++++
 arch/arm64/include/asm/barrier.h            |  16 ++-
 arch/arm64/kernel/cpu_errata.c              |  65 +++++++++++
 arch/arm64/tools/cpucaps                    |   3 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  41 +++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |   1 +
 7 files changed, 256 insertions(+), 1 deletion(-)

-- 
2.25.1

