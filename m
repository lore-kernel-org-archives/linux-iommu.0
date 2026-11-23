Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795448988;
	b=jLlRWB2JDgceLo4DbfQ0p8Vs8v9Pfg7/zRIzqGTFFl4SNDNvxi5yTAe99UlEC3UrqjOt
	 PeDd6eu8IA6o/KpSbtaYBi9kT3RNgvsTxOF70S8zpsk3Y8MlWrh1CkbACm+kGHIe3rAaR
	 D537NB0tVsrWzqP4B9If79z7e3MFoiO2jMhWsHodwoerc6pPFDbw/1ALLjjLI2g4rEVT7
	 oZI5YyWXDOLFCBsIBud+9W4HSxpW8HFKuzMWgR2lYe4Hb0yoebsbS3zns7029ko1RhIm2
	 pgg849v98iHEY0m9iToRqL2uV6DFn6GwPsbRyTFn2VMBiEex6vEih4E+78KT2u13THg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795448988;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=ampCWU9YaRxYyU/2VqzGl7j5fZT5bJdrecIR7kU5Uc4=;
	b=GVcnEjau3Yn6iDqvPmmQqi3BFHnmbUVegBuLkhvkwCggwsHZl2K7JQE4kzcMEVIitvPH
	 y2ENEN0sSSVF5a/5U14S50xtWUHXsFIlAQdu027EPxH0by5RPUhR9gEVeWYn3DRwapEpz
	 mBatTpUE/FaJTSkKBSYo65KsyDx224x8tqQcl3gcXbts1NFfIiVvdBp/+45XJ16Y1v00w
	 q4l08QOdhvhh+O2zWCAc/tOpKLIzlFKO2DCoHf+eyfDfrSeNxPgl8FxLq4dTtGAI57HQF
	 BcHOWzoiVA7F0hIUB90kb3AquuEGF2rIzac4IJ75sHZdGlvvRfU4xlMqnguLbvn1VSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--praan.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=TfUMOTyB;
	arc=none smtp.remote-ip=209.85.215.197
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF25606A31F
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 15:49:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0AF25606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=TfUMOTyB
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cdb869327e7so2910090a12.0
        for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 07:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795448987; x=1796053787; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ampCWU9YaRxYyU/2VqzGl7j5fZT5bJdrecIR7kU5Uc4=;
        b=TfUMOTyB0szndqplZAuFTAS6P+Q4GH6mzQwXmKHLFTBGczWNRQWGyGu5TqVChsx91h
         8M6KGqr5ko30MZjP3ohV4UcgNrLdRxrGNVAI4OuuqOqIRjfAVfkj+2Jmn7WWBk4YRosI
         4/nX0pM96Dp1pgHsnHlRT5cVCfT+yugsGs0gfttHIrOy6qQ4GZUejmK3iE6PPfplJ//c
         OzQ3cr7C4MTQeM8cux1nbu52V479dP1tAJ2Hn2TgFs97GjQ4LkV0kmLZ4OY80Q7nmBuw
         OdhiBZ/Kz5dgNuHLmL6w1VdtATxSTypCC9phICf1Roa8WYWymKo8Pmifw/JB+0mNo3T6
         dPTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795448987; x=1796053787;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ampCWU9YaRxYyU/2VqzGl7j5fZT5bJdrecIR7kU5Uc4=;
        b=P3UNNFd/NrWugHpvMoJc2+W7hQggZXETE06OM1VIJwwkstoB6TFpqu+oah4NWFHpxg
         ItFe14Kv8ezvvkY0DiQ18TkrExTyEXJKSPRSP4TJ0ZFF4auQVVzq9MMDhUzMlBoqUVLI
         rRNu1n54wQWDnFBuQ2oPowJ495J7jhBSOzNPDxPEPYUnDealhwRf7v0aduU0XpWclNAS
         gvmVlPjzCSIMniFhlrx3DcsEY+brGv5mQxuJGNTmgBrYEPZW7e4WpQEJ4d5N4RHlnU0I
         EOXZd3ag0B+fxcNgC7inrYqeMjAa+o+xAXp+ViFtC4OtFY8T7ZkJ2E4qFgeoOQlWIGwX
         RJSQ==
X-Forwarded-Encrypted: i=1; AL+hErEKix1+HcIvRJG39MEUDFPVocejUGau1n+F10qeRBNzC4+2HhoknJPrypOnumgtZurkOzRmfw==@lists.linux.dev
X-Gm-Message-State: APuU4Z9X3z/PGqcbwFzi3BO44+rR/h6gEMZ0Jl3RokP+mZtb53vl6i28
	Ykft1B68vKrZ6CzHhyqIrcv5Y1Z0VDp1Al5ZW01kRRppMWTHtFaiMEOj/8Ti1RtMtrGTGaJFs96
	EBA==
X-Received: from pfbfd26.prod.google.com ([2002:a05:6a00:2e9a:b0:8a0:70d8:a2ef])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6300:218b:b0:3f8:f0b1:e7c0
 with SMTP id adf61e73a8af0-4014da5fc3emr11235211637.59.1795448987022; Mon, 23
 Nov 2026 07:49:47 -0800 (PST)
Date: Mon, 23 Nov 2026 15:49:45 +0000
In-Reply-To: <20261118101913.3135869-3-amitamishra@google.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261118101913.3135869-3-amitamishra@google.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261123154945.3083888-1-praan@google.com>
Subject: Re: [PATCH 2/2] perf/smmuv3: Add runtime PM support
From: Pranjal Shrivastava <praan@google.com>
To: amitamishra@google.com
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, krzk+dt@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mark.rutland@arm.com, robh@kernel.org, 
	robin.murphy@arm.com, will@kernel.org, iommu@lists.linux.dev, 
	smostafa@google.com
