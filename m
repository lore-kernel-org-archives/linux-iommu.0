Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.177
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794669556;
	b=Ne8bIUcfvK3lHOyBY5uwQtPvoNEanDIkzc2x35EdkPKqgUlyv6iaVUMNzZWcedMN2GmJ
	 Henan3NQFDroiizKOKQdryKhtAmakyx59LhDf9g6hbz38/0IRg2Chp2Y5AuaVLBBDzXt8
	 87yjHGwycrBZGOjWU3R4WdKbcuztvhhi4/qQVtWo51w93XukjdvqqOTk5Og4H+Kr7hFmd
	 9/lxJN5bLehXZvedGmDwdzgl0mhXvTzhHERM8+jZ8aGhLAj854Qx/GgBiTvKBDpsD/0Ko
	 BO5K3edqYKTdMx6qYvED6H+Ns1adM4p9AzCDdw1AR5wuLongvykj+6zk8D4n+3VyZ7g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794669556;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=yxQu9Chowg1nqfXHmxvx8wQurJOIxxYkquabh4inNm0=;
	b=Iljzn8DMNO86g9BbjsVH08H092eeITIRJ3FrV+NRJw2F172qRAdlBDurhNwDmXrmBnwU
	 QaZoQBA5CdmHixhVUriljHVrlI9ARicD9ACnrLF2kzvwocA1rOiSFrVJWZUjgiIb4Qa69
	 9e6OD6HMmAHCBJWzkpIMVt92n4Dx3Y7VJUt1WNgAaHvg/2jScBYNJ/Wm0eqqz5dl7Jd9p
	 0RO5DU1Kro0F3gIIqmoZLo0lJo48pfcU+WxBMnG7YYrlibeFrWyGK1iN0f3a39zpwIHmk
	 KhOx3hkoyGL5hVSY9eQv51rel3d28utxbYdYINadfbNM7viF0KMVHRPCtTqbOpm/3ng==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kisa3QXt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.177
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C54606A32D
	for <iommu@lists.linux.dev>; Sat, 14 Nov 2026 15:19:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5C54606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kisa3QXt
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-3adf04a55f5so2710201fa.0
        for <iommu@lists.linux.dev>; Sat, 14 Nov 2026 07:19:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794669554; cv=none;
        d=google.com; s=arc-20260327;
        b=iTZ72zeL9vvM6cGw24VHEpFtsJzI+atyefjLLt9vVkONeR5RNHQegtllwtEz0mx4Os
         qc1D1WFU3TLdaS37z93XAbtLBUAv7bbNeEMy15XW468xqMGld2D9ICaKCZrILWGBDR6j
         14BbgpAx4O6n+T5ASBGcEw40g1887CEq0Ogv2bqRAcwecLaNf5fvYAWzK+x/h/me5oLj
         yE73lnWWVakZ4c/Y4z3Zm4SFOHetSX4DaN0mjC3XAbx0uMrhN8pyjWEPhl4S/nzJSwFU
         JIp0z8iJ02s/rp+KVm5g/YVpGWlm8271EQWPMt9F0qKhL3VDpRLjH4y4ZrLDx23kL9df
         8jqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=yxQu9Chowg1nqfXHmxvx8wQurJOIxxYkquabh4inNm0=;
        fh=aTksfhXudPaU578VWs1aV68OC+rpWVk6prVOTaWf8j8=;
        b=FOv+VPba/fxdXEAJBY6ymjBL1Luv7XamzII9y+B9JL6GIWCwDL0y6P40Gf9WnnnsnS
         kKQHLjB2MTCUXcSE0zlH7pC2oxF9okVsoaa0qMQhVgHw9GBFforwWXzrm8xjSyeZ3F8X
         HdLCBHp4VkUpzdiHyN6KwvNQK/0Onf44s8uGSy+t18u1oaLOiUoHpU/bWbSZipg24Y9b
         I3+iva6+TBIFbcolFJLVT/a4rHYtVqsKaRGs3qRhsEAl2yz+9fWTrSeXuRRB8WUlLUeT
         BcWCQD362T+irDo3qTEzG1ldNeLsEEAzCKI3oG7e0kXXr2cM3K8eEaxdAiUG55Vcr3Uz
         OjlQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794669554; x=1795274354; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yxQu9Chowg1nqfXHmxvx8wQurJOIxxYkquabh4inNm0=;
        b=kisa3QXtgt1grI7OGSiTdgdyP1GrVWsBfIQnoonxyZUIaRQr8YIF7XdctBdi0LB2mC
         yJyi+gHOwwU/9XqB2YMBiXxNOhf8fyh5aMTkw8tbv5eojBV+5MZeTtEWTDhwj4E4AlS9
         g46yx/91y8CxZK6pHgozKXzEbGoZwl8eDEtcGXvwofiZEyKYcauDMlJD9JlhiU42PlL1
         gzstwcgaiY+gDVY9C2dXZPVR48yhK2Iyl76GOSS1OokaufGTowhP+31DOUSSwYlJoMJd
         YI3Hsvd+0Kw23rhHaboYLva3CjEVhZeudhgjkPEo5lUE/JproTGVo3Nws0VGZ64DR6Qz
         v9PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794669554; x=1795274354;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yxQu9Chowg1nqfXHmxvx8wQurJOIxxYkquabh4inNm0=;
        b=sEtSAjzUK4LeusJXi6fVYRZkoYKEcHgN8R/8I++cJ0+1iQOBrUxZCuxT4ZlSNcbNLU
         wiPVWgn9HLGp8oSH+4wbRVytdHB0PfWw3p3Bfy/MBM/ISt0n8x8qW3reArWJL6b5O0hb
         zk3vpOjHkIox3GGyQBL+coV1+f5OlAr6wngWZgxiomUIl8wmneiJBCcFpMuxTcg1gUgO
         J0SByDWPWpbF+sqqGc4WF1zxz33g85HtS/yJv4IAj7DuPCku/Y53CYX0ubAUiz6xNwip
         6VtR3TUMcwbaGUiwAqHnEwnuBk2W7L2FRIvQxcgstl+56Ji4HTtxrmlcs/iFZG3tgZWD
         m9Rg==
