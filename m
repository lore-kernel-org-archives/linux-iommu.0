From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH] iommu/vt-d: Fix up error handling in alloc_iommu
	successfully in alloc_iommu
Date: Thu, 7 Jan 2016 12:19:22 +0100
Message-ID: <20160107111922.GA19149@8bytes.org>
References: <1451950077-22025-1-git-send-email-xerofoify@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1451950077-22025-1-git-send-email-xerofoify-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Nicholas Krause <xerofoify-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Jan 04, 2016 at 06:27:57PM -0500, Nicholas Krause wrote:
> This adds the proper check to alloc_iommu to make sure that the call
> to iommu_device_create has completed successfully and if not return
> to the caller the error code returned after freeing up resources
> allocated previously by alloc_iommu.
> 
> Signed-off-by: Nicholas Krause <xerofoify-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Applied with this fixup on top:

>From 3108f03ce20adf6429cb130b44da528ae85fc68d Mon Sep 17 00:00:00 2001
From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Date: Thu, 7 Jan 2016 12:16:51 +0100
Subject: [PATCH] iommu/vt-d: Fix up error handling in alloc_iommu

Only check for error when iommu->iommu_dev has been assigned
and only assign drhd->iommu when the function can't fail
anymore.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/dmar.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index add177a..62a400c 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -1063,19 +1063,19 @@ static int alloc_iommu(struct dmar_drhd_unit *drhd)
 
 	raw_spin_lock_init(&iommu->register_lock);
 
-	drhd->iommu = iommu;
-
-	if (intel_iommu_enabled)
+	if (intel_iommu_enabled) {
 		iommu->iommu_dev = iommu_device_create(NULL, iommu,
 						       intel_iommu_groups,
 						       "%s", iommu->name);
 
-	if (IS_ERR(iommu->iommu_dev)) {
-		drhd->iommu = NULL;
-		err = PTR_ERR(iommu->iommu_dev);
-		goto err_unmap;
+		if (IS_ERR(iommu->iommu_dev)) {
+			err = PTR_ERR(iommu->iommu_dev);
+			goto err_unmap;
+		}
 	}
 
+	drhd->iommu = iommu;
+
 	return 0;
 
 err_unmap:
-- 
1.8.4.5
