From: "joro@8bytes.org" <joro@8bytes.org>
Subject: Re: [PATCH] iommu/ipmmu-vmsa: fix device reference leaks
Date: Mon, 11 Feb 2019 11:24:15 +0100
Message-ID: <20190211102414.GZ32526@8bytes.org>
References: <HK0PR02MB3634F6AE1FAE6B86EF82B291B26C0@HK0PR02MB3634.apcprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <HK0PR02MB3634F6AE1FAE6B86EF82B291B26C0@HK0PR02MB3634.apcprd02.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: wen yang <yellowriver2010@hotmail.com>
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Magnus Damm <damm+renesas@opensource.se>
List-Id: iommu@lists.linux-foundation.org

Adding a few more people to Cc.

On Sun, Feb 03, 2019 at 10:27:09AM +0000, wen yang wrote:
> Make sure to drop the reference to the device taken by
> of_find_device_by_node() on driver unbind.
> 
> Signed-off-by: Wen Yang <yellowriver2010@hotmail.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: iommu@lists.linux-foundation.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/iommu/ipmmu-vmsa.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
> index 7a4529c..cebf56d 100644
> --- a/drivers/iommu/ipmmu-vmsa.c
> +++ b/drivers/iommu/ipmmu-vmsa.c
> @@ -756,6 +756,9 @@ static int ipmmu_init_platform_device(struct device *dev,
>  
>  	fwspec->iommu_priv = platform_get_drvdata(ipmmu_pdev);
>  
> +	if (!fwspec->iommu_priv)
> +		put_device(&ipmmu_pdev->dev);
> +
>  	return 0;
>  }
>  
> -- 
> 2.7.4
