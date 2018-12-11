From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 8/9] iommu/qcom: Use helper functions to access dev->iommu_fwspec
Date: Tue, 11 Dec 2018 13:19:09 +0100
Message-ID: <20181211121910.5604-9-joro@8bytes.org>
References: <20181211121910.5604-1-joro@8bytes.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181211121910.5604-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, Will Deacon <will.deacon@arm.com>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Matthias Brugger <matthias.bgg@gmail.com>, Rob Clark <robdclark@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel@suse.de>

Use the new helpers dev_iommu_fwspec_get()/set() to access
the dev->iommu_fwspec pointer. This makes it easier to move
that pointer later into another struct.

Cc: Rob Clark <robdclark@gmail.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/qcom_iommu.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/qcom_iommu.c b/drivers/iommu/qcom_iommu.c
index ee70e9921cf1..f437bf9c5ebd 100644
--- a/drivers/iommu/qcom_iommu.c
+++ b/drivers/iommu/qcom_iommu.c
@@ -354,7 +354,8 @@ static void qcom_iommu_domain_free(struct iommu_domain *domain)
 
 static int qcom_iommu_attach_dev(struct iommu_domain *domain, struct device *dev)
 {
-	struct qcom_iommu_dev *qcom_iommu = to_iommu(dev->iommu_fwspec);
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	struct qcom_iommu_dev *qcom_iommu = to_iommu(fwspec);
 	struct qcom_iommu_domain *qcom_domain = to_qcom_iommu_domain(domain);
 	int ret;
 
@@ -365,7 +366,7 @@ static int qcom_iommu_attach_dev(struct iommu_domain *domain, struct device *dev
 
 	/* Ensure that the domain is finalized */
 	pm_runtime_get_sync(qcom_iommu->dev);
-	ret = qcom_iommu_init_domain(domain, qcom_iommu, dev->iommu_fwspec);
+	ret = qcom_iommu_init_domain(domain, qcom_iommu, fwspec);
 	pm_runtime_put_sync(qcom_iommu->dev);
 	if (ret < 0)
 		return ret;
@@ -387,7 +388,7 @@ static int qcom_iommu_attach_dev(struct iommu_domain *domain, struct device *dev
 
 static void qcom_iommu_detach_dev(struct iommu_domain *domain, struct device *dev)
 {
-	struct iommu_fwspec *fwspec = dev->iommu_fwspec;
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct qcom_iommu_dev *qcom_iommu = to_iommu(fwspec);
 	struct qcom_iommu_domain *qcom_domain = to_qcom_iommu_domain(domain);
 	unsigned i;
@@ -500,7 +501,7 @@ static bool qcom_iommu_capable(enum iommu_cap cap)
 
 static int qcom_iommu_add_device(struct device *dev)
 {
-	struct qcom_iommu_dev *qcom_iommu = to_iommu(dev->iommu_fwspec);
+	struct qcom_iommu_dev *qcom_iommu = to_iommu(dev_iommu_fwspec_get(dev));
 	struct iommu_group *group;
 	struct device_link *link;
 
@@ -531,7 +532,7 @@ static int qcom_iommu_add_device(struct device *dev)
 
 static void qcom_iommu_remove_device(struct device *dev)
 {
-	struct qcom_iommu_dev *qcom_iommu = to_iommu(dev->iommu_fwspec);
+	struct qcom_iommu_dev *qcom_iommu = to_iommu(dev_iommu_fwspec_get(dev));
 
 	if (!qcom_iommu)
 		return;
@@ -543,6 +544,7 @@ static void qcom_iommu_remove_device(struct device *dev)
 
 static int qcom_iommu_of_xlate(struct device *dev, struct of_phandle_args *args)
 {
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct qcom_iommu_dev *qcom_iommu;
 	struct platform_device *iommu_pdev;
 	unsigned asid = args->args[0];
@@ -568,14 +570,14 @@ static int qcom_iommu_of_xlate(struct device *dev, struct of_phandle_args *args)
 	    WARN_ON(asid > qcom_iommu->num_ctxs))
 		return -EINVAL;
 
-	if (!dev->iommu_fwspec->iommu_priv) {
-		dev->iommu_fwspec->iommu_priv = qcom_iommu;
+	if (!fwspec->iommu_priv) {
+		fwspec->iommu_priv = qcom_iommu;
 	} else {
 		/* make sure devices iommus dt node isn't referring to
 		 * multiple different iommu devices.  Multiple context
 		 * banks are ok, but multiple devices are not:
 		 */
-		if (WARN_ON(qcom_iommu != dev->iommu_fwspec->iommu_priv))
+		if (WARN_ON(qcom_iommu != fwspec->iommu_priv))
 			return -EINVAL;
 	}
 
-- 
2.17.1
