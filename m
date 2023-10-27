Received: from mail.valinux.co.jp (mail.valinux.co.jp [210.128.90.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0881139842
	for <iommu@lists.linux.dev>; Fri, 27 Oct 2023 16:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from localhost (localhost [127.0.0.1])
	by mail.valinux.co.jp (Postfix) with ESMTP id D82FDA95E5;
	Sat, 28 Oct 2023 01:30:59 +0900 (JST)
X-Virus-Scanned: Debian amavisd-new at valinux.co.jp
Received: from mail.valinux.co.jp ([127.0.0.1])
	by localhost (mail.valinux.co.jp [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9hqLDIYGL-8R; Sat, 28 Oct 2023 01:30:59 +0900 (JST)
Received: from z790sl.. (KD111097181081.ppp-bb.dion.ne.jp [111.97.181.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.valinux.co.jp (Postfix) with ESMTPSA id AAFFBA95DE;
	Sat, 28 Oct 2023 01:30:59 +0900 (JST)
From: Koichiro Den <den@valinux.co.jp>
To: iommu@lists.linux.dev
Cc: jgg@ziepe.ca,
	kevin.tian@intel.com,
	Koichiro Den <den@valinux.co.jp>
Subject: [PATCH] iommufd: Fix missing update of domains_itree after splitting iopt_area
Date: Sat, 28 Oct 2023 01:29:42 +0900
Message-ID: <20231027162941.2864615-2-den@valinux.co.jp>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In iopt_area_split(), if the original iopt_area has filled a domain and
is linked to domains_itree, pages_nodes have to be properly reinserted.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/iommu/iommufd/io_pagetable.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
index 9f060abe53b6..5ba83296c91a 100644
--- a/drivers/iommu/iommufd/io_pagetable.c
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -1220,6 +1220,13 @@ static int iopt_area_split(struct iopt_area *area, unsigned long iova)
 	if (WARN_ON(rc))
 		goto err_remove_lhs;
 
+	/* If the original area has filled a domain, domains_itree has to be updated. */
+	if (!RB_EMPTY_NODE(&area->pages_node.rb)) {
+		interval_tree_remove(&area->pages_node, &pages->domains_itree);
+		interval_tree_insert(&lhs->pages_node, &pages->domains_itree);
+		interval_tree_insert(&rhs->pages_node, &pages->domains_itree);
+	}
+
 	lhs->storage_domain = area->storage_domain;
 	lhs->pages = area->pages;
 	rhs->storage_domain = area->storage_domain;
-- 
2.41.0

