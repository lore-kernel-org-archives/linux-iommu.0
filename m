From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v2 01/05] iommu/ipmmu-vmsa: Use
 iommu_device_register()/unregister()
Date: Wed, 26 Jul 2017 12:44:11 +0200
Message-ID: <20170726104410.GI15833@8bytes.org>
References: <150029669967.22030.8059216113725566341.sendpatchset@little-apple>
 <150029671059.22030.9200719361237858789.sendpatchset@little-apple>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <150029671059.22030.9200719361237858789.sendpatchset@little-apple>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: laurent.pinchart+renesas@ideasonboard.com, geert+renesas@glider.be, robin.murphy@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, iommu@lists.linux-foundation.org, horms+renesas@verge.net.au, sricharan@codeaurora.org, m.szyprowski@samsung.com
List-Id: iommu@lists.linux-foundation.org

On Mon, Jul 17, 2017 at 10:05:10PM +0900, Magnus Damm wrote:
> --- 0001/drivers/iommu/ipmmu-vmsa.c
> +++ work/drivers/iommu/ipmmu-vmsa.c	2017-07-17 21:01:47.140607110 +0900
> @@ -35,6 +35,7 @@
>  struct ipmmu_vmsa_device {
>  	struct device *dev;
>  	void __iomem *base;
> +	struct iommu_device iommu;
>  	struct list_head list;
>  
>  	unsigned int num_utlbs;
> @@ -1054,6 +1055,13 @@ static int ipmmu_probe(struct platform_d
>  
>  	ipmmu_device_reset(mmu);
>  
> +	iommu_device_set_ops(&mmu->iommu, &ipmmu_ops);
> +	iommu_device_set_fwnode(&mmu->iommu, &pdev->dev.of_node->fwnode);
> +
> +	ret = iommu_device_register(&mmu->iommu);
> +	if (ret)
> +		return ret;
> +

Looks good so far, why don't you also add the iommu to sysfs with
iommu_device_sysfs_add()?


	Joerg
