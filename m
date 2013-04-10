From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] documentation: iommu: add description of ARM System MMU
	binding
Date: Wed, 10 Apr 2013 18:37:32 +0100
Message-ID: <20130410173732.GQ26992@mudshark.cambridge.arm.com>
References: <1365094259-24847-1-git-send-email-will.deacon@arm.com>
	<515F37C1.4000109@codeaurora.org>
	<20130408092535.GA17476@mudshark.cambridge.arm.com>
	<5162F87A.7070409@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5162F87A.7070409-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Olav Haugan <ohaugan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Apr 08, 2013 at 06:03:54PM +0100, Olav Haugan wrote:
> Hi Will,

Hello,

> > Generally, the StreamIDs are fixed in hardware (as a function of various AXI
> > bits -- see the SMMU integration guide) and cannot be set by software.
> > Furthermore, when the StreamIDs have an implicit effect on IOMMU domain
> > configuration, since stream-matching may not be always be able to identify a
> > master uniquely.
> 
> Let me clarify what I mean by "our SMMU driver programs the SMMU SIDs".
> What I meant to say is that our SMMU driver programs the SID into the
> Stream Match Register (SMR) to route the transactions to the correct
> context bank based on the SID.

Ok, but then how does that interact with the IOMMU API in Linux? e.g. if a
client asks for an iova <-> pa mapping on a device, then you need to lookup
the StreamIDs for that device, no?

> > This really looks specific to your implementation/integration and I can't
> > see that we'd want this in the binding to be honest. It would be good to
> > have PMU support in the future, but I've not thought about that part yet.
> 
> Yes, some of this is specific to our implementation. However, the
> properties related to regulators and PMU are not specific I believe. How
> do you do handle regulators?

As I said, I'm just using a software model more the moment, so no clocks or
regulators. We can add these later, since Linux has good support for things
like that already.

> >> - List of sub nodes, one for each of the translation context banks
> >> supported.
> >>   Each sub node has the following required properties:
> >>
> >>   - reg : offset and length of the register set for the context bank.
> > 
> > Why do you need this? The structure of the context banks is well defined by
> > the SMMU architecture.
> 
> Since we specify the context banks as children of the IOMMU we specify
> the address of each node. I believe you should be specifying the "reg"
> property for the nodes when you do this.

It's completely redundant information though!

> >>   - interrupts : should contain the context bank interrupt.
> >>   - qcom,iommu-ctx-sids : List of stream identifiers associated with
> >> this translation context.
> > 
> > StreamIDs aren't statically associated with a translation context. Why do
> > you put them here? Also, how do this interact with stream matching?
> 
> We put the StreamIDs in the context bank to tell our driver that these
> StreamIDs should be programmed into the Stream Match Register (SMR) to
> route the transactions bearing these StreamIDs to this context bank. We
> don't really change the SID2CB mapping during run-time. It is set during
> compile time.

Again, I'm struggling to see how this interfaces to the more general-purpose
IOMMU API.

> >> Optional sub-node properties:
> >>    - qcom,secure-context : boolean indicating that a context is secure
> >>  and programmed by the secure environment.
> > 
> > Why does Linux care about this?
> 
> Linux cares about this because if we are doing content protection using
> one of the context banks then the context bank is programmed by the
> secure environment and not accessible/programmable by the HLOS.

Why can't the secure world just hide those context banks by using
SMMU_SCR1.NSNUMCBO?

> > I'd really rather start off small, and describe precisely what we need to
> > get architecturally-compliant SMMUs off the ground. Then, as the code grows
> > to use more features (PM, PMU, ...) then we can extend the binding.
> > Otherwise, we paint ourselves into a corner with the binding before we've
> > developed any driver code.
> 
> Sure, I did not mean to add implementation specific stuff to upstream
> bindings. Does it makes sense to you thought the way we modeled context
> banks as child nodes?

Not really, no. It seems to configure everything up-front, which makes
dynamic use of the IOMMU difficult afaict. It may suit your use-case (as you
say, you even set up the mappings at compile-time) but it's not especially
general.

Will
