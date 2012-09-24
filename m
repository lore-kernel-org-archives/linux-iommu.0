From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: How to specify IOMMU'able devices in DT (was: [RFC 0/5] ARM:
	dma-mapping: New dma_map_ops to control IOVA more precisely)
Date: Mon, 24 Sep 2012 12:44:52 +0300
Message-ID: <20120924124452.41070ed2ee9944d930cffffc@nvidia.com>
References: <1346223335-31455-1-git-send-email-hdoyu@nvidia.com>
	<20120918124918.GK2505@amd.com>
	<20120919095843.d1db155e0f085f4fcf64ea32@nvidia.com>
	<201209190759.46174.arnd@arndb.de> <20120919125020.GQ2505@amd.com>
	<401E54CE964CD94BAE1EB4A729C7087E379FDC1EEB@HQMAIL04.nvidia.com>
	<505A7DB4.4090902@wwwdotorg.org>
	<401E54CE964CD94BAE1EB4A729C7087E379FDC1F2D@HQMAIL04.nvidia.com>
	<505B35F7.2080201@wwwdotorg.org>
	<401E54CE964CD94BAE1EB4A729C7087E379FDC2372@HQMAIL04.nvidia.com>
	<20120924120415.8e6929a34c422185a98d3f82@nvidia.com>
	<1348478881.2467.27.camel@dabdike>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1348478881.2467.27.camel@dabdike>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: James Bottomley <James.Bottomley-d9PhHud1JfjCXq6kfMZ53/egYHeGw8Jk@public.gmane.org>
Cc: "linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org" <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "chunsang.jeong-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <chunsang.jeong-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "subashrp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <subashrp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org" <linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>, "minchan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <minchan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Krishna Reddy <vdumpa-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org" <linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi James,

On Mon, 24 Sep 2012 11:28:01 +0200
James Bottomley <James.Bottomley-d9PhHud1JfjCXq6kfMZ53/egYHeGw8Jk@public.gmane.org> wrote:

> On Mon, 2012-09-24 at 12:04 +0300, Hiroshi Doyu wrote:
> > diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> > index a1a7225..9eae3be 100644
> > --- a/drivers/base/platform.c
> > +++ b/drivers/base/platform.c
> > @@ -21,6 +21,8 @@
> >  #include <linux/slab.h>
> >  #include <linux/pm_runtime.h>
> > 
> > +#include <asm/dma-iommu.h>
> > +
> >  #include "base.h"
> > 
> >  #define to_platform_driver(drv)        (container_of((drv), struct
> > platform_driver, \
> > @@ -305,8 +307,19 @@ int platform_device_add(struct platform_device
> > *pdev)
> >                  dev_name(&pdev->dev), dev_name(pdev->dev.parent));
> > 
> >         ret = device_add(&pdev->dev);
> > -       if (ret == 0)
> > -               return ret;
> > +       if (ret)
> > +               goto failed;
> > +
> > +#ifdef CONFIG_PLATFORM_ENABLE_IOMMU
> > +       if (platform_bus_type.map && !pdev->dev.archdata.mapping) {
> > +               ret = arm_iommu_attach_device(&pdev->dev,
> > +                                             platform_bus_type.map);
> > +               if (ret)
> > +                       goto failed;
> 
> This is horrible ... you're adding an architecture specific callback
> into our generic code; that's really a no-no.  If the concept of
> CONFIG_PLATFORM_ENABE_IOMMU is useful to more than just arm, then this
> could become a generic callback.

As mentioned in the original, this is a heck to explain what is
needed. I am looking for some generic solution for how to specify
IOMMU info for each platform devices. I'm guessing that some other SoC
may have the similar requirements on the above. As you mentioned, this
solution should be a generic, not arch specific.
