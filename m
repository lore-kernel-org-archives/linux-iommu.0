From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 02/16] iommu: Introduce iommu domain types
Date: Thu, 26 Mar 2015 13:43:05 +0100
Message-ID: <1427373799-18662-3-git-send-email-joro@8bytes.org>
References: <1427373799-18662-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1427373799-18662-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, jroedel-l3A5Bk7waGM@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Yingjoe Chen <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

This allows to handle domains differently based on their
type in the future. An IOMMU driver can implement certain
optimizations for DMA-API domains for example.

The domain types can be extended later and some of the
existing domain attributes can be migrated to become domain
flags.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/iommu.c |  5 +++--
 include/linux/iommu.h | 27 ++++++++++++++++++++++++++-
 2 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 11de262..4920605 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -909,14 +909,15 @@ struct iommu_domain *iommu_domain_alloc(struct bus_type *bus)
 	ops = bus->iommu_ops;
 
 	if (ops->domain_alloc)
-		domain = ops->domain_alloc();
+		domain = ops->domain_alloc(IOMMU_DOMAIN_UNMANAGED);
 	else
 		domain = kzalloc(sizeof(*domain), GFP_KERNEL);
 
 	if (!domain)
 		return NULL;
 
-	domain->ops = bus->iommu_ops;
+	domain->ops  = bus->iommu_ops;
+	domain->type = IOMMU_DOMAIN_UNMANAGED;
 
 	if (ops->domain_init && domain->ops->domain_init(domain))
 		goto out_free;
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 69d1d12..72d03fe 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -51,7 +51,32 @@ struct iommu_domain_geometry {
 	bool force_aperture;       /* DMA only allowed in mappable range? */
 };
 
+/* Domain feature flags */
+#define __IOMMU_DOMAIN_PAGING	(1U << 0)  /* Support for iommu_map/unmap */
+#define __IOMMU_DOMAIN_DMA_API	(1U << 1)  /* Domain for use in DMA-API
+					      implementation              */
+#define __IOMMU_DOMAIN_PT	(1U << 2)  /* Domain is identity mapped   */
+
+/*
+ * This are the possible domain-types
+ *
+ *	IOMMU_DOMAIN_BLOCKED	- All DMA is blocked, can be used to isolate
+ *				  devices
+ *	IOMMU_DOMAIN_IDENTITY	- DMA addresses are system physical addresses
+ *	IOMMU_DOMAIN_UNMANAGED	- DMA mappings managed by IOMMU-API user, used
+ *				  for VMs
+ *	IOMMU_DOMAIN_DMA	- Internally used for DMA-API implementations.
+ *				  This flag allows IOMMU drivers to implement
+ *				  certain optimizations for these domains
+ */
+#define IOMMU_DOMAIN_BLOCKED	(0U)
+#define IOMMU_DOMAIN_IDENTITY	(__IOMMU_DOMAIN_PT)
+#define IOMMU_DOMAIN_UNMANAGED	(__IOMMU_DOMAIN_PAGING)
+#define IOMMU_DOMAIN_DMA	(__IOMMU_DOMAIN_PAGING |	\
+				 __IOMMU_DOMAIN_DMA_API)
+
 struct iommu_domain {
+	unsigned type;
 	const struct iommu_ops *ops;
 	void *priv;
 	iommu_fault_handler_t handler;
@@ -117,7 +142,7 @@ struct iommu_ops {
 	void (*domain_destroy)(struct iommu_domain *domain);
 
 	/* Domain allocation and freeing by the iommu driver */
-	struct iommu_domain *(*domain_alloc)(void);
+	struct iommu_domain *(*domain_alloc)(unsigned iommu_domain_type);
 	void (*domain_free)(struct iommu_domain *);
 
 	int (*attach_dev)(struct iommu_domain *domain, struct device *dev);
-- 
1.9.1
