From: Eric Auger <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH v7 03/10] iommu: introduce a reserved iova cookie
Date: Tue, 19 Apr 2016 16:56:27 +0000
Message-ID: <1461084994-2355-4-git-send-email-eric.auger@linaro.org>
References: <1461084994-2355-1-git-send-email-eric.auger@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1461084994-2355-1-git-send-email-eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: eric.auger-qxv4g6HH51o@public.gmane.org, eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: julien.grall-5wv7dgnIgG8@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, p.fedin-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, pranav.sawargaonkar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This patch introduces some new fields in the iommu_domain struct,
dedicated to reserved iova management.

In a similar way as DMA mapping IOVA window, we need to store
information related to a reserved IOVA window.

The reserved_iova_cookie will store the reserved iova_domain
handle. An RB tree indexed by physical address is introduced to
store the host physical addresses bound to reserved IOVAs.

Those physical addresses will correspond to MSI frame base
addresses, also referred to as doorbells. Their number should be
quite limited per domain.

Also a spin_lock is introduced to protect accesses to the iova_domain
and RB tree. The choice of a spin_lock is driven by the fact the RB
tree will need to be accessed in MSI controller code not allowed to
sleep.

Signed-off-by: Eric Auger <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

---
v5 -> v6:
- initialize reserved_binding_list
- use a spinlock instead of a mutex
---
 drivers/iommu/iommu.c | 2 ++
 include/linux/iommu.h | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index b9df141..f70ef3b 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1073,6 +1073,8 @@ static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
 
 	domain->ops  = bus->iommu_ops;
 	domain->type = type;
+	spin_lock_init(&domain->reserved_lock);
+	domain->reserved_binding_list = RB_ROOT;
 
 	return domain;
 }
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index b3e8c5b..60999db 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -24,6 +24,7 @@
 #include <linux/of.h>
 #include <linux/types.h>
 #include <linux/scatterlist.h>
+#include <linux/spinlock.h>
 #include <trace/events/iommu.h>
 
 #define IOMMU_READ	(1 << 0)
@@ -83,6 +84,11 @@ struct iommu_domain {
 	void *handler_token;
 	struct iommu_domain_geometry geometry;
 	void *iova_cookie;
+	void *reserved_iova_cookie;
+	/* rb tree indexed by PA, for reserved bindings only */
+	struct rb_root reserved_binding_list;
+	/* protects reserved cookie and rbtree manipulation */
+	spinlock_t reserved_lock;
 };
 
 enum iommu_cap {
-- 
1.9.1
