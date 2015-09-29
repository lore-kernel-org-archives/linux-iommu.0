From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC PATCH 2/3] memory: tegra: add TLB cache line size
Date: Tue, 29 Sep 2015 11:43:48 +0200
Message-ID: <20150929094348.GF9460@ulmo.nvidia.com>
References: <1443504379-31841-1-git-send-email-tfiga@chromium.org>
	<1443504379-31841-3-git-send-email-tfiga@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1457552376458918911=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1443504379-31841-3-git-send-email-tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Olav Haugan <ohaugan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Mikko Perttunen <mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Nicolas Iooss <nicolas.iooss_linux-oWGTIYur0i8@public.gmane.org>, Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vince Hsu <vince.h-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


--===============1457552376458918911==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ChQOR20MqfxkMJg9"
Content-Disposition: inline


--ChQOR20MqfxkMJg9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2015 at 02:25:25PM +0900, Tomasz Figa wrote:
> From: Vince Hsu <vince.h-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>=20
> This patch adds SMMU line size to Tegra SoC data struct to enable SMMU
> driver to use this knowledge in code added by further patch.

I think the line size should either be added in the same patch that adds
the feature which uses it, or the commit message should describe what
purpose it will be used for. As it is this commit message leaves too
many questions unanswered.

> Also add the missing TLB line number for Tegra124.
>=20
> Signed-off-by: Vince Hsu <vince.h-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> [tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org: Rebased, revised commit message.]
> Signed-off-by: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>

> diff --git a/drivers/memory/tegra/tegra124.c b/drivers/memory/tegra/tegra=
124.c
> index 21e7255..ff12487 100644
> --- a/drivers/memory/tegra/tegra124.c
> +++ b/drivers/memory/tegra/tegra124.c
> @@ -1007,6 +1007,8 @@ static const struct tegra_smmu_soc tegra124_smmu_so=
c =3D {
>  	.num_swgroups =3D ARRAY_SIZE(tegra124_swgroups),
>  	.supports_round_robin_arbitration =3D true,
>  	.supports_request_limit =3D true,
> +	.num_tlb_lines =3D 32,
> +	.tlb_line_size =3D 32,
>  	.num_asids =3D 128,
>  };

Oh my... try to fix one platform and break another. Fortunately it seems
like Tegra124 copes much better without TLB because I'm not seeing any
buffer underruns or similar on Tegra124 without this fix.

Anyway, this change is completely unrelated and fixes a regression (even
though it might not be noticeable in many use-cases), so can you please
split it out into a separate patch and add a

	Fixes: 11cec15bf3fb ("iommu/tegra-smmu: Parameterize number of TLB lines")

line to it? That patch went into v4.3-rc1 and it'd be nice to get this
fix in before the final v4.3. Feel free to add my Acked-by/Reviewed-by
as well.

Thierry

--ChQOR20MqfxkMJg9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWCl1SAAoJEN0jrNd/PrOhJYAQAJtRJJqkQT9W/BlL1XOvYkky
E/PIZXxB4+MwESMUuKe3vhUyFEgsJVNSSjmOBOFULJ4bZ5ApxOq6bpEtPHgRuSlm
yY5mB63OVSffO2HPvRFmdWSqLQbjXaU/spPwIRBVhAlB/gMBwfFdNuQ6PGY+Jo2m
NAzmNksFEUPhMH2QzJn7X/eJlHvg4uDAclTpaZfJNNE4LEmAQzffsaaafYi/rSLu
kNk0R+Ai/Zd0OS+uMsdCQGY7MG+JX/XVjdut4VEfnc7VyLlZgsNT9opHake8oMyH
Q3SJavcCmt4K19Zrc0c5AjL3tBM0uSah34I7fhbpDKk68uhHKXYj4yUUXqVHR9uU
HA2IvB/wPidPUN+Tvtw5FXsyv63egQFq00OjeuOwjpe8oPrW/Hq/s3Vyn4MSy59u
0Bb/jPRQHCa7XklwlMCA3PtRUI2gBykhsfwk93Vwf/PXNwrtnkX2VBFgWu0VeUGs
IOChtxyRlTTFGIPEDpNAYnAEgxSVa6p8Oc4ffGcK0szqJWN2JsXkgKZkkuQhQwOa
wOEAVpqWJOy+pTdpr8450XtEOlxYGXEGq7YzfJCCE/gqnu4ErDuerEq1muE1+DGd
CniicnkRmyrbxS/THSHWeDALrQuTEZnn540yMukbuU6rbwgqfip9FVeesxbXm7NR
bPPbwNiaY7QvL1+SSi4K
=lbRb
-----END PGP SIGNATURE-----

--ChQOR20MqfxkMJg9--

--===============1457552376458918911==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1457552376458918911==--
