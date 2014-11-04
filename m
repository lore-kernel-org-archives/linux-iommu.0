From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v6 1/1] iommu-api: Add map_sg function
Date: Tue, 4 Nov 2014 14:57:16 +0100
Message-ID: <20141104135716.GA14512@8bytes.org>
References: <1414256116-26933-1-git-send-email-ohaugan@codeaurora.org>
	<1414256116-26933-2-git-send-email-ohaugan@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1414256116-26933-2-git-send-email-ohaugan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Olav Haugan <ohaugan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org, kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Sat, Oct 25, 2014 at 09:55:16AM -0700, Olav Haugan wrote:
>  drivers/iommu/amd_iommu.c      |  1 +
>  drivers/iommu/arm-smmu.c       |  1 +
>  drivers/iommu/exynos-iommu.c   |  1 +
>  drivers/iommu/intel-iommu.c    |  1 +
>  drivers/iommu/iommu.c          | 25 +++++++++++++++++++++++++
>  drivers/iommu/ipmmu-vmsa.c     |  1 +
>  drivers/iommu/msm_iommu.c      |  1 +
>  drivers/iommu/omap-iommu.c     |  1 +
>  drivers/iommu/shmobile-iommu.c |  1 +
>  drivers/iommu/tegra-smmu.c     |  1 +
>  include/linux/iommu.h          | 22 ++++++++++++++++++++++
>  11 files changed, 56 insertions(+)

Applied to the core branch in my tree, with the patch below on-top of
it. Thanks, Olav.

>From 38ec010d9b04ed94845f8ff6f10d33eb6bbfe180 Mon Sep 17 00:00:00 2001
From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Date: Tue, 4 Nov 2014 14:53:51 +0100
Subject: [PATCH] iommu: Do more input validation in iommu_map_sg()

The IOMMU-API works on page boundarys, unlike the DMA-API
which can work with sub-page buffers. The sg->offset
field does not make sense on the IOMMU level, so force it to
be 0. Do some error-path consolidation while at it.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/iommu.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 46727ce..08c53c5 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1127,26 +1127,33 @@ EXPORT_SYMBOL_GPL(iommu_unmap);
 size_t default_iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
 			 struct scatterlist *sg, unsigned int nents, int prot)
 {
-	int ret;
+	struct scatterlist *s;
 	size_t mapped = 0;
 	unsigned int i;
-	struct scatterlist *s;
+	int ret;
 
 	for_each_sg(sg, s, nents, i) {
 		phys_addr_t phys = page_to_phys(sg_page(s));
-		size_t page_len = s->offset + s->length;
 
-		ret = iommu_map(domain, iova + mapped, phys, page_len, prot);
-		if (ret) {
-			/* undo mappings already done */
-			iommu_unmap(domain, iova, mapped);
-			mapped = 0;
-			break;
-		}
-		mapped += page_len;
+		/* We are mapping on page boundarys, so offset must be 0 */
+		if (s->offset)
+			goto out_err;
+
+		ret = iommu_map(domain, iova + mapped, phys, s->length, prot);
+		if (ret)
+			goto out_err;
+
+		mapped += s->length;
 	}
 
 	return mapped;
+
+out_err:
+	/* undo mappings already done */
+	iommu_unmap(domain, iova, mapped);
+
+	return 0;
+
 }
 EXPORT_SYMBOL_GPL(default_iommu_map_sg);
 
-- 
1.8.4.5
