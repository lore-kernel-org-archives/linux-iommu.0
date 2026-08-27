Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F683EBF3B
	for <iommu@lists.linux.dev>; Thu, 27 Aug 2026 09:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787822538; cv=pass; b=kQkBJWhNiGnDedV5103QVnslMdCPVonpC/ekrWgQwdZpYkbAPm4wSkfzVP+mHRbnkXKhYzqq5gPIqNL+sa9aRtcstZ017KI7WoJAevAYLgUn6NC6bJ/9poNJtZYigGzeNpmoI71jMAQXqM8Nos1HA+7ENu66RfNs2Woz19Givhw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787822538; c=relaxed/simple;
	bh=B89QC7AtZfzssb6gMR/bZCP2/NlKBqcbR1J6QOSNkJA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XtLKekdXr1RY8X4g5xeAKu9lpF5gV/XlmLrj9sNK7uQTIffr6fuxGyFt9SgBkdSha/7wCrA9nbe69yrWXcqbUYYfAVATA4hqSOmb9RKosSXb/s7yWSC57RLF0Rp0qvq79Ja23/3re2E9/nT/UQHGDwWKzOVraoEAcQnvT3mZ2pw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=auhVSCYC; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="auhVSCYC"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c15e592da74so272322666b.1
        for <iommu@lists.linux.dev>; Thu, 27 Aug 2026 02:22:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787822533; cv=none;
        d=google.com; s=arc-20260327;
        b=W/DJ3WY0mzUc/1Y/A55MZmvueAExbpOrlIO6woKZ0uyaIiE++M7Aw93Q6/7+Ol13/g
         4XO8xLxh/4kH4qGBsoGfW/pWtb1OkFVfZX7DdbUeS3eF5nOV4mivgfUwX54tsw4xhPXd
         dXi1Oa71SxkCJQ+NRC6wAhMn1fs8mJOtz9FJ+wW71EjFweNVv0OzGjdoSEy4dTXM//3B
         IB+Oe+x+6sYTvw0Q6xAiyuA2WaTzQDcLdSqaubrv/Kgfzjhbez8pWz/pidSLjNe99aAj
         tEkZrCEXoYVzd8CfjxL3koTyYH2riv4HzacfewsEQ8CUDuSgBHDSZN/PIEVRjaH0W4rU
         CB9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sR4QR528o/yU156MmURY2Xi3Gh5p+6A+XzV1cmsnWpM=;
        fh=VX4LMKPQyIbE4qQ6ahyzg4tAEnwhSWDx39pIuJ3HXqs=;
        b=qnvuNhFB4yNp0op1Y/g88M23YLjOk074bn4cy+wmPKF6pb/twwv76NqzzxJMa0A04s
         Ua+LA3+hE+yBjUVg8fUOod0AsPHNNVYnT8aO7k5ZNBC/mWNzD5OK3dTO2Sxj43scB2dR
         av+G98z1EPP3MU6sHdldgKPaVriAji587vZy8Upgl56yqJsKxgQwMxF45MxaT//9/TJv
         qJAzSgENWYwmSeiLUuQ0PJFnH5vUWZVwzmZMsGsuvm9X//Vdv/p4No9134xqrwLkVFm3
         yl44MKfwR6pCvsXyrA3oRLMGeFIduVG2ZfwypwNETIhK56Wj98OlenKjzmfAirQmS7XX
         8XrQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1787822533; x=1788427333; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sR4QR528o/yU156MmURY2Xi3Gh5p+6A+XzV1cmsnWpM=;
        b=auhVSCYC2p7jGWhJbBYs5jLdEVLFsdtC/UTUHb7O7H1+DI3I4dn2irkvNJkdi/e88Y
         G3Fi4ALc+YtNuJgSErH7FlgVvd4QUWXJKd04hRcsqTB47Fc/NEaV8eoPlZTRm7+32FR6
         cRgCLF/77I5xso43Z70K57tpch29/EiX18JmX0G6w5dAqzBZsPVZDbfBsu9LLphD6J7E
         sFZNIyfqVKf0lBi4Mrqv8qnp/SkN+cHUI7kXsNmDcZqvEG0kqzPvi+6OcIPjMmbJO7TU
         8kLUDAakAwHgOfR50io/FBZVaX7x236HvUy5eGT5i1FDnADSGB/i55SrtdlBnAskHoqd
         TTjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787822533; x=1788427333;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sR4QR528o/yU156MmURY2Xi3Gh5p+6A+XzV1cmsnWpM=;
        b=p2791G5zwNnn+2VhEFboyrj/Kee0+lTJto7fMUbBJJcFaBbUy5cmFynbEMcmM0Kgex
         85sbyrPdMoxc6Ff8SjnLxz0xReyUx5B45BhPlrI/L5FbHrhty+CA17jC5hjcdRHxZx6u
         jKqxEOQOx3zOrZZI0CFVwBL+zIovvd7odhgfYT4+50WURw/psQj5Izmh0FpQpJofQ/CX
         IT3+YHbNmG9apwVHf8A1eE99G4oMQAtbj/JX7lKd0NeJNDhW+h/pa/rMdxK904/aAexI
         8AUU1yeCyL2t646DpO+VV1Cww0bO+2asoaFHRFaJyuTL4BxUUDRq014TTPfkxk2GB4tW
         8X+A==
