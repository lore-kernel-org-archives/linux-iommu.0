From: Wei Yang <richard.weiyang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/2] PCI: add a function to walk on local bus
Date: Fri,  5 Aug 2016 13:47:46 +0000
Message-ID: <1470404867-26783-1-git-send-email-richard.weiyang@gmail.com>
References: <20160728090132.42c6ebc1@t450s.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20160728090132.42c6ebc1-1yVPhWWZRC1BDLzU/O5InQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, jroedel-l3A5Bk7waGM@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Add a function to just walk on the local bus.

Signed-off-by: Wei Yang <richard.weiyang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/pci/bus.c   | 26 +++++++++++++++++++++-----
 include/linux/pci.h |  2 ++
 2 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index dd7cdbe..ccf4290 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -338,17 +338,19 @@ EXPORT_SYMBOL(pci_bus_add_devices);
  *  @top      bus whose devices should be walked
  *  @cb       callback to be called for each device found
  *  @userdata arbitrary pointer to be passed to callback.
+ *  @local    whether it just walk on the local bus
  *
  *  Walk the given bus, including any bridged devices
- *  on buses under this bus.  Call the provided callback
- *  on each device found.
+ *  on buses under this bus if "local" is false.
+ *  Call the provided callback on each device found.
  *
  *  We check the return of @cb each time. If it returns anything
  *  other than 0, we break out.
  *
  */
-void pci_walk_bus(struct pci_bus *top, int (*cb)(struct pci_dev *, void *),
-		  void *userdata)
+static void __pci_walk_bus(struct pci_bus *top,
+			   int (*cb)(struct pci_dev *, void *),
+			   void *userdata, bool local)
 {
 	struct pci_dev *dev;
 	struct pci_bus *bus;
@@ -368,7 +370,7 @@ void pci_walk_bus(struct pci_bus *top, int (*cb)(struct pci_dev *, void *),
 			continue;
 		}
 		dev = list_entry(next, struct pci_dev, bus_list);
-		if (dev->subordinate) {
+		if (dev->subordinate && !local) {
 			/* this is a pci-pci bridge, do its devices next */
 			next = dev->subordinate->devices.next;
 			bus = dev->subordinate;
@@ -381,8 +383,22 @@ void pci_walk_bus(struct pci_bus *top, int (*cb)(struct pci_dev *, void *),
 	}
 	up_read(&pci_bus_sem);
 }
+
+void pci_walk_bus(struct pci_bus *top, int (*cb)(struct pci_dev *, void *),
+		  void *userdata)
+{
+	__pci_walk_bus(top, cb, userdata, false);
+}
 EXPORT_SYMBOL_GPL(pci_walk_bus);
 
+void pci_walk_bus_local(struct pci_bus *top,
+			int (*cb)(struct pci_dev *, void *),
+			void *userdata)
+{
+	__pci_walk_bus(top, cb, userdata, true);
+}
+EXPORT_SYMBOL_GPL(pci_walk_bus_local);
+
 struct pci_bus *pci_bus_get(struct pci_bus *bus)
 {
 	if (bus)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index b67e4df..e43df8c 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1224,6 +1224,8 @@ int pci_scan_bridge(struct pci_bus *bus, struct pci_dev *dev, int max,
 
 void pci_walk_bus(struct pci_bus *top, int (*cb)(struct pci_dev *, void *),
 		  void *userdata);
+void pci_walk_bus_local(struct pci_bus *top,
+		  int (*cb)(struct pci_dev *, void *), void *userdata);
 int pci_cfg_space_size(struct pci_dev *dev);
 unsigned char pci_bus_max_busnr(struct pci_bus *bus);
 void pci_setup_bridge(struct pci_bus *bus);
-- 
2.5.0
