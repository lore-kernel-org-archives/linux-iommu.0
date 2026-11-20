Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795192625;
	b=G2YtBfwvJo7tyQE/icvpGCUn2awBQGg4TGw15IrWYuaw1S7spSRX6A4EShUE0W3Ra9nG
	 RVHHkqywCwRsyY2K3b9ch6MBoNQo6YoId1Ss+V83EDHdgsUp6cTTYonkyLm7CoCK8gKTB
	 H7FvBD4uEXD6RGwDWq7lVqXV0hVYW6wP049E8Qp4G2Z4kfDgOi6JuDUaTOIl5ZeeW5G/0
	 KlF8jjqBUYg2vig/faKfPTBdemMivR498EaXbJhnfFdXMIPB9R2EI2i8mlYsTvozC0rB/
	 b96i5fHoyU6mtYa4Nwk7JfGzTXV6gjHZnSKnwHx3a6zWJQn3llGgovg/i73iInM7Nsg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795192625;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=sOZlj3ywuMdrr6/tY+cQYmRF0Ei8aVJk6YFpDa2DEF0=;
	b=SZYoDVf7ie6kraBV00rC9rE+DVJx1G/xGa4OswGNMhstr5Sc7EWYqWMWZyYjcpDxr1Ji
	 7hH+D92myqn/PgMo/EqD1aZFTrZtwVnGeFTibT0daY1zksmcdmxCpIImoZOHvk1pkjx70
	 fgRLdyphQdcavus85MfTyAmS/Pp3ay0sogYmsfVVmQR/oUScDounT5HJNEm9MALy3FAv9
	 +6d/hKrewQoB/1JzdO6keLwfunR5rKCOON55xZzzg56N5R7eJmR6MZk28OjNYNL/DWDVD
	 a0EOuzpWEj+QzH23h243JnJZxl6RAmtiLpmr9aPTh6yFj7YGytU/t/KCUcbSDD9tbMQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lzw8VZvA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.48
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177E5606A334
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 16:37:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 177E5606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lzw8VZvA
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5c14b6ac47eso96262e87.0
        for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 08:37:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795192623; cv=none;
        d=google.com; s=arc-20260327;
        b=BgAMRjD6wdFoC5ACMDsOL14/WbgeSip3SetZWlgWkwSR65U3o37gdd5VtGNhIGgzGh
         u6HKB/Ec3/UQV32lONOx+RUnGIosPW3rOmgc0bKjnp/g8GlRcJs7loaKgfK1z2Qi1XYI
         Tl320rKmHpl0wOm7dnesJ8vaBdUYODvmzBYR7aSg1+6uwxkMnKMAOr08HHFjrf0KhxlE
         89OG1dc8N/ThtnnXrTNZEe1m4BJXsdCO5xPOqCL9wWUW0Gn1t9IAt3lq9MpEq3Ned+1Y
         jXaqVshUmNhWB2IbEC+BGdg9CD3tY+clC6YtZOdXWYP2SiRGhOQZUzDx48LMcfFLw7SO
         iK1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=sOZlj3ywuMdrr6/tY+cQYmRF0Ei8aVJk6YFpDa2DEF0=;
        fh=D7cUGWmjCCjyMSc8sHa1JF5f1waxEaisNEd+F3Pyh04=;
        b=VSxz6n0q9ZSmNveCPmqfjrEMOmC+Jh63FAKUjJnWJO/Wq2hHUZqBCS2v2fXMcV37Yj
         nFGH5Gqtgz5EqXv5YZ44T8z62oQ4P1cpGjBD38GFGZ0fkFSMBgVTXBERfVwRENiETznj
         o/cbiPhopIWKd9hF1CBtONXybqUTcHflUNZwT/M7cGsQCRGsXB7VnmeMHdVrAD3jDggd
         E8vrSviq5+qEO85BV4HN5N5smVKOeiAlnXqrrepKLjALwdTiH+OBC9e2FP/H0kkIuD9n
         yQbEK0IaT3Dv28A4cT77WiXazIHyoNHkhYh7A9Jgl9PuYBnv8KYcoW63BAz0hClMwExe
         qO1w==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795192623; x=1795797423; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sOZlj3ywuMdrr6/tY+cQYmRF0Ei8aVJk6YFpDa2DEF0=;
        b=lzw8VZvAXyjUw0ze3DHS5TnsIsHTGqKyyjzuuI+wyRk1/9CFj7HULgyMWK7PlobxLL
         uxIfhcRIvqQmKukE5oPNEJgTZBmfVFZXWTXaem6G19c5DZf3VauAEQzMbAwbxrE0+EsG
         z1y6r7BPnc1trBcPlms+YYUkvkftdH/kptjyHbQxc5pPDGkmanlFOO272ylBHVT4kyEs
         UyeWeLtk1tH/P78evL2CJhBeE2e9T7NVVfxGxMYzG1Pnb5UEfAl42fyrFy0gUlag41L0
         /3dWuJOsb/jaKyCyKzOzZ4QjDHxSL1Jr01jFTib2eovhSAwV9LbQ4b3oxx/vrLh71Rmi
         wjjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795192623; x=1795797423;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=sOZlj3ywuMdrr6/tY+cQYmRF0Ei8aVJk6YFpDa2DEF0=;
        b=xZhV4RwiMBHeuutMzKCMzjnz4gzo33VeEcZ35Uq8wQpCXx6LDFwkcQ0aV5d6Tnac9F
         CgSa2keMpQuBTh9ste2I3aUHc6Vl0HS0eVRwiKRnCuAfY0e9gSZfuPV3yCJ86i+oSA2i
         Ngyf6LSVcApuT4gvy6rZ2G9ubW+xg2b8A5Aw0PIlZfGzWeLH0b3Y33XBZPWDqWUE9xm+
         DqNx6JReT2LegVIYzcY+wxReotnL/qWjECtJOIaHVULxAJPRV0TIpVNNymzepofKFo4o
         xymplkbnmSZlM2Y5tQfpkW/HHsZULv3cRxA0BDoXVDuBNmoEDy0Y0E724P+9inQ9C8yq
         I3OA==
