From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 4/6] powerpc/iommu: Use device_iommu_mapped()
Date: Tue, 11 Dec 2018 14:43:41 +0100
Message-ID: <20181211134343.10664-5-joro@8bytes.org>
References: <20181211134343.10664-1-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20181211134343.10664-1-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Mathias Nyman <mathias.nyman-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Sam Bobroff <sbobroff-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Russell Currey <ruscur-3Su/lFKaw5ejKv3TNrM5DQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vinod Koul <vkoul-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, jroedel-l3A5Bk7waGM@public.gmane.org, oohall-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Michael Ellerman <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>, Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

Use the new function to replace the open-coded iommu check.

Cc: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Cc: Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>
Cc: Russell Currey <ruscur-3Su/lFKaw5ejKv3TNrM5DQ@public.gmane.org>
Cc: Sam Bobroff <sbobroff-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org>
Acked-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 arch/powerpc/kernel/eeh.c   | 2 +-
 arch/powerpc/kernel/iommu.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 6cae6b56ffd6..23fe62f11486 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -1472,7 +1472,7 @@ static int dev_has_iommu_table(struct device *dev, void *data)
 	if (!dev)
 		return 0;
 
-	if (dev->iommu_group) {
+	if (device_iommu_mapped(dev)) {
 		*ppdev = pdev;
 		return 1;
 	}
diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index f0dc680e659a..48d58d1dcac2 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -1086,7 +1086,7 @@ int iommu_add_device(struct device *dev)
 	if (!device_is_registered(dev))
 		return -ENOENT;
 
-	if (dev->iommu_group) {
+	if (device_iommu_mapped(dev)) {
 		pr_debug("%s: Skipping device %s with iommu group %d\n",
 			 __func__, dev_name(dev),
 			 iommu_group_id(dev->iommu_group));
@@ -1129,7 +1129,7 @@ void iommu_del_device(struct device *dev)
 	 * and we needn't detach them from the associated
 	 * IOMMU groups
 	 */
-	if (!dev->iommu_group) {
+	if (!device_iommu_mapped(dev)) {
 		pr_debug("iommu_tce: skipping device %s with no tbl\n",
 			 dev_name(dev));
 		return;
@@ -1148,7 +1148,7 @@ static int tce_iommu_bus_notifier(struct notifier_block *nb,
         case BUS_NOTIFY_ADD_DEVICE:
                 return iommu_add_device(dev);
         case BUS_NOTIFY_DEL_DEVICE:
-                if (dev->iommu_group)
+                if (device_iommu_mapped(dev))
                         iommu_del_device(dev);
                 return 0;
         default:
-- 
2.17.1
