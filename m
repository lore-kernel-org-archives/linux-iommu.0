Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E69E2C21C0;
	Tue, 13 Jan 2026 15:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768316758; cv=none; b=OhaNZSuF7DUE6sqbBwg3wTwbiLqDuRXBLcagdv/1rmI8bcZS7c6XbH9fi/Dv4hYsGb6kT00XyYJSD0VB2RWJxoBIZmaDLdy6iEHdiFy+HsYk83x22zAW/7XdnoANnAswwn4u2a8/Spor2bLR0WxxmNaCHlCM1uvlOcyllCE7Z7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768316758; c=relaxed/simple;
	bh=Xf5PxXObJb1p8ordy+fY/duh24byIHYMJ9YaRb9qn1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F2dYeRe6B3RYbfaXc/EnOdlTnPSEibc+UL0LbsG+UeP0shqYIrOeGbM/MWUvJGTHkGPOSaOd+dDroZzJkHE5EEzu6fZTE/544xJv2L9MUvberShZHqmj1Dq+njD548ODwzGTlYLipSFwx/2XEJVUDJvyYXgUzxlVBGxylWCWIUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m4ly5Q5T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m4ly5Q5T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FA37C116C6;
	Tue, 13 Jan 2026 15:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768316757;
	bh=Xf5PxXObJb1p8ordy+fY/duh24byIHYMJ9YaRb9qn1M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m4ly5Q5TCjqSluQ9NvuxIe6iBKfTcKlHfDKbap6DpUAwMdMJaZxaEArYOcFiGrr2G
	 jPcu9HN8R7QvxvE9NDnJKrkrJk8iEHSWB9EFYCH5/PJkznz3O7rmVbGVxE0fPpxx9N
	 sns1RG6zenoH+IJAMiO5QrJmg4o2nM5cFh3hs3hfZpxkH/r3TBnJvaT5ZD6cpPmxlv
	 qly9AxWL5y99b0e6u2gU2GTDSB8baOQKcM04QPb97002/8Nr3SWYI9tkocOzPLMl1w
	 8iNsHcamIH3KmNI4IZprJdhMccZ0l03BHBOjDAxv+piXOMghIc0mrb0z6OtdH6O1PZ
	 PS3YjhZWCY+tw==
Date: Tue, 13 Jan 2026 15:05:52 +0000
From: Will Deacon <will@kernel.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, robin.murphy@arm.com, joro@8bytes.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, skolothumtho@nvidia.com,
	praan@google.com, xueshuai@linux.alibaba.com, smostafa@google.com
Subject: Re: [PATCH rc v5 1/4] iommu/arm-smmu-v3: Add update_safe bits to fix
 STE update sequence
Message-ID: <aWZfUNXEka3GBf9s@willie-the-truck>
References: <cover.1766093909.git.nicolinc@nvidia.com>
 <58f5af553fa7c3b5fd16f1eb13a81ae428f85678.1766093909.git.nicolinc@nvidia.com>
 <aV7OBrH-TDiGRblt@willie-the-truck>
 <20260108003646.GA537728@nvidia.com>
 <aWUY-f3kvM94z4qh@willie-the-truck>
 <20260112161010.GC812923@nvidia.com>
 <aWVETpwlx9Rhs8Kw@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWVETpwlx9Rhs8Kw@Asurada-Nvidia>

On Mon, Jan 12, 2026 at 10:58:22AM -0800, Nicolin Chen wrote:
> On Mon, Jan 12, 2026 at 12:10:10PM -0400, Jason Gunthorpe wrote:
> > Still, it seems easy enough to improve, do not add EATS to the safe
> > bits if either the current or new STE has S2S set. That will force a
> > V=0 and avoid the illegal STE. Nicolin?
> 
> Ack. I made the following changes:
> -----------------------------------------------------------------
> @@ -1083,7 +1083,8 @@ void arm_smmu_get_ste_used(const __le64 *ent, __le64 *used_bits)
>  EXPORT_SYMBOL_IF_KUNIT(arm_smmu_get_ste_used);
> 
>  VISIBLE_IF_KUNIT
> -void arm_smmu_get_ste_update_safe(__le64 *safe_bits)
> +void arm_smmu_get_ste_update_safe(const __le64 *cur, const __le64 *target,
> +                                 __le64 *safe_bits)
>  {
>         /*
>          * MEV does not meaningfully impact the operation of the HW, it only
> @@ -1097,13 +1098,22 @@ void arm_smmu_get_ste_update_safe(__le64 *safe_bits)
>         safe_bits[1] |= cpu_to_le64(STRTAB_STE_1_MEV);
> 
>         /*
> -        * EATS is used to reject and control the ATS behavior of the device. If
> -        * we are changing it away from 0 then we already trust the device to
> -        * use ATS properly and we have sequenced the device's ATS enable in PCI
> -        * config space to prevent it from issuing ATS while we are changing
> -        * EATS.
> +        * When a STE comes to change EATS the sequencing code in the attach
> +        * logic already will have the PCI cap for ATS disabled. Thus at this
> +        * moment we can expect that the device will not generate ATS queries
> +        * and so we don't care about the sequencing of EATS. The purpose of
> +        * EATS is to protect the system from hostile untrusted devices that
> +        * issue ATS when the PCI config space is disabled. However, if EATS
> +        * is being changed then we already must be trusting the device since
> +        * the EATS security block is being disabled.
> +        *
> +        *  Note: Since we moved the EATS update to the first phase, changing
> +        *  S2S and EATS might transiently set S2S=1 and EATS=1, resulting in
> +        *  a bad STE. See "5.2 Stream Table Entry". In such a case, we can't
> +        *  do a hitless update.
>          */
> -       safe_bits[1] |= cpu_to_le64(STRTAB_STE_1_EATS);
> +       if (!((cur[2] | target[2]) & cpu_to_le64(STRTAB_STE_2_S2S)))
> +               safe_bits[1] |= cpu_to_le64(STRTAB_STE_1_EATS);

I suppose we shouldn't ever see the case that they both have S2S, but
that's fine.

The spec also suggests that there's an additional illegal STE case w/
split-stage ATS (EATS_S1CHK) if Config != S1+S2.

I do wonder whether having all the hitless machinery alongside this
"safe" stuff is really overkill and we wouldn't be better off just
checking the cases that we actually care about rather than checking
architecturally and then subtracting the cases we don't care about.

Will
