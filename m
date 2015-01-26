From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 15/15] iommu: Remove domain_init and domain_free iommu_ops
Date: Tue, 27 Jan 2015 00:51:45 +0100
Message-ID: <1422316305-19216-16-git-send-email-joro@8bytes.org>
References: <1422316305-19216-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1422316305-19216-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, jroedel-l3A5Bk7waGM@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

All drivers have been converted to the new domain_alloc and
domain_free iommu-ops. So remove the old ones and get rid of
iommu_domain->priv too, as this is no longer needed when the
struct iommu_domain is embedded in the private structures of
the iommu drivers.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/iommu.c | 30 ++----------------------------
 include/linux/iommu.h |  3 ---
 2 files changed, 2 insertions(+), 31 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index ab24d77..e66cc08 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -900,51 +900,25 @@ EXPORT_SYMBOL_GPL(iommu_set_fault_handler);
 
 struct iommu_domain *iommu_domain_alloc(struct bus_type *bus)
 {
-	const struct iommu_ops *ops;
 	struct iommu_domain *domain;
 
 	if (bus == NULL || bus->iommu_ops == NULL)
 		return NULL;
 
-	ops = bus->iommu_ops;
-
-	if (ops->domain_alloc)
-		domain = ops->domain_alloc(IOMMU_DOMAIN_UNMANAGED);
-	else
-		domain = kzalloc(sizeof(*domain), GFP_KERNEL);
-
+	domain = bus->iommu_ops->domain_alloc(IOMMU_DOMAIN_UNMANAGED);
 	if (!domain)
 		return NULL;
 
 	domain->ops  = bus->iommu_ops;
 	domain->type = IOMMU_DOMAIN_UNMANAGED;
 
-	if (ops->domain_init && domain->ops->domain_init(domain))
-		goto out_free;
-
 	return domain;
-
-out_free:
-	if (ops->domain_free)
-		ops->domain_free(domain);
-	else
-		kfree(domain);
-
-	return NULL;
 }
 EXPORT_SYMBOL_GPL(iommu_domain_alloc);
 
 void iommu_domain_free(struct iommu_domain *domain)
 {
-	const struct iommu_ops *ops = domain->ops;
-
-	if (likely(ops->domain_destroy != NULL))
-		ops->domain_destroy(domain);
-
-	if (ops->domain_free)
-		ops->domain_free(domain);
-	else
-		kfree(domain);
+	domain->ops->domain_free(domain);
 }
 EXPORT_SYMBOL_GPL(iommu_domain_free);
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 0b67f65..2951dca 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -62,7 +62,6 @@ enum iommu_domain_type {
 struct iommu_domain {
 	enum iommu_domain_type type;
 	const struct iommu_ops *ops;
-	void *priv;
 	iommu_fault_handler_t handler;
 	void *handler_token;
 	struct iommu_domain_geometry geometry;
@@ -122,8 +121,6 @@ enum iommu_attr {
  */
 struct iommu_ops {
 	bool (*capable)(enum iommu_cap);
-	int (*domain_init)(struct iommu_domain *domain);
-	void (*domain_destroy)(struct iommu_domain *domain);
 
 	/* Domain allocation and freeing by the iommu driver */
 	struct iommu_domain *(*domain_alloc)(enum iommu_domain_type);
-- 
1.8.4.5
