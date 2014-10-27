From: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [Patch Part1 v3 19/20] iommu/amd: Use helpers to access irq_cfg data
	structure associated with IRQ
Date: Mon, 27 Oct 2014 16:12:10 +0800
Message-ID: <1414397531-28254-20-git-send-email-jiang.liu@linux.intel.com>
References: <1414397531-28254-1-git-send-email-jiang.liu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1414397531-28254-1-git-send-email-jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Randy Dunlap <rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Yinghai Lu <yinghai-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Use helpers to access irq_cfg data structure associated with IRQ,
instead of accessing irq_data->chip_data directly. Later we could
rewrite those helpers to support hierarchy irqdomain.

Signed-off-by: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/iommu/amd_iommu.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 505a9adac2d5..6fda7cc789eb 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -4068,7 +4068,7 @@ static int setup_ioapic_entry(int irq, struct IO_APIC_route_entry *entry,
 	int devid;
 	int ret;
 
-	cfg = irq_get_chip_data(irq);
+	cfg = irq_cfg(irq);
 	if (!cfg)
 		return -EINVAL;
 
@@ -4131,7 +4131,7 @@ static int set_affinity(struct irq_data *data, const struct cpumask *mask,
 	if (!config_enabled(CONFIG_SMP))
 		return -1;
 
-	cfg       = data->chip_data;
+	cfg       = irqd_cfg(data);
 	irq       = data->irq;
 	irte_info = &cfg->irq_2_irte;
 
@@ -4169,7 +4169,7 @@ static int free_irq(int irq)
 	struct irq_2_irte *irte_info;
 	struct irq_cfg *cfg;
 
-	cfg = irq_get_chip_data(irq);
+	cfg = irq_cfg(irq);
 	if (!cfg)
 		return -EINVAL;
 
@@ -4188,7 +4188,7 @@ static void compose_msi_msg(struct pci_dev *pdev,
 	struct irq_cfg *cfg;
 	union irte irte;
 
-	cfg = irq_get_chip_data(irq);
+	cfg = irq_cfg(irq);
 	if (!cfg)
 		return;
 
@@ -4217,7 +4217,7 @@ static int msi_alloc_irq(struct pci_dev *pdev, int irq, int nvec)
 	if (!pdev)
 		return -EINVAL;
 
-	cfg = irq_get_chip_data(irq);
+	cfg = irq_cfg(irq);
 	if (!cfg)
 		return -EINVAL;
 
@@ -4237,7 +4237,7 @@ static int msi_setup_irq(struct pci_dev *pdev, unsigned int irq,
 	if (!pdev)
 		return -EINVAL;
 
-	cfg = irq_get_chip_data(irq);
+	cfg = irq_cfg(irq);
 	if (!cfg)
 		return -EINVAL;
 
@@ -4260,7 +4260,7 @@ static int alloc_hpet_msi(unsigned int irq, unsigned int id)
 	struct irq_cfg *cfg;
 	int index, devid;
 
-	cfg = irq_get_chip_data(irq);
+	cfg = irq_cfg(irq);
 	if (!cfg)
 		return -EINVAL;
 
-- 
1.7.10.4
