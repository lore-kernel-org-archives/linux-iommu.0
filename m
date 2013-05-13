From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] documentation: iommu: add description of ARM System MMU
	binding
Date: Mon, 13 May 2013 11:04:11 +0100
Message-ID: <20130513100411.GD29814@mudshark.cambridge.arm.com>
References: <5162F87A.7070409@codeaurora.org>
	<20130410173732.GQ26992@mudshark.cambridge.arm.com>
	<5169C7D1.8070300@codeaurora.org>
	<20130415131341.GG9827@mudshark.cambridge.arm.com>
	<516D9602.2010404@codeaurora.org>
	<20130418190131.GA12344@mudshark.cambridge.arm.com>
	<5177113D.7060300@codeaurora.org>
	<20130424095501.GC21850@mudshark.cambridge.arm.com>
	<5189635A.8090504@codeaurora.org> <20130513090724.GA10369@alberich>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130513090724.GA10369@alberich>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
Cc: Olav Haugan <ohaugan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, May 13, 2013 at 10:07:24AM +0100, Andreas Herrmann wrote:
> On Tue, May 07, 2013 at 04:26:02PM -0400, Olav Haugan wrote:
> > I think you misunderstood me. I am talking about having for example 1
> > master with two (2) context banks so that StreamID "1" goes to CB0 and
> > StreamID "2" goes to CB1. This means that the master device is attached
> > to two different domains. How do I model this with the the device tree
> > bindings?
> 
> Hi Olav,
> 
> I think with the proposed device tree binding you can't model this.
> 
> Do we have such use cases already? Or what future use cases would
> require this?
> 
> I can imagine of multiple contexts per device for stuff similar to
> what PASID in PCI Express are used for.
> 
> But in such a case you probably want to have some configurable bits in
> the StreamID (that should be set by an SMMU driver). And the DT
> binding should contain the number of contexts that a master device can
> support.

See my reply to your other thread, but I don't think this should be solved
in the SMMU driver. I really think that the device/domain configuration
should be driven by the master device drivers, rather than the device-tree.

Will
