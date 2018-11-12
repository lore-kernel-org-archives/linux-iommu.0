From: "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
Subject: [PATCH] amd/iommu: Fix Guest Virtual APIC Log Tail Address Register
Date: Mon, 12 Nov 2018 12:26:30 +0000
Message-ID: <20181112122611.129219-1-Suravee.Suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Cc: "joro@8bytes.org" <joro@8bytes.org>, Filippo Sironi <sironi@amazon.de>, Wei Wang <wawei@amazon.de>, "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
List-Id: iommu@lists.linux-foundation.org

From: Filippo Sironi <sironi@amazon.de>

This register should have been programmed with the physical address
of the memory location containing the shadow tail pointer for
the guest virtual APIC log instead of the base address.

Fixes: 8bda0cfbdc1a  ('iommu/amd: Detect and initialize guest vAPIC log')
Signed-off-by: Filippo Sironi <sironi@amazon.de>
Signed-off-by: Wei Wang <wawei@amazon.de>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd_iommu_init.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.=
c
index 9c3d610e1e19..e777fa90b2c2 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -797,7 +797,8 @@ static int iommu_init_ga_log(struct amd_iommu *iommu)
 	entry =3D iommu_virt_to_phys(iommu->ga_log) | GA_LOG_SIZE_512;
 	memcpy_toio(iommu->mmio_base + MMIO_GA_LOG_BASE_OFFSET,
 		    &entry, sizeof(entry));
-	entry =3D (iommu_virt_to_phys(iommu->ga_log) & 0xFFFFFFFFFFFFFULL) & ~7UL=
L;
+	entry =3D (iommu_virt_to_phys(iommu->ga_log_tail) &
+		 (BIT_ULL(52)-1)) & ~7ULL;
 	memcpy_toio(iommu->mmio_base + MMIO_GA_LOG_TAIL_OFFSET,
 		    &entry, sizeof(entry));
 	writel(0x00, iommu->mmio_base + MMIO_GA_HEAD_OFFSET);
--=20
2.17.1
