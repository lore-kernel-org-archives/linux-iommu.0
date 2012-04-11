From: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Subject: Re: [RFC 4/4] drm: Add NVIDIA Tegra support
Date: Wed, 11 Apr 2012 17:00:56 +0200
Message-ID: <20120411150056.GA20811@avionic-0098.adnet.avionic-design.de>
References: <1334146230-1795-1-git-send-email-thierry.reding@avionic-design.de>
	<1334146230-1795-5-git-send-email-thierry.reding@avionic-design.de>
	<20120411124810.GK4296@phenom.ffwll.local>
	<20120411132326.GD27337@avionic-0098.adnet.avionic-design.de>
	<20120411133512.GL4296@phenom.ffwll.local>
	<20120411141108.GI27337@avionic-0098.adnet.avionic-design.de>
	<20120411143456.GM4296@phenom.ffwll.local>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2608031697436496576=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20120411143456.GM4296-dv86pmgwkMBes7Z6vYuT8azUEOm+Xw19@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Jon Mayo <jmayo-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--===============2608031697436496576==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Daniel Vetter wrote:
> On Wed, Apr 11, 2012 at 04:11:08PM +0200, Thierry Reding wrote:
> > * Daniel Vetter wrote:
> > > On Wed, Apr 11, 2012 at 03:23:26PM +0200, Thierry Reding wrote:
> > > > * Daniel Vetter wrote:
> > > > > On Wed, Apr 11, 2012 at 02:10:30PM +0200, Thierry Reding wrote:
> > > > > > This commit adds a very basic DRM driver for NVIDIA Tegra SoCs.=
 It
> > > > > > currently has rudimentary GEM support and can run a console on =
the
> > > > > > framebuffer as well as X using the xf86-video-modesetting drive=
r.
> > > > > > Only the RGB output is supported. Quite a lot of things still n=
eed
> > > > > > to be worked out and there is a lot of room for cleanup.
> > > > >=20
> > > > > Indeed, after a quick look there are tons of functions that are j=
ust stubs
> > > > > ;-) One thing I wonder though is why you directly use the iommu a=
pi and
> > > > > not wrap it up into dma_map? Is arm infrastructure just not there=
 yet or
> > > > > do you plan to tightly integrate the tegra drm with the iommu (e.=
g. for
> > > > > process space switching or similarly funky stuff)?
> > > >=20
> > > > I'm not sure I know what you are referring to. Looking for all user=
s of
> > > > iommu_map() doesn't turn up anything related to dma_map. Can you po=
int me in
> > > > the right direction?
> > >=20
> > > Well, you use the iommu api to map/unmap memory into the iommu for te=
gra,
> > > whereas usually device drivers just use the dma api to do that. The u=
sual
> > > interface is dma_map_sg/dma_unmap_sg, but there are quite a few varia=
nts
> > > around. I'm just wondering why this you've choosen this.
> >=20
> > I don't think this works on ARM. Maybe I'm not seeing the whole picture=
 but
> > judging by a quick look through the kernel tree there aren't any users =
that
> > map DMA memory through an IOMMU.
> >=20
> > Maybe your question is answered by my reply to Alan's comment. The mapp=
ing
> > is actually done to get a linear view for the display controller which
> > doesn't support SG transfers. The kernel and user-space already have vi=
rtual
> > linear buffers.
>=20
> Hm, in that case it looks like your iommu works more like the gtt on intel
> chips and less like the iommu on intel platforms (which we access through
> the dma_map api).

Yes, it's very much like the GTT on Intel chips. In fact I've been using the
gma500 driver as a source for inspiration. Wikipedia confirms that GTT and
GART are synonymous.

> I wonder whether that will end up in some layering fun together with
> dma_buf, which conceptually is at the same level as the dma api, which
> usually uses an underlying iommu exposed with the iommu api you're using.

That's odd. The only users of the IOMMU API that I can find in the kernel
tree are in drivers/remoteproc and drivers/media/video/omap3isp. And omap3i=
sp
doesn't do any actual mapping at a quick glance. Can you point me to where
this is hooked up with the Intel IOMMU?

Thierry

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAk+FnKgACgkQZ+BJyKLjJp+hKQCgon1btnMjTEIqjJzmf8KuR5eX
UBQAoJSPE1x5ZXFug3E7WhTiIj2ODr1d
=Wfsa
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--

--===============2608031697436496576==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============2608031697436496576==--
