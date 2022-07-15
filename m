Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394C67A
	for <iommu@lists.linux.dev>; Fri, 15 Jul 2022 08:46:08 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
	id 6F10A535; Fri, 15 Jul 2022 10:46:06 +0200 (CEST)
Date: Fri, 15 Jul 2022 10:46:05 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	robin.murphy@arm.com, vasant.hegde@amd.com, ashish.kalra@amd.com,
	jon.grimm@amd.com
Subject: Re: [PATCH v4 8/9] iommu/amd: Do not support IOMMU_DOMAIN_IDENTITY
 after SNP is enabled
Message-ID: <YtEpTTDGR+5zoEQ1@8bytes.org>
References: <20220713225651.20758-1-suravee.suthikulpanit@amd.com>
 <20220713225651.20758-9-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220713225651.20758-9-suravee.suthikulpanit@amd.com>

On Wed, Jul 13, 2022 at 05:56:50PM -0500, Suravee Suthikulpanit wrote:
> +	/*
> +	 * Since DTE[Mode]=0 is prohibited on SNP-enabled system,
> +	 * default to use IOMMU_DOMAIN_DMA[_FQ].
> +	 */
> +	if (WARN_ONCE(amd_iommu_snp_en && (type == IOMMU_DOMAIN_IDENTITY),
> +		      "Cannot allocate identity domain due to SNP\n"))

I removed that WARN_ON_ONCE() here, this is really no condition someone
should worry about.

Regards,

	Joerg


