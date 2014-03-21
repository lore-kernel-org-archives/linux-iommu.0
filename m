From: David Woodhouse <David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 03/33] iommu/vt-d: Allocate space for ACPI devices
Date: Fri, 21 Mar 2014 17:18:44 +0000
Message-ID: <1395422354-19762-4-git-send-email-David.Woodhouse@intel.com>
References: <1395422354-19762-1-git-send-email-David.Woodhouse@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1395422354-19762-1-git-send-email-David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
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
List-Id: iommu@lists.linux-foundation.org

Signed-off-by: David Woodhouse <David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/iommu/dmar.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index eb95020..4c6297d 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -84,7 +84,8 @@ void *dmar_alloc_dev_scope(void *start, void *end, int *cnt)
 	*cnt = 0;
 	while (start < end) {
 		scope = start;
-		if (scope->entry_type == ACPI_DMAR_SCOPE_TYPE_ENDPOINT ||
+		if (scope->entry_type == ACPI_DMAR_SCOPE_TYPE_ACPI ||
+		    scope->entry_type == ACPI_DMAR_SCOPE_TYPE_ENDPOINT ||
 		    scope->entry_type == ACPI_DMAR_SCOPE_TYPE_BRIDGE)
 			(*cnt)++;
 		else if (scope->entry_type != ACPI_DMAR_SCOPE_TYPE_IOAPIC &&
@@ -342,21 +343,18 @@ dmar_parse_one_drhd(struct acpi_dmar_header *header)
 	dmaru->reg_base_addr = drhd->address;
 	dmaru->segment = drhd->segment;
 	dmaru->include_all = drhd->flags & 0x1; /* BIT0: INCLUDE_ALL */
-	if (!dmaru->include_all) {
-		dmaru->devices = dmar_alloc_dev_scope((void *)(drhd + 1),
-					((void *)drhd) + drhd->header.length,
-					&dmaru->devices_cnt);
-		if (dmaru->devices_cnt && dmaru->devices == NULL) {
-			kfree(dmaru);
-			return -ENOMEM;
-		}
+	dmaru->devices = dmar_alloc_dev_scope((void *)(drhd + 1),
+					      ((void *)drhd) + drhd->header.length,
+					      &dmaru->devices_cnt);
+	if (dmaru->devices_cnt && dmaru->devices == NULL) {
+		kfree(dmaru);
+		return -ENOMEM;
 	}
 
 	ret = alloc_iommu(dmaru);
 	if (ret) {
-		if (!dmaru->include_all)
-			dmar_free_dev_scope(&dmaru->devices,
-					    &dmaru->devices_cnt);
+		dmar_free_dev_scope(&dmaru->devices,
+				    &dmaru->devices_cnt);
 		kfree(dmaru);
 		return ret;
 	}
-- 
1.8.5.3
