From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 00/16 v2] iommu: Move domain allocation into drivers
Date: Fri, 27 Mar 2015 12:03:43 +0100
Message-ID: <20150327110341.GC5440@ulmo.nvidia.com>
References: <1427373799-18662-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hOcCNbCCxyk/YU74"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1427373799-18662-1-git-send-email-joro@8bytes.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, Will Deacon <will.deacon@arm.com>, Kukjin Kim <kgene@kernel.org>, David Woodhouse <dwmw2@infradead.org>, Heiko Stuebner <heiko@sntech.de>, Hiroshi Doyu <hdoyu@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Alexandre Courbot <gnurou@gmail.com>, Alex Williamson <alex.williamson@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Yingjoe Chen <yingjoe.chen@mediatek.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-tegra@vger.kernel.org, jroedel@suse.de
List-Id: iommu@lists.linux-foundation.org


--hOcCNbCCxyk/YU74
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2015 at 01:43:03PM +0100, Joerg Roedel wrote:
> Changes v1-v2:
>=20
> 	* Rebased to v4.0-rc5
> 	* Converted domain-types to a bit-field
>=20
> Hi,
>=20
> here is patch-set to replace the existing domain_init and
> domain_destroy iommu-ops with the new domain_alloc and
> domain_free callbacks
>=20
> The new callbacks move the allocation of iommu domains into
> the iommu driver, allowing them to put a generic
> iommu_domain struct into their own domain struct. This makes
> domain handling in the drivers more cache efficient and
> prepares the introduction of default domains in another
> patch-set.
>=20
> While at it, this patch-set also introduces domain types.
> These are internal to the iommu core code for now, there are
> three of them:
>=20
> 	* DMA-API domains
> 	* Identity mapped domains
> 	* Domains unmanaged by the iommu-core, used for
> 	  iommu-api so that the users can create their own
> 	  mappings
>=20
> The patches have been compile tested for x86, ARM and PPC
> and runtime tested on x86 (Intel VT-d and AMD IOMMU).
>=20
> Please review.
>=20
> Thanks,
>=20
> 	Joerg
>=20
> Joerg Roedel (15):
>   iommu: Introduce domain_alloc and domain_free iommu_ops
>   iommu: Introduce iommu domain types
>   iommu/amd: Make use of domain_alloc and domain_free
>   iommu/vt-d: Make use of domain_alloc and domain_free
>   iommu/omap: Make use of domain_alloc and domain_free
>   iommu/arm-smmu: Make use of domain_alloc and domain_free
>   iommu/exynos: Make use of domain_alloc and domain_free
>   iommu/tegra-smmu: Make use of domain_alloc and domain_free
>   iommu/tegra-gart: Make use of domain_alloc and domain_free
>   iommu/msm: Make use of domain_alloc and domain_free
>   iommu/shmobile: Make use of domain_alloc and domain_free
>   iommu/ipmmu-vmsa: Make use of domain_alloc and domain_free
>   iommu/rockchip: Make use of domain_alloc and domain_free
>   iommu/fsl: Make use of domain_alloc and domain_free
>   iommu: Remove domain_init and domain_free iommu_ops
>=20
>  drivers/iommu/amd_iommu.c       | 84 +++++++++++++++++++++--------------=
----
>  drivers/iommu/amd_iommu_types.h |  7 ++--
>  drivers/iommu/arm-smmu.c        | 46 +++++++++++++---------
>  drivers/iommu/exynos-iommu.c    | 87 ++++++++++++++++++++++-------------=
------
>  drivers/iommu/fsl_pamu_domain.c | 60 +++++++++++++++-------------
>  drivers/iommu/fsl_pamu_domain.h |  2 +-
>  drivers/iommu/intel-iommu.c     | 48 +++++++++++++----------
>  drivers/iommu/iommu.c           | 20 ++--------
>  drivers/iommu/ipmmu-vmsa.c      | 43 +++++++++++---------
>  drivers/iommu/msm_iommu.c       | 73 +++++++++++++++++-----------------
>  drivers/iommu/omap-iommu.c      | 49 +++++++++++++----------
>  drivers/iommu/rockchip-iommu.c  | 40 +++++++++++--------
>  drivers/iommu/shmobile-iommu.c  | 40 +++++++++++--------
>  drivers/iommu/tegra-gart.c      | 67 +++++++++++++++++++++----------
>  drivers/iommu/tegra-smmu.c      | 41 ++++++++++---------
>  include/linux/iommu.h           | 17 ++++++--
>  16 files changed, 407 insertions(+), 317 deletions(-)

The core and Tegra bits:

Tested-by: Thierry Reding <treding@nvidia.com>

--hOcCNbCCxyk/YU74
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVFTkNAAoJEN0jrNd/PrOhOnAP/0c1ukOr7WBy0Q18WxVj8j7F
VZj1NFFiReYH75D3J7LYVMCFoEnw8HaKQxjCwgy25WID6q9fBQD00SmTsj8y4vxW
L3BhV2mWMmhtGoIVt110rtS6DRbMBzwzVWJ3uMp7y53FMr2BsQF9O1qOGYsgOmuM
NahD7DaofEeJ+vgc/Uq0NH6ccae4lKRKxcszEicCdZ+/a7kQFikqQ1olR/oNw/Sz
127aL97Cj8ASlnTRzeH2K2R6eETcareoBAYIIoBLHb84jfx9/npqU9TKW+z3EPB1
ulMK8geAd0+wQcQe2h39IyBXWGf8ILwCfUjVNjq9W0PXkaLexE0VlktcZDYveeaj
GGnKNSHFfPYmfsg3aIIVkt5sTs4dfw77opKH6wjRm3QPalNv86ELt9EwLx5YgM1I
xi11a536l9ztHtZZ24NREd/7OAhXQV7Q6xbMdhiLsRIJiYclc58rFivMUMCvRavN
qoOjS1TlIKoA6Jx01j76ejxVQfZoecsmyaa7D8RsVkN2S+GCfvsloqaM96ye6MNs
IT9wCsPI93RuR1PWE5pcna1ltNId/Xwl3R90Kzj1vfa5csTHhiN3kXl7tVvvNhbG
sMieuj/XF0XX5FpyoFGPud3wu7ZlDjASTInGWTFMZfr64vBiYIR7Tvh1ET7/dJ7p
E1DQqZ9NjO0HmEjRmBMR
=uhCB
-----END PGP SIGNATURE-----

--hOcCNbCCxyk/YU74--
