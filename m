From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v5 2/2] vfio/iommu_type1: add new VFIO_TYPE1_NESTING_IOMMU
	IOMMU type
Date: Thu, 25 Sep 2014 18:45:01 +0100
Message-ID: <1411667101-26197-3-git-send-email-will.deacon@arm.com>
References: <1411667101-26197-1-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1411667101-26197-1-git-send-email-will.deacon-5wv7dgnIgG8@public.gmane.org>
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
translation services to the guest operating system, which are nested
with the existing translation installed by VFIO. However, enabling this
feature means that the IOMMU driver must be informed that the VFIO domain
is being created for the purposes of nested translation.

This patch adds a new IOMMU type (VFIO_TYPE1_NESTING_IOMMU) to the VFIO
type-1 driver. The new IOMMU type acts identically to the
VFIO_TYPE1v2_IOMMU type, but additionally sets the DOMAIN_ATTR_NESTING
attribute on its IOMMU domains.

Cc: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
---
 drivers/vfio/vfio_iommu_type1.c | 30 +++++++++++++++++++++++++-----
 include/uapi/linux/vfio.h       |  3 +++
 2 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 0734fbe5b651..583ccdb2c58f 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -57,7 +57,8 @@ struct vfio_iommu {
 	struct list_head	domain_list;
 	struct mutex		lock;
 	struct rb_root		dma_list;
-	bool v2;
+	bool			v2;
+	bool			nesting;
 };
 
 struct vfio_domain {
@@ -705,6 +706,15 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 		goto out_free;
 	}
 
+	if (iommu->nesting) {
+		int attr = 1;
+
+		ret = iommu_domain_set_attr(domain->domain, DOMAIN_ATTR_NESTING,
+					    &attr);
+		if (ret)
+			goto out_domain;
+	}
+
 	ret = iommu_attach_group(domain->domain, iommu_group);
 	if (ret)
 		goto out_domain;
@@ -819,17 +829,26 @@ static void *vfio_iommu_type1_open(unsigned long arg)
 {
 	struct vfio_iommu *iommu;
 
-	if (arg != VFIO_TYPE1_IOMMU && arg != VFIO_TYPE1v2_IOMMU)
-		return ERR_PTR(-EINVAL);
-
 	iommu = kzalloc(sizeof(*iommu), GFP_KERNEL);
 	if (!iommu)
 		return ERR_PTR(-ENOMEM);
 
+	switch (arg) {
+	case VFIO_TYPE1_IOMMU:
+		break;
+	case VFIO_TYPE1_NESTING_IOMMU:
+		iommu->nesting = true;
+	case VFIO_TYPE1v2_IOMMU:
+		iommu->v2 = true;
+		break;
+	default:
+		kfree(iommu);
+		return ERR_PTR(-EINVAL);
+	}
+
 	INIT_LIST_HEAD(&iommu->domain_list);
 	iommu->dma_list = RB_ROOT;
 	mutex_init(&iommu->lock);
-	iommu->v2 = (arg == VFIO_TYPE1v2_IOMMU);
 
 	return iommu;
 }
@@ -885,6 +904,7 @@ static long vfio_iommu_type1_ioctl(void *iommu_data,
 		switch (arg) {
 		case VFIO_TYPE1_IOMMU:
 		case VFIO_TYPE1v2_IOMMU:
+		case VFIO_TYPE1_NESTING_IOMMU:
 			return 1;
 		case VFIO_DMA_CC_IOMMU:
 			if (!iommu)
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 6612974c64bf..29715d27548f 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -33,6 +33,9 @@
 /* Check if EEH is supported */
 #define VFIO_EEH			5
 
+/* Two-stage IOMMU */
+#define VFIO_TYPE1_NESTING_IOMMU	6	/* Implies v2 */
+
 /*
  * The IOCTL interface is designed for extensibility by embedding the
  * structure length (argsz) and flags into structures passed between
-- 
2.1.0
