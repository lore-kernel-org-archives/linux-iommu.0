From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH] iommu/ipmmu-vmsa: Include SoC part number in DT binding docs
Date: Tue, 20 Oct 2015 13:27:47 +0300
Message-ID: <1833179.ksYYvY8Qgn@avalon>
References: <20151019031003.7878.28510.sendpatchset@little-apple> <9833652.FLB0aRvpVP@avalon> <CANqRtoQ=nBpWX_eMUM9-febZ-cCAFayEGoUjMSpAXHaw3kekqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <CANqRtoQ=nBpWX_eMUM9-febZ-cCAFayEGoUjMSpAXHaw3kekqQ@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Pawel Moll <pawel.moll@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, joro <joro@8bytes.org>, SH-Linux <linux-sh@vger.kernel.org>, iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>, Kumar Gala <galak@codeaurora.org>, Simon Horman <horms+renesas@verge.net.au>
List-Id: iommu@lists.linux-foundation.org

Hi Magnus,

On Tuesday 20 October 2015 17:58:17 Magnus Damm wrote:
> On Mon, Oct 19, 2015 at 3:44 PM, Laurent Pinchart wrote:
> > On Monday 19 October 2015 12:10:03 Magnus Damm wrote:
> >> From: Magnus Damm <damm+renesas@opensource.se>
> >> 
> >> Add part numbers for APE6 and current set of R-Car Gen2 SoCs to the
> >> IPMMU DT binding documentation. The example is also updated to show
> >> how the generic compatible string may be used as fallback.
> > 
> > I'd use a wording stronger than "may" here, as the generic compatible
> > value is required. I would also explicitly state that in the bindings
> > documentation.
>
> I don't mind using a different wording, but it becomes a bit difficult
> to describe exactly when to use the generic compatible string and when
> not to. Is it always required, or does it depend on the hardware?
> 
>  "For compatible hardware please use the generic compat string."
> Compatible with what? =)
> 
> Any ideas how to describe it correctly in the binding documentation?

Given that the generic compat string is always required I'd just say so. We 
can then update the DT bindings later when we'll introduce the first SoC not 
compatible with the generic compat string.

-- 
Regards,

Laurent Pinchart

