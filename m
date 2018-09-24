From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4 17/20] iommu/tegra: gart: Prepend error/debug messages
	with "GART:"
Date: Mon, 24 Sep 2018 12:57:14 +0200
Message-ID: <20180924105714.GN21032@ulmo>
References: <20180924004153.8232-1-digetx@gmail.com>
	<20180924004153.8232-18-digetx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7554180137821373611=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180924004153.8232-18-digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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


--===============7554180137821373611==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="b/Q3JWIUAuLE0ZFy"
Content-Disposition: inline


--b/Q3JWIUAuLE0ZFy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 24, 2018 at 03:41:50AM +0300, Dmitry Osipenko wrote:
> GART became a part of Memory Controller, hence now the drivers device
> is Memory Controller and not GART. As a result all printed messages are
> prepended with the "tegra-mc 7000f000.memory-controller:", so let's
> prepend GART's messages with "GART:" in order to differentiate them
> from the MC.
>=20
> Signed-off-by: Dmitry Osipenko <digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/iommu/tegra-gart.c | 36 ++++++++++++++++++------------------
>  1 file changed, 18 insertions(+), 18 deletions(-)

There's a macro called dev_fmt (similar to pr_fmt) to do this for dev_*
printers. Also I think this would be more readable if the prefix was
"gart: " rather than "GART: ". At least from my personal experience I
get easily distracted by all-caps words in logs, because they usually
indicate something that requires immediate attention. I think it's
better to leave that up to higher level mechanisms, such as the color
keying of messages based on level by tools like dmesg.

Thierry

--b/Q3JWIUAuLE0ZFy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAluowwoACgkQ3SOs138+
s6F4Ww/+OYHsX2jWHpA4boVmo7Hho/Wg6+os+ELy0AU2+wUZFLqOPJxotod6Xa47
/j4fX9/3klWk/r1K3pgnfzgVxROcR3uYFTbt7gQL14GY0Q7URN/w4ne1hfMSFuQW
ycVuApcIJa75YmHPdWx/CfWla16Yg+Fv1024IWMyEVDMYpQMqShecWEdRkQpqXP3
UigSgEhpMZIinud0IiwsA4vcyJySUV4WSuJ9YjAlJnc0DsH0rZvmCM3oPh0rFpvO
MAqiNW+A3TxCM/LOwZ73YdCp6rYdypVLiljU4BCc03eLaoXbB1KdM5Z0itOSEQOp
F8ldbtgrvqoJf7YGXGn7WanKepRqJvoph09x2D2FScxjl90Wh/Ej7msnt6eDpzt9
pEPSHHcoxlemS2b3+j+PwSPLw4/3hervHNaobnxbu5cceqBPhkiZsUaVvJtJ+1BC
3a9VOO6wp07tNMbTANyo9WIfxfGflX+h1pH24c05XieGi/3ywHqnimxiHPk0/LNQ
6bTgHS3Jlvvd9ZnzsB2u7i9IY1mSkWOlucKf0Zdoemr/q5WpdyYCi0MXRPxtuQ66
6Af5jRTZbyiU0pf0RggWJPIN0XQCzu5HCG62NKvcvXu5e/vpPULLJ95D8pm8wI7j
4S9wcbXCczVhYCvq5JLNLSaSpgyG/xSdXeRzXw3RDRxiLtM2ie0=
=tygZ
-----END PGP SIGNATURE-----

--b/Q3JWIUAuLE0ZFy--

--===============7554180137821373611==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7554180137821373611==--
