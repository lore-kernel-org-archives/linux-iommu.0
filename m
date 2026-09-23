Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690F24EC64E
	for <iommu@lists.linux.dev>; Wed, 23 Sep 2026 11:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790164543; cv=pass; b=fVYaplCVqSDxho/ajCc1qhHbGWc47mC6v605Qi0iS7KcVwnNj5jVofuG4rfhpxcLM5OA8iXP/EkeXpCs6KFnuMewn3oL1JdAYBpBYLWm4H6Fu8vZj9UQelKDW2Vgzr/KEpLHVjY79KsoaYCYhYOHwpK5xuiIRdBxjiWuYNO2FDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790164543; c=relaxed/simple;
	bh=nm2A3E+U5TTONx7bskhFhE5Ow4/TVEhF235l9tbEgwY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YDaxux0fcR4OG37i2+/1CDwYJcrQDa19MWV0rcWS8RpCJ43UU/FCD8Lrdw0hWBySKV2o7hYkjGXA3mMABLPVh+lvK9SmliReZqKe+b1vBAj1AKU+S+0+0OAhxw24iGdhqaAiEOsANm3AQ2vuQ2AtzbSo+d9opBWlckTu8Xz1UNs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b=B1Xcjtna; arc=pass smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b="B1Xcjtna"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-485b1d2874aso697544f8f.1
        for <iommu@lists.linux.dev>; Wed, 23 Sep 2026 04:55:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790164524; cv=none;
        d=google.com; s=arc-20260327;
        b=CdHkSG/W8Mq55YONRffcgrAXUvtOaq9lQxSZw5+xPo5WoylPfnQ6P4+D0Mnl8eh34d
         K2g1RzG8OgK0UDBSdj65faRbVbRwMoJLSELMri/2dU4A2QETkRU31Gteoc63A9rOQddZ
         gH6flV9NJe2oRD0UUANmzRbtslb8600xTemhONFoZXnkvpAijP6cflUiT3gp4Pnj1FHW
         utRJiZO1kNvbSyLNEQ+WwaqAy5Uu1nXPRSe5Bkv+JDKNa2mni+VBKpiIyBAnJQfQpwt6
         PksUoZ2QouC1FphIwDM1aCA0xT2kUAnhMWuKlqDu2crrjiJ6E0WMoIEic453GM5Nne8F
         VmeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HVdhMrrjS3oE1TYac2kH0SXF1gwoyCJ45igZqsjG9/w=;
        fh=swgPSxMjf7d8cNxaPZdtkX66kWqO3uqT5dKa9TC8ZcI=;
        b=FO0LDB63FCAKeCFtegr2VoF/W/k8B9sU4flYsxjLN2H4x38Mz1rwTHBi3H499F3Q47
         q4I/A1Pq0vuSah8iYq9+NF93mQ9RYrqa2gpiJgLdQyop5Oy/s7Z369zG7vCP/mHfI9gY
         E5okvvyEkwMpRZONXeh3tnLMPq1BMgPCYXEngJU79Z5L0Biyv3rT3vXiGTAzlZckPEcz
         lI64KPeexPmpyo4r5rsDFjwEFS4EsOLhlYa2hirXMQAjTqVQ6h3EHknqHeHfJpAIR5wc
         lhpeZG7Anv9QrguB2g51VfxdwwwzTo98fJaeuVCUvZeqWHhgkUiYgEK1L4SFPzRsBndB
         pKNA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1790164524; x=1790769324; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HVdhMrrjS3oE1TYac2kH0SXF1gwoyCJ45igZqsjG9/w=;
        b=B1XcjtnaaGBanBjXm7Vjp2XS5aa46zFVx36sCkR/XaPoTzbwrBrZkVE/wgUwIQA60e
         TaUZmGv0Det4GNA15FKjzVuxVX9CLDbunAY9pBhfPgCDCjwHc0TyD8TVWorlYbOTnOcf
         BhE3OW3AgxGTj8IG6JfOToHsiDMfdiANx2CEa/5gYepX60p8M+R/nmj1yv8IJSPgk0om
         QuphvPnVn713SiF8vbgvkwKjIJgkQd0qD1p5UlmRo6TI4fpUVJAx7ZJPn9paFybc8ktP
         p7GurOHpSyAsJZjWoBzVb4ov+L5ZcC5pL678gLZ2X5Ys5+TUb3msO+kxXeLQGjd183Ao
         SH2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790164524; x=1790769324;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HVdhMrrjS3oE1TYac2kH0SXF1gwoyCJ45igZqsjG9/w=;
        b=V/Qnj5hV2vo23yMUTJMk7o6JRdlNlWDI/PxjEkLFCz/QIcUTH5RD6NWrobImST/BTk
         gguZLH4DLQ/UvBIrgBduBqp1rDp/bp0RM08ziSeP1dfpiXmaF7H7lwz8gjHrVHgL3kKl
         iWJ6P1AHSVpqc7tUV7Vsc9Ja+sCq13WCNPprqgINMQldzhXWkID7Si0GYxMXAx0pfNQR
         hw5X5NfJgrEFNcZc2lkF2ah9GF7mfX5yauc5PVQo/gOrXpKDg6iNox37HjafRlOA3Xf3
         64/jA1m6Mi6/PEeffliWzU0Ta+J4NiKyMOwE6zCORU5kxEruk/PXkQEsCxEAQZXP6YYK
         Xs+Q==
