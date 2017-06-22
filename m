From: Arvind Yadav <arvind.yadav.cs-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] iommu/amd_iommu_init: Handle return of
	iommu_device_register/iommu_device_sysfs_add
Date: Thu, 22 Jun 2017 13:50:19 +0530
Message-ID: <b30120510267556ae2bc353108d92633213de806.1498119505.git.arvind.yadav.cs@gmail.com>
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

iommu_device_register and iommu_device_sysfs_add can fail here and
we must check its return value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/iommu/amd_iommu_init.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 41a66ae..c420a68 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -1642,10 +1642,15 @@ static int iommu_init_pci(struct amd_iommu *iommu)
 	amd_iommu_erratum_746_workaround(iommu);
 	amd_iommu_ats_write_check_workaround(iommu);
 
-	iommu_device_sysfs_add(&iommu->iommu, &iommu->dev->dev,
+	ret = iommu_device_sysfs_add(&iommu->iommu, &iommu->dev->dev,
 			       amd_iommu_groups, "ivhd%d", iommu->index);
+	if (ret)
+		return ret;
+
 	iommu_device_set_ops(&iommu->iommu, &amd_iommu_ops);
-	iommu_device_register(&iommu->iommu);
+	ret = iommu_device_register(&iommu->iommu);
+	if (ret)
+		return ret;
 
 	return pci_enable_device(iommu->dev);
 }
-- 
1.9.1
