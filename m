From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2] iommu/ipmmu-vmsa: Add r8a7796 DT binding
Date: Mon, 31 Oct 2016 09:28:14 +0100
Message-ID: <20161031082814.GH18195@verge.net.au>
References: <20161027104510.27104.53523.sendpatchset@little-apple>
 <20161031051516.zpmoynwudyxlvppg@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161031051516.zpmoynwudyxlvppg@rob-hp-laptop>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, devicetree@vger.kernel.org, mark.rutland@arm.com, laurent.pinchart+renesas@ideasonboard.com, geert+renesas@glider.be, joro@8bytes.org, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Oct 31, 2016 at 12:15:16AM -0500, Rob Herring wrote:
> On Thu, Oct 27, 2016 at 07:45:10PM +0900, Magnus Damm wrote:
> > From: Magnus Damm <damm+renesas@opensource.se>
> > 
> > Update the IPMMU DT binding documentation to include the r8a7796 compat
> > string for R-Car M3-W.
> > 
> > Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> > Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > ---
> > 
> >  Changes since V1:
> >  - Added Acked-by from Laurent - thanks!
> > 
> >  Now broken out, however earlier V1 posted as part of:
> >  [PATCH 0/3] iommu/ipmmu-vmsa: Initial r8a7796 support
> > 
> >  Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt |    1 +
> >  1 file changed, 1 insertion(+)
> 
> Acked-by: Rob Herring <robh@kernel.org>

Acked-by: Simon Horman <horms+renesas@verge.net.au>
