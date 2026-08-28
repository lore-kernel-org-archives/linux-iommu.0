Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1BA22FE0E
	for <iommu@lists.linux.dev>; Fri, 28 Aug 2026 01:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787880869; cv=pass; b=sa9Y39q/OYMo79atbYXplVmZyC1toe86VAjwobY8NJTCWk4FMBiq7o5wOiDHMRMP8EZ+uyxA/qQizjNylQ1cmponoqFbysyo4VxBoG56LKZr9t2WIIqiYbQLk17lLB62FDjRiAbo6Agpu1F8/zucUzn2yuWHvMSccHh+EE3BY3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787880869; c=relaxed/simple;
	bh=AUn4DkMjfbz0V9bw2QLRkD+OcVVZ5kBHdFTD2sSMLKU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y+LQJheSWQm3jwLoHJGnf1ySChhw9HIDUoTHRx2XTZ0pKAyLrfg8/7j//n0L8HiEPoJNBrjZLnmxfnIYY6EpHlaeAahpPuVS8S/YgLmlj+ozDn3WQxxPVufEWDihLF6HT0oFIIXWzJbJB59lE7Dr03kLcuiMfV9ddGVtuk8YklQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=W4Dt7oAM; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="W4Dt7oAM"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c2533d83e3bso75044166b.2
        for <iommu@lists.linux.dev>; Thu, 27 Aug 2026 18:34:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787880865; cv=none;
        d=google.com; s=arc-20260327;
        b=b7i1U6gzCI1JQvEyU5pk5pjPxxbXy7wOPZvNS7sqnPdDRrjNA6hrR8q7RM38nniDRX
         In/M+V0yd1fZlenFq1x3QjT/QD0yE5NVh5W+mwbB76TvfEHOyaH6iUk7KuA3eXrjRh3k
         I3Fq1598ANb7auZSpPB+6EIRDYmmN+iZBdBFAM3DwpgJ6k2BF2DyQcJJOOqkb4GGWTB0
         3Kg3O3BjtB95CDarXipa9XDZk0nZmR3TVaAmfCUYciwvziFm70cnE+q0m1J0u+suzR9G
         zVX/YTMLjnlK8MEb5cwnAVxqRkWP4lixP6DxqrXDBzPe35m4LW1cKm7z0Gyv+EhdCN0V
         AeGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rsZyppuQWLfhq5DS8SqBctU08ErRMd+s2J1xe+oQRY0=;
        fh=UPZUJxxmERkQt40+jj94FXeo8lWXF5gRF+5nCPWwWz0=;
        b=qtIX2KmrmwQsXUU1/lmFgTJn//fjL6y7poaP0skpBbjeqe15c1Hfxadg4HLFzNfc0p
         Sc91B/bJfJnO34tFn2dPu3xGNHGY8lRWQg9QglGkAgvsPW4aDCn5CTSOs/+znQKnEes1
         TAsh3iqRxnWiAYVJx1BXCDoowKiNZCsxMdd8HUJaJWPPXm2FFsugdp8HmEp2lmNhRcGM
         ujNLn0Dx6ozhSJiyvL0Af3JZFQSwHv7qmMUnx12bw2TuUR3g/eRzb5aaor4S345ZPRRy
         +v8tvm2YmOzY4yAMHGD59cANADM2TUq2TQdVB54YQUZO/B6qiI/c4SVnqNxHmZD/9hOI
         eeHQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1787880865; x=1788485665; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rsZyppuQWLfhq5DS8SqBctU08ErRMd+s2J1xe+oQRY0=;
        b=W4Dt7oAMtgOXNlKoJztAlg/FR/jnbTuMXsDRRKtXrAGcvxby83FuH0eOHFoYHVSbXS
         V8EaESFZI0TT5/ETog8m17et9+wEuRK7Beh3ZqHSdCrFT8HForXqPiEjtr4g+J0vafTp
         xdo+p/qw3VVgwrxv2gLKxK2l74TH14g90HDTuybQFuEoOFUUzaJFEyQ8Vy412dYErtcG
         jx8NF/V7ZxG3iuK7pY7w1xtKC6KUQCUoLHCDY7D912KOyjBU7/BMehcEA++FEnQ3GT+S
         2uCB9/piHXG8ye8O5ao5rqFzbuJ3HFZmwXGKOk6KjjV6OpgYVvXPq8UwB91OKE5NUYiz
         7fQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787880865; x=1788485665;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rsZyppuQWLfhq5DS8SqBctU08ErRMd+s2J1xe+oQRY0=;
        b=low+91BDZ4J+yV6DIM0/xI+IVt9CdS4CQ85y52hrcYIlU5Kg5Y+4baWq+svTzRKB5Y
         Lzjdm05BqQp7pHULEnNf+ECx0XDf8oA6qe1toxXcRlUEdTEAL78V3bMvj58O/5a0BZW4
         +WmbcV0OVclXFZw97Qyk+Hhxfzk+wMf4kyYpnaWmLI9jekk21OTokSXtOnUo2v1iMv+L
         Gf7TJyA2oe/cq+nSVCsNxsLNjGEA3Djw8YCFSgU/kt4hxmgaknUaGyEd86QQpqf9UKsU
         VBVL3xinHpF1zIu6/4LCvUh2e192STuH4swkDteiB6epDv6yiFVAdfRoM1BBgD+aAnhw
         KYkQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp5MiBDZ+m2zOveSohHod2c5p74dK+ZmzcA5MoKFaxfVuXepazHN9smRHqgq8tlMJO8b+E8qg==@lists.linux.dev
