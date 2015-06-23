From: Baptiste Reynal <b.reynal@virtualopensystems.com>
Subject: Re: [PATCH] iommu/arm-smmu: Fix bug in ARM_SMMU_FEAT_TRANS_OPS
 condition check
Date: Tue, 23 Jun 2015 14:12:42 +0200
Message-ID: <CAN9JPjGw+abvTX9mCb0M1K5AaxCHzVNx+ccf+iyDo34EL8KzRA@mail.gmail.com>
References: <1435061246-14690-1-git-send-email-sricharan@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1435061246-14690-1-git-send-email-sricharan@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Sricharan R <sricharan@codeaurora.org>
Cc: "moderated list:ARM SMMU DRIVER" <linux-arm-kernel@lists.infradead.org>, Linux IOMMU <iommu@lists.linux-foundation.org>, Will Deacon <will.deacon@arm.com>, linux-arm-msm@vger.kernel.org, open list <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

This issue has already been fixed here :
http://www.spinics.net/lists/arm-kernel/msg424824.html

Regards,
Baptiste

On Tue, Jun 23, 2015 at 2:07 PM, Sricharan R <sricharan@codeaurora.org> wrote:
> Patch 'fix ARM_SMMU_FEAT_TRANS_OPS condition' changed the check
> for ARM_SMMU_FEAT_TRANS_OPS to be based on presence of stage1 check,
> but used (id & ID0_ATOSNS) instead of !(id & ID0_ATOSNS).
> Fix it here.
>
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> ---
>  drivers/iommu/arm-smmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 09091e9..fbf4af6 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -1866,7 +1866,7 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
>                 return -ENODEV;
>         }
>
> -       if ((id & ID0_S1TS) && ((smmu->version == 1) || (id & ID0_ATOSNS))) {
> +       if ((id & ID0_S1TS) && ((smmu->version == 1) || !(id & ID0_ATOSNS))) {
>                 smmu->features |= ARM_SMMU_FEAT_TRANS_OPS;
>                 dev_notice(smmu->dev, "\taddress translation ops\n");
>         }
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
>
