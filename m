From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH V3 1/4] ARM64: dts: rockchip: rk3328 add iommu nodes
Date: Wed, 26 Jul 2017 13:44:02 +0200
Message-ID: <7545443.2JTXH2SMA9@diego>
References: <1500863530-32792-1-git-send-email-xxm@rock-chips.com> <20170726105818.GK15833@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170726105818.GK15833-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Simon Xue <xxm-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

Am Mittwoch, 26. Juli 2017, 12:58:19 CEST schrieb Joerg Roedel:
> On Mon, Jul 24, 2017 at 10:32:07AM +0800, Simon Xue wrote:
> > Add H265e/VEPU/VPU/VDEC/VOP iommu nodes
> > 
> > Signed-off-by: Simon Xue <xxm-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
> > ---
> > 
> > changes since V2:
> >  - none
> >  
> >  arch/arm64/boot/dts/rockchip/rk3328.dtsi | 45
> >  ++++++++++++++++++++++++++++++++ 1 file changed, 45 insertions(+)
> 
> Applied all, thanks.

I really would prefer iommu dt-nodes going through my tree :-)

Especially as parts of these conflict with already pending patches for
graphics support and with the iommu nodes sitting in your tree these
would need to wait another kernel release.


Heiko
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
