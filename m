Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6916A315D40;
	Thu, 19 Mar 2026 14:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773931639; cv=none; b=d2GxdUS8d01+Jo4RUQsvtovrgUlQmBrJ0akVzLcSDFMuRKp8QvSRKRJcbbYQXF7G+ifGi7N2T4swXicTa/mGOEvsUKDFmkQ07pU7pfDExqwD0teWEqyE4GH7XEYwsO0YR2rhrG5BN3w4PKQR9OqhwDYJEGY5MAGdDHZjZMDpSCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773931639; c=relaxed/simple;
	bh=EicLv+Pp2VYPHfrLT5jJbVaFs0nelxml4j5+LlQ6DOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bVEg8/XRGaVKVqGKMe7gGy2MyFyXGX9NRIPmBZXtG6sI4s561bSrRGKWKs0xR/l5uQ6b9pjgfhGtIjm8vJ4XsV9aKEJR95JL8odiLDC6yt36U3a52dmsIv4JtnBFTJxGQ0IUEy6wbe8S4G2oJ2TLfzgEQy/1JBley4e58lnkL+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JBLyQ84Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JBLyQ84Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC0FAC19424;
	Thu, 19 Mar 2026 14:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773931638;
	bh=EicLv+Pp2VYPHfrLT5jJbVaFs0nelxml4j5+LlQ6DOs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JBLyQ84ZNZ2zURLv4YQlg87S6ASd2taCZrsWvtxvgxLR2ZNShIS020jbPJdywWktN
	 S2sir5HUtz85SNypHesWkffqX7qqXBqDkhtMkoIHMQPzk/SDH3U2BMkmoWe7MG50YJ
	 IWVW5ItH2N+9YdkYJmFJaK9dTLb9NswVvUzzZ5TuSIGdTIopfKcU/Z3roSLVcAuCSD
	 HcLk154JdE1ni9T1oC/429iAKzMxooKFYM1fFJ4D/6+mmkz9KVSsmsTykb9nwN1WNA
	 2AYUJPT/qkSO5tCp8m6rW8UfEw1iFOQLUoUa2mZn4dEbyeuiKos7gGqCp1HYNMZmw9
	 Qv4b46VZNE6cA==
Date: Thu, 19 Mar 2026 14:47:13 +0000
From: Will Deacon <will@kernel.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: robin.murphy@arm.com, jgg@nvidia.com, kevin.tian@intel.com,
	joro@8bytes.org, linux-tegra@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, eric.auger@redhat.com,
	skolothumtho@nvidia.com
Subject: Re: [PATCH 2/2] iommu/tegra241-cmdqv: Update uAPI to clarify HYP_OWN
 requirement
Message-ID: <abwMcZZHtEuaMEdZ@willie-the-truck>
References: <cover.1773361875.git.nicolinc@nvidia.com>
 <9ef47d0db2d7b8207fef1ef4437de6efa08565b6.1773361875.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ef47d0db2d7b8207fef1ef4437de6efa08565b6.1773361875.git.nicolinc@nvidia.com>

On Thu, Mar 12, 2026 at 05:36:35PM -0700, Nicolin Chen wrote:
> From hardware implementation perspective, a guest tegra241-cmdqv hardware
> is different than the host hardware:
>  - Host HW is backed by a VINTF (HYP_OWN=1)
>  - Guest HW is backed by a VINTF (HYP_OWN=0)
> 
> The kernel driver has an implementation requirement of the HYP_OWN bit in
> the VM. So, VMM must follow that to allow the same copy of Linux to work.
> 
> Add this requirement to the uAPI, which is currently missing.
> 
> Fixes: 4dc0d12474f9 ("iommu/tegra241-cmdqv: Add user-space use support")
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  include/uapi/linux/iommufd.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
> index 1dafbc552d37d..f63edbe71d542 100644
> --- a/include/uapi/linux/iommufd.h
> +++ b/include/uapi/linux/iommufd.h
> @@ -1052,6 +1052,11 @@ struct iommu_fault_alloc {
>  enum iommu_viommu_type {
>  	IOMMU_VIOMMU_TYPE_DEFAULT = 0,
>  	IOMMU_VIOMMU_TYPE_ARM_SMMUV3 = 1,
> +	/*
> +	 * TEGRA241_CMDQV requirements (otherwise, VCMDQs will not work)
> +	 * - Kernel will allocate a VINTF (HYP_OWN=0) to back this VIOMMU. So,
> +	 *   VMM must wire the HYP_OWN bit to 0 in guest VINTF_CONFIG register
> +	 */
>  	IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV = 2,
>  };

Jason, are you happy with this one?

Will
