From: Nicholas Krause <xerofoify-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] iommu:Check that iommu_device_create has completed
	successfully in alloc_iommu
Date: Mon,  4 Jan 2016 18:27:57 -0500
Message-ID: <1451950077-22025-1-git-send-email-xerofoify@gmail.com>
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
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This adds the proper check to alloc_iommu to make sure that the call
to iommu_device_create has completed successfully and if not return
to the caller the error code returned after freeing up resources
allocated previously by alloc_iommu.

Signed-off-by: Nicholas Krause <xerofoify-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/iommu/dmar.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index 80e3c17..a496d73 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -1069,6 +1069,12 @@ static int alloc_iommu(struct dmar_drhd_unit *drhd)
 		iommu->iommu_dev = iommu_device_create(NULL, iommu,
 						       intel_iommu_groups,
 						       "%s", iommu->name);
+
+	if (IS_ERR(iommu->iommu_dev)) {
+		drhd->iommu = NULL;
+		err = PTR_ERR(iommu->iommu_dev);
+		goto err_unmap;
+	}
 
 	return 0;
 
-- 
2.5.0
