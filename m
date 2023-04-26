Received: from smtp.smtpout.orange.fr (smtp-25.smtpout.orange.fr [80.12.242.25])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110F5C2CC
	for <iommu@lists.linux.dev>; Wed, 26 Apr 2023 20:33:18 +0000 (UTC)
Received: from pop-os.home ([86.243.2.178])
	by smtp.orange.fr with ESMTPA
	id rlLzpN8gYFuuVrlLzpchLA; Wed, 26 Apr 2023 22:03:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1682539385;
	bh=fL3qIG/GDz0C+Fjp2zZoc/yr7ihwk/lufVhQHBEWF/w=;
	h=From:To:Cc:Subject:Date;
	b=S1ordQppoBepkwZ6IrQWXizCESx+DZQYHJ5zfnEcuY1RAug/mq3IyXyMlS7zN0ybj
	 mZUGklz8nU6NGeus1nAPpRzBAjM/J91uGGwrudzKRqTLn2/egj2MEDqBz2nDroQUqy
	 4M95H14y2HZ3xgHaYoMf08B5MDLcYz20SxFfbgqZrrHxI0Ntpy64XKcDtfYIY/kbjE
	 as8orXJtIxarUoI36RW7BAacOgxuHuXG0FCy9V+nFZslWtY4CA9cpxDZ2dEVPzRMdB
	 GmElCeQfHWK2pLpjB3TAepQa1QpnVzA7koM+VzhH9w8yfRMxzJ4VVGGTvb8TepEcRd
	 mBrkIXTmbXUew==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 26 Apr 2023 22:03:05 +0200
X-ME-IP: 86.243.2.178
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	iommu@lists.linux.dev
Subject: [PATCH] iommu: Use list_count_nodes()
Date: Wed, 26 Apr 2023 22:03:02 +0200
Message-Id: <c4fdffbe6c12c615f79e23e9337cc452f869c8cc.1682539352.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iommu_group_device_count() really looks the same as list_count_nodes(), so
use the latter instead of hand writing it.

One uses list_for_each_entry() and the other list_for_each(), but they
both count the number of nodes in the list.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Un-tested
---
 drivers/iommu/iommu.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 91573efd9488..47f0a709380e 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1126,17 +1126,6 @@ void iommu_group_remove_device(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(iommu_group_remove_device);
 
-static int iommu_group_device_count(struct iommu_group *group)
-{
-	struct group_device *entry;
-	int ret = 0;
-
-	list_for_each_entry(entry, &group->devices, list)
-		ret++;
-
-	return ret;
-}
-
 static int __iommu_group_for_each_dev(struct iommu_group *group, void *data,
 				      int (*fn)(struct device *, void *))
 {
@@ -2083,7 +2072,7 @@ int iommu_attach_device(struct iommu_domain *domain, struct device *dev)
 	 */
 	mutex_lock(&group->mutex);
 	ret = -EINVAL;
-	if (iommu_group_device_count(group) != 1)
+	if (list_count_nodes(&group->devices) != 1)
 		goto out_unlock;
 
 	ret = __iommu_attach_group(domain, group);
@@ -2114,7 +2103,7 @@ void iommu_detach_device(struct iommu_domain *domain, struct device *dev)
 
 	mutex_lock(&group->mutex);
 	if (WARN_ON(domain != group->domain) ||
-	    WARN_ON(iommu_group_device_count(group) != 1))
+	    WARN_ON(list_count_nodes(&group->devices) != 1))
 		goto out_unlock;
 	__iommu_group_set_core_domain(group);
 
-- 
2.34.1

