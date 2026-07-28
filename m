Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C0627AC31
	for <iommu@lists.linux.dev>; Tue, 28 Jul 2026 10:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785233007; cv=none; b=q6IUVlInNzTNe8aLIclms4tNhLDfjmMkwRux4x3aSONvIjiIO99awmPqoWCsGNHD0BmVnOaUbJ17gsT8Eyb5WXSCynBuJXg5flHonmBU/+BBA0p/nsJKHqxqMrHyJtWzysiN/JZNMeZz/fJ+GsI3PchlEYCKIgZdLPZV58wwIX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785233007; c=relaxed/simple;
	bh=C794aoCPt4x14/i/B2KzFGvlvv5P6Xq2V1Y4ahB1pOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X8aKxKA7hYn4DapH01oOnJ8lPTS1MXYEHbfZT1ZpJro0MChYZuBPEXmCj6+3CdoW3wrK9bvTBxJJ7RGxTiXr8K9arkIcFP9BrEbd0mHXsQYJ4Mm/ZxeIuY60UlHW5eQ/qCd6t2VH1yYH9NRWNMnir8x7RY3NJhqG7/q/uTPJZ7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BtMswrpA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BtMswrpA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6A161F000E9;
	Tue, 28 Jul 2026 10:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785233006;
	bh=2eSPIDKzh3hZMBFlXK8+Byxo5earaMZxst52f30+aek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BtMswrpA0KElM78Uc6VPB02Hu5cEm10KeI4wy0Z9NJ30pQIk0ubgq471hrnsrZLGs
	 s/k0EJrhYzUA3Fz8HinxIWH2fbBuqHuFTREjPHv0WcOHS3JM/v5+f648VSk6fFxZ11
	 34JiQQVMZZK/j9Mwj4VeB0svRMTcoQZiiy3QHaS1QiL8n/8e/HM0uK3kSJTOxh0SK8
	 c/iPkNQkkbjbPPmTfgJFmbJBZFIUP3SMGqXSQgBvMMIJgX4XEo27K1eZkQOlzdiWi4
	 UeeOuHuNanjrcRtWEeJdHcw8wIUw66/Zf7gaL7OmcC6w+NY4njgk5B5iZrXflh89gS
	 8l4QLA10m+BRQ==
Date: Tue, 28 Jul 2026 11:03:21 +0100
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: catalin.marinas@arm.com, joro@8bytes.org, jpb@kernel.org,
	jgg@nvidia.com, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/2] arm64: Add override for MMFR1.HAFDBS
Message-ID: <amh-aW67-ifCUXXF@willie-the-truck>
References: <cover.1785153415.git.robin.murphy@arm.com>
 <d7b31cbcd984c1efa61d2fc97111150cc18e21b0.1785153415.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7b31cbcd984c1efa61d2fc97111150cc18e21b0.1785153415.git.robin.murphy@arm.com>

On Mon, Jul 27, 2026 at 01:03:28PM +0100, Robin Murphy wrote:
> In general it might be nice to have the ability to disable hardware
> access/dirty bit management for debugging or performance comparison
> purposes without having to rebuild the kernel. However once FEAT_HAFT
> comes into the picture we also start to have a real functional concern
> where the decision to use HAFT based on the boot CPUs can prevent SVA
> or late-onlining if SMMUs/CPUs are later found to lack HAFT support.
> 
> To that end, add the appropriate MMFR1 override, with an easy "nohaft"
> alias for the significant case, partly since the feature/field naming
> isn't the most obvious, but also so it could potentially be redirected
> in future if someone wanted to attempt a higher-level means of turning
> off just HAFT usage independently from FEAT_HDBSS.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> 
> v3: No change.
> 
>  Documentation/admin-guide/kernel-parameters.txt | 3 +++
>  arch/arm64/kernel/pi/idreg-override.c           | 2 ++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index b5493a7f8f22..7f23e5b8dc44 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -565,6 +565,9 @@ Kernel parameters
>  	arm64.nogcs	[ARM64] Unconditionally disable Guarded Control Stack
>  			support
>  
> +	arm64.nohaft	[ARM64] Unconditionally disable Hardware managed Access
> +			Flag for Table descriptors support
> +
>  	arm64.nomops	[ARM64] Unconditionally disable Memory Copy and Memory
>  			Set instructions support
>  
> diff --git a/arch/arm64/kernel/pi/idreg-override.c b/arch/arm64/kernel/pi/idreg-override.c
> index bc57b290e5e7..0e051fec5afe 100644
> --- a/arch/arm64/kernel/pi/idreg-override.c
> +++ b/arch/arm64/kernel/pi/idreg-override.c
> @@ -64,6 +64,7 @@ static const struct ftr_set_desc mmfr1 __prel64_initconst = {
>  	.override	= &id_aa64mmfr1_override,
>  	.fields		= {
>  		FIELD("vh", ID_AA64MMFR1_EL1_VH_SHIFT, mmfr1_vh_filter),
> +		FIELD("hafdbs", ID_AA64MMFR1_EL1_HAFDBS_SHIFT, NULL),
>  		{}
>  	},
>  };
> @@ -246,6 +247,7 @@ static const struct {
>  	{ "arm64.nomte",		"id_aa64pfr1.mte=0" },
>  	{ "nokaslr",			"arm64_sw.nokaslr=1" },
>  	{ "rodata=off",			"arm64_sw.rodataoff=1" },
> +	{ "arm64.nohaft",		"id_aa64mmfr1.hafdbs=2" },

What happens if I pass this option on a CPU that doesn't implement
HTTU at all? Will that then end up *enabling* HA and HD?

Will
