From: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v2 4/4] PCI: Remove unused SR-IOV VF Migration support
Date: Tue, 18 Feb 2014 14:00:00 -0700
Message-ID: <20140218205959.11014.17242.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20140218205925.11014.14973.stgit@bhelgaas-glaptop.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140218205925.11014.14973.stgit-1RhO1Y9PlrlHTL0Zs8A6p5iNqAH0jzoTYJqu5kTmcBRl57MIdRCFDg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: e1000-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Sudeep Dutt <sudeep.dutt-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Hemminger <stephen-OTpzqLSitTUnbdJkjeBofR2eb7JE58TQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Tomas Winkler <tomas.winkler-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Aaron F Brown <aaron.f.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Arjan van de Ven <arjan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

This reverts commit 74bb1bcc7dbb ("PCI: handle SR-IOV Virtual Function
Migration"), removing this exported interface:

  pci_sriov_migration()

Since pci_sriov_migration() is unused, it is impossible to schedule
sriov_migration_task() or use any of the other migration infrastructure.

This is based on Stephen Hemminger's patch (see link below), but goes a bit
further.

Link: http://lkml.kernel.org/r/20131227132710.7190647c-We1ePj4FEcvRI77zikRAJc56i+j3xesD0e7PPNI6Mm0@public.gmane.org
Signed-off-by: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
CC: Stephen Hemminger <stephen-OTpzqLSitTUnbdJkjeBofR2eb7JE58TQ@public.gmane.org>
---
 Documentation/PCI/pci-iov-howto.txt |    4 -
 drivers/pci/iov.c                   |  119 -----------------------------------
 drivers/pci/pci.h                   |    4 -
 include/linux/pci.h                 |    4 -
 4 files changed, 131 deletions(-)

diff --git a/Documentation/PCI/pci-iov-howto.txt b/Documentation/PCI/pci-iov-howto.txt
index 86551cc72e03..2d91ae251982 100644
--- a/Documentation/PCI/pci-iov-howto.txt
+++ b/Documentation/PCI/pci-iov-howto.txt
@@ -68,10 +68,6 @@ To disable SR-IOV capability:
 	echo  0 > \
         /sys/bus/pci/devices/<DOMAIN:BUS:DEVICE.FUNCTION>/sriov_numvfs
 
-To notify SR-IOV core of Virtual Function Migration:
-(a) In the driver:
-	irqreturn_t pci_sriov_migration(struct pci_dev *dev);
-
 3.2 Usage example
 
 Following piece of code illustrates the usage of the SR-IOV API.
diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 9dce7c5e2a77..de7a74782f92 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -170,97 +170,6 @@ static void virtfn_remove(struct pci_dev *dev, int id, int reset)
 	pci_dev_put(dev);
 }
 
-static int sriov_migration(struct pci_dev *dev)
-{
-	u16 status;
-	struct pci_sriov *iov = dev->sriov;
-
-	if (!iov->num_VFs)
-		return 0;
-
-	if (!(iov->cap & PCI_SRIOV_CAP_VFM))
-		return 0;
-
-	pci_read_config_word(dev, iov->pos + PCI_SRIOV_STATUS, &status);
-	if (!(status & PCI_SRIOV_STATUS_VFM))
-		return 0;
-
-	schedule_work(&iov->mtask);
-
-	return 1;
-}
-
-static void sriov_migration_task(struct work_struct *work)
-{
-	int i;
-	u8 state;
-	u16 status;
-	struct pci_sriov *iov = container_of(work, struct pci_sriov, mtask);
-
-	for (i = iov->initial_VFs; i < iov->num_VFs; i++) {
-		state = readb(iov->mstate + i);
-		if (state == PCI_SRIOV_VFM_MI) {
-			writeb(PCI_SRIOV_VFM_AV, iov->mstate + i);
-			state = readb(iov->mstate + i);
-			if (state == PCI_SRIOV_VFM_AV)
-				virtfn_add(iov->self, i, 1);
-		} else if (state == PCI_SRIOV_VFM_MO) {
-			virtfn_remove(iov->self, i, 1);
-			writeb(PCI_SRIOV_VFM_UA, iov->mstate + i);
-			state = readb(iov->mstate + i);
-			if (state == PCI_SRIOV_VFM_AV)
-				virtfn_add(iov->self, i, 0);
-		}
-	}
-
-	pci_read_config_word(iov->self, iov->pos + PCI_SRIOV_STATUS, &status);
-	status &= ~PCI_SRIOV_STATUS_VFM;
-	pci_write_config_word(iov->self, iov->pos + PCI_SRIOV_STATUS, status);
-}
-
-static int sriov_enable_migration(struct pci_dev *dev, int nr_virtfn)
-{
-	int bir;
-	u32 table;
-	resource_size_t pa;
-	struct pci_sriov *iov = dev->sriov;
-
-	if (nr_virtfn <= iov->initial_VFs)
-		return 0;
-
-	pci_read_config_dword(dev, iov->pos + PCI_SRIOV_VFM, &table);
-	bir = PCI_SRIOV_VFM_BIR(table);
-	if (bir > PCI_STD_RESOURCE_END)
-		return -EIO;
-
-	table = PCI_SRIOV_VFM_OFFSET(table);
-	if (table + nr_virtfn > pci_resource_len(dev, bir))
-		return -EIO;
-
-	pa = pci_resource_start(dev, bir) + table;
-	iov->mstate = ioremap(pa, nr_virtfn);
-	if (!iov->mstate)
-		return -ENOMEM;
-
-	INIT_WORK(&iov->mtask, sriov_migration_task);
-
-	iov->ctrl |= PCI_SRIOV_CTRL_VFM | PCI_SRIOV_CTRL_INTR;
-	pci_write_config_word(dev, iov->pos + PCI_SRIOV_CTRL, iov->ctrl);
-
-	return 0;
-}
-
-static void sriov_disable_migration(struct pci_dev *dev)
-{
-	struct pci_sriov *iov = dev->sriov;
-
-	iov->ctrl &= ~(PCI_SRIOV_CTRL_VFM | PCI_SRIOV_CTRL_INTR);
-	pci_write_config_word(dev, iov->pos + PCI_SRIOV_CTRL, iov->ctrl);
-
-	cancel_work_sync(&iov->mtask);
-	iounmap(iov->mstate);
-}
-
 static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
 {
 	int rc;
@@ -351,12 +260,6 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
 			goto failed;
 	}
 
