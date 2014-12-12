From: Feng Wu <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [v3 26/26] iommu/vt-d: Add a command line parameter for VT-d
	posted-interrupts
Date: Fri, 12 Dec 2014 23:15:00 +0800
Message-ID: <1418397300-10870-27-git-send-email-feng.wu@intel.com>
References: <1418397300-10870-1-git-send-email-feng.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1418397300-10870-1-git-send-email-feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, gleb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Enable VT-d Posted-Interrtups and add a command line
parameter for it.

Signed-off-by: Feng Wu <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 Documentation/kernel-parameters.txt |  1 +
 drivers/iommu/irq_remapping.c       | 12 ++++++++----
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 838f377..324b790 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -1453,6 +1453,7 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 			nosid	disable Source ID checking
 			no_x2apic_optout
 				BIOS x2APIC opt-out request will be ignored
+			nopost	disable Interrupt Posting
 
 	iomem=		Disable strict checking of access to MMIO memory
 		strict	regions from userspace.
diff --git a/drivers/iommu/irq_remapping.c b/drivers/iommu/irq_remapping.c
index b008663..aa3cd23 100644
--- a/drivers/iommu/irq_remapping.c
+++ b/drivers/iommu/irq_remapping.c
@@ -24,7 +24,7 @@ int irq_remap_broken;
 int disable_sourceid_checking;
 int no_x2apic_optout;
 
-int disable_irq_post = 1;
+int disable_irq_post = 0;
 
 static struct irq_remap_ops *remap_ops;
 
@@ -59,14 +59,18 @@ static __init int setup_irqremap(char *str)
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
1.9.1
