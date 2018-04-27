From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v1 3/4] iommu/tegra: gart: Constify number of GART pages
Date: Fri, 27 Apr 2018 11:49:53 +0200
Message-ID: <20180427094953.GN30388@ulmo>
References: <cover.1523304324.git.digetx@gmail.com>
	<954659be6760130f6ffd5e733db2ad58cbb8e6e4.1523304324.git.digetx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9127911692487236358=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <954659be6760130f6ffd5e733db2ad58cbb8e6e4.1523304324.git.digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


--===============9127911692487236358==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qYrsQHciA3Wqs7Iv"
Content-Disposition: inline


--qYrsQHciA3Wqs7Iv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 09, 2018 at 11:07:21PM +0300, Dmitry Osipenko wrote:
> GART has a fixed aperture size, hence the number of pages is constant.
>=20
> Signed-off-by: Dmitry Osipenko <digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/iommu/tegra-gart.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)

This doesn't really give a good explanation of why you want to do this.
While it is certainly true that the aperture is fixed in size, I can
imagine cases where somebody would want to restrict the aperture size
(perhaps there's a fixed mapping somewhere near the end of the mapping
that Linux shouldn't touch, or the GART aperture could be reduced to
simulate out of IOVA memory situations).

Without a good explanation why this is necessary I don't see why the
current code should be changed.

Thierry

--qYrsQHciA3Wqs7Iv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlri8kEACgkQ3SOs138+
s6FctRAAoUkhihlrmgwWCXP1zK7QT3+qpmdYyr1JNLF4i+0x73Qb0/wPoGu89JNV
EcjSkaOIm7SQN+pvvPQnbKVuIJYM1PDKIdC+XNEtOTkDmfx2vhWL/X4sXnth+cia
aabuCK0Q5epsaUIS7cvpKgChuOwmNeKADI3WSWZEpI2etqeCo6xIQ3FB+3rsoQCQ
/eOzmk6eKsaySKFRLLWq8SmOjw8e3HFgU8OgHU1jk2vzACgn2kN8p4r7voV20MrF
Y6xdlySnVLaKkXNNtpjCZ51eOQkD34T4T3YaIf6aNwvv5TT3tiEvPk4zoHNq0/aB
o9vFOYc8F5IApoLAx4N1KKItk2F9HuvpK2DSqlQRH6VJqUw4PL1qu+8Rq6wWhofC
p4IR0iEcCa9NpHZrF3jAJdNhrOo/3vA2aFyOJwg7UYCFZIGd4gCNa24TZxlhp2Z7
6XDnqijmQHuQcl2wtvpwdRnpBXNQ5E2dvKpbNvRUsoPeD/1G25CaDySt2ol1mx3i
ebOtpYSJ+oH/qNz+Da6qjH/agVtBYYjvpT6kA9fAr5MnF6/d/vCmt5TbdYpb4tio
Y5mrcD488qIAifg6a1r/O2xq6v+q3h9NnyN4MNbibfuwRXaT+csBb5wYL9jlFC2P
okwV9TwsbaVbh1lOZlALGKKt2HGhJYED4qKxgLd4pfUlPiCMN8w=
=x0GZ
-----END PGP SIGNATURE-----

--qYrsQHciA3Wqs7Iv--

--===============9127911692487236358==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9127911692487236358==--
