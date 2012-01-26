From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/5] iommu/amd: Implement DOMAIN_ATTR_GEOMETRY attribute
Date: Thu, 26 Jan 2012 12:42:10 -0600
Message-ID: <4F219E82.106@freescale.com>
References: <1326983405-319-1-git-send-email-joerg.roedel@amd.com> <1326983405-319-3-git-send-email-joerg.roedel@amd.com> <C5ECD7A89D1DC44195F34B25E172658D038749@039-SN2MPN1-011.039d.mgd.msft.net> <20120120160344.GG2205@amd.com> <4F219A9C.8000400@freescale.com> <20120126183116.GI19255@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120126183116.GI19255@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joerg.roedel@amd.com>
Cc: Sethi Varun-B16395 <B16395@freescale.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, Ohad Ben-Cohen <ohad@wizery.com>, Tony Lindgren <tony@atomide.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Wood Scott-B07421 <B07421@freescale.com>, David Brown <davidb@codeaurora.org>, David Woodhouse <dwmw2@infradead.org>
List-Id: iommu@lists.linux-foundation.org

On 01/26/2012 12:31 PM, Joerg Roedel wrote:
> On Thu, Jan 26, 2012 at 12:25:32PM -0600, Scott Wood wrote:
>> How should a PAMU driver interpret "force_aperture"?  When would DMA
>> ever be allowed outside the specified range?  What does the range mean
>> in that case?
> 
> The force_aperture flag indicated whether DMA is only allowed between
> aperture_start and apertuer_end or if DMA is allowed outside of this
> range too (unmapped in this case).
> 
> The AMD GART for example would set this flag to false because it does
> not enforce DMA to be in the aperture-range.

Why is this not an AMD GART specific attribute?  Is there any feature
reporting mechanism by which a user would know if that flag is supported?

If it must be in the generic struct, it would be nice to invert the
polarity so that the default (after zeroing) is something that should be
more widely supportable, and less likely to create unintended identity
mappings.

How in general are available attributes and restrictions on possible
values to be communicated to users of the API?

-Scott
