From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2 0/2] iommu/ipmmu-vmsa: Add r8a779(6|70|95) DT bindings
Date: Thu, 21 Dec 2017 10:26:31 +0100
Message-ID: <20171221092631.tawh5x7gqw5626o2@verge.net.au>
References: <20171124105804.26924-1-horms+renesas@verge.net.au>
 <20171220120244.38a2be5a@t450s.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171220120244.38a2be5a@t450s.home>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Joerg Roedel <joro@8bytes.org>, Magnus Damm <magnus.damm@gmail.com>, iommu@lists.linux-foundation.org, linux-renesas-soc@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Dec 20, 2017 at 12:02:44PM -0700, Alex Williamson wrote:
> On Fri, 24 Nov 2017 10:58:02 +0000
> Simon Horman <horms+renesas@verge.net.au> wrote:
> 
> > Update the IPMMU DT binding documentation to include r8a7796 (R-Car M3-W),
> > r8a77970 (R-Car V3M) and r8a77995 (R-Car D3) compat strings.
> > 
> > This patch-set is comprised of patches previously included in
> > * [PATCH v4 0/3] iommu/ipmmu-vmsa: r8a7796 support V4
> > * [PATCH 0/2] iommu/ipmmu-vmsa: r8a779(70|95) support
> > 
> > Those series also include driver updates to implement the bindings,
> > however, it while it is felt that the bindings themselves are ready
> > to be merged we feel that the driver updates are not at that stage yet.
> > 
> > Changes since v1:
> > * Correct typo in r8a779(70|95) patch: R8A7770 -> R8A77970
> > 
> > 
> > Magnus Damm (1):
> >   iommu/ipmmu-vmsa: Add r8a7796 DT binding
> > 
> > Simon Horman (1):
> >   iommu/ipmmu-vmsa: Add r8a779(70|95) DT bindings
> > 
> >  Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> 
> Applied to v4.16-iommu/ipmmu-vmsa.  Thanks,

Thanks, much appreciated.
