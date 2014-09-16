From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v2 15/18] iommu: exynos: document internal structures
Date: Tue, 16 Sep 2014 13:54:42 +0200
Message-ID: <1410868485-4143-16-git-send-email-m.szyprowski@samsung.com>
References: <1410868485-4143-1-git-send-email-m.szyprowski@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1410868485-4143-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, linaro-mm-sig@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>, Shaik Ameer Basha <shaik.ameer@samsung.com>, Cho KyongHo <pullip.cho@samsung.com>, Joerg Roedel <joro@8bytes.org>, Thierry Reding <treding@nvidia.com>, Olof Johansson <olof@lixom.net>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Rob Herring <robh@kernel.org>, Will Deacon <will.deacon@arm.com>, David Wodhouse <dwmw2@infradead.org>, Inki Dae <inki.dae@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>
List-Id: iommu@lists.linux-foundation.org

Add a few words of comment to all internal structures used by the driver.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/iommu/exynos-iommu.c | 49 +++++++++++++++++++++++++++++---------------
 1 file changed, 33 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index ae61d0680b9a..a75b06365f97 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -184,32 +184,49 @@ static char *sysmmu_fault_name[SYSMMU_FAULTS_NUM] = {
 	"UNKNOWN FAULT"
 };
 
-/* attached to dev.archdata.iommu of the master device */
+/*
+ * This structure is attached to dev.archdata.iommu of the master device
+ * on device add, contains a list of SYSMMU controllers defined by device tree,
+ * which are bound to given master device. It is usually referenced by 'owner'
+ * pointer.
+ */
 struct exynos_iommu_owner {
-	struct list_head clients;
+	struct list_head clients; /* list of sysmmu_drvdata.owner_node */
 };
 
+/*
+ * This structure is stored in ->priv field of generic struct iommu_domain,
+ * contains list of SYSMMU controllers from all master devices, which has been
+ * attached to this domain and page tables of IO address space defined by this
+ * domain. It is usually referenced by 'domain' pointer.
+ */
 struct exynos_iommu_domain {
-	struct list_head clients; /* list of sysmmu_drvdata.node */
+	struct list_head clients; /* list of sysmmu_drvdata.domain_node */
 	sysmmu_pte_t *pgtable; /* lv1 page table, 16KB */
 	short *lv2entcnt; /* free lv2 entry counter for each section */
-	spinlock_t lock; /* lock for this structure */
+	spinlock_t lock; /* lock for modyfying list of clients */
 	spinlock_t pgtablelock; /* lock for modifying page table @ pgtable */
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
-	struct iommu_domain *domain;
-	struct list_head domain_node;
-	struct list_head owner_node;
-	phys_addr_t pgtable;
-	int version;
+	struct device *sysmmu; /* SYSMMU controller device */
+	struct device *master; /* master device (owner of given SYSMMU) */
+	void __iomem *sfrbase; /* our registers */
+	struct clk *clk; /* SYSMMU's clock */
+	struct clk *clk_master; /* master's device clock */
+	int activations; /* number of calls to sysmmu_enable */
+	spinlock_t lock; /* lock for modyfying enable/disable state */
+	struct iommu_domain *domain; /* domain we belong to */
+	struct list_head domain_node; /* node for domain clients list */
+	struct list_head owner_node; /* node for owner clients list */
+	phys_addr_t pgtable; /* assigned page table structure */
+	int version; /* our version */
 };
 
 static bool set_sysmmu_active(struct sysmmu_drvdata *data)
-- 
1.9.2
