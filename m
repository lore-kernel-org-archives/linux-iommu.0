Return-Path: <SRS0=bNYQ=AE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 442F6C433DF
	for <iommu@archiver.kernel.org>; Tue, 23 Jun 2020 10:29:40 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C1032072E
	for <iommu@archiver.kernel.org>; Tue, 23 Jun 2020 10:29:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Netg0S81"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C1032072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id C21ED2154C;
	Tue, 23 Jun 2020 10:29:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ln8Y35GSX-Xa; Tue, 23 Jun 2020 10:29:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 1499D204AC;
	Tue, 23 Jun 2020 10:29:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EBE31C088E;
	Tue, 23 Jun 2020 10:29:36 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F1C9BC016F
 for <iommu@lists.linux-foundation.org>; Tue, 23 Jun 2020 10:29:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id ED33987E9B
 for <iommu@lists.linux-foundation.org>; Tue, 23 Jun 2020 10:29:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hbEeeAQNnHsD for <iommu@lists.linux-foundation.org>;
 Tue, 23 Jun 2020 10:29:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com
 [209.85.218.65])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 8098F87E57
 for <iommu@lists.linux-foundation.org>; Tue, 23 Jun 2020 10:29:34 +0000 (UTC)
Received: by mail-ej1-f65.google.com with SMTP id dr13so21072571ejc.3
 for <iommu@lists.linux-foundation.org>; Tue, 23 Jun 2020 03:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=tPGW60dM9fSf/IzKxhzQKBLFRcFd0S7nyyUJfJ7rChE=;
 b=Netg0S81KCIaj8t7fgVMU8+4u0a3kj3VqayqQmsFJ2zN/7a5Oz7J0/MvbSrEcHLRip
 uOukYgG5jWh1q6J8+4j0vLn9Agi8vthdbhLaUbbAQqog1QB+Ir5eR/OhOWEhk1NlP5m0
 zUGajfY/jkSMSn/iL7zJoMuXkKOyxVJFBES1VYeJ3mu3M2r3mjimEYZlV6zqCBr9ol18
 j9iL2WwH2jHon0diAEy1yEFFCpqONNkWFMtpuHdU8YvIIlnQ1oTOHiqGkFxBgNxHSnZs
 OLXumMATKCn9vEoI/wyWc2/DHtmayrCIpkh9NR4iwbMGsGcV8hX38TMRuOt53asx52eD
 YOJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=tPGW60dM9fSf/IzKxhzQKBLFRcFd0S7nyyUJfJ7rChE=;
 b=nz4zg67MS+G2WGphwAHrmrnAiJVPL3gIUgNQDTLdGIHL0sChECf3Y/s9HgBXeXhS/h
 b+cd1GOz/DOVIgV1CfsYgPlG/4hnapcKRS3MwiRQOO0XEEOpdF9Achzy0z3SsHcc+DHj
 gBHLb0jYxtifp8EGqaLgYgAjRj2gEOOFx2ck3xcXh5C2Nc9vqgL/Z0mOQgGxb+Yd4Y7L
 UURiwmdPLV4AnXbkPG4zqqhoQ4y89PVS5Mur4mGzxInCAK1e5VlajhIXk6xbPYCrixcI
 IcBO2f+ejO0nQbAYfkFQsr8NJZUFAZ+MXol8i2XnSRQl5a39RQ+qNjEUAT9u/EHYCLTx
 NQ0A==
X-Gm-Message-State: AOAM5332OK9xnZSGGUDyvoCavU23jnW6beNo71Dl+tTiOb7vxyPw0Amd
 14QZfnRzEnOl0XbsQniGEIY=
X-Google-Smtp-Source: ABdhPJw0xCzsJkn8DbekZJAFKN2AXHHvsMp8U/XXOFleitYftMpZy9ZHGK+vFBWrK88XEtE7ZjUErA==
X-Received: by 2002:a17:906:9408:: with SMTP id
 q8mr1702000ejx.496.1592908172738; 
 Tue, 23 Jun 2020 03:29:32 -0700 (PDT)
