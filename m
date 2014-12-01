From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v5 0/8] Introduce automatic DMA configuration for IOMMU
	masters
Date: Mon, 1 Dec 2014 15:05:04 +0000
Message-ID: <20141201150503.GG18466@arm.com>
References: <1417181386-18142-1-git-send-email-will.deacon@arm.com>
	<2496335.D95hVHbola@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <2496335.D95hVHbola@wuerfel>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org
Cc: "jroedel-l3A5Bk7waGM@public.gmane.org" <jroedel-l3A5Bk7waGM@public.gmane.org>, Robin Murphy <Robin.Murphy-5wv7dgnIgG8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org" <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Dec 01, 2014 at 01:52:57PM +0000, Arnd Bergmann wrote:
> On Friday 28 November 2014 13:29:38 Will Deacon wrote:
> > Here is v5 of the patches I've previously sent here:
> > 
> >   RFCv1: http://lists.infradead.org/pipermail/linux-arm-kernel/2014-August/283023.html
> >   RFCv2: http://lists.infradead.org/pipermail/linux-arm-kernel/2014-September/283752.html
> >   RFCv3: http://lists.infradead.org/pipermail/linux-arm-kernel/2014-September/287031.html
> >   RFCv4: http://lists.infradead.org/pipermail/linux-arm-kernel/2014-November/302711.html
> > 
> > Changes since RFCv4 include:
> > 
> >   - Dropped the RFC tag, since has been used by a couple of people now
> > 
> >   - Dropped the DMA segment configuration from of_dma_configure, as there
> >     appear to be assumptions about 64k segments elsewhere in the kernel
> > 
> >   - Added acks/tested-bys (thanks to everybody who reviewed the series)
> > 
> >   - A few small fixes for issues found by Marek
> > 
> > Arnd: Is this too late for 3.19? We could merge the first 6 patches
> > with no issues, since there aren't any callers of of_iommu_init
> > without patch 7 anyway.
> > 
> > Up to you.
> 
> I think this looks great overall. My only feedback is the exact same
> comment that Joerg already made:
> 
> On Friday 28 November 2014 14:03:36 jroedel-l3A5Bk7waGM@public.gmane.org wrote:
> > Hmm, I don't like the idea of storing private data in iommu_ops. But
> > given that this is already an improvement we can build on later, here is
> > my
> > 
> >         Acked-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
> > 
> > To further improve this we should probably introduce a seperate
> > iommu-descriptor data-structure later which then describes a single
> > hardware iommu device.
> 
> so I second that and add my
> 
> Acked-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>

Yup, I'll take a look at that as part of a separate series, since I really
want to have different pgsize_bitmaps anyway.

> Now, who should merge this series? I think someone should put all eight
> patches into linux-next now, and if something goes wrong with the last
> two, then we skip them for 3.19.

I think it makes most sense to go via arm-soc, but we'd need rmk's ack
on the last two patches.

Russell, are you ok with that plan?

Will
