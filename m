Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795584591;
	b=rHAi2oIuJRNW2HmPB0Cm35EjBZ4Ufb8vN2lcm6g3hpgNNymGYSafks64k4J7SoeG6CD4
	 anVV5i1VmTIup4eaL8VARu8XSptqNNO1YxXupf8n6n96XNszW5X/vfjhz/Vbm6b8e5XRh
	 sc6PCBnZBTNZnmern68snNbNg9Nvst6vIRFg8IkAaJLcc4Ps3AcYNsjeztOjq/jXWqDMj
	 TWhhiIvNI4oCMilD0+ccHIiFyb9id9YcU4nc1w3lVG208nNjxRGnsD1gFUmqDARzDkfpi
	 WY6ks+KojSWcMNxt68VKzk6TnBGfAyAkg3tWBDiyA/ZvxRrw0Ik4I6Iwz95oRPHLASA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795584591;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=z31507qutrSHsDuMlMYuZrOSlqTz0X7hfxnmDVf3XDU=;
	b=lzpjmi+Oy9x+Nc9vrTexDc9EvCht6NrE38piZ/Uc9tNaoby+vGZveSmxwe4W3V4QlJOT
	 p1av+FSpeQ7BjB7rBMeZN1KH+OdQsB/5TPxrP9G6K+1DHYhYFGljq0NLNS3nnJNdKmCTe
	 9dAOs99LMKIr0ohnA/Qi+HAmKzYdxi7tkvArvHmItEHV65ot1zEc5C3cPv0NI1je0e5bC
	 wi295AIq2UZzoJ3fPbjDCohjOViMAa4/5Ddk1IUmZCNZMP+238MjsaqYfZTkcxzwT241h
	 sypyRyU9W3OhC1zWxbXPmXny3aUiT9SvTNrx3+LjRFalY5pjbKcWMxyfZfWcKfEYRDg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=bGXg7aBY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.47
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575BD606A326
	for <iommu@lists.linux.dev>; Wed, 25 Nov 2026 05:29:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 575BD606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=bGXg7aBY
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-7d2d95c5d81so3704994137.0
        for <iommu@lists.linux.dev>; Tue, 24 Nov 2026 21:29:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795584590; cv=none;
        d=google.com; s=arc-20260327;
        b=oeNCVtbqIUVaatn1sLQwH5Sss3uqfYvonj82TU8lxmfK6pxoPKZQHaiw9xMm0H5CQM
         9r+RpXTmEhlssCJQ+tAzHT7QOWc8iPhXLE2gM4ojlfpuAoWrnEa4A3wfaHoTm0v7jQQK
         reNBT8/h/UWn6NaAeaG5BzninJRQInikQvApwVintBuCwB34RYSnaYeF/hcG7bMweFbF
         xQ/Ni1/1ghUUs6Sem9lD5L6B8LzXGLbk0pkXVqI+ZQrO0otU3Ig9SjQBMP0hjEEh4y7C
         D5+nOrSS/LkuNHcMng2UpuUVtIOZ7QivUIAAB7GNv3ZGG6tKf/MqnHOduezBxRoFykOK
         kkRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=z31507qutrSHsDuMlMYuZrOSlqTz0X7hfxnmDVf3XDU=;
        fh=U0d+xiMu414Uly2jHjI7DpxGyXCrgI+gZnaLRj+Vn40=;
        b=YipWNDAtUS5ZrxRUReC3Dj+iu8oIKyCgqpeJ6Q1uYqGtaXFDfG3iTxJd+F2g0VPBMD
         n/WOLh5vMb3yM6m4PwWuiVddm9GgkuyU/eC06/OnYzL1sbP4DK/y6OEvJ+n9PKmLoyNO
         OKNzvXjlG0HqKNRwFhOfM5BrsHZoMeX/pEHtq6O0lu8lZDpnI9nfa7pHyinrw1srnDIs
         8hTwxQh3GzwgIzqhmjxYWARO1lbrrUqB/1mwXjtUxVCu/dqtC/R6djrQFGLQJaRgTWu7
         rRCOGVFo1mLLECq2fvSWZxtKt+g4Exedds2DBWg3Ui8/lpGujyumnxDxkgQLLiSKpnwP
         Xkzw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795584590; x=1796189390; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=z31507qutrSHsDuMlMYuZrOSlqTz0X7hfxnmDVf3XDU=;
        b=bGXg7aBYfGL7UPgwEFCIojKxumOKWhpfIzN41fkMpflo3mNQCin1vV6lxlTWUn7dXQ
         y1IRzXxcEenkd+2zNfeQg+KibIj/dXgit+c1mmQKIreUY8lb0EN3I8Eu+SchlQj+AvX9
         h7ncBz7P2ydUZyuqOkYIXJsf6IOBEIca3m5QIqmp7Ku+nE4TtnelL0xrClO/Zi+r5nB6
         CAgjOjf3MuYc0DBXeELWWxZzNS+JQVTz4yzV/pu7gHsYluuDqS/TbedlkwipE1cqmFU7
         UfbiP3TgnPYL4j6RE3d4ToY0EksGZ3WDPsxKC/SDY23DWZNRKW/HJ//3+zt0ovbZktRQ
         FN1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795584590; x=1796189390;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z31507qutrSHsDuMlMYuZrOSlqTz0X7hfxnmDVf3XDU=;
        b=TYDhD7WjV71yECzo8YnsknTOgRbHZ8Gt+w8Vut6fmuIligjAFQ0IS/6z2sUaiKZ/vK
         BZdY7qdYw2Gvu2D5lD/B29xa5VnJvXnlgKnQkcruWcg7hnYRTh3WxggaBMlsqKejK0Ue
         ndtLFbi2FpRZOvC9wZyfhvHmbV0IMB8gcWDNIuD46h3kOI8+eSdVSqR5AFwGA3t0nWUX
         o3k77Nm8VqyAO2rxGb/5WMyAa7Mkw+fMhuOjSm9xT7lNvgWWviixHmjWhbPqedoTERDe
         22QGydwCGKPUR2IMD/tlNSC6RpE8yN1UpPRIjJtnC9jzPoCDLo2RH3xP6YP55E8bCe1w
         gmPw==
