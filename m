From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V3 1/4] ARM64: dts: rockchip: rk3328 add iommu nodes
Date: Thu, 27 Jul 2017 14:15:18 +0200
Message-ID: <20170727121518.GB21502@8bytes.org>
References: <1500863530-32792-1-git-send-email-xxm@rock-chips.com>
	<7545443.2JTXH2SMA9@diego> <20170726122753.GQ15833@8bytes.org>
	<1668393.AqADimcrsl@diego>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1668393.AqADimcrsl@diego>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hey Heiko,

On Wed, Jul 26, 2017 at 03:53:06PM +0200, Heiko St=FCbner wrote:
> Having code and dts changes go through different trees is no problem, as =
they =

> don't have a compile-time dependencies on each other and come together ni=
cely =

> in linux-next again.

Okay, I removed

ARM64: dts: rockchip: rk3328 add iommu nodes
ARM: dts: rockchip: rk322x add iommu nodes
ARM64: dts: rockchip: rk3368 add iommu nodes
ARM64: dts: rockchip: rk3399 add iommu nodes
ARM64: dts: rockchip: rk3328 add iommu nodes
ARM: dts: rockchip: rk322x add iommu nodes
ARM64: dts: rockchip: rk3368 add iommu nodes
ARM64: dts: rockchip: rk3399 add iommu nodes

from my tree again and kept

Docs: dt: rockchip: add rockchip,disable-mmu-reset property
iommu/rockchip: add multi irqs support
iommu/rockchip: ignore isp mmu reset operation


Regards,

	Joerg
