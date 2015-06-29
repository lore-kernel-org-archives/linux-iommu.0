From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH 03/22] iommu: Propagate error in add_iommu_group
Date: Mon, 29 Jun 2015 21:55:28 +0200
Message-ID: <119636597.cTShkBsF28@diego>
References: <1432831305-11126-1-git-send-email-joro@8bytes.org>
	<7180470.n5cCZefX9d@diego> <20150629140637.GK18569@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20150629140637.GK18569-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: jroedel-l3A5Bk7waGM@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

Am Montag, 29. Juni 2015, 16:06:37 schrieb Joerg Roedel:
> On Mon, Jun 29, 2015 at 11:28:40AM +0200, Heiko St=FCbner wrote:
> > The Rockchip iommu uses bus_set_ops to set its iommu-ops for the platfo=
rm
> > bus and currently returns -ENODEV if it encounters a platform_devices t=
hat
> > does not have an iommu. As add_iommu_group ignored these returns
> > till now this worked, but of course starts to fail now.
> > =

> > All two invocations of the add_device callback ignored (or still ignore)
> > the return value so I've come with the following small patch to fix the
> > breakage that now exists in the 4.2 tree.
> > =

> > There is probably a better solution possible in the longer term, likely
> > similar to what Samsung does, but I'm not sure yet how this would work
> > with our drm device that needs an iommu mapping without having an
> > iommu (the iommus being attached to the crtc-components).
> =

> Btw, if you want to test the fix too, here is the link:
> =

> 	http://lists.linuxfoundation.org/pipermail/iommu/2015-June/013508.html

yep, works like a charm and fixes the issue. So if helpful:
Tested-by: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>


Thanks
Heiko
