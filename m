From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/5] iommu/tegra-smmu: Fix domain_alloc
Date: Thu, 14 Feb 2019 12:12:21 +0100
Message-ID: <20190214111221.GA10927@ulmo>
References: <1547671814-30088-1-git-send-email-navneetk@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4361933613648371829=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1547671814-30088-1-git-send-email-navneetk-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Navneet Kumar <navneetk-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--===============4361933613648371829==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ReaqsoxgOBHFXBhH"
Content-Disposition: inline


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 16, 2019 at 12:50:10PM -0800, Navneet Kumar wrote:
> * Allocate dma iova cookie for a domain while adding dma iommu
> devices.
> * Perform a stricter check for domain type parameter.
>=20
> Signed-off-by: Navneet Kumar <navneetk-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/iommu/tegra-smmu.c | 43 +++++++++++++++++++++++++++-------------=
---
>  1 file changed, 27 insertions(+), 16 deletions(-)

I just gave this a quick spin because I was investigating how we could
potentially make use of the DMA API instead of the IOMMU API directly in
Tegra DRM. We currently rely on the fact that the Tegra SMMU driver only
supports unmanaged domains. Once we start supporting DMA domains all the
automatic machinery kicks in and there's lots of SMMU faults. I think at
least partially those faults point out bugs we currently have in the
code. From the looks of it, the display controller is running during
boot and happily fetching from whatever address it was configured with
in the bootloader, and when we enable the ASID for the display
controller as part of the DMA/IOMMU setup, the fetches from the display
controller will be accessing IOV addresses that don't have a mapping.

One one hand that's a good thing because it points out existing
weaknesses, but then it also means that we can't merge this series
because it causes bad regressions.

I also see failures from the GPU with this applied, which I think stem
=66rom the fact that we're now transparently mapping allocations through
the SMMU without the Nouveau driver knowing that and setting the
appropriate bit when addressing memory. Or it could come from the SMMU
code in Nouveau trying to map an already mapped buffer, so effectively
creating an IOVA mapping to an address that is already a IOV address
rather than a physical address.

So I think before we can go ahead with this series we have a lot of
janitorial work to do first so that this won't cause any regressions
when applied.

Thierry

--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxlTRMACgkQ3SOs138+
s6HUMxAAvIGmvJBhDZoAcnBNy4feVd9cYkdK8q3P+VnZaUlkp27o153CvOvacqtS
kquC+6fJemkKWjYDEyRzw7YQq4qcyFC782eVE52g8UO411YCDtT+KHei+9t4NO1B
nONmucjJxAMis89euhYHTsoocfbpe1RrCIf6rQKhIi+JD3ylZhSTk/6bWmBC/fwd
ZPW4lNmZJwJL3fjMXlxvj7zEYYFZdMxSNR6s3fSFNEmynder4+njvBprPzbX9BiI
UqP2iD2o6DbpdBt6OYANvI6E7VMFHmUV6yMb/FbftcX6apSRjA6Wb8CnRSMloQzB
w/o1zK6IL0Mr1jdcWhke3cc9ZSREZp1gQQqcn5hYnP8gZVK4raXsrd8UhgRbapfq
JzSc7X0lBcE6XLy5HabUQ7ywAs8yrtNw1wvlPLP+oDEgJpLk8l/YvZX7lv0t86EG
Q4YmtAmHKIvawb98BIfkN9PSlP6rTvn6kD460NC5QQv+5kopALhbtcN9r+4N5GF0
fyxMUYuS+n/DSCTrTsgzbTDzOOj1F1vUMwSaiD7L66bFqQVxSu4xOYmHg7dXCMR4
vecOjuaNIZjj8Yixg+WOaNh0LZVcSF+HQ+VFMFGdcSyvulgXUH4/WRlcyFhVNM45
JwdB+k32kmaoioVYda9lYzFF1c6KxPmywCecvptYXKESXdq6e/c=
=LYi4
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--

--===============4361933613648371829==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4361933613648371829==--
