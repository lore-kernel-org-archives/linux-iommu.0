From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 00/18] Clean up exposure of arch-internal code
Date: Mon, 27 Jul 2015 16:09:06 +0200
Message-ID: <20150727140905.GA16858@ulmo.nvidia.com>
References: <20150727122824.GH7557@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6485554151840307928=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20150727122824.GH7557-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--===============6485554151840307928==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2015 at 01:28:24PM +0100, Russell King - ARM Linux wrote:
> This series of patches attempts to clean up the use of architecture
> internal functions in drivers, and removes some functions from view
> in the asm/ headers.  I'm also considering whether we need to add
> some linker magic to hide symbols when building the built-in.o files.
>=20
> This was triggered by 3rd party drivers "going under the covers" of
> the DMA API and calling the dmac_*() functions directly, a practice
> which I have always refused to allow.  This also breaks module
> building (which is the big hint that they're doing something wrong.)
>=20
> However, it also came to light that various drivers are using
> __cpuc_* functions directly, which are non-portable, and is another
> instance of "going under the covers" and tinkering with what should
> be kept as architecture implementation details.
>=20
> This series addresses some of these points.  It:
>=20
> (a) moves dmac_map_area() and dmac_unmap_area() prototypes out of
>     asm/cacheflush.h and into arch/arm/mm.
> (b) provide a secure_flush() call for the Qualcomm secure monitor
>     code.
> (c) stop tegra smmu driver(s) from using __cpuc_flush_dcache_area,
>     something which necessitates additional complexity to deal with
>     the ARM vs ARM64 differences.  It should be using the DMA API.
>     However, the Tegra SMMU driver is in really bad shape, and this
>     isn't a simple conversion - it requires a lot of additional
>     fixes to bring the code up to scratch.

Out of curiosity, did you have any hardware to test this on? I've given
it a quick spin and haven't seen anything out of the ordinary. I have a
couple of nitpicks towards the end of the series, but other than that,
very nice work.

What's the plan for merging this? Should it all go in through Joerg's
tree so that potentially other driver conversions can go in on top of
this, or would you prefer to take it through the ARM tree?

> It leaves the Rockchip IOMMU driver for the time being, but that is also
> something which needs cleaning up in the same way as the Tegra SMMU
> driver.

=46rom a cursory look, MSM, OMAP and Exynos are in the same boat as well.

Thanks,
Thierry

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVtjt+AAoJEN0jrNd/PrOh928QALgW4wrmocNU4b2cJgKIVLVQ
abL7K5SZORwvXGFym/izYzZckGggnqILkDTg1wNCZL5rGHbqOV/JaZ1O4wuEND0d
DeI9o58aV6Kx4AKWu+ZL2a8uexTPmVEQPeX3hbPX0KPoBYoW3Ukl4e8KcLqHCzRz
wF+zeEW1rYbL/qlGetJItjKn08EOr+pCOm0YCjD8nr6baD4xhgn8WAX7dA/SonqW
t0Bl3xWfTSAfXmZc5vhp1/80swK65xZAuYiMWewbJedjKhMKNcruizQbXtBLGCiI
LQfvDametgHR28r5644Q65ccHJ/AJ+C7XbaUOEH7cp98zSqmV47YwdQZaWigcqxs
twXpwPMy0ZKXsywPgc1+bpYj0V5pMRLdJvcPXYdY3pJIQh6qbwDZEiYXVR/bG7pj
KUWjizkngx6DCzcJT9+xKm0RckwdjAAp4F8hCCbSkzQqgvToqCRFiEbs4KYOQ+35
eKcMOr4/TFREsAXhtvp3ZTfJnL1U/ClltlJ8gJoUV7AOFteAz8OrqQcBPU+eFRZG
5mkTviZc7q7tfvaz/JeDHxuB2bKri09Wg6lVEwk4F5vRgiw8WiMQDiP/ka+HP0H1
3pnu++nNwDijMq9YeuK1qVXokCH9sUYiKUmB8h2S/iYUhW7a59HPCse2orPOKYmL
FWH9quuYNmgtAFXI7mmS
=0bes
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--

--===============6485554151840307928==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6485554151840307928==--
