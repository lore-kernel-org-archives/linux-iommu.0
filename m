Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A3937AA8C
	for <iommu@lists.linux.dev>; Tue, 17 Feb 2026 23:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771372371; cv=pass; b=aruoGyTvtDPp3NAvcobNe4ZncOdlJD7BbliSDowFojtU+yAtMdhRdtHyZ+CqU2cd1hK+iRkIDAqj459IDVvF0Em87r2by8X15SipP+zEMYRuMzMKsY5fWy8tKH5o/xR6IrP8UpqwKp3uiogKrEqLGmZM5cfv+y23W4426Paq1NU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771372371; c=relaxed/simple;
	bh=OaXFrEgBp5zm30w4sZTssC/84jDhBffTbo4kUzkfT5I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GTiPjT89Q3Za/fOw6XLekpsRGJgLPV10AV+oPRa8cvN4L9OqU7CFiaiuRaB3iwhRp1dmrfm1ipVi13iJ13KbmN5bHn4eW+hMPpb3cSsV05OH+Nq4LHakXEUglMMFbW3exd7hFu3f3NKgXcmUcqTi4TIthyWijg8vT+6N52wc2uI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hLrnjzbT; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hLrnjzbT"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-505d3baf1a7so116111cf.1
        for <iommu@lists.linux.dev>; Tue, 17 Feb 2026 15:52:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771372369; cv=none;
        d=google.com; s=arc-20240605;
        b=jQTwbZDs74ahYvqOq0yBMF+nawVFd4FU6SNLs1Xf9ZjCIvRAjoIKR1at1JaD9Cj8wA
         /1nwW9TB471lCzlbA77c2U1KsrAHIPoWNzPEG5Z5FOdcFQnnMACjkihqfb2yjZFnNvri
         OQO1vPcq5du4U9knQut9TBgXQNzaOB/qAVU0A9tHTgSObb4aSBiOdQm+l3T5YhYuPRGq
         8rjhg3VM1MF+bYAD+sGHppMLT2spDRakzzarzS7V44tJZa7A8z9mrrJQz6nq258Pa9iq
         CX3NHiFDfG5O2PjcG74ilM2Ke6CLpOFWMe5t0G1A89sWklZlZWdRLB8O4g4W4G5Af1PB
         pdww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0hOj4FBvf5ePTOC1w2mo9g/0cgTA9dvygNb55rf+USA=;
        fh=RbKMzCHIFX3x8M8JHksnjAapYfmOeRqptXV87bj+6Bs=;
        b=bmZRSZZj3QhnaLBWpzY9q3HR7u0R9LwWqqsE1hhsWndOGFr4AIn3SJ7umDbaVO4lYI
         OlEOHpfMvheaX9QOetQw6rCqK5TzDD/iuYxWIWgphzIaYai1gWZ7h8ZpMj2sLbxaxBmo
         Yl6922bIBjeFEDtfrZEKiEiMkTN+F6zlIskT1gic8sjOFV9spUqHVHjEi6EoiqhBO6zq
         3a8C7eIn/oOG7nTQQL/dnm8H09aLCr3v93sMwuMa/k+Pai+L/ek+Zu850j3uI4NG760T
         HIM5skpzV1FCyLd42aWmNuubFNf6PKHfbawZYdHS5yQ7ZiaABG2b08qki6KnKZcjNaDW
         Ruqg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771372369; x=1771977169; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0hOj4FBvf5ePTOC1w2mo9g/0cgTA9dvygNb55rf+USA=;
        b=hLrnjzbT55XVH6rXcbPnZ5n2IX2Zjrv2h9tIk/oRYFlTHHrBQNwwSLUdJ5o5am5tK5
         ZRf93Kp2mcU9nS+hCgZg23J+lQpc5WIsYRgGva2waFv2c0EKgOf01cF9+pI/xPodoYUs
         d3Qv2itQ2CgKZ3u2lgvSNPXC6QI6I3xzDE+QB2iUMOE6wyK0d5GCGZpBmX69/JplT/QV
         KkacaZm2voDsltMq/eqQqUlcwGR63ZxeiAEyjIjGh1BgnaUSXXShZ+L1J+AfhcCWd560
         eqtqdF3UEYTHuOYvkZ/RYzxPpAgTFltYwQfk5mjeKnoViZGkj6+JomXO80PTxgx1LD7r
         awmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771372369; x=1771977169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0hOj4FBvf5ePTOC1w2mo9g/0cgTA9dvygNb55rf+USA=;
        b=MNutg3o0CozL2yr6LoNkhCBCKuMQRbmSZ1kvEvAwlZu64qTh5pXUBfjWLO9VSPJB3B
         JnTTd5ITyGpSSXBP0ImSV80RAs4SbDLMo0sFFS+2FX3ZFHc7Ip73xTG5qzmSRrhRTCbr
         SU7r+9rZYrnTtze3dc4Zl2N6oFVbuwXf/q2hRQfENDXL7QuL6CooLBsBnnr9KixgKE3C
         B7u2ETSHwXaV0v4PBevKTpivwzeuZrPbw3DIIwc7mPmHH4ud2LKBSaU9WOTJixHL9+Jx
         9NM3bkI5/xKFaRhNREqI+zr28zoBFvuEsrKm+cS5S60ELqoYESxaJmixnAU8fACQq/3D
         2+FA==
