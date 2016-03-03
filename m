From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] iommu/ipmmu-vmsa: Add r8a7795 DT binding
Date: Thu, 3 Mar 2016 10:59:34 +0100
Message-ID: <20160303095934.GA27379@8bytes.org>
References: <20160229143309.28517.77269.sendpatchset@little-apple>
 <20160302145559.GU22747@8bytes.org>
 <CANqRtoQQzav-kweM80NnVUqtr2xxaA95XV88U1Ye7yoYHzSUsA@mail.gmail.com>
 <20160303000539.GB23040@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160303000539.GB23040@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: Magnus Damm <magnus.damm@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Pawel Moll <pawel.moll@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, linux-renesas-soc@vger.kernel.org, iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>, Kumar Gala <galak@codeaurora.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Mar 03, 2016 at 09:05:39AM +0900, Simon Horman wrote:
> On Thu, Mar 03, 2016 at 12:46:30AM +0900, Magnus Damm wrote:
> > On Wed, Mar 2, 2016 at 11:55 PM, Joerg Roedel <joro@8bytes.org> wrote:
> > > On Mon, Feb 29, 2016 at 11:33:09PM +0900, Magnus Damm wrote:
> > >> From: Magnus Damm <damm+renesas@opensource.se>
> > >>
> > >> Update the IPMMU DT binding documentation to include the r8a7795 compat
> > >> string as well as the "renesas,ipmmu-main" property that on r8a7795 will
> > >> be used to describe the topology and the relationship between the various
> > >> cache IPMMU instances and the main IPMMU.
> > >>
> > >> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> > >> ---
> > >>
> > >>  Written against linux-next tag next-20160229
> > >>
> > >>  Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt |   15 ++++++++--
> > >>  1 file changed, 13 insertions(+), 2 deletions(-)
> > >
> > > Through which tree should this go?
> > 
> > Unless anyone objects may I suggest going through your tree please!
> 
> FWIW that would be my preferred option.

Okay, applied.
