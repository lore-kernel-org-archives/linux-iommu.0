Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245D4612D
	for <iommu@lists.linux.dev>; Wed,  9 Aug 2023 13:50:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EE6FC433CC;
	Wed,  9 Aug 2023 13:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691589018;
	bh=1hImN3R8rh56hDlOvVWKDW7DBgbqk7msuvf7SxIvhuQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iA1bDz5GA5+hV8FkGZuPhc9bWpOSUxnPn8niO2qk7qAjHvRs2+5hLyruSot4FVsyi
	 YhABA1v+VkkynK/R7bivuLrnkIJE0+fNIM+4hZ1Bz2MgG105zKZjvgm+cNGDwETHDl
	 RHWE0/Okn3fnouRsfVhdjqmjrtGoIDX7xbyTKg0D3zYKIGMoNw1pB/FlGGSrQH7vD7
	 u867td9eRgkr5Iha6U3A5t7+Mk2V+AvDFOtKRvTFrrAva5WzDE5HfvwSTwBQq+K2w6
	 0f4+/OziSnBKuAMoKFLOgg9ImdQCX1Ct0psPFMnfSSVEikJ7CNpH0OeYiwiFpdg7iA
	 wrAuuxY69+JEQ==
Date: Wed, 9 Aug 2023 14:50:13 +0100
From: Will Deacon <will@kernel.org>
To: Michael Shavit <mshavit@google.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com,
	nicolinc@nvidia.com, jgg@nvidia.com, jean-philippe@linaro.org
Subject: Re: [PATCH v5 8/9] iommu/arm-smmu-v3: Skip cd sync if CD table isn't
 active
Message-ID: <20230809135011.GC4226@willie-the-truck>
References: <20230808171446.2187795-1-mshavit@google.com>
 <20230809011204.v5.8.Idedc0f496231e2faab3df057219c5e2d937bbfe4@changeid>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809011204.v5.8.Idedc0f496231e2faab3df057219c5e2d937bbfe4@changeid>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Aug 09, 2023 at 01:12:04AM +0800, Michael Shavit wrote:
> This commit explicitly keeps track of whether a CD table is installed in
> an STE so that arm_smmu_sync_cd can skip the sync when unnecessary. This
> was previously achieved through the domain->devices list, but we are
> moving to a model where arm_smmu_sync_cd directly operates on a master
> and the master's CD table instead of a domain.

Why is this path worth optimising?

> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index f5ad386cc8760..488d12dd2d4aa 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -985,6 +985,9 @@ static void arm_smmu_sync_cd(struct arm_smmu_master *master,
>  		},
>  	};
>  
> +	if (!master->cd_table.installed)
> +		return;

Doesn't this interact badly with the sync in arm_smmu_detach_dev(), which I
think happens after zapping the STE?

>  	cmds.num = 0;
>  	for (i = 0; i < master->num_streams; i++) {
>  		cmd.cfgi.sid = master->streams[i].id;
> @@ -1091,7 +1094,7 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_master *master, int ssid,
>  		cdptr[3] = cpu_to_le64(cd->mair);
>  
>  		/*
> -		 * STE is live, and the SMMU might read dwords of this CD in any
> +		 * STE may be live, and the SMMU might read dwords of this CD in any
>  		 * order. Ensure that it observes valid values before reading
>  		 * V=1.
>  		 */

Why does this patch need to update this comment?

Will
