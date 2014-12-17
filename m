From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v6 6/8] dma-mapping: detect and configure IOMMU in
	of_dma_configure
Date: Wed, 17 Dec 2014 11:14:38 +0000
Message-ID: <20141217111438.GC3461@arm.com>
References: <1417453034-21379-1-git-send-email-will.deacon@arm.com>
	<6311849.8NniZ58Jf1@avalon> <20141215113252.GH20738@arm.com>
	<35498434.EVQZ75aAeX@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <35498434.EVQZ75aAeX@avalon>
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

On Wed, Dec 17, 2014 at 12:19:45AM +0000, Laurent Pinchart wrote:
> On Monday 15 December 2014 11:32:52 Will Deacon wrote:
> > On Sun, Dec 14, 2014 at 03:51:13PM +0000, Laurent Pinchart wrote:
> > > On Monday 01 December 2014 16:57:12 Will Deacon wrote:
> > > > +	of_dma_configure(&dev->dev);
> > > >  	if (of_device_add(dev) != 0) {
> > > > +		of_dma_deconfigure(&dev->dev);
> > > 
> > > Don't you also need to call of_dma_deconfigure() when the device is
> > > destroyed ? Otherwise the default domain created by arch_setup_dma_ops()
> > > will be leaked.
> >
> > Something like below?
> 
> Yes, something like that. This will however cause a dev_warn("Not attached") 
> message to be printed for devices that have no IOMMU, that should be fixed in 
> the arch code.

Good catch, additional patch below to fix that up.

Will

--->8

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 09645f00bd17..c757f3d2d01e 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -2023,7 +2023,10 @@ static bool arm_setup_iommu_dma_ops(struct device *dev, u64 dma_base, u64 size,
 
 static void arm_teardown_iommu_dma_ops(struct device *dev)
 {
-       struct dma_iommu_mapping *mapping = dev->archdata.mapping;
+       struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
+
+       if (!mapping)
+               return;
 
        arm_iommu_detach_device(dev);
        arm_iommu_release_mapping(mapping);
