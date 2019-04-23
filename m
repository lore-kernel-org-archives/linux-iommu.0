From: "Liu, Yi L" <yi.l.liu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [RFC v3 2/3] vfio/pci: protect cap/ecap_perm bits alloc/free with
	atomic op
Date: Tue, 23 Apr 2019 20:14:39 +0800
Message-ID: <1556021680-2911-3-git-send-email-yi.l.liu@intel.com>
References: <1556021680-2911-1-git-send-email-yi.l.liu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1556021680-2911-1-git-send-email-yi.l.liu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, kwankhede-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org
Cc: kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Liu-i9wRM+HIrmnmtl4Z8vJ8Kg761KYD1DLY@public.gmane.org, jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org, yi.y.sun-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

There is a case in which cap_perms and ecap_perms can be reallocated
by different modules. e.g. the vfio-mdev-pci sample driver. To secure
the initialization of cap_perms and ecap_perms, this patch adds an
atomic variable to track the user of cap/ecap_perms bits. First caller
of vfio_pci_init_perm_bits() will initialize the bits. While the last
caller of vfio_pci_uninit_perm_bits() will free the bits.

Cc: Kevin Tian <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Suggested-by: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Liu, Yi L <yi.l.liu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/vfio/pci/vfio_pci_config.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
index e82b511..913fca6 100644
--- a/drivers/vfio/pci/vfio_pci_config.c
+++ b/drivers/vfio/pci/vfio_pci_config.c
@@ -996,11 +996,17 @@ static int __init init_pci_ext_cap_pwr_perm(struct perm_bits *perm)
 	return 0;
 }
 
+/* Track the user number of the cap/ecap perm_bits */
+atomic_t vfio_pci_perm_bits_users = ATOMIC_INIT(0);
+
 /*
  * Initialize the shared permission tables
  */
 void vfio_pci_uninit_perm_bits(void)
 {
+	if (atomic_dec_return(&vfio_pci_perm_bits_users))
+		return;
+
 	free_perm_bits(&cap_perms[PCI_CAP_ID_BASIC]);
 
 	free_perm_bits(&cap_perms[PCI_CAP_ID_PM]);
@@ -1017,6 +1023,9 @@ int __init vfio_pci_init_perm_bits(void)
 {
 	int ret;
 
+	if (atomic_inc_return(&vfio_pci_perm_bits_users) != 1)
+		return 0;
+
 	/* Basic config space */
 	ret = init_pci_cap_basic_perm(&cap_perms[PCI_CAP_ID_BASIC]);
 
-- 
2.7.4
