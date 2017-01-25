From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH/RFC 2/4] iommu: iova: use __alloc_percpu_gfp() with GFP_NOWAIT in init_iova_rcaches()
Date: Wed, 25 Jan 2017 21:54:00 +0900
Message-ID: <1485348842-23712-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
References: <1485348842-23712-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1485348842-23712-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: joro@8bytes.org
Cc: magnus.damm@gmail.com, iommu@lists.linux-foundation.org, linux-renesas-soc@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
List-Id: iommu@lists.linux-foundation.org

In the future, the init_iova_rcaches will be called in atomic.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/iommu/iova.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index b7268a1..866ad65 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -723,7 +723,9 @@ static void init_iova_rcaches(struct iova_domain *iovad)
 		rcache = &iovad->rcaches[i];
 		spin_lock_init(&rcache->lock);
 		rcache->depot_size = 0;
-		rcache->cpu_rcaches = __alloc_percpu(sizeof(*cpu_rcache), cache_line_size());
+		rcache->cpu_rcaches = __alloc_percpu_gfp(sizeof(*cpu_rcache),
+							 cache_line_size(),
+							 GFP_NOWAIT);
 		if (WARN_ON(!rcache->cpu_rcaches))
 			continue;
 		for_each_possible_cpu(cpu) {
-- 
1.9.1
