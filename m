Received: from mail-wr2-f14.google.com (mail-wr2-f14.google.com [74.125.225.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E7D485924
	for <iommu@lists.linux.dev>; Wed, 23 Sep 2026 12:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790164883; cv=pass; b=idyKwlf4DqCUnDZjk3noE6/fe9IKUsswa81/epPoFPguwumEk/3Ao33mxjXkNt3Sn3hlwOBD09uJ1g6nbIFwvNAh6WuuYnDnx4939qNJCUf6kXA/m8hruYN1n5vWJWHd3yri8TMOqrgA1eWIn6OUK3lXkcmXvYr3zzt3EUFoo+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790164883; c=relaxed/simple;
	bh=UciKY87OJuo05x9eA/7imt88rzW35xEJOjxrzxqe9Co=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GAMwVhRtV5c/49edTVnscG98RTQ8IKsOeTT9FmtxNwphGCaKNExhcTfeGwYTRlj8FFOqlG71/MtC4vM6rPk6kAtkHytJ/KUR54d6sOYH39Avh8gCruzBZwJQJ/GgXcKOIGFWpUFftnITWRDYtzFty7dsp359xdQbyhaXuZsHBaw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b=t7h7hrgL; arc=pass smtp.client-ip=74.125.225.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b="t7h7hrgL"
Received: by mail-wr2-f14.google.com with SMTP id ffacd0b85a97d-482f6350f88so609510f8f.2
        for <iommu@lists.linux.dev>; Wed, 23 Sep 2026 05:01:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790164878; cv=none;
        d=google.com; s=arc-20260327;
        b=LCtbKUdp4z3ISQB5oisEyaJGLxlga1tX57vsxOdGeOeTrlF3/tqWuVPPl/Jwsg7G6W
         Tda406bgxI44GBihruiHIVq6XKNAgioqi3LukNtZuIxQMXugKZNLNY7s5iwlark74Hq5
         VZDF2fwOJ77rwQxcQSW21gdcSN8p4v1M3NBRCqXe8O5YPop3tuFHn4i4zUfize4JuaA4
         YxJGRv5bG74r/dS4Gw8OECsBWcl+TyHM+C9l31qF7mNd1M2V07bSKMC3z0e/Gz+HnPJk
         N5IrN+qKdo9knn+r8v/lrdRaS9vMJvHPLtuUMkuvzUFHYh7S9oN3qhC+gnVe7/IYR8GM
         KGSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7oV5NhC84tix+b+JvApE1dpYWTnu/MAWxqkNt5esyEI=;
        fh=XXlRhcRzr4+3Te0Jmw2Cpdpzc3Bqqp8zncLjIUu5jQg=;
        b=cs0FKFrrqv/flX8bZmYZlibHkOLSiIUTx6wnz4Z24Tv3hUnQT7t4rZ3TXnsxjSid2Y
         wstWEBRCvaaTUgnNyGr/JMa4VPXJQ+1UJ17kK0FenUyNOnV7KrEfQOONCy2iEUf6byYx
         zmgJbCjoZikpgoysk5a/I45wOc9Iya/BSNKhc993wKSujkC5iWWq36S9dQNTdB93t1po
         2g/pX/iNmrl0Y/ZRS5HZ2m7IOaa/Z3PD1+hB/moZU9rZEAHpaF8gOBkXuMPZ+SLceFTf
         eStpsVk6uvwwMx/H9NDUJErUPINrG4pY7wzRXwqnZCacPxz5JP1hU/72g3IWadsW1yDf
         tSOA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1790164878; x=1790769678; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7oV5NhC84tix+b+JvApE1dpYWTnu/MAWxqkNt5esyEI=;
        b=t7h7hrgLCuUXWd65ylaPtinpC9SnXRIe0jvaox9EpgH1vSo9oWynNc1KmYLDd9dhTp
         vnQWVI9E61mn4AgQGM4iz3I29zpv/vyPiUvhr9sxTJTiJOg/OaXCzPu1eABb333ECskP
         lPfLiPhPfMGFsdtqIi8Q4aYRXMTujyDoMnizHa8P39+QeUgHM4gKn+5ih5F/Jcr80BOI
         IYNR1pk2ZeCpcPiEikmJgo+FcaJCiZhT/p5SuDJ1s8DX7Q/h/JYUc4Y7dw0d4lsQ4B3v
         LhuN+nz5R4eTWpwDFIZ2sj+AAVv6ZrwbpwlVNaKV8BAqNvbSPdgp2ab/+4fAfx1Gqx37
         wWLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790164878; x=1790769678;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7oV5NhC84tix+b+JvApE1dpYWTnu/MAWxqkNt5esyEI=;
        b=ZyvseCj6xU9ud9czgU84ZxHzorokdjMRTll+Q2bffxV5nX5iTn3vi+wLAhqLpCC+sa
         SlTZoiWn12mMQkut/Fuz7QZ+UEy5LQxQ3kEq9YUfp6IycKhF2rLiP3zftanU5AADE2YX
         wjVaG7dw0UZ6+eBz6gkO9rKmq3zbAkTKSd0LojigcULJD0mUhOyj/Ph6jFeACYjuu523
         IZ5q5IpI5wEjsS15ShsFBwaWRVPhgoHi5jONUg4lWVyzSUSvs4JOfzXHOOV/DKCBfEYN
         ClkLuFzohZq7CiVXSfnEoYyLBYn8tE+7GuMk231HaR2YNCroBXi6GNVGh7T8XT+mmVrv
         /70A==
X-Forwarded-Encrypted: i=1; AKwUvBxcnYD1Ikb9A+8taQvYL2NfXWEqK4KSU+Hcp3RhYd1s7DWgbtbdsAl302lSzNggUDoXkH2MXw==@lists.linux.dev
X-Gm-Message-State: AFuF++l13TUyZhFo0pjVdCmvRbK2/xaTLbYoPt75rUn3DEWNiUzLAO6S
	PAlIBZevs/eF0Gzdl5ewMgtBIWEUjFTd/MD0PSTI72rUrpwVSKR4ikVKK73qZMCWoJdpGWt2OWG
	zLi/jeMfntFxV83dIxVtKzp9smoUmTXsiHqyiiiGvJA==
X-Gm-Gg: AYBFou0vOTWqYHFqB9nRs6bJ8jtAF781B2l6x/utwuoJpQjCxcgH1RRBkiD+r1frK4l
	DWiMNwRmA84+EL8gKW1g7ClNRS8vkM/KQtzEFUckRPshjrpyEd/nsNojsRlVfThFKyuqzX4VjNb
	njTZAomf/E2tjdJsH00fau7f9ebT5y8MmcGy5W3ml8qYySD7TxRWXeu18xh4P84H/jMx+sOyKoS
	JBJNvoqIpJ0DaAu+/+V/H22vaTb3nfioJ2vwaWcV5tllarMdK1xZjXP6IWwE/ZurzQCHKzR605A
	iedWaPJhc1hPzk3Zp+VOJflOwaKs415TambTr96+TCRgAlJYCSlodA9dPV3hCo9pwv/UeD280IK
	02G3ED7PjXmPBcUT59pzgOsV7U60ZTnCMSfpaK7yYsJa/KBjiTOSUSuDB+ja5YsgxM3nwdh+TXa
	s=
X-Received: by 2002:a05:6000:70b:b0:487:81c:183f with SMTP id
 ffacd0b85a97d-4886704926dmr3859972f8f.10.1790164877652; Wed, 23 Sep 2026
 05:01:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260831145943.313726-1-andrew.jones@oss.qualcomm.com> <20260831145943.313726-13-andrew.jones@oss.qualcomm.com>
In-Reply-To: <20260831145943.313726-13-andrew.jones@oss.qualcomm.com>
From: Anup Patel <anup@brainfault.org>
Date: Wed, 23 Sep 2026 17:31:05 +0530
X-Gm-Features: AclHuK-2ObkketlET_SBsJ58iMsfQLM0zUzwlh7sLplMTaBDRnaBDkNaFuzixnM
Message-ID: <CAAhSdy36ZUbJ5OetQ0n7C8UYYBVhqUsbHc3+XMDOfXX2O9ZjmA@mail.gmail.com>
Subject: Re: [PATCH v5 12/17] irqchip/riscv-imsic: Support IOMMU MSI address lists
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
> RISC-V IOMMU host interrupt remapping maps every possible host IMSIC
> target into one contiguous IOVA range. MSI message composition therefore
> needs each target's position within that range.
>
> When the S-mode IMSIC address list is available, prepare the complete
> list while allocating an IRQ. This allows the IOMMU backend to map the
> pages and cache the contiguous base IOVA in the MSI descriptor. Skip the
> optional preparation when no list is available, allowing devices which
> do not need IOMMU MSI translation to keep using physical MSI messages.
>
> When the descriptor has an IOMMU MSI mapping, use the selected logical
> CPU directly as the page index within the IOVA range. Use the same path
> for initial composition and affinity updates. Messages remain physical
> when no IOMMU MSI mapping is required.
>
> Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
> ---
>  drivers/irqchip/Kconfig                    |  1 +
>  drivers/irqchip/irq-riscv-imsic-platform.c | 25 +++++++++++++++++++---
>  2 files changed, 23 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> index 42f2278a702d..c7cda52b21eb 100644
> --- a/drivers/irqchip/Kconfig
> +++ b/drivers/irqchip/Kconfig
> @@ -656,6 +656,7 @@ config RISCV_IMSIC
>         select IRQ_DOMAIN_HIERARCHY
>         select GENERIC_IRQ_MATRIX_ALLOCATOR
>         select GENERIC_MSI_IRQ
> +       select IRQ_MSI_IOMMU
>         select IRQ_MSI_LIB
>
>  config RISCV_RPMI_SYSMSI
> diff --git a/drivers/irqchip/irq-riscv-imsic-platform.c b/drivers/irqchip=
/irq-riscv-imsic-platform.c
> index 643c8e459611..6e26a31f7503 100644
> --- a/drivers/irqchip/irq-riscv-imsic-platform.c
> +++ b/drivers/irqchip/irq-riscv-imsic-platform.c
> @@ -10,6 +10,7 @@
>  #include <linux/cpu.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
> +#include <linux/iommu.h>
>  #include <linux/irq.h>
>  #include <linux/irqchip.h>
>  #include <linux/irqdomain.h>
> @@ -69,8 +70,10 @@ static void imsic_irq_ack(struct irq_data *d)
>         irq_move_irq(d);
>  }
>
> -static void imsic_irq_compose_vector_msg(struct imsic_vector *vec, struc=
t msi_msg *msg)
> +static void imsic_irq_compose_vector_msg(struct irq_data *d, struct imsi=
c_vector *vec,
> +                                        struct msi_msg *msg)
>  {
> +       struct msi_desc *desc =3D irq_data_get_msi_desc(d);
>         phys_addr_t msi_addr;
>
>         if (WARN_ON(!vec))
> @@ -79,6 +82,11 @@ static void imsic_irq_compose_vector_msg(struct imsic_=
vector *vec, struct msi_ms
>         if (WARN_ON(!imsic_cpu_page_phys(vec->cpu, 0, &msi_addr)))
>                 return;
>
> +       if (desc->iommu_msi_shift) {

Is it expected that iommu_msi_shift =3D=3D 0 means no IOMMU in the path?

> +               msi_addr =3D (desc->iommu_msi_iova << desc->iommu_msi_shi=
ft) +
> +                          vec->cpu * IMSIC_MMIO_PAGE_SZ;
> +       }
> +
>         msg->address_hi =3D upper_32_bits(msi_addr);
>         msg->address_lo =3D lower_32_bits(msi_addr);
>         msg->data =3D vec->local_id;
> @@ -86,7 +94,7 @@ static void imsic_irq_compose_vector_msg(struct imsic_v=
ector *vec, struct msi_ms
>
>  static void imsic_irq_compose_msg(struct irq_data *d, struct msi_msg *ms=
g)
>  {
> -       imsic_irq_compose_vector_msg(irq_data_get_irq_chip_data(d), msg);
> +       imsic_irq_compose_vector_msg(d, irq_data_get_irq_chip_data(d), ms=
g);
>  }
>
>  #ifdef CONFIG_SMP
> @@ -94,7 +102,7 @@ static void imsic_msi_update_msg(struct irq_data *d, s=
truct imsic_vector *vec)
>  {
>         struct msi_msg msg =3D { };
>
> -       imsic_irq_compose_vector_msg(vec, &msg);
> +       imsic_irq_compose_vector_msg(d, vec, &msg);
>         irq_data_get_irq_chip(d)->irq_write_msi_msg(d, &msg);
>  }
>
> @@ -225,7 +233,9 @@ static struct irq_chip imsic_irq_base_chip =3D {
>  static int imsic_irq_domain_alloc(struct irq_domain *domain, unsigned in=
t virq,
>                                   unsigned int nr_irqs, void *args)
>  {
> +       msi_alloc_info_t *info =3D args;
>         struct imsic_vector *vec;
> +       int ret;
>
>         /* Multi-MSI is not supported yet. */
>         if (nr_irqs > 1)
> @@ -235,6 +245,15 @@ static int imsic_irq_domain_alloc(struct irq_domain =
*domain, unsigned int virq,
>         if (!vec)
>                 return -ENOSPC;
>
> +       if (imsic->smode_msi_pa) {

The imsic_setup_state() will fail if smode_msi_pa creation fails at
boot time so this looks like a paranoid check.

> +               ret =3D iommu_dma_prepare_msi_list(info->desc, imsic->smo=
de_msi_pa,
> +                                                num_possible_cpus(), IMS=
IC_MMIO_PAGE_SZ);
> +               if (ret) {
> +                       imsic_vector_free(vec);
> +                       return ret;
> +               }
> +       }
> +
>         irq_domain_set_info(domain, virq, virq, &imsic_irq_base_chip, vec=
,
>                             handle_edge_irq, NULL, NULL);
>         irq_set_noprobe(virq);
> --
> 2.43.0
>

Regards,
Anup
