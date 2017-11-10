From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 0/2] iommu/ipmmu-vmsa: r8a779(70|95) support
Date: Fri, 10 Nov 2017 09:38:07 +0100
Message-ID: <20171110083807.biz6txghquop7lr2@verge.net.au>
References: <20171101103423.7334-1-horms+renesas@verge.net.au>
 <20171106122201.77d640e5@t450s.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171106122201.77d640e5@t450s.home>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Joerg Roedel <joro@8bytes.org>, linux-renesas-soc@vger.kernel.org, iommu@lists.linux-foundation.org, Magnus Damm <magnus.damm@gmail.com>
List-Id: iommu@lists.linux-foundation.org

On Mon, Nov 06, 2017 at 12:22:01PM -0700, Alex Williamson wrote:
> On Wed,  1 Nov 2017 11:34:21 +0100
> Simon Horman <horms+renesas@verge.net.au> wrote:
> 
> > Update Update the IPMMU DT binding documentation and driver implementation
> > to support the r8a77970 (R-Car V3M) and r8a77995 (R-Car D3).
> > 
> > Based on work for r8a7796 by Magnus Damm.
> > 
> > Patches based on:
> > * iommu/next
> > * [PATCH v5 00/09] iommu/ipmmu-vmsa: r8a7795 support V5
> > * [PATCH v4 0/3] iommu/ipmmu-vmsa: r8a7796 support V4
> >   (fuzz when applying 3/3)
> 
> This last dependent patch series hasn't had any comments or updates
> since June.  Do I take it from Simon's new patches here that it's still
> relevant and desired?  Perhaps it was simply missed and nobody bothered
> to re-send it?  Thanks,

Hi Alex,

I spoke with Magnus about this and we feel that its a little early
to merge the driver portion of both "[PATCH v4 0/3] iommu/ipmmu-vmsa:
r8a7796 support V4" and this patchset.

We would, however, like to see the bindings updates merged as they seem
ready. I will repost them separately as that should be easiest for you.