X-Forwarded-Encrypted: i=1; AHgh+RqIieuRYyHF0lOb4WuafIMaOJQQY76O+3aMuj/yRzDki8U4vywQnAKBGEvjNycA+Gn6CZwzHQ==@lists.linux.dev
X-Gm-Message-State: AFuF++kC0CxhiCnIuCV1XR32Oofrq5bA6tEWqOLmILh1rtTrdfAYg7R4
	SXIfrukQbXPxJcWj7QAwb4ygdJf17jmkLJCBlJhDnvUPda3FgfaCHPMBQu39R2ygMM0FwuMuYQj
	QUUIpCO/lzyJBfXU+bN3fpxeQUkF9E5uW5X2uzWxIiQ==
X-Gm-Gg: AR+sD13IpHgJchVP0ObE7VDIxlnaxsN4comMXahnSmwYg85+JXlt8HSyAmJbhzfzAT5
	0Vup7Sq0jYXtO/Gly//aJGEvUobz1OBrHOvRlNcwI0HYwwXhwf0JTx+GFHF+XaC6x8esJFFLSSW
	gbnAjYzeiWEC1GvQ7pzN3YpryYiNljy8RfG5G59oSr979W2+34Y3e/6idLdVJu5eCVbr/6VvirD
	Gb450bQZyE9kWfCKKVcCe9ynbDFLhieJO5OXjc3qRueUqUuZ/Eiakwdk3mYGiA2E3bwODa/SypR
	BhqTnHJmlH82hlDUUQKswZWRIYG1K+2ylWcCYqroLEUy48L3
X-Received: by 2002:a17:906:7947:b0:c15:f598:60c0 with SMTP id
 a640c23a62f3a-c250bb7e838mr1564945066b.4.1787822533363; Thu, 27 Aug 2026
 02:22:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260824022034.3916570-1-zong.li@sifive.com> <20260824022034.3916570-2-zong.li@sifive.com>
 <ab59c5b8-2915-4d59-8766-7a6297224494@picoheart.com>
In-Reply-To: <ab59c5b8-2915-4d59-8766-7a6297224494@picoheart.com>
From: Zong Li <zong.li@sifive.com>
Date: Thu, 27 Aug 2026 17:22:00 +0800
X-Gm-Features: AcwNN1WwMQQT_m_Py9koyaEt_VcNKFRBPZMUBc9xYC0enHXIGDMus1J5lq_IxXU
Message-ID: <CANXhq0rBYWyLztFQzLCPx1vMSdahcuH-kfKPGO+WRDvFEW6Osg@mail.gmail.com>
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

