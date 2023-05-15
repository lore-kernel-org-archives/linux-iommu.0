Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B08BC2E8
	for <iommu@lists.linux.dev>; Mon, 15 May 2023 12:49:40 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9E66AFEC;
	Mon, 15 May 2023 05:50:24 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EA8053F67D;
	Mon, 15 May 2023 05:49:38 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org
Cc: iommu@lists.linux.dev,
	will@kernel.org,
	jgg@nvidia.com,
	digetx@gmail.com,
	thierry.reding@gmail.com,
	linux-tegra@vger.kernel.org
Subject: [PATCH 2/4] iommu/tegra-gart: Improve domain support
Date: Mon, 15 May 2023 13:49:30 +0100
Message-Id: <11f282c5d1db884e9f187cc4639add28faa4ee13.1684154219.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
In-Reply-To: <cover.1684154219.git.robin.murphy@arm.com>
References: <cover.1684154219.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rework the saving of mappings over suspend/resume by moving the data
from the GART instance to the domain itself, and keeping it actively up
to date. This saves having to read everything back out of the hardware
at suspend time, but also lets us make the attach path actually support
the notion of multiple domains that it was already checking for. With
this in place we'll then be ready to tackle the remaining assumptions...

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/tegra-gart.c | 87 ++++++++++++++++++++++++--------------
 1 file changed, 56 insertions(+), 31 deletions(-)

diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index deedb9f0f380..a74648655dac 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -33,15 +33,19 @@
 /* bitmap of the page sizes currently supported */
 #define GART_IOMMU_PGSIZES	(GART_PAGE_SIZE)
 
+struct gart_domain {
+	struct iommu_domain	domain;
+	u32			*savedata;
+};
+
 struct gart_device {
 	void __iomem		*regs;
-	u32			*savedata;
 	unsigned long		iovmm_base;	/* offset to vmm_area start */
 	unsigned long		iovmm_end;	/* offset to vmm_area end */
 	spinlock_t		pte_lock;	/* for pagetable */
 	spinlock_t		dom_lock;	/* for active domain */
 	unsigned int		active_devices;	/* number of active devices */
-	struct iommu_domain	*active_domain;	/* current active domain */
+	struct gart_domain	*active_domain;	/* current active domain */
 	struct iommu_device	iommu;		/* IOMMU Core handle */
 	struct device		*dev;
 };
@@ -62,6 +66,16 @@ static bool gart_debug;
 	     iova < gart->iovmm_end;					\
 	     iova += GART_PAGE_SIZE)
 
