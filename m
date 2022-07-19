Received: from m15111.mail.126.com (m15111.mail.126.com [220.181.15.111])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0531C04
	for <iommu@lists.linux.dev>; Tue, 19 Jul 2022 13:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=GCVlq
	LoEaaIgAALjbS95tP2uNkJvDM2J9R7TYDiUAHM=; b=DgXYyyJwDAVoxegiTiwUR
	q6HsVsQCT2IEQpzQbusA8oO5pWr0i3m2KXTey2NZ+a4QlgeyifmD+JFLq+yxXR1a
	dEk/9EQn11o8PW24Im8yPs2VFAAvI6lRanbsHMisUvsqrXF6TvhDnqNZTQVpmWca
	bLwyYqegGUn9GQupNMk+8E=
Received: from localhost.localdomain (unknown [124.16.139.61])
	by smtp1 (Coremail) with SMTP id C8mowAB3fzdzqNZiREBlHA--.30928S2;
	Tue, 19 Jul 2022 20:49:56 +0800 (CST)
From: Liang He <windhl@126.com>
To: robdclark@gmail.com,
	will@kernel.org,
	robin.murphy@arm.com,
	joro@8bytes.org,
	iommu@lists.linux.dev,
	linux-arm-msm@vger.kernel.org,
	windhl@126.com
Subject: [PATCH] iommu/arm-smmu: qcom_iommu: Add of_node_put() when breaking out of loop
Date: Tue, 19 Jul 2022 20:49:55 +0800
Message-Id: <20220719124955.1242171-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:C8mowAB3fzdzqNZiREBlHA--.30928S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gr4rZFWkKrWUJF1kCw1fXrb_yoWkGFbEkF
	18Xas3Gr10yrZrAr9FqF43ZrykKws5ZrZxGay8WryrJr17Xr1kJanFqFW8X3yxua1jyFyU
	G3sxAFZ5ArWUXjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRMMa0JUUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbi3BVDF1pED8wxpQAAsU

In qcom_iommu_has_secure_context(), we should call of_node_put()
for the reference 'child' when breaking out of for_each_child_of_node()
which will automatically increase and decrease the refcount.

Fixes: d051f28c8807 ("iommu/qcom: Initialize secure page table")
Signed-off-by: Liang He <windhl@126.com>
---
 drivers/iommu/arm/arm-smmu/qcom_iommu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
index 4a922c7b69ee..b6f90d5b7541 100644
--- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
+++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
@@ -740,8 +740,10 @@ static bool qcom_iommu_has_secure_context(struct qcom_iommu_dev *qcom_iommu)
 	struct device_node *child;
 
 	for_each_child_of_node(qcom_iommu->dev->of_node, child)
-		if (of_device_is_compatible(child, "qcom,msm-iommu-v1-sec"))
+		if (of_device_is_compatible(child, "qcom,msm-iommu-v1-sec")) {
+			of_node_put(child);
 			return true;
+		}
 
 	return false;
 }
-- 
2.25.1

