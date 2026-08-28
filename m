Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FD12D3EEB
	for <iommu@lists.linux.dev>; Fri, 28 Aug 2026 02:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787883866; cv=pass; b=YQ5vtW1P7+lkZ7uLx6k6UQSDj4kJSjukI92KwZKA3mAUzW/iiscIj5nBKhGg2pgiQzlhCiu2rUdoItgYqcnaY+xcMkV8w2nLos9D7CxOPrVNtNKORwgdR9QVA3QQ07NwktgHEQY3Su7pkK/QNTj9NFr/IB2j0MjkSJ+jVxEsq4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787883866; c=relaxed/simple;
	bh=XssY/Ag2bMB7mb27MbqGh/p8ihJ49N4V0GEqbAMtdvU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I+fa7jake2vIObmfzAfXQ1afPVUN3hrv2wOMCLgaNKee58+J+rF56r0DCmNwET9X6xHbXdEpKLjK3oTRKqcWat7JHmnTo2BEaqAotbgC47uKKYQl5LDk1FtbamsVl/X9R6XhQCIIoBcPYnpe4YUD37vyS+ONahaHVMXOHbUTnv4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=lbrBsVKG; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="lbrBsVKG"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c160420289bso75363466b.0
        for <iommu@lists.linux.dev>; Thu, 27 Aug 2026 19:24:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787883862; cv=none;
        d=google.com; s=arc-20260327;
        b=FRFbs1vGA6GS6LFqw/m+CMORsY5JAmMNcoCAOlPcLW2/PxeKHX8GzKAxwZKlMtR3Zw
         siO7+fz+FF41qLt7UOXLSEv7WO0p3ZoQJIzESByqcgdxqKvRP5UhUDUYx0HlSRnUyXCM
         3XsYrLGDqMGcKkSnPQLRKKj5QEST8Z3gHg/gTdBE/EU3HP0ACIpiV/SA6vVFQr9hyDzR
         PryY9a0O/yRPcTyJM27T1CSTk55s8vMr18ghlMOkUF0qeE6ApHcg6Tzyl9TF8dAhj4+v
         OhrojtC+53NJHLTjB9gARwV1i3jSaYlMlQasg7IwJhb+0Se3AtMRnP2zTmc1/2wsU5sT
         94vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LpY4Xg0DZOqzdq9EYZ1ldhFFRYnkNlLXXK3mNdSnahk=;
        fh=WaJOcPE68Nt5Dmjd1PvPBfOFCfeGt2C74iBTKKLn5Vc=;
        b=dSSuFS/wUEIJS32TAgNLlkLBXu8B0QbpHafmsZtWVnlfRtNmdT00ZfWMF3QRqJwck9
         myOEj58TEa/qYLDwJcp5rknk/8scXoCvVIRNSdi87ykSz7nlO2ZIyrNJ1sdIOHCeQTQC
         CRteQI80uz2G7Kz+nm9xzOXOqUtSwLobrMdVcXjbWqP+8wL3MhuCsqkEIiwBl3NDF7FB
         BygehyC/2T8G6IOAmYJrbr9pXoWASqILmdIIt3lWE2YR8Rh8YitMXT+m2Rynk0lqTnoa
         GOz0+zxSZOF0hApioNEXV7IKY6KG56Xa4rl8TDYLPlrB6NnNuSZH3UI9Mn9RMn6Sd3GA
         ePGw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1787883862; x=1788488662; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LpY4Xg0DZOqzdq9EYZ1ldhFFRYnkNlLXXK3mNdSnahk=;
        b=lbrBsVKG3JASxQmxT7JOokKSZwXFAHGRhg9GYj8k3iD6E85fIhNWk6QUDP/DPvlML6
         +duwZ+X1KGlySlVn5Ggd3Bg6rW0b04AZES81rZLWF3hbJGtpuB7yH2QhOltEV7kKZAqX
         PrWikTzvzyLzkqjKcUvDTh45bPkrs1OJwaeahaHl0tEyoAQqRqtPnyRL/iiHP80cHsQW
         YlZptyEI/TMUyTQwI50+2JxJBVFi/o05aS/rBl1OHRU93DFS06Djuo33nO74U+mMb9cK
         AEld/efC7YmgCxLDZ1tfuEfQcKHlOO+MBwIqFczLuFODimlE7+rU4Xm5gkCQTOhEbgNs
         D9kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787883862; x=1788488662;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LpY4Xg0DZOqzdq9EYZ1ldhFFRYnkNlLXXK3mNdSnahk=;
        b=r7UhYPCmAIFWa+ewr7wkPRLc2pwyUwkwdyb7w9ImlkDemoHbl/f9/ysntRuvg9Nn9P
         Kth2vPFlMMOMPfqE0aFaBxk7XecFEvrfo6zMqW1gcWgbdkHxNYac9MCQoDauCyMZZidN
         NVbgBT24qMNQY5lDt1wTrYdKGfm3kmeyU6Pk3t8L8LhdrY9VmDuSJfVQDKLpE5K5Y5pz
         YTJPMv+6cFDY9Gg2dp5oqxtUw4RP93pA1W9rrt99OImRwN0xfeyI6T7G73AV3Zx8UI4Q
         i3wYFEdWTNmAdCQRRpYFGPE3/Z5/erc4i2o6UZPQ3k4fMmPcjdRCJWreQdcJAy6wwk19
         EWyA==