X-Gm-Message-State: APuU4Z84eFWTFR2V6V5OWFVh0i9ie559dbLTAtt2abot15FD9YBU7SUo
	Nz0tl/MkGf916W62n9PYeWhgmWPYLZ1hZdoHhdv7o3AcDUZWZOGGk5EPofI0yj0fJH053TLKipl
	xmfIhUcwo7dkv+LjZLKMndb4e9ISy+z8=
X-Gm-Gg: AZFdTZew7GZ46GhNnIB9p0hHRMmO+Fl68IjAQS+Vj9osaNW6W0Rr0fSOKejKnbjWiKO
	KPKDHl+RS34hPDWR5mpYhEujOscFvk87D8gpW4q9z2HYtyl9RoKxue8JWp2blVBISFmYLxSn8Y7
	2/FAu3beIERnfGHNFvkIFn4CR+rO9lFCizdO+VFqzohkZxR6QYmNqPR9F74QyTAdYWf63uPQ3Uf
	pEqyjVefESielThu0Bfwo3Pbe9LNeLErAEranWYGya2PQQqhntNMd0A5yzCMPIF/xRzTNRPrwMP
	9xZ/rQAuMKB8UUPNtUHzEpK4/DYFNFHzzfADtPFpCL7bqSuXns+uFT8fZhALERFECouCU0odhnn
	cufKd3QG8+dEAGgxk2f+xdt5UCUYtE0P7MJURTdLkb83M8mMxZwdJVYXPH9oMS+q7EnmzgJMbeq
	PvyA9pcLQrUPrCOURg2qImfmzJWIdsoN0cJdnNg6IhHA==
X-Received: by 2002:a05:6512:1384:b0:5bf:ce24:38c8 with SMTP id
 2adb3069b0e04-5c1bc797ddamr1295342e87.4.1795192622850; Fri, 20 Nov 2026
 08:37:02 -0800 (PST)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261120152308.76894-1-vasant.hegde@amd.com>
