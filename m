From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] documentation: iommu: add description of ARM System MMU
	binding
Date: Thu, 18 Apr 2013 20:01:31 +0100
Message-ID: <20130418190131.GA12344@mudshark.cambridge.arm.com>
References: <1365094259-24847-1-git-send-email-will.deacon@arm.com>
	<515F37C1.4000109@codeaurora.org>
	<20130408092535.GA17476@mudshark.cambridge.arm.com>
	<5162F87A.7070409@codeaurora.org>
	<20130410173732.GQ26992@mudshark.cambridge.arm.com>
	<5169C7D1.8070300@codeaurora.org>
	<20130415131341.GG9827@mudshark.cambridge.arm.com>
	<516D9602.2010404@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <516D9602.2010404-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
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
Cc: "linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Olav,

On Tue, Apr 16, 2013 at 07:18:42PM +0100, Olav Haugan wrote:
> On 4/15/2013 6:13 AM, Will Deacon wrote:
> > If so, doesn't that strongly tie your video driver to the SMMU?
> 
> Isn't this more or less what you are doing in DT where you associate
> specific devices with an IOMMU (mmu-masters)?

No. The device-tree describes the *hardware*, as per usual. The StreamIDs
are fixed properties of the SoC and we can't change them from Linux, so we
describe all of the StreamIDs upstream of each SMMU so that we can program
the thing. There's no way to generic way to discover them.

> > This seems to be where we differ. My anticipated use-case is that a domain
> > is allocated, which defines an empty address space. Masters are then
> > attached to the domain by passing their struct device, so this may
> > correspond to a DMA controller or a video core, in your case. The context
> > bank is allocated dynamically when the first device is added to the
> > domain, and then it is subsequently shared between all the masters in that
> > domain.
> 
> I feel that there are some limitation with this. Maybe you can address
> the following:
> 
> 1) What if you want two context banks in one domain (shared page table)?

Why would a page table shared between devices require multiple context
banks? Multiple SMRs and S2CRs, sure, but they would ultimately point at the
same context bank (and hence same address space).

> 2) What if a master (device) needs to use 2 or more context banks?

If a master needs to be in two address spaces at once, then it will need to
attach it's StreamIDs to different domains. You can't place a single
StreamID in two address spaces (this is an architectural constraint).

> > Perhaps, but I don't think it's worth complicating the binding based on a
> > potential nice-to-have fault message.
> > 
> 
> However, global register space (including Stream Match Registers [SMR])
> needs to be programmed by the secure environment for security or by
> hyper-visor if you are in such an environment.

Of course, but that's not Linux (and KVM would likely have some additional
code if it wanted to do device passthrough, for example).

Will
