From: Robert Richter <rrichter@marvell.com>
Subject: [PATCH] iommu/iova: Fix tracking of recently failed iova address size
Date: Fri, 15 Mar 2019 15:56:20 +0000
Message-ID: <20190315155553.11857-1-rrichter@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: Ganapatrao Kulkarni <gkulkarni@marvell.com>, Robin Murphy <robin.murphy@arm.com>, Robert Richter <rrichter@marvell.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

We track the smallest size that failed for a 32 bit allocation. The
Size decreases only and if we actually walked the tree and noticed an
allocation failure. Current code is broken and wrongly updates the
size value even if we did not try an allocation. This leads to
increased size values and we might go the slow path again even if we
have seen a failure before for the same or a smaller size.

Cc: <stable@vger.kernel.org> # 4.20+
Fixes: bee60e94a1e2 ("iommu/iova: Optimise attempts to allocate iova from 3=
2bit address range")
Signed-off-by: Robert Richter <rrichter@marvell.com>
---
 drivers/iommu/iova.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index f8d3ba247523..2de8122e218f 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -207,8 +207,10 @@ static int __alloc_and_insert_iova_range(struct iova_d=
omain *iovad,
 		curr_iova =3D rb_entry(curr, struct iova, node);
 	} while (curr && new_pfn <=3D curr_iova->pfn_hi);
=20
-	if (limit_pfn < size || new_pfn < iovad->start_pfn)
+	if (limit_pfn < size || new_pfn < iovad->start_pfn) {
+		iovad->max32_alloc_size =3D size;
 		goto iova32_full;
+	}
=20
 	/* pfn_lo will point to size aligned address if size_aligned is set */
 	new->pfn_lo =3D new_pfn;
@@ -222,7 +224,6 @@ static int __alloc_and_insert_iova_range(struct iova_do=
main *iovad,
 	return 0;
=20
 iova32_full:
-	iovad->max32_alloc_size =3D size;
 	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
 	return -ENOMEM;
 }
--=20
2.20.1
