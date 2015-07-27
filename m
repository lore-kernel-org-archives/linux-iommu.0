From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 17/18] iommu: tegra-smmu: more cleanups
Date: Mon, 27 Jul 2015 16:12:07 +0200
Message-ID: <20150727141206.GC16858@ulmo.nvidia.com>
References: <20150727122824.GH7557@n2100.arm.linux.org.uk>
	<E1ZJhXo-0004Ce-Hq@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2029029019791857532=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <E1ZJhXo-0004Ce-Hq-eh5Bv4kxaXIANfyc6IWni62ZND6+EDdj@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--===============2029029019791857532==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Qbvjkv9qwOGw/5Fx"
Content-Disposition: inline


--Qbvjkv9qwOGw/5Fx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 27, 2015 at 01:30:12PM +0100, Russell King wrote:
> Signed-off-by: Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
> ---
>  drivers/iommu/tegra-smmu.c | 49 ++++++++++++++++++++++++++--------------------
>  1 file changed, 28 insertions(+), 21 deletions(-)

Same here.

Thierry

--Qbvjkv9qwOGw/5Fx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVtjw2AAoJEN0jrNd/PrOhA+EQAKRqq1f6372jDIz4o/Gv9OEg
o/02gCgF8XpG8lU0Uf4HTDTlwhUXiJJ5L/TJD1cgFzbt8/qx28Fk2gmzmvxg+NHy
WllvgQ22eyCUO4vyxiljfljLQtxXiK89TuTBkBsFmMc56TR+M4Pv4p7cbW9JgVZH
bZxq3ckidG+O7pCljvUGR9TDJr5dBKss99QKK00rPJ8IehpwYgy9Z/DPTimJo7hy
2s430MgK3Y/OYbPLqly6rcYk2cu120OBZeEcAj70pzT2fYVZiyIyYiOP25SMdTsJ
PS0L32u3FDcf8EeveGsGxGPBdRgcFekUHtMM0l1AZ0TUkw3K5cpzf79rA/It3hJu
tlGMWJeJPisCEAiyXkX8xk3xi/xoEJRLhlepjvZ1vS4ywdAIFljyppg1jgIGqq8L
zYWS3pc136j0j8UPsgQQhAu91mbRVnOuLMC5BCvK7RddtjAodorAzFLosz9wv2NB
35ddjR3u56S9g9VF1zG3CtYfp9LuCFHhLsFdlf+Cf2etEfy3EVY58kx/YUkR9o1R
IzC28hP1h6Gvfc/jf+sfuTC/3HVORnlNKTH38FQPYRDzAD94yrnqmhfR+r3AqC54
Eespg9Id/l+M8q4ZtkiP0IZbxu30RJMevuOezjWkfRWPDHeAvrtYbkqmc5Mwbs5y
i7cEdazDwjm+eS0q41Jy
=4R70
-----END PGP SIGNATURE-----

--Qbvjkv9qwOGw/5Fx--

--===============2029029019791857532==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2029029019791857532==--
