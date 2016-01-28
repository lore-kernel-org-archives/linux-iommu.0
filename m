From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [RFC PATCH 3/6] of: iommu: Increment DT node refcount in
 of_iommu_set_ops()
Date: Thu, 28 Jan 2016 17:15:23 +0000
Message-ID: <56AA4CAB.6000708@arm.com>
References: <1453872079-27140-1-git-send-email-anup.patel@broadcom.com>
 <1453872079-27140-4-git-send-email-anup.patel@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1453872079-27140-4-git-send-email-anup.patel@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Anup Patel <anup.patel@broadcom.com>, Catalin Marinas <catalin.marinas@arm.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>, Robin Murphy <Robin.Murphy@arm.com>, Sricharan R <sricharan@codeaurora.org>, Linux IOMMU <iommu@lists.linux-foundation.org>, Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Device Tree <devicetree@vger.kernel.org>, Scott Branden <sbranden@broadcom.com>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Ray Jui <rjui@broadcom.com>, Linux Kernel <linux-kernel@vger.kernel.org>, Vikram Prakash <vikramp@broadcom.com>, Rob Herring <robh+dt@kernel.org>, BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>, Kumar Gala <galak@codeaurora.org>
List-Id: iommu@lists.linux-foundation.org

On 27/01/16 05:21, Anup Patel wrote:
> We are saving pointer to iommu DT node in of_iommu_set_ops()
> hence we should increment DT node ref count.

Oh man, shame on whoever wrote that code! :P

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Anup Patel <anup.patel@broadcom.com>
> Reviewed-by: Ray Jui <rjui@broadcom.com>
> Reviewed-by: Scott Branden <sbranden@broadcom.com>
> ---
>   drivers/iommu/of_iommu.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> index 60ba238..5fea665 100644
> --- a/drivers/iommu/of_iommu.c
> +++ b/drivers/iommu/of_iommu.c
> @@ -110,6 +110,7 @@ void of_iommu_set_ops(struct device_node *np, struct iommu_ops *ops)
>   	if (WARN_ON(!iommu))
>   		return;
>
> +	of_node_get(np);
>   	INIT_LIST_HEAD(&iommu->list);
>   	iommu->np = np;
>   	iommu->ops = ops;
>
