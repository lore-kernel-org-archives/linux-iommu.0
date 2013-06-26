From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 03/23] ARM: dt: tegra30: iommu: Add
 "nvidia,memory-clients"
Date: Wed, 26 Jun 2013 12:33:54 +0200
Message-ID: <20130626103354.GH27083@manwe>
References: <1372238906-9346-4-git-send-email-hdoyu@nvidia.com>
 <20130626101816.GE27083@manwe>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ISKrrfpKsPiF35CV"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130626101816.GE27083@manwe>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--ISKrrfpKsPiF35CV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2013 at 12:18:17PM +0200, Thierry Reding wrote:
> On Wed, Jun 26, 2013 at 12:28:06PM +0300, Hiroshi Doyu wrote:
> [...]
> > diff --git a/Documentation/devicetree/bindings/iommu/nvidia,tegra30-smm=
u.txt b/Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt
> [...]
> > @@ -23,3 +24,13 @@ Example:
> >  		nvidia,swgroups =3D <0x00000000 0x000779ff>;
> >  		nvidia,ahb =3D <&ahb>;
> >  	};
> > +
> > +	host1x {
> > +		compatible =3D "nvidia,tegra30-host1x", "simple-bus";
> > +		nvidia,memory-clients =3D <SWGID_HC>;
>=20
> And this could use the SWGID(HC) to match up with how GPIOs are
> referenced in the DTS files.

Scratch that. SWGID() yields a mask for the corresponding swgroup so
it's not the same thing.

Thierry

--ISKrrfpKsPiF35CV
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRysOSAAoJEN0jrNd/PrOhdnUP/1VxUWesJx3hTUampPW/gUDT
lwmS+ltwKWS/Lz9KqNB3K7GDy+/zKR8BohMvokvG79wrfp75mx5dkin8jYt6gpbq
cvx2ZyNsmYXE9GC1JMGZu51nifYGCXgLSc5AhvTG6fCittOXN/iWYmXFH4YyOUlG
6/CcpUP3J/I6/yaPnizwZrgSfuFMazNMpc+kZ/ApGwNJadgNn8AW/+/r/4Dn8GKr
PRV2zoR57BTWXsA5ltOosJX4a+RM+nq6abUWyQdq1mxzFHjvzyrdduxbIdCoIcPX
gZq7QwMIE7J867fzNV+14+w3Lj2+ITQHzpDly2YlmcLEF76JyfQ93zMfrmYn4p5u
WkJcypfZkD0cyd9Pqk+DldRrlGUl7Yr+zj3RoSZahEmOBl4Z//daIE4xIkQzy3GO
ViHXdBSfYGCGgY4CJmI58RPEZDAuT8JFc3RS8XLPS7PtAXbp9vsLBBihGiyIg2fe
q6gB+/eRqpOoyLASJKjcXZGBLAchE0hKMErFczJl8bbIENQxlFlzy/pTkkcwVrQw
e6mpTd9R5cbGYtwS4RbXW02DllF/v6jHSoEmCVRy7Xu6fm/KwLJsOwMqbb9XMZzI
3oyJwRpPjGn+S39BZMJlW2j4DHmIgtZZHK/gtD/fT5sUnwkDkhd3tvQ2MuKd4o+1
gdEtgX9GP3IiKyQCJFQt
=dqiB
-----END PGP SIGNATURE-----

--ISKrrfpKsPiF35CV--
