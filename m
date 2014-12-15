From: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: [PATCH 01/10] iommu/ipmmu-vmsa: Cleanup failures of ARM mapping
	creation or attachment
Date: Mon, 15 Dec 2014 02:13:40 +0200
Message-ID: <1418602429-11276-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1418602429-11276-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1418602429-11276-1-git-send-email-laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
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
Cc: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

The ARM IOMMU mapping needs to be released when attaching the device
fails. Add arm_iommu_release_mapping() to the error code path. This is
safe to call with a NULL mapping, so no specific check is needed.

Cleanup is also missing when failing to create a mapping. Jump to the
error code path in that case instead of returning immediately.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
---
 drivers/iommu/ipmmu-vmsa.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 7dab5cbcc775..f7036adb5634 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -1090,7 +1090,8 @@ static int ipmmu_add_device(struct device *dev)
 						   SZ_1G, SZ_2G);
 		if (IS_ERR(mapping)) {
 			dev_err(mmu->dev, "failed to create ARM IOMMU mapping\n");
-			return PTR_ERR(mapping);
+			ret = PTR_ERR(mapping);
+			goto error;
 		}
 
 		mmu->mapping = mapping;
@@ -1106,6 +1107,7 @@ static int ipmmu_add_device(struct device *dev)
 	return 0;
 
 error:
+	arm_iommu_release_mapping(mmu->mapping);
 	kfree(dev->archdata.iommu);
 	dev->archdata.iommu = NULL;
 	iommu_group_remove_device(dev);
-- 
2.0.4
