From: "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
Subject: [PATCH] iommu/amd: Mark translation invalid during device detach
Date: Wed, 16 Jan 2019 04:15:10 +0000
Message-ID: <20190116041432.3484-1-Suravee.Suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Cc: "joro@8bytes.org" <joro@8bytes.org>, "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, "Singh, Brijesh" <brijesh.singh@amd.com>
List-Id: iommu@lists.linux-foundation.org

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

When a device switches domain, IOMMU driver detach device from the old
domain, and attach device to the new domain. During this period
the host table root pointer is not set, which means DMA translation
should be marked as invalid (clear TV bit).

So, clear the TV bit when detach the device. The TV bit will be set
again when attaching device to the new domain.

Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 87ba23a75b38..525659b88ade 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1956,7 +1956,7 @@ static void set_dte_entry(u16 devid, struct protectio=
n_domain *domain,
 static void clear_dte_entry(u16 devid)
 {
 	/* remove entry from the device table seen by the hardware */
-	amd_iommu_dev_table[devid].data[0]  =3D DTE_FLAG_V | DTE_FLAG_TV;
+	amd_iommu_dev_table[devid].data[0]  =3D DTE_FLAG_V;
 	amd_iommu_dev_table[devid].data[1] &=3D DTE_FLAG_MASK;
=20
 	amd_iommu_apply_erratum_63(devid);
--=20
2.17.1
