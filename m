From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/1] iommu/vt-d: Remove unnecessary WARN_ON()
Date: Tue, 19 Jun 2018 10:49:19 +0800
Message-ID: <1529376559-25759-1-git-send-email-baolu.lu@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>
Cc: ashok.raj@intel.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

When drivers call intel_svm_available() to check whether the
Shared Virtual Memory(SVM) is supported by the IOMMU driver,
they will get a warning in the kernel message if the SVM is
not supported by the hardware.

[    3.790876] WARNING: CPU: 0 PID: 267 at drivers/iommu/intel-svm.c:334 intel_svm_bind_mm+0x292/0x570
[    3.790877] Modules linked in: dsa(+) vfio_mdev mdev vfio_iommu_type1 soundcore vfio serio_raw parport_pc ppdev lp parport autofs4 psmouse virtio_net pata_acpi
[    3.790884] CPU: 0 PID: 267 Comm: systemd-udevd Not tainted 4.15.0+ #358
[    3.790885] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.11.0-0-g63451fca13-prebuilt.qemu-project.org 04/01/2014
[    3.790887] RIP: 0010:intel_svm_bind_mm+0x292/0x570
[    3.790887] RSP: 0000:ffffac72c08a3a70 EFLAGS: 00010246
[    3.790889] RAX: 0000000000000000 RBX: ffff90447a5160a0 RCX: 0000000000000000
[    3.790889] RDX: 0000000000000000 RSI: 0000000000000082 RDI: ffff90447fc16550
[    3.790890] RBP: ffff90447a516000 R08: 0000000000000000 R09: 0000000000000178
[    3.790891] R10: 0000000000000220 R11: 0000000000aaaaaa R12: 0000000000000000
[    3.790891] R13: 0000000000000002 R14: ffffac72c08a3b18 R15: ffffac72c08a3eb8
[    3.790893] FS:  00007fb21e85b8c0(0000) GS:ffff90447fc00000(0000) knlGS:0000000000000000
[    3.790894] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.790894] CR2: 000055c08167d148 CR3: 000000013a6f4000 CR4: 00000000000006f0
[    3.790903] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    3.790904] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

This is caused by a unnecessary WARN_ON() in intel_svm_bind_mm().
Hence, remove it.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-svm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index 45f6e58..2cc0aac 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -309,7 +309,7 @@ int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_
 	int pasid_max;
 	int ret;
 
-	if (WARN_ON(!iommu || !iommu->pasid_table))
+	if (!iommu || !iommu->pasid_table)
 		return -EINVAL;
 
 	if (dev_is_pci(dev)) {
-- 
2.7.4