X-Gm-Message-State: APuU4Z9lDbXLTtNkpDJNYDQN33pwL0EY10301GeG0awd6GT04hpsfVff
	Z6pM22BsyVMJ+2SXaJXOHk18N7J/zYuu6+RJUN5Y4KINnzTbtGJaIBfrhuV3Q6oEi9ZtRy/BNB7
	XpdUbh8PJh8YRhSA/PuyuxXw3+8YO/0w=
X-Gm-Gg: AYBFou1s74c1RHuwJqCG4txNQ0yVjmKAITFKTyQ9eAfth8aj0r/1zKbTXS2t0O7hyAp
	fILdv7qb7mWi12N/82f2BJIF4MnUXiWVXC0L6C07I9WPZ8EIVjoPOIbeBb/7f2DKvl2Ry9Vg9Bl
	59XcCJdJl6AdfA1jpoVFp1H4/tJ83WzI+2li+P0VWUEImmxJer9lbha8BBz+pI5C85qiRCCNVT+
	q9rOSXB7DMEqkdGlRomVrzFxnn6eTg7J03OM8lNMu6F4L/vBqFAv87M3LH3lep65sM/fobFZ0pF
	ukcVqWZT1jGiOUAxagYp+VlbgVV9EjzXiG0ClyaYQSdz9cEt/qbMSpdRQ32AjijbwJk+cG7CX3N
	jt671oIChnSi3DgXZFLwTJZAtWzN+Km3tl6dRnOgYUg2C2OkGdUpXD4AeIBNhas7SO10VUSYgnA
	70bqTBIWE1hF+1ZzdkNQ==
X-Received: by 2002:a05:6512:3d20:b0:5c1:4a47:b86b with SMTP id
 2adb3069b0e04-5c1709e0a05mr2413431e87.3.1794669553630; Sat, 14 Nov 2026
 07:19:13 -0800 (PST)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <CACOV87VBwH+R3eSBEOuz8hk7OaT63+A9m6ipPSW5wt1VhHMFPg@mail.gmail.com>
In-Reply-To: <CACOV87VBwH+R3eSBEOuz8hk7OaT63+A9m6ipPSW5wt1VhHMFPg@mail.gmail.com>
From: Nathan Blomquist <nblomquist@gmail.com>
Date: Sat, 14 Nov 2026 10:19:02 -0500
X-Gm-Features: AclHuK-21YGiR5kEl6mQS87zA-IC3roYvKMwEQ_WFRXbHch-OPrxp4OoRlpWyAA
Message-ID: <CACOV87WpRNEo=7ckZBdcmGnZ17c3w5qPOe5jY9ZJUdr6y_DAVw@mail.gmail.com>
Subject: Re: [REGRESSION] AMD IOMMU v2 failures on Cezanne; page-table
 flushing helps
To: joro@8bytes.org, vasant.hegde@amd.com
Cc: iommu@lists.linux.dev, suravee.suthikulpanit@amd.com
Content-Type: text/plain; charset="UTF-8"

Hi,

A further test result from the affected Ryzen 5 5600G (Cezanne) system:

I booted with amd_iommu=pgtbl_v2 and the experimental v2 page-table
cache-flushing patch described in my original report. The system boots
successfully, drives/storage work, networking works, and usb devices work.