+static struct gart_domain *to_gart_domain(const struct iommu_domain *domain)
+{
+	return container_of(domain, struct gart_domain, domain);
+}
+
+static int gart_pte_index(struct gart_device *gart, unsigned long iova)
+{
+	return (iova - gart->iovmm_base) / GART_PAGE_SIZE;
+}
+
 static inline void gart_set_pte(struct gart_device *gart,
 				unsigned long iova, unsigned long pte)
 {
@@ -80,9 +94,10 @@ static inline unsigned long gart_read_pte(struct gart_device *gart,
 	return pte;
 }
 
-static void do_gart_setup(struct gart_device *gart, const u32 *data)
+static void do_gart_setup(struct gart_device *gart)
 {
 	unsigned long iova;
+	const u32 *data = gart->active_domain ? gart->active_domain->savedata : NULL;
 
 	for_each_gart_pte(gart, iova)
 		gart_set_pte(gart, iova, data ? *(data++) : 0);
@@ -107,33 +122,44 @@ static int gart_iommu_attach_dev(struct iommu_domain *domain,
 				 struct device *dev)
 {
 	struct gart_device *gart = gart_handle;
+	struct gart_domain *prev;
 	int ret = 0;
 
 	spin_lock(&gart->dom_lock);
 
+	prev = gart->active_domain;
 	if (domain->type == IOMMU_DOMAIN_IDENTITY) {
 		if (dev_iommu_priv_get(dev)) {
 			dev_iommu_priv_set(dev, NULL);
 			if (--gart->active_devices == 0)
 				gart->active_domain = NULL;
 		}
-	} else if (gart->active_domain && gart->active_domain != domain) {
+	} else if (prev && &prev->domain != domain) {
 		ret = -EINVAL;
 	} else if (dev_iommu_priv_get(dev) != domain) {
 		dev_iommu_priv_set(dev, domain);
-		gart->active_domain = domain;
+		gart->active_domain = to_gart_domain(domain);
 		gart->active_devices++;
 	}
 
 	spin_unlock(&gart->dom_lock);
 
+	/* If the active domain has changed, sync our mappings */
+	if (!ret && prev != gart->active_domain) {
+		spin_lock(&gart->pte_lock);
+		do_gart_setup(gart);
+		spin_unlock(&gart->pte_lock);
+	}
+
 	return ret;
 }
 
 static struct iommu_domain *gart_iommu_domain_alloc(unsigned type)
 {
+	struct gart_device *gart = gart_handle;
 	static struct iommu_domain identity;
-	struct iommu_domain *domain;
+	struct gart_domain *domain;
+	int num_pages;
 
 	if (type == IOMMU_DOMAIN_IDENTITY)
 		return &identity;
@@ -142,18 +168,25 @@ static struct iommu_domain *gart_iommu_domain_alloc(unsigned type)
 		return NULL;
 
 	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
-	if (domain) {
-		domain->geometry.aperture_start = gart_handle->iovmm_base;
-		domain->geometry.aperture_end = gart_handle->iovmm_end - 1;
-		domain->geometry.force_aperture = true;
-	}
+	if (!domain)
+		return NULL;
 
-	return domain;
+	domain->domain.geometry.aperture_start = gart->iovmm_base;
+	domain->domain.geometry.aperture_end = gart->iovmm_end - 1;
+	domain->domain.geometry.force_aperture = true;
+
+	num_pages = (gart->iovmm_end - gart->iovmm_base) / GART_PAGE_SIZE;
+	domain->savedata = vcalloc(num_pages, sizeof(u32));
+	if (!domain->savedata) {
+		kfree(domain);
+		return NULL;
+	}
+	return &domain->domain;
 }
 
 static void gart_iommu_domain_free(struct iommu_domain *domain)
 {
-	WARN_ON(gart_handle->active_domain == domain);
+	WARN_ON(&gart_handle->active_domain->domain == domain);
 	if (domain->type != IOMMU_DOMAIN_IDENTITY)
 		kfree(domain);
 }
@@ -161,12 +194,16 @@ static void gart_iommu_domain_free(struct iommu_domain *domain)
 static inline int __gart_iommu_map(struct gart_device *gart, unsigned long iova,
 				   unsigned long pa)
 {
+	int idx = gart_pte_index(gart, iova);
+	u32 pte = GART_ENTRY_PHYS_ADDR_VALID | pa;
+
 	if (unlikely(gart_debug && gart_pte_valid(gart, iova))) {
 		dev_err(gart->dev, "Page entry is in-use\n");
 		return -EINVAL;
 	}
 
-	gart_set_pte(gart, iova, GART_ENTRY_PHYS_ADDR_VALID | pa);
+	gart->active_domain->savedata[idx] = pte;
+	gart_set_pte(gart, iova, pte);
 
 	return 0;
 }
@@ -190,11 +227,14 @@ static int gart_iommu_map(struct iommu_domain *domain, unsigned long iova,
 static inline int __gart_iommu_unmap(struct gart_device *gart,
 				     unsigned long iova)
 {
+	int idx = gart_pte_index(gart, iova);
+
 	if (unlikely(gart_debug && !gart_pte_valid(gart, iova))) {
 		dev_err(gart->dev, "Page entry is invalid\n");
 		return -EINVAL;
 	}
 
+	gart->active_domain->savedata[idx] = 0;
 	gart_set_pte(gart, iova, 0);
 
 	return 0;
@@ -285,9 +325,6 @@ static const struct iommu_ops gart_iommu_ops = {
 
 int tegra_gart_suspend(struct gart_device *gart)
 {
-	u32 *data = gart->savedata;
-	unsigned long iova;
-
 	/*
 	 * All GART users shall be suspended at this point. Disable
 	 * address translation to trap all GART accesses as invalid
@@ -296,15 +333,12 @@ int tegra_gart_suspend(struct gart_device *gart)
 	writel_relaxed(0, gart->regs + GART_CONFIG);
 	FLUSH_GART_REGS(gart);
 
-	for_each_gart_pte(gart, iova)
-		*(data++) = gart_read_pte(gart, iova);
-
 	return 0;
 }
 
 int tegra_gart_resume(struct gart_device *gart)
 {
-	do_gart_setup(gart, gart->savedata);
+	do_gart_setup(gart);
 
 	return 0;
 }
@@ -337,7 +371,7 @@ struct gart_device *tegra_gart_probe(struct device *dev, struct tegra_mc *mc)
 	spin_lock_init(&gart->pte_lock);
 	spin_lock_init(&gart->dom_lock);
 
-	do_gart_setup(gart, NULL);
+	do_gart_setup(gart);
 
 	err = iommu_device_sysfs_add(&gart->iommu, dev, NULL, "gart");
 	if (err)
@@ -347,17 +381,8 @@ struct gart_device *tegra_gart_probe(struct device *dev, struct tegra_mc *mc)
 	if (err)
 		goto remove_sysfs;
 
-	gart->savedata = vmalloc(resource_size(res) / GART_PAGE_SIZE *
-				 sizeof(u32));
-	if (!gart->savedata) {
-		err = -ENOMEM;
-		goto unregister_iommu;
-	}
-
 	return gart;
 
-unregister_iommu:
-	iommu_device_unregister(&gart->iommu);
 remove_sysfs:
 	iommu_device_sysfs_remove(&gart->iommu);
 free_gart:
-- 
2.39.2.101.g768bb238c484.dirty

