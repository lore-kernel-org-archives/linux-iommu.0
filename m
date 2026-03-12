Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2AC3D76;
	Thu, 12 Mar 2026 13:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773323492; cv=none; b=l/rNAnjlRyjAh1OUcMOk1QNu20nPUzIeAbti3kk7bvWdU/+ceWwIfmkpj0kdBXEOt/jbh1F36Fphb5poyH+SW27I9ViWdLPhhZKauvBeL16Y5HhvW7H0EGY0cTGfz92Vy9FcH2RggRt0z3FI+d/OMZCiZLX1X6hOeen4kczjHKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773323492; c=relaxed/simple;
	bh=PtSQ2Ji9q7XrnlvdmM/5zKCUgRKhbcNIzSsBGPLburI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j+DXSHme+BHUaXxO6CfI4b5R2xrRFkaQkuHXTkGqSNI7u7YU3EqP6mj4ztlFJpD+ThLn+VMt0ZMmK3RZ6mY2s+DG/zc1Uv0/AJorGNh1W9pdCH/0WqKU/KK/Stwk8VMh3cB5HEFqwyVzYtp1Rsz5rewOILeQSXb6uuslVXtK/74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xp4kGILZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xp4kGILZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71A11C4CEF7;
	Thu, 12 Mar 2026 13:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773323492;
	bh=PtSQ2Ji9q7XrnlvdmM/5zKCUgRKhbcNIzSsBGPLburI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xp4kGILZZoZG5mZO5MA4SQjgRU9aeQOtahllK7QTjyngC8DSEWRdrR6ZtRdlLyYtD
	 jIzQK5EPE18m9+V+3gZo7yEW7QwUrcim9204Sqm7QPeR24mzGu1rd1HcxGQee2eJx7
	 UoXhhyIvw4evqAD5J/B2/x2xHVpukB/fM2xAgbaznDlV8/xxFbSrXLMyZA30gU7Neh
	 koOCGw754sJuWUx4uBJQ7FiAzpAOmG9EwcO8FgHww1mN9c2iCHcLhjRBVChXYMUfZR
	 M32XVIj7KmWwNPZ1oYTVrCaIBpZfyGjz/vCV04fsHijCk0uNBJK5JJYOpGd94IA9XL
	 6QKXEfJEFKFtw==
Date: Thu, 12 Mar 2026 13:51:26 +0000
From: Will Deacon <will@kernel.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: robin.murphy@arm.com, joro@8bytes.org, jgg@nvidia.com, praan@google.com,
	mmarrid@nvidia.com, kees@kernel.org, Alexander.Grest@microsoft.com,
	baolu.lu@linux.intel.com, smostafa@google.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, bbiber@nvidia.com,
	skaestle@nvidia.com
Subject: Re: [PATCH rc] iommu/arm-smmu-v3: Drain in-flight fault handlers
Message-ID: <abLE3rdM9YAu81tq@willie-the-truck>
References: <20260307001723.964956-1-nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260307001723.964956-1-nicolinc@nvidia.com>

On Fri, Mar 06, 2026 at 04:17:23PM -0800, Nicolin Chen wrote:
> From: Malak Marrid <mmarrid@nvidia.com>
> 
> When a device is switching away from a domain, either through a detach or a
> replace operation, it must drain its IOPF queue that only contains the page
> requests for the old domain.
> 
> Currently, the IOPF infrastructure is used by master->stall_enabled. So the
> stalled transaction for the old domain should be resumed/terminated. Fix it
> properly.
> 
> Fixes: cfea71aea921 ("iommu/arm-smmu-v3: Put iopf enablement in the domain attach path")
> Cc: stable@vger.kernel.org
> Co-developed-by: Barak Biber <bbiber@nvidia.com>
> Signed-off-by: Barak Biber <bbiber@nvidia.com>
> Co-developed-by: Stefan Kaestle <skaestle@nvidia.com>
> Signed-off-by: Stefan Kaestle <skaestle@nvidia.com>
> Signed-off-by: Malak Marrid <mmarrid@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 4d00d796f0783..2176ee8bec767 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2843,6 +2843,12 @@ static int arm_smmu_enable_iopf(struct arm_smmu_master *master,
>  	if (master->iopf_refcount) {
>  		master->iopf_refcount++;
>  		master_domain->using_iopf = true;
> +		/*
> +		 * If the device is already on the IOPF queue (domain replace),
> +		 * drain in-flight fault handlers so nothing will hold the old
> +		 * domain when the core switches the attach handle.
> +		 */
> +		iopf_queue_flush_dev(master->dev);

So this drains the iopf workqueue, but don't you still have a race with
the hardware generating a fault on the old domain and then that only
showing up once you've switched to the new one? What is the actual
problem you're trying to solve with this patch?

>  		return 0;
>  	}
>  
> @@ -2866,8 +2872,11 @@ static void arm_smmu_disable_iopf(struct arm_smmu_master *master,
>  		return;
>  
>  	master->iopf_refcount--;
> -	if (master->iopf_refcount == 0)
> +	if (master->iopf_refcount == 0) {
> +		/* Drain in-flight fault handlers before removing device */
> +		iopf_queue_flush_dev(master->dev);
>  		iopf_queue_remove_device(master->smmu->evtq.iopf, master->dev);

Why doesn't iopf_queue_remove_device() handle the draining? Is there a
case where you _don't_ want to drain the faults on the disable path?

Will
