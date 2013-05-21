From: Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2] documentation: iommu: add description of ARM System
	MMU binding
Date: Tue, 21 May 2013 12:25:01 +0200
Message-ID: <20130521102501.GB14432@alberich>
References: <1365789727-5371-1-git-send-email-will.deacon@arm.com>
	<20130513095020.GB10369@alberich>
	<20130513095846.GC29814@mudshark.cambridge.arm.com>
	<20130513104147.GF10369@alberich> <20130517201639.GL10369@alberich>
	<20130520101841.GK31359@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130520101841.GK31359-MRww78TxoiP5vMa5CHWGZ34zcgK1vI+I0E9HWUfgJXw@public.gmane.org>
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
Cc: Olav Haugan <ohaugan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, May 20, 2013 at 06:18:41AM -0400, Will Deacon wrote:
> Hi Andreas,
> 
> On Fri, May 17, 2013 at 09:16:39PM +0100, Andreas Herrmann wrote:
> > On Mon, May 13, 2013 at 12:41:47PM +0200, Andreas Herrmann wrote:
> > > On Mon, May 13, 2013 at 05:58:46AM -0400, Will Deacon wrote:
> > > > Again, you also need to tie in topology information if you go down this
> > > > route.
> > 
> > I still don't like the approach of having two independend lists that
> > must be in sync to associate a master with its stream-ids.
> > 
> > Why? Say you have 8 masters for an SMMU with 1 or 2 stream-ids each:
> > 
> >      	 smmu {
> > 		...
> >                 mmu-masters = <&dma0>, <&dma0>, <&dma1>, <&dma1>,
> > 			      <&dma2>, <&dma2>, <&dma4>, <&dma4>,
> > 			      <&dma5>, <&dma6>, <&dma7>, <&dma8>;
> >                 stream-ids =	<0>, <1>, <2>, <3>,
> > 				<4>, <5>, <6>, <7>,
> > 		                <8>, <9>, <0xa>, <0xb>;
> > 	}
> > 
> > Couldn't we use of_phandle_args for this purpose? So your example
> > 
> > +        smmu {
> > 		 ...
> > +                mmu-masters = <&dma0>,
> > +                              <&dma0>,
> > +                              <&dma1>;
> > +                stream-ids  = <0xd01d>,
> > +                              <0xd01e>,
> > +                              <0xd11c>;
> > +        };
> > 
> > would look like
> > 
> > 	dma0 {
> > 		...
> > 		#stream-id-cells = <2>
> > 		...
> > 	}
> > 
> > 	dma1 {
> > 		...
> > 		#stream-id-cells = <1>
> > 		...
> > 	}
> > 
> >         smmu {
> > 		...
> > 		mmu-masters = <&dma0 0xd01d 0xd01e
> > 			       &dma1 0xd11c>,
> >        };
> > 
> > and my example would be converted to
> > 
> > 	smmu {
> > 		...
> >                 mmu-masters = <&dma0 0 1 &dma1 2 3 &dma2 4 5
> > 			       &dma4 6 7 &dma5 8 &dma6 9
> > 			       &dma7 0xa &dma8 0xb>
> > 		...
> > 	}
> 
> That also looks fine to me, although I'd like to write the parsing code in
> my driver before I commit to anything!
> 
> > Of course usage of of_phandle_args would restrict the number of
> > stream-ids per master to 8 (which is currently used as
> > MAX_PHANDLE_ARGS). But I don't think that this is a restriction in
> > practice or do you expect to have more than 8 stream-ids per master
> > (ie. per struct device in Linux)?
> 
> Actually, I think that could be a problem. It doesn't sound unlikely that
> multi-channel DMA controllers could have:
> 
> 	- Separate instruction fetch streamid per channel
> 	- Separate read/write streamids per channel
> 
> so 8 does sound a bit small to me. How difficult would it be to bump that
> number in the future if we needed to?

Seems it was introduced with commit 15c9a0acc3f7873db4b7d35d016729b2dc229b49
(of: create of_phandle_args to simplify return of phandle parsing data)
by Grant Likely.

The macro is primarily used in struct of_phandle_args. I don't believe
that increasing the number of args (e.g. doubling it if necessary)
would cause objections.

struct of_phandle_args is used as argument for various (parsing
functions). In several functions objects of that type are on the
stack.

And there is a private data structure in gpiolib-of.c which also
contains an object of that type:

  struct gg_data {
        enum of_gpio_flags *flags;
        struct of_phandle_args gpiospec;
        int out_gpio;
  };

I don't expect that stack overflows or significant blowup of kernel
size will be casued by a moderate bump of MAX_PHANDLE_ARGS. I think
doubling it or even increasing it to 32 will not cause issues.

(Of course its impossible to increase it to the theoretical maximum of
32k (15-bit) stream-ids. But 32k stream-ids for just one Linux device?
I'd say practically irrelevant.)


Andreas