X-Forwarded-Encrypted: i=1; AHgh+RpWnaFz6qRn+/h9Sl1SQL226Acu23QrW/mHPGfVegIHVoCeOp57FRIlsatxKsdex5tJ0ZrgeQ==@lists.linux.dev
X-Gm-Message-State: AFuF++k0Fxr1PNykusO5iyelKs6BmiNJUSMxpP6OTXxcQQTKvRX3JorD
	qfCW17D73N81/bXNBjCMtn/vHXwxkx9ouycJScrFKzEQWaFOweqMdT/4CXLK6ax6I13TEecUR9n
	RCdqvahsVEjLqQsvcY2qoJeRa2NK8CiJIsgHDg7fjGg==
X-Gm-Gg: AR+sD10YnHsFouCIfVBIg1wjEYsvOnPy1Otcvx98wZidwWkMjSkRgrf+HBjIWZdsuz9
	umuK2VSlXk5s4CDZf0XQNqg4iBqzBLtFHUwSsF/PEcLT4lsF2UpU2knQAyZFkSEVZX7hZNFIdC3
	Wgfw3gVpRCYhEM/oQAXeNoMcS5lVCP0ZgrTo9Ln2sgbB/3yrzRzQtFUAgK7KNl5JcYV+mF/aHFv
	BD02t3sVbjs6AgFjsKMAVEu7RDWcagoIlUJebFt+pJZTqBKrz9c4MDOj1pVfcLoPBOQLKGbmADo
	vhECu+4LatwRmKmWQCdv3R2xzS+PAJJ1TM7DGzvTVn+952c=
X-Received: by 2002:a17:907:1c90:b0:c25:362e:fb8b with SMTP id
 a640c23a62f3a-c2556d9cd56mr193722766b.7.1787883861790; Thu, 27 Aug 2026
 19:24:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260714083625.1083606-1-zong.li@sifive.com> <20260714083625.1083606-2-zong.li@sifive.com>
 <6a5dc092-d0b5-4304-acfb-9de161f2bfd6@picoheart.com> <CANXhq0o1t5D76pscjqHteLjGJB4Z2iSS1a=o0+JCjKQtdPJ+vQ@mail.gmail.com>
 <47de2c31-04e0-4095-84a2-81e18b5fc855@picoheart.com>
In-Reply-To: <47de2c31-04e0-4095-84a2-81e18b5fc855@picoheart.com>
From: Zong Li <zong.li@sifive.com>
Date: Fri, 28 Aug 2026 10:24:10 +0800
X-Gm-Features: AcwNN1VOA2vMcYC0NmbKrDuaHyI1jtEH3jjzW6dgRq0nLljGyv_kKIaUYA5XyZo
Message-ID: <CANXhq0rmh3UoXt+=Wi6XBXrAi6nT8_XUUtdCZSMm=YWLV+Jpiw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] drivers/perf: riscv-iommu: add risc-v iommu pmu driver
To: Yicong Yang <yang.yicong@picoheart.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, pjw@kernel.org, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	mark.rutland@arm.com, andrew.jones@oss.qualcomm.com, guoren@kernel.org, 
	david.laight.linux@gmail.com, zhangzhanpeng.jasper@bytedance.com, 
	iommu@lists.linux.dev, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 5:32=E2=80=AFPM Yicong Yang <yang.yicong@picoheart.=
