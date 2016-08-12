From: "Sricharan" <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: RE: [PATCH 2/2] iommu/msm: wire up fault handling
Date: Fri, 12 Aug 2016 21:47:22 +0530
Message-ID: <001201d1f4b5$04810fc0$0d832f40$@codeaurora.org>
References: <1471015747-569-1-git-send-email-robdclark@gmail.com>
	<1471015747-569-2-git-send-email-robdclark@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1471015747-569-2-git-send-email-robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Content-Language: en-us
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: 'Rob Clark' <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi,

>When things go wrong on the gpu, we can get *thousands* of faults.  With
>so many pr_err() prints, which were slowing down resuming the iommu,
>drm/msm would think the GPU had actually hung and reset it.
>
>Wire up the fault reporting, so instead we get a small ratelimited print
>of the fault address from drm/msm's fault handler instead.
>
>Signed-off-by: Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>---
> drivers/iommu/msm_iommu.c | 16 +++++++++++-----
> drivers/iommu/msm_iommu.h |  3 +++
> 2 files changed, 14 insertions(+), 5 deletions(-)
>
>diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
>index f6f596f..1110b72 100644
>--- a/drivers/iommu/msm_iommu.c
>+++ b/drivers/iommu/msm_iommu.c
>@@ -411,6 +411,7 @@ static int msm_iommu_attach_dev(struct iommu_domain *domain, struct device *dev)
> 			}
> 			__disable_clocks(iommu);
> 			list_add(&iommu->dom_node, &priv->list_attached);
>+			iommu->domain = domain;
> 		}
> 	}
>
>@@ -614,8 +615,8 @@ irqreturn_t msm_iommu_fault_handler(int irq, void *dev_id)
> 		goto fail;
> 	}
>
>-	pr_err("Unexpected IOMMU page fault!\n");
>-	pr_err("base = %08x\n", (unsigned int)iommu->base);
>+	pr_debug("Unexpected IOMMU page fault!\n");

              So was just thinking if its better to have only this as a ratelimited print,
              for global faults ?, otherwise
                Reviewed-by: sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
 
Regards,
 Sricharan
  
