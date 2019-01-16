From: "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
Subject: [PATCH] iommu/amd: Fix IOMMU page flush when detach all devices from
 a domain
Date: Wed, 16 Jan 2019 04:16:25 +0000
Message-ID: <20190116041546.3541-1-Suravee.Suthikulpanit@amd.com>
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

When a VM is terminated, the VFIO driver detaches all pass-through
devices from VFIO domain by clearing domain id and page table root
pointer from each device table entry (DTE), and then invalidates
the DTE. Then, the VFIO driver unmap pages and invalidate IOMMU pages.

Currently, the IOMMU driver keeps track of which IOMMU and how many
devices are attached to the domain. When invalidate IOMMU pages,
the driver checks if the IOMMU is still attached to the domain before
issuing the invalidate page command.

However, since VFIO has already detached all devices from the domain,
the subsequent INVALIDATE_IOMMU_PAGES commands are being skipped as
there is no IOMMU attached to the domain. This results in data
corruption and could cause the PCI device to end up in indeterministic
state.

Fix this by always issuing the IOMMU pages invalidate command when
device count is zero, which is the case when detaching all the devices
from the domain.

Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd_iommu.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 525659b88ade..ab31ba75da1b 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1248,7 +1248,13 @@ static void __domain_flush_pages(struct protection_d=
omain *domain,
 	build_inv_iommu_pages(&cmd, address, size, domain->id, pde);
=20
 	for (i =3D 0; i < amd_iommu_get_num_iommus(); ++i) {
-		if (!domain->dev_iommu[i])
+		/*
+		 * The dev_cnt is zero when all devices are detached
+		 * from the domain. This is the case when VFIO detaches
+		 * all devices from the group before flushing IOMMU pages.
+		 * So, always issue the flush command.
+		 */
+		if (domain->dev_cnt && !domain->dev_iommu[i])
 			continue;
=20
 		/*
--=20
2.17.1
