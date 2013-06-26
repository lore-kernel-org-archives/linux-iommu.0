From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 7/9] documentation: iommu: add description of ARM System
	MMU binding
Date: Wed, 26 Jun 2013 14:39:41 +0100
Message-ID: <20130626133941.GD7417@mudshark.cambridge.arm.com>
References: <1370889285-22799-1-git-send-email-will.deacon@arm.com>
	<1370889285-22799-8-git-send-email-will.deacon@arm.com>
	<CALRxmdBxFWoRKv+bUu8VEwNNcAJUej9jM2V8N0rrqrr_Vpe8fQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CALRxmdBxFWoRKv+bUu8VEwNNcAJUej9jM2V8N0rrqrr_Vpe8fQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Stuart Yoder <b08248-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org Discuss" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Stuart,

On Tue, Jun 25, 2013 at 08:18:19PM +0100, Stuart Yoder wrote:
> On Mon, Jun 10, 2013 at 1:34 PM, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote:
> > diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> > new file mode 100644
> > index 0000000..e34c6cd
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> > @@ -0,0 +1,70 @@
> > +* ARM System MMU Architecture Implementation
> > +
> > +ARM SoCs may contain an implementation of the ARM System Memory
> > +Management Unit Architecture, which can be used to provide 1 or 2 stages
> > +of address translation to bus masters external to the CPU.
> > +
> > +The SMMU may also raise interrupts in response to various fault
> > +conditions.
> > +
> > +** System MMU required properties:
> > +
> > +- compatible    : Should be one of:
> > +
> > +                        "arm,smmu-v1"
> > +                        "arm,smmu-v2"
> > +                        "arm,mmu-400"
> > +                        "arm,mmu-500"
> > +
> > +                  depending on the particular implementation and/or the
> > +                  version of the architecture implemented.
> > +
> > +- reg           : Base address and size of the SMMU.
> > +
> > +- #global-interrupts : The number of global interrupts exposed by the
> > +                       device.
> > +
> > +- interrupts    : Interrupt list, with the first #global-irqs entries
> > +                  corresponding to the global interrupts
> 
> It seems like we don't have enough information here.   It's not enough
> for the OS to know that there are 2, 4, etc global interrupts, no?  It needs
> to know which hardware interrupt each corresponds to.   That kind of
> stuff is normally defined in the device binding.
> 
> What is it that determines the number of global interrupts?

I'd suggest looking at the driver I posted to get a gist of how the parsing
code works, but suffice to say that we describe both the number of
interrupts and the actual interrupt numbers here.

> > +- mmu-masters   : A list of phandles to device nodes representing bus
> > +                  masters for which the SMMU can provide a translation
> > +                  and their corresponding StreamIDs (see example below).
> > +                  Each device node linked from this list must have a
> > +                  "#stream-id-cells" property, indicating the number of
> > +                  StreamIDs associated with it.
> 
> So to find a the SMMU for a given device, I walk up the bus hierarchy
> until I find an SMMU?

Again, the code is better than any explanation I can give here, but we
basically construct a tree of masters for each SMMU in the system based on
the mmu-masters property, which we can later search.

> > +** System MMU optional properties:
> > +
> > +- smmu-parent   : When multiple SMMUs are chained together, this
> > +                  property can be used to provide a phandle to the
> > +                  parent SMMU (that is the next SMMU on the path going
> > +                  from the mmu-masters towards memory) node for this
> > +                  SMMU.
> 
> Why is an explicit phandle link needed here when you don't need a
> smmu-parent phandle in each mmu-master?    Won't walking the bus
> hierarchy identify the parent SMMU if things are chained?

What bus hierarchy? If I have two SMMU device nodes, how do I infer any
topological information without an explicit linkage?

Will
