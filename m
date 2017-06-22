From: Arvind Yadav <arvind.yadav.cs-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] iommu/intel-iommu: Handle return of
	iommu_device_register/iommu_device_sysfs_add
Date: Thu, 22 Jun 2017 15:14:16 +0530
Message-ID: <638ae85be5f0944bc698f89a8783f647e0757d79.1498124554.git.arvind.yadav.cs@gmail.com>
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
To: dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, jroedel-l3A5Bk7waGM@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

iommu_device_register and iommu_device_sysfs_add can fail here and
we must check its return value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/iommu/intel-iommu.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 9e35ad6..0e7b374 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -4909,11 +4909,19 @@ int __init intel_iommu_init(void)
 	init_iommu_pm_ops();
 
 	for_each_active_iommu(iommu, drhd) {
-		iommu_device_sysfs_add(&iommu->iommu, NULL,
+		ret = iommu_device_sysfs_add(&iommu->iommu, NULL,
 				       intel_iommu_groups,
 				       "%s", iommu->name);
+		if (ret) {
+			pr_err("Failed to register iommu in sysfs\n");
+			goto out_free_reserved_range;
+		}
 		iommu_device_set_ops(&iommu->iommu, &intel_iommu_ops);
-		iommu_device_register(&iommu->iommu);
+		ret = iommu_device_register(&iommu->iommu);
+		if (ret) {
+			pr_err("Failed to register iommu\n");
+			goto out_free_reserved_range;
+		}
 	}
 
 	bus_set_iommu(&pci_bus_type, &intel_iommu_ops);
-- 
1.9.1
