From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH V3 1/4] ARM64: dts: rockchip: rk3328 add iommu nodes
Date: Thu, 27 Jul 2017 14:26:26 +0200
Message-ID: <2435376.oHOWQmfDuH@diego>
References: <1500863530-32792-1-git-send-email-xxm@rock-chips.com> <1668393.AqADimcrsl@diego> <20170727121518.GB21502@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170727121518.GB21502-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Simon Xue <xxm-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

Am Donnerstag, 27. Juli 2017, 14:15:18 CEST schrieb Joerg Roedel:
> Hey Heiko,
> 
> On Wed, Jul 26, 2017 at 03:53:06PM +0200, Heiko Stübner wrote:
> > Having code and dts changes go through different trees is no problem, as
> > they don't have a compile-time dependencies on each other and come
> > together nicely in linux-next again.
> 
> Okay, I removed
> 
> ARM64: dts: rockchip: rk3328 add iommu nodes
> ARM: dts: rockchip: rk322x add iommu nodes
> ARM64: dts: rockchip: rk3368 add iommu nodes
> ARM64: dts: rockchip: rk3399 add iommu nodes
> ARM64: dts: rockchip: rk3328 add iommu nodes
> ARM: dts: rockchip: rk322x add iommu nodes
> ARM64: dts: rockchip: rk3368 add iommu nodes
> ARM64: dts: rockchip: rk3399 add iommu nodes
>
> from my tree again and kept
> 
> Docs: dt: rockchip: add rockchip,disable-mmu-reset property
> iommu/rockchip: add multi irqs support
> iommu/rockchip: ignore isp mmu reset operation

great, thanks.

Interestingly it seems you had the dts patches 2 times each
likely from v1 and v2. But they're gone now, so all good :-)


Heiko
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
