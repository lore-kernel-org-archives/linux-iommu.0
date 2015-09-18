From: Feng Wu <feng.wu@intel.com>
Subject: [PATCH v9 03/18] KVM: arm/arm64: select IRQ_BYPASS_MANAGER
Date: Fri, 18 Sep 2015 22:29:41 +0800
Message-ID: <1442586596-5920-4-git-send-email-feng.wu@intel.com>
References: <1442586596-5920-1-git-send-email-feng.wu@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1442586596-5920-1-git-send-email-feng.wu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: pbonzini@redhat.com, alex.williamson@redhat.com, joro@8bytes.org, mtosatti@redhat.com
Cc: eric.auger@linaro.org, kvm@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Feng Wu <feng.wu@intel.com>
List-Id: iommu@lists.linux-foundation.org

From: Eric Auger <eric.auger@linaro.org>

Select IRQ_BYPASS_MANAGER when CONFIG_KVM is set
Also add compilation of virt/lib.

Signed-off-by: Eric Auger <eric.auger@linaro.org>
Signed-off-by: Feng Wu <feng.wu@intel.com>
---
v3 -> v4:
- add compilation of virt/lib in arm/arm64 KVM

v2 -> v3:
- [Feng Wu] Correct a typo in 'arch/arm64/kvm/Kconfig'

v1 -> v2:
- also set IRQ_BYPASS_MANAGER for arm64

 arch/arm/kvm/Kconfig    | 2 ++
 arch/arm/kvm/Makefile   | 1 +
 arch/arm64/kvm/Kconfig  | 2 ++
 arch/arm64/kvm/Makefile | 1 +
 4 files changed, 6 insertions(+)

diff --git a/arch/arm/kvm/Kconfig b/arch/arm/kvm/Kconfig
index bfb915d..3c565b9 100644
--- a/arch/arm/kvm/Kconfig
+++ b/arch/arm/kvm/Kconfig
@@ -3,6 +3,7 @@
 #
 
 source "virt/kvm/Kconfig"
+source "virt/lib/Kconfig"
 
 menuconfig VIRTUALIZATION
 	bool "Virtualization"
@@ -31,6 +32,7 @@ config KVM
 	select KVM_VFIO
 	select HAVE_KVM_EVENTFD
 	select HAVE_KVM_IRQFD
+	select IRQ_BYPASS_MANAGER
 	depends on ARM_VIRT_EXT && ARM_LPAE && ARM_ARCH_TIMER
 	---help---
 	  Support hosting virtualized guest machines.
diff --git a/arch/arm/kvm/Makefile b/arch/arm/kvm/Makefile
index c5eef02c..a6a41dd 100644
--- a/arch/arm/kvm/Makefile
+++ b/arch/arm/kvm/Makefile
@@ -24,3 +24,4 @@ obj-y += $(KVM)/arm/vgic.o
 obj-y += $(KVM)/arm/vgic-v2.o
 obj-y += $(KVM)/arm/vgic-v2-emul.o
 obj-y += $(KVM)/arm/arch_timer.o
+obj-y += ../../../virt/lib/
diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
index bfffe8f..2509539 100644
--- a/arch/arm64/kvm/Kconfig
+++ b/arch/arm64/kvm/Kconfig
@@ -3,6 +3,7 @@
 #
 
 source "virt/kvm/Kconfig"
+source "virt/lib/Kconfig"
 
 menuconfig VIRTUALIZATION
 	bool "Virtualization"
@@ -31,6 +32,7 @@ config KVM
 	select KVM_VFIO
 	select HAVE_KVM_EVENTFD
 	select HAVE_KVM_IRQFD
+	select IRQ_BYPASS_MANAGER
 	---help---
 	  Support hosting virtualized guest machines.
 
diff --git a/arch/arm64/kvm/Makefile b/arch/arm64/kvm/Makefile
index f90f4aa..55eec69 100644
--- a/arch/arm64/kvm/Makefile
+++ b/arch/arm64/kvm/Makefile
@@ -27,3 +27,4 @@ kvm-$(CONFIG_KVM_ARM_HOST) += $(KVM)/arm/vgic-v3.o
 kvm-$(CONFIG_KVM_ARM_HOST) += $(KVM)/arm/vgic-v3-emul.o
 kvm-$(CONFIG_KVM_ARM_HOST) += vgic-v3-switch.o
 kvm-$(CONFIG_KVM_ARM_HOST) += $(KVM)/arm/arch_timer.o
+kvm-$(CONFIG_KVM_ARM_HOST) += ../../../virt/lib/
-- 
2.1.0
