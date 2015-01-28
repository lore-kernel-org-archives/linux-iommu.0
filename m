From: Emil Medve <Emilian.Medve-eDlz3WWmN0ll57MIdRCFDg@public.gmane.org>
Subject: [PATCH 23/26] iommu/fsl: Use NULL instead of zero
Date: Wed, 28 Jan 2015 08:34:55 -0600
Message-ID: <1422455698-3074-24-git-send-email-Emilian.Medve@Freescale.com>
References: <1422455698-3074-1-git-send-email-Emilian.Medve@Freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1422455698-3074-1-git-send-email-Emilian.Medve-eDlz3WWmN0ll57MIdRCFDg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, jroedel-l3A5Bk7waGM@public.gmane.org, Varun.Sethi-eDlz3WWmN0ll57MIdRCFDg@public.gmane.org
Cc: Emil Medve <Emilian.Medve-eDlz3WWmN0ll57MIdRCFDg@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

drivers/iommu/fsl_pamu.c:532:72: warning: Using plain integer as NULL pointer
drivers/iommu/fsl_pamu.c:559:72: warning: Using plain integer as NULL pointer
drivers/iommu/fsl_pamu.c:570:66: warning: Using plain integer as NULL pointer

Signed-off-by: Emil Medve <Emilian.Medve-eDlz3WWmN0ll57MIdRCFDg@public.gmane.org>
---
 drivers/iommu/fsl_pamu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/fsl_pamu.c b/drivers/iommu/fsl_pamu.c
index 1d9273a..7a4665d 100644
--- a/drivers/iommu/fsl_pamu.c
+++ b/drivers/iommu/fsl_pamu.c
@@ -529,7 +529,7 @@ u32 get_stash_id(u32 stash_dest_hint, u32 vcpu)
 	if (stash_dest_hint == PAMU_ATTR_CACHE_L3) {
 		node = of_find_matching_node(NULL, l3_device_ids);
 		if (node) {
-			prop = of_get_property(node, "cache-stash-id", 0);
+			prop = of_get_property(node, "cache-stash-id", NULL);
 			if (!prop) {
 				pr_debug("missing cache-stash-id at %s\n",
 					 node->full_name);
@@ -556,7 +556,7 @@ found_cpu_node:
 	/* find the hwnode that represents the cache */
 	for (cache_level = PAMU_ATTR_CACHE_L1; (cache_level < PAMU_ATTR_CACHE_L3) && found; cache_level++) {
 		if (stash_dest_hint == cache_level) {
-			prop = of_get_property(node, "cache-stash-id", 0);
+			prop = of_get_property(node, "cache-stash-id", NULL);
 			if (!prop) {
 				pr_debug("missing cache-stash-id at %s\n",
 					 node->full_name);
@@ -567,7 +567,7 @@ found_cpu_node:
 			return be32_to_cpup(prop);
 		}
 
-		prop = of_get_property(node, "next-level-cache", 0);
+		prop = of_get_property(node, "next-level-cache", NULL);
 		if (!prop) {
 			pr_debug("can't find next-level-cache at %s\n",
 				 node->full_name);
-- 
2.2.2
