From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/1] arm/dts: Tegra30: Add device tree support for SMMU
Date: Wed, 18 Apr 2012 08:10:17 +0300
Message-ID: <20120418081017.d3c630c6f7d09cd4ed039854@nvidia.com>
References: <20120413.132205.1766846402066131036.hdoyu@nvidia.com>
	<4F887F9B.700@wwwdotorg.org>
	<20120416.131059.331282986467061278.hdoyu@nvidia.com>
	<4F8C43AA.7090107@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4F8C43AA.7090107-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, 16 Apr 2012 18:07:06 +0200
Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> wrote:

> On 04/16/2012 04:10 AM, Hiroshi Doyu wrote:
> > Stephen Warren wrote at Fri, 13 Apr 2012 21:33:47 +0200:
> >> On 04/13/2012 04:22 AM, Hiroshi Doyu wrote:
> >>> Add device tree support for Tegra30 IOMMU(SMMU).
> ...
> >> But why does the SMMU driver expect to control the AHB arbitration
> >> registers? They seem unrelated to the SMMU.
> > 
> > It's necessary to inform AHB that SMMU is ready to use. There's a
> > dedicated bit for SMMU in this AHB arbitration register.
> 
> Shouldn't there be a dedicated driver for the AHB arbitration registers
> that the SMMU driver calls into to achieve this? IIRC, the AHB
> arbitration registers support much more than the SMMU enable, and if we
> ever need to touch those other features, going to the SMMU driver to do
> so probably wouldn't make sense.

Agree. Sounds like the way to go.

We haven't upstreamed AHB driver yet. So is it ok to remove AHB entry
from SMMU dt and add AHB function call when upstreaming AHB driver?
I'll work on that.
