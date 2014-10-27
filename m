From: Yijing Wang <wangyijing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 11/16] s390/MSI: Use MSI controller framework to configure
	MSI/MSI-X irq
Date: Mon, 27 Oct 2014 21:22:17 +0800
Message-ID: <1414416142-31239-12-git-send-email-wangyijing@huawei.com>
References: <1414416142-31239-1-git-send-email-wangyijing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1414416142-31239-1-git-send-email-wangyijing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Cc: linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Xinwei Hu <huxinwei-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-s390-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Michael Ellerman <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Sebastian Ott <sebott-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, xen-devel-GuqFBffKawtpuQazS67q72D2FQJk+8+b@public.gmane.org, Chris Metcalf <cmetcalf-kv+TWInifGbQT0dZR+AlfA@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, David Vrabel <david.vrabel-Sxgqhf6Nn4DQT0dZR+AlfA@public.gmane.org>, Wuyun <wuyun.wu-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, linuxppc-dev-uLR06cmDAlZmR6Xm/wNWPw@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Use MSI controller framework instead of arch MSI functions to configure
MSI/MSI-X irq. So we can manage MSI/MSI-X irq in a unified framework.

Signed-off-by: Yijing Wang <wangyijing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Acked-by: Sebastian Ott <sebott-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
---
 arch/s390/include/asm/pci.h |    1 +
 arch/s390/pci/pci.c         |   19 +++++++++++++++++--
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
index c030900..bf14da2 100644
--- a/arch/s390/include/asm/pci.h
+++ b/arch/s390/include/asm/pci.h
@@ -88,6 +88,7 @@ struct zpci_dev {
 	u32 uid;			/* user defined id */
 	u8 util_str[CLP_UTIL_STR_LEN];	/* utility string */
 
+	struct msi_controller *msi_ctrl;
 	/* IRQ stuff */
 	u64		msi_addr;	/* MSI address */
 	struct airq_iv *aibv;		/* adapter interrupt bit vector */
diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index 552b990..beed5ab 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -358,7 +358,15 @@ static void zpci_irq_handler(struct airq_struct *airq)
 	}
 }
 
-int arch_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
+struct msi_controller *pcibios_msi_controller(struct pci_bus *bus)
+{
+	struct zpci_dev *zpci = bus->sysdata;
+
+	return zpci->msi_ctrl;
+}
+
+static int zpci_setup_msi_irqs(struct msi_controller *ctrl,
+		struct pci_dev *pdev, int nvec, int type)
 {
 	struct zpci_dev *zdev = get_zdev(pdev);
 	unsigned int hwirq, msi_vecs;
@@ -434,7 +442,8 @@ out:
 	return rc;
 }
 
-void arch_teardown_msi_irqs(struct pci_dev *pdev)
+static void zpci_teardown_msi_irqs(struct msi_controller *ctrl,
+		struct pci_dev *pdev)
 {
 	struct zpci_dev *zdev = get_zdev(pdev);
 	struct msi_desc *msi;
@@ -464,6 +473,11 @@ void arch_teardown_msi_irqs(struct pci_dev *pdev)
 	airq_iv_free_bit(zpci_aisb_iv, zdev->aisb);
 }
 
+static struct msi_controller zpci_msi_ctrl = {
+	.setup_irqs = zpci_setup_msi_irqs,
+	.teardown_irqs = zpci_teardown_msi_irqs,
+};
+
 static void zpci_map_resources(struct zpci_dev *zdev)
 {
 	struct pci_dev *pdev = zdev->pdev;
@@ -749,6 +763,7 @@ static int zpci_scan_bus(struct zpci_dev *zdev)
 	if (ret)
 		return ret;
 
+	zdev->msi_ctrl = &zpci_msi_ctrl;
 	zdev->bus = pci_scan_root_bus(NULL, ZPCI_BUS_NR, &pci_root_ops,
 				      zdev, &resources);
 	if (!zdev->bus) {
-- 
1.7.1
