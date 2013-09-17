From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] iommu/tegra: Print phys_addr_t using %pa
Date: Tue, 17 Sep 2013 10:19:31 +0200
Message-ID: <1379405971-2693-1-git-send-email-treding@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs98uUxBSJOaYoYkZiVZrdSR2LY78lusg7I@public.gmane.org, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

When enabling LPAE on ARM, phys_addr_t becomes 64 bits wide and printing
a variable of that type using a simple %x format specifier causes the
compiler to complain. Change the format specifier to %pa, which is used
specifically for variables of type phys_addr_t.

Signed-off-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
Olof has been sending patches to fix up similar issues, but I couldn't
find one that fixes these warnings. If Olof sent a patch for this and I
missed it, please ignore.

 drivers/iommu/tegra-gart.c | 6 +++---
 drivers/iommu/tegra-smmu.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index 108c0e9..8993999 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -252,7 +252,7 @@ static int gart_iommu_map(struct iommu_domain *domain, unsigned long iova,
 	spin_lock_irqsave(&gart->pte_lock, flags);
 	pfn = __phys_to_pfn(pa);
 	if (!pfn_valid(pfn)) {
-		dev_err(gart->dev, "Invalid page: %08x\n", pa);
+		dev_err(gart->dev, "Invalid page: %pa\n", &pa);
 		spin_unlock_irqrestore(&gart->pte_lock, flags);
 		return -EINVAL;
 	}
@@ -295,8 +295,8 @@ static phys_addr_t gart_iommu_iova_to_phys(struct iommu_domain *domain,
 
 	pa = (pte & GART_PAGE_MASK);
 	if (!pfn_valid(__phys_to_pfn(pa))) {
-		dev_err(gart->dev, "No entry for %08llx:%08x\n",
-			 (unsigned long long)iova, pa);
+		dev_err(gart->dev, "No entry for %08llx:%pa\n",
+			 (unsigned long long)iova, &pa);
 		gart_dump_table(gart);
 		return -EINVAL;
 	}
diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index e066560..34374b3 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -731,7 +731,7 @@ static int smmu_iommu_map(struct iommu_domain *domain, unsigned long iova,
 	unsigned long pfn = __phys_to_pfn(pa);
 	unsigned long flags;
 
-	dev_dbg(as->smmu->dev, "[%d] %08lx:%08x\n", as->asid, iova, pa);
+	dev_dbg(as->smmu->dev, "[%d] %08lx:%pa\n", as->asid, iova, &pa);
 
 	if (!pfn_valid(pfn))
 		return -ENOMEM;
-- 
1.8.4
