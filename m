From: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 0/2] iommu/ipmmu-vmsa: Modify ipmmu_slave_whitelist()
Date: Wed, 28 Nov 2018 09:23:35 +0000
Message-ID: <1543396868-14723-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
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

This patch set is based on iommu.git / latest next branch
(commit id = f262283c224537962cba0f41b8823e3be9f7b0ff)

I talked with Geert-san about this topic on below:
https://patchwork.kernel.org/patch/10651375/

Also Simon-san suggests we should keep the whitelist.

So, not to change behavior of R-Car Gen2, this patch set adds
two conditions. After applied this patch set, we can add slave
devices easily like below:

--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -774,6 +774,8 @@ static int ipmmu_init_platform_device(struct device *dev,
 };
 
 static const char * const rcar_gen3_slave_whitelist[] = {
+	"e6700000.dma-controller",
+	"e7300000.dma-controller"
 };
 
 static bool ipmmu_slave_whitelist(struct device *dev)


Changes from v1:
 - Use "ES3.*" instead of "ES3.0" for r8a7795 in patch 1.
 - Use "unsigned int" instead of "int" in patch 2.
 - Add Geert-san's Reviewed-by.
 

Yoshihiro Shimoda (2):
  iommu/ipmmu-vmsa: Modify ipmmu_slave_whitelist() to check SoC
    revisions
  iommu/ipmmu-vmsa: add an array of slave devices whitelist

 drivers/iommu/ipmmu-vmsa.c | 45 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 37 insertions(+), 8 deletions(-)

-- 
1.9.1
