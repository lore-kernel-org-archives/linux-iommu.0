From: Dmitry Safonov <dima@arista.com>
Subject: [RFC 2/3] iommu/iova: Make free_iova() atomic
Date: Thu, 21 Jun 2018 19:08:22 +0100
Message-ID: <20180621180823.805-3-dima@arista.com>
References: <20180621180823.805-1-dima@arista.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180621180823.805-1-dima@arista.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Dmitry Safonov <dima@arista.com>, David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org, Dmitry Safonov <0x7f454c46@gmail.com>
List-Id: iommu@lists.linux-foundation.org

find_iova() grabs rbtree's spinlock only for the search time.
Nothing guaranties that returned iova still exist for __free_iova().
Prevent potential use-after-free and double-free by holding the spinlock
all the time iova is being searched and freed.

Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org
Cc: Dmitry Safonov <0x7f454c46@gmail.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 drivers/iommu/iova.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 4b38eb507670..4c63d92afaf7 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -382,11 +382,14 @@ EXPORT_SYMBOL_GPL(__free_iova);
 void
 free_iova(struct iova_domain *iovad, unsigned long pfn)
 {
-	struct iova *iova = find_iova(iovad, pfn);
+	unsigned long flags;
+	struct iova *iova;
 
+	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
+	iova = private_find_iova(iovad, pfn);
 	if (iova)
-		__free_iova(iovad, iova);
-
+		private_free_iova(iovad, iova);
+	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
 }
 EXPORT_SYMBOL_GPL(free_iova);
 
-- 
2.13.6
