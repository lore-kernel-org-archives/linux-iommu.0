Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B71C10E1
	for <iommu@lists.linux.dev>; Tue, 21 Jun 2022 15:14:39 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EF2301688;
	Tue, 21 Jun 2022 08:14:38 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BE5213F66F;
	Tue, 21 Jun 2022 08:14:37 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org,
	will@kernel.org
Cc: iommu@lists.linux-foundation.org,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/3] iommu: Use dev_iommu_ops() for probe_finalize
Date: Tue, 21 Jun 2022 16:14:25 +0100
Message-ID: <5fe4b0ce22f676f435d332f2b2828dc7ef848a19.1655822151.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.36.1.dirty
In-Reply-To: <cover.1655822151.git.robin.murphy@arm.com>
References: <cover.1655822151.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <20220621151425.lWem1QA37dzkz7NRYgzQA6jHp4U4cr9xM_bWf8OXWZ4@z>

The ->probe_finalize hook only runs after ->probe_device succeeds,
so we can move that over to the new dev_iommu_ops() as well.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 847ad47a2dfd..06d6989f07f6 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -272,7 +272,7 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 
 int iommu_probe_device(struct device *dev)
 {
-	const struct iommu_ops *ops = dev->bus->iommu_ops;
+	const struct iommu_ops *ops;
 	struct iommu_group *group;
 	int ret;
 
@@ -313,6 +313,7 @@ int iommu_probe_device(struct device *dev)
 	mutex_unlock(&group->mutex);
 	iommu_group_put(group);
 
+	ops = dev_iommu_ops(dev);
 	if (ops->probe_finalize)
 		ops->probe_finalize(dev);
 
-- 
2.36.1.dirty

