From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH/RFC] driver core: Postpone DMA tear-down until after
 devres release
Date: Fri, 8 Feb 2019 17:40:19 +0100
Message-ID: <20190208164019.GY32526@8bytes.org>
References: <20190207193653.18221-1-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190207193653.18221-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, "Rafael J . Wysocki" <rafael@kernel.org>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hi Geert,

On Thu, Feb 07, 2019 at 08:36:53PM +0100, Geert Uytterhoeven wrote:
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 8ac10af17c0043a3..d62487d024559620 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -968,9 +968,9 @@ static void __device_release_driver(struct device *dev, struct device *parent)
>  			drv->remove(dev);
>  
>  		device_links_driver_cleanup(dev);
> -		arch_teardown_dma_ops(dev);
>  
>  		devres_release_all(dev);
> +		arch_teardown_dma_ops(dev);
>  		dev->driver = NULL;
>  		dev_set_drvdata(dev, NULL);
>  		if (dev->pm_domain && dev->pm_domain->dismiss)

Thanks for the fix! Should it also be tagged for stable and get a Fixes
tag? I know it only triggers with a fix in v5.0-rc, but still...

Regards,

	Joerg