com> wrote:
>
> On 7/22/26 1:15 PM, Zong Li wrote:
> > On Mon, Jul 20, 2026 at 3:29=E2=80=AFPM Yicong Yang <yang.yicong@picohe=
art.com> wrote:
> >>
> >> Hi Zong,
> >>
> >> On 7/14/26 4:36 PM, Zong Li wrote:
> >>> Add a new driver to support the RISC-V IOMMU PMU. This is an auxiliar=
y
> >>> device driver created by the parent RISC-V IOMMU driver.
> >>>
> >>> The RISC-V IOMMU PMU separates the cycle counter from the event count=
ers.
> >>> The cycle counter is not associated with iohpmevt0, so a software-def=
ined
> >>> cycle event is required for the perf subsystem.
> >>>
> >>> The number and width of the counters are hardware-implemented and mus=
t
> >>> be detected at runtime.
> >>>
> >>> The performance monitor provides counters with filtering support to
> >>> collect events for specific device ID/process ID, or GSCID/PSCID.
> >>>
> >>> According to RISC-V IOMMU specification Chapter 6:
> >>> Whether an 8 byte access to an IOMMU register is single-copy atomic i=
s
> >>> UNSPECIFIED. Use two separate 4 byte accesses for hardware
> >>> compatibility.
> >>>
> >>> PMU-related definitions are moved into the perf driver, where they ar=
e
> >>> used exclusively.
> >>>
> >>> Suggested-by: David Laight <david.laight.linux@gmail.com>
> >>> Suggested-by: Guo Ren <guoren@kernel.org>
> >>> Link: https://lore.kernel.org/linux-riscv/20260618143634.7f3dd6c5@pum=
pkin/
> >>> Signed-off-by: Zong Li <zong.li@sifive.com>
> >>> ---
> >>>  drivers/iommu/riscv/iommu-bits.h |  61 ---
> >>>  drivers/perf/Kconfig             |  12 +
> >>>  drivers/perf/Makefile            |   1 +
> >>>  drivers/perf/riscv_iommu_pmu.c   | 722 +++++++++++++++++++++++++++++=
++
> >>>  4 files changed, 735 insertions(+), 61 deletions(-)
> >>>  create mode 100644 drivers/perf/riscv_iommu_pmu.c
> >>>
>
> [...]
>
> >>> +
> >>> +static irqreturn_t riscv_iommu_pmu_irq_handler(int irq, void *dev_id=
)
> >>> +{
> >>> +     struct riscv_iommu_pmu *pmu =3D (struct riscv_iommu_pmu *)dev_i=
d;
> >>> +     DECLARE_BITMAP(ovf_bitmap, RISCV_IOMMU_HPM_COUNTER_NUM);
> >>> +     u32 ovf, idx;
> >>> +
> >>> +     /* Check whether this interrupt is for PMU */
> >>> +     if (!(readl_relaxed(pmu->reg + RISCV_IOMMU_REG_IPSR) & RISCV_IO=
MMU_IPSR_PMIP))
> >>> +             return IRQ_NONE;
> >>> +
> >>> +     /* Process PMU IRQ */
> >>> +     riscv_iommu_pmu_stop_all(pmu);
> >>> +
> >>> +     ovf =3D readl(pmu->reg + RISCV_IOMMU_REG_IOCOUNTOVF);
> >>> +     if (!ovf)
> >>> +             return IRQ_NONE;
> >>> +
> >>> +     bitmap_from_u64(ovf_bitmap, ovf);
> >>> +     for_each_set_bit(idx, ovf_bitmap, pmu->num_counters) {
> >>> +             struct perf_event *event =3D pmu->events[idx];
> >>> +
> >>> +             if (WARN_ON_ONCE(!event))
> >>> +                     continue;
> >>> +
> >>> +             riscv_iommu_pmu_update(event);
> >>> +             riscv_iommu_pmu_set_period(event);
> >>> +             riscv_iommu_pmu_clear_ovf(event, idx);
> >>> +     }
> >>> +
> >>> +     /* Clear performance monitoring interrupt pending bit */
> >>> +     writel_relaxed(RISCV_IOMMU_IPSR_PMIP, pmu->reg + RISCV_IOMMU_RE=
G_IPSR);
> >>> +
> >>> +     riscv_iommu_pmu_start_all(pmu);
> >>> +
> >>> +     return IRQ_HANDLED;
> >>> +}
> >>> +
> >>> +static unsigned int riscv_iommu_pmu_get_irq_num(struct riscv_iommu_d=
evice *iommu)
> >>> +{
> >>> +     /* Reuse ICVEC.CIV mask for all interrupt vectors mapping */
> >>> +     int vec =3D (iommu->icvec >> (RISCV_IOMMU_INTR_PM * 4)) & RISCV=
_IOMMU_ICVEC_CIV;
> >>> +
> >>> +     return iommu->irqs[vec];
> >>> +}
> >>> +
> >>> +static int riscv_iommu_pmu_request_irq(struct riscv_iommu_device *io=
mmu,
> >>> +                                    struct riscv_iommu_pmu *pmu)
> >>> +{
> >>> +     return devm_request_irq(iommu->dev, pmu->irq, riscv_iommu_pmu_i=
rq_handler,
> >>> +                             IRQF_NOBALANCING | IRQF_SHARED, dev_nam=
e(iommu->dev), pmu);
> >>
> >> need IRQF_NO_THREAD to avoid force thread of the handler.
> >>
> >> it's a PMU exclusive interrupt, reason to make it IRQF_SHARED?
> >
> > PMU interrupt can be shared with the queue's interrupt (such as the
> > command queue, fault queue, and so on). Also, in the IOMMU driver,
> > these queue interrupts are handled as threaded IRQ
> >
>
> you can keep iommu's handler threaded while pmu's still in
> the top half, so it doesn't matter to set IRQF_SHARED.

