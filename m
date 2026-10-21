Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792590310;
	b=Z8DhnCgMzd8URoGSYWLNZPlxkiebq1mCq+RekfMFx9lht0RGIYX/C2gLxId5MvYArYww
	 4AiYNh/m6eZ0MKyG32f+C4mddbwoRncSxiR6arOwAz6RaIG8XjI3vETh+UjIv99uU+qmK
	 mb7VKMOvR4ayavKrgDILm8AGGd8dusLGGbZad/Jm97AdrZsTEM+LKTKEHO7iX5K0tONZR
	 SYcupbFhtOzEmiw0679Kx9wbi2kIQuJ8FUPeEtKYyqch3D6fQ+QqoNKLNP+xbiPR5Iw7+
	 /BKCn5v0vPIegnTzEwyRMZsWVxazOW14SmQUiwp1/KzBHo3tEU6b2JorTRWZSiAkyEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792590310;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=14kePxaJgvrh0ObJmhms1Rosb4Wt+rKX1sH/AFcKt3s=;
	b=gpddU5fxloasMmS4LXcSM4ua193pzkxCkq8WSJTKqhrvSuTvgdUXcby6VU334K41AfC8
	 ei/uE8L58Hf0wsm534PU3kVzT4fbpsn6x97y7S9xlIJ+KBhYYvrViSpDnJ0N+4K5iO6cO
	 FaQR9DmYutOaFNAAZbNW9IX73oaFkZM2aRXaXejRKu0jFEWsUFaTzYe8WWysErvTC0yVZ
	 60tWpA6rF44MbM8l3f+LaJWwbJ7HZVlUy/qi9rgajSgyVuNFhPSg0nEiuVP6gThC4I+NA
	 olkH6oXa8vSN+DOoWYH70GQxC/nCphQYgafxMtzP+vGegqQPkMR4Qdke1hqYZ5W9wSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=tJOZoNk4;
	arc=none smtp.remote-ip=209.85.208.41
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FA7606A32E
	for <iommu@lists.linux.dev>; Wed, 21 Oct 2026 13:45:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3FA7606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=tJOZoNk4
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6b1aa36fc0eso13168a12.0
        for <iommu@lists.linux.dev>; Wed, 21 Oct 2026 06:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792590308; x=1793195108; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=14kePxaJgvrh0ObJmhms1Rosb4Wt+rKX1sH/AFcKt3s=;
        b=tJOZoNk4nRncfBtXVElWkKjjf/H79uPCEXPWEGtNzT6iT1b1i9j90rGm0DvSYkt8M+
         Be1PsI0OHV3+eEWw87cpjSIyb1QEapEG3esmytUqtLw9CP1M7p4ZCiZMfzvAmNX2ClcE
         TqRkFQLYHzeLqCN1N7LlPLTqQnfiMJPogWHTwvPwGJbMGbtTjIqYplrhuoL1liMyvArV
         5poozMfgUtFZQ1VXnuYuttp41o5q/Rf9XnSslExGjpPxcZJ9/wUiZrCcCqJ4aO8hN5kM
         1ibZE1Tg8lDE7v2uyJ74aSADAa3idjtlmDKCj4w4H5Qc5XNxjJbyTUwOPoSClN0z4Zh6
         c9GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792590308; x=1793195108;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=14kePxaJgvrh0ObJmhms1Rosb4Wt+rKX1sH/AFcKt3s=;
        b=EhDJ1o550Gv/1w0LPHkv4asDV1vOc5GMg/ClSxv8zZlXDj36cjS+qo9uyzBsIfmUiS
         13fmxZWSqHyzFi4khONwc3d+WyXzM6m3cqJRqNMr6v1RQ8qg/F1TqdvFvO03m0KWe+ct
         wM/qMHBIYCcHYWQxsCmiBK66BuV7A8+PaUFg/979NR/4wKDK9xHLE3o4WRAsmD4SMDbU
         bQZGez+JuPtmXjufdAAGe9OXTlHjKjk3dZSyw6oImtBEfLHoZcgXT1AoADjWVZmkM1pR
         2KP5j175YUEzgoyDZUgvcFzgAFuemqyE2SvfGy0TDkQZg2bGZxthazLdAa8gRrq/L81u
         DOeQ==
X-Forwarded-Encrypted: i=1; AKwUvBwVdIysc5koIN6RokDgpoHeC9n0nF9SVwVdJHQteZmoUbcb61FyqT16c4LdiAGVdE+ngMRDYw==@lists.linux.dev
X-Gm-Message-State: AFq9FYLVNsA6UfJaW6bJ3zWxVdlyqxC94kRXVz+7Nt2gkKwUnWrZpqW/
	NwVAmFs42TKSGqT9XuuinP8THqr1ZgloNzDrZsfQPMjwV6JIzaGuONJjeZBF5+Icsw==
