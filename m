From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v2 0/5] Renesas VMSA-compatible IPMMU DT support
Date: Fri, 18 Apr 2014 00:50:14 +0200
Message-ID: <2308571.W3LBJprK1V@avalon>
References: <6626224.o7l75GClE1@avalon> <20140417155519.GE30553@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20140417155519.GE30553@arm.com>
Sender: linux-sh-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

Hi Will,

On Thursday 17 April 2014 16:55:19 Will Deacon wrote:
> On Thu, Apr 17, 2014 at 12:12:57PM +0100, Laurent Pinchart wrote:
> > Hello,
> 
> Hi Laurent,
> 
> > This patch set adds DT support to the Renesas VMSA-compatible IPMMU
> > driver. The first patch refactors the driver to remove dependencies on
> > platform data, the second patch adds the DT bindings documentation and the
> > third patch implement them in the driver.
> > 
> > The next two patches show real-life examples for IPMMU DT bindings usage.
> > Patch 4/5 adds IPMMU DT nodes to the r8a7791 SoC dtsi file, and patch 5/5
> > enables IOMMU support for the VSP1 on the same platform.
> > 
> > The patches are based on top of the IPMMU driver previously submitted to
> > the iommu mailing list. The last patch additionally requires to VSP1 DT
> > support patch series previously submitted to the linux-media mailing list
> > and is thus a test patch only at the moment, not meant to be merged yet.
> > 
> > The DT bindings are pretty simple, with only three standard properties in
> > the IPMMU DT node. The driver doesn't need to know the number of
> > micro-TLBs (a micro-TLB being a port to which a bus master device is
> > attached, identified by a number similar in purpose to a stream ID), so
> > I've decided not to specify it in DT. The micro-TLBs are configured when
> > a bus master device is attached or detached, and at that point the device
> > provides its micro-TLB number.
> > 
> > The only reason I can foresee why the number of micro-TLBs would be useful
> > is to iterate over micro-TLBs when the driver probes the device to
> > disable them all. A mask would probably be better than a number in that
> > case, and I think we can always add that later if we find a need for it.
> > 
> > The device to IOMMU association is represented in the bus master device
> > nodes using an iommus property, similarly to interrupts or clocks. This
> > model departs from the ARM SMMU DT bindings that represent the same
> > information inside the IOMMU DT node. Will, please feel free to tell me
> > if you believe this model isn't good.
> 
> If this model works for you, then I'm also fine with it. The only complaint
> is that we now have a needless difference between the ARM SMMU driver and
> your driver in the way that the device <-> smmu topology is described. I'd
> be happy to try and move my driver over to your binding, but that would
> break all existing users and, whilst there aren't any in-tree .dts files
> using the ARM SMMU, I doubt it would be a popular move.

I'm also slightly unhappy with having two different models. Of course, if I 
had thought that the two models were equally good, I would have followed yours 
:-) It seems more natural to me to express the association with an IOMMU as a 
resource, similarly to clocks, GPIOs or interrupts. It would also allow easier 
support for devices that use multiple IOMMUs (which should be pretty uncommon, 
in my case devices can have several independent bus master ports, but they all 
go through the same IOMMU, with different micro-TLBs/stream IDs).

There's no other mainline IOMMU driver that model the bus masters to IOMMU 
relationship in DT, so it's probably a good time to discuss this issue as 
broadly as possible and decide on sane rules. If we have to live with 
different models, so be it, but I think we should establish a default model at 
least for new drivers. It would especially be useful if we want to handle 
device to domain association in common code, which I believe would be a good 
target.

> > Every IPMMU instance serves multiple bus master devices and implements
> > four independent page tables and TLBs. Each bus master can be freely
> > assigned to one of the page tables, lowering the risk of TLB miss when
> > multiple bus masters require address translation at the same time. I've
> > decided not to express the bus master to page table association in DT as
> > this seems to me to be a software configuration decision, not a hardware
> > property. Feel free to disagree.
>
> Isn't the master -> page table association a dynamic property, defined by
> the (runtime) configuration of IOMMU domains? That is, you have one page
> table per domain and the act of attaching a device to a domain associates
> it with that page table?

That's correct. The IPMMU has four domains and handles more than four devices. 
I thus need to decide to which domain to attach each device. Doing so in a 
round-robin fashion is an acceptable first implementation, but fine-tuning 
might be needed at some point for performance reasons.

> Or do you need an identity-mapped page table in order to pass-through
> transactions when no translation is configured?

Fortunately I don't need that.

-- 
Regards,

Laurent Pinchart

