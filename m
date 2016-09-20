From: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH/RFC] iommu/ipmmu-vmsa: Update ->add_device() return value
Date: Tue, 20 Sep 2016 21:41:44 +0900
Message-ID: <20160920124144.8629.22575.sendpatchset@little-apple>
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
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>

Update the IPMMU driver to return -ENODEV when adding devices
not hooked up a particular IPMMU instance.

Currently the ->add_device() callback implementation in the IPMMU
driver returns -ENODEV for devices with no "iommus" property,
however the function ipmmu_find_utlbs() may return -EINVAL.

This patch updates the ipmmu_find_utlbs() return value to -ENODEV
for the case when multiple IPMMU instances exist. That way the
code matches the expected behaviour described in the comment of
the add_iommu_group() function in iommu.c:

 /*
  * We ignore -ENODEV errors for now, as they just mean that the
  * device is not translated by an IOMMU. We still care about
  * other errors and fail to initialize when they happen.
  */

Signed-off-by: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>
---

 Applies to next-20160920 on top of:
 b1e2afc iommu/ipmmu-vmsa: Fix wrong error handle of ipmmu_add_device

 drivers/iommu/ipmmu-vmsa.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 0002/drivers/iommu/ipmmu-vmsa.c
+++ work/drivers/iommu/ipmmu-vmsa.c	2016-09-08 18:20:06.270607110 +0900
@@ -781,7 +781,7 @@ static int ipmmu_find_utlbs(struct ipmmu
 		of_node_put(args.np);
 
 		if (args.np != mmu->dev->of_node || args.args_count != 1)
-			return -EINVAL;
+			return -ENODEV;
 
 		utlbs[i] = args.args[0];
 	}
