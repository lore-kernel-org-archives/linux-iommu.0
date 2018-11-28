From: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 1/2] iommu/ipmmu-vmsa: Modify ipmmu_slave_whitelist() to check
	SoC revisions
Date: Wed, 28 Nov 2018 06:10:30 +0000
Message-ID: <1543385279-1584-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
References: <1543385279-1584-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1543385279-1584-1-git-send-email-yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: "geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org" <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, "magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org" <horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Some R-Car Gen3 SoCs has hardware restrictions on the IPMMU. So,
to check whether this R-Car Gen3 SoC can use the IPMMU correctly,
this patch modifies the ipmmu_slave_whitelist().

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
---
 drivers/iommu/ipmmu-vmsa.c | 34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 9e2655f..1c38538 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -754,12 +754,6 @@ static int ipmmu_init_platform_device(struct device *dev,
 	return 0;
 }
 
-static bool ipmmu_slave_whitelist(struct device *dev)
-{
-	/* By default, do not allow use of IPMMU */
-	return false;
-}
-
 static const struct soc_device_attribute soc_rcar_gen3[] = {
 	{ .soc_id = "r8a774a1", },
 	{ .soc_id = "r8a7795", },
@@ -771,11 +765,35 @@ static bool ipmmu_slave_whitelist(struct device *dev)
 	{ /* sentinel */ }
 };
 
+static const struct soc_device_attribute soc_rcar_gen3_whitelist[] = {
+	{ .soc_id = "r8a7795", .revision = "ES3.0" },
+	{ .soc_id = "r8a77965", },
+	{ .soc_id = "r8a77990", },
+	{ .soc_id = "r8a77995", },
+	{ /* sentinel */ }
+};
+
+static bool ipmmu_slave_whitelist(struct device *dev)
+{
+	/*
+	 * For R-Car Gen3 use a white list to opt-in slave devices.
+	 * For Other SoCs, this returns true anyway.
+	 */
+	if (!soc_device_match(soc_rcar_gen3))
+		return true;
+
+	/* Check whether this R-Car Gen3 can use the IPMMU correctly or not */
+	if (!soc_device_match(soc_rcar_gen3_whitelist))
+		return false;
+
+	/* By default, do not allow use of IPMMU */
+	return false;
+}
+
 static int ipmmu_of_xlate(struct device *dev,
 			  struct of_phandle_args *spec)
 {
-	/* For R-Car Gen3 use a white list to opt-in slave devices */
-	if (soc_device_match(soc_rcar_gen3) && !ipmmu_slave_whitelist(dev))
+	if (!ipmmu_slave_whitelist(dev))
 		return -ENODEV;
 
 	iommu_fwspec_add_ids(dev, spec->args, 1);
-- 
1.9.1