Received: from localhost ([62.96.65.119])
 by smtp.gmail.com with ESMTPSA id q14sm14692150edj.47.2020.06.23.03.29.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 03:29:28 -0700 (PDT)
Date: Tue, 23 Jun 2020 12:29:27 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Krishna Reddy <vdumpa@nvidia.com>
Subject: Re: [PATCH v6 1/4] iommu/arm-smmu: add NVIDIA implementation for
 dual ARM MMU-500 usage
Message-ID: <20200623102927.GD4098287@ulmo>
References: <20200604234414.21912-1-vdumpa@nvidia.com>
 <20200604234414.21912-2-vdumpa@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20200604234414.21912-2-vdumpa@nvidia.com>
User-Agent: Mutt/1.14.4 (2020-06-18)
Cc: treding@nvidia.com, bhuntsman@nvidia.com, robin.murphy@arm.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 mperttunen@nvidia.com, talho@nvidia.com, snikam@nvidia.com,
 nicolinc@nvidia.com, linux-tegra@vger.kernel.org, yhsu@nvidia.com,
 praithatha@nvidia.com, will@kernel.org, linux-arm-kernel@lists.infradead.org,
 bbiswas@nvidia.com
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2958925487968110857=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============2958925487968110857==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wLAMOaPNJ0fu1fTG"
Content-Disposition: inline


--wLAMOaPNJ0fu1fTG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 04, 2020 at 04:44:11PM -0700, Krishna Reddy wrote:
> NVIDIA's Tegra194 soc uses two ARM MMU-500s together to interleave

s/soc/SoC/

> IOVA accesses across them.
> Add NVIDIA implementation for dual ARM MMU-500s and add new compatible
> string for Tegra194 soc.

Same here.

