From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: Re: [PATCH] of/platform: Initialise default DMA masks
Date: Fri, 27 Jul 2018 19:03:55 +0200
Message-ID: <20180727170355.GA32635@lst.de>
References: <9ffa7f2676c25adf39e85ec8114b26500b5680f6.1532699305.git.robin.murphy@arm.com>
	<20180727142054.GA29316@lst.de>
	<a5c6dd56-100a-e1cd-b4c4-2a30d8791ade@arm.com>
	<CAL_JsqJCtzhcO8s59d=SPEtYpDWhCkKo99cQiuK987Y1Oqgb9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAL_JsqJCtzhcO8s59d=SPEtYpDWhCkKo99cQiuK987Y1Oqgb9A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, Jul 27, 2018 at 10:50:34AM -0600, Rob Herring wrote:
> On Fri, Jul 27, 2018 at 8:18 AM Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org> wrote:
> >
> > On 27/07/18 15:20, Christoph Hellwig wrote:
> > > On Fri, Jul 27, 2018 at 03:14:15PM +0100, Robin Murphy wrote:
> > >> This shouldn't strictly depend on the changes currently queued in the
> > >> dma-mapping tree, so should be OK to go through the DT tree in parallel.
> > >> Ideally we'd fix all DMA-capable drivers to set their masks correctly,
> > >> but in the short term everyone's going to get cross about -rc1 not
> > >> booting...
> > >
> > > I'd prefer to pick this up through the dma-mapping tree, and in fact
> > > move it before the bus_dma_mask changes just to keep a bisectable
> > > tree.
> >
> > Sure, if Rob and Frank are OK with that I don't mind either way.
> 
> NP.
> 
> Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

Ok, applied so that it gets into the next linux-next.
