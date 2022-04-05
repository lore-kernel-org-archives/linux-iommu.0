Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C22DBC433F5
	for <iommu@archiver.kernel.org>; Tue,  5 Apr 2022 10:41:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 77A59824DD;
	Tue,  5 Apr 2022 10:41:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Vcz6OeKeGaOK; Tue,  5 Apr 2022 10:41:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4659F81D5C;
	Tue,  5 Apr 2022 10:41:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CCDE4C0012;
	Tue,  5 Apr 2022 10:41:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4E200C0012
 for <iommu@lists.linux-foundation.org>; Tue,  5 Apr 2022 10:41:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2DC6981D5C
 for <iommu@lists.linux-foundation.org>; Tue,  5 Apr 2022 10:41:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7TkaPsD6m3Qb for <iommu@lists.linux-foundation.org>;
 Tue,  5 Apr 2022 10:41:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id 460DF81D5A
 for <iommu@lists.linux-foundation.org>; Tue,  5 Apr 2022 10:41:11 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B36D91474;
 Tue,  5 Apr 2022 03:41:10 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com
 [10.1.196.40])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4CDD73F5A1;
 Tue,  5 Apr 2022 03:41:09 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org, baolu.lu@linux.intel.com, andreas.noever@gmail.com,
 michael.jamet@intel.com, mika.westerberg@linux.intel.com,
 YehezkelShB@gmail.com
Subject: [PATCH v3 1/4] iommu: Introduce device_iommu_capable()
Date: Tue,  5 Apr 2022 11:41:01 +0100
Message-Id: <37ec2f9f67098d0caf60dcec558fbe1756ea2621.1649089693.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.28.0.dirty
In-Reply-To: <cover.1649089693.git.robin.murphy@arm.com>
References: <cover.1649089693.git.robin.murphy@arm.com>
MIME-Version: 1.0
Cc: iommu@lists.linux-foundation.org, linux-usb@vger.kernel.org, hch@lst.de,
 linux-kernel@vger.kernel.org, mario.limonciello@amd.com
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

iommu_capable() only really works for systems where all IOMMU instances
are completely homogeneous, and all devices are IOMMU-mapped. Implement
the new variant which can give an accurate answer for whichever device
the caller is actually interested in.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v3: New patch; now that the dev_iommu_ops() work has landed we can go
    straight to a proper implementation. Also s/dev/device/ to match
    the precedent of device_iommu_mapped() for the public API.

 drivers/iommu/amd/iommu.c                   |  2 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  2 +-
 drivers/iommu/arm/arm-smmu/arm-smmu.c       |  2 +-
 drivers/iommu/arm/arm-smmu/qcom_iommu.c     |  2 +-
 drivers/iommu/fsl_pamu_domain.c             |  2 +-
 drivers/iommu/intel/iommu.c                 |  2 +-
 drivers/iommu/iommu.c                       | 25 ++++++++++++++++++++-
 drivers/iommu/s390-iommu.c                  |  2 +-
 include/linux/iommu.h                       |  8 ++++++-
 9 files changed, 38 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 1160a13c80ab..e412a50dce59 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2132,7 +2132,7 @@ static phys_addr_t amd_iommu_iova_to_phys(struct iommu_domain *dom,
 	return ops->iova_to_phys(ops, iova);
 }
 