>=20
> Signed-off-by: Krishna Reddy <vdumpa@nvidia.com>
> ---
>  MAINTAINERS                     |   2 +
>  drivers/iommu/Makefile          |   2 +-
>  drivers/iommu/arm-smmu-impl.c   |   3 +
>  drivers/iommu/arm-smmu-nvidia.c | 161 ++++++++++++++++++++++++++++++++
>  drivers/iommu/arm-smmu.h        |   1 +
>  5 files changed, 168 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/iommu/arm-smmu-nvidia.c
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 50659d76976b7..118da0893c964 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16572,9 +16572,11 @@ F:	drivers/i2c/busses/i2c-tegra.c
> =20
>  TEGRA IOMMU DRIVERS
>  M:	Thierry Reding <thierry.reding@gmail.com>
> +R:	Krishna Reddy <vdumpa@nvidia.com>
>  L:	linux-tegra@vger.kernel.org
>  S:	Supported
>  F:	drivers/iommu/tegra*
> +F:	drivers/iommu/arm-smmu-nvidia.c
> =20
>  TEGRA KBC DRIVER
>  M:	Laxman Dewangan <ldewangan@nvidia.com>
> diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
> index 57cf4ba5e27cb..35542df00da72 100644
> --- a/drivers/iommu/Makefile
> +++ b/drivers/iommu/Makefile
> @@ -15,7 +15,7 @@ obj-$(CONFIG_AMD_IOMMU) +=3D amd_iommu.o amd_iommu_init=
=2Eo amd_iommu_quirks.o
>  obj-$(CONFIG_AMD_IOMMU_DEBUGFS) +=3D amd_iommu_debugfs.o
>  obj-$(CONFIG_AMD_IOMMU_V2) +=3D amd_iommu_v2.o
>  obj-$(CONFIG_ARM_SMMU) +=3D arm_smmu.o
> -arm_smmu-objs +=3D arm-smmu.o arm-smmu-impl.o arm-smmu-qcom.o
> +arm_smmu-objs +=3D arm-smmu.o arm-smmu-impl.o arm-smmu-qcom.o arm-smmu-n=
vidia.o
>  obj-$(CONFIG_ARM_SMMU_V3) +=3D arm-smmu-v3.o
>  obj-$(CONFIG_DMAR_TABLE) +=3D dmar.o
>  obj-$(CONFIG_INTEL_IOMMU) +=3D intel-iommu.o intel-pasid.o
> diff --git a/drivers/iommu/arm-smmu-impl.c b/drivers/iommu/arm-smmu-impl.c
> index c75b9d957b702..52c84c30f83e4 100644
> --- a/drivers/iommu/arm-smmu-impl.c
> +++ b/drivers/iommu/arm-smmu-impl.c
> @@ -160,6 +160,9 @@ struct arm_smmu_device *arm_smmu_impl_init(struct arm=
_smmu_device *smmu)
>  	 */
>  	switch (smmu->model) {
>  	case ARM_MMU500:
> +		if (of_device_is_compatible(smmu->dev->of_node,
> +					    "nvidia,tegra194-smmu-500"))
> +			return nvidia_smmu_impl_init(smmu);

Should NVIDIA_TEGRA194_SMMU be a separate value for smmu->model,
perhaps? That way we avoid this somewhat odd check here.

>  		smmu->impl =3D &arm_mmu500_impl;
>  		break;
>  	case CAVIUM_SMMUV2:
> diff --git a/drivers/iommu/arm-smmu-nvidia.c b/drivers/iommu/arm-smmu-nvi=
dia.c

I wonder if it would be better to name this arm-smmu-tegra.c to make it
clearer that this is for a Tegra chip. We do have regular expressions in
MAINTAINERS that catch anything with "tegra" in it to make this easier.

> new file mode 100644
> index 0000000000000..dafc293a45217
> --- /dev/null
> +++ b/drivers/iommu/arm-smmu-nvidia.c
> @@ -0,0 +1,161 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +// Nvidia ARM SMMU v2 implementation quirks

s/Nvidia/NVIDIA/

> +// Copyright (C) 2019 NVIDIA CORPORATION.  All rights reserved.

I suppose this should now also include 2020.

> +
> +#define pr_fmt(fmt) "nvidia-smmu: " fmt

Same here. Might be worth making this "tegra-smmu: " for consistency.

> +
> +#include <linux/bitfield.h>
> +#include <linux/delay.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +
> +#include "arm-smmu.h"
> +
> +/* Tegra194 has three ARM MMU-500 Instances.
> + * Two of them are used together for Interleaved IOVA accesses and
> + * used by Non-Isochronous Hw devices for SMMU translations.

"non-isochronous", s/Hw/HW/

> + * Third one is used for SMMU translations from Isochronous HW devices.

"isochronous"

> + * It is possible to use this Implementation to program either

"implementation"

> + * all three or two of the instances identically as desired through
> + * DT node.
> + *
> + * Programming all the three instances identically comes with redundant =
tlb

s/tlb/TLB/

> + * invalidations as all three never need to be tlb invalidated for a HW =
device.

Same here.

> + *
> + * When Linux Kernel supports multiple SMMU devices, The SMMU device use=
d for

"kernel" and "..., the SMMU device"

> + * Isochornous HW devices should be added as a separate ARM MMU-500 devi=
ce

"isochronous"

> + * in DT and be programmed independently for efficient tlb invalidates.

"TLB"

> + *
> + */
> +#define MAX_SMMU_INSTANCES 3
> +
> +#define TLB_LOOP_TIMEOUT		1000000	/* 1s! */

USEC_PER_SEC?

> +#define TLB_SPIN_COUNT			10
> +
> +struct nvidia_smmu {
> +	struct arm_smmu_device	smmu;
> +	unsigned int		num_inst;
> +	void __iomem		*bases[MAX_SMMU_INSTANCES];
> +};
> +
> +#define to_nvidia_smmu(s) container_of(s, struct nvidia_smmu, smmu)

Making this static inline can make error messages more readable.

> +
> +#define nsmmu_page(smmu, inst, page) \
> +	(((inst) ? to_nvidia_smmu(smmu)->bases[(inst)] : smmu->base) + \
> +	((page) << smmu->pgshift))

Can we simply define to_nvidia_smmu(smmu)->bases[0] =3D smmu->base in
nvidia_smmu_impl_init()? Then this would become just:

	to_nvidia_smmu(smmu)->bases[inst] + ((page) << (smmu)->pgshift)

Also, the nsmmu_ prefix looks somewhat odd here. You already use struct
nvidia_smmu as the name of the structure, so why not be consistent and
continue to use nvidia_smmu_ as the prefix for function names?

Or perhaps even use tegra_smmu_ as the prefix to match the filename
change I suggested earlier.

> +
> +static u32 nsmmu_read_reg(struct arm_smmu_device *smmu,
> +			      int page, int offset)
> +{
> +	return readl_relaxed(nsmmu_page(smmu, 0, page) + offset);
> +}
> +
> +static void nsmmu_write_reg(struct arm_smmu_device *smmu,
> +			    int page, int offset, u32 val)
> +{
> +	unsigned int i;
> +
> +	for (i =3D 0; i < to_nvidia_smmu(smmu)->num_inst; i++)
> +		writel_relaxed(val, nsmmu_page(smmu, i, page) + offset);
> +}
> +
> +static u64 nsmmu_read_reg64(struct arm_smmu_device *smmu,
> +				int page, int offset)
> +{
> +	return readq_relaxed(nsmmu_page(smmu, 0, page) + offset);
> +}
> +
> +static void nsmmu_write_reg64(struct arm_smmu_device *smmu,
> +				  int page, int offset, u64 val)
> +{
> +	unsigned int i;
> +
> +	for (i =3D 0; i < to_nvidia_smmu(smmu)->num_inst; i++)
> +		writeq_relaxed(val, nsmmu_page(smmu, i, page) + offset);
> +}
> +
> +static void nsmmu_tlb_sync(struct arm_smmu_device *smmu, int page,
> +			   int sync, int status)
> +{
> +	u32 reg;

I see this is being used to store the value read from a register. I find
it clearer to call this "value" or "val" (or in this case perhaps even
"status") because whenever I read "reg" I immediately think this is
meant to be a register offset, which can then be confusing when I see it
used in I/O accessors because it is in the wrong position.

But anyway, that's just my opinion and this is a bit subjective, so feel
free to ignore.

> +	unsigned int i;
> +	unsigned int spin_cnt, delay;
> +
> +	arm_smmu_writel(smmu, page, sync, 0);
> +
> +	for (delay =3D 1; delay < TLB_LOOP_TIMEOUT; delay *=3D 2) {
> +		for (spin_cnt =3D TLB_SPIN_COUNT; spin_cnt > 0; spin_cnt--) {
> +			reg =3D 0;

You may want to declare the variable at this scope since you never need
it outside. Also, use a space between variable initialization and the
for block below for better readability.

> +			for (i =3D 0; i < to_nvidia_smmu(smmu)->num_inst; i++) {
> +				reg |=3D readl_relaxed(
> +					nsmmu_page(smmu, i, page) + status);
> +			}

Maybe add a separate variable for the page address so this can be a bit
uncluttered. Also, I'd prefer a blank line after the block for
readability.

> +			if (!(reg & ARM_SMMU_sTLBGSTATUS_GSACTIVE))
> +				return;
> +			cpu_relax();

Blank line above cpu_relax() for readability.

> +		}
> +		udelay(delay);

Again, a blank line between blocks and subsequent statements can help
readability.

> +	}
> +	dev_err_ratelimited(smmu->dev,
> +			    "TLB sync timed out -- SMMU may be deadlocked\n");

Same here.

Also, is there anything we can do when this happens?

> +}
> +
> +static int nsmmu_reset(struct arm_smmu_device *smmu)
> +{
> +	u32 reg;
> +	unsigned int i;
> +
> +	for (i =3D 0; i < to_nvidia_smmu(smmu)->num_inst; i++) {
> +		/* clear global FSR */
> +		reg =3D readl_relaxed(nsmmu_page(smmu, i, ARM_SMMU_GR0) +
> +				    ARM_SMMU_GR0_sGFSR);
> +		writel_relaxed(reg, nsmmu_page(smmu, i, ARM_SMMU_GR0) +
> +				    ARM_SMMU_GR0_sGFSR);
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct arm_smmu_impl nvidia_smmu_impl =3D {
> +	.read_reg =3D nsmmu_read_reg,
> +	.write_reg =3D nsmmu_write_reg,
> +	.read_reg64 =3D nsmmu_read_reg64,
> +	.write_reg64 =3D nsmmu_write_reg64,
> +	.reset =3D nsmmu_reset,
> +	.tlb_sync =3D nsmmu_tlb_sync,
> +};
> +
> +struct arm_smmu_device *nvidia_smmu_impl_init(struct arm_smmu_device *sm=
mu)
> +{
> +	unsigned int i;
> +	struct nvidia_smmu *nsmmu;
> +	struct resource *res;
> +	struct device *dev =3D smmu->dev;
> +	struct platform_device *pdev =3D to_platform_device(smmu->dev);
> +
> +	nsmmu =3D devm_kzalloc(smmu->dev, sizeof(*nsmmu), GFP_KERNEL);
> +	if (!nsmmu)
> +		return ERR_PTR(-ENOMEM);
> +
> +	nsmmu->smmu =3D *smmu;
> +	/* Instance 0 is ioremapped by arm-smmu.c */
> +	nsmmu->num_inst =3D 1;

Maybe add this here to simplify the nsmmu_page() macro above:

	nsmmu->bases[0] =3D smmu->base;

> +
> +	for (i =3D 1; i < MAX_SMMU_INSTANCES; i++) {
> +		res =3D platform_get_resource(pdev, IORESOURCE_MEM, i);
> +		if (!res)
> +			break;
> +		nsmmu->bases[i] =3D devm_ioremap_resource(dev, res);
> +		if (IS_ERR(nsmmu->bases[i]))
> +			return (struct arm_smmu_device *)nsmmu->bases[i];

ERR_CAST()?

> +		nsmmu->num_inst++;
> +	}

More blank lines would make this much easier to read, in my opinion.

> +
> +	nsmmu->smmu.impl =3D &nvidia_smmu_impl;
> +	devm_kfree(smmu->dev, smmu);

Maybe a comment here would be useful for readers to immediately
understand why you're doing this here.

> +	pr_info("NVIDIA ARM SMMU Implementation, Instances=3D%d\n",
> +		nsmmu->num_inst);

I think I'd just omit this. In general you should only let the user know
when things go wrong, but the above is printed when everything goes as
expected.

Thierry

--wLAMOaPNJ0fu1fTG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl7x2YUACgkQ3SOs138+
s6FHohAAqVIuYWiM6cSjnAMmfY4aPp5GAld67SpGovHutRbzuWjmKw9lT3AFwmvM
25lypPdf3OE6uQ55O6HzwCvPzupDXDKvLYHsmSPh15ObD3Pu3dewdu6oSkf+p4Zv
pkqrs+WOeOc4n0p6zICAM4Ag0YxheytceGFByYLNvu+Pk4HsAcqqssrvr+7aJ6QL
1WXqVz5BzruXi4rEIlMhWIK7/fvEJMNgqk5A7ahQMgZQ6IgWn1gJUwRnIsuEF5rA
rqLT1h+kZAS60v9B+CCHyylgfcIUQ1qbCC2uoeH+WNhdLNZWVjtUcgjmFrBkq9e1
z3qxkFGIvrPWSn483oCoXFfdoJx6pyMgSIZyS/p3/WSTlI7XbNbdROLrBt+2FvHP
e+fGKtl2DzS/lgZEoZOS+gf15IATZP8BqjnCqq9IXYSaoZ+f81icADXwrDktk8FF
ll64s8B2L/H0IhELclJB9+2F5JAQg/ZH1B3OFzdlpGGvaLwOOUXhOUi4Vm2lac/r
rIwWMSJOCw0ldtWHjInvg0yypEp45dJ8EA2uzuwpSRv/5i9UoeBiHkxHSg05LAY6
Lc8E+TyPMrOxqYVsIuF/k65dg9nOi3EwoVqz2NwB8X2vf4krchCRP2VnlEKOU71i
sycs1n2qnoYs2MO0eJI5ls8WHQ5m4GRhnwhvcduVZACNbwCs8H4=
=l/SC
-----END PGP SIGNATURE-----

--wLAMOaPNJ0fu1fTG--

--===============2958925487968110857==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============2958925487968110857==--