X-Gm-Message-State: AFuF++nMm4zmGO1BHEb5wF7nD8SPodIr3Ds/pmwi19sMNXHBM5L6Dwe6
	xKh534y+H3FXnubJCAt5/c6uv3l2SlYVrr38yKNRO6jXNtJhqNgZfjQzzcPLnbG1QBp1NXuka0h
	e5aI/kIMtPnibec4Pb+SKRe8ZkAOMoaytQiYU5TFo2Q==
X-Gm-Gg: AR+sD12Pqb7OvbqaAarqLskrOlS6gxYMTHzt0su4JyWjQSFZRiqaymUWFgGfSRxakmH
	sAUAumgjJ9920tykIsuxKClcz40Wlbg3DF5LQRWO41CmBnkG0BmZ5LD3hkm/cvtEvYqsfyMbWuc
	GvBvQ58bXRt8vvmcQu8sZScOXz66fgaPrwYlJXcn0FJHqit8BZEJYymnhInqHVy3NUl7bFpBiIt
	duFLw0szDHSJK9WF1TFiuCXLXP3gYfC/4McWiF26m34WEs9r2twCmWsuHURWMx3O3MGOpN8IIEg
	7SMvzYkmJ6oNC0bXAs8s9bEdWfC+qeJWUk97HiTNy9s5SkATffqsjH4BUQ==
X-Received: by 2002:a17:907:3c91:b0:c15:ee0d:9a32 with SMTP id
 a640c23a62f3a-c25571b8fa2mr166349366b.21.1787880865465; Thu, 27 Aug 2026
 18:34:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260824022034.3916570-1-zong.li@sifive.com> <20260824022034.3916570-2-zong.li@sifive.com>
 <ab59c5b8-2915-4d59-8766-7a6297224494@picoheart.com> <CANXhq0rBYWyLztFQzLCPx1vMSdahcuH-kfKPGO+WRDvFEW6Osg@mail.gmail.com>
 <6c4c4785-eb68-47b2-bbf5-ad77a9414100@picoheart.com>
In-Reply-To: <6c4c4785-eb68-47b2-bbf5-ad77a9414100@picoheart.com>
From: Zong Li <zong.li@sifive.com>
Date: Fri, 28 Aug 2026 09:34:13 +0800
X-Gm-Features: AcwNN1Xen4xFnCyv1PkZQefqoDWMXNLxWGjnJH5Zg8I4ZwvV5fK_3heb91B4sRM
Message-ID: <CANXhq0qrjGq26OoduJ9Z7NnMZOJnE5vqSQ=POhcD8vDJyTcUSQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] drivers/perf: riscv-iommu: add risc-v iommu pmu driver
To: Yicong Yang <yang.yicong@picoheart.com>
Cc: tomasz.jeznach@linux.dev, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, pjw@kernel.org, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, mark.rutland@arm.com, 
	andrew.jones@oss.qualcomm.com, guoren@kernel.org, 
	david.laight.linux@gmail.com, zhangzhanpeng.jasper@bytedance.com, 
	iommu@lists.linux.dev, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Chen Pei <cp0613@linux.alibaba.com>, Fangyu Yu <fangyu.yu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026 at 5:57=E2=80=AFPM Yicong Yang <yang.yicong@picoheart.=
