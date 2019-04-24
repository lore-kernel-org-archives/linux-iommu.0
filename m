From: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH v3 1/6] iommu/ipmmu-vmsa: Link IOMMUs and devices in sysfs
Date: Wed, 24 Apr 2019 15:55:13 +0200
Message-ID: <20190424135518.25150-2-geert+renesas@glider.be>
References: <20190424135518.25150-1-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20190424135518.25150-1-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>
Cc: linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

As of commit 7af9a5fdb9e0ca33 ("iommu/ipmmu-vmsa: Use
iommu_device_sysfs_add()/remove()"), IOMMU devices show up under
/sys/class/iommu/, but their "devices" subdirectories are empty.
Likewise, devices tied to an IOMMU do not have an "iommu" backlink.

Make sure all links are created, on both arm32 and arm64.

Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Reviewed-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
---
v3:
  - Fix sysfs path typo in patch description,

v2:
  - Add Reviewed-by.
---
 drivers/iommu/ipmmu-vmsa.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 9a380c10655e182d..9f2b781e20a0eba6 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -885,27 +885,37 @@ static int ipmmu_init_arm_mapping(struct device *dev)
 
 static int ipmmu_add_device(struct device *dev)
 {
+	struct ipmmu_vmsa_device *mmu = to_ipmmu(dev);
 	struct iommu_group *group;
+	int ret;
 
 	/*
 	 * Only let through devices that have been verified in xlate()
 	 */
-	if (!to_ipmmu(dev))
+	if (!mmu)
 		return -ENODEV;
 
-	if (IS_ENABLED(CONFIG_ARM) && !IS_ENABLED(CONFIG_IOMMU_DMA))
-		return ipmmu_init_arm_mapping(dev);
+	if (IS_ENABLED(CONFIG_ARM) && !IS_ENABLED(CONFIG_IOMMU_DMA)) {
+		ret = ipmmu_init_arm_mapping(dev);
+		if (ret)
+			return ret;
+	} else {
+		group = iommu_group_get_for_dev(dev);
+		if (IS_ERR(group))
+			return PTR_ERR(group);
 
-	group = iommu_group_get_for_dev(dev);
-	if (IS_ERR(group))
-		return PTR_ERR(group);
+		iommu_group_put(group);
+	}
 
-	iommu_group_put(group);
+	iommu_device_link(&mmu->iommu, dev);
 	return 0;
 }
 
 static void ipmmu_remove_device(struct device *dev)
 {
+	struct ipmmu_vmsa_device *mmu = to_ipmmu(dev);
+
+	iommu_device_unlink(&mmu->iommu, dev);
 	arm_iommu_detach_device(dev);
 	iommu_group_remove_device(dev);
 }
-- 
2.17.1
