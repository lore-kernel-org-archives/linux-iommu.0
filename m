Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80B7539F
	for <iommu@lists.linux.dev>; Wed,  7 Sep 2022 12:27:54 +0000 (UTC)
Received: from 8bytes.org (p4ff2bb62.dip0.t-ipconnect.de [79.242.187.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id AD80324000A;
	Wed,  7 Sep 2022 14:27:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1662553673;
	bh=0wl2Nk9Q0WFKXl/+RiiHcEiTn36WNoLwCfq691DbiTo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eSE7PKfrDVe8icJKeddE6TPmkE9jmff1nD4d+WlM1hY3/Cw75Y+xwk9/93uFz6W15
	 GR8e8OiIgZW8JR5IAhp0Uy5JXQphStqSTD6FmEOTqhIrf/+VFazqJYYFRBcQ2lV3cB
	 s3eT/CoqR3bpcmPloFTMEsw2SmRaOp+3V1xrdixQU4wWiP6D2lXQdjNjBq5yfr99i9
	 tOeHU659HmNsLiGg9WTIiDnu2ZRrG7kJlZ9UAV2HC4cBWSqsm9dasxoXWKThmZKn8+
	 HZNmWiU7Nj+NTlbE2wjnfEg5CFSqNj6rmEe39f0YNDrJ55E4Ow+VvKi7qVnB7+sRZ3
	 mhe21gvCnHSZQ==
Date: Wed, 7 Sep 2022 14:27:52 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: will@kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, baolu.lu@linux.intel.com,
	kevin.tian@intel.com, suravee.suthikulpanit@amd.com,
	vasant.hegde@amd.com, mjrosato@linux.ibm.com,
	schnelle@linux.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/16] iommu: retire bus_set_iommu()
Message-ID: <YxiOSNz7gPuTzgY6@8bytes.org>
References: <cover.1660572783.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1660572783.git.robin.murphy@arm.com>

On Mon, Aug 15, 2022 at 05:20:01PM +0100, Robin Murphy wrote:
> Matthew Rosato (1):
>   iommu/s390: Fail probe for non-PCI devices
> 
> Robin Murphy (15):
>   iommu/vt-d: Handle race between registration and device probe
>   iommu/amd: Handle race between registration and device probe
>   iommu: Always register bus notifiers
>   iommu: Move bus setup to IOMMU device registration
>   iommu/amd: Clean up bus_set_iommu()
>   iommu/arm-smmu: Clean up bus_set_iommu()
>   iommu/arm-smmu-v3: Clean up bus_set_iommu()
>   iommu/dart: Clean up bus_set_iommu()
>   iommu/exynos: Clean up bus_set_iommu()
>   iommu/ipmmu-vmsa: Clean up bus_set_iommu()
>   iommu/mtk: Clean up bus_set_iommu()
>   iommu/omap: Clean up bus_set_iommu()
>   iommu/tegra-smmu: Clean up bus_set_iommu()
>   iommu/virtio: Clean up bus_set_iommu()
>   iommu: Clean up bus_set_iommu()

Applied, thanks Robin.
