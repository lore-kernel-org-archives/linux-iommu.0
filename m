Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0F91C34
	for <iommu@lists.linux.dev>; Mon, 15 Aug 2022 15:26:55 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 687801FB;
	Mon, 15 Aug 2022 08:26:55 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E55353F70D;
	Mon, 15 Aug 2022 08:26:53 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org,
	will@kernel.org
Cc: iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/2] iommu: Retire iommu_capable()
Date: Mon, 15 Aug 2022 16:26:49 +0100
Message-Id: <d8bd8777d06929ad8f49df7fc80e1b9af32a41b5.1660574547.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.36.1.dirty
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With all callers now converted to the device-specific version, retire
the old bus-based interface, and give drivers the chance to indicate
accurate per-instance capabilities.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/amd/iommu.c                   |  2 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  2 +-
 drivers/iommu/arm/arm-smmu/arm-smmu.c       |  2 +-
 drivers/iommu/arm/arm-smmu/qcom_iommu.c     |  2 +-
 drivers/iommu/fsl_pamu_domain.c             |  2 +-
 drivers/iommu/intel/iommu.c                 |  2 +-
 drivers/iommu/iommu.c                       | 11 +----------
 drivers/iommu/s390-iommu.c                  |  2 +-
 include/linux/iommu.h                       |  8 +-------
 9 files changed, 9 insertions(+), 24 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 65b8e4fd8217..94220eb5bff3 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2251,7 +2251,7 @@ static phys_addr_t amd_iommu_iova_to_phys(struct iommu_domain *dom,
 	return ops->iova_to_phys(ops, iova);
 }
 
-static bool amd_iommu_capable(enum iommu_cap cap)
+static bool amd_iommu_capable(struct device *dev, enum iommu_cap cap)
 {
 	switch (cap) {
 	case IOMMU_CAP_CACHE_COHERENCY:
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index d32b02336411..ab919ec43c4d 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1992,7 +1992,7 @@ static const struct iommu_flush_ops arm_smmu_flush_ops = {
 };
 
 /* IOMMU API */
-static bool arm_smmu_capable(enum iommu_cap cap)
+static bool arm_smmu_capable(struct device *dev, enum iommu_cap cap)
 {
 	switch (cap) {
 	case IOMMU_CAP_CACHE_COHERENCY:
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index dfa82df00342..ce036a053fb8 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -1330,7 +1330,7 @@ static phys_addr_t arm_smmu_iova_to_phys(struct iommu_domain *domain,
 	return ops->iova_to_phys(ops, iova);
 }
 
-static bool arm_smmu_capable(enum iommu_cap cap)
+static bool arm_smmu_capable(struct device *dev, enum iommu_cap cap)
 {
 	switch (cap) {
 	case IOMMU_CAP_CACHE_COHERENCY:
diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
index 17235116d3bb..66ca47f2e57f 100644
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
index 011f9ab7f743..08fd9089e3ba 100644
--- a/drivers/iommu/fsl_pamu_domain.c
+++ b/drivers/iommu/fsl_pamu_domain.c
@@ -178,7 +178,7 @@ static phys_addr_t fsl_pamu_iova_to_phys(struct iommu_domain *domain,
 	return iova;
 }
 
-static bool fsl_pamu_capable(enum iommu_cap cap)
+static bool fsl_pamu_capable(struct device *dev, enum iommu_cap cap)
 {
 	return cap == IOMMU_CAP_CACHE_COHERENCY;
 }
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 7cca030a508e..da63b358ef4a 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4429,7 +4429,7 @@ static bool intel_iommu_enforce_cache_coherency(struct iommu_domain *domain)
 	return true;
 }
 
-static bool intel_iommu_capable(enum iommu_cap cap)
+static bool intel_iommu_capable(struct device *dev, enum iommu_cap cap)
 {
 	if (cap == IOMMU_CAP_CACHE_COHERENCY)
 		return true;
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 780fb7071577..6283a8b4def4 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1869,19 +1869,10 @@ bool device_iommu_capable(struct device *dev, enum iommu_cap cap)
 	if (!ops->capable)
 		return false;
 
-	return ops->capable(cap);
+	return ops->capable(dev, cap);
 }
 EXPORT_SYMBOL_GPL(device_iommu_capable);
 
-bool iommu_capable(struct bus_type *bus, enum iommu_cap cap)
-{
-	if (!bus->iommu_ops || !bus->iommu_ops->capable)
-		return false;
-
-	return bus->iommu_ops->capable(cap);
-}
-EXPORT_SYMBOL_GPL(iommu_capable);
-
 /**
  * iommu_set_fault_handler() - set a fault handler for an iommu domain
  * @domain: iommu domain
diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
index c898bcbbce11..cd0ee89d63e0 100644
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
index ea30f00dc145..e39372dfe8c4 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -227,7 +227,7 @@ struct iommu_iotlb_gather {
  * @owner: Driver module providing these ops
  */
 struct iommu_ops {
-	bool (*capable)(enum iommu_cap);
+	bool (*capable)(struct device *dev, enum iommu_cap);
 
 	/* Domain allocation and freeing by the iommu driver */
 	struct iommu_domain *(*domain_alloc)(unsigned iommu_domain_type);
@@ -420,7 +420,6 @@ extern int bus_set_iommu(struct bus_type *bus, const struct iommu_ops *ops);
 extern int bus_iommu_probe(struct bus_type *bus);
 extern bool iommu_present(struct bus_type *bus);
 extern bool device_iommu_capable(struct device *dev, enum iommu_cap cap);
-extern bool iommu_capable(struct bus_type *bus, enum iommu_cap cap);
 extern struct iommu_domain *iommu_domain_alloc(struct bus_type *bus);
 extern struct iommu_group *iommu_group_get_by_id(int id);
 extern void iommu_domain_free(struct iommu_domain *domain);
@@ -697,11 +696,6 @@ static inline bool device_iommu_capable(struct device *dev, enum iommu_cap cap)
 	return false;
 }
 
-static inline bool iommu_capable(struct bus_type *bus, enum iommu_cap cap)
-{
-	return false;
-}
-
 static inline struct iommu_domain *iommu_domain_alloc(struct bus_type *bus)
 {
 	return NULL;
-- 
2.36.1.dirty

