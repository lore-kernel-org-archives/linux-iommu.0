From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v7 11/25] iommu/exynos: Document internal structures
Date: Tue, 19 May 2015 15:20:31 +0200
Message-ID: <1432041645-11172-12-git-send-email-m.szyprowski@samsung.com>
References: <1432041645-11172-1-git-send-email-m.szyprowski@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1432041645-11172-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, linaro-mm-sig@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>, Shaik Ameer Basha <shaik.ameer@samsung.com>, Cho KyongHo <pullip.cho@samsung.com>, Joerg Roedel <joro@8bytes.org>, Thierry Reding <treding@nvidia.com>, Olof Johansson <olof@lixom.net>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Rob Herring <robh@kernel.org>, Will Deacon <will.deacon@arm.com>, David Wodhouse <dwmw2@infradead.org>, Inki Dae <inki.dae@samsung.com>, Kukjin Kim <kgene@kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>, Joonyoung Shim <jy0922.shim@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>, Javier Martinez Canillas <javier@dowhile0.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>
List-Id: iommu@lists.linux-foundation.org

Add a few words of comment to all internal structures used by the driver.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/iommu/exynos-iommu.c | 53 +++++++++++++++++++++++++++++---------------
 1 file changed, 35 insertions(+), 18 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 646adb547cba..0e7250fda087 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -180,32 +180,49 @@ static char *sysmmu_fault_name[SYSMMU_FAULTS_NUM] = {
 	"UNKNOWN FAULT"
 };
 
-/* attached to dev.archdata.iommu of the master device */
+/*
+ * This structure is attached to dev.archdata.iommu of the master device
+ * on device add, contains a list of SYSMMU controllers defined by device tree,
+ * which are bound to given master device. It is usually referenced by 'owner'
+ * pointer.
+*/
 struct exynos_iommu_owner {
-	struct device *sysmmu;
+	struct device *sysmmu;		/* sysmmu controller for given master */
 };
 
+/*
+ * This structure exynos specific generalization of struct iommu_domain.
+ * It contains list of SYSMMU controllers from all master devices, which has
+ * been attached to this domain and page tables of IO address space defined by
+ * it. It is usually referenced by 'domain' pointer.
+ */
 struct exynos_iommu_domain {
-	struct list_head clients; /* list of sysmmu_drvdata.node */
-	sysmmu_pte_t *pgtable; /* lv1 page table, 16KB */
-	short *lv2entcnt; /* free lv2 entry counter for each section */
-	spinlock_t lock; /* lock for this structure */
-	spinlock_t pgtablelock; /* lock for modifying page table @ pgtable */
+	struct list_head clients; /* list of sysmmu_drvdata.domain_node */
+	sysmmu_pte_t *pgtable;	/* lv1 page table, 16KB */
+	short *lv2entcnt;	/* free lv2 entry counter for each section */
+	spinlock_t lock;	/* lock for modyfying list of clients */
+	spinlock_t pgtablelock;	/* lock for modifying page table @ pgtable */
 	struct iommu_domain domain; /* generic domain data structure */
 };
 
+/*
+ * This structure hold all data of a single SYSMMU controller, this includes
+ * hw resources like registers and clocks, pointers and list nodes to connect
+ * it to all other structures, internal state and parameters read from device
+ * tree. It is usually referenced by 'data' pointer.
+ */
 struct sysmmu_drvdata {
-	struct device *sysmmu;	/* System MMU's device descriptor */
-	struct device *master;	/* Owner of system MMU */
-	void __iomem *sfrbase;
-	struct clk *clk;
-	struct clk *clk_master;
-	int activations;
-	spinlock_t lock;
-	struct exynos_iommu_domain *domain;
-	struct list_head domain_node;
-	phys_addr_t pgtable;
-	unsigned int version;
+	struct device *sysmmu;		/* SYSMMU controller device */
+	struct device *master;		/* master device (owner) */
+	void __iomem *sfrbase;		/* our registers */
+	struct clk *clk;		/* SYSMMU's clock */
+	struct clk *clk_master;		/* master's device clock */
+	int activations;		/* number of calls to sysmmu_enable */
+	spinlock_t lock;		/* lock for modyfying state */
+	struct exynos_iommu_domain *domain; /* domain we belong to */
+	struct list_head domain_node;	/* node for domain clients list */
+	phys_addr_t pgtable;		/* assigned page table structure */
+	unsigned int version;		/* our version */
 };
 
 static struct exynos_iommu_domain *to_exynos_domain(struct iommu_domain *dom)
-- 
1.9.2
