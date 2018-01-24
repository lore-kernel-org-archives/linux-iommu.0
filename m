From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v5 08/13] iommu/rockchip: Control clocks needed to access
 the IOMMU
Date: Wed, 24 Jan 2018 13:49:38 +0000
Message-ID: <f06d2d9f-3869-ed02-43f4-f4ea4a104a57@arm.com>
References: <20180124103516.2571-1-jeffy.chen@rock-chips.com>
 <20180124103516.2571-9-jeffy.chen@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180124103516.2571-9-jeffy.chen@rock-chips.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Jeffy Chen <jeffy.chen@rock-chips.com>, linux-kernel@vger.kernel.org
Cc: jcliang@chromium.org, xxm@rock-chips.com, tfiga@chromium.org, devicetree@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Joerg Roedel <joro@8bytes.org>, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

On 24/01/18 10:35, Jeffy Chen wrote:
> From: Tomasz Figa <tfiga@chromium.org>
> 
> Current code relies on master driver enabling necessary clocks before
> IOMMU is accessed, however there are cases when the IOMMU should be
> accessed while the master is not running yet, for example allocating
> V4L2 videobuf2 buffers, which is done by the VB2 framework using DMA
> mapping API and doesn't engage the master driver at all.
> 
> This patch fixes the problem by letting clocks needed for IOMMU
> operation to be listed in Device Tree and making the driver enable them
> for the time of accessing the hardware.
> 
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> Signed-off-by: Tomasz Figa <tfiga@chromium.org>
> ---
> 
> Changes in v5:
> Use clk_bulk APIs.
> 
> Changes in v4: None
> Changes in v3: None
> Changes in v2: None
> 
>   .../devicetree/bindings/iommu/rockchip,iommu.txt   |  8 +++
>   drivers/iommu/rockchip-iommu.c                     | 74 ++++++++++++++++++++--
>   2 files changed, 76 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/rockchip,iommu.txt b/Documentation/devicetree/bindings/iommu/rockchip,iommu.txt
> index 2098f7732264..33dd853359fa 100644
> --- a/Documentation/devicetree/bindings/iommu/rockchip,iommu.txt
> +++ b/Documentation/devicetree/bindings/iommu/rockchip,iommu.txt
> @@ -14,6 +14,13 @@ Required properties:
>                       "single-master" device, and needs no additional information
>                       to associate with its master device.  See:
>                       Documentation/devicetree/bindings/iommu/iommu.txt
> +Optional properties:
> +- clocks : A list of master clocks requires for the IOMMU to be accessible

s/requires/required/

> +           by the host CPU. The number of clocks depends on the master
> +           block and might as well be zero. See [1] for generic clock

Oops, some subtleties of English here :)

To say "the number of clocks ... might as well be zero" effectively 
implies "there's no point ever specifying any clocks". I guess what you 
really mean here is "...might well be...", i.e. it is both valid and 
reasonably likely to require zero clocks.

> +           bindings description.
> +
> +[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
>   
>   Optional properties:
>   - rockchip,disable-mmu-reset : Don't use the mmu reset operation.
> @@ -27,5 +34,6 @@ Example:
>   		reg = <0xff940300 0x100>;
>   		interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
>   		interrupt-names = "vopl_mmu";
> +		clocks = <&cru ACLK_VOP1>, <&cru DCLK_VOP1>, <&cru HCLK_VOP1>;
>   		#iommu-cells = <0>;
>   	};
> diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
> index c4131ca792e0..8a5e2a659b67 100644
> --- a/drivers/iommu/rockchip-iommu.c
> +++ b/drivers/iommu/rockchip-iommu.c
> @@ -4,6 +4,7 @@
>    * published by the Free Software Foundation.
>    */
>   
> +#include <linux/clk.h>
>   #include <linux/compiler.h>
>   #include <linux/delay.h>
>   #include <linux/device.h>
> @@ -91,6 +92,8 @@ struct rk_iommu {
>   	struct device *dev;
>   	void __iomem **bases;
>   	int num_mmu;
> +	struct clk_bulk_data *clocks;
> +	int num_clocks;
>   	bool reset_disabled;
>   	struct iommu_device iommu;
>   	struct list_head node; /* entry in rk_iommu_domain.iommus */
> @@ -450,6 +453,38 @@ static int rk_iommu_force_reset(struct rk_iommu *iommu)
>   	return 0;
>   }
>   
> +static int rk_iommu_of_get_clocks(struct rk_iommu *iommu)
> +{
> +	struct device_node *np = iommu->dev->of_node;
> +	int ret;
> +	int i;
> +
> +	ret = of_count_phandle_with_args(np, "clocks", "#clock-cells");
> +	if (ret == -ENOENT)
> +		return 0;
> +	else if (ret < 0)
> +		return ret;
> +
> +	iommu->num_clocks = ret;
> +	iommu->clocks = devm_kcalloc(iommu->dev, iommu->num_clocks,
> +				     sizeof(*iommu->clocks), GFP_KERNEL);
> +	if (!iommu->clocks)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < iommu->num_clocks; ++i) {
> +		iommu->clocks[i].clk = of_clk_get(np, i);
> +		if (IS_ERR(iommu->clocks[i].clk)) {
> +			ret = PTR_ERR(iommu->clocks[i].clk);
> +			goto err_clk_put;
> +		}
> +	}

Just to confirm my understanding from a quick scan through the code, the 
reason we can't use clk_bulk_get() here is that currently, clocks[i].id 
being NULL means we'd end up just getting the first clock multiple 
times, right?

