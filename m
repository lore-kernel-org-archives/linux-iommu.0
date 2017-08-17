From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 13/13] remoteproc: Use sychronized interface of the IOMMU-API
Date: Thu, 17 Aug 2017 14:56:36 +0200
Message-ID: <1502974596-23835-14-git-send-email-joro@8bytes.org>
References: <1502974596-23835-1-git-send-email-joro@8bytes.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1502974596-23835-1-git-send-email-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org, Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>, Joerg Roedel <jroedel@suse.de>, Ohad Ben-Cohen <ohad@wizery.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, linux-remoteproc@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel@suse.de>

The map and unmap functions of the IOMMU-API changed their
semantics: They do no longer guarantee that the hardware
TLBs are synchronized with the page-table updates they made.

To make conversion easier, new synchronized functions have
been introduced which give these guarantees again until the
code is converted to use the new TLB-flush interface of the
IOMMU-API, which allows certain optimizations.

But for now, just convert this code to use the synchronized
functions so that it will behave as before.

Cc: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: linux-remoteproc@vger.kernel.org
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/remoteproc/remoteproc_core.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 564061d..16db19c 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -553,7 +553,8 @@ static int rproc_handle_devmem(struct rproc *rproc, struct fw_rsc_devmem *rsc,
 	if (!mapping)
 		return -ENOMEM;
 
-	ret = iommu_map(rproc->domain, rsc->da, rsc->pa, rsc->len, rsc->flags);
+	ret = iommu_map_sync(rproc->domain, rsc->da,
+			     rsc->pa, rsc->len, rsc->flags);
 	if (ret) {
 		dev_err(dev, "failed to map devmem: %d\n", ret);
 		goto out;
@@ -661,8 +662,8 @@ static int rproc_handle_carveout(struct rproc *rproc,
 			goto dma_free;
 		}
 
-		ret = iommu_map(rproc->domain, rsc->da, dma, rsc->len,
-				rsc->flags);
+		ret = iommu_map_sync(rproc->domain, rsc->da, dma, rsc->len,
+				     rsc->flags);
 		if (ret) {
 			dev_err(dev, "iommu_map failed: %d\n", ret);
 			goto free_mapping;
@@ -823,7 +824,8 @@ static void rproc_resource_cleanup(struct rproc *rproc)
 	list_for_each_entry_safe(entry, tmp, &rproc->mappings, node) {
 		size_t unmapped;
 
-		unmapped = iommu_unmap(rproc->domain, entry->da, entry->len);
+		unmapped = iommu_unmap_sync(rproc->domain, entry->da,
+					    entry->len);
 		if (unmapped != entry->len) {
 			/* nothing much to do besides complaining */
 			dev_err(dev, "failed to unmap %u/%zu\n", entry->len,
-- 
2.7.4
