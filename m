Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6353634CF9;
	Thu, 15 May 2025 14:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747319599; cv=none; b=nDNtosqNSAcbd6+lSCnX59pb2zwHpn7x4IZoQixhYjZ+CFJG7gip72r6J3K+EkLuuKH4fYR7z5AwDkl3WyfKP782YCJFEFKnhbi79DO3zcI/9hkIYFuKtjH1XusqYQdNEob7foy9Gk9g93XhhZBYH30vmSF4Ov66SCS1g3jMe6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747319599; c=relaxed/simple;
	bh=aK3rHV9MtBbtgEpm1YycksMWHc3n6cne+RJGaA7nDSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DzM3W9rod9HP0GAI8ZM0PFu1R1owEpqreFy7NQCPD4MsFsiRBhGFSGXhvhh9PSXfoWalIZdMzu5P1UZ02aMRDBxp8sX1KzpmE9hK2qNZiqp8+oxG7Uo8eekE62Xm2tDQt9X29E9Cfzq3debUmPiWq5qyHT8/VDM0gCongtFV0g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PpDzTORU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PpDzTORU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39541C4CEE7;
	Thu, 15 May 2025 14:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747319596;
	bh=aK3rHV9MtBbtgEpm1YycksMWHc3n6cne+RJGaA7nDSk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PpDzTORUkYWu9YTyP3G2LZ7vGtA3BEZ2rlgSomrVu/Qdp7QEu06jbSvRoTUVw7ETl
	 2132dOSL1pBhWlbL4iIVF7X2tepv3AXp/CLBJmHOKzzQpfBRQudCNEwIuHpMKPbesq
	 Q6aNfPEJFou2azINgLxWxRfz7Eq4XGO4fITkgUtc5YNkl/3J1kCjQx37SlRLdiSINS
	 hPZo085VL/QYlszeM5vkLjzK9+5UxoN/rjy9R5I9BzcjaSolNnum29uHVz+Sk+Lb+Z
	 209P6QhUvdxfysoe/EQKlYmfnXt2SQwSkCtXyCazKNh3Bah6NQYrUXcH6nr3PyoCRH
	 AkDCR0a5YUUeA==
Date: Thu, 15 May 2025 15:33:10 +0100
From: Will Deacon <will@kernel.org>
To: Rob Clark <robdclark@gmail.com>
Cc: dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
	linux-arm-msm@vger.kernel.org, Connor Abbott <cwabbott0@gmail.com>,
	Rob Clark <robdclark@chromium.org>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, Nicolin Chen <nicolinc@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Joao Martins <joao.m.martins@oracle.com>,
	"moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>,
	"open list:IOMMU SUBSYSTEM" <iommu@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 05/40] iommu/io-pgtable-arm: Add quirk to quiet
 WARN_ON()
Message-ID: <20250515143309.GA12165@willie-the-truck>
References: <20250514175527.42488-1-robdclark@gmail.com>
 <20250514175527.42488-6-robdclark@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250514175527.42488-6-robdclark@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, May 14, 2025 at 10:53:19AM -0700, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> In situations where mapping/unmapping sequence can be controlled by
> userspace, attempting to map over a region that has not yet been
> unmapped is an error.  But not something that should spam dmesg.
> 
> Now that there is a quirk, we can also drop the selftest_running
> flag, and use the quirk instead for selftests.
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> Acked-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  drivers/iommu/io-pgtable-arm.c | 27 ++++++++++++++-------------
>  include/linux/io-pgtable.h     |  8 ++++++++
>  2 files changed, 22 insertions(+), 13 deletions(-)

[...]

> diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
> index bba2a51c87d2..639b8f4fb87d 100644
> --- a/include/linux/io-pgtable.h
> +++ b/include/linux/io-pgtable.h
> @@ -88,6 +88,13 @@ struct io_pgtable_cfg {
>  	 *
>  	 * IO_PGTABLE_QUIRK_ARM_HD: Enables dirty tracking in stage 1 pagetable.
>  	 * IO_PGTABLE_QUIRK_ARM_S2FWB: Use the FWB format for the MemAttrs bits
> +	 *
> +	 * IO_PGTABLE_QUIRK_NO_WARN_ON: Do not WARN_ON() on conflicting
> +	 *	mappings, but silently return -EEXISTS.  Normally an attempt
> +	 *	to map over an existing mapping would indicate some sort of
> +	 *	kernel bug, which would justify the WARN_ON().  But for GPU
> +	 *	drivers, this could be under control of userspace.  Which
> +	 *	deserves an error return, but not to spam dmesg.
>  	 */
>  	#define IO_PGTABLE_QUIRK_ARM_NS			BIT(0)
>  	#define IO_PGTABLE_QUIRK_NO_PERMS		BIT(1)
> @@ -97,6 +104,7 @@ struct io_pgtable_cfg {
>  	#define IO_PGTABLE_QUIRK_ARM_OUTER_WBWA		BIT(6)
>  	#define IO_PGTABLE_QUIRK_ARM_HD			BIT(7)
>  	#define IO_PGTABLE_QUIRK_ARM_S2FWB		BIT(8)
> +	#define IO_PGTABLE_QUIRK_NO_WARN_ON		BIT(9)

This feels a bit fragile to me:
  * IOMMU-API users of io-pgtable shouldn't be passing this quirk
    but might end up doing so to paper over driver bugs.

  * Low-level users of io-pgtable who expose page-table operations to
    userspace need to pass the quirk, but might well not bother because
    well-behaved userspace doesn't trigger the warning.

So overall, it's all a bit unsatisfactory. Is there a way we could have
the warnings only when invoked via the IOMMU API?

Will
