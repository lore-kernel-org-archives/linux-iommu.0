From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [RFC PATCH v3 5/7] dma-mapping: detect and configure IOMMU in
	of_dma_configure
Date: Mon, 27 Oct 2014 13:30:33 +0200
Message-ID: <14012645.olm9XxYoII@avalon>
References: <1410539695-29128-1-git-send-email-will.deacon@arm.com>
	<4572757.M4IDlCz5Vc@avalon> <20141027105158.GE8768@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20141027105158.GE8768-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: "jroedel-l3A5Bk7waGM@public.gmane.org" <jroedel-l3A5Bk7waGM@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Will,

On Monday 27 October 2014 10:51:59 Will Deacon wrote:
> On Tue, Oct 14, 2014 at 01:53:59PM +0100, Laurent Pinchart wrote:
> > On Monday 22 September 2014 18:50:27 Will Deacon wrote:
> > > On Mon, Sep 22, 2014 at 10:29:10AM +0100, Thierry Reding wrote:
> > > > Agreed. I wonder how useful it is to know the set of IOMMU instances
> > > > that each device can master through. Wouldn't it be more useful to
> > > > keep a list of master interfaces for each device? The set of IOMMU
> > > > instances can trivially be derived from that.
> > > 
> > > I'm struggling to think how that would look. What do you mean by `master
> > > interfaces' in terms of the code we have in Linux? At the end of the
> > > day, the list of IOMMU instances (i.e. iommu_dma_mapping) exists because
> > > you and Laurent have use-cases involving devices mastering through
> > > multiple IOMMUs. If it doesn't work for you, it might be best for you to
> > > send me the patch ;)
> > 
> > Just for the record, I've brought up the topic of masters being served by
> > multiple IOMMUs, but don't have a use case for it (yet at least). I do
> > have masters served through multiple streams with separate stream IDs, but
> > all by the same IOMMU.
> 
> Ok. I spoke to Arnd, David and Joerg at LPC and the consensus was that the
> DMA-mapping API should *not* be exposed to the details of masters that
> master through multiple IOMMUs. Instead, that should be abstracted by the
> device API by exposing that device as a single struct device.

I'm not sure to follow you here. Aren't we already exposing masters that 
master through multiple IOMMUs as single instances of struct device ?

> So, that's certainly an area that needs more work and I'll drop the limited
> support I'd cooked up from this patch set in the next version.

How about masters connected to multiple stream IDs of the same IOMMU ?

-- 
Regards,

Laurent Pinchart
