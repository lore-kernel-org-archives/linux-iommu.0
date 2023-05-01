Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69C08C05;
	Mon,  1 May 2023 22:01:20 +0000 (UTC)
Received: from [77.22.52.211] (helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1ptba2-00037i-9M; Tue, 02 May 2023 00:01:10 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
 llvm@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Miguel Ojeda <ojeda@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Tom Rix <trix@redhat.com>,
 Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>,
 Nicolin Chen <nicolinc@nvidia.com>
Subject:
 Re: [PATCH v4 00/17] Consolidate the error handling around device attachment
Date: Tue, 02 May 2023 00:01:08 +0200
Message-ID: <5903096.CbtlEUcBR6@diego>
In-Reply-To: <0-v4-79d0c229580a+650-iommu_err_unwind_jgg@nvidia.com>
References: <0-v4-79d0c229580a+650-iommu_err_unwind_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Mittwoch, 12. April 2023, 15:51:30 CEST schrieb Jason Gunthorpe:
> Jason Gunthorpe (17):
>   iommu: Replace iommu_group_device_count() with list_count_nodes()
>   iommu: Add for_each_group_device()
>   iommu: Make __iommu_group_set_domain() handle error unwind
>   iommu: Use __iommu_group_set_domain() for __iommu_attach_group()
>   iommu: Use __iommu_group_set_domain() in iommu_change_dev_def_domain()
>   iommu: Replace __iommu_group_dma_first_attach() with set_domain
>   iommu: Remove iommu_group_do_dma_first_attach() from
>     iommu_group_add_device()
>   iommu: Replace iommu_group_do_dma_first_attach with
>     __iommu_device_set_domain
>   iommu: Fix iommu_probe_device() to attach the right domain
>   iommu: Do iommu_group_create_direct_mappings() before attach
>   iommu: Remove the assignment of group->domain during default domain
>     alloc
>   iommu: Consolidate the code to calculate the target default domain
>     type
>   iommu: Revise iommu_group_alloc_default_domain()
>   iommu: Consolidate the default_domain setup to one function
>   iommu: Allow IOMMU_RESV_DIRECT to work on ARM
>   iommu: Remove __iommu_group_for_each_dev()
>   iommu: Tidy the control flow in iommu_group_store_type()

This probably will need an update for Greg's recent
b18d0a0f92a8 ("iommu: make the pointer to struct bus_type constant")

I've fixed that locally for me for testing, and with that:

On both arm32+arm64 Rockchip boards (rk3288-pinky + px30-minievb)
the display keeps working, so

Tested-by: Heiko Stuebner <heiko@sntech.de>