-	if (iov->cap & PCI_SRIOV_CAP_VFM) {
-		rc = sriov_enable_migration(dev, nr_virtfn);
-		if (rc)
-			goto failed;
-	}
-
 	kobject_uevent(&dev->dev.kobj, KOBJ_CHANGE);
 	iov->num_VFs = nr_virtfn;
 
@@ -387,9 +290,6 @@ static void sriov_disable(struct pci_dev *dev)
 	if (!iov->num_VFs)
 		return;
 
-	if (iov->cap & PCI_SRIOV_CAP_VFM)
-		sriov_disable_migration(dev);
-
 	for (i = 0; i < iov->num_VFs; i++)
 		virtfn_remove(dev, i, 0);
 
@@ -688,25 +588,6 @@ void pci_disable_sriov(struct pci_dev *dev)
 EXPORT_SYMBOL_GPL(pci_disable_sriov);
 
 /**
- * pci_sriov_migration - notify SR-IOV core of Virtual Function Migration
- * @dev: the PCI device
- *
- * Returns IRQ_HANDLED if the IRQ is handled, or IRQ_NONE if not.
- *
- * Physical Function driver is responsible to register IRQ handler using
- * VF Migration Interrupt Message Number, and call this function when the
- * interrupt is generated by the hardware.
- */
-irqreturn_t pci_sriov_migration(struct pci_dev *dev)
-{
-	if (!dev->is_physfn)
-		return IRQ_NONE;
-
-	return sriov_migration(dev) ? IRQ_HANDLED : IRQ_NONE;
-}
-EXPORT_SYMBOL_GPL(pci_sriov_migration);
-
-/**
  * pci_num_vf - return number of VFs associated with a PF device_release_driver
  * @dev: the PCI device
  *
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 4df38df224f4..6bd082299e31 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -1,8 +1,6 @@
 #ifndef DRIVERS_PCI_H
 #define DRIVERS_PCI_H
 
-#include <linux/workqueue.h>
-
 #define PCI_CFG_SPACE_SIZE	256
 #define PCI_CFG_SPACE_EXP_SIZE	4096
 
@@ -240,8 +238,6 @@ struct pci_sriov {
 	struct pci_dev *dev;	/* lowest numbered PF */
 	struct pci_dev *self;	/* this PF */
 	struct mutex lock;	/* lock for VF bus */
-	struct work_struct mtask; /* VF Migration task */
-	u8 __iomem *mstate;	/* VF Migration State Array */
 };
 
 #ifdef CONFIG_PCI_ATS
diff --git a/include/linux/pci.h b/include/linux/pci.h
index fb57c892b214..230a8dabc5a3 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -29,7 +29,6 @@
 #include <linux/atomic.h>
 #include <linux/device.h>
 #include <linux/io.h>
-#include <linux/irqreturn.h>
 #include <uapi/linux/pci.h>
 
 #include <linux/pci_ids.h>
@@ -1577,7 +1576,6 @@ void __iomem *pci_ioremap_bar(struct pci_dev *pdev, int bar);
 #ifdef CONFIG_PCI_IOV
 int pci_enable_sriov(struct pci_dev *dev, int nr_virtfn);
 void pci_disable_sriov(struct pci_dev *dev);
-irqreturn_t pci_sriov_migration(struct pci_dev *dev);
 int pci_num_vf(struct pci_dev *dev);
 int pci_vfs_assigned(struct pci_dev *dev);
 int pci_sriov_set_totalvfs(struct pci_dev *dev, u16 numvfs);
@@ -1586,8 +1584,6 @@ int pci_sriov_get_totalvfs(struct pci_dev *dev);
 static inline int pci_enable_sriov(struct pci_dev *dev, int nr_virtfn)
 { return -ENODEV; }
 static inline void pci_disable_sriov(struct pci_dev *dev) { }
-static inline irqreturn_t pci_sriov_migration(struct pci_dev *dev)
-{ return IRQ_NONE; }
 static inline int pci_num_vf(struct pci_dev *dev) { return 0; }
 static inline int pci_vfs_assigned(struct pci_dev *dev)
 { return 0; }
