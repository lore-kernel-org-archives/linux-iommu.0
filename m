Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B6E4CC294
	for <iommu@lists.linux.dev>; Fri, 25 Sep 2026 15:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790351575; cv=pass; b=pDH337WpMFgNjVfJwEt80N68Qht+KQFf7mHkXKqFqUN/3kC1IeYrxeWucMOkMHa+llpftp3JeqZ7qCbS3NCkjUCbR9R/c43x81cb3ItXlM27nifIoxyydH6t+0T72ws1ZaKEf1diZwcDJJ9/CqrY9U9NXRDwdZCeKPFYI+DSx3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790351575; c=relaxed/simple;
	bh=AWFiB9V++G9Q22T75aL/cEXhoU4UPD1FL5xpucU1Mrw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AnHuhp6i8rgJutZfNAWmhKzqdzYMdwDO9pA1nbw0htI63PdHg7v/L0oDEfScGu/91JoQGT1HzfbWY4yogT1qs24W8NrhHH548ap1KWvWY4g165rPmCeHZOHezLQi2IkQyijqiNo7+icaS/hhqhIFr9EyFyPOM72DjMl2pkN3gxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b=MWpj4anZ; arc=pass smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b="MWpj4anZ"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-485984ebf5cso813887f8f.0
        for <iommu@lists.linux.dev>; Fri, 25 Sep 2026 08:52:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790351568; cv=none;
        d=google.com; s=arc-20260327;
        b=anwK+JsTbHZkyX+pQRwOw5ytQxdmS08Wz3wNFaUDCxIUSk01XLRjdRd64g13HJO4uQ
         dHk8dN8j/amiW8QqgLHjH3ky+0aUGFCRJ6xlu9Nk9rhl+gCqwdVXgbH5XeqN1/E4vcRS
         sIs732vrb7uOYVS5nt4Vqc0YnLzjTKVsj7Zx0Pojl2LDl3UaqjvNy+2fhzBq1aeNZ5eO
         XwZny+Us5Afhynln4XHSDvLcGpfXXBWYL43KIQYaqUoHyCfsAwVrqrU6jsJqLzvhqcoO
         s3VJnUA7oVUy5dvhtOuxqCJyl4WtZ3OuhbefJwJGwaCtxSEBm+NXDhoGWjYd6DsOrtDe
         95xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=utwZNZ9pY4Xx5gq59KUjA7owWSl05dTqrvQ9otynvfA=;
        fh=aJ5VOcpIT7C1+B0ECO+xaAs5L3AtCip0Ekti/w0BxWo=;
        b=kFeErY4SrpJ8OLEmyCXjbO1usSq/NaQf/8SGhasPnwhHMdaNPtDPpMwKDmo5963u2K
         wam66Wq8G50NH6t+e16A1VvqEypeNpBX797GTKVs+Bhr4ncg8KpY79yxUg2Kiv8OHLjG
         YcQiGAZAaRMAcvxvst71JBYT0biEZmJHbCvhTU+ku1yTqC/n00UV7rdH7a4OoIuK3XOB
         BIw4y4R28d+ucalIvHlfCoDmj/A1L6IBeNuuJYdwyMnllXMce+QL8Dl3Ey1YNLt+2qHp
         /FIJTwZeGRLsaf+2ALO2yDMpHr6mnaNwUYWBtQOV6/Wkz2UQyYIzqfOcHlcioEI+1ufl
         T4kw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1790351568; x=1790956368; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=utwZNZ9pY4Xx5gq59KUjA7owWSl05dTqrvQ9otynvfA=;
        b=MWpj4anZcIh7oIzZKCaLwI3WP3hZn+TK0qTmN+DfbgEds6KX3Jf2mvrMWb83f1s172
         aOSb6iP3utn8pkCg/MezWaZ5lpRXaZZIGgWxZ6iVjhf2tF/AN1kQdJuLSOJZDmf8xPDQ
         moLhGsSflFeK+HOMwIXNr1CxBsTmzUnXtqV3uNHmMd1vLbg2zFCUdN92qf+tzhbvV1uG
         ILA3z6k1i4F9LjNu0rR/Q4AQuki8hqdD5Uk+AJodYVlsz2xT7nlfTP8A5TJSGuHT27lC
         WBAgQNjAI+XCtj0bE+mg98qtlAZ5DNIIyVf1peOfa04Jh+iEt41Va9j+bTs9Qjkx2CSw
         oBuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790351568; x=1790956368;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=utwZNZ9pY4Xx5gq59KUjA7owWSl05dTqrvQ9otynvfA=;
        b=2IehmQ6tHrd02VpoTupWgjFLW/9yYtR346hRk4ymDZikctQ1sK3FeX64UGqPbcWu6B
         UZunrQQGFIqd507HXlbAnECixFQiRpQooy2ZWrodj8DEn9WprOu5qa9YopY2ObePrbey
         s2Mq1DDcMiVJnEoA/mWBA5y1tjrzCp+yeMzvVRcvJgK8xS8GU7n95qhJ9vy9MheUOsEW
         hZFlkaZPbUieWtn3VOAY81g1Nk9LuyBFBiURg7wtgsEnMc1jyiEf4EvKN9PPmdPwjHlr
         A473fSqt4JXqmF27I8V2SPfeg2Yeh9jE9cMV3d35NkmvlblgMAW+BUyKY2pCVd9Cdnzk
         uFUA==
