Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BDB7A
	for <iommu@lists.linux.dev>; Fri, 15 Jul 2022 08:44:53 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
	id C69C7535; Fri, 15 Jul 2022 10:44:51 +0200 (CEST)
Date: Fri, 15 Jul 2022 10:44:50 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	robin.murphy@arm.com, vasant.hegde@amd.com, ashish.kalra@amd.com,
	jon.grimm@amd.com
Subject: Re: [PATCH v4 0/9] iommu/amd: Enforce IOMMU restrictions for
 SNP-enabled system
Message-ID: <YtEpAgSGz+Linner@8bytes.org>
References: <20220713225651.20758-1-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220713225651.20758-1-suravee.suthikulpanit@amd.com>

On Wed, Jul 13, 2022 at 05:56:42PM -0500, Suravee Suthikulpanit wrote:
> Brijesh Singh (1):
>   iommu/amd: Introduce function to check and enable SNP
> 
> Suravee Suthikulpanit (8):
>   iommu/amd: Change macro for IOMMU control register bit shift to
>     decimal value
>   iommu/amd: Introduce Support for Extended Feature 2 Register
>   iommu/amd: Introduce global variable for storing common EFR and EFR2
>   iommu/amd: Process all IVHDs before enabling IOMMU features
>   iommu/amd: Globally detect SNP support
>   iommu/amd: Set translation valid bit only when IO page tables are in
>     use
>   iommu/amd: Do not support IOMMU_DOMAIN_IDENTITY after SNP is enabled
>   iommu/amd: Do not support IOMMUv2 APIs when SNP is enabled

Applied, thanks Suravee.

