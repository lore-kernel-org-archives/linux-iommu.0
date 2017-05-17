From: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v8 03/08] iommu/ipmmu-vmsa: Break out utlb parsing code
Date: Wed, 17 May 2017 19:06:48 +0900
Message-ID: <149501560877.21593.10455371761556148369.sendpatchset@little-apple>
References: <149501557669.21593.1017116915706613060.sendpatchset@little-apple>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <149501557669.21593.1017116915706613060.sendpatchset@little-apple>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, will.deacon-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>

Break out the utlb parsing code and dev_data allocation into a
separate function. This is preparation for future code sharing.

Signed-off-by: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>
Reviewed-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---

 Changes since V7:
 - Free archdata and utlbs in case of error

 drivers/iommu/ipmmu-vmsa.c |   64 ++++++++++++++++++++++++++++----------------
 1 file changed, 41 insertions(+), 23 deletions(-)

--- 0004/drivers/iommu/ipmmu-vmsa.c
+++ work/drivers/iommu/ipmmu-vmsa.c	2017-05-17 16:37:29.080607110 +0900
@@ -649,22 +649,15 @@ static int ipmmu_find_utlbs(struct ipmmu
 	return 0;
 }
 
-static int ipmmu_add_device(struct device *dev)
+static int ipmmu_init_platform_device(struct device *dev)
 {
 	struct ipmmu_vmsa_archdata *archdata;
 	struct ipmmu_vmsa_device *mmu;
-	struct iommu_group *group = NULL;
 	unsigned int *utlbs;
 	unsigned int i;
 	int num_utlbs;
 	int ret = -ENODEV;
 
-	if (dev->archdata.iommu) {
-		dev_warn(dev, "IOMMU driver already assigned to device %s\n",
-			 dev_name(dev));
-		return -EINVAL;
-	}
-
 	/* Find the master corresponding to the device. */
 
 	num_utlbs = of_count_phandle_with_args(dev->of_node, "iommus",
@@ -701,6 +694,36 @@ static int ipmmu_add_device(struct devic
 		}
 	}
 
+	archdata = kzalloc(sizeof(*archdata), GFP_KERNEL);
+	if (!archdata) {
+		ret = -ENOMEM;
+		goto error;
+	}
+
+	archdata->mmu = mmu;
+	archdata->utlbs = utlbs;
+	archdata->num_utlbs = num_utlbs;
+	dev->archdata.iommu = archdata;
+	return 0;
+
+error:
+	kfree(utlbs);
+	return ret;
+}
+
+static int ipmmu_add_device(struct device *dev)
+{
+	struct ipmmu_vmsa_archdata *archdata;
+	struct ipmmu_vmsa_device *mmu = NULL;
+	struct iommu_group *group;
+	int ret;
+
+	if (dev->archdata.iommu) {
+		dev_warn(dev, "IOMMU driver already assigned to device %s\n",
+			 dev_name(dev));
+		return -EINVAL;
+	}
+
 	/* Create a device group and add the device to it. */
 	group = iommu_group_alloc();
 	if (IS_ERR(group)) {
@@ -718,16 +741,9 @@ static int ipmmu_add_device(struct devic
 		goto error;
 	}
 
-	archdata = kzalloc(sizeof(*archdata), GFP_KERNEL);
-	if (!archdata) {
-		ret = -ENOMEM;
+	ret = ipmmu_init_platform_device(dev);
+	if (ret < 0)
 		goto error;
-	}
-
-	archdata->mmu = mmu;
-	archdata->utlbs = utlbs;
-	archdata->num_utlbs = num_utlbs;
-	dev->archdata.iommu = archdata;
 
 	/*
 	 * Create the ARM mapping, used by the ARM DMA mapping core to allocate
@@ -738,6 +754,8 @@ static int ipmmu_add_device(struct devic
 	 * - Make the mapping size configurable ? We currently use a 2GB mapping
 	 *   at a 1GB offset to ensure that NULL VAs will fault.
 	 */
+	archdata = dev->archdata.iommu;
+	mmu = archdata->mmu;
 	if (!mmu->mapping) {
 		struct dma_iommu_mapping *mapping;
 
@@ -762,16 +780,16 @@ static int ipmmu_add_device(struct devic
 	return 0;
 
 error:
-	arm_iommu_release_mapping(mmu->mapping);
-
-	kfree(dev->archdata.iommu);
-	kfree(utlbs);
-
-	dev->archdata.iommu = NULL;
+	if (mmu)
+		arm_iommu_release_mapping(mmu->mapping);
 
 	if (!IS_ERR_OR_NULL(group))
 		iommu_group_remove_device(dev);
 
+	kfree(archdata->utlbs);
+	kfree(archdata);
+	dev->archdata.iommu = NULL;
+
 	return ret;
 }
 