On Wed, Aug 26, 2026 at 4:28=E2=80=AFPM Yicong Yang <yang.yicong@picoheart.=
com> wrote:
>
> On 8/24/26 10:20 AM, Zong Li wrote:
> > Add a new driver to support the RISC-V IOMMU PMU. This is an auxiliary
> > device driver created by the parent RISC-V IOMMU driver.
> >
> > The performance monitor provides counters with filtering support to
> > collect events for specific device ID/process ID, or GSCID/PSCID.
> >
> > The RISC-V IOMMU PMU separates the cycle counter from the event counter=
s.
> > The cycle counter is not associated with iohpmevt0, so a software-defin=
ed
> > cycle event is required for the perf subsystem.
> >
> > The number and width of the counters are hardware-implemented and must
> > be detected at runtime.
> >
> > Leave out all the dead cleanup code (i.e. .remove() operation) if the
> > PMU driver is tied to the IOMMU driver and can never realistically be
> > removed.
> >
> > PMU-related definitions are moved into the perf driver, where they are
> > used exclusively.
> >
> > According to RISC-V IOMMU specification Chapter 6:
> > Whether an 8 byte access to an IOMMU register is single-copy atomic is
> > UNSPECIFIED. Use two separate 4 byte accesses for hardware
> > compatibility.
> >
> > Tested-by: Chen Pei <cp0613@linux.alibaba.com>
> > Tested-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
> > Reviewed-by: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>
> > Suggested-by: David Laight <david.laight.linux@gmail.com>
> > Suggested-by: Guo Ren <guoren@kernel.org>
> > Link: https://lore.kernel.org/linux-riscv/20260618143634.7f3dd6c5@pumpk=
in/
> > Signed-off-by: Zong Li <zong.li@sifive.com>
> > ---
> >  drivers/iommu/riscv/iommu-bits.h |  61 ---
> >  drivers/perf/Kconfig             |  12 +
> >  drivers/perf/Makefile            |   1 +
> >  drivers/perf/riscv_iommu_pmu.c   | 813 +++++++++++++++++++++++++++++++
> >  4 files changed, 826 insertions(+), 61 deletions(-)
> >  create mode 100644 drivers/perf/riscv_iommu_pmu.c
> >
>
> [...]
>
> > +
> > +/* cpumask */
> > +static ssize_t riscv_iommu_cpumask_show(struct device *dev,
> > +                                     struct device_attribute *attr,
> > +                                     char *buf)
> > +{
> > +     struct riscv_iommu_pmu *pmu =3D to_riscv_iommu_pmu(dev_get_drvdat=
a(dev));
> > +
> > +     return cpumap_print_to_pagebuf(true, buf, cpumask_of(pmu->on_cpu)=
);
>
> needs to use sysfs_emit(), cpumap_print_to_pagebuf is removed in 7.3-rc
>
> https://lore.kernel.org/lkml/20260702154725.185376-1-ynorov@nvidia.com/
>

I will fix it in the next version. Thanks

> > +}
> > +
>
> [...]
>
> > +
> > +static int riscv_iommu_pmu_probe(struct auxiliary_device *auxdev,
> > +                              const struct auxiliary_device_id *id)
> > +{
> > +     struct  riscv_iommu_device *iommu_dev =3D dev_get_platdata(&auxde=
v->dev);
> > +     struct riscv_iommu_pmu *iommu_pmu;
> > +     void __iomem *addr;
> > +     char *name;
> > +     int ret;
> > +
> > +     iommu_pmu =3D devm_kzalloc(&auxdev->dev, sizeof(*iommu_pmu), GFP_=
KERNEL);
> > +     if (!iommu_pmu)
> > +             return -ENOMEM;
> > +
> > +     iommu_pmu->reg =3D iommu_dev->reg;
> > +
> > +     /*
> > +      * Counter number and width are hardware-implemented.
> > +      * Detect them by write 1s. Counter should be consecutive.
> > +      */
> > +     addr =3D iommu_pmu->reg + RISCV_IOMMU_REG_IOCOUNTINH;
> > +     writel(RISCV_IOMMU_IOCOUNTINH_HPM, addr);
> > +     iommu_pmu->num_counters =3D hweight32(readl(addr));
> > +
> > +     addr =3D iommu_pmu->reg + RISCV_IOMMU_REG_IOHPMCYCLES;
> > +     riscv_iommu_pmu_writeq(RISCV_IOMMU_IOHPMCYCLES_COUNTER, addr);
> > +     iommu_pmu->cycle_cntr_mask =3D riscv_iommu_pmu_readq(addr);
> > +
> > +     /* Assume the width of all event counters are the same */
> > +     addr =3D iommu_pmu->reg + RISCV_IOMMU_REG_IOHPMCTR_BASE;
> > +     riscv_iommu_pmu_writeq(RISCV_IOMMU_IOHPMCTR_COUNTER, addr);
> > +     iommu_pmu->event_cntr_mask =3D riscv_iommu_pmu_readq(addr);
> > +
> > +     iommu_pmu->pmu =3D (struct pmu) {
> > +             .module         =3D THIS_MODULE,
> > +             .parent         =3D &auxdev->dev,
> > +             .task_ctx_nr    =3D perf_invalid_context,
> > +             .event_init     =3D riscv_iommu_pmu_event_init,
> > +             .add            =3D riscv_iommu_pmu_add,
> > +             .del            =3D riscv_iommu_pmu_del,
> > +             .start          =3D riscv_iommu_pmu_start,
> > +             .stop           =3D riscv_iommu_pmu_stop,
> > +             .read           =3D riscv_iommu_pmu_read,
> > +             .attr_groups    =3D riscv_iommu_pmu_attr_grps,
> > +             .capabilities   =3D PERF_PMU_CAP_NO_EXCLUDE,
> > +     };
> > +
> > +     auxiliary_set_drvdata(auxdev, iommu_pmu);
> > +
> > +     name =3D devm_kasprintf(&auxdev->dev, GFP_KERNEL,
> > +                           "riscv_iommu_pmu_%u", auxdev->id);
> > +     if (!name) {
> > +             dev_err(&auxdev->dev, "Failed to create name riscv_iommu_=
pmu%u\n",
> > +                     auxdev->id);
> > +             return -ENOMEM;
> > +     }
> > +
> > +     iommu_pmu->numa_node =3D dev_to_node(iommu_dev->dev);
> > +     iommu_pmu->irq =3D riscv_iommu_pmu_get_irq_num(iommu_dev);
> > +
> > +     ret =3D riscv_iommu_pmu_request_irq(auxdev, iommu_dev, iommu_pmu)=
;
> > +     if (ret) {
> > +             dev_err(&auxdev->dev, "Failed to request irq %s: %d\n", n=
ame, ret);
> > +             return ret;
> > +     }
> > +
> > +     /*
> > +      * Bind all events to the same cpu context to avoid race enabling=
.
> > +      * Pick a local CPU from the numa node of this iommu for the loca=
lity.
> > +      *
> > +      * Hold the hotplug lock until this instance is registered, other=
wise
> > +      * the CPU picked here could go offline in between. The teardown
> > +      * callback does not run for an instance which is not registered =
yet,
> > +      * so nothing would move the PMU off that CPU afterwards.
> > +      */
> > +     cpus_read_lock();
> > +
> > +     iommu_pmu->on_cpu =3D cpumask_local_spread(0, iommu_pmu->numa_nod=
e);
> > +     ret =3D irq_set_affinity(iommu_pmu->irq, cpumask_of(iommu_pmu->on=
_cpu));
> > +     if (ret)
> > +             dev_dbg(&auxdev->dev, "failed to set irq %u affinity to c=
pu %u: %d\n",
> > +                     iommu_pmu->irq, iommu_pmu->on_cpu, ret);
> > +
> > +     ret =3D cpuhp_state_add_instance_nocalls_cpuslocked(cpuhp_state,
> > +                                                      &iommu_pmu->node=
);
> > +
> > +     cpus_read_unlock();
>
> it could be simplified to init the ->on_cpu in the hotplug handler withou=
t
> holding the cpu hotplug lock like below:
>
> iommu_pmu->on_cpu =3D -1;
> ret =3D cpuhp_state_add_instance() /* init the ->on_cpu in the hotplug ha=
ndler */

It seems we might lose the benefits of cumask_local_spread this way.

>
> otherwise looks good to me.
>
> Reviewed-by: Yicong Yang <yang.yicong@picoheart.com>
>
> > +
> > +     if (ret) {
> > +             dev_err(&auxdev->dev, "Failed to register hotplug %s: %d\=
n", name, ret);
> > +             return ret;
> > +     }
> > +
> > +     ret =3D devm_add_action_or_reset(&auxdev->dev,
> > +                                    riscv_iommu_pmu_remove_cpuhp_insta=
nce,
> > +                                    iommu_pmu);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret =3D perf_pmu_register(&iommu_pmu->pmu, name, -1);
> > +     if (ret) {
> > +             dev_err(&auxdev->dev, "Failed to registe %s: %d\n", name,=
 ret);
> > +             return ret;
> > +     }
> > +
> > +     ret =3D devm_add_action_or_reset(&auxdev->dev,
> > +                                    riscv_iommu_pmu_do_unregister,
> > +                                    iommu_pmu);
> > +     if (ret)
> > +             return ret;
> > +
> > +     /*
> > +      * The PMU name only carries the aux dev id, not the iommu dev na=
me, so
> > +      * find the iommu dev name here to map this PMU back to its iommu=
 dev.
> > +      */
> > +     dev_info(&auxdev->dev, "%s: Registered with %d counters (iommu %s=
)\n",
> > +              name, iommu_pmu->num_counters, dev_name(iommu_dev->dev))=
;
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct auxiliary_device_id riscv_iommu_pmu_id_table[] =3D=
 {
> > +     { .name =3D "riscv-iommu.pmu" },
> > +     {}
> > +};
> > +MODULE_DEVICE_TABLE(auxiliary, riscv_iommu_pmu_id_table);
> > +
> > +static struct auxiliary_driver iommu_pmu_driver =3D {
> > +     .driver =3D {
> > +             .suppress_bind_attrs =3D true,
> > +     },
> > +     .probe          =3D riscv_iommu_pmu_probe,
> > +     .id_table       =3D riscv_iommu_pmu_id_table,
> > +};
> > +
> > +static int __init riscv_iommu_pmu_init(void)
> > +{
> > +     int ret;
> > +
> > +     cpuhp_state =3D cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN,
> > +                                           "perf/riscv/iommu:online",
> > +                                           riscv_iommu_pmu_online_cpu,
> > +                                           riscv_iommu_pmu_offline_cpu=
);
> > +     if (cpuhp_state < 0)
> > +             return cpuhp_state;
> > +
> > +     ret =3D auxiliary_driver_register(&iommu_pmu_driver);
> > +     if (ret)
> > +             cpuhp_remove_multi_state(cpuhp_state);
> > +
> > +     return ret;
> > +}
> > +module_init(riscv_iommu_pmu_init);
> > +
> > +MODULE_DESCRIPTION("RISC-V IOMMU PMU");
> > +MODULE_LICENSE("GPL");
