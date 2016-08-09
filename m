From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 3/3] iommu/ipmmu-vmsa: Hook up r8a7796 DT matching code
Date: Tue, 09 Aug 2016 16:19:01 +0300
Message-ID: <14156780.DZdbshsptM@avalon>
References: <20160607033918.28687.98260.sendpatchset@little-apple> <CANqRtoSfzZhMXwLpbwr2k22qgcA=GJ5pxV82FPLkB4FKOqsX4g@mail.gmail.com> <7796705.iS1mBl6Cq9@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <7796705.iS1mBl6Cq9@avalon>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, iommu@lists.linux-foundation.org, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Joerg Roedel <joro@8bytes.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-renesas-soc@vger.kernel.org, Simon Horman <horms+renesas@verge.net.au>
List-Id: iommu@lists.linux-foundation.org

On Tuesday 09 Aug 2016 16:17:57 Laurent Pinchart wrote:
> On Wednesday 08 Jun 2016 18:12:31 Magnus Damm wrote:
> > On Wed, Jun 8, 2016 at 5:48 PM, Laurent Pinchart wrote:
> >> On Wednesday 08 Jun 2016 09:04:17 Geert Uytterhoeven wrote:
> >>> On Wed, Jun 8, 2016 at 2:18 AM, Laurent Pinchart wrote:
> >>>>> --- 0031/drivers/iommu/ipmmu-vmsa.c
> >>>>> +++ work/drivers/iommu/ipmmu-vmsa.c   2016-06-06 11:19:40.210607110
> 
> [snip]
> 
> >>>>> @@ -1268,6 +1271,8 @@ IOMMU_OF_DECLARE(ipmmu_vmsa_iommu_of, "r
> >>>>>                ipmmu_vmsa_iommu_of_setup);
> >>>>>  IOMMU_OF_DECLARE(ipmmu_r8a7795_iommu_of, "renesas,ipmmu-r8a7795",
> >>>>>                ipmmu_vmsa_iommu_of_setup);
> >>>>> +IOMMU_OF_DECLARE(ipmmu_r8a7796_iommu_of, "renesas,ipmmu-r8a7796",
> >>>>> +              ipmmu_vmsa_iommu_of_setup);
> >>>> 
> >>>> How about a Gen3 generic compatible string in addition to the
> >>>> SoC-specific ones ?
> >>> 
> >>> Do we want to specify the number of utlbs here?
> >>> Does it differ between r8a7795, r8a7796, and future members?
> >> 
> >> It differs between IPMMU instances on a given SoC, so if we want to
> >> specify it it should be a DT property.
> > 
> > Can you please point out which documentation that says it varies with
> > IPMMU instance?
> > 
> > Based on IMUCTRn register description "H3-ES1" has 0-31 range while
> > "Others" have 0-47.
> 
> The maximum number of uTLBs is indeed the same according to that part of the
> documentation, but not all uTLBs are available in all IPMMU instances. We
> even have holes in the uTLB ranges, maybe a mask would be more appropriate.

And the other option is of course to ignore that and accept any uTLB number, 
in which case we will rely on the IOMMU bus master node providing correct 
information.

-- 
Regards,

Laurent Pinchart
