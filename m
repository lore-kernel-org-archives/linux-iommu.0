From: Ben Hutchings <ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org>
Subject: Re: [PATCH 3.2] iommu/amd: Initialize device table after dma_ops
Date: Sun, 17 Mar 2013 03:42:38 +0000
Message-ID: <1363491758.3937.239.camel@deadeye.wl.decadent.org.uk>
References: <1362087590.2822.44.camel@lorien2>
	<1362265235.3768.156.camel@deadeye.wl.decadent.org.uk>
	<20130303225828.GA22602@8bytes.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7366499088637387161=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20130303225828.GA22602-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, stable <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, shuahkhan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, shuah.khan-VXdhtT5mjnY@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--===============7366499088637387161==
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-WPbVFvloCwtPcxK4NBQz"


--=-WPbVFvloCwtPcxK4NBQz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2013-03-03 at 23:58 +0100, Joerg Roedel wrote:
> Hi Ben,
>=20
> On Sat, Mar 02, 2013 at 11:00:35PM +0000, Ben Hutchings wrote:
> > I'm not convinced about this backport, because the order of
> > initialisation already changed a lot after 3.2 and before the upstream
> > commit.  So I'm going to wait for Joerg to confirm that this makes sens=
e
> > before adding it to the patch queue.
>=20
> The patch looks good, it fixes a race condition during amd_iommu
> initialization. I'll also gave the backport a test to be sure it
> doesn't break anything.

Applied, thanks all.

Ben.

--=20
Ben Hutchings
Usenet is essentially a HUGE group of people passing notes in class.
                      - Rachel Kadel, `A Quick Guide to Newsgroup Etiquette=
'

--=-WPbVFvloCwtPcxK4NBQz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIVAwUAUUU7rue/yOyVhhEJAQrSfg/9HdiIdudy3NnPDqaENUElXOipOIYN3VIj
9aQLvrGXAsBM7yGT5StWZupYMCXUpkpXveGMV1v7Vy1ncnXb37wf9a98F8B6mSsU
UWNVSN8fQaz4J++y8sVIiZYiGEqF8cshSvLLVpHTozQrtCZ0JxijAeazhLObfNTz
g2IAKINJ15TBDhn6f3snZxAJO3g3wzW/7aBpjlEztkTvm4zOVziWmuVhhDLTyZh5
3DDgMvgtoQ2mW9x4UG0vefp3dwQ5VrfOtFcw/e7J47q6aotseIRQ1HkZd4xvX6Pt
hYnQLdWS58IfAnv0hkaO8DJPqyiXGOE8Xq32uNwIdzCuRYqJyh4f6FhDmOi2O3gB
xft4+UBkRPoJr4emEmcZWPoHxjN/k2bKALtW/BRuNQsvOkojlwBDu0bswVhXrR3y
S1BT3elILYI+ZhLkEeyB1K+GabSEUDE2SWhM4Kq4hs/T0HalIheocUeavEYK0X+4
8ChoeDNAD2vi8nCsEZvssvznk1KTBrmvfv/Mh3rAV2kUeUdDeMFmliGBdqw5kl8G
QqDsDqurHW24EtwFrFP01HOVTfYzp8qEfb29iTbDKpVNi4kJdlT5QESiT2oWG1du
tFHePFmMvkjYXnxaxypxObZ4C4mYz1bqd3JIxUkIuwzGHnRabNn8JAUChCeCWeRg
bN72eDYl5YQ=
=MrJG
-----END PGP SIGNATURE-----

--=-WPbVFvloCwtPcxK4NBQz--

--===============7366499088637387161==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7366499088637387161==--