X-Gm-Gg: AYBFou0wjyzR1ViJvtSfd6erkF+NmX1SvTQ4i+fM98ov2gyKki8BGeDjbuFCpdW83/G
	pUowhJZIUcjoPLWu/a4p/jh2MGk7KeAx2AhKhgeVpebcdBn/MMYTimOSEW7q4aRAZbrMYWBvgfr
	cOTImXmk/qlQXTmigSYO7OncXez1tnEFXL5GAfCwevBCgwd168kfR3YjhfBKG9l67hKYNQ0ngj9
	uFmAskzttQXW3XXnVA/ZQ4mjFGPXOAfjLMtJEtl8TYgIKzbEP/I43U+ci08QjQUtY5A1yL9qJ6M
	KWVEbhRJT7q2mJOdrWTOazu6WqqVXv9WM7MCOpWso/L54tu9HvuTx+IJB06U4he9Ep6x0Q5AnGY
	T0o3S8hV6bS3Z8EcyHbS2zg3Nttg374aA+1vfGtDdoAnM1u3m+chbRw+liNBRQzfRXyKI4TuB1H
	dTQVabR66usNfHJ17lp8majHjuzIOTQA6pppl7Dh0et17Jp36v2/IlqoEO8Aw6vbYtIk3Pgi9B2
	a9P5o8NxqioDshPNToVCX6HGr6Lbyzy1oq3WiLtFmIDqJKn11tuHnWoCpJWlu+/C3Lzl1i+CaUg
	Yzu6b7Azmx+zJsXRpUV5bjLUdaRQwRBoWfEws1V6hVg=
X-Received: by 2002:aa7:cf8c:0:b0:6b1:d80d:396b with SMTP id 4fb4d7f45d1cf-6b3e9c11a49mr111990a12.14.1792590307609;
        Wed, 21 Oct 2026 06:45:07 -0700 (PDT)
Received: from google.com (250.192.189.35.bc.googleusercontent.com. [35.189.192.250])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c468a61b2aasm5475966b.86.2026.10.21.06.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 06:45:06 -0700 (PDT)
Date: Wed, 21 Oct 2026 13:45:03 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, jgg@nvidia.com,
	praan@google.com, kevin.tian@intel.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, jamien@nvidia.com, kas@kernel.org,
	Cristian Prundeanu <cpru@amazon.com>,
	Breno Leitao <leitao@kernel.org>
Subject: Re: [PATCH v11 06/11] iommu/arm-smmu-v3: Add
 ARM_SMMU_OPT_KDUMP_ADOPT for kdump kernel
Message-ID: <atjB34tvJySp9abz@google.com>
References: <cover.1791226953.git.nicolinc@nvidia.com>
 <ee4257b62324aa75d7140f1f4a49aa0f78586fff.1791226953.git.nicolinc@nvidia.com>
 <atdSrRwrphdI9ZQA@google.com>
 <atemgT/67JPpdk57@nvidia.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <atemgT/67JPpdk57@nvidia.com>