X-Forwarded-Encrypted: i=1; AKwUvBxxYRugGriU4XcvaBmzAjQpd60hLguCpBSsw1ZHohF1cEAUXFl2KlUmshvP/GLZxSZZ5B9u8Q==@lists.linux.dev
X-Gm-Message-State: AFuF++kQ53Ex8tbPlbCEOTPMlx+Jze6IOW/6SC7GGexlh1NEOtuNtn+l
	Yk4X9lrW8B6qBw9MqTLh6lIvsp3pNBKPBqtNRTkF2hz8zC6MoS35yXEtIm8D7AdRBl0ziHRnjLx
	VrgiA/a0w/ESqxWKkv6nG0iL1lOT0lsRSv61btV4PEA==
X-Gm-Gg: AYBFou0JoyV5MDgpH+GanjyCtWKpRUaLwFlq+K6r6hWR6yBTqF6HXqtfvipQHkyCb8B
	he6sqh4p1jKguzfYj0Y4DaglI+pACnvJESBQvBxtZ2qppqS4DRQT2xXyogiAnFxjvOYapF/1QeU
	bHNzdAdW8/ibuF8mUO5/m7w9ascO1OIbM0hbEHPf71xk3dlE56mbhBftqRVBWQcEeiddZbLAhPx
	TrBXsmNT5+6lECJ7bGOh+jGeKO4IGSpRpccwmBgDC6I//7ucTtsG9j+1lehGo0a43NR9fC0h7rG
	TDiyO+fDMi4J+w89uRfbKR2R7TaMVKBUjTdXKBzqN6hApKSAdcXeLjP96KXogcJ8zWtTRmJ2Ul5
	eurfgDdpmcG/6SefxVJGKsJAwRtf9YswEn1d5i7QEnvjiJQkgvwPKj4s/P4L/G6UzXBgxzOT7QK
	yNwucxq2RejA==
X-Received: by 2002:a05:6000:4b09:b0:488:6072:c0bc with SMTP id
 ffacd0b85a97d-48872a5d9a7mr10536030f8f.4.1790351568022; Fri, 25 Sep 2026
 08:52:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260925151659.419512-1-andrew.jones@oss.qualcomm.com> <20260925151659.419512-12-andrew.jones@oss.qualcomm.com>
In-Reply-To: <20260925151659.419512-12-andrew.jones@oss.qualcomm.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 25 Sep 2026 21:22:37 +0530
X-Gm-Features: AclHuK8pWQixNwcDzjZHyMQnruKEEP2VO1eZ6phkF3nVvr6l2DhyRC2oXU3yBTo
Message-ID: <CAAhSdy1a-poX0KKrHThmOzvSnLQVwDQdY_Anz3=zjSYOcboPJg@mail.gmail.com>
Subject: Re: [PATCH v6 11/16] irqchip/riscv-imsic: Support IOMMU MSI address lists
To: Andrew Jones <andrew.jones@oss.qualcomm.com>
Cc: linux-riscv@lists.infradead.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev, tjeznach@rivosinc.com, 
	jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, pjw@kernel.org, palmer@dabbelt.com, tglx@kernel.org, 
	kevin.tian@intel.com, fangyu.yu@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 8:47=E2=80=AFPM Andrew Jones
