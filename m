From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] iommu: Implement a dummy bus_set_iommu()
Date: Thu, 23 Oct 2014 10:09:54 +0200
Message-ID: <20141023080953.GA30397@ulmo>
References: <1406897113-20099-1-git-send-email-thierry.reding@gmail.com>
	<1406897113-20099-2-git-send-email-thierry.reding@gmail.com>
	<20140818165750.GE9809@8bytes.org> <20141015091043.GA13162@ulmo>
	<20141022142922.GH10074@8bytes.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1960513411381422373=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20141022142922.GH10074-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--===============1960513411381422373==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
Content-Disposition: inline


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2014 at 04:29:22PM +0200, Joerg Roedel wrote:
> On Wed, Oct 15, 2014 at 11:10:44AM +0200, Thierry Reding wrote:
> > It seems like I never got back to you on this. The reason here is that
> > for Tegra the IOMMU is part of a larger IP block. The IP block is
> > primarily a memory controller with a bunch of configuration knobs for
> > arbitration, prioritization and whatnot. A smaller part of the device
> > does the IOMMU translation. Therefore the IOMMU implementation would
> > be part of a larger driver, and having this dummy would reduce the
> > amount of #ifdefs required.
> >=20
> > bus_set_iommu() is also the only function in include/linux/iommu.h that
> > doesn't have a dummy, so it seemed like a natural thing to do.
> >=20
> > That said, I can work around this being absent for !IOMMU_API.
>=20
> Or you make this "larger driver" just depend on IOMMU_API? Otherwise you
> need the #ifdefs anyway to not carry around the iommu-ops functions in
> the driver without having the iommu core enabled, no?

I can do that using IS_ENABLED() magic, which will cause the iommu_ops
to be thrown away automatically when IOMMU_API is disabled. That allows
the driver to be compiled with full coverage and still only include the
needed parts in the final binary.

Then again, going forward it doesn't seem likely that we'll ever want to
disable IOMMU on Tegra once it's been enabled, so this isn't really a
big issue.

Thierry

--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUSLfRAAoJEN0jrNd/PrOhrpUP/2X6qYRxRULeM/oV5GDviyn5
L3jfLuRxUhnqEJtJOOGUrx6mzzGT2sj4aOc/lWcC3RAZSHEaZUGrsmcWHNIYAQCj
OHefo6H4BClO4iyiIyqOv02Dj54jDe5mahfYgon5q/4IGuIOFZFdwoz9SUXqFfso
bleiBTMxO52De6UptV9XMyD98yX6iOnLSsS6UDm3qgnxCT4wFHKVtLrq5pI5oV5e
iwbAuPOoh77C9JL6qp9Tk6ixJeqyYSN/bsz7YmmMoCVi/8BRiNW5IuuTxxH2hmw1
HUq5vjbcbsZI7QSMgWiG6aXhQndiLvCr/ekfJ5HT0lyOyDaoo06YTXZEM48C7v6R
xJfMSZVegBTWVM1Ry8PgGcNFL58JccMvElkrV07VmotSDQtPv8jrXANG7Bu0Ya32
z38cpBTHMRiW8RxisdT4qaOKN6fIZh/85iWH4jvOcDM1Da+eLeDs2ef2g7O4p60p
hX3SqG/soy+IekbyoSu4SAa6q7bYxpfce1bg3hNi+tpNM/sekhEFwPJ9nlGexYFt
bMm4ouU+SjKmOpDe+PTj8p03Ym4kU9+b8OBK2y8iNbmmCc8LJE2hXoxFxKvpyIvu
DJpmOA/Rq87FEgA48yeS9rKa62KHLP261gxpH0+m4a9E8BTMpC8g0khgLn1QOo2c
4GhpE2awi+8Ydr3dGPTr
=n6kj
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--

--===============1960513411381422373==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1960513411381422373==--