On Tue, Oct 20, 2026 at 10:36:01AM -0700, Nicolin Chen wrote:
> On Tue, Oct 20, 2026 at 11:38:21AM +0000, Mostafa Saleh wrote:
> > On Mon, Oct 05, 2026 at 12:30:49PM -0700, Nicolin Chen wrote:
> > > +	/*
> > > +	 * According to spec (6.3.24), HW aligns the base down to the table size
> > > +	 * and ignores the low bits, so an unaligned base would make this kernel
> > > +	 * read a different table.
> > > +	 */
> > > +	if (!IS_ALIGNED(base, size)) {
> > > +		dev_err(smmu->dev, "unaligned stream table base %pa\n", &base);
> > 
> > I understand these are best effort, but what happens if the address
> > corrupted and happens to be aligned?
> 
> This is a basic sanity so HW wouldn't immediately fail. A corrupted
> address would be trickier to test out; also we don't have a perfect
> way to do that. Earlier versions had some address range check. I've
> dropped it, following Jason's comments.
> 
> This is also in the kdocs of the whole smmu kdump functions:
> 
>  *  - Only a coherent SMMU (ARM_SMMU_FEAT_COHERENCY) is supported, as the stream
>  *    table adoption is done by memremap with MEMREMAP_WB, which is verified on
>  *    the real hardware. Callers of these functions are responsible for gating
>  *    ARM_SMMU_FEAT_COHERENCY once during the probe.
>  */
> 
> > > +int arm_smmu_kdump_adopt_deferred_l2_strtab(struct arm_smmu_device *smmu,
> > > +					    u32 sid, phys_addr_t base, u32 span,
> > > +					    struct arm_smmu_strtab_l2 **l2table)
> > > +{
> > > +	struct arm_smmu_strtab_l2 *table;
> > > +	size_t size;
> > > +
> > > +	/*
> > > +	 * Retest the span in case the L1 descriptor has been overwritten since
> > > +	 * the adopt. Reject this master's insert; panic or SMMU-disable would
> > > +	 * either lose the vmcore or cascade aborts. Do not try to fix it, as it
> > > +	 * would break all other SIDs in the same bus (PCI case). The corruption
> > > +	 * blast radius is already bounded to that bus range.
> > > +	 */
> > > +	if (span != STRTAB_SPLIT + 1) {
> > > +		dev_err(smmu->dev,
> > > +			"L1[%u] span %u changed since adopt (was %u)\n",
> > > +			arm_smmu_strtab_l1_idx(sid), span, STRTAB_SPLIT + 1);
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	size = (1UL << (span - 1)) * sizeof(struct arm_smmu_ste);
> > > +
> > > +	/* Same live-corruption check as the span; reject an overwritten base */
> > > +	if (!base || !IS_ALIGNED(base, size)) {
> > > +		dev_err(smmu->dev, "L1[%u] bad l2 table base %pa\n",
> > > +			arm_smmu_strtab_l1_idx(sid), &base);
> > > +		return -EINVAL;
> > > +	}
> > > +
> > 
> > Those are a bit similar to arm_smmu_kexec_parse_strtab_2lvl() is it
> > possible to have some helpers instead?
> 
> Sure. I can do that.
> 
> > > +int arm_smmu_kdump_adopt_strtab(struct arm_smmu_device *smmu)
> > > +{
> > > +	u32 cfg_reg = readl_relaxed(smmu->base + ARM_SMMU_STRTAB_BASE_CFG);
> > > +	u64 base_reg = readq_relaxed(smmu->base + ARM_SMMU_STRTAB_BASE);
> > > +	bool was_2lvl = smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB;
> > > +	phys_addr_t base = base_reg & STRTAB_BASE_ADDR_MASK;
> > > +	u32 fmt = FIELD_GET(STRTAB_BASE_CFG_FMT, cfg_reg);
> > > +	int ret;
> > > +
> > > +	dev_dbg(smmu->dev, "adopting crashed kernel's stream table\n");
> > > +
> > > +	if (fmt == STRTAB_BASE_CFG_FMT_2LVL) {
> > > +		/*
> > > +		 * Both kernels run on the same hardware, so it's impossible for
> > > +		 * kdump kernel to see the support for linear stream table only.
> > > +		 */
> > 
> > STRTAB_SPLIT which influences ARM_SMMU_FEAT_2_LVL_STRTAB is a SW choice, so it is
> 
> I missed that.
> 
> > possible to get such mismatch if STRTAB_SPLIT of the newer kernel is larger than the
> > older kernel.
> > However, I agree that in that case it's better to refuse the adoption.
> >
> > > +		if (WARN_ON(!(smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB)))
> > > +			ret = -EINVAL;
> 
> I can replace the FEAT guard here with
> 
> 	if (WARN_ON(FIELD_GET(IDR0_ST_LVL, idr0) != IDR0_ST_LVL_2LVL))
> 		ret = -EINVAL;
> 

That makes more sense with the comment about for structural validation,
although.

> > > +		else
> > > +			ret = arm_smmu_kdump_adopt_strtab_2lvl(smmu, cfg_reg,
> > > +							       base);
> > > +	} else if (fmt == STRTAB_BASE_CFG_FMT_LINEAR) {
> > > +		/*
> > > +		 * The kdump kernel need not match the crashed kernel. An older
> > > +		 * crashed kernel that predates two-level stream table support
> > > +		 * may have used a linear table on 2-level-capable hardware, so
> > > +		 * enforce the same format here to match the adopted table.
> > > +		 */
> > > +		ret = arm_smmu_kdump_adopt_strtab_linear(smmu, cfg_reg, base);
> > > +		if (!ret)
> > > +			smmu->features &= ~ARM_SMMU_FEAT_2_LVL_STRTAB;
> > 
> > For simplicity, it is better to enforce the same table formats between
> > kernels as the rest of the file, for example,
> > arm_smmu_kexec_parse_strtab_2lvl() refuses different STRTAB_SPLIT.
> > Some checks can be removed and the was_2lvl error path. It's
> > very unlikely to hit such case anyway.
> 
> Sashiko pointed out a corner case that a modified kernel kdumps
> into a vanilla kernel. It is not really a big effort to support
> it. So, I would rather keep this.

I see, I have no strong opinion, but I think we can just ignore sashiko
here, and this can be a limitation as long as it fails gracefully, it
makes the patch slightly easier to reason about.

> 
> > > +	} else {
> > > +		dev_err(smmu->dev, "invalid STRTAB format %u\n", fmt);
> > > +		ret = -EINVAL;
> > > +	}
> > > +
> > > +	if (ret) {
> > > +		arm_smmu_kdump_adopt_cleanup(smmu);
> > 
> > Probably easier to inline the error handling after each call and remove this?
> 
> I don't quite follow this. The clean function is used by three
> sites. How can we remove it?

I see, I missed it is also used in devm_add_action_or_reset()

Thanks,
Mostafa

> 
> Thanks
> Nicolin
> 
