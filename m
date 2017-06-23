From: Robert Richter <robert.richter@cavium.com>
Subject: [PATCH] iommu/arm-smmu-v3, acpi: Add temporary Cavium SMMU-V3 IORT
 model number definitions
Date: Fri, 23 Jun 2017 06:59:33 +0200
Message-ID: <20170623045933.GR16981@rric.localdomain>
References: <1498133138-20244-1-git-send-email-gakula@caviumnetworks.com>
 <20170622182257.GI15336@arm.com>
 <20170622185822.GK15336@arm.com>
 <20170622193535.GA10237@rric.localdomain>
 <20170622210437.GA27861@red-moon>
 <20170623045541.GQ16981@rric.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170623045541.GQ16981@rric.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Will Deacon <will.deacon@arm.com>, Geetha sowjanya <gakula@caviumnetworks.com>, linux-arm-kernel@lists.infradead.org, robh@kernel.org, devel@acpica.org, catalin.marinas@arm.com, Charles.Garcia-Tobin@arm.com, geethasowjanya.akula@gmail.com, jcm@redhat.com, linu.cherian@cavium.com, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org, sgoutham@cavium.com, robin.murphy@arm.com
List-Id: iommu@lists.linux-foundation.org

On 23.06.17 06:55:41, Robert Richter wrote:
> On 22.06.17 22:04:37, Lorenzo Pieralisi wrote:
> > On Thu, Jun 22, 2017 at 09:35:35PM +0200, Robert Richter wrote:
> > > On 22.06.17 19:58:22, Will Deacon wrote:
> > > > On Thu, Jun 22, 2017 at 07:22:57PM +0100, Will Deacon wrote:
> > > > > On Thu, Jun 22, 2017 at 05:35:35PM +0530, Geetha sowjanya wrote:
> > > > > > Cavium ThunderX2 SMMUv3 implementation has two Silicon Erratas.
> > > > > > 1. Errata ID #74
> > > > > >    SMMU register alias Page 1 is not implemented
> > > > > > 2. Errata ID #126
> > > > > >    SMMU doesnt support unique IRQ lines and also MSI for gerror,
> > > > > >    eventq and cmdq-sync
> > > > > > 
> > > > > > The following patchset does software workaround for these two erratas.
> > > > > 
> > > > > I've picked up the first two patches, and left comments on the final patch.
> > > > 
> > > > ... except that it doesn't build:
> > > > 
> > > > 
> > > > drivers/acpi/arm64/iort.c: In function ‘arm_smmu_v3_resource_size’:
> > > > drivers/acpi/arm64/iort.c:837:21: error: ‘ACPI_IORT_SMMU_V3_CAVIUM_CN99XX’ undeclared (first use in this function)
> > > >   if (smmu->model == ACPI_IORT_SMMU_V3_CAVIUM_CN99XX)
> > > >                      ^
> > > > drivers/acpi/arm64/iort.c:837:21: note: each undeclared identifier is reported only once for each function it appears in
> > > > make[4]: *** [drivers/acpi/arm64/iort.o] Error 1
> > > > 
> > > > 
> > > > I don't see ACPI_IORT_SMMU_V3_CAVIUM_CN99XX defined, even in linux-next.
> > > > 
> > > > What's the plan here?
> > > 
> > > It is defined already in acpica and we actually waiting for the acpi
> > > maintainers to include it:
> > > 
> > >  https://github.com/acpica/acpica/commit/d00a4eb86e64
> > > 
> > > We could add
> > > 
> > > /* Until ACPICA headers cover IORT rev. C */
> > > #ifndef ACPI_IORT_SMMU_V3_CAVIUM_CN99XX
> > > #define ACPI_IORT_SMMU_V3_CAVIUM_CN99XX		0x2
> > > #endif
> > > 
> > > to both files:
> > > 
> > >  drivers/acpi/arm64/iort.c
> > >  drivers/iommu/arm-smmu-v3.c
> > > 
> > 
> > I thought it was a solved problem (and that the IORT patch was based
> > on Robin's workaround) but I was clearly wrong and I apologise to
> > Will about this.
> > 
> > FWIW, you could add the define in include/linux/acpi_iort.h and I will
> > remove it whenever ACPICA changes make it into the kernel.
> 
> Adding it there will still let depend us on acpi maintainers, while I
> think the over 2 files might go through arm64 tree smoothly. A change
> in acpi_iort.h also adds the definition to other archs and I don't
> think that adding arch #ifdefs to avoid that are welcome in that
> header file too.
> 
> I am going to resend my patch below with an improved wording.

Here it comes:

>From d210b4c540bc4adcebd51d5a87437d2049649e94 Mon Sep 17 00:00:00 2001
From: Robert Richter <rrichter@cavium.com>
Date: Thu, 22 Jun 2017 21:20:54 +0200
Subject: [PATCH] iommu/arm-smmu-v3, acpi: Add temporary Cavium SMMU-V3 IORT
 model number definitions

The model number is already defined in acpica and we are actually
waiting for the acpi maintainers to include it:

 https://github.com/acpica/acpica/commit/d00a4eb86e64

Adding those temporary definitions until the change makes it into
include/acpi/actbl2.h. Once that is done this patch can be reverted.

Signed-off-by: Robert Richter <rrichter@cavium.com>
---
 drivers/acpi/arm64/iort.c   | 5 +++++
 drivers/iommu/arm-smmu-v3.c | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 797b28dc7b34..15491237a657 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -31,6 +31,11 @@
 #define IORT_IOMMU_TYPE		((1 << ACPI_IORT_NODE_SMMU) |	\
 				(1 << ACPI_IORT_NODE_SMMU_V3))
 
+/* Until ACPICA headers cover IORT rev. C */
+#ifndef ACPI_IORT_SMMU_V3_CAVIUM_CN99XX
+#define ACPI_IORT_SMMU_V3_CAVIUM_CN99XX		0x2
+#endif
+
 struct iort_its_msi_chip {
 	struct list_head	list;
 	struct fwnode_handle	*fw_node;
diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 380969aa60d5..c759dfa7442d 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -412,6 +412,11 @@
 #define MSI_IOVA_BASE			0x8000000
 #define MSI_IOVA_LENGTH			0x100000
 
+/* Until ACPICA headers cover IORT rev. C */
+#ifndef ACPI_IORT_SMMU_V3_CAVIUM_CN99XX
+#define ACPI_IORT_SMMU_V3_CAVIUM_CN99XX		0x2
+#endif
+
 static bool disable_bypass;
 module_param_named(disable_bypass, disable_bypass, bool, S_IRUGO);
 MODULE_PARM_DESC(disable_bypass,
-- 
2.11.0

