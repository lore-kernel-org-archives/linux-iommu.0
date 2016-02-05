From: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] iommu/arm-smmu-v2: Workaround for ThunderX errata#27704
Date: Fri, 5 Feb 2016 20:15:32 +0000
Message-ID: <20160205201532.GA10389@leverpostej>
References: <1454698027-20911-1-git-send-email-tchalamarla@caviumnetworks.com>
	<20160205200142.GA8647@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160205200142.GA8647@leverpostej>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: tchalamarla-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org
Cc: will.deacon-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Geethasowjanya.Akula-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Feb 05, 2016 at 08:02:09PM +0000, Mark Rutland wrote:
> On Fri, Feb 05, 2016 at 10:47:07AM -0800, tchalamarla-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org wrote:
> > From: Tirumalesh Chalamarla <tchalamarla-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
> > 
> > An issue exists whereby the Linux kernel requires that ASIDs are a
> > unique namespace per SMMU.  
> 
> The SMMU architecture requires this, and Linux relies on hardware
> following the architecture.
> 
> Please describe the problem correctly. i.e. that the hardware
> erroneously shares TLBs between SMMU instances.
> 
> > That ASID-local choice conflicts with the
> > CN88xx SMMU, where only shared ASID namespaces are supported;
> > specifically within a given node SMMU0 and SMMU1 share, as does SMMU2
> > and SMMU3. CN88xx SMMU also requires global VMIDs.
> > 
> > This patch tries to address these issuee by supplying asid and vmid
> > transformations from devicetree.
> > 
> > Signed-off-by: Akula Geethasowjanya <Geethasowjanya.Akula-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
> > Signed-off-by: Tirumalesh Chalamarla <tchalamarla-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
> > ---
> >  .../devicetree/bindings/iommu/arm,smmu.txt         | 16 ++++++
> >  drivers/iommu/arm-smmu.c                           | 59 ++++++++++++++++++----
> >  2 files changed, 65 insertions(+), 10 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> > index 7180745..eef06d0 100644
> > --- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> > +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> > @@ -55,6 +55,22 @@ conditions.
> >                    aliases of secure registers have to be used during
> >                    SMMU configuration.
> >  
> > +- thunderx,smmu-asid-transform	: Enable proper handling for buggy
> > +		  implementations that require special transformations
> > +		  for smmu asid. if this property exists asid-transform
> > +		  property must be present.
> > +
> > +- thunderx,smmu-vmid-transform	: Enable proper handling for buggy
> > +		  implementations that require special transformations
> > +		  for smmu vmid. if this property exists vmid-transform
> > +		  property must be present.
> > +
> > +- asid-transform 	: Transform mask that needs to be applied to asid.
> > +			This property has to be specified as '/bits/ 8' value.
> > +
> > +- vmid-transform 	: Transform mask that needs to be applied to vmid.
> > +			This property has to be specified as '/bits/ 8' value.
> 
> Don't bother with /bits/ 8. It saves no space in the DTB and only adds
> to confusion. Use a full cell, and of_property_read_u32, and validate
> that the value is in range.
> 
> Having two properties for each seems redundant. The presence of a mask
> should be sufficient to make it clear that the use of the mask is
> required.
> 
> These properties aren't sufficiently described. How is the mask
> "applied", and what is it applied to? What constraints does it impose
> on the OS's selection of ASIDs/VMIDs?
> 
> From the looks of the patch, it's ANDed into the value Linux has
> selected, so it sounds like an OS must avoid using any bits set in any
> mask on any SMMU instance. That sounds very difficult to ensure in
> general, and very fragile.

A much better approach would be to have something like:

valid-asid-range : two u32 cells describing the minimum and maximum
                   ASIDs that may be used on this SMMU instance. The OS
		   must allocate ASIDs in the interval [minimum,
		   maximum].

That way the OS can prevent itself from allocating conflicting ASIDs,
which is not possible with a single base value as you have with your
asid-transform property.

Mark.
