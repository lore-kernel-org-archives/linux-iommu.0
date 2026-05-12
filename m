Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29DB364EB8
	for <iommu@lists.linux.dev>; Tue, 12 May 2026 17:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778606497; cv=pass; b=fP+11PBreXJSuaAWDehqhHOrv4Uxz/6VJgFGu4byegfI3OhLs5fpN1TaZZcYngCk7G9021ym5qTfbw+nTTU1dZtimtIe2wMvSSDIG38dWvANyJOLj9h9ylRQedbgk6Bth+PEVTE2/i+gc+1TqaOmknkuI9PNk2a2Yia+YJIS0C8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778606497; c=relaxed/simple;
	bh=zcYTOOYxC7xX5KD2g+rGVDLwBlYmwKwqKMbUARiKFEU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qwox5HZSmPVT3yDy9so66SInH7fOqmHnYtP3QJA4/yHYJYTTQJBK+WtG3NtuUFHGhL1+oJI0HEdOgujU/ppdsMjyAqD5xPL62GqNR7a8Y/HE14zfRZAONSsQhRx5VgOhpy5Dk+Znqn5locCl6208VodqmXUmlfmGqUGHGGUOi9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=J5zrLgvo; arc=pass smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="J5zrLgvo"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7dcdaf06498so3940089a34.2
        for <iommu@lists.linux.dev>; Tue, 12 May 2026 10:21:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778606495; cv=none;
        d=google.com; s=arc-20240605;
        b=ka33uHTHwYOUyVpZsC9MPByk6Su3hb1HBnrvcW5BYRUc9nyPJQAGaD/6oipDlz6Ord
         xjn3p4dniog9FGuFFfTxrTHRvXxxloS+9D/3XwnvyWR3xN2ajU3ivI7C9+zzDFOWA9Pg
         Gqz+WVSIYFFPQOAz4MBhB9Kl2Pc8VmSP6vZL3tVzsNBsoEMJhmL3JD+INCohz3pdAvkb
         Opn3iPLve5FeBOILxh9jcMyiDZazphE+SVsvolii3lz9EM7NT29crMxxad7OI6Y9mL4B
         3hX/eLfaTCTMzlY9JLeYE1dvmkyKVrxtfFhby4Ty/wZ7LoGYvxQ43B86x8AFfU/sB/XF
         6guQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=w4U5nnGfyr+nTyOXf43f1pYFnCF1Xh9M/5FcKXA/LTg=;
        fh=Jx2+wDCBACImBeOLL3ginEBIVOlKDtfUmvaGXQjSob0=;
        b=F/ggrlH+nX7VsFZd/Vt0Y8FzMY9PZrvu32v3UOmeVUUVLQu3MbH+u0aIJgHErw40f9
         HxGG5bKwUp8KRIKnIYXqFeRLID+jqZlUxq04WEyUzOKfdzRwOBmzhBem+LIwYNFc9XyF
         znVjkYj7/JCliZMtT/Ybax8Syp4OYuOBRSgu2mZyQMC5kcwQyS2n/YZ1PRdKl2IiMDkV
         64FsjMCiCgxL052/WLjnovR38k4sEvnO8V2T83VrqyL29kdWAZtN58OhZECHY9ZpMKRs
         xZPG+cCYZg0RtNciCOrcRk8yfMA/naLOAfHdN3sIWlo3xT8jXGoiCMhOKQDX0kAAdzFP
         GIIA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1778606495; x=1779211295; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w4U5nnGfyr+nTyOXf43f1pYFnCF1Xh9M/5FcKXA/LTg=;
        b=J5zrLgvo72yrxKOR7YXSqEigfsyQdrj/xmiS+bdbl0X4nwVeWo9GXrX2t3obu1yAn3
         mOFfh6AgmiLYpm6p1KHHpPH9TtOymqmoEPd57Pwrp3PEqYd0cTK2c5WXMg2h0xJTShy3
         IMOP/wKvMOCN2jGAKGvZoSowFgIlxoGqziG89wkBTkB3CG0W4leBH0N5AV6lbJBtHllt
         48s+ANVwqryAej1e1tLi/TAleagasP5m2Jx94LaE5+vuUfs79JkUdlRgFXqwUKE3/nxS
         bBYFNbAFOXxKmBAAjE0A659tM9WeQkBJkaw+yoUjQ3vOdBSEMnESG+dU6x36xqSZxqG3
         P5LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778606495; x=1779211295;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w4U5nnGfyr+nTyOXf43f1pYFnCF1Xh9M/5FcKXA/LTg=;
        b=P3BdJyEYq+7TcjpsPj0ira05rH2ILuNguZNOf4TDDOPWB8Cr1xpGQu4GBx8GTfKhmQ
         VeLYqhg1/bMIrWuTs4h0AEvauMgH/FIusFylds8z7vzTOwEOOSjgCpefGpKkScv/CWYV
         RtZnk4k7UsYOViIDuVjeGZgDMykm/usuIx/CHGceiU7Fb9qsCSgifzufs4qc6LRgMrP2
         fZo2EFjWt3hDQ1okTm+W08sDnIhRzMo7fhL22MNL/a+K5bZ0H7uGz978RnHdCZ8Vou9k
         DtdEMuxnAwlFkkWIuDCErwcz6l42DV8hnVxJ6S1zP4rMDTiplNyRNRrvqNWpm6c1Jiaf
         dBGQ==
