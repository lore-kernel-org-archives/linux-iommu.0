Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C0D37AA8C
	for <iommu@lists.linux.dev>; Tue, 17 Feb 2026 23:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771372352; cv=pass; b=tGpyxoYhTcgR55TWLlhU3kR2PD/ygu8/t9wrSrhyQbZqhPdyVBr0Foms5xO8DD0pBW7h8RShaUlZBTsXFC//pZkYkKdd7cEafVRVeX1qDvKDN3TPZ6okjiYV6371pWQfMcwd1epFxIu0EonXjqeI8WEspmbMgGlBM8MWU4Y9rm0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771372352; c=relaxed/simple;
	bh=Vwro7Wz9SjBSlIO83YL+XYPsIeZvf67CFH4NHn1IiVw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ap7X7UnecEi4phPTRyu6K0ZdoZX40nryTjyfjnHOCzix4y3pIGxM07EkFxGOouysyYbLOFrZUnV1/zj0DN1Csrb+57hnhJXS58FquIQqKjOJD/V3nqrQHqKloj2h2WKlO0uheHUaOH/QQEPHJ3HXmyJjoJJ6ONQCnngd34bW/XU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XE10CCW3; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XE10CCW3"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-506a355aedfso212171cf.0
        for <iommu@lists.linux.dev>; Tue, 17 Feb 2026 15:52:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771372350; cv=none;
        d=google.com; s=arc-20240605;
        b=IB0/Smi6XtVdk48AVlZVVkRNpSxw7QbMfuqiRNsjZRSlA7ZE7HagR+AgCqjx2jWL4b
         U54Zh9vPtspSEVSAVHZlZnvGQdGa/PbJxxHfJPdKoTKgIQI7nOBRQ6pq+8j2VLLRr0Ux
         ijZg7yiJlAfJ9kBNY1Ln1JTGGgDlo8iq8khFojGiOAV6nUCvh0K5XihCNKJK0Wfm2wGd
         A3sdOC8+u8hnW+yHmDQrTSunqsUfJEZBkzpoKgd/njIghAqlJPBWBsKKQdtSxVVrA0RO
         M/xStDmR0oeRfrH/O9Fh1dFd+b/t4oa9Gqo08LB+r1EiszgdVRfyccDU8XUZ/wWhWhsL
         h6qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=U70LMDwg35hkWDfSQ7a2VjldoFXcwUPLfXcX3px64f0=;
        fh=hUcVhcJkBOhpp3V7ZX9fFJOrl8CTlFpIYVLHd6LHjpA=;
        b=KNRSD7HSlhq9zjR3tLuMmYuiIXKANoqEK5NxwSw1OUkXRhuin9+w3078DU5JKub/2O
         iF1v1xR7Cgh3TO5ZkYR+mrXp6Zqr3tRQaJJJJ2tnC0TCHcnAAuiPAyUfubVehvZHyjuu
         ocRfx4SLhGWojfcMYjl7DcGWpeX8+/EixynlH+JxjctzCjiyLEHMJqaoPqfqzAWe6JQz
         7d21f/SCixt45J5bJwbkcUz+FPGsxm1+xl1TEiAFOn0LbSRy2n6kFUSDmeezLd+dPVBw
         X3ol3wZKTqYTrIYoRvqBDB7pzSxVEcb56jtdoT9+rBoOoMbIhI2pLxLKTQ6Jtb5BEFJb
         ZJIA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771372350; x=1771977150; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U70LMDwg35hkWDfSQ7a2VjldoFXcwUPLfXcX3px64f0=;
        b=XE10CCW3gbXJZ4G8hLNTghw16yC88RnBKdR95X+X2b6TUkh1NltL+ReabmgMmt05Sb
         l1db/nhpiFHaIKJkaKU21bTkqGS77cje5Z6giffkcaa9JoizYou5ea/MYPE3mQ9J8hDV
         eWE0tShrYBHcK1HQ2mewzqSChlcpcREeWjQSMF7/pTBpcKQmo80ZFl10kZH5/5yz6FN8
         jNY/ne7PcbhGCCeryK9HX/+2+FfmifY24CNJ+ZdMJkLZhn5/THSsXft8zN4yv8Hc9TWq
         95nupkT8WwCKTavRzd7VzAoB/PmLsFqxpdXcwdHtW8leJ6UyAAnztkwz5S1DxksP1qTv
         Unhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771372350; x=1771977150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U70LMDwg35hkWDfSQ7a2VjldoFXcwUPLfXcX3px64f0=;
        b=cv3CeUy7f1/SYNG2zBPak/AsjHKuXYkivna9HSP5XcC98GsJvTSFn6dzEmPeGAIHZE
         5gtFVz3NJyqbZC4jHX0/QZfQNhd9YNxMtn6pMCRItUVavjtsQn13Qh1uP0ttfrURxG2/
         OzYCOoMvkKzH899/HfC1m2/Ww/hrqWjWEsDMeSd0n26lvmRL/C3BCUTtu2oHAN8CH6js
         61KwWuRxDEv8XrRub/11b3jPmdNVpsh+gKvIwVRXnbrrQHTMXHWAxezHzi3GpwGuB0vK
         34G4D2PNdDdW+DGZUZx0/eVfHxFSqlPdzYqTIhDAb7bUe6I3Ski8GsySoQOaei23C2sT
         R4KQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkOnLbmt/iYtF33vT3TCDt7GNa8fxA4Y+yjTLrU3J2NCOws5KpL/stUabm64VtqAQyUd7scg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxTMFmYljA9elJSZfSDni1U3QusbfpaDfJA5JWeXwVLAC2kblKK
	5tUQMm1Srw8sixp1GGuZWQfTfFbbNbIL6HZM7BeWFilbDbEAnnO9eOCNLh4EGI14RlPdIjOxJyF
	HQSlRX3pdlqnv8/uugO9h77OQgadf0LNH4hs6+jBs
