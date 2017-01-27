From: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH/RFC v2 1/4] iommu/of: Skip IOMMU devices disabled in DT
Date: Fri, 27 Jan 2017 15:14:16 +0900
Message-ID: <148549765644.22203.4025544332917256731.sendpatchset@little-apple>
References: <148549764733.22203.16459470412085471955.sendpatchset@little-apple>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <148549764733.22203.16459470412085471955.sendpatchset@little-apple>
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
Cc: laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>

Extend the shared IOMMU code to skip over ->xlate() in case the
IOMMU device pointed to by a slave device has been disabled in DT.

Difficult to trigger in case a single IOMMU device is used, however
when multiple IOMMUs are used and some of them are disabled in DT
then this patch makes sure that ->xlate() only gets invoked for the
enabled ones.

Signed-off-by: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>
---

 I used to keep this as a local check in the xlate() callback
 for the not-yet-merged-upstream R-Car Gen3 IPMMU driver stack.

 Since honoring DT disabled devices probably makes sense for most users
 it seems like a good plan to try to push it into the common subsystem level.

 Thanks to Geert for suggesting this ages ago.

 Developed on top of renesas-drivers-2017-01-24-v4.10-rc5 which
 includes a recent version of iommu/next.

 drivers/iommu/of_iommu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 0001/drivers/iommu/of_iommu.c
+++ work/drivers/iommu/of_iommu.c	2017-01-27 13:19:22.540607110 +0900
@@ -159,7 +159,7 @@ const struct iommu_ops *of_iommu_configu
 		np = iommu_spec.np;
 		ops = of_iommu_get_ops(np);
 
-		if (!ops || !ops->of_xlate ||
+		if (!ops || !ops->of_xlate || !of_device_is_available(np) ||
 		    iommu_fwspec_init(dev, &np->fwnode, ops) ||
 		    ops->of_xlate(dev, &iommu_spec))
 			goto err_put_node;
