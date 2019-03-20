From: Robert Richter <rrichter@marvell.com>
Subject: [PATCH v2] iommu/iova: Fix tracking of recently failed iova address
Date: Wed, 20 Mar 2019 18:57:23 +0000
Message-ID: <20190320185718.jhr6gvs7jdbn4x3p@rric.localdomain>
References: <20190315155553.11857-1-rrichter@marvell.com>
 <7515342b-f4b2-9406-5249-93ae7880835a@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7515342b-f4b2-9406-5249-93ae7880835a@arm.com>
Content-Language: en-US
Content-ID: <6E854B9372BE4340AD425230E1258AD2@namprd18.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>, Ganapatrao Kulkarni <gkulkarni@marvell.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

On 18.03.19 15:19:23, Robin Murphy wrote:
> On 15/03/2019 15:56, Robert Richter wrote:
> > We track the smallest size that failed for a 32 bit allocation. The
> > Size decreases only and if we actually walked the tree and noticed an
> > allocation failure. Current code is broken and wrongly updates the
> > size value even if we did not try an allocation. This leads to
> > increased size values and we might go the slow path again even if we
> > have seen a failure before for the same or a smaller size.
>=20
> That description wasn't too clear (since it rather contradicts itself by
> starting off with "XYZ happens" when the whole point is that XYZ doesn't
> actually happen properly), but having gone and looked at the code in cont=
ext
> I think I understand it now - specifically, it's that the early-exit path
> for detecting that a 32-bit allocation request is too big to possibly
> succeed should never have gone via the route which assigns to
> max32_alloc_size.
>=20
> In that respect, the diff looks correct, so modulo possibly tweaking the
> commit message,
>=20
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>

Robin, thanks for your review.

I hope the following description is better now.

Thanks,

-Robert

-- >8 --
From: Robert Richter <rrichter@marvell.com>
Subject: [PATCH v2] iommu/iova: Fix tracking of recently failed iova addres=
s
 size

If a 32 bit allocation request is too big to possibly succeed, it
early exits with a failure and then should never update max32_alloc_
size. This patch fixes current code, now the size is only updated if
the slow path failed while walking the tree. Without the fix the
allocation may enter the slow path again even if there was a failure
before of a request with the same or a smaller size.

Cc: <stable@vger.kernel.org> # 4.20+
Fixes: bee60e94a1e2 ("iommu/iova: Optimise attempts to allocate iova from 3=
2bit address range")
Signed-off-by: Robert Richter <rrichter@marvell.com>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
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