X-Forwarded-Encrypted: i=1; AFNElJ/kk13cnzbjOw0HcfQ0E6drv39BjUKtrMF0FDfihAlLddx4t0u7ta1NOh7FiFHIuNWxt/S6MA==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywu7/10N70AeEqT6JjhbBPqzP7PlWdr2bVjPFMwnN6X8ycYkmBM
	TmG5gn/SNWyVBK5ucotDkpmr6hQ8xvwtiE/qVyH6w2SGQSPZiOGXc6or5NyVhpHOQKG4tcgYCSN
	gYiP/CCe5jog2kKQ7FFuZl333o97RZxs//6L+t1cSJA==
X-Gm-Gg: Acq92OGVVVN6nV35tk2NoygMar3h/7Q67ArRvZ6VLO+trwMwmTe23AX1eYEha6yyx20
	vtqUrkeqBuMzTZTHT0QpxGbkgG/6Q0hWMOj2GHCnMloVzQcbHG+suRdlgJISviib5O7S8sVZSBi
	AWUiPm5FSYSHtyhR/9noZhBrlaUi6MmdgZx9vI6dn/2XlBR0HKbkjkAoIuv4kDPSezsucmJ0/YJ
	O3nG62SplHersc7TkGNleTA12t7xDVv3e6eOHnbtgaIWxf9ifM+rJ0A7DGAz6v21QyNW/J6dsOs
	Z9wVet5X7YgialzJIVMu
X-Received: by 2002:a05:6820:1b0b:b0:69b:5696:e64d with SMTP id
 006d021491bc7-69b69d1d9dbmr2025814eaf.13.1778606494741; Tue, 12 May 2026
 10:21:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260508212339.381933-1-andrew.jones@oss.qualcomm.com> <20260508212339.381933-2-andrew.jones@oss.qualcomm.com>
In-Reply-To: <20260508212339.381933-2-andrew.jones@oss.qualcomm.com>
From: Tomasz Jeznach <tjeznach@rivosinc.com>
Date: Tue, 12 May 2026 10:21:22 -0700
X-Gm-Features: AVHnY4I6ENcqXOAeNBceyRtARGuUtboM3f4VQYc2dWNjFI_AlpyEsoddY8VIUj0
Message-ID: <CAH2o1u4kUFyJqzRVOH4W0NxC0znabvi4V8VTQsURgBDErC8hTw@mail.gmail.com>
Subject: Re: [PATCH 1/2] iommu/riscv: Map IMSIC addresses for paging domains
To: Andrew Jones <andrew.jones@oss.qualcomm.com>
Cc: linux-riscv@lists.infradead.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, joro@8bytes.org, will@kernel.org, 
	pjw@kernel.org, palmer@dabbelt.com, anup@brainfault.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, May 8, 2026 at 2:23=E2=80=AFPM Andrew Jones
<andrew.jones@oss.qualcomm.com> wrote:
>
> When IOMMU_DMA is enabled, devices get paging domains and MSI writes
> to IMSIC interrupt files must be handled correctly in the s-stage.
> As the device always writes to the host physical IMSIC addresses,
> which the IMSIC irqchip programs directly, install s-stage identity
> mappings for the host IMSICs. But, use IOMMU_RESV_DIRECT_RELAXABLE
> since the 1:1 mappings aren't required for device assignment.
>

Devices are expected to send MSI writes as MemWr with AT=3D00b, which
triggers address translation by the responsible IOMMU. While the
current MSI target address is identical to the IMSIC physical address,
direct mapping might work; however, I consider this an interim hack to
achieve basic MSI forwarding. It is quite similar to a workaround I
previously used utilizing IOMMU_RESV_MSI types [1], which worked well
enough with VFIO interfaces (assuming unsafe interrupts are
acceptable).

