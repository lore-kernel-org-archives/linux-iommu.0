Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4544D9F7A
	for <iommu@lists.linux.dev>; Fri, 25 Sep 2026 15:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790351514; cv=pass; b=nS61NZPVWZWQL2FkXiuzvcZIuIvTP+ORzVN5yEHIMNc0fgQagqnCB6TNtbIytS+cMnbZy/OtigUM6VckDvh59jcvBvd9EU5zxbuti6NraRrm9J/Tsc6jzRwKnmLhsTvhOy2dijY0eGhgWrHtlBTfXZ33DT+cK2CFuLQOPM9HPIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790351514; c=relaxed/simple;
	bh=Jf2O3vX2s2gUIjt+C5kumMdxZmsulGyl9yMEzEeYwT0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X6zH8ku1j4MAnWd0S1gRv/KKX3bs3ojEafb25wMpUyllhaEl5OLJ6UU+uYpJF6SJl8K4cXjEM4bPnFIe0YmxGxTybQF4uG3zonyZXd9OXIbRPjbGAqfQoAPRM2Z16Pz00MlwkUa1VJ48ZIk211Tmnk2JzVD1pzms2oG2iZ5s0JI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b=UUDqjkRh; arc=pass smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b="UUDqjkRh"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-48881a62e09so422880f8f.2
        for <iommu@lists.linux.dev>; Fri, 25 Sep 2026 08:51:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790351502; cv=none;
        d=google.com; s=arc-20260327;
        b=rNqaC9uhVaMEJQYo+1i7RCIey6r+mylyb9FavTuNXKPU2laeaWybanAE5TqeFGvlNm
         kOFzU50TCC7v8CuID99h4VFk4LTy8CVo8ySuVD02AJv8mpxMWgIYpHTK28Q4n1djP4dx
         M9l84vRpq2u8DXzR+oHZZa1HF9I9Elywnqjh9Mwl78seMzwKVfrVmczRLz3t1YhPqCdm
         QF21BC8FClkOURg1hW1HtFCA+OdabgXu9i/nBhpU0YWMsJWKuQsIM04L2T6vDFTD9h8F
         CoRoYph2lwAWBtcPuabqdzDuOhDSEPt0Xs67ytmuYasdvChIAcHqi9WjkbJljLcxbnT2
         EAqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=noVybGNNqVJKCVT0Wn7kCfbdAb1ukBVBJPW474QG+2s=;
        fh=xmoVFU1z+k8cm3Lu4cFiDmvuV2i83WUzAoaS/Hj9UUs=;
        b=EZYfViMwPQWlxue1bfKrwPrBfscS4ykZj15Qe8LK0lLhf1N21pjlH1tINj2kWLp0/9
         kEYktgH9qcUsNkp39xff6Yo+YlqKyq55MDdLA0p5eUE3USfur6FKOGdw8+BNPLJTE5uW
         50Y3BalThMeut7faK/RVjzZXcT5SsBguMfffTsoGk1XZ3eVuu2Rl8PJN5UbXcDLGoXhB
         D24o1lo+xanhrjmPdWRxnKr9GONDRbhJmowyOvs4DGpEGd4lgOd6oC7VWdW3Fa6KCEcW
         92Nmzy7Mu/xxVYhWVRbRjwc1ahdit5BX7am3bWfu65DkjrsJ+NTSac5XNwxmIezOinR8
         NS3g==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1790351502; x=1790956302; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=noVybGNNqVJKCVT0Wn7kCfbdAb1ukBVBJPW474QG+2s=;
        b=UUDqjkRh9wvsNkEo0QiIpm5NW4WxMH43z33QzJwtmkB6wVF434phwgMp0Km79xqroH
         Dbej1lHUacd1lOewO7a3Ey4JUBJLO2aQmVSK2L0VrSkiJe7e6OLIyEUChs1d2wULHOiP
         u3Y/4huUxeRRtIqs8VjOM2ifSK3QSII5EHApmHrXr+jX8uXxQwr1nxJ8tL6p8jxWHGAT
         UgTeHDWjpeT6bDMdhUyc1DP828z4QROsK5L4oGgVbKt5VeB4SiAXI3JETXf48zvTTSrj
         7oP6Os+GbHE5UDB+39X0V46e+654Mx4LuKSbJizjEO8nJOhO0+syAtw9KA/+XwWjTPyg
         RXJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790351502; x=1790956302;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=noVybGNNqVJKCVT0Wn7kCfbdAb1ukBVBJPW474QG+2s=;
        b=lRy9RaXazw0QOcMHekhFkf4C7pvNB57ZOSTN388H4Fbh+oEUbogOeOmOH7mxJZjn0B
         1GrIz+tdVRoHCmS83giSfISCtodB/+KXLIrY4k0VoFVLJQl5oRsrpc0ZoyrSbtwySymG
         x2ngaT42wzQI7zGkUitHYrK0UDzwY5CMM1zna9KXMEBd3Ibwm26gpNEFhdfKl866Y9df
         6CGN7eHOKU07vyVcoTaD11jkRpKBZ5HeTP+6Xg3xu+Zz3eUkBatLBoUkVa5AZR4pCJDY
         lAbCGjOI7oaSuDKVyUG2W/xPJvHBV3DnsWCyUeZZQXo4pxYJMzNW6mHB9Iw68jk6TSVl
         h5DQ==