I guess there could be other users who also want "just get whatever 
clocks I have" functionality, so it might be worth proposing that for 
the core API as a separate/follow-up patch, but it definitely doesn't 
need to be part of this series.

I really don't know enough about correct clk API usage, but modulo the 
binding comments it certainly looks nice and tidy now;

Acked-by: Robin Murphy <robin.murphy@arm.com>

Thanks,
Robin.

> +
> +	return 0;
> +err_clk_put:
> +	clk_bulk_put(i, iommu->clocks);
> +	return ret;
> +}
> +
>   static void log_iova(struct rk_iommu *iommu, int index, dma_addr_t iova)
>   {
>   	void __iomem *base = iommu->bases[index];
> @@ -506,6 +541,8 @@ static irqreturn_t rk_iommu_irq(int irq, void *dev_id)
>   	irqreturn_t ret = IRQ_NONE;
>   	int i;
>   
> +	WARN_ON(clk_bulk_enable(iommu->num_clocks, iommu->clocks));
> +
>   	for (i = 0; i < iommu->num_mmu; i++) {
>   		int_status = rk_iommu_read(iommu->bases[i], RK_MMU_INT_STATUS);
>   		if (int_status == 0)
> @@ -552,6 +589,8 @@ static irqreturn_t rk_iommu_irq(int irq, void *dev_id)
>   		rk_iommu_write(iommu->bases[i], RK_MMU_INT_CLEAR, int_status);
>   	}
>   
> +	clk_bulk_disable(iommu->num_clocks, iommu->clocks);
> +
>   	return ret;
>   }
>   
> @@ -594,7 +633,9 @@ static void rk_iommu_zap_iova(struct rk_iommu_domain *rk_domain,
>   	list_for_each(pos, &rk_domain->iommus) {
>   		struct rk_iommu *iommu;
>   		iommu = list_entry(pos, struct rk_iommu, node);
> +		WARN_ON(clk_bulk_enable(iommu->num_clocks, iommu->clocks));
>   		rk_iommu_zap_lines(iommu, iova, size);
> +		clk_bulk_disable(iommu->num_clocks, iommu->clocks);
>   	}
>   	spin_unlock_irqrestore(&rk_domain->iommus_lock, flags);
>   }
> @@ -823,10 +864,14 @@ static int rk_iommu_attach_device(struct iommu_domain *domain,
>   	if (!iommu)
>   		return 0;
>   
> -	ret = rk_iommu_enable_stall(iommu);
> +	ret = clk_bulk_enable(iommu->num_clocks, iommu->clocks);
>   	if (ret)
>   		return ret;
>   
> +	ret = rk_iommu_enable_stall(iommu);
> +	if (ret)
> +		goto out_disable_clocks;
> +
>   	ret = rk_iommu_force_reset(iommu);
>   	if (ret)
>   		goto out_disable_stall;
> @@ -852,6 +897,8 @@ static int rk_iommu_attach_device(struct iommu_domain *domain,
>   
>   out_disable_stall:
>   	rk_iommu_disable_stall(iommu);
> +out_disable_clocks:
> +	clk_bulk_disable(iommu->num_clocks, iommu->clocks);
>   	return ret;
>   }
>   
> @@ -873,6 +920,7 @@ static void rk_iommu_detach_device(struct iommu_domain *domain,
>   	spin_unlock_irqrestore(&rk_domain->iommus_lock, flags);
>   
>   	/* Ignore error while disabling, just keep going */
> +	WARN_ON(clk_bulk_enable(iommu->num_clocks, iommu->clocks));
>   	rk_iommu_enable_stall(iommu);
>   	rk_iommu_disable_paging(iommu);
>   	for (i = 0; i < iommu->num_mmu; i++) {
> @@ -880,6 +928,7 @@ static void rk_iommu_detach_device(struct iommu_domain *domain,
>   		rk_iommu_write(iommu->bases[i], RK_MMU_DTE_ADDR, 0);
>   	}
>   	rk_iommu_disable_stall(iommu);
> +	clk_bulk_disable(iommu->num_clocks, iommu->clocks);
>   
>   	iommu->domain = NULL;
>   
> @@ -1172,18 +1221,31 @@ static int rk_iommu_probe(struct platform_device *pdev)
>   	iommu->reset_disabled = device_property_read_bool(dev,
>   					"rockchip,disable-mmu-reset");
>   
> -	err = iommu_device_sysfs_add(&iommu->iommu, dev, NULL, dev_name(dev));
> +	err = rk_iommu_of_get_clocks(iommu);
>   	if (err)
>   		return err;
>   
> +	err = clk_bulk_prepare(iommu->num_clocks, iommu->clocks);
> +	if (err)
> +		goto err_put_clocks;
> +
> +	err = iommu_device_sysfs_add(&iommu->iommu, dev, NULL, dev_name(dev));
> +	if (err)
> +		goto err_unprepare_clocks;
> +
>   	iommu_device_set_ops(&iommu->iommu, &rk_iommu_ops);
>   	err = iommu_device_register(&iommu->iommu);
> -	if (err) {
> -		iommu_device_sysfs_remove(&iommu->iommu);
> -		return err;
> -	}
> +	if (err)
> +		goto err_remove_sysfs;
>   
>   	return 0;
> +err_remove_sysfs:
> +	iommu_device_sysfs_remove(&iommu->iommu);
> +err_unprepare_clocks:
> +	clk_bulk_unprepare(iommu->num_clocks, iommu->clocks);
> +err_put_clocks:
> +	clk_bulk_put(iommu->num_clocks, iommu->clocks);
> +	return err;
>   }
>   
>   static const struct of_device_id rk_iommu_dt_ids[] = {
> 
