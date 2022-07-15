Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530997A
	for <iommu@lists.linux.dev>; Fri, 15 Jul 2022 08:49:25 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
	id 5E13F535; Fri, 15 Jul 2022 10:49:23 +0200 (CEST)
Date: Fri, 15 Jul 2022 10:49:21 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, suravee.suthikulpanit@amd.com,
	robin.murphy@arm.com
Subject: Re: [PATCH v2 0/6] iommu/amd: Add Generic IO Page Table Framework
 Support for v2 Page Table
Message-ID: <YtEqEYMugGjoIo9e@8bytes.org>
References: <20220713053034.12061-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220713053034.12061-1-vasant.hegde@amd.com>

Hi Vassant,

On Wed, Jul 13, 2022 at 11:00:28AM +0530, Vasant Hegde wrote:
> Suravee Suthikulpanit (4):
>   iommu/amd: Refactor amd_iommu_domain_enable_v2 to remove locking
>   iommu/amd: Update sanity check when enable PRI/ATS for IOMMU v1 table
>   iommu/amd: Add support for Guest IO protection
>   iommu/amd: Add support for using AMD IOMMU v2 page table for DMA-API
> 
> Vasant Hegde (2):
>   iommu/amd: Initial support for AMD IOMMU v2 page table
>   iommu/amd: Add command-line option to enable different page table

Thanks for the submission, but I have to defer it until the next cycle.
With the PCI multi-domain support and the SNP-enablement there are
already some intrusive patches queued up for the AMD driver, and I want
to let the dust settle around those first.

Please remind me after the next merge window about this series.

Thanks,

	Joerg
