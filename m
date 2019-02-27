From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 04/13] iommu/mediatek: Add device_link between the
 consumer and the larb devices
Date: Wed, 27 Feb 2019 19:30:10 +0000
Message-ID: <709d7d66-9610-eeb3-128e-e2156bcfb616@arm.com>
References: <1546318276-18993-1-git-send-email-yong.wu@mediatek.com>
 <1546318276-18993-5-git-send-email-yong.wu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1546318276-18993-5-git-send-email-yong.wu@mediatek.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh+dt@kernel.org>
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org, Nicolas Boichat <drinkcat@chromium.org>, arnd@arndb.de, srv_heupstream@mediatek.com, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Tomasz Figa <tfiga@google.com>, iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org, yingjoe.chen@mediatek.com, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

On 01/01/2019 04:51, Yong Wu wrote:
> MediaTek IOMMU don't have its power-domain. all the consumer connect
> with smi-larb, then connect with smi-common.
> 
>          M4U
>           |
>      smi-common
>           |
>    -------------
>    |         |    ...
>    |         |
> larb1     larb2
>    |         |
> vdec       venc
> 
> When the consumer works, it should enable the smi-larb's power which
> also need enable the smi-common's power firstly.
> 
> Thus, First of all, use the device link connect the consumer and the
> smi-larbs. then add device link between the smi-larb and smi-common.
> 
> This patch adds device_link between the consumer and the larbs.
> 
> Suggested-by: Tomasz Figa <tfiga@chromium.org>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>   drivers/iommu/mtk_iommu.c    | 15 +++++++++++++--
>   drivers/iommu/mtk_iommu_v1.c | 14 ++++++++++++--
>   2 files changed, 25 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 202e41b..735ae8d 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -247,6 +247,7 @@ static void mtk_iommu_config(struct mtk_iommu_data *data,
>   	struct mtk_smi_larb_iommu    *larb_mmu;
>   	unsigned int                 larbid, portid;
>   	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> +	struct device_link *link;
>   	int i;
>   
>   	for (i = 0; i < fwspec->num_ids; ++i) {
> @@ -257,10 +258,20 @@ static void mtk_iommu_config(struct mtk_iommu_data *data,
>   		dev_dbg(dev, "%s iommu port: %d\n",
>   			enable ? "enable" : "disable", portid);
>   
> -		if (enable)
> +		if (enable) {
>   			larb_mmu->mmu |= MTK_SMI_MMU_EN(portid);
> -		else
> +			/* Link the consumer with the larb device(supplier) */
> +			link = device_link_add(dev, larb_mmu->dev,
> +					       DL_FLAG_PM_RUNTIME |
> +					       DL_FLAG_AUTOREMOVE_CONSUMER);

This looks technically wrong, since we get here from 
mtk_iommu_attach_device(), and in theory a device could get attached to 
any number of domains over its lifetime, so adding a link at this point 
when there's no corresponding cleanup on detach is definitely 
unbalanced. If you want this layer to manage the link on behalf of the 
consumer, it would probably be better to do it at the point of 
mtk_iommu_add_device(), and either track it for manual cleanup in 
mtk_iommu_remove_device() or rely on AUTOREMOVE_SUPPLIER.

Robin.

> +			if (!link) {
> +				dev_err(dev, "Unable to link %s\n",
> +					dev_name(larb_mmu->dev));
> +				return;
> +			}
> +		} else {
>   			larb_mmu->mmu &= ~MTK_SMI_MMU_EN(portid);
> +		}
>   	}
>   }
>   
> diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
> index 9386aee..022bad9 100644
> --- a/drivers/iommu/mtk_iommu_v1.c
> +++ b/drivers/iommu/mtk_iommu_v1.c
> @@ -201,6 +201,7 @@ static void mtk_iommu_config(struct mtk_iommu_data *data,
>   	struct mtk_smi_larb_iommu    *larb_mmu;
>   	unsigned int                 larbid, portid;
>   	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> +	struct device_link *link;
>   	int i;
>   
>   	for (i = 0; i < fwspec->num_ids; ++i) {
> @@ -211,10 +212,19 @@ static void mtk_iommu_config(struct mtk_iommu_data *data,
>   		dev_dbg(dev, "%s iommu port: %d\n",
>   			enable ? "enable" : "disable", portid);
>   
> -		if (enable)
> +		if (enable) {
>   			larb_mmu->mmu |= MTK_SMI_MMU_EN(portid);
> -		else
> +			link = device_link_add(dev, larb_mmu->dev,
> +					       DL_FLAG_PM_RUNTIME |
> +					       DL_FLAG_AUTOREMOVE_CONSUMER);
> +			if (!link) {
> +				dev_err(dev, "Unable to link %s\n",
> +					dev_name(larb_mmu->dev));
> +				return;
> +			}
> +		} else {
>   			larb_mmu->mmu &= ~MTK_SMI_MMU_EN(portid);
> +		}
>   	}
>   }
>   
> 