X-Gm-Gg: AZuq6aJDDXdhKByEgoDRWwXNpJ9MNrWQUr53KeRnUKNPrvzE+M+XgbKjGFoOa1lUdrW
	VI3yJAyyMpBhQOiPNtxszBgLcFP1Tor1oa30xxdzbKXgL7GFKJ5ptXZr2YZJ1OFVbRVi8j+Gc3D
	UGzhn14nDO+COi2ojQ90mO1ZByBpSqMm4g+HgX0Ljpp+6MZZGK8ajxg3mue2bJtXgV3oFurdE8i
	vit4WUGgf7JfEB6PR3EDKlnoX/SCYvXf2an9VcwvCozwt9Mrg0A/4GhoRx1ZHVgxLM3bq9Zmozh
	qcgtJ7mZ+bZWHieVvUT+qaSYz+zQQDybGNttodHsww==
X-Received: by 2002:ac8:5a50:0:b0:4ff:bffa:d9e4 with SMTP id
 d75a77b69052e-506e89b0786mr1030271cf.13.1771372349200; Tue, 17 Feb 2026
 15:52:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260217214438.3395039-1-bhelgaas@google.com> <20260217214438.3395039-3-bhelgaas@google.com>
In-Reply-To: <20260217214438.3395039-3-bhelgaas@google.com>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Tue, 17 Feb 2026 15:52:17 -0800
X-Gm-Features: AaiRm5385l2y2PbYeHPbAeK2vhhbhFbPj9fF99vwXzsqu93DNzBiAJBLa6RgbIU
Message-ID: <CAAywjhQb8_ZF0kR475uWZFXm5D972yx59etCUa3fNZ22s0eZmw@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] iommu/vt-d: Remove dmar_writel() and dmar_writeq()
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 17, 2026 at 1:44=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> dmar_writel() and dmar_writeq() do nothing other than expand to the gener=
ic
> writel() and writeq(), and the dmar_write*() wrappers are used
> inconsistently.
>
> Remove the dmar_write*() wrappers and use writel() and writeq() directly.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/iommu/intel/dmar.c          |  2 +-
>  drivers/iommu/intel/iommu.c         | 12 ++++++------
>  drivers/iommu/intel/iommu.h         |  3 ---
>  drivers/iommu/intel/irq_remapping.c |  4 ++--
>  drivers/iommu/intel/perfmon.c       | 22 +++++++++++-----------
>  drivers/iommu/intel/prq.c           | 14 +++++++-------
>  6 files changed, 27 insertions(+), 30 deletions(-)
>
> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
> index 96d9878b9eb6..44d8361d2480 100644
> --- a/drivers/iommu/intel/dmar.c
> +++ b/drivers/iommu/intel/dmar.c
> @@ -1662,7 +1662,7 @@ static void __dmar_enable_qi(struct intel_iommu *io=
mmu)
>         /* write zero to the tail reg */
>         writel(0, iommu->reg + DMAR_IQT_REG);
>
> -       dmar_writeq(iommu->reg + DMAR_IQA_REG, val);
> +       writeq(val, iommu->reg + DMAR_IQA_REG);
>
>         iommu->gcmd |=3D DMA_GCMD_QIE;
>         writel(iommu->gcmd, iommu->reg + DMAR_GCMD_REG);
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 64284938e1ce..e75ce8d28be6 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -697,7 +697,7 @@ static void iommu_set_root_entry(struct intel_iommu *=
iommu)
>                 addr |=3D DMA_RTADDR_SMT;
>
>         raw_spin_lock_irqsave(&iommu->register_lock, flag);
> -       dmar_writeq(iommu->reg + DMAR_RTADDR_REG, addr);
> +       writeq(addr, iommu->reg + DMAR_RTADDR_REG);
>
>         writel(iommu->gcmd | DMA_GCMD_SRTP, iommu->reg + DMAR_GCMD_REG);
>
> @@ -765,7 +765,7 @@ static void __iommu_flush_context(struct intel_iommu =
*iommu,
>         val |=3D DMA_CCMD_ICC;
>
>         raw_spin_lock_irqsave(&iommu->register_lock, flag);
> -       dmar_writeq(iommu->reg + DMAR_CCMD_REG, val);
> +       writeq(val, iommu->reg + DMAR_CCMD_REG);
>
>         /* Make sure hardware complete it */
>         IOMMU_WAIT_OP(iommu, DMAR_CCMD_REG,
> @@ -806,8 +806,8 @@ void __iommu_flush_iotlb(struct intel_iommu *iommu, u=
16 did, u64 addr,
>         raw_spin_lock_irqsave(&iommu->register_lock, flag);
>         /* Note: Only uses first TLB reg currently */
>         if (val_iva)
> -               dmar_writeq(iommu->reg + tlb_offset, val_iva);
> -       dmar_writeq(iommu->reg + tlb_offset + 8, val);
> +               writeq(val_iva, iommu->reg + tlb_offset);
> +       writeq(val, iommu->reg + tlb_offset + 8);
>
>         /* Make sure hardware complete it */
>         IOMMU_WAIT_OP(iommu, tlb_offset + 8,
> @@ -4198,8 +4198,8 @@ int ecmd_submit_sync(struct intel_iommu *iommu, u8 =
ecmd, u64 oa, u64 ob)
>          * - It's not invoked in any critical path. The extra MMIO
>          *   write doesn't bring any performance concerns.
>          */
> -       dmar_writeq(iommu->reg + DMAR_ECEO_REG, ob);
> -       dmar_writeq(iommu->reg + DMAR_ECMD_REG, ecmd | (oa << DMA_ECMD_OA=
_SHIFT));
> +       writeq(ob, iommu->reg + DMAR_ECEO_REG);
> +       writeq(ecmd | (oa << DMA_ECMD_OA_SHIFT), iommu->reg + DMAR_ECMD_R=
EG);
>
>         IOMMU_WAIT_OP(iommu, DMAR_ECRSP_REG, readq,
>                       !(res & DMA_ECMD_ECRSP_IP), res);
> diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
> index dbd8d196d154..10331364c0ef 100644
> --- a/drivers/iommu/intel/iommu.h
> +++ b/drivers/iommu/intel/iommu.h
> @@ -148,9 +148,6 @@
>
>  #define OFFSET_STRIDE          (9)
>
> -#define dmar_writeq(a,v) writeq(v,a)
> -#define dmar_writel(a, v) writel(v, a)
> -
>  #define DMAR_VER_MAJOR(v)              (((v) & 0xf0) >> 4)
>  #define DMAR_VER_MINOR(v)              ((v) & 0x0f)
>
> diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/ir=
q_remapping.c
> index 3fce6efea524..ad3a8a42f70c 100644
> --- a/drivers/iommu/intel/irq_remapping.c
> +++ b/drivers/iommu/intel/irq_remapping.c
> @@ -465,8 +465,8 @@ static void iommu_set_irq_remapping(struct intel_iomm=
u *iommu, int mode)
>
>         raw_spin_lock_irqsave(&iommu->register_lock, flags);
>
> -       dmar_writeq(iommu->reg + DMAR_IRTA_REG,
> -                   (addr) | IR_X2APIC_MODE(mode) | INTR_REMAP_TABLE_REG_=
SIZE);
> +       writeq((addr) | IR_X2APIC_MODE(mode) | INTR_REMAP_TABLE_REG_SIZE,
> +              iommu->reg + DMAR_IRTA_REG);
>
>         /* Set interrupt-remapping table pointer */
>         writel(iommu->gcmd | DMA_GCMD_SIRTP, iommu->reg + DMAR_GCMD_REG);
> diff --git a/drivers/iommu/intel/perfmon.c b/drivers/iommu/intel/perfmon.=
c
> index 30bd684612ad..84f5ef2c42d8 100644
> --- a/drivers/iommu/intel/perfmon.c
> +++ b/drivers/iommu/intel/perfmon.c
> @@ -99,20 +99,20 @@ IOMMU_PMU_ATTR(filter_page_table,   "config2:32-36", =
       IOMMU_PMU_FILTER_PAGE_TABLE);
>  #define iommu_pmu_set_filter(_name, _config, _filter, _idx, _econfig)   =
       \
>  {                                                                       =
       \
>         if ((iommu_pmu->filter & _filter) && iommu_pmu_en_##_name(_econfi=
g)) {  \
> -               dmar_writel(iommu_pmu->cfg_reg + _idx * IOMMU_PMU_CFG_OFF=
SET +  \
> -                           IOMMU_PMU_CFG_SIZE +                         =
       \
> -                           (ffs(_filter) - 1) * IOMMU_PMU_CFG_FILTERS_OF=
FSET,  \
> -                           iommu_pmu_get_##_name(_config) | IOMMU_PMU_FI=
LTER_EN);\
> +               writel(iommu_pmu_get_##_name(_config) | IOMMU_PMU_FILTER_=
EN,    \
> +                      iommu_pmu->cfg_reg + _idx * IOMMU_PMU_CFG_OFFSET +=
       \
> +                      IOMMU_PMU_CFG_SIZE +                              =
       \
> +                      (ffs(_filter) - 1) * IOMMU_PMU_CFG_FILTERS_OFFSET)=
;      \
>         }                                                                =
       \
>  }
>
>  #define iommu_pmu_clear_filter(_filter, _idx)                           =
       \
>  {                                                                       =
       \
>         if (iommu_pmu->filter & _filter) {                               =
       \
> -               dmar_writel(iommu_pmu->cfg_reg + _idx * IOMMU_PMU_CFG_OFF=
SET +  \
> -                           IOMMU_PMU_CFG_SIZE +                         =
       \
> -                           (ffs(_filter) - 1) * IOMMU_PMU_CFG_FILTERS_OF=
FSET,  \
> -                           0);                                          =
       \
> +               writel(0,                                                =
       \
> +                      iommu_pmu->cfg_reg + _idx * IOMMU_PMU_CFG_OFFSET +=
       \
> +                      IOMMU_PMU_CFG_SIZE +                              =
       \
> +                      (ffs(_filter) - 1) * IOMMU_PMU_CFG_FILTERS_OFFSET)=
;      \
>         }                                                                =
       \
>  }
>
> @@ -411,7 +411,7 @@ static int iommu_pmu_assign_event(struct iommu_pmu *i=
ommu_pmu,
>         hwc->idx =3D idx;
>
>         /* config events */
> -       dmar_writeq(iommu_config_base(iommu_pmu, idx), hwc->config);
> +       writeq(hwc->config, iommu_config_base(iommu_pmu, idx));
>
>         iommu_pmu_set_filter(requester_id, event->attr.config1,
>                              IOMMU_PMU_FILTER_REQUESTER_ID, idx,
> @@ -510,7 +510,7 @@ static void iommu_pmu_counter_overflow(struct iommu_p=
mu *iommu_pmu)
>                         iommu_pmu_event_update(event);
>                 }
>
> -               dmar_writeq(iommu_pmu->overflow, status);
> +               writeq(status, iommu_pmu->overflow);
>         }
>  }
>
> @@ -524,7 +524,7 @@ static irqreturn_t iommu_pmu_irq_handler(int irq, voi=
d *dev_id)
>         iommu_pmu_counter_overflow(iommu->pmu);
>
>         /* Clear the status bit */
> -       dmar_writel(iommu->reg + DMAR_PERFINTRSTS_REG, DMA_PERFINTRSTS_PI=
S);
> +       writel(DMA_PERFINTRSTS_PIS, iommu->reg + DMAR_PERFINTRSTS_REG);
>
>         return IRQ_HANDLED;
>  }
> diff --git a/drivers/iommu/intel/prq.c b/drivers/iommu/intel/prq.c
> index c28fbd5c14a7..1460b57db129 100644
> --- a/drivers/iommu/intel/prq.c
> +++ b/drivers/iommu/intel/prq.c
> @@ -259,7 +259,7 @@ static irqreturn_t prq_event_thread(int irq, void *d)
>                 head =3D (head + sizeof(*req)) & PRQ_RING_MASK;
>         }
>
> -       dmar_writeq(iommu->reg + DMAR_PQH_REG, tail);
> +       writeq(tail, iommu->reg + DMAR_PQH_REG);
>
>         /*
>          * Clear the page request overflow bit and wake up all threads th=
at
> @@ -325,9 +325,9 @@ int intel_iommu_enable_prq(struct intel_iommu *iommu)
>                        iommu->name);
>                 goto free_iopfq;
>         }
> -       dmar_writeq(iommu->reg + DMAR_PQH_REG, 0ULL);
> -       dmar_writeq(iommu->reg + DMAR_PQT_REG, 0ULL);
> -       dmar_writeq(iommu->reg + DMAR_PQA_REG, virt_to_phys(iommu->prq) |=
 PRQ_ORDER);
> +       writeq(0ULL, iommu->reg + DMAR_PQH_REG);
> +       writeq(0ULL, iommu->reg + DMAR_PQT_REG);
> +       writeq(virt_to_phys(iommu->prq) | PRQ_ORDER, iommu->reg + DMAR_PQ=
A_REG);
>
>         init_completion(&iommu->prq_complete);
>
> @@ -348,9 +348,9 @@ int intel_iommu_enable_prq(struct intel_iommu *iommu)
>
>  int intel_iommu_finish_prq(struct intel_iommu *iommu)
>  {
> -       dmar_writeq(iommu->reg + DMAR_PQH_REG, 0ULL);
> -       dmar_writeq(iommu->reg + DMAR_PQT_REG, 0ULL);
> -       dmar_writeq(iommu->reg + DMAR_PQA_REG, 0ULL);
> +       writeq(0ULL, iommu->reg + DMAR_PQH_REG);
> +       writeq(0ULL, iommu->reg + DMAR_PQT_REG);
> +       writeq(0ULL, iommu->reg + DMAR_PQA_REG);
>
>         if (iommu->pr_irq) {
>                 free_irq(iommu->pr_irq, iommu);
> --
> 2.51.0
>
>

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
