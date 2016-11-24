From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 1/5] iommu/exynos: Improve page fault debug message
Date: Thu, 24 Nov 2016 12:20:16 +0100
Message-ID: <1479986420-30859-2-git-send-email-m.szyprowski@samsung.com>
References: <1479986420-30859-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <1479986420-30859-1-git-send-email-m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Add master device name to default IOMMU fault message to make easier to
find which device triggered the fault. While at it, move printing some
information (like page table base and first level entry addresses) to
dev_dbg(), because those are typically not very useful for typical device
driver user/developer not equipped with hardware debugging tools.

Signed-off-by: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/iommu/exynos-iommu.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 57ba0d3091ea..ac726e1760de 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -381,13 +381,14 @@ static void show_fault_information(struct sysmmu_drvdata *data,
 {
 	sysmmu_pte_t *ent;
 
-	dev_err(data->sysmmu, "%s FAULT occurred at %#x (page table base: %pa)\n",
-		finfo->name, fault_addr, &data->pgtable);
+	dev_err(data->sysmmu, "%s: %s FAULT occurred at %#x\n",
+		dev_name(data->master), finfo->name, fault_addr);
+	dev_dbg(data->sysmmu, "Page table base: %pa\n", &data->pgtable);
 	ent = section_entry(phys_to_virt(data->pgtable), fault_addr);
-	dev_err(data->sysmmu, "\tLv1 entry: %#x\n", *ent);
+	dev_dbg(data->sysmmu, "\tLv1 entry: %#x\n", *ent);
 	if (lv1ent_page(ent)) {
 		ent = page_entry(ent, fault_addr);
-		dev_err(data->sysmmu, "\t Lv2 entry: %#x\n", *ent);
+		dev_dbg(data->sysmmu, "\t Lv2 entry: %#x\n", *ent);
 	}
 }
 
-- 
1.9.1