com> wrote:
>
> On 8/27/26 5:22 PM, Zong Li wrote:
> > On Wed, Aug 26, 2026 at 4:28=E2=80=AFPM Yicong Yang <yang.yicong@picohe=
art.com> wrote:
> >>
> >> On 8/24/26 10:20 AM, Zong Li wrote:
> >>> Add a new driver to support the RISC-V IOMMU PMU. This is an auxiliar=
y
> >>> device driver created by the parent RISC-V IOMMU driver.
> >>>
> >>> The performance monitor provides counters with filtering support to
> >>> collect events for specific device ID/process ID, or GSCID/PSCID.
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
> >>> Leave out all the dead cleanup code (i.e. .remove() operation) if the
> >>> PMU driver is tied to the IOMMU driver and can never realistically be
> >>> removed.
> >>>
> >>> PMU-related definitions are moved into the perf driver, where they ar=
e
> >>> used exclusively.
> >>>
> >>> According to RISC-V IOMMU specification Chapter 6:
> >>> Whether an 8 byte access to an IOMMU register is single-copy atomic i=
s
> >>> UNSPECIFIED. Use two separate 4 byte accesses for hardware
> >>> compatibility.
> >>>
> >>> Tested-by: Chen Pei <cp0613@linux.alibaba.com>
> >>> Tested-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
> >>> Reviewed-by: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>
> >>> Suggested-by: David Laight <david.laight.linux@gmail.com>
> >>> Suggested-by: Guo Ren <guoren@kernel.org>
> >>> Link: https://lore.kernel.org/linux-riscv/20260618143634.7f3dd6c5@pum=
pkin/
> >>> Signed-off-by: Zong Li <zong.li@sifive.com>
> >>> ---
> >>>  drivers/iommu/riscv/iommu-bits.h |  61 ---
> >>>  drivers/perf/Kconfig             |  12 +
> >>>  drivers/perf/Makefile            |   1 +
> >>>  drivers/perf/riscv_iommu_pmu.c   | 813 +++++++++++++++++++++++++++++=
++
> >>>  4 files changed, 826 insertions(+), 61 deletions(-)
> >>>  create mode 100644 drivers/perf/riscv_iommu_pmu.c
> >>>
> >>
> >> [...]
> >>
> >>> +
> >>> +/* cpumask */
> >>> +static ssize_t riscv_iommu_cpumask_show(struct device *dev,
> >>> +                                     struct device_attribute *attr,
> >>> +                                     char *buf)
> >>> +{
> >>> +     struct riscv_iommu_pmu *pmu =3D to_riscv_iommu_pmu(dev_get_drvd=
ata(dev));
> >>> +
> >>> +     return cpumap_print_to_pagebuf(true, buf, cpumask_of(pmu->on_cp=
u));
> >>
> >> needs to use sysfs_emit(), cpumap_print_to_pagebuf is removed in 7.3-r=
c
> >>
> >> https://lore.kernel.org/lkml/20260702154725.185376-1-ynorov@nvidia.com=
/
> >>
> >
> > I will fix it in the next version. Thanks
> >
> >>> +}
> >>> +
> >>
> >> [...]
> >>
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
> >>> +     /*
> >>> +      * Counter number and width are hardware-implemented.
> >>> +      * Detect them by write 1s. Counter should be consecutive.
> >>> +      */
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
> >>> +                           "riscv_iommu_pmu_%u", auxdev->id);
> >>> +     if (!name) {
> >>> +             dev_err(&auxdev->dev, "Failed to create name riscv_iomm=
u_pmu%u\n",
> >>> +                     auxdev->id);
> >>> +             return -ENOMEM;
> >>> +     }
> >>> +
> >>> +     iommu_pmu->numa_node =3D dev_to_node(iommu_dev->dev);
> >>> +     iommu_pmu->irq =3D riscv_iommu_pmu_get_irq_num(iommu_dev);
> >>> +
> >>> +     ret =3D riscv_iommu_pmu_request_irq(auxdev, iommu_dev, iommu_pm=
u);
> >>> +     if (ret) {
> >>> +             dev_err(&auxdev->dev, "Failed to request irq %s: %d\n",=
 name, ret);
> >>> +             return ret;
> >>> +     }
> >>> +
> >>> +     /*
> >>> +      * Bind all events to the same cpu context to avoid race enabli=
ng.
> >>> +      * Pick a local CPU from the numa node of this iommu for the lo=
cality.
> >>> +      *
> >>> +      * Hold the hotplug lock until this instance is registered, oth=
erwise
> >>> +      * the CPU picked here could go offline in between. The teardow=
n
> >>> +      * callback does not run for an instance which is not registere=
d yet,
> >>> +      * so nothing would move the PMU off that CPU afterwards.
> >>> +      */
> >>> +     cpus_read_lock();
> >>> +
> >>> +     iommu_pmu->on_cpu =3D cpumask_local_spread(0, iommu_pmu->numa_n=
ode);
> >>> +     ret =3D irq_set_affinity(iommu_pmu->irq, cpumask_of(iommu_pmu->=
on_cpu));
> >>> +     if (ret)
> >>> +             dev_dbg(&auxdev->dev, "failed to set irq %u affinity to=
 cpu %u: %d\n",
> >>> +                     iommu_pmu->irq, iommu_pmu->on_cpu, ret);
> >>> +
> >>> +     ret =3D cpuhp_state_add_instance_nocalls_cpuslocked(cpuhp_state=
,
> >>> +                                                      &iommu_pmu->no=
de);
> >>> +
> >>> +     cpus_read_unlock();
> >>
> >> it could be simplified to init the ->on_cpu in the hotplug handler wit=
hout
> >> holding the cpu hotplug lock like below:
> >>
> >> iommu_pmu->on_cpu =3D -1;
> >> ret =3D cpuhp_state_add_instance() /* init the ->on_cpu in the hotplug=
 handler */
