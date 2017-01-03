From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RFC PATCH] iommu/arm-smmu: Add global SMR masking property
Date: Tue, 3 Jan 2017 13:47:34 +0000
Message-ID: <20170103134733.GG6986@arm.com>
References: <ad6b6a4937b1fe183e6d48ccbaf4cb46db92fed4.1481893907.git.robin.murphy@arm.com>
	<20161221032921.hdcnyiq6m224ejlv@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161221032921.hdcnyiq6m224ejlv@rob-hp-laptop>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stuart.yoder-3arQi8VN3Tc@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Dec 20, 2016 at 09:29:21PM -0600, Rob Herring wrote:
> On Fri, Dec 16, 2016 at 01:19:29PM +0000, Robin Murphy wrote:
> > The current SMR masking support using a 2-cell iommu-specifier is
> > primarily intended to handle individual masters with large and/or
> > complex Stream ID assignments; it quickly gets a bit clunky in other SMR
> > use-cases where we just want to consistently mask out the same part of
> > every Stream ID (e.g. for MMU-500 configurations where the appended TBU
> > number gets in the way unnecessarily). Let's add a new property to allow
> > a single global mask value to better fit the latter situation.
> > 
> > CC: Stuart Yoder <stuart.yoder-3arQi8VN3Tc@public.gmane.org>
> > Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> > ---
> > 
> > Compile-tested only...
> > 
> >  Documentation/devicetree/bindings/iommu/arm,smmu.txt | 8 ++++++++
> >  drivers/iommu/arm-smmu.c                             | 4 +++-
> >  2 files changed, 11 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> > index e862d1485205..98f5cbe5fdb4 100644
> > --- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> > +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> > @@ -60,6 +60,14 @@ conditions.
> >                    aliases of secure registers have to be used during
> >                    SMMU configuration.
> >  
> > +- stream-match-mask : Specifies a fixed SMR mask value to combine with
> 
> Needs a vendor prefix.

Why does this need a vendor prefix? I'm not fussed either way, but since
the stream-match-mask is an optional architectural concept and not specific
to an implementation, it seems strange to me that it would need a prefix
whereas something like #global-interrupts does not.

> > +                  the Stream ID value from every iommu-specifier. This
> > +                  may be used instead of an "#iommu-cells" value of 2
> > +                  when there is no need for per-master SMR masks, but
> > +                  it is still desired to mask some portion of every
> > +                  Stream ID (e.g. for certain MMU-500 configurations
> > +                  given globally unique external IDs).

Robin -- it might be worth a sentence here saying that the property is
ignored if stream matching isn't supported by the hardware.

Will
