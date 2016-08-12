From: "Sricharan" <sricharan@codeaurora.org>
Subject: RE: [PATCH 1/2] iommu/msm: resume device after fault
Date: Fri, 12 Aug 2016 21:20:47 +0530
Message-ID: <000f01d1f4b1$4da988c0$e8fc9a40$@codeaurora.org>
References: <1471015747-569-1-git-send-email-robdclark@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1471015747-569-1-git-send-email-robdclark@gmail.com>
Content-Language: en-us
Sender: linux-arm-msm-owner@vger.kernel.org
To: 'Rob Clark' <robdclark@gmail.com>, iommu@lists.linux-foundation.org
Cc: linux-arm-msm@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hi,

>We need to disable stall on memory access after a fault, otherwise the
>device using the iommu will be perma-wedged with no access to memory.
>This was causing drm/msm to be unable to recover the gpu after an iommu
>fault.
>
>Signed-off-by: Rob Clark <robdclark@gmail.com>
>---
> drivers/iommu/msm_iommu.c | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
>index b09692b..f6f596f 100644
>--- a/drivers/iommu/msm_iommu.c
>+++ b/drivers/iommu/msm_iommu.c
>@@ -628,6 +628,7 @@ irqreturn_t msm_iommu_fault_handler(int irq, void *dev_id)
> 			pr_err("Interesting registers:\n");
> 			print_ctx_regs(iommu->base, i);
> 			SET_FSR(iommu->base, i, 0x4000000F);
>+			SET_RESUME(iommu->base, i, 1);

    Acked-by:  sricharan@codeaurora.org

Regards,
Sricharan