X-Forwarded-Encrypted: i=1; AKwUvBzbIweAqJU+B0oVtPXXgHqKcqV8qY180zHEvG94PEzSFbGTf4iCw6zxCkPvFu0EtZl07VN0Hw==@lists.linux.dev
X-Gm-Message-State: AFuF++njSUWT/JtQA5W107RGbZrvupc3q2f7kY89k2LTM1n40mmrSvUH
	8q/VQO8VS5s1WASTdwn7El7jotsy2myA2zo12Q4A3C2r8v+7v7ABC8fga3TF4ciKqlhqepc7RGu
	lVzTBLPYDJ9MrKldfUfuBYiaZRhZrVjfEq/Z1SOVKtw==
X-Gm-Gg: AYBFou3rZyHk/vT35FzDF8QJxKiUmG14NZZPcChKhvgWliva/1ZM9f7UQByX35JdG0C
	bQOtb8CPH6wOb4uRvCzlEvFbw2OvAi5UoTCfwtmTxrts8+PFk3RQ7zs3iymG670IZRT77WLSAM6
	aarjUO91X1+9ILivY9h59NG7iSGG/sAo4vDbGpF1k0M9KRtwYhefRNC3phIkEdgmxarf6RaBRXT
	Fhg2rITDRNj9dw+aLk/w5lYSWlmmefM92m1HLJ3mlNgu2Zqud6K/DDp1f6a3KkFbVu1rUqtWS9h
	68dSZ4YAA8HKNGnx6f0r6Ik/oLCS0RZDzF+zo7j5W3jHHBPFAzQ6fOkByGdckQFsL4qbsl+THSd
	lfLOV5S+F4HaFaN1GU4Tj32DgEiZinMkhMQBRJzntdJ28eNayc7IPaMCOp2XNSgAmw66sbE12je
	w=
X-Received: by 2002:a5d:5e88:0:b0:487:9a9:6d24 with SMTP id
 ffacd0b85a97d-4887171a503mr9892842f8f.19.1790351502520; Fri, 25 Sep 2026
 08:51:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260925151659.419512-1-andrew.jones@oss.qualcomm.com> <20260925151659.419512-11-andrew.jones@oss.qualcomm.com>
