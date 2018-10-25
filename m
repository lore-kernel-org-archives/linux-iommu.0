From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 3/3] iommu/tegra194_smmu: Add Tegra194 SMMU driver
Date: Thu, 25 Oct 2018 17:09:47 +0200
Message-ID: <20181025150947.GN21521@ulmo>
References: <1540334347-7178-1-git-send-email-vdumpa@nvidia.com>
	<1540334347-7178-4-git-send-email-vdumpa@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7684249965129621834=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1540334347-7178-4-git-send-email-vdumpa-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Krishna Reddy <vdumpa-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: snikam-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, praithatha-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, talho-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, yhsu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, avanbrunt-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--===============7684249965129621834==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tpyx7gKuSYt+mjHM"
Content-Disposition: inline


--tpyx7gKuSYt+mjHM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 23, 2018 at 03:39:07PM -0700, Krishna Reddy wrote:
> Tegra194 SMMU driver supports Dual ARM SMMU configuration
> supported in Tegra194 SOC.
> The IOVA accesses from HW devices are interleaved across two
> ARM SMMU devices.
>=20
> Signed-off-by: Krishna Reddy <vdumpa-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/iommu/Makefile        |   1 +
>  drivers/iommu/tegra194-smmu.c | 201 ++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 202 insertions(+)
>  create mode 100644 drivers/iommu/tegra194-smmu.c
>=20
> diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
> index a158a68..84da9f9 100644
> --- a/drivers/iommu/Makefile
> +++ b/drivers/iommu/Makefile
> @@ -28,6 +28,7 @@ obj-$(CONFIG_OMAP_IOMMU_DEBUG) +=3D omap-iommu-debug.o
>  obj-$(CONFIG_ROCKCHIP_IOMMU) +=3D rockchip-iommu.o
>  obj-$(CONFIG_TEGRA_IOMMU_GART) +=3D tegra-gart.o
>  obj-$(CONFIG_TEGRA_IOMMU_SMMU) +=3D tegra-smmu.o
> +obj-$(CONFIG_TEGRA_IOMMU_SMMU) +=3D tegra194-smmu.o
>  obj-$(CONFIG_EXYNOS_IOMMU) +=3D exynos-iommu.o
>  obj-$(CONFIG_FSL_PAMU) +=3D fsl_pamu.o fsl_pamu_domain.o
>  obj-$(CONFIG_S390_IOMMU) +=3D s390-iommu.o

I think we'll need a new Kconfig option for this. This is completely
different from the old Tegra SMMU, and as it is, it will build the
Tegra194 SMMU driver all the way back to Tegra30 where no such thing
exists.

Also, as the 0-day builder already reported there are dependencies that
aren't properly modelled and make the build fail under some
configurations. I think we'll want something like this:

	config ARM_SMMU_TEGRA
		depends on ARM64 && MMU && ARCH_TEGRA
		select IOMMU_API
		select IOMMU_IO_PGTABLE_LPAE
		help
			...

That should pull in the dependency as necessary.

It might also be worth considering to move the Kconfig and Makefile
entries closer to the ARM SMMU entries to clarify that they're related.

> diff --git a/drivers/iommu/tegra194-smmu.c b/drivers/iommu/tegra194-smmu.c
> new file mode 100644
> index 0000000..02109c8
> --- /dev/null
> +++ b/drivers/iommu/tegra194-smmu.c
> @@ -0,0 +1,201 @@
> +/*
> + * IOMMU API for Tegra194 Dual ARM SMMU implementation.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * Copyright (C) 2018 Nvidia Corporation
> + *
> + * Author: Krishna Reddy <vdumpa-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> + */
> +
> +#define pr_fmt(fmt) "tegra194-smmu: " fmt
> +
> +#include "arm-smmu-common.h"
> +
> +/* Tegra194 has three SMMU instances.
> + * Two of the SMMU instances are used by specific set of devices to
> + * access IOVA addresses in interleaved fashion.
> + * The 3rd SMMU instance is used alone by specific set of devices.
> + * This driver only support Dual SMMU configuration which interleaves
> + * IOVA accesses across two SMMU's.
> + * For the 3rd SMMU instance, Default ARM SMMU driver is used.
> + */
> +#define NUM_SMMU_INSTANCES 2

