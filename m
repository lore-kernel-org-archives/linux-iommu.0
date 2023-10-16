Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A1726E10
	for <iommu@lists.linux.dev>; Mon, 16 Oct 2023 12:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 506331FB;
	Mon, 16 Oct 2023 05:53:46 -0700 (PDT)
Received: from entos-ampere02.shanghai.arm.com (unknown [10.169.212.212])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4EB523F5A1;
	Mon, 16 Oct 2023 05:53:03 -0700 (PDT)
From: Jia He <justin.he@arm.com>
To: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	nd@arm.com,
	Jia He <justin.he@arm.com>
Subject: [PATCH v3 0/2] fix dma_addressing_limited() if dma_range_map
Date: Mon, 16 Oct 2023 12:52:52 +0000
Message-Id: <20231016125254.1875-1-justin.he@arm.com>
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
v2: https://lore.kernel.org/lkml/20231010020835.3678-1-justin.he@arm.com/
  - refine the subject and commit msg (By Robin Murphy)
  - refactor the checking loop in check_ram_in_range_map() in the pages
    unit to avoid wrap to 0 on 32bits platforms (Robin)
v3:
  - move and export dma_addressing_limited() to avoid adding a new
    exported helper (by Christoph Hellwig)

Jia He (2):
  dma-mapping: export dma_addressing_limited()
  dma-mapping: fix dma_addressing_limited() if dma_range_map can't cover
    all system RAM

 include/linux/dma-mapping.h | 19 ++++--------
 kernel/dma/mapping.c        | 60 +++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+), 14 deletions(-)

-- 
2.25.1