X-Forwarded-Encrypted: i=1; AKwUvBxH8+LGS9NL7/ujcdmYZ6NozSRiHf43qV1S0lIOyPGnoMNf+xp09xRYUnofzYn8FQ6VOBLkjA==@lists.linux.dev
X-Gm-Message-State: AFuF++lBi6NhheyHrR+L9Qt4rtBEiTB3n/wQUeq1HG+V6PJng78vmVUX
	l1FHZTdnkc+3HUg6ZhZp7KJQfDWMmxsCPNqcJc2KHhohaDaiwsrfcMCn1M0ws9p+TbC2lWDJ8OL
	sncYlqQlGXSeYDUKzskPZVv37Dvo3FzMec4cFnYG+mw==
X-Gm-Gg: AYBFou3UNCCfUtLgkARDHEA63lRjjhgdkFXuyGzjEzt2LXrvexLuUiGmP2TuBxlUbwl
	xSatHMvUWehyhFJjTBccJ3mSHM+h1UbBqtqXtEd3S4RGZookhUVsjqecIX8OuqS2pijj68tGkDJ
	9kzM0IIEqQ5YnniaEUoD7m9x7Kt8+fyy0b7FqYtg1wVWdjbHBFMZaRKbDnWN4+DEV401CLIP+5y
	aMKSwZCqs8RBvdw4SWAG44ck4ZM+FKliC+Id4u4zdBNMLHab6rHO7owq8sUnIWTgb+eE9cN0+Vx
	t8M3hOLyy1PWL7nRD/lgHCn+K99JSzHIxlU+Ie8iYOEJn/tIZLDe/GqUl+b/OgNHdsO0Bc42922
	9h2mSmSCcnkex6iZQDKQhrtQWGgA9XT/CYiXozcp903XXQzewLRun3HFGQnQWbNvd9pDJ0J1Paa
	ER
X-Received: by 2002:a05:6000:4023:b0:486:f17d:14dc with SMTP id
 ffacd0b85a97d-4886705f8fdmr4136204f8f.12.1790164523026; Wed, 23 Sep 2026
 04:55:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260831145943.313726-1-andrew.jones@oss.qualcomm.com> <20260831145943.313726-12-andrew.jones@oss.qualcomm.com>
In-Reply-To: <20260831145943.313726-12-andrew.jones@oss.qualcomm.com>
From: Anup Patel <anup@brainfault.org>
Date: Wed, 23 Sep 2026 17:25:11 +0530
X-Gm-Features: AclHuK_zLIl-mrpS78xV6vRgDB9dAAUf9QhniI9fOC93j9unzeVYyRI1tSChnzo
Message-ID: <CAAhSdy3o=JtEXnFANPdNn3E3XuKk2wUwXwrekQ+1ropJWnrYGA@mail.gmail.com>
Subject: Re: [PATCH v5 11/17] irqchip/riscv-imsic: Add S-mode MSI address list
To: Andrew Jones <andrew.jones@oss.qualcomm.com>
Cc: linux-riscv@lists.infradead.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev, tjeznach@rivosinc.com, 
	jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, pjw@kernel.org, palmer@dabbelt.com, tglx@kernel.org, 
	kevin.tian@intel.com, fangyu.yu@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2026 at 8:30=E2=80=AFPM Andrew Jones