Can we parameterize this at runtime? I suspect that this is something
that could show up in a future chip as well but with a different number
of instances. If we parameterize that, supporting the next generation
may be almost automatic.

That said, it's probably fine to do that in a follow-up if indeed some
future chip requires it.

> +
> +struct tegra194_smmu {
> +	void __iomem			*bases[NUM_SMMU_INSTANCES];
> +	struct arm_smmu_device		*smmu;
> +};
> +
> +static struct tegra194_smmu t194_smmu;

Why the global variable here? It seems to me like the only reason for
its existence is to prevent multiple instances of the dual SMMU. I don't
think that's something we need to worry about. We should expect the DT
to contain the correct number of SMMU instances.

> +
> +static inline void writel_one(u32 val, volatile void __iomem *virt_addr)
> +{
> +	writel(val, virt_addr);
> +}
> +
> +static inline void writel_relaxed_one(u32 val,
> +			volatile void __iomem *virt_addr)
> +{
> +	writel_relaxed(val, virt_addr);
> +}
> +
> +#define WRITEL_FN(fn, call, type) \
> +static inline void fn(type val, volatile void __iomem *virt_addr) \
> +{ \
> +	int i; \
> +	u32 offset =3D abs(virt_addr - t194_smmu.bases[0]); \
> +	for (i =3D 0; i < NUM_SMMU_INSTANCES; i++) \
> +		call(val, t194_smmu.bases[i] + offset); \
> +}

Ah... the global variable is also used here. The fact that we need this
strange construct here indicates to me that this isn't properly factored
out into library code yet.

Thierry

--tpyx7gKuSYt+mjHM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvR3LkACgkQ3SOs138+
s6GXIw/+MYW/FNhjYquJSelnNEPbg7tLquxWBrCU5ixwd3MWYrRvS7tFpQstYtQg
lF0CUHFrnH2bv3uNVGm0TXncfc+g9EgjzLby+JH+yxV39N8aG7rLVMPNfz8XsPsO
v4slFAmp988RNHkTEgXQ0RmmzZHooSJ+RhdfsZ12qQBoEuKFmprRYKi3IP/mt/Qy
UwbiHyHR79YwPTsrHcRjbCp9t3GnSrV8ecanJp+cvQYoPWocKakm0UJVNFri1lap
0BWXsTpsUAVbR6eyG7KytEPfHM0I0Bc6Hc9CKqOd4GmQk3ksc80k7+tpEHWPpDmx
QQMM8x+R6HFBQfe8q/kmxYqz4+eGW1P2/mmhMSpsFqFV1sxNxArR9j4rqedEjOZu
+703bo4x34xZ7FAkMQwgia3wCdLJW/uiD+puSSMcNPhtdo2JJ8MT5dURzDnud40a
3mQ6aMhQn3wcvul6ZpYgz5oHIzAE41ebWAYREb5Jksfgj2H2w2Zkff3eh52TXaqn
U+SayV/SoofejHlo9xcwzF0NDwUp6XCBkOSIjdDxEsXUxjl8LSeanXhjSSitfj0B
XiLDfTTpLXauhcvDgKhFzjuAkO73E2RfC21d1iQ7babBF2yga57sV8Ot4EYk7jlV
164NqQhRx1bkTICORIGIY4Wcd++NdhXqbo52IHYADdkTo4smi9Q=
=QUXy
-----END PGP SIGNATURE-----

--tpyx7gKuSYt+mjHM--

--===============7684249965129621834==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7684249965129621834==--
