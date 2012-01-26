From: Joerg Roedel <joerg.roedel@amd.com>
Subject: Re: [PATCH 2/5] iommu/amd: Implement DOMAIN_ATTR_GEOMETRY attribute
Date: Thu, 26 Jan 2012 19:31:16 +0100
Message-ID: <20120126183116.GI19255@amd.com>
References: <1326983405-319-1-git-send-email-joerg.roedel@amd.com>
 <1326983405-319-3-git-send-email-joerg.roedel@amd.com>
 <C5ECD7A89D1DC44195F34B25E172658D038749@039-SN2MPN1-011.039d.mgd.msft.net>
 <20120120160344.GG2205@amd.com>
 <4F219A9C.8000400@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4F219A9C.8000400@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Scott Wood <scottwood@freescale.com>
Cc: Sethi Varun-B16395 <B16395@freescale.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, Ohad Ben-Cohen <ohad@wizery.com>, Tony Lindgren <tony@atomide.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Wood Scott-B07421 <B07421@freescale.com>, David Brown <davidb@codeaurora.org>, David Woodhouse <dwmw2@infradead.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Jan 26, 2012 at 12:25:32PM -0600, Scott Wood wrote:
> On 01/20/2012 10:03 AM, Joerg Roedel wrote:
> > Because the values in this generic geometry-struct make sense for more
> > than one IOMMU (short-term for Tegra GART and Freescale PAMU). If you
> > have additional vendor-specific ones you could add them via a
> > vendor-specific attribute.
> 
> Freescale PAMU is the IOMMU that Varun is talking about, that needs
> additional geometry attributes (in particular, subwindow count).

This can be solved by a PAMU specific attribute.

> How should a PAMU driver interpret "force_aperture"?  When would DMA
> ever be allowed outside the specified range?  What does the range mean
> in that case?

The force_aperture flag indicated whether DMA is only allowed between
aperture_start and apertuer_end or if DMA is allowed outside of this
range too (unmapped in this case).

The AMD GART for example would set this flag to false because it does
not enforce DMA to be in the aperture-range.


	Joerg

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