<andrew.jones@oss.qualcomm.com> wrote:
>
> RISC-V IOMMU host interrupt remapping maps every possible host IMSIC
> target into one contiguous IOVA range. MSI message composition therefore
> needs each target's position within that range.
>
> Prepare the complete IMSIC address list while allocating an IRQ. The
> list is guaranteed to exist after IMSIC state initialization. The IOMMU
> backend maps the pages and caches the contiguous base IOVA in the MSI
> descriptor when translation is needed.
>
> When the descriptor has an IOMMU MSI mapping, use the selected logical
> CPU directly as the page index within the IOVA range. Use the same path
> for initial composition and affinity updates. A zero iommu_msi_shift
> means no MSI address translation is required, so keep physical messages.
>
> Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
> Tested-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>

LGMT.

Reviewed-by: Anup Patel <anup@brainfault.org>
Acked-by: Anup Patel <anup@brainfault.org>

Thanks,
Anup

> ---
>  drivers/irqchip/Kconfig                    |  1 +
>  drivers/irqchip/irq-riscv-imsic-platform.c | 24 +++++++++++++++++++---
>  2 files changed, 22 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> index 20b77fbc51ee..a038e1121be3 100644
> --- a/drivers/irqchip/Kconfig
> +++ b/drivers/irqchip/Kconfig
> @@ -651,6 +651,7 @@ config RISCV_IMSIC
>         select IRQ_DOMAIN_HIERARCHY
>         select GENERIC_IRQ_MATRIX_ALLOCATOR
>         select GENERIC_MSI_IRQ
> +       select IRQ_MSI_IOMMU
>         select IRQ_MSI_LIB
>
>  config RISCV_RPMI_SYSMSI
> diff --git a/drivers/irqchip/irq-riscv-imsic-platform.c b/drivers/irqchip=
/irq-riscv-imsic-platform.c
> index 643c8e459611..ddb2bb570cdc 100644
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
> @@ -79,6 +82,12 @@ static void imsic_irq_compose_vector_msg(struct imsic_=
vector *vec, struct msi_ms
>         if (WARN_ON(!imsic_cpu_page_phys(vec->cpu, 0, &msi_addr)))
>                 return;
>
> +       /* A zero shift means no IOMMU MSI mapping is needed. */
> +       if (desc->iommu_msi_shift) {
> +               msi_addr =3D (desc->iommu_msi_iova << desc->iommu_msi_shi=
ft) +
> +                          vec->cpu * IMSIC_MMIO_PAGE_SZ;
> +       }
> +
>         msg->address_hi =3D upper_32_bits(msi_addr);
>         msg->address_lo =3D lower_32_bits(msi_addr);
>         msg->data =3D vec->local_id;
> @@ -86,7 +95,7 @@ static void imsic_irq_compose_vector_msg(struct imsic_v=
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
> @@ -94,7 +103,7 @@ static void imsic_msi_update_msg(struct irq_data *d, s=
truct imsic_vector *vec)
>  {
>         struct msi_msg msg =3D { };
>
> -       imsic_irq_compose_vector_msg(vec, &msg);
> +       imsic_irq_compose_vector_msg(d, vec, &msg);
>         irq_data_get_irq_chip(d)->irq_write_msi_msg(d, &msg);
>  }
>
> @@ -225,7 +234,9 @@ static struct irq_chip imsic_irq_base_chip =3D {
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
> @@ -235,6 +246,13 @@ static int imsic_irq_domain_alloc(struct irq_domain =
*domain, unsigned int virq,
>         if (!vec)
>                 return -ENOSPC;
>
> +       ret =3D iommu_dma_prepare_msi_list(info->desc, imsic->msi_pa_list=
,
> +                                        num_possible_cpus(), IMSIC_MMIO_=
PAGE_SZ);
> +       if (ret) {
> +               imsic_vector_free(vec);
> +               return ret;
> +       }
> +
>         irq_domain_set_info(domain, virq, virq, &imsic_irq_base_chip, vec=
,
>                             handle_edge_irq, NULL, NULL);
>         irq_set_noprobe(virq);
> --
> 2.43.0
>
