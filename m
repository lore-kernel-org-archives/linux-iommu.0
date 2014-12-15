From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v6 6/8] dma-mapping: detect and configure IOMMU in
	of_dma_configure
Date: Mon, 15 Dec 2014 11:32:52 +0000
Message-ID: <20141215113252.GH20738@arm.com>
References: <1417453034-21379-1-git-send-email-will.deacon@arm.com>
	<1417453034-21379-7-git-send-email-will.deacon@arm.com>
	<6311849.8NniZ58Jf1@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <6311849.8NniZ58Jf1@avalon>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: "jroedel-l3A5Bk7waGM@public.gmane.org" <jroedel-l3A5Bk7waGM@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Sun, Dec 14, 2014 at 03:51:13PM +0000, Laurent Pinchart wrote:
> On Monday 01 December 2014 16:57:12 Will Deacon wrote:
> > This patch extends of_dma_configure so that it sets up the IOMMU for a
> > device, as well as the coherent/non-coherent DMA mapping ops.
> > 
> > Acked-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
> > Acked-by: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> > Tested-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> > Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>

[...]

> > +static void of_dma_deconfigure(struct device *dev)
> > +{
> > +	arch_teardown_dma_ops(dev);
> >  }
> > 
> >  /**
> > @@ -223,16 +234,12 @@ static struct platform_device
> > *of_platform_device_create_pdata( if (!dev)
> >  		goto err_clear_flag;
> > 
> > -	of_dma_configure(&dev->dev);
> >  	dev->dev.bus = &platform_bus_type;
> >  	dev->dev.platform_data = platform_data;
> > -
> > -	/* We do not fill the DMA ops for platform devices by default.
> > -	 * This is currently the responsibility of the platform code
> > -	 * to do such, possibly using a device notifier
> > -	 */
> > +	of_dma_configure(&dev->dev);
> > 
> >  	if (of_device_add(dev) != 0) {
> > +		of_dma_deconfigure(&dev->dev);
> 
> Don't you also need to call of_dma_deconfigure() when the device is destroyed 
> ? Otherwise the default domain created by arch_setup_dma_ops() will be leaked.

Something like below?

Will

--->8

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index b89caf8c7586..ec29c25b4fce 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -525,6 +525,7 @@ static int of_platform_device_destroy(struct device *dev, void *data)
                amba_device_unregister(to_amba_device(dev));
 #endif
 
+       of_dma_deconfigure(dev);
        of_node_clear_flag(dev->of_node, OF_POPULATED);
        of_node_clear_flag(dev->of_node, OF_POPULATED_BUS);
        return 0;
