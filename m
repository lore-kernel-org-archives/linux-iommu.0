From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4 16/20] iommu/tegra: gart: Don't use managed resources
Date: Tue, 25 Sep 2018 12:03:30 +0200
Message-ID: <20180925100330.GF7097@ulmo>
References: <20180924004153.8232-1-digetx@gmail.com>
	<20180924004153.8232-17-digetx@gmail.com>
	<20180924105246.GM21032@ulmo>
	<a9e2943b-1139-8838-5440-bd6cf55e9a55@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0129261916438940506=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <a9e2943b-1139-8838-5440-bd6cf55e9a55-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Dmitry Osipenko <digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


--===============0129261916438940506==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0rSojgWGcpz+ezC3"
Content-Disposition: inline


--0rSojgWGcpz+ezC3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 24, 2018 at 09:57:10PM +0300, Dmitry Osipenko wrote:
> On 9/24/18 1:52 PM, Thierry Reding wrote:
> > On Mon, Sep 24, 2018 at 03:41:49AM +0300, Dmitry Osipenko wrote:
> >> GART is a part of the Memory Controller driver that is always built-in,
> >> hence there is no benefit from the use of managed resources.
> >>
> >> Signed-off-by: Dmitry Osipenko <digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> >> ---
> >>  drivers/iommu/tegra-gart.c | 12 +++++++-----
> >>  1 file changed, 7 insertions(+), 5 deletions(-)
> >=20
> > One benefit would be cleanup on probe error. Also, we may eventually
> > want to make even the memory controller driver buildable as a module.
>=20
> Please, let's keep that patch as is and re-introduce devm once it will
> become really relevant.

Alright, fine with me.

Thierry

--0rSojgWGcpz+ezC3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAluqB/IACgkQ3SOs138+
s6HNoA/8CFbeEPyFp1VE67Jzl/fEMLQ6zRfF+06HOGCAeFnQ0qqvVGle6Il1QH1i
N9HYw6xE11x2NZHngX+kYMw+b7B0cF4nT3CXLDa0GXTf4ZzqWkmDOwGPKaPMUl8e
MCC2TEf6TIJl0SJy6X66Zoxc4wFof3WIUT2XzxlRR7vPwiRJj4NLyVqH2PEkxyQz
eLhRE9ZNTQeA5GGUtizPZ2mePDMmK9r6wFRwfitoz1no0JuRVJtsVfdCcCa6zbhR
dni5cyjGWiUDCxTS4OaUesNkTN8uYlVVZYGiglVDrgiz7ztA26Wp6JSZp9oaPDz2
9LmA30NgzE3ja6tjd+vlBFc+k0LBwWpmphjG8kQWMaos+PoJypoaFu560aS7oF+r
kTcBh7RLJo1JRu+jLx8P/iYEWth4/ZLkCTPqi7foJPwJb+qu7J0gUuFW+29UnX/U
bDE2z/pRwggUCGpfKlqXz+EdqZ2+tgYwRaeLgrPmKs7HSHsqnzlV0jlkfaKABoP+
Od2ftt1kkAobq0vUTwGLKKpWVJcQSxCX6HMkFvC7TTL1ntMZVSK1SqomA9geFo2k
0YbywVOL6LBlyElwpWZ+oyemLb9IH5POnHnl+gCxYAqy3oIJg87+UTuMjnbHI3a9
xRxdJhFy0jOLmtSlQTq9Q0HmKC+VfD+4kDOOPUFwV8lFDFCr3a4=
=fmqX
-----END PGP SIGNATURE-----

--0rSojgWGcpz+ezC3--

--===============0129261916438940506==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0129261916438940506==--
