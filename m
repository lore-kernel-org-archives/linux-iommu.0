From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RFC PATCH v3 5/7] dma-mapping: detect and configure IOMMU in
	of_dma_configure
Date: Mon, 22 Sep 2014 18:46:00 +0100
Message-ID: <20140922174600.GJ7936@arm.com>
References: <1410539695-29128-1-git-send-email-will.deacon@arm.com>
	<1410539695-29128-6-git-send-email-will.deacon@arm.com>
	<4252161.sBJZLIS2WH@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4252161.sBJZLIS2WH@avalon>
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

On Thu, Sep 18, 2014 at 12:17:33PM +0100, Laurent Pinchart wrote:
> Hi Will,

Hello again,

> On Friday 12 September 2014 17:34:53 Will Deacon wrote:
> > @@ -195,7 +197,19 @@ static void of_dma_configure(struct platform_device
> > *pdev) dev_dbg(dev, "device is%sdma coherent\n",
> >  		coherent ? " " : " not ");
> > 
> > -	arch_setup_dma_ops(dev, coherent);
> > +	iommu = of_iommu_configure(dev);
> > +	dev_dbg(dev, "device is%sbehind an iommu\n",
> > +		iommu ? " " : " not ");
> > +
> > +	arch_setup_dma_ops(dev, dma_addr, size, iommu, coherent);
> > +
> > +	if (iommu)
> > +		kref_put(&iommu->kref, of_iommu_deconfigure);
> 
> What's the expected life cycle of the iommu_dma_mapping structure ? It gets 
> created by of_iommu_configure() and the initial reference gets dropped here. I 
> suppose you expect arch code to need to keep a reference to the structure, but 
> your implementation in patch 7/7 doesn't. As far as I can see, you don't even 
> use the contents of the structure in the ARM arch_setup_dma_ops() 
> implementation. Do you expect that to change later, or other architectures to 
> need it ?

Indeed, I've not done anything to the ARM dma-mapping ops other than plug-in
the existing code, which doesn't use these new features. I think Marek was
going to look at that.

> By the way, now that I think about it, I find struct iommu_dma_mapping and 
> struct dma_iommu_mapping very confusing.

Yup; I'd like to see some generic code that uses the per-IOMMU-instance
domain and allocator which is passed to arch_setup_dma_ops. Then we could
simply move arch/arm/ (and arm64) over to that, which would get rid of
dma_iommu_mapping entirely.

Will
