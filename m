Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89A245000
	for <iommu@lists.linux.dev>; Tue, 26 May 2026 01:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779758452; cv=none; b=mBsrXbnXhjtGQiFaf+DwQelYWO/nfxzcdjnhVbOuX3mXtFDFX7aXoA8/EAkFahOvFeujos9erZCS22WIIWhLifm8NX1cnyrkGe5OZWPj4vmK/wP4kJrD1hrMgBpsaMtrCFjKvjALAoBx78KJ7Z/7XdEiMdANu9n7rZdgSV57jP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779758452; c=relaxed/simple;
	bh=IES99TK3UG1XcvBR+g7fMZt0qpCtHXjnt2qQ0e46ec4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t6Co6cAUuRMWhiX8zm7zXqCZcF1bQF/Em7v8Zmt5r7R0vpElFvgm5dHKbaoI0MwQNVN05YjVzjRfDIB8rCsa/UQUbK35asg3Q/h0tjBFqzk6v6mzysv3eMCqepH9uALipRorj2y3q2Ei4ij2DM87Hqyx43niTcBKSCntgWDi9NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=eCxqx8r+; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="eCxqx8r+"
Received: from mrdev.corp.microsoft.com (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id ED57B20B7166;
	Mon, 25 May 2026 18:20:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com ED57B20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1779758440;
	bh=j8yYLEPuVMxX6YEKnSVCvQPAnmKn4u8txf6BJd+EFF0=;
	h=From:To:Cc:Subject:Date:From;
	b=eCxqx8r+gHhJiWUTuAxZJOi4rUlJZz6UcbFSbwW3MrpkP53tsMVFMWrWgIAklRj9J
	 XMQkT7PHi/zufrTybqPjZWURRqKC84OX383zT/aB++GpIBiF63PN3tKlXheP2viNX5
	 p2bhoxYn4fVbj1TM8AdBz+HKyxDQ6dFSjIauiNAk=
From: Mukesh R <mrathor@linux.microsoft.com>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Cc: mhklinux@outlook.com,
	wei.liu@kernel.org,
	zhangyu1@linux.microsoft.com,
	jacob.pan@linux.microsoft.com,
	schakrabarti@linux.microsoft.com
Subject: [PATCH V0] iommu/hyperv: Create hyperv subdirectory under iommu
Date: Mon, 25 May 2026 18:20:37 -0700
Message-ID: <20260526012037.3874959-1-mrathor@linux.microsoft.com>
X-Mailer: git-send-email 2.51.2.vfs.0.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Create hyperv subdirectory under drivers/iommu in anticipation of more
hyperv related files for upcoming PCI passthru and pv IOMMU patches.
Also, the current file hyperv-iommu.c actually implements irq remapping,
so rename to more appropriate hv-irq-remap.c and move it under the new
hyperv subdirectory. Lastly, this file should not be tied to
CONFIG_HYPERV_IOMMU, but to CONFIG_HYPERV and CONFIG_IRQ_REMAP.

Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
---
 MAINTAINERS                                             | 2 +-
 drivers/iommu/Makefile                                  | 2 +-
 drivers/iommu/hyperv/Makefile                           | 2 ++
 drivers/iommu/{hyperv-iommu.c => hyperv/hv-irq-remap.c} | 8 +-------
 drivers/iommu/irq_remapping.c                           | 2 +-
 5 files changed, 6 insertions(+), 10 deletions(-)
 create mode 100644 drivers/iommu/hyperv/Makefile
 rename drivers/iommu/{hyperv-iommu.c => hyperv/hv-irq-remap.c} (99%)

diff --git a/MAINTAINERS b/MAINTAINERS
index d1cc0e12fe1f..b651ee0c6e6b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11914,7 +11914,7 @@ F:	drivers/clocksource/hyperv_timer.c
 F:	drivers/hid/hid-hyperv.c
 F:	drivers/hv/
 F:	drivers/input/serio/hyperv-keyboard.c
-F:	drivers/iommu/hyperv-iommu.c
+F:	drivers/iommu/hyperv/hv-irq-remap.c
 F:	drivers/net/ethernet/microsoft/
 F:	drivers/net/hyperv/
 F:	drivers/pci/controller/pci-hyperv-intf.c
diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 0275821f4ef9..d9683422aecb 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -4,6 +4,7 @@ obj-$(CONFIG_AMD_IOMMU) += amd/
 obj-$(CONFIG_INTEL_IOMMU) += intel/
 obj-$(CONFIG_RISCV_IOMMU) += riscv/
 obj-$(CONFIG_GENERIC_PT) += generic_pt/fmt/
+obj-$(CONFIG_HYPERV) += hyperv/
 obj-$(CONFIG_IOMMU_API) += iommu.o
 obj-$(CONFIG_IOMMU_SUPPORT) += iommu-pages.o
 obj-$(CONFIG_IOMMU_API) += iommu-traces.o
@@ -30,7 +31,6 @@ obj-$(CONFIG_TEGRA_IOMMU_SMMU) += tegra-smmu.o
 obj-$(CONFIG_EXYNOS_IOMMU) += exynos-iommu.o
 obj-$(CONFIG_FSL_PAMU) += fsl_pamu.o fsl_pamu_domain.o
 obj-$(CONFIG_S390_IOMMU) += s390-iommu.o
-obj-$(CONFIG_HYPERV_IOMMU) += hyperv-iommu.o
 obj-$(CONFIG_VIRTIO_IOMMU) += virtio-iommu.o
 obj-$(CONFIG_IOMMU_SVA) += iommu-sva.o
 obj-$(CONFIG_IOMMU_IOPF) += io-pgfault.o
diff --git a/drivers/iommu/hyperv/Makefile b/drivers/iommu/hyperv/Makefile
new file mode 100644
index 000000000000..0053e00e08e6
--- /dev/null
+++ b/drivers/iommu/hyperv/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_IRQ_REMAP) += hv-irq-remap.o
diff --git a/drivers/iommu/hyperv-iommu.c b/drivers/iommu/hyperv/hv-irq-remap.c
similarity index 99%
rename from drivers/iommu/hyperv-iommu.c
rename to drivers/iommu/hyperv/hv-irq-remap.c
index 479103261ae6..b34ee9589190 100644
--- a/drivers/iommu/hyperv-iommu.c
+++ b/drivers/iommu/hyperv/hv-irq-remap.c
@@ -7,13 +7,11 @@
  *
  * Author : Lan Tianyu <Tianyu.Lan@microsoft.com>
  */