X-Forwarded-Encrypted: i=1; AL+hErH2y4GPGFHBsfCTdz1DUUBcO4k716Bl+iqcSxRdm3NvvqyzH5allI9M9f3AGbWBlh2MMqxHKQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z+Kh9ZKvgfF3h6QkYmr1lEn5S3mGaOqHPgjA81OqSGDlqKBj4kJ
	Z7Z890nmk5CfvYE+CWQhzkBtIJ7jDXbeZMazHknERoDZgMdA7a26QAa45gAVBQehiT8Y03hJqGf
	SoCT6OupjTJdDrYqOuAJgfOpQPXNec5VXYcqbo6tj
X-Gm-Gg: AZFdTZeUd9wr2+Q8JMpR6tbYF7u3grtjoYxQHxwY2hJa6x7NtKuqzSniJMkoY4AZlWg
	pD7qY5nQEQXXygsGbv3JwkiTlf8pM+ihPeakZFOI2WIMCU90f/RxSnTmz4z/99zAhH7rovhqQsz
	GygWQI8Zc2t8lHx+HUPCaQz9Wn58zDrtgLT6DzS/ClkKZmicCR6iRm/G40y+QUHX+hfShaVzHm5
	1NV8CCL0CxtQsM4xGnxcojGMwA4q1kcNArGrzuAi2FuurcDxyflFiTjID4t6vMQKTjJrLU7qYbV
	EPexYz37kiJD0AUffhRnlfQXw3r6P4Yt+ZTGBB+cI8+ut0/NjDhMkCow7ecO2YTKx8XVptCwXQa
	Ol423lxYuz95iLOVdjxCUcb5PWgES2BOfeah7ka1mKk4VCbKFa4EfVklZRLrh7KDv9z3V25JhJI
	O4oWKCXX7oD3hiXm2EPAbyZF+KQLLrDDDGM7DFOMbky76qtCVMnvVMYidYIzqliTBXnEDTphzx
