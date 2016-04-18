From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
Subject: [RFC v6 01/10] PCI: Ignore resource_alignment if PCI_PROBE_ONLY was set
Date: Mon, 18 Apr 2016 18:55:57 +0800
Message-ID: <1460976961-29328-1-git-send-email-xyjxie@linux.vnet.ibm.com>
Return-path: <linux-doc-owner@vger.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org, linux-doc@vger.kernel.org
Cc: alex.williamson@redhat.com, bhelgaas@google.com, aik@ozlabs.ru, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, corbet@lwn.net, warrier@linux.vnet.ibm.com, zhong@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com, gwshan@linux.vnet.ibm.com, Yongji Xie <xyjxie@linux.vnet.ibm.com>
List-Id: iommu@lists.linux-foundation.org

The resource_alignment will releases memory resources allocated
by firmware so that kernel can reassign new resources later on.
But this will cause the problem that no resources can be
allocated by kernel if PCI_PROBE_ONLY was set, e.g. on pSeries
platform because PCI_PROBE_ONLY force kernel to use firmware
setup and not to reassign any resources.

To solve this problem, this patch ignores resource_alignment
if PCI_PROBE_ONLY was set.

Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
---
 drivers/pci/pci.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 602eb42..77b7494 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4607,6 +4607,12 @@ static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev)
 	spin_lock(&resource_alignment_lock);
 	p = resource_alignment_param;
 	while (*p) {
+		if (pci_has_flag(PCI_PROBE_ONLY)) {
+			printk(KERN_ERR "PCI: Ignore resource_alignment parameter: %s with PCI_PROBE_ONLY set\n",
+					p);
+			*p = 0;
+			break;
+		}
 		count = 0;
 		if (sscanf(p, "%d%n", &align_order, &count) == 1 &&
 							p[count] == '@') {
-- 
1.7.9.5

