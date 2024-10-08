Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4051DED48;
	Tue,  8 Oct 2024 13:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728394504; cv=none; b=u4uwDkbfK9oLzEh/qcIUa3kaHuHVaak+2Qy2D2bGAqOtUmtwBXcb+Y84UQMRfXk0jn1o4yKaZLcoM4YsCmvmuBtKFaQ3MyrUrV8LQwSBnTsoooUU6cVPZvzTMu0hWX/19LiP1WLeKavWLqT5R7YbWKAxj7FsKz6lz2JlPzjZUOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728394504; c=relaxed/simple;
	bh=rhzeorojdWXbtQKT/eLfgADYU779cPzVT9gYFI0nvR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e3EfIlAEIr0hYnjMa611/WpTIienoIJYa8xoHnGRblbPqhpDvaWOkJX7Y/kHXi0yyBq1UuwmNT35kcI8dezxWhv6rnd+XiUKeSza1Yh3pdkYl94vKW5i/i3NsRxM+y+hFLVC+8VB0gW3G936WW9VIxMdxz+m+qd/ARPbucn0EFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UEm8Zo3K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UEm8Zo3K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2A08C4CEC7;
	Tue,  8 Oct 2024 13:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728394503;
	bh=rhzeorojdWXbtQKT/eLfgADYU779cPzVT9gYFI0nvR8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UEm8Zo3K+6x1JaQ/8/pddrhX+o+jYj/XQOtf9+t9/XJoNanY9At4FsmQaFs/4XdjL
	 akH2k2aAtqAP7odf/xIqdf4qSxNWqv8e1+CkjXPOSvTbE+qIU0pBrLRWX42sPdfPGG
	 K3ZMBcEBW6bRLftIJtUlgLu0yQA8H58lEJE00GG5QYviaBX6AjblxQLGBlMXsS4E+f
	 i78vfQovNAMFYfnBNh4pIcQpk4LenLyCMTVRg9+NAp3bvp8efI4eyTUHlefjnhEFLy
	 qd8iQw8zVRzR1Ky3OvTOxjIz0Z+JRJSn4kV6UA40cksOTPPlaeoA0ikFja9BFBjNyF
	 2a9C1upNMtehw==
Date: Tue, 8 Oct 2024 14:34:58 +0100
From: Will Deacon <will@kernel.org>
To: Yang Shi <yang@os.amperecomputing.com>
Cc: jgg@ziepe.ca, nicolinc@nvidia.com, james.morse@arm.com,
	robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [v3 PATCH] iommu/arm-smmu-v3: Fix L1 stream table index
 calculation for 32-bit sid size
Message-ID: <20241008133458.GA10474@willie-the-truck>
References: <20241004180405.555194-1-yang@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004180405.555194-1-yang@os.amperecomputing.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi folks,

Sorry I'm late to the party, I went fishing.

On Fri, Oct 04, 2024 at 11:04:05AM -0700, Yang Shi wrote:
> The commit ce410410f1a7 ("iommu/arm-smmu-v3: Add arm_smmu_strtab_l1/2_idx()")
> calculated the last index of L1 stream table by 1 << smmu->sid_bits. 1
> is 32 bit value.
> However some platforms, for example, AmpereOne and the platforms with
> ARM MMU-700, have 32-bit stream id size.  This resulted in ouf-of-bound shift.
> The disassembly of shift is:
> 
>     ldr     w2, [x19, 828]  //, smmu_7(D)->sid_bits
>     mov     w20, 1
>     lsl     w20, w20, w2
> 
> According to ARM spec, if the registers are 32 bit, the instruction actually
> does:
>     dest = src << (shift % 32)
> 
> So it actually shifted by zero bit.
> 
> The out-of-bound shift is also undefined behavior according to C
> language standard.
> 
> This caused v6.12-rc1 failed to boot on such platforms.
> 
> UBSAN also reported:
> 
> UBSAN: shift-out-of-bounds in drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:3628:29
> shift exponent 32 is too large for 32-bit type 'int'
> 
> Using 64 bit immediate when doing shift can solve the problem.  The
> disassembly after the fix looks like:
>     ldr     w20, [x19, 828] //, smmu_7(D)->sid_bits
>     mov     x0, 1
>     lsl     x0, x0, x20
> 
> There are a couple of problematic places, extracted the shift into a helper.
> 
> Fixes: ce410410f1a7 ("iommu/arm-smmu-v3: Add arm_smmu_strtab_l1/2_idx()")
> Tested-by: James Morse <james.morse@arm.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 16 +++++++++++-----
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  5 +++++
>  2 files changed, 16 insertions(+), 5 deletions(-)

[...]

> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 737c5b882355..9d4fc91d9258 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -3624,8 +3624,9 @@ static int arm_smmu_init_strtab_2lvl(struct arm_smmu_device *smmu)
>  {
>  	u32 l1size;
>  	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
> +	u64 num_sids = arm_smmu_strtab_num_sids(smmu);
>  	unsigned int last_sid_idx =
> -		arm_smmu_strtab_l1_idx((1 << smmu->sid_bits) - 1);
> +		arm_smmu_strtab_l1_idx(num_sids - 1);
>  
>  	/* Calculate the L1 size, capped to the SIDSIZE. */
>  	cfg->l2.num_l1_ents = min(last_sid_idx + 1, STRTAB_MAX_L1_ENTRIES);
> @@ -3655,20 +3656,25 @@ static int arm_smmu_init_strtab_2lvl(struct arm_smmu_device *smmu)
>  
>  static int arm_smmu_init_strtab_linear(struct arm_smmu_device *smmu)
>  {
> -	u32 size;
> +	u64 size;
>  	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
> +	u64 num_sids = arm_smmu_strtab_num_sids(smmu);
> +
> +	size = num_sids * sizeof(struct arm_smmu_ste);
> +	/* The max size for dmam_alloc_coherent() is 32-bit */
> +	if (size > SIZE_MAX)
> +		return -EINVAL;
>  
> -	size = (1 << smmu->sid_bits) * sizeof(struct arm_smmu_ste);
>  	cfg->linear.table = dmam_alloc_coherent(smmu->dev, size,
>  						&cfg->linear.ste_dma,
>  						GFP_KERNEL);
>  	if (!cfg->linear.table) {
>  		dev_err(smmu->dev,
> -			"failed to allocate linear stream table (%u bytes)\n",
> +			"failed to allocate linear stream table (%llu bytes)\n",
>  			size);
>  		return -ENOMEM;
>  	}
> -	cfg->linear.num_ents = 1 << smmu->sid_bits;
> +	cfg->linear.num_ents = num_sids;

This all looks a bit messy to me. The architecture guarantees that
2-level stream tables are supported once we hit 7-bit SIDs and, although
the driver relaxes this to > 8-bit SIDs, we'll never run into overflow
problems in the linear table code above.

So I'm inclined to take Daniel's one-liner [1] which just chucks the
'ULL' suffix into the 2-level case. Otherwise, we're in a weird
situation where the size is 64-bit for a short while until it gets
truncated anyway when we assign it to a 32-bit field.

Any objections?

Will

[1] https://lore.kernel.org/r/20241002015357.1766934-1-danielmentz@google.com
