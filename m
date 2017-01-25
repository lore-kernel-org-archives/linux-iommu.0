From: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH/RFC 3/4] iommu: dma: iommu iova domain reset
Date: Wed, 25 Jan 2017 21:54:01 +0900
Message-ID: <1485348842-23712-4-git-send-email-yoshihiro.shimoda.uh@renesas.com>
References: <1485348842-23712-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1485348842-23712-1-git-send-email-yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
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
Cc: linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>

To add a workaround code for ipmmu-vmsa driver, this patch adds
a new geometry "force_reset_when_empty" not to reuse iova space.
When all pfns happen to get unmapped then ask the IOMMU driver to
flush the state followed by starting from an empty iova space.

Signed-off-by: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
---
 drivers/iommu/dma-iommu.c | 42 +++++++++++++++++++++++++++++++++++++-----
 drivers/iommu/iova.c      |  9 +++++++++
 include/linux/iommu.h     |  2 ++
 include/linux/iova.h      |  1 +
 4 files changed, 49 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index a0b8c0f..d0fa0b1 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -42,6 +42,7 @@ struct iommu_dma_cookie {
 	struct iova_domain	iovad;
 	struct list_head	msi_page_list;
 	spinlock_t		msi_lock;
+	spinlock_t		reset_lock;
 };
 
 static inline struct iova_domain *cookie_iovad(struct iommu_domain *domain)
@@ -74,6 +75,7 @@ int iommu_get_dma_cookie(struct iommu_domain *domain)
 
 	spin_lock_init(&cookie->msi_lock);
 	INIT_LIST_HEAD(&cookie->msi_page_list);
+	spin_lock_init(&cookie->reset_lock);
 	domain->iova_cookie = cookie;
 	return 0;
 }
@@ -208,9 +210,11 @@ int dma_direction_to_prot(enum dma_data_direction dir, bool coherent)
 static struct iova *__alloc_iova(struct iommu_domain *domain, size_t size,
 		dma_addr_t dma_limit)
 {
+	struct iommu_dma_cookie *cookie = domain->iova_cookie;
 	struct iova_domain *iovad = cookie_iovad(domain);
 	unsigned long shift = iova_shift(iovad);
 	unsigned long length = iova_align(iovad, size) >> shift;
+	unsigned long flags;
 	struct iova *iova;
 
 	if (domain->geometry.force_aperture)
@@ -219,9 +223,19 @@ static struct iova *__alloc_iova(struct iommu_domain *domain, size_t size,
 	 * Enforce size-alignment to be safe - there could perhaps be an
 	 * attribute to control this per-device, or at least per-domain...
 	 */
-	iova = alloc_iova(iovad, length, dma_limit >> shift, true);
-	if (iova)
-		atomic_add(iova_size(iova), &domain->iova_pfns_mapped);
+	if (domain->geometry.force_reset_when_empty) {
+		spin_lock_irqsave(&cookie->reset_lock, flags);
+
+		iova = alloc_iova(iovad, length, dma_limit >> shift, true);
+		if (iova)
+			atomic_add(iova_size(iova), &domain->iova_pfns_mapped);
+
+		spin_unlock_irqrestore(&cookie->reset_lock, flags);
+	} else {
+		iova = alloc_iova(iovad, length, dma_limit >> shift, true);
+		if (iova)
+			atomic_add(iova_size(iova), &domain->iova_pfns_mapped);
+	}
 
 	return iova;
 }
@@ -229,10 +243,28 @@ static struct iova *__alloc_iova(struct iommu_domain *domain, size_t size,
 void
 __free_iova_domain(struct iommu_domain *domain, struct iova *iova)
 {
+	struct iommu_dma_cookie *cookie = domain->iova_cookie;
 	struct iova_domain *iovad = cookie_iovad(domain);
+	unsigned long flags;
 
-	atomic_sub(iova_size(iova), &domain->iova_pfns_mapped);
-	__free_iova(iovad, iova);
+	/* In case force_reset_when_empty is set, do not reuse iova space
+	 * but instead simply keep on expanding seemingly forever.
+	 * When all pfns happen to get unmapped then ask the IOMMU driver to
+	 * flush the state followed by starting from an empty iova space.
+	 */
+	if (domain->geometry.force_reset_when_empty) {
+		spin_lock_irqsave(&cookie->reset_lock, flags);
+		if (atomic_sub_return(iova_size(iova),
+				      &domain->iova_pfns_mapped) == 0) {
+			reset_iova_domain(iovad);
+			if (domain->ops->domain_reset)
+				domain->ops->domain_reset(domain);
+		}
+		spin_unlock_irqrestore(&cookie->reset_lock, flags);
+	} else {
+		atomic_sub(iova_size(iova), &domain->iova_pfns_mapped);
+		__free_iova(iovad, iova);
+	}
 }
 
 
diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 866ad65..50aaa46 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -464,6 +464,7 @@ void put_iova_domain(struct iova_domain *iovad)
 	while (node) {
 		struct iova *iova = rb_entry(node, struct iova, node);
 
+		__cached_rbnode_delete_update(iovad, iova);
 		rb_erase(node, &iovad->rbroot);
 		free_iova_mem(iova);
 		node = rb_first(&iovad->rbroot);
@@ -472,6 +473,14 @@ void put_iova_domain(struct iova_domain *iovad)
 }
 EXPORT_SYMBOL_GPL(put_iova_domain);
 
+void
+reset_iova_domain(struct iova_domain *iovad)
+{
+	put_iova_domain(iovad);
+	init_iova_rcaches(iovad);
+}
+EXPORT_SYMBOL_GPL(reset_iova_domain);
+
 static int
 __is_range_overlap(struct rb_node *node,
 	unsigned long pfn_lo, unsigned long pfn_hi)
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 91d0159..bd9ba1b 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -51,6 +51,7 @@ struct iommu_domain_geometry {
 	dma_addr_t aperture_start; /* First address that can be mapped    */
 	dma_addr_t aperture_end;   /* Last address that can be mapped     */
 	bool force_aperture;       /* DMA only allowed in mappable range? */
+	bool force_reset_when_empty;
 };
 
 /* Domain feature flags */
@@ -168,6 +169,7 @@ struct iommu_ops {
 	/* Domain allocation and freeing by the iommu driver */
 	struct iommu_domain *(*domain_alloc)(unsigned iommu_domain_type);
 	void (*domain_free)(struct iommu_domain *);
+	void (*domain_reset)(struct iommu_domain *);
 
 	int (*attach_dev)(struct iommu_domain *domain, struct device *dev);
 	void (*detach_dev)(struct iommu_domain *domain, struct device *dev);
diff --git a/include/linux/iova.h b/include/linux/iova.h
index f27bb2c..31c8496 100644
--- a/include/linux/iova.h
+++ b/include/linux/iova.h
@@ -103,6 +103,7 @@ void init_iova_domain(struct iova_domain *iovad, unsigned long granule,
 	unsigned long start_pfn, unsigned long pfn_32bit);
 struct iova *find_iova(struct iova_domain *iovad, unsigned long pfn);
 void put_iova_domain(struct iova_domain *iovad);
+void reset_iova_domain(struct iova_domain *iovad);
 struct iova *split_and_remove_iova(struct iova_domain *iovad,
 	struct iova *iova, unsigned long pfn_lo, unsigned long pfn_hi);
 void free_cpu_cached_iovas(unsigned int cpu, struct iova_domain *iovad);
-- 
1.9.1
