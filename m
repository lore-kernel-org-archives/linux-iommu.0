From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] documentation: iommu: add description of ARM System MMU
	binding
Date: Mon, 15 Apr 2013 14:13:41 +0100
Message-ID: <20130415131341.GG9827@mudshark.cambridge.arm.com>
References: <1365094259-24847-1-git-send-email-will.deacon@arm.com>
	<515F37C1.4000109@codeaurora.org>
	<20130408092535.GA17476@mudshark.cambridge.arm.com>
	<5162F87A.7070409@codeaurora.org>
	<20130410173732.GQ26992@mudshark.cambridge.arm.com>
	<5169C7D1.8070300@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5169C7D1.8070300-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
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

On Sat, Apr 13, 2013 at 10:02:09PM +0100, Olav Haugan wrote:
> Hi again Will,

Hello Olav,

> On 4/10/2013 10:37 AM, Will Deacon wrote:
> > Ok, but then how does that interact with the IOMMU API in Linux? e.g.
> > if a client asks for an iova <-> pa mapping on a device, then you
> > need to lookup the StreamIDs for that device, no?
> 
> Can you explain this use case a bit more. I am not clear what you mean
> by a "client"? Are you referring to a client in Linux or are you
> referring to the client being the core behind an IOMMU (such as a DMA
> engine or a video core)?

Sure. By `client', I mean any use of the IOMMU API. It could be something
like your LVD example later on, it could be KVM or it could be indirectly
via dma-mapping. Basically, any user of <linux/iommu.h>.

> I am not sure how StreamIDs relates to the IOMMU API in Linux :-)

That's the thing; they don't, at least not explicitly. The StreamIDs must
all be handled inside the driver and it's actually what the driver would
deal with, rather than devices.

For example, if I create an IOMMU domain containing a DMA controller, that
means that I have associated a set of StreamIDs (i.e. those configured to
identify the DMA controller's master ports) with that domain. That may have
further consequences on which other devices can be put in the same domain
(stream-matching may require some IDs to sit in the same address space/domain)
and also effectively parameterises the domain, by pointing those StreamIDs
at the same context bank.

> I think it helps if I explain my use case to you so you understand how
> we use the IOMMU and maybe you can explain your use case and how your
> driver works so that we can get on the same page. BTW, our ARMv1 IOMMU
> driver can be found @ [1]
> 
> Our use case:
> 
> 1) During boot IOMMU HW is probed, devices for each IOMMU and for each
> context bank are created.

So you create a device for each context bank...

> 2) Video session starts.
> 3) Linux Video Driver (LVD) creates one or more domain
> (iommu_domain_alloc) and calls iommu_attach_device() for each context
> bank it is going to use.

...and attach the context bank to the domain dynamically?

If so, doesn't that strongly tie your video driver to the SMMU?

> 4) LVD then calls map as needed for the buffers that the video core
> needs to access.
> 5) LVD shares IOVA with video core and kicks off video core decoding.
> 6) Video session ends.
> 7) LVD unmaps
> 8) LVD detaches.
> 
> The video driver selects context bank to attach to based on the use case
> and does not know about StreamIDs really.
> 
> BTW, when you call iommu_attach_device() what "device" do you pass as
> argument? Do you pass the IOMMU as a device? How do you specify which
> Context Bank to attach to?

This seems to be where we differ. My anticipated use-case is that a domain
is allocated, which defines an empty address space. Masters are then
attached to the domain by passing their struct device, so this may
correspond to a DMA controller or a video core, in your case. The context
bank is allocated dynamically when the first device is added to the
domain, and then it is subsequently shared between all the masters in that
domain.

I think this also matches what dma-mapping.c expects.

> > Why can't the secure world just hide those context banks by using 
> > SMMU_SCR1.NSNUMCBO?
> 
> Yes, that is a possibility for context banks. If you have 1 or more
> "secure" context banks it also means that Linux does not have access
> (read: can't have) to the global register space and this must be
> communicated somehow (hence the "secure-id" IOMMU node property. The
> secure-context property might be redundant. However, there might be use
> cases were Linux would want to know about the secure context bank. One
> such use case could be to register for page fault from the secure
> context bank so that Linux can log a useful page fault message to the
> kernel log.

Perhaps, but I don't think it's worth complicating the binding based on a
potential nice-to-have fault message.

Will