Before the patch, booting with amd_iommu=pgtbl_v2 caused widespread
failures; almost nothing worked.

This suggests the problem may extend beyond Radeon initialization when
v2 translation is selected more broadly on this system.

The cache-flushing change is still experimental. This result does not
resolve cache visibility versus ordering/timing effects or establish
performance and long-term data integrity.

AI assistance was used to draft this update.

Thanks,
Nathan



On Fri, 13 Nov 2026 13:03:53 -0500, Nathan Blomquist
<nblomquist@gmail.com> wrote:
> Hi,
>
> Resending in plain text because my earlier email included HTML.
> Apologies if you receive this twice.
>
> Could you take a look at this AMD IOMMU regression? Since 7.4-rc1, my Ryzen
> 5 5600G systems fail to initialize Navi GPUs under v2 translation. Identity
> mapping works.
>
> The bisect points to bf5bdfd1f8d4 ("iommu/amd: Force identity mode for
> selected GPUs only").
>
> I've attached a small experimental patch and logs to this comment on the
> AMDGPU bug tracker:
> https://gitlab.freedesktop.org/drm/amd/-/work_items/6081#note_3782405
>
> I found that my dGPU stopped working when trying 7.4-rc1 for a different
> issue.
>
> The patch enables the existing guest-page-table cache-flush handling
> through PT_FEAT_DMA_INCOHERENT. Pristine 7.4-rc2 plus those three lines
> initializes both an RX 6600 and RX 5500 XT, with no IOMMU faults or PSP
> errors. DTEs confirm both still use translated v2 DMA-FQ domains.
>
> I also tested whether the flush's barriers alone were enough. Using one
> unchanged kernel/initramfs, both GPUs gave these results:
>
> - Cache flushing: pass
> - No flushing or barriers: fail
> - Two MFENCEs without flushing: fail
> - No flushing or barriers again: fail
> - Cache flushing again: pass
>
> The feature's other effects were retained in every mode. Failures had IOMMU
> page faults followed by PSP KDB-load failure and probe -22. GCR3-only
> flushing also failed in an earlier test.
>
> So two MFENCEs alone didn't help, but I haven't ruled out the extra delay
> from flushing. This is a diagnostic patch, not a proposed final fix;
> performance is untested.
>
> Is there a known Cezanne coherency erratum or something in the v2
> table-update path we should check? Full logs, DTEs and diagnostic patches
> are available.
>
> AI assistance was used for the diagnostic code, testing and write-up.
>
> Thanks,
> Nathan
>
> Subject: [RFC PATCH] iommu/amd: Enable cache flushing for v2 page tables
>
> On a Ryzen 5 5600G (Cezanne) test system, an RX 6600 and RX 5500 XT
> fail AMDGPU initialization with translated v2 DMA-FQ domains on v7.4-rc2.
> IOMMU page faults precede PSP firmware loading failures and probe -22.
>
> Enable the existing generic page-table incoherent-memory handling for
> AMD v2 domains and provide its required IOMMU device pointer. On x86,
> the existing flush implementation calls clflush_cache_range().
>
> This is an experimental extraction for review, not a proposed final
> platform policy. It enables this handling for all AMD v2 paging domains,
> not just the affected platform. Cache visibility versus flush-induced
> ordering/timing remains unresolved, and performance is unmeasured.
> The feature also disables a single-page fast path and sets an ignored
> AVL bit in non-leaf entries.
>
> AI assistance (OpenCode) was used for the diagnostic implementation,
> test automation, evidence analysis, and this extracted patch and text.
>
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/6081
> ---
> Base: pristine v7.4-rc2, before applying the c1diag diagnostic patch.
> This three-line extraction was separately built and boot-tested once,
> without diagnostic logging, mode selection or GCR3 modifications.
> No GPU workload, performance, cold-boot or other-platform validation yet.
>
> drivers/iommu/amd/iommu.c | 3 +++
> 1 file changed, 3 insertions(+)
>
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -2810,6 +2810,9 @@ static struct iommu_domain
> *amd_iommu_domain_alloc_paging_v2(struct device *dev,
> domain->iommu.nid = dev_to_node(dev);
>
> cfg.common.features = BIT(PT_FEAT_X86_64_AMD_ENCRYPT_TABLES);
> + domain->iommu.iommu_device =
> + &get_amd_iommu_from_dev(dev)->dev->dev;
> + cfg.common.features |= BIT(PT_FEAT_DMA_INCOHERENT);
> if (amd_iommu_np_cache)
> cfg.common.features |= BIT(PT_FEAT_FLUSH_RANGE_NO_GAPS);
> else
>
> base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