X-Forwarded-Encrypted: i=1; AJvYcCXrNo4+YlWya0XTCXezan6Zk95sN8dbiqVwubn+iYhWtF398iEyYccNyxo/jGcqszHF035Heg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzXl+CUHIw7Jcf3ICiagHfja+Uw2y9yksr6z5t4R8dmDe28VM9S
	wOCp0W6d2Zeu9LlaiUCKcClSQaUytw0qsNvcNMwSc68bwyday25d6uFuiJ0bH6cGbKEVdh7QW2F
	SRx3A89LYhd4GInVqkEAoOZAsAPdsGA809arWjuJP
X-Gm-Gg: AZuq6aIxZ9AvwyphmskRiR6vpDvU/WcNe895UPFqrCgFM23A6fOz/vE3jt9/btrnw+o
	AsJKcW+9kGEWTlSmTPWf/QPlTlP/tktkRv/JzdkbIsLuJcOcGFF+Q3KAFCl3e/rd+V5aC2H9GES
	zTcteGZJYXQqbLG8w9vz6KlN3mN5iu9rm5xz4NK9OU80x8OTuslHkc0wzBPe0v2Jaz4Ywxrpof2
	bq81uKOsrmH9kM9d0zN6YuQxBRSc9FEZnZJhAf0pX8JOx7eNcGmKe38MLa8WptefxXWJB6csE5U
	kgiMleIm/cA3XYgY7hnE+UEjzci2hAwql41vE0Xw6A==
X-Received: by 2002:a05:622a:252:b0:4f1:a61a:1e8 with SMTP id
 d75a77b69052e-506e8622c6emr1224561cf.10.1771372368519; Tue, 17 Feb 2026
 15:52:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260217214438.3395039-1-bhelgaas@google.com> <20260217214438.3395039-2-bhelgaas@google.com>