> >
> > It seems we might lose the benefits of cumask_local_spread this way.
> >
>
> could use cpumask_local_spread() in the online handler for a local cpu,
> refer to dwc_pcie_pmu.c.

Yes, you are right. Let's modify it in the next version. Thanks

>
> >>
> >> otherwise looks good to me.
> >>
> >> Reviewed-by: Yicong Yang <yang.yicong@picoheart.com>
> >>
> >>> +
> >>> +     if (ret) {
> >>> +             dev_err(&auxdev->dev, "Failed to register hotplug %s: %=
d\n", name, ret);
> >>> +             return ret;
> >>> +     }
> >>> +
> >>> +     ret =3D devm_add_action_or_reset(&auxdev->dev,
> >>> +                                    riscv_iommu_pmu_remove_cpuhp_ins=
tance,
> >>> +                                    iommu_pmu);
> >>> +     if (ret)
> >>> +             return ret;
> >>> +
> >>> +     ret =3D perf_pmu_register(&iommu_pmu->pmu, name, -1);
> >>> +     if (ret) {
> >>> +             dev_err(&auxdev->dev, "Failed to registe %s: %d\n", nam=
e, ret);
> >>> +             return ret;
> >>> +     }
> >>> +
> >>> +     ret =3D devm_add_action_or_reset(&auxdev->dev,
> >>> +                                    riscv_iommu_pmu_do_unregister,
> >>> +                                    iommu_pmu);
> >>> +     if (ret)
> >>> +             return ret;
> >>> +
> >>> +     /*
> >>> +      * The PMU name only carries the aux dev id, not the iommu dev =
name, so
> >>> +      * find the iommu dev name here to map this PMU back to its iom=
mu dev.
> >>> +      */
> >>> +     dev_info(&auxdev->dev, "%s: Registered with %d counters (iommu =
%s)\n",
> >>> +              name, iommu_pmu->num_counters, dev_name(iommu_dev->dev=
));
> >>> +
> >>> +     return 0;
> >>> +}
> >>> +
> >>> +static const struct auxiliary_device_id riscv_iommu_pmu_id_table[] =
=3D {
> >>> +     { .name =3D "riscv-iommu.pmu" },
> >>> +     {}
> >>> +};
> >>> +MODULE_DEVICE_TABLE(auxiliary, riscv_iommu_pmu_id_table);
> >>> +
> >>> +static struct auxiliary_driver iommu_pmu_driver =3D {
> >>> +     .driver =3D {
> >>> +             .suppress_bind_attrs =3D true,
> >>> +     },
> >>> +     .probe          =3D riscv_iommu_pmu_probe,
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
> >>> +
> >>> +MODULE_DESCRIPTION("RISC-V IOMMU PMU");
> >>> +MODULE_LICENSE("GPL");
