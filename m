From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 02/23] iommu/amd: Move 'struct dma_ops_domain' definition to
	amd_iommu.c
Date: Tue, 22 Dec 2015 23:21:07 +0100
Message-ID: <1450822888-22590-3-git-send-email-joro@8bytes.org>
References: <1450822888-22590-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1450822888-22590-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: jroedel-l3A5Bk7waGM@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

It is only used in this file anyway, so keep it there. Same
with 'struct aperture_range'.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/amd_iommu.c       | 40 ++++++++++++++++++++++++++++++++++++++++
 drivers/iommu/amd_iommu_types.h | 40 ----------------------------------------
 2 files changed, 40 insertions(+), 40 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 3cdfac6..9ce51eb 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -114,6 +114,46 @@ struct kmem_cache *amd_iommu_irq_cache;
 static void update_domain(struct protection_domain *domain);
 static int protection_domain_init(struct protection_domain *domain);
 
+/*
+ * For dynamic growth the aperture size is split into ranges of 128MB of
+ * DMA address space each. This struct represents one such range.
+ */
+struct aperture_range {
+
+	/* address allocation bitmap */
+	unsigned long *bitmap;
+
+	/*
+	 * Array of PTE pages for the aperture. In this array we save all the
+	 * leaf pages of the domain page table used for the aperture. This way
+	 * we don't need to walk the page table to find a specific PTE. We can
+	 * just calculate its address in constant time.
+	 */
+	u64 *pte_pages[64];
+
+	unsigned long offset;
+};
+
+/*
+ * Data container for a dma_ops specific protection domain
+ */
+struct dma_ops_domain {
+	/* generic protection domain information */
+	struct protection_domain domain;
+
+	/* size of the aperture for the mappings */
+	unsigned long aperture_size;
+
+	/* address we start to search for free addresses */
+	unsigned long next_address;
+
+	/* address space relevant data */
+	struct aperture_range *aperture[APERTURE_MAX_RANGES];
+
+	/* This will be set to true when TLB needs to be flushed */
+	bool need_flush;
+};
+
 /****************************************************************************
  *
  * Helper functions
diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
index b08cf57..9d32b20 100644
--- a/drivers/iommu/amd_iommu_types.h
+++ b/drivers/iommu/amd_iommu_types.h
@@ -425,46 +425,6 @@ struct protection_domain {
 };
 
 /*
- * For dynamic growth the aperture size is split into ranges of 128MB of
- * DMA address space each. This struct represents one such range.
- */
-struct aperture_range {
-
-	/* address allocation bitmap */
-	unsigned long *bitmap;
-
-	/*
-	 * Array of PTE pages for the aperture. In this array we save all the
-	 * leaf pages of the domain page table used for the aperture. This way
-	 * we don't need to walk the page table to find a specific PTE. We can
-	 * just calculate its address in constant time.
-	 */
-	u64 *pte_pages[64];
-
-	unsigned long offset;
-};
-
-/*
- * Data container for a dma_ops specific protection domain
- */
-struct dma_ops_domain {
-	/* generic protection domain information */
-	struct protection_domain domain;
-
-	/* size of the aperture for the mappings */
-	unsigned long aperture_size;
-
-	/* address we start to search for free addresses */
-	unsigned long next_address;
-
-	/* address space relevant data */
-	struct aperture_range *aperture[APERTURE_MAX_RANGES];
-
-	/* This will be set to true when TLB needs to be flushed */
-	bool need_flush;
-};
-
-/*
  * Structure where we save information about one hardware AMD IOMMU in the
  * system.
  */
-- 
1.9.1