X-Received: by 2002:a05:6102:4488:b0:7cb:bb7b:77e4 with SMTP id
 ada2fe7eead31-7d7393b30c6mr5630777137.3.1795584589058; Tue, 24 Nov 2026
 21:29:49 -0800 (PST)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261118101913.3135869-3-amitamishra@google.com> <20261123154945.3083888-1-praan@google.com>
In-Reply-To: <20261123154945.3083888-1-praan@google.com>
From: Amita Mishra <amitamishra@google.com>
Date: Wed, 25 Nov 2026 10:59:36 +0530
X-Gm-Features: Aa3M54pSWQSSH-CwFoe9S0jqnWcBEelhF7YQ6aGMTLjqJveDGr8T5HV3QQARPWM
Message-ID: <CANLJkh0O=_hYhjv1QJKVfoLFp75RCgKRGHuKh2ubDA8EUExGsw@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf/smmuv3: Add runtime PM support
To: Pranjal Shrivastava <praan@google.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, krzk+dt@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mark.rutland@arm.com, robh@kernel.org, 
	robin.murphy@arm.com, will@kernel.org, iommu@lists.linux.dev, 
	smostafa@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pranjal,

Thanks for the thorough review and for adding iommu@lists.linux.dev -- I'll
make sure to include it on v2.

On Mon, Nov 23, 2026 at 03:49:45PM +0000, Pranjal Shrivastava wrote:
> On Wed, Nov 18, 2026 at 10:19:13AM +0000, Amita Mishra wrote:
> > On SoCs where an SMMUv3 PMCG resides in a switchable power domain,
> > probing the PMCG attaches and powers on the domain, but without runtime
> > PM support the domain remains permanently powered on even when no perf
> > events are active.
>
> I'm interested to know which PMCGs are these? Upstream arm-smmu-v3
> doesn't have runtime PM yet, thus, a PMCG that shares its SMMU's power
> domain gains nothing from this today: the SMMU keeps the domain on anyway
>
> With my arm-smmu-v3 runtime PM series [1], the SMMU lets go of the domain
> once it has no active clients, and then a PMCG without runtime PM would b=
e
> the one keeping it on, the two series seem to fit together. For TBU PMCGs
> in a subsystem's domain this matters either way.
>
> I'm wondering if you have PMCGs in power-domains that are neither tied to
> the SMMU power-domain and nor it's clients' power-domain?
> (That'd be a bit odd but possible).

They are the two cases you mentioned -- TBU PMCGs residing in switchable
subsystem/client power domains (which already use runtime PM today), and
TCU PMCGs sharing the SMMU power domain (which pair with your arm-smmu-v3
runtime PM series). There isn't a separate third power domain.

> Which makes me question whether the PMCG needs runtime PM at all. It's
> a profiling tool, and I'd be surprised if production devices that use
> runtime PM keep PMCG events open. Without events nothing needs the PMCG
> powered, so all this buys is not pinning the domain while the driver is
> probed but unused..
>
> Do you probe the PMCGs on production devices? If they're only used for
> profiling and not in-field, not loading the driver there (or leaving the
> node disabled) avoids the problem without runtime PM in the driver.

Yes -- the same SoC DT and kernel image are used across production and
profiling/debug builds, and we want PMCGs available on demand for profiling
without maintaining separate DTs or manually toggling drivers/nodes. Today,
simply having the node enabled and probed pins the attached subsystem/SMMU
power domain on permanently even when no perf events are ever opened, which
causes power regressions on idle devices.

On holding the runtime PM reference for the lifetime of an event
(event_init -> destroy): fair point about disabled events and the observer
effect on TBU TLB/config-cache misses while profiling. Because perf's
->add()/->start()/->pmu_enable() callbacks run in atomic context, taking th=
e
reference in ->event_init() and dropping it in ->destroy() (similar to
drivers/gpu/drm/xe/xe_pmu.c) was the cleanest way to keep the PMCG powered
whenever events exist while allowing idle systems with no open events to
power-gate.

> > @@ -975,15 +1040,45 @@ static void smmu_pmu_remove(struct platform_devi=
ce *pdev)
> >
> >      perf_pmu_unregister(&smmu_pmu->pmu);
> >      cpuhp_state_remove_instance_nocalls(cpuhp_state_num, &smmu_pmu->no=
de);
> > +    if (pdev->dev.pm_domain)
> > +        pm_runtime_disable(&pdev->dev);
> >  }
>
> Events hold a module reference and bind/unbind is suppressed, so this
> only runs with no events, i.e. normally with the PMCG runtime-suspended.
> devres then frees the IRQ: free_irq() -> msi_domain_deactivate() ->
> smmu_pmu_write_msi_msg() writes to the unpowered PMCG, since the PM
> domain is only detached after devres in device_unbind_cleanup().
[...]
> > +static int smmu_pmu_runtime_resume(struct device *dev)
> > +{
> > +    struct smmu_pmu *smmu_pmu =3D dev_get_drvdata(dev);
> > +
> > +    smmu_pmu_reset(smmu_pmu);
> > +    return 0;
> > +}
>
> Sashiko flagged this too: after a power-off the IRQ configuration is
> gone, and smmu_pmu_reset() doesn't put it back.
[...]
> This is the same problem I had to solve for the SMMU in [1]: patches
> 7-8 make the genirq/msi core cache the message in
> irq_chip_write_msi_msg() and add msi_device_domain_restore_msi_msgs(),
> and arm_smmu_resume_msis() in patch 9 clears the IRQ_CFG0 registers and
> then calls it (a no-op for wired IRQs).

