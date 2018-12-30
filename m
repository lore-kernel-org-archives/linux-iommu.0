From: Julia Lawall <Julia.Lawall-L2FTfq7BK8M@public.gmane.org>
Subject: [PATCH 8/8] iommu/msm: reduce indentation
Date: Sun, 30 Dec 2018 16:53:15 +0100
Message-ID: <1546185195-25676-9-git-send-email-Julia.Lawall@lip6.fr>
References: <1546185195-25676-1-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1546185195-25676-1-git-send-email-Julia.Lawall-L2FTfq7BK8M@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Delete tab aligning a statement with the right hand side of a
preceding assignment rather than the left hand side.

Found with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall-L2FTfq7BK8M@public.gmane.org>

---
 drivers/iommu/msm_iommu.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index fc4270733f11..6dde3a9db92e 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -461,10 +461,10 @@ static int msm_iommu_attach_dev(struct iommu_domain *domain, struct device *dev)
 				master->num =
 					msm_iommu_alloc_ctx(iommu->context_map,
 							    0, iommu->ncb);
-					if (IS_ERR_VALUE(master->num)) {
-						ret = -ENODEV;
-						goto fail;
-					}
+				if (IS_ERR_VALUE(master->num)) {
+					ret = -ENODEV;
+					goto fail;
+				}
 				config_mids(iommu, master);
 				__program_context(iommu->base, master->num,
 						  priv);
