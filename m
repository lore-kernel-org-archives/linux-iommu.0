From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V3 1/4] ARM64: dts: rockchip: rk3328 add iommu nodes
Date: Wed, 26 Jul 2017 14:27:53 +0200
Message-ID: <20170726122753.GQ15833@8bytes.org>
References: <1500863530-32792-1-git-send-email-xxm@rock-chips.com>
 <20170726105818.GK15833@8bytes.org>
 <7545443.2JTXH2SMA9@diego>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <7545443.2JTXH2SMA9@diego>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Cc: Simon Xue <xxm-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hey Heiko,

On Wed, Jul 26, 2017 at 01:44:02PM +0200, Heiko Stübner wrote:
> I really would prefer iommu dt-nodes going through my tree :-)
> 
> Especially as parts of these conflict with already pending patches for
> graphics support and with the iommu nodes sitting in your tree these
> would need to wait another kernel release.

Sure, no problem. I have nothing pushed yet, so it's easy to remove
again. Do you want to take all three patch-sets from Simon through your
tree or just this one?


Regards,

	Joerg

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
