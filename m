From: Andreas Herrmann <andreas.herrmann@calxeda.com>
Subject: Re: [PATCH v2] documentation: iommu: add description of ARM System
 MMU binding
Date: Mon, 13 May 2013 12:41:47 +0200
Message-ID: <20130513104147.GF10369@alberich>
References: <1365789727-5371-1-git-send-email-will.deacon@arm.com>
 <20130513095020.GB10369@alberich>
 <20130513095846.GC29814@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20130513095846.GC29814@mudshark.cambridge.arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Will Deacon <will.deacon@arm.com>
Cc: Olav Haugan <ohaugan@codeaurora.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, May 13, 2013 at 05:58:46AM -0400, Will Deacon wrote:
> On Mon, May 13, 2013 at 10:50:20AM +0100, Andreas Herrmann wrote:
> > Hi Will,
> 
> Hi Andreas,
> 
> > so far, I thought, that this proposal is fine. After I have tried to
> > make use of the binding I have some points that might need further
> > disucssion.
> 
> Sure, although I've been using the binding without issues so it would be
> interesting to understand your use-case and why it's raising problems.
> 
> > Olav already asked (in another thread) how to model the mapping of
> > stream IDs to contexts for master devices that support multiple
> > contexts.  I doubt that this is fully covered yet.
> 
> Yeah, I've been meaning to reply to that. Given the way that the IOMMU API
> is structure in Linux, I don't think having multiple stream IDs per (struct)
> device, where each StreamID points at a different context (and therefore
> address space) makes much sense. It also doesn't solve the more general
> problem where StreamIDs for a device might have different SMMUs downstream.
> 
> To solve this, I think it is better to treat the device as having multiple
> struct device instances, and managing the mappings in the device driver.

Ok.

> For most devices, I'd expect a single context to be enough. This is
> certainly the case for device virtualisation at stage-2 and DMA at stage-1.

Yep, that's the usual case.
(Just thought what other scenarios there are.)

So the DT binding is for the most common (single-context) use case only.
(And everything else needs special device driver treatment.)

> > I also think that it is more useful to move the stream-id property to
> > the device node of a master device. (It's a characteristic of the
> > master device not of the SMMU.) Currently with multiple stream IDs per
> > master device you have repeated entries in the mmu-master property.
> 
> The problem with that approach is how to handle StreamID remastering. This
> can and will happen, so the StreamID for a device is actually a property of
> both the device *and* a particular point in the bus topology. Putting this
> information in the device nodes will drag topology information all over the
> place and I don't think it will make things clearer to read or easier to parse.

Ok, good point, didn't think about that.
And agreed, adding remastered StreamIDs as a property to a device node is odd.

> > But all that is needed is to point (once) to each mmu-master in the
> > SMMU device node. Then you should be able to look up the corresponding
> > stream IDs in the device node for each mmu-master.
> 
> Again, you also need to tie in topology information if you go down this
> route.


Thanks,
Andreas
