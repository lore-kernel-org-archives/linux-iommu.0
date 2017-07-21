From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH 2/2] iommu/rockchip: ignore isp mmu reset operation
Date: Fri, 21 Jul 2017 09:54:00 +0800
Message-ID: <c8d74b7f-9c74-e5a7-d0e0-2e52ae8d6e8b@rock-chips.com>
References: <1500600921-102537-1-git-send-email-xxm@rock-chips.com>
 <1500600921-102537-2-git-send-email-xxm@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1500600921-102537-2-git-send-email-xxm@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Simon Xue <xxm@rock-chips.com>
Cc: Joerg Roedel <joro@8bytes.org>, Heiko Stuebner <heiko@sntech.de>, shawn.lin@rock-chips.com, linux-rockchip@lists.infradead.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hi Simon,

On 2017/7/21 9:35, Simon Xue wrote:
> From: Simon <xxm@rock-chips.com>
> 
> ISP mmu can't support reset operation, it won't get the
> expected result when reset, but rest functions work normally.
> Add this patch as a WA for this issue.
> 
> Signed-off-by: Simon <xxm@rock-chips.com>
> ---
>   drivers/iommu/rockchip-iommu.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
> index b38283e..47c00b9 100644
> --- a/drivers/iommu/rockchip-iommu.c
> +++ b/drivers/iommu/rockchip-iommu.c
> @@ -92,6 +92,7 @@ struct rk_iommu {
>   	int num_mmu;
>   	int *irq;
>   	int num_irq;
> +	bool reset_disabled;
>   	struct iommu_device iommu;
>   	struct list_head node; /* entry in rk_iommu_domain.iommus */
>   	struct iommu_domain *domain; /* domain to which iommu is attached */
> @@ -415,6 +416,9 @@ static int rk_iommu_force_reset(struct rk_iommu *iommu)
>   	int ret, i;
>   	u32 dte_addr;
>   
> +	if (iommu->reset_disabled)
> +		return 0;
> +
>   	/*
>   	 * Check if register DTE_ADDR is working by writing DTE_ADDR_DUMMY
>   	 * and verifying that upper 5 nybbles are read back.
> @@ -1177,6 +1181,9 @@ static int rk_iommu_probe(struct platform_device *pdev)
>   		}
>   	}
>   
> +	iommu->reset_disabled = device_property_read_bool(dev,
> +					"rk_iommu,disable_reset_quirk");
> +

Please update Documentation/devicetree/bindings/iommu/rockchip,iommu.txt
as well. And please use '-' instead of '_' for DT property.


>   	err = iommu_device_sysfs_add(&iommu->iommu, dev, NULL, dev_name(dev));
>   	if (err)
>   		return err;
> 
