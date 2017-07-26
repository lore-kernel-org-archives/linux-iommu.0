From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH V3 1/4] ARM64: dts: rockchip: rk3328 add iommu nodes
Date: Wed, 26 Jul 2017 15:53:06 +0200
Message-ID: <1668393.AqADimcrsl@diego>
References: <1500863530-32792-1-git-send-email-xxm@rock-chips.com>
	<7545443.2JTXH2SMA9@diego> <20170726122753.GQ15833@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170726122753.GQ15833-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

Am Mittwoch, 26. Juli 2017, 14:27:53 CEST schrieb Joerg Roedel:
> On Wed, Jul 26, 2017 at 01:44:02PM +0200, Heiko St=FCbner wrote:
> > I really would prefer iommu dt-nodes going through my tree :-)
> > =

> > Especially as parts of these conflict with already pending patches for
> > graphics support and with the iommu nodes sitting in your tree these
> > would need to wait another kernel release.
> =

> Sure, no problem. I have nothing pushed yet, so it's easy to remove
> again. Do you want to take all three patch-sets from Simon through your
> tree or just this one?

no, I'm of course fine with (and even very much in favor of) iommu-code
going through your tree :-) . I just want to keep the devicetree changes
together to prevent conflicts (and unnecessary wait times).

Having code and dts changes go through different trees is no problem, as th=
ey =

don't have a compile-time dependencies on each other and come together nice=
ly =

in linux-next again.


Heiko
