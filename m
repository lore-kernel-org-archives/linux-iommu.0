From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: Re: [PATCH] x86: enable swiotlb for > 4GiG ram on 32-bit kernels
Date: Thu, 18 Oct 2018 14:51:16 +0200
Message-ID: <20181018125116.GA24676@lst.de>
References: <20181014075208.2715-1-hch@lst.de>
	<CAP8WD_Zj5aMcTCVtV-hot3zLNfNuMzHyeogm0Lqb=+XZ1LdkKw@mail.gmail.com>
	<20181017163351.GA23719@lst.de>
	<CAP8WD_boL-DxEXxa-ci382Ff8yTdMS9T+sy2Y0-LEX-WPc8L_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAP8WD_boL-DxEXxa-ci382Ff8yTdMS9T+sy2Y0-LEX-WPc8L_g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: whiteheadm-HInyCGIudOg@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Oct 17, 2018 at 01:41:49PM -0400, tedheadster wrote:
> > What is the comparism?  Is this on a non-aic7xxx kernel with and without
> > the fix?
> 
> Christoph,
>   I will try and do some strict before-and-after benchmarking of your
> patch. It will take a few days because I am on travel. This is on an
> aic7xxx (it does have that controller) kernel with and without the
> fix.

But you said without the fix it doesn't work at all?  Or is this
the same box, just with the aic7xxx controller disabled?

In general the patch should only have two effects:

 - set a small amount of memory aside for bounce buffering
 - switch the default dma_ops from dma_direct_ops to swiotlb_ops

I can't really see how either could have such a huge effect, even with
swiotlb having a couple more wired up ops for which we'd enable spectre
mitigations.

So a strict before and after would be very interesting, if it is really
just this one change that causes such a huge drop we have hidden dragons
somewhere..