Agreed on both MSI issues -- I'll fix them in v2. Since
msi_device_domain_restore_msi_msgs() isn't in mainline yet, would you
prefer that v2 stays standalone by caching the single msi_msg locally in
struct smmu_pmu (clearing SMMU_PMCG_IRQ_CFG0 and restoring on resume, and
skipping MMIO in smmu_pmu_write_msi_msg() while suspended), or should this
wait/build on top of your genirq/msi patches from [1]?

> Minor: an autosuspend delay would avoid powering the domain on and off
> for every event open/close.

Sounds good, I can add autosuspend support in v2 as well.

Regards,
Amita


On Mon, Nov 23, 2026 at 9:19=E2=80=AFPM Pranjal Shrivastava <praan@google.c=
om> wrote:
>
> On Wed, Nov 18, 2026 at 10:19:13AM +0000, Amita Mishra wrote:
>
> Hi Amita,
>
> +iommu@lists.linux.dev
> Please CC the iommu list as well.
>
> > On SoCs where an SMMUv3 PMCG resides in a switchable power domain,
> > probing the PMCG attaches and powers on the domain, but without runtime
> > PM support the domain remains permanently powered on even when no perf
> > events are active.
>
> I'm interested to know which PMCGs are these? Upstream arm-smmu-v3
> doesn't have runtime PM yet, thus, a PMCG that shares its SMMU's power
> domain gains nothing from this today: the SMMU keeps the domain on anyway
>
> With my arm-smmu-v3 runtime PM series [1], the SMMU lets go of the domain
> once it has no active clients, and then a PMCG without runtime PM would b=
e
> the one keeping it on, the two series seem to fit together. For TBU PMCGs
> in a subsystem's domain this matters either way.
>
> I'm wondering if you have PMCGs in power-domains that are neither tied to
> the SMMU power-domain and nor it's clients' power-domain?
> (That'd be a bit odd but possible).
>
> [...]
>
> > +    /* The same condition smmu_pmu_probe() enables runtime PM on. */
> > +    if (dev->pm_domain) {
> > +        int ret =3D pm_runtime_resume_and_get(dev);
> > +
> > +        if (ret < 0)
> > +            return ret;
> > +        event->destroy =3D smmu_pmu_event_destroy;
> >      }
>
> This keeps the domain powered for as long as the event exists, even
> while it is disabled or not scheduled. I'd be surprised if the
> production devices that use runtime PM keep a PMCG event open requiring
> this?
>
> For a PMCG in the SMMU's domain, with [1] that means a perf event keeps
> the domain on while the SMMU itself is suspended (SMMUEN=3D0, GBPA=3DAbor=
t).
> The SMMU only suspends once all its clients are idle, so apart from
> cycles there's nothing meaningful to count.
>
> For a TBU PMCG, it keeps the subsystem's domain powered, which changes
> what's being measured: the TBU's TLBs and config caches survive what
> would otherwise be power-offs, so tlb_miss and config_cache_miss can
> under-report compared to the unmonitored system.
>
> Which makes me question whether the PMCG needs runtime PM at all. It's
> a profiling tool, and I'd be surprised if production devices that use
> runtime PM keep PMCG events open. Without events nothing needs the PMCG
> powered, so all this buys is not pinning the domain while the driver is
> probed but unused..
>
> Do you probe the PMCGs on production devices? If they're only used for
> profiling and not in-field, not loading the driver there (or leaving the
> node disabled) avoids the problem without runtime PM in the driver.
>
> If we do need it, a couple of issues with the implementation below:
>
> [...]
>
> > @@ -975,15 +1040,45 @@ static void smmu_pmu_remove(struct platform_devi=
ce *pdev)
> >
> >      perf_pmu_unregister(&smmu_pmu->pmu);
> >      cpuhp_state_remove_instance_nocalls(cpuhp_state_num, &smmu_pmu->no=
de);
> > +    if (pdev->dev.pm_domain)
> > +        pm_runtime_disable(&pdev->dev);
> >  }
>
> Events hold a module reference and bind/unbind is suppressed, so this
> only runs with no events, i.e. normally with the PMCG runtime-suspended.
> devres then frees the IRQ: free_irq() -> msi_domain_deactivate() ->
> smmu_pmu_write_msi_msg() writes to the unpowered PMCG, since the PM
> domain is only detached after devres in device_unbind_cleanup(). Wired
> interrupts are fine, and the CPU hotplug path Sashiko mentioned
> shouldn't rewrite the message with a GICv3 ITS parent, so in practice
> this is MSIs plus module unload.
>
> With the MSI message cached by the core (see below),
> smmu_pmu_write_msi_msg() could simply skip the MMIO while the PMCG is
> suspended and leave it to resume. Note it would have to check
> pm_runtime_status_suspended(), since runtime PM is already disabled by
> the time devres runs. Alternatively, keep the PMCG resumed across the
> devres teardown.
>
> [...]
>
> > +static int smmu_pmu_runtime_resume(struct device *dev)
> > +{
> > +    struct smmu_pmu *smmu_pmu =3D dev_get_drvdata(dev);
> > +
> > +    smmu_pmu_reset(smmu_pmu);
> > +    return 0;
> > +}
>
> Sashiko flagged this too: after a power-off the IRQ configuration is
> gone, and smmu_pmu_reset() doesn't put it back. With MSIs, overflow
> interrupts stop arriving and counters wrap unnoticed. With a wired
> interrupt on an MSI-capable PMCG, IRQ_CFG0 comes back UNKNOWN, so an
> overflow can send an MSI write to a garbage address, which is exactly
> why probe clears it.
>
> This is the same problem I had to solve for the SMMU in [1]: patches
> 7-8 make the genirq/msi core cache the message in
> irq_chip_write_msi_msg() and add msi_device_domain_restore_msi_msgs(),
> and arm_smmu_resume_msis() in patch 9 clears the IRQ_CFG0 registers and
> then calls it (a no-op for wired IRQs). The PMCG resume needs the same:
>
>     writeq_relaxed(0, smmu_pmu->reg_base + SMMU_PMCG_IRQ_CFG0);
>     msi_device_domain_restore_msi_msgs(dev, MSI_DEFAULT_DOMAIN);
>
> Minor: an autosuspend delay would avoid powering the domain on and off
> for every event open/close.
>
> Thanks,
> Praan
>
> [1] https://lore.kernel.org/all/20260929034510.2023173-1-praan@google.com=
/
