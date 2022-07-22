Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F7933C4
	for <iommu@lists.linux.dev>; Fri, 22 Jul 2022 14:37:17 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
	id 2FF685D1; Fri, 22 Jul 2022 16:37:15 +0200 (CEST)
Date: Fri, 22 Jul 2022 16:37:13 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Jerry Snitselaar <jsnitsel@redhat.com>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/amd: Disable guest vapic logging during early
 kdump init
Message-ID: <Ytq2GRX7UJjvXk4w@8bytes.org>
References: <20220721003439.403435-1-jsnitsel@redhat.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721003439.403435-1-jsnitsel@redhat.com>

On Wed, Jul 20, 2022 at 05:34:39PM -0700, Jerry Snitselaar wrote:
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index 1d08f87e734b..2b00d7f28df7 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -815,6 +815,11 @@ static void free_ga_log(struct amd_iommu *iommu)
>  #endif
>  }
>  
> +static void iommu_ga_log_disable(struct amd_iommu *iommu)
> +{
> +	iommu_feature_disable(iommu, CONTROL_GALOG_EN);
> +}
> +
>  static int iommu_ga_log_enable(struct amd_iommu *iommu)
>  {
>  #ifdef CONFIG_IRQ_REMAP
> @@ -2504,6 +2509,7 @@ static void early_enable_iommus(void)
>  		for_each_iommu(iommu) {
>  			iommu_disable_command_buffer(iommu);
>  			iommu_disable_event_buffer(iommu);
> +			iommu_ga_log_disable(iommu);
>  			iommu_enable_command_buffer(iommu);
>  			iommu_enable_event_buffer(iommu);
>  			iommu_enable_ga(iommu);

Looks about right, but I also let Suravee comment on this.

Disabling the GA-Log under a device still using it should hopefully not
put it into some undefined state.
