From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V3 1/4] ARM64: dts: rockchip: rk3328 add iommu nodes
Date: Thu, 27 Jul 2017 14:45:07 +0200
Message-ID: <20170727124507.GC21502@8bytes.org>
References: <1500863530-32792-1-git-send-email-xxm@rock-chips.com>
	<1668393.AqADimcrsl@diego> <20170727121518.GB21502@8bytes.org>
	<2435376.oHOWQmfDuH@diego>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <2435376.oHOWQmfDuH@diego>
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

On Thu, Jul 27, 2017 at 02:26:26PM +0200, Heiko St=FCbner wrote:
> Am Donnerstag, 27. Juli 2017, 14:15:18 CEST schrieb Joerg Roedel:
> > ARM64: dts: rockchip: rk3328 add iommu nodes
> > ARM: dts: rockchip: rk322x add iommu nodes
> > ARM64: dts: rockchip: rk3368 add iommu nodes
> > ARM64: dts: rockchip: rk3399 add iommu nodes
> > ARM64: dts: rockchip: rk3328 add iommu nodes
> > ARM: dts: rockchip: rk322x add iommu nodes
> > ARM64: dts: rockchip: rk3368 add iommu nodes
> > ARM64: dts: rockchip: rk3399 add iommu nodes

> Interestingly it seems you had the dts patches 2 times each
> likely from v1 and v2. But they're gone now, so all good :-)

Heh, you are right, I got confused by all these rkXXXX numbers and
thought it were patch-sets for different hardware :-)

Even more interesting that they applied almost cleanly.


	Joerg
