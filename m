From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v2 05/10] iommu/ipmmu-vmsa: Add device tree bindings documentation
Date: Tue, 16 Dec 2014 17:19:32 +0200
Message-ID: <1644235.rIIJM1Vgpl@avalon>
References: <1418737457-22042-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <1418737457-22042-6-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <CAMuHMdXC8C7BuTdK8-RkqaQ6dqi1bxRHFz1CttGQi3u9w6QD7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdXC8C7BuTdK8-RkqaQ6dqi1bxRHFz1CttGQi3u9w6QD7Q@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, iommu@lists.linux-foundation.org, Linux-sh list <linux-sh@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

Hi Geert,

On Tuesday 16 December 2014 14:52:39 Geert Uytterhoeven wrote:
> On Tue, Dec 16, 2014 at 2:44 PM, Laurent Pinchart wrote:
> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com>
> 
> Thanks!
> 
> Apart from the minor nit below:
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> > +       ipmmu_mx: mmu@fe951800 {
> 
> fe951000

Oops :-) Fixed, and applied your ack. Thank you.

> (yes, having to put the same information in two places will cause
> discrepancies)
>
> > +               compatible = "renasas,ipmmu-vmsa";
> > +               reg = <0 0xfe951000 0 0x1000>;
> > +               interrupts = <0 222 IRQ_TYPE_LEVEL_HIGH>,
> > +                            <0 221 IRQ_TYPE_LEVEL_HIGH>;
> > +               #iommu-cells = <1>;
> > +       };

-- 
Regards,

Laurent Pinchart