In-Reply-To: <20260925151659.419512-11-andrew.jones@oss.qualcomm.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 25 Sep 2026 21:21:28 +0530
X-Gm-Features: AclHuK9Smh7rGiwz-QHNVaoPdbwbyf3R_ZUrSV-K4y97wOA8f1Kpw1Exnt_jFjc
Message-ID: <CAAhSdy37AUsq0ixwiaGz5HwSJw+jTAonoCHG5Oi8h5=Hw+bXrw@mail.gmail.com>
Subject: Re: [PATCH v6 10/16] irqchip/riscv-imsic: Add MSI address list
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
> Upcoming RISC-V IOMMU interrupt remapping needs to map every possible
> host IMSIC target into one contiguous MSI IOVA range. MSI message
> composition then uses the target CPU's position within that range.
>
> Build an IMSIC physical address array indexed by logical CPU.
> Require every possible CPU to have an initialized IMSIC page before
> publishing the array. This preserves physical address zero as a valid
> target and guarantees the array has num_possible_cpus() entries.
>
> The array size and each target's index can therefore be derived
> directly, without storing duplicate count or per-CPU index metadata.
>
> Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
> Tested-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>

LGMT.

Reviewed-by: Anup Patel <anup@brainfault.org>
Acked-by: Anup Patel <anup@brainfault.org>

Thanks,
Anup

> ---
>  drivers/irqchip/irq-riscv-imsic-state.c | 32 +++++++++++++++++++++++++
>  drivers/irqchip/irq-riscv-imsic-state.h |  3 +++
>  2 files changed, 35 insertions(+)
>
> diff --git a/drivers/irqchip/irq-riscv-imsic-state.c b/drivers/irqchip/ir=
q-riscv-imsic-state.c
> index df38a7670a89..abd1cdb640ea 100644
> --- a/drivers/irqchip/irq-riscv-imsic-state.c
> +++ b/drivers/irqchip/irq-riscv-imsic-state.c
> @@ -709,6 +709,31 @@ static int __init imsic_get_mmio_resource(struct fwn=
ode_handle *fwnode,
>         return of_address_to_resource(to_of_node(fwnode), index, res);
>  }
>
> +static int __init imsic_init_msi_pa_list(void)
> +{
> +       struct imsic_global_config *global =3D &imsic->global;
> +       phys_addr_t *msi_pa_list;
> +       unsigned int cpu;
> +
> +       msi_pa_list =3D kcalloc(num_possible_cpus(), sizeof(*msi_pa_list)=
, GFP_KERNEL);
> +       if (!msi_pa_list)
> +               return -ENOMEM;
> +
> +       for_each_possible_cpu(cpu) {
> +               struct imsic_local_config *local =3D per_cpu_ptr(global->=
local, cpu);
> +
> +               if (!local->msi_va) {
> +                       kfree(msi_pa_list);
> +                       return -ENODEV;
> +               }
> +
> +               msi_pa_list[cpu] =3D local->msi_pa;
> +       }
> +
> +       imsic->msi_pa_list =3D msi_pa_list;
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
> +       rc =3D imsic_init_msi_pa_list();
> +       if (rc) {
> +               pr_err("%pfwP: failed to initialize MSI address list\n", =
fwnode);
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
> +       kfree(imsic->msi_pa_list);
>         kfree(imsic);
>         imsic =3D NULL;
>         return rc;
> diff --git a/drivers/irqchip/irq-riscv-imsic-state.h b/drivers/irqchip/ir=
q-riscv-imsic-state.h
> index c42ee180b305..e51c61dcced3 100644
> --- a/drivers/irqchip/irq-riscv-imsic-state.h
> +++ b/drivers/irqchip/irq-riscv-imsic-state.h
> @@ -50,6 +50,9 @@ struct imsic_priv {
>         /* Global configuration common for all HARTs */
>         struct imsic_global_config              global;
>
> +       /* MSI target physical addresses indexed by logical CPU for IOMMU=
 mapping */
> +       phys_addr_t                             *msi_pa_list;
> +
>         /* Per-CPU state */
>         struct imsic_local_priv __percpu        *lpriv;
>
> --
> 2.43.0
>
