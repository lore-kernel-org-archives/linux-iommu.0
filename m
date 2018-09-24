From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4 15/20] iommu/tegra: gart: Allow only one active domain
	at a time
Date: Mon, 24 Sep 2018 12:50:43 +0200
Message-ID: <20180924105043.GL21032@ulmo>
References: <20180924004153.8232-1-digetx@gmail.com>
	<20180924004153.8232-16-digetx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4493669928481835760=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180924004153.8232-16-digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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


--===============4493669928481835760==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="00hq2S6J2Jlg6EbK"
Content-Disposition: inline


--00hq2S6J2Jlg6EbK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 24, 2018 at 03:41:48AM +0300, Dmitry Osipenko wrote:
> GART has a single address space that is shared by all devices, hence only
> one domain could be active at a time.
>=20
> Signed-off-by: Dmitry Osipenko <digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/iommu/tegra-gart.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
> index 1d45b023adea..9f7d3afb686f 100644
> --- a/drivers/iommu/tegra-gart.c
> +++ b/drivers/iommu/tegra-gart.c
> @@ -55,6 +55,7 @@ struct gart_device {
>  	spinlock_t		pte_lock;	/* for pagetable */
>  	struct list_head	client;
>  	spinlock_t		client_lock;	/* for client list */
> +	struct iommu_domain	*active_domain;	/* current active domain */

The active_ prefix seems a little unnecessary here, but either way:

Acked-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

--00hq2S6J2Jlg6EbK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAluowYMACgkQ3SOs138+
s6EwKA//YnbjzmDTEdpchLy7vm5PcbIN2vQ15t394H/pBAqUoUWcqcziaBlJC3a9
y2Exp0e9z/8thAcITQSn6jq+K1FHCEjtiBZHqZzgOqNQozqk+QaUby4SvOVueGA3
nfwZVkFpSjcac6JxXtgIkmcaIW1MB3JIZIMMQC7sCW04BINHoKGpcxhCWLRZ5Ma4
schH+VQ6YWgmyfjDLzHcBqJcJeQGbOs41RO2GDCCBF/xTvtUjiH0fqCtNIM8yQhk
H7UMBP/xOCp+RnrpAm8wuCupFdkceKbd6EIVzxgz+4JWAdiMefAP38PB8B5ZjJe3
aDyL7ZYUjr9e8F7mpHRVPkHah8RW3TsxEuc09q3kAYAgSPGown0geAGFgqIsEjQY
vJPQhR4slYbihcac8Oun/dKDUStg/+pNurDZyemmQ97amjXi66RA2X2234LCSOyH
6CukFlaHrIYjtwctHmgceT8gsrQFGJuy4Y45fBtzC7cN1IEYAwkA1lPbb7uYU7w4
qs6dDdR3IN7xS+vUSKEQV5ch2Z/WYqnEf/v2CZHVAqVHmd9OWAMRL1akLqvkVNxd
qOtELT14EDXZdnZHo8Bs7/LYb7k2eT2+HBoUMKeuR56dfV/LaQKV60kf2D+KYnWT
P2TOOI80G2Te1oPXjVmtY3YkYqPWZ0AhcSsJc7SvaQAyJL8fK4Y=
=P3Vx
-----END PGP SIGNATURE-----

--00hq2S6J2Jlg6EbK--

--===============4493669928481835760==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4493669928481835760==--
