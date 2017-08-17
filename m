From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 11/13] gpu: host1x: Use sychronized interface of the IOMMU-API
Date: Thu, 17 Aug 2017 14:56:34 +0200
Message-ID: <1502974596-23835-12-git-send-email-joro@8bytes.org>
References: <1502974596-23835-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1502974596-23835-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

The map and unmap functions of the IOMMU-API changed their
semantics: They do no longer guarantee that the hardware
TLBs are synchronized with the page-table updates they made.

To make conversion easier, new synchronized functions have
been introduced which give these guarantees again until the
code is converted to use the new TLB-flush interface of the
IOMMU-API, which allows certain optimizations.

But for now, just convert this code to use the synchronized
functions so that it will behave as before.

Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/gpu/host1x/cdma.c | 6 +++---
 drivers/gpu/host1x/job.c  | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/host1x/cdma.c b/drivers/gpu/host1x/cdma.c
index 28541b2..bdf557e 100644
--- a/drivers/gpu/host1x/cdma.c
+++ b/drivers/gpu/host1x/cdma.c
@@ -55,7 +55,7 @@ static void host1x_pushbuffer_destroy(struct push_buffer *pb)
 		return;
 
 	if (host1x->domain) {
-		iommu_unmap(host1x->domain, pb->dma, pb->alloc_size);
+		iommu_unmap_sync(host1x->domain, pb->dma, pb->alloc_size);
 		free_iova(&host1x->iova, iova_pfn(&host1x->iova, pb->dma));
 	}
 
@@ -105,8 +105,8 @@ static int host1x_pushbuffer_init(struct push_buffer *pb)
 		}
 
 		pb->dma = iova_dma_addr(&host1x->iova, alloc);
-		err = iommu_map(host1x->domain, pb->dma, pb->phys, size,
-				IOMMU_READ);
+		err = iommu_map_sync(host1x->domain, pb->dma, pb->phys, size,
+				     IOMMU_READ);
 		if (err)
 			goto iommu_free_iova;
 	} else {
diff --git a/drivers/gpu/host1x/job.c b/drivers/gpu/host1x/job.c
index bee5044..70a029c 100644
--- a/drivers/gpu/host1x/job.c
+++ b/drivers/gpu/host1x/job.c
@@ -243,7 +243,7 @@ static unsigned int pin_job(struct host1x *host, struct host1x_job *job)
 				goto unpin;
 			}
 
-			err = iommu_map_sg(host->domain,
+			err = iommu_map_sg_sync(host->domain,
 					iova_dma_addr(&host->iova, alloc),
 					sgt->sgl, sgt->nents, IOMMU_READ);
 			if (err == 0) {
@@ -695,8 +695,8 @@ void host1x_job_unpin(struct host1x_job *job)
 		struct host1x_job_unpin_data *unpin = &job->unpins[i];
 
 		if (!IS_ENABLED(CONFIG_TEGRA_HOST1X_FIREWALL) && host->domain) {
-			iommu_unmap(host->domain, job->addr_phys[i],
-				    unpin->size);
+			iommu_unmap_sync(host->domain, job->addr_phys[i],
+					 unpin->size);
 			free_iova(&host->iova,
 				iova_pfn(&host->iova, job->addr_phys[i]));
 		}
-- 
2.7.4
