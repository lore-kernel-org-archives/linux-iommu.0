From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 3/4] iommu/tegra: gart: Set aperture at domain initialization time
Date: Fri, 27 Mar 2015 11:07:26 +0100
Message-ID: <1427450847-17719-3-git-send-email-thierry.reding@gmail.com>
References: <1427450847-17719-1-git-send-email-thierry.reding@gmail.com>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1427450847-17719-1-git-send-email-thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

From: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

The aperture of the domain should always be available, otherwise drivers
need to attach first before they can use the aperture geometry.

Cc: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/tegra-gart.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index c48da057dbb1..5f3b68c26b83 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -156,20 +156,10 @@ static inline bool gart_iova_range_valid(struct gart_device *gart,
 static int gart_iommu_attach_dev(struct iommu_domain *domain,
 				 struct device *dev)
 {
-	struct gart_device *gart;
+	struct gart_device *gart = domain->priv;
 	struct gart_client *client, *c;
 	int err = 0;
 
-	gart = gart_handle;
-	if (!gart)
-		return -EINVAL;
-	domain->priv = gart;
-
-	domain->geometry.aperture_start = gart->iovmm_base;
-	domain->geometry.aperture_end   = gart->iovmm_base +
-					gart->page_count * GART_PAGE_SIZE - 1;
-	domain->geometry.force_aperture = true;
-
 	client = devm_kzalloc(gart->dev, sizeof(*c), GFP_KERNEL);
 	if (!client)
 		return -ENOMEM;
@@ -218,6 +208,19 @@ out:
 
 static int gart_iommu_domain_init(struct iommu_domain *domain)
 {
+	struct gart_device *gart;
+
+	gart = gart_handle;
+	if (!gart)
+		return -EINVAL;
+
+	domain->priv = gart;
+
+	domain->geometry.aperture_start = gart->iovmm_base;
+	domain->geometry.aperture_end = gart->iovmm_base +
+					gart->page_count * GART_PAGE_SIZE - 1;
+	domain->geometry.force_aperture = true;
+
 	return 0;
 }
 
-- 
2.3.2
