From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH] iommu/rockchip: Make use of 'struct iommu_device'
Date: Mon, 03 Apr 2017 13:11:01 +0200
Message-ID: <4252325.o7BCCiZe8L@diego>
References: <1490970624-19981-1-git-send-email-joro@8bytes.org>
	<1785458.LaVlbOJ67B@diego> <20170403110758.GB4683@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170403110758.GB4683-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Am Montag, 3. April 2017, 13:07:58 CEST schrieb Joerg Roedel:
> Hey Heiko,
> =

> On Mon, Apr 03, 2017 at 11:56:59AM +0200, Heiko St=FCbner wrote:
> > In general works, and I still keep a working iommu-based display :-)
> > I can also see my two vop iommus under /sys/class/iommu now.
> =

> Great, thanks for testing that patch!
> =

> > Links in the devices subdirectory do not work though, see below:
> Okay, thats bad, but I think its nothing we should work around right
> now. My goal with this work is to have a per-iommu check-device
> call-back to bind devices to iommus in the core code.
> =

> This will also solve the probe-ordering issue and we are fine again. We
> just call check-device then for every device on the bus that has no
> iommu already when the iommu is registered and create the links at that
> time.

ok, so you can at least add my
Tested-by: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>

on the patch


Heiko
