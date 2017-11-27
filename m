From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 0/2] iommu/tegra: Add IOMMU group support
Date: Mon, 27 Nov 2017 10:53:43 +0100
Message-ID: <20171127095343.GA21584@ulmo>
References: <20171127095055.21486-1-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="M9NhX3UHpAaciwkO"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171127095055.21486-1-thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Mikko Perttunen <mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 27, 2017 at 10:50:53AM +0100, Thierry Reding wrote:
> From: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>=20
> Hi Joerg,
>=20
> Both patches in this series are built-time dependent and therefore it
> would be easiest if they went in via the same tree (either the IOMMU
> tree, or the Tegra tree with your Acked-by on patch 1). Alternatively,
> I could put patch two in a separate branch and provide a stable tag for
> you to pull in, in order to resolve the dependency.
>=20
> Do you have any preference?
>=20
> Thierry
>=20
> Thierry Reding (2):
>   iommu/tegra: Allow devices to be grouped
>   memory: tegra: Create SMMU display groups

I just realized that these are actually in the wrong order. The second
patch adds the data fields that the first patch uses. Depending on which
merge strategy you prefer I can reorder when applying or resend in the
correct order.

Thierry

--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlob4KMACgkQ3SOs138+
s6GraRAAnrbmW5m9XDNXSsbhAIqJoH9wV23F4qAiIeep8sQYlOcjP7VsDB8yWwzW
oZDjQYaQUclf0hiMvQv7AtpboT0ubAVn7SkeEylWQnwEx/sGRleFvT9r7m2h60eo
6xYwjHWzZSdfYR1oTul/aGHxiJ1nZCSwHJZENqidHVdB8oi29buwAQ7kUGuHq6Uy
6V1D1EaV/kJlr/zhVOVSo5olZb7ipJ9lPrqHmvsl2ETlSsfdRwJCp889TPBqZDf1
UKr38cgv+1tY11+TgqWASltt1MlEZTptCdxkYRJTuD7ZJFtFdd47MxAbaIfjzTl7
DLekrAKkoPExOenCQYgDevIOeN7afXE2RhqIkCpLNel7AbUg+6xNb/oxhHpa69zX
tAGF/WW+PThZYd0959mnn3WE9H6/rcsA0uwnkqikIQSno2Io4U9fPqpn3BqzdjQn
UsctnZgBKqLT6LThyjPdOWB2RIV2w1t1YP7h9UN6MTF+XWc/nCQ/yzelMoZ1fdC/
VkNDvgRbbrhb96xUrtcHu8tv0L1iNtgUNThwjUFG1sR6DisDkotCpjIYPx50p3iT
c46A8UGST6GXTA0BSD+IWKSBtSbI41a1nIv4n/6O0pYgd8sWMjLdLDCGnromeiMv
inpijGgXz+Rtq2b9mgq5yVPYoF/5TAFgwzpmMndLcUKWb8T9004=
=h+/X
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--