In-Reply-To: <20260217214438.3395039-2-bhelgaas@google.com>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Tue, 17 Feb 2026 15:52:37 -0800
X-Gm-Features: AaiRm53N159S8MCVKRGwqkZK26IYTlciScy9hgzJ4FWQ02r2HrOBnUEV-z49us8
Message-ID: <CAAywjhQGbyByM8M1aV4NerYsQhNPK9LXOhkBGdok7Nz9RVNWUA@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] iommu/vt-d: Remove dmar_readl() and dmar_readq()
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
> dmar_readl() and dmar_readq() do nothing other than expand to the generic
> readl() and readq(), and the dmar_read*() wrappers are used inconsistentl=
y.
>
> Remove the dmar_read*() wrappers and use readl() and readq() directly.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/iommu/intel/debugfs.c       | 18 +++++++++---------
>  drivers/iommu/intel/dmar.c          | 22 +++++++++++-----------
>  drivers/iommu/intel/iommu.c         | 10 +++++-----
>  drivers/iommu/intel/iommu.h         |  2 --
>  drivers/iommu/intel/irq_remapping.c |  2 +-
>  drivers/iommu/intel/perfmon.c       | 28 ++++++++++++++--------------
>  drivers/iommu/intel/prq.c           | 12 ++++++------
>  7 files changed, 46 insertions(+), 48 deletions(-)
>
> diff --git a/drivers/iommu/intel/debugfs.c b/drivers/iommu/intel/debugfs.=
c
> index 617fd81a80f0..21e4e465ca58 100644
> --- a/drivers/iommu/intel/debugfs.c
> +++ b/drivers/iommu/intel/debugfs.c
> @@ -133,13 +133,13 @@ static int iommu_regset_show(struct seq_file *m, vo=
id *unused)
>                  */
>                 raw_spin_lock_irqsave(&iommu->register_lock, flag);
>                 for (i =3D 0 ; i < ARRAY_SIZE(iommu_regs_32); i++) {
> -                       value =3D dmar_readl(iommu->reg + iommu_regs_32[i=
].offset);
> +                       value =3D readl(iommu->reg + iommu_regs_32[i].off=
set);
>                         seq_printf(m, "%-16s\t0x%02x\t\t0x%016llx\n",
>                                    iommu_regs_32[i].regs, iommu_regs_32[i=
].offset,
>                                    value);
>                 }
>                 for (i =3D 0 ; i < ARRAY_SIZE(iommu_regs_64); i++) {
> -                       value =3D dmar_readq(iommu->reg + iommu_regs_64[i=
].offset);
> +                       value =3D readq(iommu->reg + iommu_regs_64[i].off=
set);
>                         seq_printf(m, "%-16s\t0x%02x\t\t0x%016llx\n",
>                                    iommu_regs_64[i].regs, iommu_regs_64[i=
].offset,
>                                    value);
> @@ -247,7 +247,7 @@ static void ctx_tbl_walk(struct seq_file *m, struct i=
ntel_iommu *iommu, u16 bus)
>                 tbl_wlk.ctx_entry =3D context;
>                 m->private =3D &tbl_wlk;
>
> -               if (dmar_readq(iommu->reg + DMAR_RTADDR_REG) & DMA_RTADDR=
_SMT) {
> +               if (readq(iommu->reg + DMAR_RTADDR_REG) & DMA_RTADDR_SMT)=
 {
>                         pasid_dir_ptr =3D context->lo & VTD_PAGE_MASK;
>                         pasid_dir_size =3D get_pasid_dir_size(context);
>                         pasid_dir_walk(m, pasid_dir_ptr, pasid_dir_size);
> @@ -285,7 +285,7 @@ static int dmar_translation_struct_show(struct seq_fi=
le *m, void *unused)
>
>         rcu_read_lock();
>         for_each_active_iommu(iommu, drhd) {
> -               sts =3D dmar_readl(iommu->reg + DMAR_GSTS_REG);
> +               sts =3D readl(iommu->reg + DMAR_GSTS_REG);
>                 if (!(sts & DMA_GSTS_TES)) {
>                         seq_printf(m, "DMA Remapping is not enabled on %s=
\n",
>                                    iommu->name);
> @@ -364,13 +364,13 @@ static int domain_translation_struct_show(struct se=
q_file *m,
>                 if (seg !=3D iommu->segment)
>                         continue;
>
> -               sts =3D dmar_readl(iommu->reg + DMAR_GSTS_REG);
> +               sts =3D readl(iommu->reg + DMAR_GSTS_REG);
>                 if (!(sts & DMA_GSTS_TES)) {
>                         seq_printf(m, "DMA Remapping is not enabled on %s=
\n",
>                                    iommu->name);
>                         continue;
>                 }
> -               if (dmar_readq(iommu->reg + DMAR_RTADDR_REG) & DMA_RTADDR=
_SMT)
> +               if (readq(iommu->reg + DMAR_RTADDR_REG) & DMA_RTADDR_SMT)
>                         scalable =3D true;
>                 else
>                         scalable =3D false;
> @@ -538,8 +538,8 @@ static int invalidation_queue_show(struct seq_file *m=
, void *unused)
>                 raw_spin_lock_irqsave(&qi->q_lock, flags);
>                 seq_printf(m, " Base: 0x%llx\tHead: %lld\tTail: %lld\n",
>                            (u64)virt_to_phys(qi->desc),
> -                          dmar_readq(iommu->reg + DMAR_IQH_REG) >> shift=
,
> -                          dmar_readq(iommu->reg + DMAR_IQT_REG) >> shift=
);
> +                          readq(iommu->reg + DMAR_IQH_REG) >> shift,
> +                          readq(iommu->reg + DMAR_IQT_REG) >> shift);
>                 invalidation_queue_entry_show(m, iommu);
>                 raw_spin_unlock_irqrestore(&qi->q_lock, flags);
>                 seq_putc(m, '\n');
> @@ -620,7 +620,7 @@ static int ir_translation_struct_show(struct seq_file=
 *m, void *unused)
>                 seq_printf(m, "Remapped Interrupt supported on IOMMU: %s\=
n",
>                            iommu->name);
>
> -               sts =3D dmar_readl(iommu->reg + DMAR_GSTS_REG);
> +               sts =3D readl(iommu->reg + DMAR_GSTS_REG);
>                 if (iommu->ir_table && (sts & DMA_GSTS_IRES)) {
>                         irta =3D virt_to_phys(iommu->ir_table->base);
>                         seq_printf(m, " IR table address:%llx\n", irta);
> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
> index ec975c73cfe6..96d9878b9eb6 100644
> --- a/drivers/iommu/intel/dmar.c
> +++ b/drivers/iommu/intel/dmar.c
> @@ -899,8 +899,8 @@ dmar_validate_one_drhd(struct acpi_dmar_header *entry=
, void *arg)
>                 return -EINVAL;
>         }
>
> -       cap =3D dmar_readq(addr + DMAR_CAP_REG);
> -       ecap =3D dmar_readq(addr + DMAR_ECAP_REG);
> +       cap =3D readq(addr + DMAR_CAP_REG);
> +       ecap =3D readq(addr + DMAR_ECAP_REG);
>
>         if (arg)
>                 iounmap(addr);
> @@ -982,8 +982,8 @@ static int map_iommu(struct intel_iommu *iommu, struc=
t dmar_drhd_unit *drhd)
>                 goto release;
>         }
>
> -       iommu->cap =3D dmar_readq(iommu->reg + DMAR_CAP_REG);
> -       iommu->ecap =3D dmar_readq(iommu->reg + DMAR_ECAP_REG);
> +       iommu->cap =3D readq(iommu->reg + DMAR_CAP_REG);
> +       iommu->ecap =3D readq(iommu->reg + DMAR_ECAP_REG);
>
>         if (iommu->cap =3D=3D (uint64_t)-1 && iommu->ecap =3D=3D (uint64_=
t)-1) {
>                 err =3D -EINVAL;
> @@ -1017,8 +1017,8 @@ static int map_iommu(struct intel_iommu *iommu, str=
uct dmar_drhd_unit *drhd)
>                 int i;
>
>                 for (i =3D 0; i < DMA_MAX_NUM_ECMDCAP; i++) {
> -                       iommu->ecmdcap[i] =3D dmar_readq(iommu->reg + DMA=
R_ECCAP_REG +
> -                                                      i * DMA_ECMD_REG_S=
TEP);
> +                       iommu->ecmdcap[i] =3D readq(iommu->reg + DMAR_ECC=
AP_REG +
> +                                                 i * DMA_ECMD_REG_STEP);
>                 }
>         }
>
> @@ -1239,8 +1239,8 @@ static const char *qi_type_string(u8 type)
>
>  static void qi_dump_fault(struct intel_iommu *iommu, u32 fault)
>  {
> -       unsigned int head =3D dmar_readl(iommu->reg + DMAR_IQH_REG);
> -       u64 iqe_err =3D dmar_readq(iommu->reg + DMAR_IQER_REG);
> +       unsigned int head =3D readl(iommu->reg + DMAR_IQH_REG);
> +       u64 iqe_err =3D readq(iommu->reg + DMAR_IQER_REG);
>         struct qi_desc *desc =3D iommu->qi->desc + head;
>
>         if (fault & DMA_FSTS_IQE)
> @@ -1322,7 +1322,7 @@ static int qi_check_fault(struct intel_iommu *iommu=
, int index, int wait_index)
>                  * SID field is valid only when the ITE field is Set in F=
STS_REG
>                  * see Intel VT-d spec r4.1, section 11.4.9.9
>                  */
> -               iqe_err =3D dmar_readq(iommu->reg + DMAR_IQER_REG);
> +               iqe_err =3D readq(iommu->reg + DMAR_IQER_REG);
>                 ite_sid =3D DMAR_IQER_REG_ITESID(iqe_err);
>
>                 writel(DMA_FSTS_ITE, iommu->reg + DMAR_FSTS_REG);
> @@ -1981,8 +1981,8 @@ irqreturn_t dmar_fault(int irq, void *dev_id)
>                         source_id =3D dma_frcd_source_id(data);
>
>                         pasid_present =3D dma_frcd_pasid_present(data);
> -                       guest_addr =3D dmar_readq(iommu->reg + reg +
> -                                       fault_index * PRIMARY_FAULT_REG_L=
EN);
> +                       guest_addr =3D readq(iommu->reg + reg +
> +                                          fault_index * PRIMARY_FAULT_RE=
G_LEN);
>                         guest_addr =3D dma_frcd_page_addr(guest_addr);
>                 }
>
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 705828b06e32..64284938e1ce 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -769,7 +769,7 @@ static void __iommu_flush_context(struct intel_iommu =
*iommu,
>
>         /* Make sure hardware complete it */
>         IOMMU_WAIT_OP(iommu, DMAR_CCMD_REG,
> -               dmar_readq, (!(val & DMA_CCMD_ICC)), val);
> +               readq, (!(val & DMA_CCMD_ICC)), val);
>
>         raw_spin_unlock_irqrestore(&iommu->register_lock, flag);
>  }
> @@ -811,7 +811,7 @@ void __iommu_flush_iotlb(struct intel_iommu *iommu, u=
16 did, u64 addr,
>
>         /* Make sure hardware complete it */
>         IOMMU_WAIT_OP(iommu, tlb_offset + 8,
> -               dmar_readq, (!(val & DMA_TLB_IVT)), val);
> +               readq, (!(val & DMA_TLB_IVT)), val);
>
>         raw_spin_unlock_irqrestore(&iommu->register_lock, flag);
>
> @@ -1533,7 +1533,7 @@ static int copy_translation_tables(struct intel_iom=
mu *iommu)
>         int bus, ret;
>         bool new_ext, ext;
>
> -       rtaddr_reg =3D dmar_readq(iommu->reg + DMAR_RTADDR_REG);
> +       rtaddr_reg =3D readq(iommu->reg + DMAR_RTADDR_REG);
>         ext        =3D !!(rtaddr_reg & DMA_RTADDR_SMT);
>         new_ext    =3D !!sm_supported(iommu);
>
> @@ -4185,7 +4185,7 @@ int ecmd_submit_sync(struct intel_iommu *iommu, u8 =
ecmd, u64 oa, u64 ob)
>
>         raw_spin_lock_irqsave(&iommu->register_lock, flags);
>
> -       res =3D dmar_readq(iommu->reg + DMAR_ECRSP_REG);
> +       res =3D readq(iommu->reg + DMAR_ECRSP_REG);
>         if (res & DMA_ECMD_ECRSP_IP) {
>                 ret =3D -EBUSY;
>                 goto err;
> @@ -4201,7 +4201,7 @@ int ecmd_submit_sync(struct intel_iommu *iommu, u8 =
ecmd, u64 oa, u64 ob)
>         dmar_writeq(iommu->reg + DMAR_ECEO_REG, ob);
>         dmar_writeq(iommu->reg + DMAR_ECMD_REG, ecmd | (oa << DMA_ECMD_OA=
_SHIFT));
>
> -       IOMMU_WAIT_OP(iommu, DMAR_ECRSP_REG, dmar_readq,
> +       IOMMU_WAIT_OP(iommu, DMAR_ECRSP_REG, readq,
>                       !(res & DMA_ECMD_ECRSP_IP), res);
>
>         if (res & DMA_ECMD_ECRSP_IP) {
> diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
> index 599913fb65d5..dbd8d196d154 100644
> --- a/drivers/iommu/intel/iommu.h
> +++ b/drivers/iommu/intel/iommu.h
> @@ -148,9 +148,7 @@
>
>  #define OFFSET_STRIDE          (9)
>
> -#define dmar_readq(a) readq(a)
>  #define dmar_writeq(a,v) writeq(v,a)
> -#define dmar_readl(a) readl(a)
>  #define dmar_writel(a, v) writel(v, a)
>
>  #define DMAR_VER_MAJOR(v)              (((v) & 0xf0) >> 4)
> diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/ir=
q_remapping.c
> index ecb591e98565..3fce6efea524 100644
> --- a/drivers/iommu/intel/irq_remapping.c
> +++ b/drivers/iommu/intel/irq_remapping.c
> @@ -422,7 +422,7 @@ static int iommu_load_old_irte(struct intel_iommu *io=
mmu)
>         u64 irta;
>
>         /* Check whether the old ir-table has the same size as ours */
> -       irta =3D dmar_readq(iommu->reg + DMAR_IRTA_REG);
> +       irta =3D readq(iommu->reg + DMAR_IRTA_REG);
>         if ((irta & INTR_REMAP_TABLE_REG_SIZE_MASK)
>              !=3D INTR_REMAP_TABLE_REG_SIZE)
>                 return -EINVAL;
> diff --git a/drivers/iommu/intel/perfmon.c b/drivers/iommu/intel/perfmon.=
c
> index 75f493bcb353..30bd684612ad 100644
> --- a/drivers/iommu/intel/perfmon.c
> +++ b/drivers/iommu/intel/perfmon.c
> @@ -307,7 +307,7 @@ static void iommu_pmu_event_update(struct perf_event =
*event)
>
>  again:
>         prev_count =3D local64_read(&hwc->prev_count);
> -       new_count =3D dmar_readq(iommu_event_base(iommu_pmu, hwc->idx));
> +       new_count =3D readq(iommu_event_base(iommu_pmu, hwc->idx));
>         if (local64_xchg(&hwc->prev_count, new_count) !=3D prev_count)
>                 goto again;
>
> @@ -340,7 +340,7 @@ static void iommu_pmu_start(struct perf_event *event,=
 int flags)
>         hwc->state =3D 0;
>
>         /* Always reprogram the period */
> -       count =3D dmar_readq(iommu_event_base(iommu_pmu, hwc->idx));
> +       count =3D readq(iommu_event_base(iommu_pmu, hwc->idx));
>         local64_set((&hwc->prev_count), count);
>
>         /*
> @@ -496,7 +496,7 @@ static void iommu_pmu_counter_overflow(struct iommu_p=
mu *iommu_pmu)
>          * Two counters may be overflowed very close. Always check
>          * whether there are more to handle.
>          */
> -       while ((status =3D dmar_readq(iommu_pmu->overflow))) {
> +       while ((status =3D readq(iommu_pmu->overflow))) {
>                 for_each_set_bit(i, (unsigned long *)&status, iommu_pmu->=
num_cntr) {
>                         /*
>                          * Find the assigned event of the counter.
> @@ -518,7 +518,7 @@ static irqreturn_t iommu_pmu_irq_handler(int irq, voi=
d *dev_id)
>  {
>         struct intel_iommu *iommu =3D dev_id;
>
> -       if (!dmar_readl(iommu->reg + DMAR_PERFINTRSTS_REG))
> +       if (!readl(iommu->reg + DMAR_PERFINTRSTS_REG))
>                 return IRQ_NONE;
>
>         iommu_pmu_counter_overflow(iommu->pmu);
> @@ -555,7 +555,7 @@ static int __iommu_pmu_register(struct intel_iommu *i=
ommu)
>  static inline void __iomem *
>  get_perf_reg_address(struct intel_iommu *iommu, u32 offset)
>  {
> -       u32 off =3D dmar_readl(iommu->reg + offset);
> +       u32 off =3D readl(iommu->reg + offset);
>
>         return iommu->reg + off;
>  }
> @@ -574,7 +574,7 @@ int alloc_iommu_pmu(struct intel_iommu *iommu)
>         if (!cap_ecmds(iommu->cap))
>                 return -ENODEV;
>
> -       perfcap =3D dmar_readq(iommu->reg + DMAR_PERFCAP_REG);
> +       perfcap =3D readq(iommu->reg + DMAR_PERFCAP_REG);
>         /* The performance monitoring is not supported. */
>         if (!perfcap)
>                 return -ENODEV;
> @@ -617,8 +617,8 @@ int alloc_iommu_pmu(struct intel_iommu *iommu)
>         for (i =3D 0; i < iommu_pmu->num_eg; i++) {
>                 u64 pcap;
>
> -               pcap =3D dmar_readq(iommu->reg + DMAR_PERFEVNTCAP_REG +
> -                                 i * IOMMU_PMU_CAP_REGS_STEP);
> +               pcap =3D readq(iommu->reg + DMAR_PERFEVNTCAP_REG +
> +                            i * IOMMU_PMU_CAP_REGS_STEP);
>                 iommu_pmu->evcap[i] =3D pecap_es(pcap);
>         }
>
> @@ -651,9 +651,9 @@ int alloc_iommu_pmu(struct intel_iommu *iommu)
>          * Width.
>          */
>         for (i =3D 0; i < iommu_pmu->num_cntr; i++) {
> -               cap =3D dmar_readl(iommu_pmu->cfg_reg +
> -                                i * IOMMU_PMU_CFG_OFFSET +
> -                                IOMMU_PMU_CFG_CNTRCAP_OFFSET);
> +               cap =3D readl(iommu_pmu->cfg_reg +
> +                           i * IOMMU_PMU_CFG_OFFSET +
> +                           IOMMU_PMU_CFG_CNTRCAP_OFFSET);
>                 if (!iommu_cntrcap_pcc(cap))
>                         continue;
>
> @@ -675,9 +675,9 @@ int alloc_iommu_pmu(struct intel_iommu *iommu)
>
>                 /* Override with per-counter event capabilities */
>                 for (j =3D 0; j < iommu_cntrcap_egcnt(cap); j++) {
> -                       cap =3D dmar_readl(iommu_pmu->cfg_reg + i * IOMMU=
_PMU_CFG_OFFSET +
> -                                        IOMMU_PMU_CFG_CNTREVCAP_OFFSET +
> -                                        (j * IOMMU_PMU_OFF_REGS_STEP));
> +                       cap =3D readl(iommu_pmu->cfg_reg + i * IOMMU_PMU_=
CFG_OFFSET +
> +                                   IOMMU_PMU_CFG_CNTREVCAP_OFFSET +
> +                                   (j * IOMMU_PMU_OFF_REGS_STEP));
>                         iommu_pmu->cntr_evcap[i][iommu_event_group(cap)] =
=3D iommu_event_select(cap);
>                         /*
>                          * Some events may only be supported by a specifi=
c counter.
> diff --git a/drivers/iommu/intel/prq.c b/drivers/iommu/intel/prq.c
> index ff63c228e6e1..c28fbd5c14a7 100644
> --- a/drivers/iommu/intel/prq.c
> +++ b/drivers/iommu/intel/prq.c
> @@ -81,8 +81,8 @@ void intel_iommu_drain_pasid_prq(struct device *dev, u3=
2 pasid)
>          */
>  prq_retry:
>         reinit_completion(&iommu->prq_complete);
> -       tail =3D dmar_readq(iommu->reg + DMAR_PQT_REG) & PRQ_RING_MASK;
> -       head =3D dmar_readq(iommu->reg + DMAR_PQH_REG) & PRQ_RING_MASK;
> +       tail =3D readq(iommu->reg + DMAR_PQT_REG) & PRQ_RING_MASK;
> +       head =3D readq(iommu->reg + DMAR_PQH_REG) & PRQ_RING_MASK;
>         while (head !=3D tail) {
>                 struct page_req_dsc *req;
>
> @@ -208,8 +208,8 @@ static irqreturn_t prq_event_thread(int irq, void *d)
>          */
>         writel(DMA_PRS_PPR, iommu->reg + DMAR_PRS_REG);
>
> -       tail =3D dmar_readq(iommu->reg + DMAR_PQT_REG) & PRQ_RING_MASK;
> -       head =3D dmar_readq(iommu->reg + DMAR_PQH_REG) & PRQ_RING_MASK;
> +       tail =3D readq(iommu->reg + DMAR_PQT_REG) & PRQ_RING_MASK;
> +       head =3D readq(iommu->reg + DMAR_PQH_REG) & PRQ_RING_MASK;
>         handled =3D (head !=3D tail);
>         while (head !=3D tail) {
>                 req =3D &iommu->prq[head / sizeof(*req)];
> @@ -268,8 +268,8 @@ static irqreturn_t prq_event_thread(int irq, void *d)
>         if (readl(iommu->reg + DMAR_PRS_REG) & DMA_PRS_PRO) {
>                 pr_info_ratelimited("IOMMU: %s: PRQ overflow detected\n",
>                                     iommu->name);
> -               head =3D dmar_readq(iommu->reg + DMAR_PQH_REG) & PRQ_RING=
_MASK;
> -               tail =3D dmar_readq(iommu->reg + DMAR_PQT_REG) & PRQ_RING=
_MASK;
> +               head =3D readq(iommu->reg + DMAR_PQH_REG) & PRQ_RING_MASK=
;
> +               tail =3D readq(iommu->reg + DMAR_PQT_REG) & PRQ_RING_MASK=
;
>                 if (head =3D=3D tail) {
>                         iopf_queue_discard_partial(iommu->iopf_queue);
>                         writel(DMA_PRS_PRO, iommu->reg + DMAR_PRS_REG);
> --
> 2.51.0
>
>

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
