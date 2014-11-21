From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 1/3] PCI/MSI: Initial hook for archs to declare multivector
	MSI support
Date: Fri, 21 Nov 2014 15:08:33 -0700
Message-ID: <20141121220833.31095.12371.stgit@gimli.home>
References: <20141121213752.31095.30735.stgit@gimli.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20141121213752.31095.30735.stgit-GCcqpEzw8uZBDLzU/O5InQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org
Cc: linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

For the most part multivector MSI is not supported and drivers and
hardware wanting multiple vectors opt for MSI-X instead.  It seems
though that having the ability to query the arch/platform code to
determine whether allocating multiple MSI vectors will ever succeed
is a useful thing.  For instance, vfio-pci can use this to determine
whether to expose multiple MSI vectors to the user.  If we know we
cannot ever support more than one vector, we have a better shot at
the userspace driver working, especially if it's a guest OS, if we
only expose one vector as being available in the interface.

Signed-off-by: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---

 drivers/pci/msi.c   |    5 +++++
 include/linux/msi.h |    1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 9fab30a..36b503a 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -79,6 +79,11 @@ int __weak arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 	return 0;
 }
 
+bool __weak arch_supports_multivector_msi(struct pci_dev *dev)
+{
+	return false;
+}
+
 /*
  * We have a default implementation available as a separate non-weak
  * function, as it is used by the Xen x86 PCI code
diff --git a/include/linux/msi.h b/include/linux/msi.h
index 44f4746..2365c64 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -58,6 +58,7 @@ void arch_teardown_msi_irq(unsigned int irq);
 int arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type);
 void arch_teardown_msi_irqs(struct pci_dev *dev);
 void arch_restore_msi_irqs(struct pci_dev *dev);
+bool arch_supports_multivector_msi(struct pci_dev *dev);
 
 void default_teardown_msi_irqs(struct pci_dev *dev);
 void default_restore_msi_irqs(struct pci_dev *dev);
