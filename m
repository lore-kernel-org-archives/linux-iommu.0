Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C931EEE6;
	Sun,  2 Aug 2026 09:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785662636; cv=none; b=PcY5kflsz6aga1tsqG8fqtYHKyzp3mGFv2M1nk1T32cD1FxGBkOo2owTf77YxrMGr1R9S25Z8kickRfwSqsndxvnH38hv76NI9EXgbJEAiZCQ8NcCVWD4j/K0lWiAYM5Iuduyso4MGdb5jTAJLNiqC8suQLk8YuukLzWRGTuvmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785662636; c=relaxed/simple;
	bh=PSxnvGUauozifoiIH/ceGwSr2O7otF86t5dKfvql0eY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M4FlUd9yvOtH4Ipjd4Ed/0ad5A2dNuN6r08pG/tp369z9ekHQvDkuc/gIqq36+YAOw2CUMYW0f/O2Eq9JM3WjDkWpGUx6zxqZIYxCQIb4D2ywL3obMeqNmF+CGPDua0B0i+y3a9WzuVRf9w7Wgk5uoBAhpDaY/Nl/HbPYwH7vh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kBdnCxCz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kBdnCxCz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB62D1F000E9;
	Sun,  2 Aug 2026 09:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785662634;
	bh=DiXxJ7FfxIMWhg+QWHNrDA/BR14L2eXTYivLTU47jAQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kBdnCxCzKEyzCd72YuQeTcXLzo/D5xWX8++RW5ux61t4DNRa0+qQfBrwxatVx92rp
	 J9nGEJp1+cpcNSU9Xq5hHbuo9FYyT/B6Bg975Lrg93ecwafYvOYRf0X2pDoeySHu4f
	 HDaTqpW8or0bLwDw47kL5Uyx6wpSLLaSC3uwlHe8gGIflLSIJyFKVLyX4ST7EzRCjQ
	 CwyyicjWwy/6DRS/O9DOKYNDZTPLd81BQ5ccVuRClHyLsX1PMM6Au5dJLT0X1cQIoU
	 5QoZyeC6KMi7SYk1j0kF5EZqO5nea+1FpFDztxzoSZ3OYwhqufjZGZ9RE5eqW7sFkw
	 jdLEEdDMMenFQ==
Date: Sun, 2 Aug 2026 10:23:48 +0100
From: Will Deacon <will@kernel.org>
To: Kuan-Wei Chiu <visitorckw@gmail.com>, nicolinc@nvidia.com
Cc: joro@8bytes.org, akpm@linux-foundation.org, robin.murphy@arm.com,
	cychu@google.com, hhchung@google.com, amitamishra@google.com,
	marscheng@google.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com
Subject: Re: [PATCH 1/2] iommu/arm-smmu-v3: Replace sort_nonatomic() with
 sort()
Message-ID: <am8MpGR14HAg58Gd@willie-the-truck>
References: <20260730181216.2709088-1-visitorckw@gmail.com>
 <20260730181216.2709088-2-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260730181216.2709088-2-visitorckw@gmail.com>

On Thu, Jul 30, 2026 at 06:12:15PM +0000, Kuan-Wei Chiu wrote:
> The number of master->num_streams per master device is typically very
> small in practice. Sorting this array takes a very small amount of
> time, so there is no practical risk of triggering a soft lockup that
> would necessitate calling cond_resched() during the sort.
> 
> Replace sort_nonatomic() with the standard sort(). Since this is the
> only remaining in-tree caller of sort_nonatomic(), this change paves
> the way to eventually remove the unused sort_nonatomic() API from the
> core library.
> 
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> ---
> Build-tested only.
> 
> I'm not really familiar with this driver or smmu internals.
> Based on my limited knowledge, master->num_streams should be small
> enough to safely switch from sort_nonatomic() to sort(), but I could be
> wrong. 
> 
> Please review carefully and let me know if there are any cases where
> num_streams could actually be large enough to cause issues.
> 
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index a10affb483a4..dcb6be2df95e 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -4047,9 +4047,9 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
>  	}
>  
>  	/* Put the ids into order for sorted to_merge/to_unref arrays */
> -	sort_nonatomic(master->streams, master->num_streams,
> -		       sizeof(master->streams[0]), arm_smmu_stream_id_cmp,
> -		       NULL);
> +	sort(master->streams, master->num_streams,
> +	     sizeof(master->streams[0]), arm_smmu_stream_id_cmp,
> +	     NULL);

Makes sense to me. Nicolin, did you choose the nonatomic version
specifically?

Will
