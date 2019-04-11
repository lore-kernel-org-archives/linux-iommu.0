From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2 4/6] iommu/ipmmu-vmsa: Move num_utlbs to SoC-specific
 features
Date: Thu, 11 Apr 2019 10:35:18 +0200
Message-ID: <20190411083518.enlytqnwukzgwslz@verge.net.au>
References: <20190403182148.18058-1-geert+renesas@glider.be>
 <20190403182148.18058-5-geert+renesas@glider.be>
 <20190411083240.jxv3xoasrg3vx5zh@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190411083240.jxv3xoasrg3vx5zh@verge.net.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Joerg Roedel <joro@8bytes.org>, Magnus Damm <damm+renesas@opensource.se>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, iommu@lists.linux-foundation.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Apr 11, 2019 at 10:32:40AM +0200, Simon Horman wrote:
> On Wed, Apr 03, 2019 at 08:21:46PM +0200, Geert Uytterhoeven wrote:
> > The maximum number of micro-TLBs per IPMMU instance is not fixed, but
> > depends on the SoC type.  Hence move it from struct ipmmu_vmsa_device to
> > struct ipmmu_features, and set up the correct value for both R-Car Gen2
> > and Gen3 SoCs.
> > 
> > Note that currently no code uses this value.
> > 
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> Are there any plans to use num_utlbs in the driver or anywhere else in the
> kernel? If not, perhaps it should be removed?

I see that I spoke too soon and it is used by a patch later on in this
series.

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