I would prefer to use the iommu_dma_prepare_msi() path, as Jason
suggested, or implement complete IRQ remapping for RISC-V IOMMU.

[1] https://github.com/tjeznach/linux/commit/3a165e1b8f7cc4d00770a932fc0840=
cfed760485

> Loop over the cpus rather than imsic groups to handle asymmetric
> configurations.
>
> Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
> ---
>  drivers/iommu/riscv/iommu.c         | 34 +++++++++++++++++++++++++++++
>  include/linux/irqchip/riscv-imsic.h |  7 ++++++
>  2 files changed, 41 insertions(+)
>
> diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> index a31f50bbad35..3c6aa9d69f95 100644
> --- a/drivers/iommu/riscv/iommu.c
> +++ b/drivers/iommu/riscv/iommu.c
> @@ -19,6 +19,7 @@
>  #include <linux/init.h>
>  #include <linux/iommu.h>
>  #include <linux/iopoll.h>
> +#include <linux/irqchip/riscv-imsic.h>
>  #include <linux/kernel.h>
>  #include <linux/pci.h>
>  #include <linux/generic_pt/iommu.h>
> @@ -1286,6 +1287,38 @@ static struct iommu_domain *riscv_iommu_alloc_pagi=
ng_domain(struct device *dev)
>         return &domain->domain;
>  }
>
> +static void riscv_iommu_get_resv_regions(struct device *dev, struct list=
_head *head)
> +{
> +       const struct imsic_global_config *imsic_global;
> +       unsigned int cpu;
> +
> +       if (!imsic_enabled())
> +               return;
> +
> +       imsic_global =3D imsic_get_global_config();
> +
> +       for_each_possible_cpu(cpu) {
> +               const struct imsic_local_config *local;
> +               struct iommu_resv_region *reg;
> +
> +               local =3D per_cpu_ptr(imsic_global->local, cpu);
> +               if (!local->msi_va)
> +                       continue;
> +
> +               /*
> +                * The device always writes to the host physical IMSIC ad=
dress, so install
> +                * identity mappings directly. Use IOMMU_RESV_DIRECT_RELA=
XABLE instead of
> +                * IOMMU_RESV_DIRECT since these 1:1 mappings are not req=
uired for assigned
> +                * devices.
> +                */

As mentioned earlier, the comment "1:1 mappings are not required for
assigned devices" is inaccurate, assuming we'd like MSI to work.

> +               reg =3D iommu_alloc_resv_region(local->msi_pa, IMSIC_MMIO=
_PAGE_SZ,
> +                                             IOMMU_WRITE | IOMMU_NOEXEC =
| IOMMU_MMIO,
> +                                             IOMMU_RESV_DIRECT_RELAXABLE=
, GFP_KERNEL);
> +               if (reg)
> +                       list_add_tail(&reg->list, head);
> +       }
> +}
> +
>  static int riscv_iommu_attach_blocking_domain(struct iommu_domain *iommu=
_domain,
>                                               struct device *dev,
>                                               struct iommu_domain *old)
> @@ -1401,6 +1434,7 @@ static const struct iommu_ops riscv_iommu_ops =3D {
>         .blocked_domain =3D &riscv_iommu_blocking_domain,
>         .release_domain =3D &riscv_iommu_blocking_domain,
>         .domain_alloc_paging =3D riscv_iommu_alloc_paging_domain,
> +       .get_resv_regions =3D riscv_iommu_get_resv_regions,
>         .device_group =3D riscv_iommu_device_group,
>         .probe_device =3D riscv_iommu_probe_device,
>         .release_device =3D riscv_iommu_release_device,
> diff --git a/include/linux/irqchip/riscv-imsic.h b/include/linux/irqchip/=
riscv-imsic.h
> index 4b348836de7a..ba3000f047b0 100644
> --- a/include/linux/irqchip/riscv-imsic.h
> +++ b/include/linux/irqchip/riscv-imsic.h
> @@ -88,6 +88,13 @@ static inline const struct imsic_global_config *imsic_=
get_global_config(void)
>
>  #endif
>
> +static inline bool imsic_enabled(void)
> +{
> +       const struct imsic_global_config *imsic_global =3D imsic_get_glob=
al_config();
> +
> +       return imsic_global && imsic_global->nr_ids;
> +}
> +
>  #if IS_ENABLED(CONFIG_ACPI) && IS_ENABLED(CONFIG_RISCV_IMSIC)
>  int imsic_platform_acpi_probe(struct fwnode_handle *fwnode);
>  struct fwnode_handle *imsic_acpi_get_fwnode(struct device *dev);
> --
> 2.43.0
>

Best,
- Tomasz
