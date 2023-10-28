Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5978291D
	for <iommu@lists.linux.dev>; Sat, 28 Oct 2023 10:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 552BF1424;
	Sat, 28 Oct 2023 03:21:53 -0700 (PDT)
Received: from entos-ampere02.shanghai.arm.com (unknown [10.169.212.228])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3F7E73F64C;
	Sat, 28 Oct 2023 03:21:08 -0700 (PDT)
From: Jia He <justin.he@arm.com>
To: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	nd@arm.com,
	Jia He <justin.he@arm.com>
Subject: [PATCH v4 0/2] fix dma_addressing_limited() if dma_range_map
Date: Sat, 28 Oct 2023 10:20:57 +0000
Message-Id: <20231028102059.66891-1-justin.he@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is to fix the hangs at boot. The root cause is the nvme device dma
mapping is failed in the checking path of phys_to_dma() since
dma_max_mapping_size() gave the wrong answer to start with.

---
Changelog:
v1: https://lore.kernel.org/all/20230912084002.2168-1-justin.he@arm.com/
v2:
https://lore.kernel.org/lkml/20231010020835.3678-1-justin.he@arm.com/
  - refine the subject and commit msg (By Robin Murphy)
  - refactor the checking loop in check_ram_in_range_map() in the pages
    unit to avoid wrap to 0 on 32bits platforms (Robin)
v3:
https://lore.kernel.org/lkml/20231016125254.1875-1-justin.he@arm.com/
  - move and export dma_addressing_limited() to avoid adding a new
    exported helper (by Christoph Hellwig)
v4:
  - refine the commit msg in patch01
  - address patch02 coding style issues
  - add the dma ops check in dma_addressing_limited() (Christoph) 
  - move dma_direct_all_ram_mapped() to direct.c (Christoph)

Jia He (2):
  dma-mapping: move dma_addressing_limited() out of line
  dma-mapping: fix dma_addressing_limited() if dma_range_map can't cover
    all system RAM

 include/linux/dma-mapping.h | 19 +++++------------
 kernel/dma/direct.c         | 41 +++++++++++++++++++++++++++++++++++++
 kernel/dma/direct.h         |  1 +
 kernel/dma/mapping.c        | 23 +++++++++++++++++++++
 4 files changed, 70 insertions(+), 14 deletions(-)

-- 
2.25.1