Content-Type: text/plain; charset="UTF-8"

On Wed, Nov 18, 2026 at 10:19:13AM +0000, Amita Mishra wrote:

Hi Amita,

+iommu@lists.linux.dev
Please CC the iommu list as well.

> On SoCs where an SMMUv3 PMCG resides in a switchable power domain,
> probing the PMCG attaches and powers on the domain, but without runtime
> PM support the domain remains permanently powered on even when no perf
> events are active.

I'm interested to know which PMCGs are these? Upstream arm-smmu-v3 
doesn't have runtime PM yet, thus, a PMCG that shares its SMMU's power 
domain gains nothing from this today: the SMMU keeps the domain on anyway

With my arm-smmu-v3 runtime PM series [1], the SMMU lets go of the domain
once it has no active clients, and then a PMCG without runtime PM would be
the one keeping it on, the two series seem to fit together. For TBU PMCGs
in a subsystem's domain this matters either way.

I'm wondering if you have PMCGs in power-domains that are neither tied to
the SMMU power-domain and nor it's clients' power-domain? 
(That'd be a bit odd but possible).

[...]

> +    /* The same condition smmu_pmu_probe() enables runtime PM on. */
> +    if (dev->pm_domain) {
> +        int ret = pm_runtime_resume_and_get(dev);
> +
> +        if (ret < 0)
> +            return ret;
> +        event->destroy = smmu_pmu_event_destroy;
>      }

This keeps the domain powered for as long as the event exists, even
while it is disabled or not scheduled. I'd be surprised if the 
production devices that use runtime PM keep a PMCG event open requiring
this? 

For a PMCG in the SMMU's domain, with [1] that means a perf event keeps
the domain on while the SMMU itself is suspended (SMMUEN=0, GBPA=Abort).
The SMMU only suspends once all its clients are idle, so apart from
cycles there's nothing meaningful to count.

For a TBU PMCG, it keeps the subsystem's domain powered, which changes
what's being measured: the TBU's TLBs and config caches survive what
would otherwise be power-offs, so tlb_miss and config_cache_miss can
under-report compared to the unmonitored system.

Which makes me question whether the PMCG needs runtime PM at all. It's
a profiling tool, and I'd be surprised if production devices that use
runtime PM keep PMCG events open. Without events nothing needs the PMCG
powered, so all this buys is not pinning the domain while the driver is
probed but unused..

Do you probe the PMCGs on production devices? If they're only used for
profiling and not in-field, not loading the driver there (or leaving the
node disabled) avoids the problem without runtime PM in the driver.

If we do need it, a couple of issues with the implementation below:

[...]

> @@ -975,15 +1040,45 @@ static void smmu_pmu_remove(struct platform_device *pdev)
>
>      perf_pmu_unregister(&smmu_pmu->pmu);
>      cpuhp_state_remove_instance_nocalls(cpuhp_state_num, &smmu_pmu->node);
> +    if (pdev->dev.pm_domain)
> +        pm_runtime_disable(&pdev->dev);
>  }

Events hold a module reference and bind/unbind is suppressed, so this
only runs with no events, i.e. normally with the PMCG runtime-suspended.
devres then frees the IRQ: free_irq() -> msi_domain_deactivate() ->
smmu_pmu_write_msi_msg() writes to the unpowered PMCG, since the PM
domain is only detached after devres in device_unbind_cleanup(). Wired
interrupts are fine, and the CPU hotplug path Sashiko mentioned
shouldn't rewrite the message with a GICv3 ITS parent, so in practice
this is MSIs plus module unload.

With the MSI message cached by the core (see below),
smmu_pmu_write_msi_msg() could simply skip the MMIO while the PMCG is
suspended and leave it to resume. Note it would have to check
pm_runtime_status_suspended(), since runtime PM is already disabled by
the time devres runs. Alternatively, keep the PMCG resumed across the
devres teardown.

[...]

> +static int smmu_pmu_runtime_resume(struct device *dev)
> +{
> +    struct smmu_pmu *smmu_pmu = dev_get_drvdata(dev);
> +
> +    smmu_pmu_reset(smmu_pmu);
> +    return 0;
> +}

Sashiko flagged this too: after a power-off the IRQ configuration is
gone, and smmu_pmu_reset() doesn't put it back. With MSIs, overflow
interrupts stop arriving and counters wrap unnoticed. With a wired
interrupt on an MSI-capable PMCG, IRQ_CFG0 comes back UNKNOWN, so an
overflow can send an MSI write to a garbage address, which is exactly
why probe clears it.

This is the same problem I had to solve for the SMMU in [1]: patches
7-8 make the genirq/msi core cache the message in
irq_chip_write_msi_msg() and add msi_device_domain_restore_msi_msgs(),
and arm_smmu_resume_msis() in patch 9 clears the IRQ_CFG0 registers and
then calls it (a no-op for wired IRQs). The PMCG resume needs the same:

    writeq_relaxed(0, smmu_pmu->reg_base + SMMU_PMCG_IRQ_CFG0);
    msi_device_domain_restore_msi_msgs(dev, MSI_DEFAULT_DOMAIN);

Minor: an autosuspend delay would avoid powering the domain on and off
for every event open/close.

Thanks,
Praan

[1] https://lore.kernel.org/all/20260929034510.2023173-1-praan@google.com/
