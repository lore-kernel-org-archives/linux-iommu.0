From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RFC PATCH v3 0/7] Introduce automatic DMA configuration for
	IOMMU masters
Date: Wed, 17 Sep 2014 02:19:11 +0100
Message-ID: <20140917011910.GA3232@arm.com>
References: <1410539695-29128-1-git-send-email-will.deacon@arm.com>
	<541821AB.8040403@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <541821AB.8040403-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <Robin.Murphy-5wv7dgnIgG8@public.gmane.org>
Cc: "jroedel-l3A5Bk7waGM@public.gmane.org" <jroedel-l3A5Bk7waGM@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org" <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Sep 16, 2014 at 12:40:27PM +0100, Robin Murphy wrote:
> On 12/09/14 17:34, Will Deacon wrote:
> > Here is version three of the RFC I've previously posted here:
> >
> >    RFCv1: http://lists.infradead.org/pipermail/linux-arm-kernel/2014-August/283023.html
> >    RFCv2: http://lists.infradead.org/pipermail/linux-arm-kernel/2014-September/283752.html
> >
> > Changes since RFCv2 include:
> >
> >    - Put the iommu_ops in iommu_data so of_iommu_configure can avoid using
> >      the bus_type
> >    - Initialise the offset and DMA masks on the dev in of_dma_configure
> >      instead of in the arch callback (as this would cause a regression on
> >      some architectures)
> >    - Added deconfigure/teardown code based on ref counting the iommu_dma_mapping
> >    - A bunch of small fixes (_OF_DECLARE,  some code shuffling, fix multiple
> >      IOMMU parsing)
> >
> > All feedback welcome. Hopefully this is now at a point where people can
> > start looking to port dma-mapping and/or IOMMU drivers to it.
> >
> 
> What about AMBA devices? Playing with this on Juno and wondering why my 
> PL330 doesn't get any of_xlate callbacks, I see that 
> of_amba_device_create doesn't call of_dma_configure or anything from 
> that path. It's easy to work around by removing the arm,primecell 
> compatible, but that feels pretty dirty.

Yeah, that's just a bug in mainline. I'll look at fixing it if you don't
beat me to it.

Will
