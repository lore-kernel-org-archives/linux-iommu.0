Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C7920B42
	for <iommu@lists.linux.dev>; Wed, 10 May 2023 12:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1683722742; x=1715258742;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ft2xF1mBOJy5jrUDL8wm0sluvoXUoK2p6NXMOoc4iMo=;
  b=gUKAXWiBp2Rt1UzYb477ahsQUgRd8fSIG6YQ2v5YI2O+rSjLYCP6AXXQ
   ZPypLV0gAXTIbOKR0NNJkl2218M2t2keN9Al9KDoHNvbyXBad/NpOHt4J
   eGncuYtSibBDhMytMYPNh9qmRrXFSeMfEgGUDBvADHGJlGTiyXawlbmex
   RdYgFwlJXOqSQqFXmDFUieb30+khID+gkgzUBQW6Bq67xlr7Nfg0cDUAw
   uyncgn8YNW3otRCE8qwj44JGzhbGTGvdh2YsPvxd+uJEgK76D79YL4Mbm
   Vx2VSDCYriSGeg/baN+MyrJLEEdlXsvsWL2Vg87XnzBc4fNaxuwI6Hrhx
   g==;
X-IronPort-AV: E=Sophos;i="5.99,264,1677567600"; 
   d="asc'?scan'208";a="214647202"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 May 2023 05:45:31 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 10 May 2023 05:45:31 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Wed, 10 May 2023 05:45:29 -0700
Date: Wed, 10 May 2023 13:45:09 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Anup Patel <apatel@ventanamicro.com>
CC: Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley
	<paul.walmsley@sifive.com>, Thomas Gleixner <tglx@linutronix.de>, Marc
 Zyngier <maz@kernel.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Robin Murphy
	<robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon
	<will@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Atish Patra
	<atishp@atishpatra.org>, Andrew Jones <ajones@ventanamicro.com>, Anup Patel
	<anup@brainfault.org>, <linux-riscv@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<iommu@lists.linux.dev>
Subject: Re: [PATCH v3 01/11] RISC-V: Add riscv_fw_parent_hartid() function
Message-ID: <20230510-squealing-pruning-2c94b85785b0@wendy>
References: <20230508142842.854564-1-apatel@ventanamicro.com>
 <20230508142842.854564-2-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7J+wqfSckLJsTGge"
Content-Disposition: inline
In-Reply-To: <20230508142842.854564-2-apatel@ventanamicro.com>

--7J+wqfSckLJsTGge
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 08, 2023 at 07:58:32PM +0530, Anup Patel wrote:
> We add common riscv_fw_parent_hartid() which help device drivers
> to get parent hartid of the INTC (i.e. local interrupt controller)
> fwnode. Currently, this new function only supports device tree
> but it can be extended to support ACPI as well.
>=20
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  arch/riscv/include/asm/processor.h |  3 +++
>  arch/riscv/kernel/cpu.c            | 12 ++++++++++++
>  2 files changed, 15 insertions(+)
>=20
> diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/=
processor.h
> index 94a0590c6971..6fb8bbec8459 100644
> --- a/arch/riscv/include/asm/processor.h
> +++ b/arch/riscv/include/asm/processor.h
> @@ -77,6 +77,9 @@ struct device_node;
>  int riscv_of_processor_hartid(struct device_node *node, unsigned long *h=
artid);
>  int riscv_of_parent_hartid(struct device_node *node, unsigned long *hart=
id);
> =20
> +struct fwnode_handle;
> +int riscv_fw_parent_hartid(struct fwnode_handle *node, unsigned long *ha=
rtid);
> +
>  extern void riscv_fill_hwcap(void);
>  extern int arch_dup_task_struct(struct task_struct *dst, struct task_str=
uct *src);
> =20
> diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> index 5de6fb703cc2..1adbe48b2b58 100644
> --- a/arch/riscv/kernel/cpu.c
> +++ b/arch/riscv/kernel/cpu.c
> @@ -73,6 +73,18 @@ int riscv_of_parent_hartid(struct device_node *node, u=
nsigned long *hartid)
>  	return -1;
>  }
> =20
> +/* Find hart ID of the CPU fwnode under which given fwnode falls. */
> +int riscv_fw_parent_hartid(struct fwnode_handle *node, unsigned long *ha=
rtid)
> +{
> +	/*
> +	 * Currently, this function only supports DT but it can be
> +	 * extended to support ACPI as well.
> +	 */

Statement of the obvious here, no?
Although, it seems a little odd to read this comment & the corresponding
statement in the commit message, when the series appears to have been
based on the ACPI?

Perhaps by the time v4 comes around, ACPI support will have been merged
& that'll be moot.

> +	if (!is_of_node(node))
> +		return -EINVAL;
> +	return riscv_of_parent_hartid(to_of_node(node), hartid);

nit: blank line before the return here please.

Thanks,
Conor.

--7J+wqfSckLJsTGge
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZFuR1QAKCRB4tDGHoIJi
0i56AP9FXRjPPY/ysx3+btPbR/gOm42Ygf+JSC4zYeMmWzv56AEAloGa6J6cwoJk
U1ibc9oqpOeFavnGuNNDRsxCfer39AE=
=fBPY
-----END PGP SIGNATURE-----

--7J+wqfSckLJsTGge--