I notieced that this conflates two independent checks in
__setup_irq(). Both are in kernel/irq/manage.c, on the path taken when
the virq already has an action installed:

         if (!((old->flags & new->flags) & IRQF_SHARED) ||
             (oldtype !=3D (new->flags & IRQF_TRIGGER_MASK)))
                 goto mismatch;

         if ((old->flags & IRQF_ONESHOT) &&
             (new->flags & IRQF_COND_ONESHOT))
                 new->flags |=3D IRQF_ONESHOT;
         else if ((old->flags ^ new->flags) & IRQF_ONESHOT)
                 goto mismatch;

There is no path anywhere in __setup_irq() that relaxes the
requirement because one requester runs in hard IRQ context and the
other one is threaded. The iommu driver requests its queue interrupts
with IRQF_ONESHOT | IRQF_SHARED, so old->flags has IRQF_SHARED.
Without it in new->flags the AND is zero and we take the mismatch
path, which means -EBUSY.

I will add a comment above the call recording why IRQF_SHARED is
needed, so this does not get dropped again in a later revision.

>
> if so we cannot ensure the count's updated in the atmoic
> context on event->cpu, which is required by the perf core
> to keep serializaiton. e.g. possible for the other users
> bind this irq to another cpu other than event->cpu?
>
>
> >>
> >>> +}
> >>> +
> >>> +static int riscv_iommu_pmu_probe(struct auxiliary_device *auxdev,
> >>> +                              const struct auxiliary_device_id *id)
> >>> +{
> >>> +     struct  riscv_iommu_device *iommu_dev =3D dev_get_platdata(&aux=
dev->dev);
> >>> +     struct riscv_iommu_pmu *iommu_pmu;
> >>> +     void __iomem *addr;
> >>> +     char *name;
> >>> +     int ret;
> >>> +
> >>> +     iommu_pmu =3D devm_kzalloc(&auxdev->dev, sizeof(*iommu_pmu), GF=
P_KERNEL);
> >>> +     if (!iommu_pmu)
> >>> +             return -ENOMEM;
> >>> +
> >>> +     iommu_pmu->reg =3D iommu_dev->reg;
> >>> +
> >>> +     /* Counter number and width are hardware-implemented. Detect th=
em by write 1s */
> >>> +     addr =3D iommu_pmu->reg + RISCV_IOMMU_REG_IOCOUNTINH;
> >>> +     writel(RISCV_IOMMU_IOCOUNTINH_HPM, addr);
> >>> +     iommu_pmu->num_counters =3D hweight32(readl(addr));
> >>> +
> >>> +     addr =3D iommu_pmu->reg + RISCV_IOMMU_REG_IOHPMCYCLES;
> >>> +     riscv_iommu_pmu_writeq(RISCV_IOMMU_IOHPMCYCLES_COUNTER, addr);
> >>> +     iommu_pmu->cycle_cntr_mask =3D riscv_iommu_pmu_readq(addr);
> >>> +
> >>> +     /* Assume the width of all event counters are the same */
> >>> +     addr =3D iommu_pmu->reg + RISCV_IOMMU_REG_IOHPMCTR_BASE;
> >>> +     riscv_iommu_pmu_writeq(RISCV_IOMMU_IOHPMCTR_COUNTER, addr);
> >>> +     iommu_pmu->event_cntr_mask =3D riscv_iommu_pmu_readq(addr);
> >>> +
> >>> +     iommu_pmu->pmu =3D (struct pmu) {
> >>> +             .module         =3D THIS_MODULE,
> >>> +             .parent         =3D &auxdev->dev,
> >>> +             .task_ctx_nr    =3D perf_invalid_context,
> >>> +             .event_init     =3D riscv_iommu_pmu_event_init,
> >>> +             .add            =3D riscv_iommu_pmu_add,
> >>> +             .del            =3D riscv_iommu_pmu_del,
> >>> +             .start          =3D riscv_iommu_pmu_start,
> >>> +             .stop           =3D riscv_iommu_pmu_stop,
> >>> +             .read           =3D riscv_iommu_pmu_read,
> >>> +             .attr_groups    =3D riscv_iommu_pmu_attr_grps,
> >>> +             .capabilities   =3D PERF_PMU_CAP_NO_EXCLUDE,
> >>> +     };
> >>> +
> >>> +     auxiliary_set_drvdata(auxdev, iommu_pmu);
> >>> +
> >>> +     name =3D devm_kasprintf(&auxdev->dev, GFP_KERNEL,
> >>> +                           "riscv_iommu_pmu_%s", dev_name(iommu_dev-=
>dev));
> >>
> >> this name is a bit unfriendly for a platform iommu. perf use ":" as
> >> a special delimiter, so I need to double quote the event like:
> >>
> >>   perf stat -e "'riscv_iommu_pmu_RSCV0004:00'/cycle/"
> >>
> >> possible to make it something like riscv_iommu_pmu_RSCV0004_00?
> >
> > Ok, this will also happen in the PCIe case. Let's find a way to modify
> > it. Or do you have any idea for the name?
> >
>
> maybe just replace ":" with "_" or use the PFN to distinguish
> like arm smmu pmcg. the latter one will eliminate the
> implementation differences (platform or pci device) but may
> not suitable since it's hard to find the connection between
> iommu and it's related pmu as iommu is still named by device
> name.
>
> I see the PCIe based IOMMU is named in the raw BDF encoding
> in fengyu's test [1] but it should be separate by ":", did
> I miss something for the name of PCIe based IOMMU?
>
> [1] https://lore.kernel.org/linux-riscv/20260714083625.1083606-1-zong.li@=
sifive.com/T/#m847cd5cba7f53e9191e09e64ef604c7c38fd0173
>
> >>
> >>> +     if (!name) {
> >>> +             dev_err(&auxdev->dev, "Failed to create name riscv_iomm=
u_pmu_%s\n",
> >>> +                     dev_name(iommu_dev->dev));
> >>> +             return -ENOMEM;
> >>> +     }
> >>> +
> >>> +     /* Bind all events to the same cpu context to avoid race enabli=
ng */
> >>> +     iommu_pmu->on_cpu =3D raw_smp_processor_id();
> >>
> >> smp_processor_id() should be enough.
> >
> > Perhaps we should try to get the local CPU of iommu as above.
> >
> >>
> >>> +     iommu_pmu->irq =3D riscv_iommu_pmu_get_irq_num(iommu_dev);
> >>> +     WARN_ON(irq_set_affinity(iommu_pmu->irq, cpumask_of(iommu_pmu->=
on_cpu)));
> >>> +
> >>> +     ret =3D riscv_iommu_pmu_request_irq(iommu_dev, iommu_pmu);
> >>> +     if (ret) {
> >>> +             dev_err(&auxdev->dev, "Failed to request irq %s: %d\n",=
 name, ret);
> >>> +             return ret;
> >>> +     }
> >>> +
> >>> +     ret =3D cpuhp_state_add_instance_nocalls(cpuhp_state, &iommu_pm=
u->node);
> >>> +     if (ret) {
> >>> +             dev_err(&auxdev->dev, "Failed to register hotplug %s: %=
d\n", name, ret);
> >>> +             return ret;
> >>> +     }
> >>> +
> >>> +     ret =3D perf_pmu_register(&iommu_pmu->pmu, name, -1);
> >>> +     if (ret) {
> >>> +             dev_err(&auxdev->dev, "Failed to registe %s: %d\n", nam=
e, ret);
> >>> +             goto err_unregister;
> >>> +     }
> >>> +
> >>> +     dev_info(&auxdev->dev, "%s: Registered with %d counters\n",
> >>> +              name, iommu_pmu->num_counters);
> >>> +
> >>> +     return 0;
> >>> +
> >>> +err_unregister:
> >>> +     cpuhp_state_remove_instance_nocalls(cpuhp_state, &iommu_pmu->no=
de);> +  return ret;
> >>> +}
> >>> +
> >>> +static const struct auxiliary_device_id riscv_iommu_pmu_id_table[] =
=3D {
> >>> +     { .name =3D "iommu.pmu" },
> >>
> >> it's clear and consistent to name it as "riscv-iommu.pmu".
> >> you've already have this "riscv" prefix in other places
> >> like the name of the PMU.
> >
> > Ok. Let's add prefix in the next version
> >
> >>
> >>> +     {}
> >>> +};
> >>> +MODULE_DEVICE_TABLE(auxiliary, riscv_iommu_pmu_id_table);
> >>> +
> >>> +static struct auxiliary_driver iommu_pmu_driver =3D {
> >>> +     .probe          =3D riscv_iommu_pmu_probe,
> >>
> >> need ->remove() to clean up the resources like PMU and cpuhp instance
> >> on driver unbind. otherwise you can use devm_add_action_or_reset()
> >> to make them device managed.
> >
> > As suggested by Robin in my v1 version,  we might be inclined to just
> > leave out all the dead cleanup code if the PMU driver is tied to the
> > IOMMU driver and can never realistically be removed. So in my
> > subsequent versions, I didn't add any cleanup code.
> >
>
> ok, thanks for the background.
>
> then need to ensure there will be no possible removal from the
> userspace, e.g. at least set driver::suppress_bind_attrs to
> avoid manual unbind.
>
> in fact it's the auxiliary device tied to the iommu driver
> rather than this auxiliary driver. as only the pmu and
> cpuhp registration lack cleanups (you've already made
> other resources device managed), it'll be easy to do
> the cleanups and support this driver as a module. but it's
> up to you.
>
> thanks.
>
> >>
> >>> +     .id_table       =3D riscv_iommu_pmu_id_table,
> >>> +};
> >>> +
> >>> +static int __init riscv_iommu_pmu_init(void)
> >>> +{
> >>> +     int ret;
> >>> +
> >>> +     cpuhp_state =3D cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN,
> >>> +                                           "perf/riscv/iommu:online"=
,
> >>> +                                           riscv_iommu_pmu_online_cp=
u,
> >>> +                                           riscv_iommu_pmu_offline_c=
pu);
> >>> +     if (cpuhp_state < 0)
> >>> +             return cpuhp_state;
> >>> +
> >>> +     ret =3D auxiliary_driver_register(&iommu_pmu_driver);
> >>> +     if (ret)
> >>> +             cpuhp_remove_multi_state(cpuhp_state);
> >>> +
> >>> +     return ret;
> >>> +}
> >>> +module_init(riscv_iommu_pmu_init);
> >>
> >> it'll be easy to make it a module for debug and test.
> >>
> >> thanks.
