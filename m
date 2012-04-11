From: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Subject: Re: [RFC 4/4] drm: Add NVIDIA Tegra support
Date: Wed, 11 Apr 2012 17:06:03 +0200
Message-ID: <20120411150603.GC20811@avionic-0098.adnet.avionic-design.de>
References: <1334146230-1795-1-git-send-email-thierry.reding@avionic-design.de>
 <1334146230-1795-5-git-send-email-thierry.reding@avionic-design.de>
 <20120411124810.GK4296@phenom.ffwll.local>
 <20120411132326.GD27337@avionic-0098.adnet.avionic-design.de>
 <20120411133512.GL4296@phenom.ffwll.local>
 <20120411141108.GI27337@avionic-0098.adnet.avionic-design.de>
 <20120411155237.24233afc@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3639873177463227766=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20120411155237.24233afc-38n7/U1jhRXW96NNrWNlrekiAK3p4hvP@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Cc: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, Jon Mayo <jmayo-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


--===============3639873177463227766==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="c3bfwLpm8qysLVxt"
Content-Disposition: inline


--c3bfwLpm8qysLVxt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Alan Cox wrote:
> > Maybe your question is answered by my reply to Alan's comment. The mapp=
ing
> > is actually done to get a linear view for the display controller which
> > doesn't support SG transfers. The kernel and user-space already have vi=
rtual
> > linear buffers.
>=20
> The framebuffer currently needs a physically contiguous map for the
> console devices. Well you could vmap them but that is pretty hideous on a
> 32bit platform with 32bit 1080p display plugged into it!

Heh, vmap() is exactly what I do. =3D) Would you mind explaining why exactl=
y it
is hideous?

I'll have to investigate what an appropriate alternative would look like.

Thierry

--c3bfwLpm8qysLVxt
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAk+FndsACgkQZ+BJyKLjJp85hwCfeZ5F3Cjoq694kmX7N+libe9l
vi4AoKpPchBTK2lPcKWpMgHZq9ySNf/d
=2Cwv
-----END PGP SIGNATURE-----

--c3bfwLpm8qysLVxt--

--===============3639873177463227766==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============3639873177463227766==--