<andrew.jones@oss.qualcomm.com> wrote:
>
> Upcoming RISC-V IOMMU interrupt remapping needs to map every possible
> host IMSIC target into one contiguous MSI IOVA range. MSI message
> composition then uses the target CPU's position within that range.
>
> Build an S-mode IMSIC physical address array indexed by logical CPU.
> Require every possible CPU to have an initialized IMSIC page before
> publishing the array. This preserves physical address zero as a valid
> target and guarantees the array has num_possible_cpus() entries.
>
> The array size and each target's index can therefore be derived
> directly, without storing duplicate count or per-CPU index metadata.
>
> Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
> ---
>  drivers/irqchip/irq-riscv-imsic-state.c | 32 +++++++++++++++++++++++++
>  drivers/irqchip/irq-riscv-imsic-state.h |  1 +
>  2 files changed, 33 insertions(+)
>
> diff --git a/drivers/irqchip/irq-riscv-imsic-state.c b/drivers/irqchip/ir=
q-riscv-imsic-state.c
> index df38a7670a89..c7ebddd308ec 100644
> --- a/drivers/irqchip/irq-riscv-imsic-state.c
> +++ b/drivers/irqchip/irq-riscv-imsic-state.c
> @@ -709,6 +709,31 @@ static int __init imsic_get_mmio_resource(struct fwn=
ode_handle *fwnode,
>         return of_address_to_resource(to_of_node(fwnode), index, res);
>  }
>
> +static int __init imsic_init_smode_msi_pa(void)
> +{
> +       struct imsic_global_config *global =3D &imsic->global;
> +       phys_addr_t *smode_msi_pa;
> +       unsigned int cpu;
> +
> +       smode_msi_pa =3D kcalloc(num_possible_cpus(), sizeof(*smode_msi_p=
a), GFP_KERNEL);
> +       if (!smode_msi_pa)
> +               return -ENOMEM;
> +
> +       for_each_possible_cpu(cpu) {
> +               struct imsic_local_config *local =3D per_cpu_ptr(global->=
local, cpu);
> +
> +               if (!local->msi_va) {
> +                       kfree(smode_msi_pa);
> +                       return -ENODEV;
> +               }
> +
> +               smode_msi_pa[cpu] =3D local->msi_pa;
> +       }
> +
> +       imsic->smode_msi_pa =3D smode_msi_pa;
> +       return 0;
> +}
> +
>  static int __init imsic_parse_fwnode(struct fwnode_handle *fwnode,
>                                      struct imsic_global_config *global,
>                                      u32 *nr_parent_irqs,
> @@ -959,6 +984,12 @@ int __init imsic_setup_state(struct fwnode_handle *f=
wnode, void *opaque)
>                 goto out_local_cleanup;
>         }
>
> +       rc =3D imsic_init_smode_msi_pa();
> +       if (rc) {
> +               pr_err("%pfwP: failed to initialize S-mode MSI addresses\=
n", fwnode);
> +               goto out_local_cleanup;
> +       }
> +
>         /* Initialize matrix allocator */
>         rc =3D imsic_matrix_init();
>         if (rc) {
> @@ -984,6 +1015,7 @@ int __init imsic_setup_state(struct fwnode_handle *f=
wnode, void *opaque)
>  out_free_local:
>         free_percpu(imsic->global.local);
>  out_free_priv:
> +       kfree(imsic->smode_msi_pa);
>         kfree(imsic);
>         imsic =3D NULL;
>         return rc;
> diff --git a/drivers/irqchip/irq-riscv-imsic-state.h b/drivers/irqchip/ir=
q-riscv-imsic-state.h
> index c42ee180b305..11352f14e32d 100644
> --- a/drivers/irqchip/irq-riscv-imsic-state.h
> +++ b/drivers/irqchip/irq-riscv-imsic-state.h
> @@ -49,6 +49,7 @@ struct imsic_priv {
>
>         /* Global configuration common for all HARTs */
>         struct imsic_global_config              global;
> +       phys_addr_t                             *smode_msi_pa;

Please a comment over here about what this is for.

I also suggest renaming "smode_msi_pa" to "msi_pa_list" because
theoritically IMSIC driver can work for M-mode as well although
we have not tried it for M-mode.

Regards,
Anup
