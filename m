From: Feng Wu <feng.wu@intel.com>
Subject: [PATCH v7 17/17] iommu/vt-d: Add a command line parameter for VT-d posted-interrupts
Date: Tue, 25 Aug 2015 16:50:20 +0800
Message-ID: <1440492620-15934-18-git-send-email-feng.wu@intel.com>
References: <1440492620-15934-1-git-send-email-feng.wu@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1440492620-15934-1-git-send-email-feng.wu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: pbonzini@redhat.com, alex.williamson@redhat.com, joro@8bytes.org, mtosatti@redhat.com
Cc: eric.auger@linaro.org, kvm@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Feng Wu <feng.wu@intel.com>
List-Id: iommu@lists.linux-foundation.org

Enable VT-d Posted-Interrtups and add a command line
parameter for it.

Signed-off-by: Feng Wu <feng.wu@intel.com>
---
 Documentation/kernel-parameters.txt |  1 +
 drivers/iommu/irq_remapping.c       | 12 ++++++++----
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 1d6f045..52aca36 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -1547,6 +1547,7 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 			nosid	disable Source ID checking
 			no_x2apic_optout
 				BIOS x2APIC opt-out request will be ignored
+			nopost	disable Interrupt Posting
 
 	iomem=		Disable strict checking of access to MMIO memory
 		strict	regions from userspace.
diff --git a/drivers/iommu/irq_remapping.c b/drivers/iommu/irq_remapping.c
index 2d99930..d8c3997 100644
--- a/drivers/iommu/irq_remapping.c
+++ b/drivers/iommu/irq_remapping.c
@@ -22,7 +22,7 @@ int irq_remap_broken;
 int disable_sourceid_checking;
 int no_x2apic_optout;
 
-int disable_irq_post = 1;
+int disable_irq_post = 0;
 
 static int disable_irq_remap;
 static struct irq_remap_ops *remap_ops;
@@ -58,14 +58,18 @@ static __init int setup_irqremap(char *str)
 		return -EINVAL;
 
 	while (*str) {
-		if (!strncmp(str, "on", 2))
+		if (!strncmp(str, "on", 2)) {
 			disable_irq_remap = 0;
-		else if (!strncmp(str, "off", 3))
+			disable_irq_post = 0;
+		} else if (!strncmp(str, "off", 3)) {
 			disable_irq_remap = 1;
-		else if (!strncmp(str, "nosid", 5))
+			disable_irq_post = 1;
+		} else if (!strncmp(str, "nosid", 5))
 			disable_sourceid_checking = 1;
 		else if (!strncmp(str, "no_x2apic_optout", 16))
 			no_x2apic_optout = 1;
+		else if (!strncmp(str, "nopost", 6))
+			disable_irq_post = 1;
 
 		str += strcspn(str, ",");
 		while (*str == ',')
-- 
2.1.0