In-Reply-To: <20261120152308.76894-1-vasant.hegde@amd.com>
From: Nathan Blomquist <nblomquist@gmail.com>
Date: Fri, 20 Nov 2026 11:36:53 -0500
X-Gm-Features: AclHuK-XpOf6P5xkG62pyao6iU88ge6pOrgHCE9wqklJ3rp4qwlku0QG9zCXg10
Message-ID: <CACOV87UPK4otJaNPx12yLxzPox75v_KNiG4z8D8MyUGwATLaVg@mail.gmail.com>
Subject: Re: [PATCH] iommu/amd: Mark v2 page tables incoherent on Cezanne
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, suravee.suthikulpanit@amd.com, 
	Mario Limonciello <superm1@kernel.org>, Alex Deucher <alexander.deucher@amd.com>, 
	Akshata V Unkal <Akshata.VUnkal@amd.com>
Content-Type: text/plain; charset="UTF-8"

Hi Vasant,

I tested the posted patch on pristine v7.4-rc3 with a Ryzen 5 5600G
(Cezanne) and Radeon RX 5500 XT. On the same setup, unpatched rc3 hit
an IOMMU page fault and failed PSP initialization. With the patch, the
GPU initialized successfully. The IOMMU device table confirmed
translated v2 DMA-FQ without an amd_iommu= override.

As a simple test, I also used the RX 5500 XT to hardware-decode and
transcode the full 1080p60 Big Buck Bunny movie from H.264 to HEVC,
then hardware-decoded all frames of the output. No IOMMU faults, GPU
resets, or DMA-API errors were observed.

Tested-by: Nathan Blomquist <nblomquist@gmail.com>

Thanks,
Nathan


On Fri, 20 Nov 2026 15:23:08 +0000, Vasant Hegde <vasant.hegde@amd.com> wrote:
> DMA fails on Cezanne (family 19h, model 50h) when a device is placed in
> an IOMMU v2 paging domain due to missing coherency setting in IOMMU HW.
> The IOMMU walks v2 page tables without observing CPU writes still held
> in the cache. v1 PTEs have a Force Coherent bit, which the driver sets
> on every entry, but the v2 format has no equivalent bit, so v2 walks
> are not kept coherent.
>
> Set PT_FEAT_DMA_INCOHERENT for v2 domains on this CPU so the generic
> page-table code clflushes table memory before the IOMMU reads it.
>
> Link: https://lore.kernel.org/linux-iommu/CACOV87VBwH+R3eSBEOuz8hk7OaT63+A9m6ipPSW5wt1VhHMFPg@mail.gmail.com/
> Cc: Mario Limonciello (AMD) <superm1@kernel.org>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Tested-by: Akshata V Unkal <Akshata.VUnkal@amd.com>
> Co-developed-by: Nathan Blomquist <nblomquist@gmail.com>
> Signed-off-by: Nathan Blomquist <nblomquist@gmail.com>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/iommu.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 41ee4ad1dcf8..0f04013f590d 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -2792,6 +2792,15 @@ static const struct iommu_domain_ops amdv2_ops = {
>       .enforce_cache_coherency = amd_iommu_enforce_cache_coherency,
>  };
>
> +/*
> + * Force a clflush on Cezanne (family 19h, model 50h) when the v2
> + * page-table is enabled.
> + */
> +static bool amd_iommu_force_incoherent(void)
> +{
> +     return boot_cpu_data.x86 == 0x19 && boot_cpu_data.x86_model == 0x50;
> +}
> +
>  static struct iommu_domain *amd_iommu_domain_alloc_paging_v2(struct device *dev,
>                                                            u32 flags)
>  {
> @@ -2810,6 +2819,13 @@ static struct iommu_domain *amd_iommu_domain_alloc_paging_v2(struct device *dev,
>       domain->iommu.nid = dev_to_node(dev);
>
>       cfg.common.features = BIT(PT_FEAT_X86_64_AMD_ENCRYPT_TABLES);
> +
> +     if (amd_iommu_force_incoherent()) {
> +             cfg.common.features |= BIT(PT_FEAT_DMA_INCOHERENT);
> +             /* pt_iommu_init() rejects DMA_INCOHERENT without a device */
> +             domain->iommu.iommu_device = dev;
> +     }
> +
>       if (amd_iommu_np_cache)
>               cfg.common.features |= BIT(PT_FEAT_FLUSH_RANGE_NO_GAPS);
>       else
> --
> 2.31.1
