From: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v3 11/11] PCI: Remove pci_ats_enabled()
Date: Tue, 11 Aug 2015 10:52:26 -0500
Message-ID: <20150811155226.21078.27244.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150811154525.21078.85310.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20150811154525.21078.85310.stgit-1RhO1Y9PlrlHTL0Zs8A6p/gx64E7kk8eUsxypvmhUTTZJqsBc5GL+g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: Yinghai Lu <yinghai-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Gregor Dick <gdick-s/n/eUQHGBpZroRs9YW3xA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Remove pci_ats_enabled().  There are no callers outside the ATS code
itself.  We don't need to check ats_cap, because if we don't find an ATS
capability, we'll never set ats_enabled.

Signed-off-by: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Reviewed-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/pci/ats.c   |    8 ++++----
 include/linux/pci.h |    2 --
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index 4b17cf5..94976b4 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -43,8 +43,8 @@ int pci_enable_ats(struct pci_dev *dev, int ps)
 	if (!dev->ats_cap)
 		return -EINVAL;
 
-	WARN_ON(pci_ats_enabled(dev));
-	if (pci_ats_enabled(dev))
+	WARN_ON(dev->ats_enabled);
+	if (dev->ats_enabled)
 		return -EBUSY;
 
 	if (ps < PCI_ATS_MIN_STU)
@@ -81,7 +81,7 @@ void pci_disable_ats(struct pci_dev *dev)
 	struct pci_dev *pdev;
 	u16 ctrl;
 
-	if (!pci_ats_enabled(dev))
+	if (!dev->ats_enabled)
 		return;
 
 	if (atomic_read(&dev->ats_ref_cnt))
@@ -104,7 +104,7 @@ void pci_restore_ats_state(struct pci_dev *dev)
 {
 	u16 ctrl;
 
-	if (!pci_ats_enabled(dev))
+	if (!dev->ats_enabled)
 		return;
 
 	ctrl = PCI_ATS_CTRL_ENABLE;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 4b484fd..806da76 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1303,13 +1303,11 @@ void pci_ats_init(struct pci_dev *dev);
 int pci_enable_ats(struct pci_dev *dev, int ps);
 void pci_disable_ats(struct pci_dev *dev);
 int pci_ats_queue_depth(struct pci_dev *dev);
-static inline int pci_ats_enabled(struct pci_dev *dev) { return dev->ats_cap && dev->ats_enabled; }
 #else
 static inline void pci_ats_init(struct pci_dev *d) { }
 static inline int pci_enable_ats(struct pci_dev *d, int ps) { return -ENODEV; }
 static inline void pci_disable_ats(struct pci_dev *d) { }
 static inline int pci_ats_queue_depth(struct pci_dev *d) { return -ENODEV; }
-static inline int pci_ats_enabled(struct pci_dev *d) { return 0; }
 #endif
 
 void pci_cfg_access_lock(struct pci_dev *dev);
