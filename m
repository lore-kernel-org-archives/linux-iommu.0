Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF57FEB1B
	for <iommu@lists.linux.dev>; Thu, 19 Jan 2023 19:18:50 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AB47E1BCA;
	Thu, 19 Jan 2023 11:19:25 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 434B13F67D;
	Thu, 19 Jan 2023 11:18:43 -0800 (PST)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org,
	will@kernel.org
Cc: hch@lst.de,
	jgg@nvidia.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] iommu: Factor out a "first device in group" helper
Date: Thu, 19 Jan 2023 19:18:21 +0000
Message-Id: <592bff75a7fc4d50d5b2435a09dfff19f1072973.1673978700.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.36.1.dirty
In-Reply-To: <cover.1673978700.git.robin.murphy@arm.com>
References: <cover.1673978700.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This pattern for picking the first device out of the group list is
repeated a few times now, so it's clearly worth factoring out.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/iommu.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index bc53ffbba4de..5b37766a09e2 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1084,6 +1084,11 @@ void iommu_group_remove_device(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(iommu_group_remove_device);
 
+static struct device *iommu_group_first_dev(struct iommu_group *group)
+{
+	return list_first_entry(&group->devices, struct group_device, list)->dev;
+}
+
 static int iommu_group_device_count(struct iommu_group *group)
 {
 	struct group_device *entry;
@@ -2835,7 +2840,6 @@ static int iommu_change_dev_def_domain(struct iommu_group *group,
 				       struct device *prev_dev, int type)
 {
 	struct iommu_domain *prev_dom;
-	struct group_device *grp_dev;
 	int ret, dev_def_dom;
 	struct device *dev;
 
@@ -2867,8 +2871,7 @@ static int iommu_change_dev_def_domain(struct iommu_group *group,
 	}
 
 	/* Since group has only one device */
-	grp_dev = list_first_entry(&group->devices, struct group_device, list);
-	dev = grp_dev->dev;
+	dev = iommu_group_first_dev(group);
 
 	if (prev_dev != dev) {
 		dev_err_ratelimited(prev_dev, "Cannot change default domain: Device has been changed\n");
@@ -2965,7 +2968,6 @@ static int iommu_change_dev_def_domain(struct iommu_group *group,
 static ssize_t iommu_group_store_type(struct iommu_group *group,
 				      const char *buf, size_t count)
 {
-	struct group_device *grp_dev;
 	struct device *dev;
 	int ret, req_type;
 
@@ -3000,8 +3002,7 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
 	}
 
 	/* Since group has only one device */
-	grp_dev = list_first_entry(&group->devices, struct group_device, list);
-	dev = grp_dev->dev;
+	dev = iommu_group_first_dev(group);
 	get_device(dev);
 
 	/*
@@ -3126,21 +3127,18 @@ void iommu_device_unuse_default_domain(struct device *dev)
 
 static int __iommu_group_alloc_blocking_domain(struct iommu_group *group)
 {
-	struct group_device *dev =
-		list_first_entry(&group->devices, struct group_device, list);
+	struct device *dev = iommu_group_first_dev(group);
 
 	if (group->blocking_domain)
 		return 0;
 
-	group->blocking_domain =
-		__iommu_domain_alloc(dev->dev->bus, IOMMU_DOMAIN_BLOCKED);
+	group->blocking_domain = __iommu_domain_alloc(dev->bus, IOMMU_DOMAIN_BLOCKED);
 	if (!group->blocking_domain) {
 		/*
 		 * For drivers that do not yet understand IOMMU_DOMAIN_BLOCKED
 		 * create an empty domain instead.
 		 */
-		group->blocking_domain = __iommu_domain_alloc(
-			dev->dev->bus, IOMMU_DOMAIN_UNMANAGED);
+		group->blocking_domain = __iommu_domain_alloc(dev->bus, IOMMU_DOMAIN_UNMANAGED);
 		if (!group->blocking_domain)
 			return -EINVAL;
 	}
-- 
2.36.1.dirty

