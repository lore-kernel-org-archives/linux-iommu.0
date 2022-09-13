Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5649D320D
	for <iommu@lists.linux.dev>; Tue, 13 Sep 2022 11:47:27 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CFAF51063;
	Tue, 13 Sep 2022 04:47:32 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 83A163F71A;
	Tue, 13 Sep 2022 04:47:25 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org
Cc: will@kernel.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Thierry Reding <thierry.reding@gmail.com>,
	John Garry <john.garry@huawei.com>
Subject: [PATCH] iommu/iova: Fix module config properly
Date: Tue, 13 Sep 2022 12:47:20 +0100
Message-Id: <548c2f683ca379aface59639a8f0cccc3a1ac050.1663069227.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.36.1.dirty
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IOMMU_IOVA is intended to be an optional library for users to select as
and when they desire. Since it can be a module now, this means that
built-in code which has chosen not to select it should not fail to link
if it happens to have selected as a module by someone else. Replace
IS_ENABLED() with IS_REACHABLE() to do the right thing.

CC: Thierry Reding <thierry.reding@gmail.com>
Reported-by: John Garry <john.garry@huawei.com>
Fixes: 15bbdec3931e ("iommu: Make the iova library a module")
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

Phrased as a fix for the sake of complete honesty, but it seems
everyone's been making do for years already so by now it's really
just more of an enhancement.

 include/linux/iova.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/iova.h b/include/linux/iova.h
index 8f97a43be834..fe18c3e6a725 100644
--- a/include/linux/iova.h
+++ b/include/linux/iova.h
@@ -75,7 +75,7 @@ static inline unsigned long iova_pfn(struct iova_domain *iovad, dma_addr_t iova)
 	return iova >> iova_shift(iovad);
 }
 
-#if IS_ENABLED(CONFIG_IOMMU_IOVA)
+#if IS_REACHABLE(CONFIG_IOMMU_IOVA)
 int iova_cache_get(void);
 void iova_cache_put(void);
 
-- 
2.36.1.dirty

