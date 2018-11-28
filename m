From: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 2/2] iommu/ipmmu-vmsa: add an array of slave devices whitelist
Date: Wed, 28 Nov 2018 06:10:31 +0000
Message-ID: <1543385279-1584-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
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

To avoid adding copy and pasted strcmp codes in the future,
this patch adds an array "rcar_gen3_slave_whitelist" to check
whether the device can work with the IPMMU or not.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
---
 drivers/iommu/ipmmu-vmsa.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 1c38538..1f65469 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -773,8 +773,13 @@ static int ipmmu_init_platform_device(struct device *dev,
 	{ /* sentinel */ }
 };
 
+static const char * const rcar_gen3_slave_whitelist[] = {
+};
+
 static bool ipmmu_slave_whitelist(struct device *dev)
 {
+	int i;
+
 	/*
 	 * For R-Car Gen3 use a white list to opt-in slave devices.
 	 * For Other SoCs, this returns true anyway.
@@ -786,7 +791,13 @@ static bool ipmmu_slave_whitelist(struct device *dev)
 	if (!soc_device_match(soc_rcar_gen3_whitelist))
 		return false;
 
-	/* By default, do not allow use of IPMMU */
+	/* Check whether this slave device can work with the IPMMU */
+	for (i = 0; i < ARRAY_SIZE(rcar_gen3_slave_whitelist); i++) {
+		if (!strcmp(dev_name(dev), rcar_gen3_slave_whitelist[i]))
+			return true;
+	}
+
+	/* Otherwise, do not allow use of IPMMU */
 	return false;
 }
 
-- 
1.9.1