-static bool amd_iommu_capable(enum iommu_cap cap)
+static bool amd_iommu_capable(struct device *dev, enum iommu_cap cap)
 {
 	switch (cap) {
 	case IOMMU_CAP_CACHE_COHERENCY:
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 73b7b1b17b77..b221525c31b9 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1981,7 +1981,7 @@ static const struct iommu_flush_ops arm_smmu_flush_ops = {
 };
 
 /* IOMMU API */
-static bool arm_smmu_capable(enum iommu_cap cap)
+static bool arm_smmu_capable(struct device *dev, enum iommu_cap cap)
 {
 	switch (cap) {
 	case IOMMU_CAP_CACHE_COHERENCY:
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index f0bec4a35df5..34cab56b9c6d 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -1313,7 +1313,7 @@ static phys_addr_t arm_smmu_iova_to_phys(struct iommu_domain *domain,
 	return ops->iova_to_phys(ops, iova);
 }
 
-static bool arm_smmu_capable(enum iommu_cap cap)
+static bool arm_smmu_capable(struct device *dev, enum iommu_cap cap)
 {
 	switch (cap) {
 	case IOMMU_CAP_CACHE_COHERENCY:
diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
index 80af00f468b4..028649203d33 100644
--- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
+++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
@@ -493,7 +493,7 @@ static phys_addr_t qcom_iommu_iova_to_phys(struct iommu_domain *domain,
 	return ret;
 }
 
-static bool qcom_iommu_capable(enum iommu_cap cap)
+static bool qcom_iommu_capable(struct device *dev, enum iommu_cap cap)
 {
 	switch (cap) {
 	case IOMMU_CAP_CACHE_COHERENCY:
diff --git a/drivers/iommu/fsl_pamu_domain.c b/drivers/iommu/fsl_pamu_domain.c
index 7274f86b2bc4..ddf5ab28615c 100644
--- a/drivers/iommu/fsl_pamu_domain.c
+++ b/drivers/iommu/fsl_pamu_domain.c
@@ -177,7 +177,7 @@ static phys_addr_t fsl_pamu_iova_to_phys(struct iommu_domain *domain,
 	return iova;
 }
 
-static bool fsl_pamu_capable(enum iommu_cap cap)
+static bool fsl_pamu_capable(struct device *dev, enum iommu_cap cap)
 {
 	return cap == IOMMU_CAP_CACHE_COHERENCY;
 }
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 21111491ddfd..255304eb3b1f 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4544,7 +4544,7 @@ static phys_addr_t intel_iommu_iova_to_phys(struct iommu_domain *domain,
 	return phys;
 }
 
-static bool intel_iommu_capable(enum iommu_cap cap)
+static bool intel_iommu_capable(struct device *dev, enum iommu_cap cap)
 {
 	if (cap == IOMMU_CAP_CACHE_COHERENCY)
 		return domain_update_iommu_snooping(NULL);
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index efad7c1675e0..469574e84e6a 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1889,12 +1889,35 @@ static int iommu_bus_init(struct bus_type *bus)
 	return err;
 }
 
+/**
+ * device_iommu_capable() - check for a general IOMMU capability
+ * @dev: device to which the capability would be relevant, if available
+ * @cap: IOMMU capability
+ *
+ * Return: true if an IOMMU is present and supports the given capability
+ * for the given device, otherwise false.
+ */
+bool device_iommu_capable(struct device *dev, enum iommu_cap cap)
+{
+	const struct iommu_ops *ops;
+
+	if (!dev->iommu || !dev->iommu->iommu_dev)
+		return false;
+
+	ops = dev_iommu_ops(dev);
+	if (!ops->capable)
+		return false;
+
+	return ops->capable(dev, cap);
+}
+EXPORT_SYMBOL_GPL(device_iommu_capable);
+
 bool iommu_capable(struct bus_type *bus, enum iommu_cap cap)
 {
 	if (!bus->iommu_ops || !bus->iommu_ops->capable)
 		return false;
 
-	return bus->iommu_ops->capable(cap);
+	return bus->iommu_ops->capable(NULL, cap);
 }
 EXPORT_SYMBOL_GPL(iommu_capable);
 
diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
index 5f5f4bd91e6f..ea4ba9de04af 100644
--- a/drivers/iommu/s390-iommu.c
+++ b/drivers/iommu/s390-iommu.c
@@ -39,7 +39,7 @@ static struct s390_domain *to_s390_domain(struct iommu_domain *dom)
 	return container_of(dom, struct s390_domain, domain);
 }
 
-static bool s390_iommu_capable(enum iommu_cap cap)
+static bool s390_iommu_capable(struct device *dev, enum iommu_cap cap)
 {
 	switch (cap) {
 	case IOMMU_CAP_CACHE_COHERENCY:
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 4a25f8241207..1fa927e6f1c6 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -219,7 +219,7 @@ struct iommu_iotlb_gather {
  * @owner: Driver module providing these ops
  */
 struct iommu_ops {
-	bool (*capable)(enum iommu_cap);
+	bool (*capable)(struct device *dev, enum iommu_cap);
 
 	/* Domain allocation and freeing by the iommu driver */
 	struct iommu_domain *(*domain_alloc)(unsigned iommu_domain_type);
@@ -415,6 +415,7 @@ static inline const struct iommu_ops *dev_iommu_ops(struct device *dev)
 #define IOMMU_GROUP_NOTIFY_UNBOUND_DRIVER	6 /* Post Driver unbind */
 
 extern int bus_iommu_probe(struct bus_type *bus);
+extern bool device_iommu_capable(struct device *dev, enum iommu_cap cap);
 extern bool iommu_capable(struct bus_type *bus, enum iommu_cap cap);
 extern struct iommu_domain *iommu_domain_alloc(struct device *dev);
 extern struct iommu_group *iommu_group_get_by_id(int id);
@@ -682,6 +683,11 @@ struct iommu_device {};
 struct iommu_fault_param {};
 struct iommu_iotlb_gather {};
 
+static inline bool device_iommu_capable(struct device *dev, enum iommu_cap cap)
+{
+	return false;
+}
+
 static inline bool iommu_capable(struct bus_type *bus, enum iommu_cap cap)
 {
 	return false;
-- 
2.28.0.dirty

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
