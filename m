From: Eric Wong <e@80x24.org>
Subject: [PATCH] iommu/intel: quirk to disable DMAR for QM57 igfx
Date: Fri, 18 Jan 2019 12:17:05 +0000
Message-ID: <20190118121705.a4usvhnskyblooja@dcvr>
References: <20181227114948.ev4b3jte3ubsc5us@dcvr>
 <154642214920.6261.102817444136744919@jlahtine-desk.ger.corp.intel.com>
 <20190104010626.e6yqdqkmdcqjepke@dcvr>
 <154659116310.4596.13613897418163029789@jlahtine-desk.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <154659116310.4596.13613897418163029789@jlahtine-desk.ger.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>
Cc: Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>, Jani Nikula <jani.nikula@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, iommu@lists.linux-foundation.org, intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Joonas Lahtinen <joonas.lahtinen@linux.intel.com> wrote:
> Quoting Eric Wong (2019-01-04 03:06:26)
> > Yeah, so the Debian bpo 4.17(.17) kernel did not set
> > CONFIG_INTEL_IOMMU_DEFAULT_ON, so I didn't encounter problems.
> > My self-built kernels all set CONFIG_INTEL_IOMMU_DEFAULT_ON.
> 
> So it's the case that IOMMU never worked on your machine.
> 
> My recommendation would be to simply use intel_iommu=igfx_off if you
> need IOMMU.
> 
> Old hardware is known to have issues with IOMMU, and retroactively
> enabling IOMMU on those machines just brings them up :/

How about we use a quirk in case distros make IOMMU the default
one day?

--------8<--------
Subject: [PATCH] iommu/intel: quirk to disable DMAR for QM57 igfx

Like the GM45, it seems the integrated graphics on QM57 seems
broken and hanging graphics with "intel_iommu=on".  So allow
future users to unconditionally enable DMAR support and not have
to remember or know to specify "intel_iommu=igfx_off"

cf. https://lore.kernel.org/lkml/20181227114948.ev4b3jte3ubsc5us@dcvr/
cf. https://lore.kernel.org/lkml/154659116310.4596.13613897418163029789@jlahtine-desk.ger.corp.intel.com/

Signed-off-by: Eric Wong <e@80x24.org>
---
 drivers/iommu/intel-iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 048b5ab36a02..dc2507a01580 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5399,7 +5399,7 @@ const struct iommu_ops intel_iommu_ops = {
 
 static void quirk_iommu_g4x_gfx(struct pci_dev *dev)
 {
-	/* G4x/GM45 integrated gfx dmar support is totally busted. */
+	/* G4x/GM45/QM57 integrated gfx dmar support is totally busted. */
 	pr_info("Disabling IOMMU for graphics on this chipset\n");
 	dmar_map_gfx = 0;
 }
@@ -5411,6 +5411,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x2e20, quirk_iommu_g4x_gfx);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x2e30, quirk_iommu_g4x_gfx);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x2e40, quirk_iommu_g4x_gfx);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x2e90, quirk_iommu_g4x_gfx);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x0044, quirk_iommu_g4x_gfx);
 
 static void quirk_iommu_rwbf(struct pci_dev *dev)
 {
@@ -5457,7 +5458,6 @@ static void quirk_calpella_no_shadow_gtt(struct pci_dev *dev)
        }
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x0040, quirk_calpella_no_shadow_gtt);
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x0044, quirk_calpella_no_shadow_gtt);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x0062, quirk_calpella_no_shadow_gtt);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x006a, quirk_calpella_no_shadow_gtt);
 
-- 
EW
