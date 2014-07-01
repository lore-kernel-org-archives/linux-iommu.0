From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [RFC PATCH 2/3] vfio/iommu_type1: add new VFIO_TYPE1_HYP_IOMMU IOMMU
	type
Date: Tue,  1 Jul 2014 17:10:16 +0100
Message-ID: <1404231017-10856-2-git-send-email-will.deacon@arm.com>
References: <1404231017-10856-1-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1404231017-10856-1-git-send-email-will.deacon-5wv7dgnIgG8@public.gmane.org>
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
Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

VFIO allows devices to be safely handed off to userspace by putting
them behind an IOMMU configured to ensure DMA and interrupt isolation.
This enables userspace KVM clients, such as kvmtool and qemu, to further
map the device into a virtual machine.

With IOMMUs such as the ARM SMMU, it is then possible to provide SMMU
translation services to the guest operating system, despite the existing
translation installed by VFIO. However, enabling this feature means that
the IOMMU driver must be informed that the VFIO domain is being created
for the purposes of a hypervisor.

This patch adds a new IOMMU type (VFIO_TYPE1_HYP_IOMMU) to the VFIO
type-1 driver which acts identically to VFIO_TYPE1v2_IOMMU but passes
the IOMMU_DOMAIN_HYP flag when allocating IOMMU domains for the VFIO
groups attached to the IOMMU.

Cc: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
---
 drivers/vfio/vfio_iommu_type1.c | 22 ++++++++++++++++++----
 include/uapi/linux/vfio.h       |  2 ++
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 8ae76774d28e..612db1b84ae8 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -58,6 +58,7 @@ struct vfio_iommu {
 	struct mutex		lock;
 	struct rb_root		dma_list;
 	bool v2;
+	int			domain_flags;
 };
 
 struct vfio_domain {
@@ -699,7 +700,7 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 	if (ret)
 		goto out_free;
 
-	domain->domain = iommu_domain_alloc(bus, IOMMU_DOMAIN_DMA);
+	domain->domain = iommu_domain_alloc(bus, iommu->domain_flags);
 	if (!domain->domain) {
 		ret = -EIO;
 		goto out_free;
@@ -818,9 +819,20 @@ done:
 static void *vfio_iommu_type1_open(unsigned long arg)
 {
 	struct vfio_iommu *iommu;
-
-	if (arg != VFIO_TYPE1_IOMMU && arg != VFIO_TYPE1v2_IOMMU)
+	bool v2 = false;
+	int domain_flags = IOMMU_DOMAIN_DMA;
+
+	switch (arg) {
+	case VFIO_TYPE1_IOMMU:
+		break;
+	case VFIO_TYPE1_HYP_IOMMU:
+		domain_flags = IOMMU_DOMAIN_HYP;
+	case VFIO_TYPE1v2_IOMMU:
+		v2 = true;
+		break;
+	default:
 		return ERR_PTR(-EINVAL);
+	}
 
 	iommu = kzalloc(sizeof(*iommu), GFP_KERNEL);
 	if (!iommu)
@@ -829,7 +841,8 @@ static void *vfio_iommu_type1_open(unsigned long arg)
 	INIT_LIST_HEAD(&iommu->domain_list);
 	iommu->dma_list = RB_ROOT;
 	mutex_init(&iommu->lock);
-	iommu->v2 = (arg == VFIO_TYPE1v2_IOMMU);
+	iommu->v2 = v2;
+	iommu->domain_flags = domain_flags;
 
 	return iommu;
 }
@@ -885,6 +898,7 @@ static long vfio_iommu_type1_ioctl(void *iommu_data,
 		switch (arg) {
 		case VFIO_TYPE1_IOMMU:
 		case VFIO_TYPE1v2_IOMMU:
+		case VFIO_TYPE1_HYP_IOMMU:
 			return 1;
 		case VFIO_DMA_CC_IOMMU:
 			if (!iommu)
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index cb9023d4f063..871cf6dfe631 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -29,6 +29,8 @@
  * capability is subject to change as groups are added or removed.
  */
 #define VFIO_DMA_CC_IOMMU		4
+#define VFIO_TYPE1_HYP_IOMMU		5	/* Implies v2 */
+
 
 /*
  * The IOCTL interface is designed for extensibility by embedding the
-- 
2.0.0
