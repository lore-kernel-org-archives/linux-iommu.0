From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [RFT v3] drm: use late_initcall() for amdkfd and radeon
Date: Thu, 26 May 2016 18:18:36 -0700
Message-ID: <1464311916-10065-1-git-send-email-mcgrof@kernel.org>
References: <20160527004642.GQ11948@wotan.suse.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160527004642.GQ11948@wotan.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: vw@iommu.org, oded.gabbay@gmail.com, joro@8bytes.org, christian.koenig@amd.com, alexander.deucher@amd.com, airlied@linux.ie
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, "Luis R. Rodriguez" <mcgrof@kernel.org>
List-Id: iommu@lists.linux-foundation.org

To get KFD support in radeon we need the following
initialization to happen in this order, their
respective driver file that has its init routine
listed next to it:

0. AMD IOMMUv1:    arch/x86/kernel/pci-dma.c
1. AMD IOMMUv2:    drivers/iommu/amd_iommu_v2.c
2. AMD KFD:        drivers/gpu/drm/amd/amdkfd/kfd_module.c
3. AMD Radeon:     drivers/gpu/drm/radeon/radeon_drv.c

Order is rather implicit, but these drivers can currently
only do so much given the amount of leg room available.
Below are the respective init routines and how they are
initialized:

arch/x86/kernel/pci-dma.c               rootfs_initcall(pci_iommu_init);
drivers/iommu/amd_iommu_v2.c            module_init(amd_iommu_v2_init);
drivers/gpu/drm/amd/amdkfd/kfd_module.c module_init(kfd_module_init);
drivers/gpu/drm/radeon/radeon_drv.c     module_init(radeon_init);

When a driver is built-in module_init() folds to use
device_initcall(), and we have the following possible
orders:

	#define pure_initcall(fn)    __define_initcall(fn, 0)
	#define core_initcall(fn)    __define_initcall(fn, 1)
	#define postcore_initcall(fn)__define_initcall(fn, 2)
	#define arch_initcall(fn)    __define_initcall(fn, 3)
	#define subsys_initcall(fn)  __define_initcall(fn, 4)
	#define fs_initcall(fn)      __define_initcall(fn, 5)
        ---------------------------------------------------------
	#define rootfs_initcall(fn)  __define_initcall(fn, rootfs)
	#define device_initcall(fn)  __define_initcall(fn, 6)
	#define late_initcall(fn)    __define_initcall(fn, 7)

Since we start off from rootfs_initcall(), it gives us 3 more
levels of leg room to play with for order semantics, this isn't
enough to address all required levels of dependencies, this
is specially true given that AMD-KFD needs to be loaded before
the radeon driver -- -but this it not enforced by symbols.
If the AMD-KFD driver is not loaded prior to the radeon driver
because otherwise the radeon driver will not initialize the
AMD-KFD driver and you get no KFD functionality in userspace.

Commit 1bacc894c227fad8a7 ("drivers: Move iommu/ before gpu/ in
Makefile") works around some of the possibe races between
the AMD IOMMU v2 and GPU drivers by changing the link order.
This is fragile, however its the bets we can do, given that
making the GPU drivers use late_initcall() would also implicate
a similar race between them. That possible race is fortunatley
addressed given that the drm Makefile currently has amdkfd
linked prior to radeon:

drivers/gpu/drm/Makefile
...
obj-$(CONFIG_HSA_AMD) += amd/amdkfd/
obj-$(CONFIG_DRM_RADEON)+= radeon/
...

Changing amdkfd and radeon to late_initcall() however is
still the right call in orde to annotate explicitly a
delayed dependency requirement between the GPU drivers
and the IOMMUs.

We can't address the fragile nature of the link order
right now, but in the future that might be possible.

Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---

Please note, the changes to drivers/Makefile are just
for the sake of forcing the possible race to occur,
if this works well the actual [PATCH] submission will
skip those changes as its pointless to remove those
work arounds as it stands, due to the limited nature
of the levels available for addressing requirements.

Also, if you are aware of further dependency hell
things like these -- please do let me know as I am
interested in looking at addressing them.

 drivers/Makefile                        | 6 ++----
 drivers/gpu/drm/amd/amdkfd/kfd_module.c | 2 +-
 drivers/gpu/drm/radeon/radeon_drv.c     | 2 +-
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/Makefile b/drivers/Makefile
index 0b6f3d60193d..0fbe3982041f 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -50,10 +50,7 @@ obj-$(CONFIG_RESET_CONTROLLER)	+= reset/
 obj-y				+= tty/
 obj-y				+= char/
 
-# iommu/ comes before gpu as gpu are using iommu controllers
-obj-$(CONFIG_IOMMU_SUPPORT)	+= iommu/
-
-# gpu/ comes after char for AGP vs DRM startup and after iommu
+# gpu/ comes after char for AGP vs DRM startup
 obj-y				+= gpu/
 
 obj-$(CONFIG_CONNECTOR)		+= connector/
@@ -147,6 +144,7 @@ obj-y				+= clk/
 
 obj-$(CONFIG_MAILBOX)		+= mailbox/
 obj-$(CONFIG_HWSPINLOCK)	+= hwspinlock/
+obj-$(CONFIG_IOMMU_SUPPORT)	+= iommu/
 obj-$(CONFIG_REMOTEPROC)	+= remoteproc/
 obj-$(CONFIG_RPMSG)		+= rpmsg/
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_module.c b/drivers/gpu/drm/amd/amdkfd/kfd_module.c
index 850a5623661f..3d1dab8a31c7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_module.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_module.c
@@ -141,7 +141,7 @@ static void __exit kfd_module_exit(void)
 	dev_info(kfd_device, "Removed module\n");
 }
 
-module_init(kfd_module_init);
+late_initcall(kfd_module_init);
 module_exit(kfd_module_exit);
 
 MODULE_AUTHOR(KFD_DRIVER_AUTHOR);
diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
index b55aa740171f..1fa1b7f3a89c 100644
--- a/drivers/gpu/drm/radeon/radeon_drv.c
+++ b/drivers/gpu/drm/radeon/radeon_drv.c
@@ -609,7 +609,7 @@ static void __exit radeon_exit(void)
 	radeon_unregister_atpx_handler();
 }
 
-module_init(radeon_init);
+late_initcall(radeon_init);
 module_exit(radeon_exit);
 
 MODULE_AUTHOR(DRIVER_AUTHOR);
-- 
2.8.2