-
 #include <linux/types.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/iommu.h>
 #include <linux/module.h>
-
 #include <asm/apic.h>
 #include <asm/cpu.h>
 #include <asm/hw_irq.h>
@@ -22,9 +20,7 @@
 #include <asm/hypervisor.h>
 #include <asm/mshyperv.h>
 
-#include "irq_remapping.h"
-
-#ifdef CONFIG_IRQ_REMAP
+#include "../irq_remapping.h"
 
 /*
  * According 82093AA IO-APIC spec , IO APIC has a 24-entry Interrupt
@@ -330,5 +326,3 @@ static const struct irq_domain_ops hyperv_root_ir_domain_ops = {
 	.alloc = hyperv_root_irq_remapping_alloc,
 	.free = hyperv_root_irq_remapping_free,
 };
-
-#endif
diff --git a/drivers/iommu/irq_remapping.c b/drivers/iommu/irq_remapping.c
index c2443659812a..41bf65e4ea88 100644
--- a/drivers/iommu/irq_remapping.c
+++ b/drivers/iommu/irq_remapping.c
@@ -108,7 +108,7 @@ int __init irq_remapping_prepare(void)
 	else if (IS_ENABLED(CONFIG_AMD_IOMMU) &&
 		 amd_iommu_irq_ops.prepare() == 0)
 		remap_ops = &amd_iommu_irq_ops;
-	else if (IS_ENABLED(CONFIG_HYPERV_IOMMU) &&
+	else if (IS_ENABLED(CONFIG_HYPERV) &&
 		 hyperv_irq_remap_ops.prepare() == 0)
 		remap_ops = &hyperv_irq_remap_ops;
 	else
-- 
2.51.2.vfs.0.1

