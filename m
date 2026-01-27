Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEF32701D9;
	Tue, 27 Jan 2026 13:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769521072; cv=none; b=LYvsVA8M9RwAcucKFclfuhci0oFh2ePPJgGVArrJuhxiX9kDufnzqNyBIpOHD5wqCvnzXlgwlFqZkqtCqWqBboObmRhr9jW6QF6rRptPmmrkHPiW3k3VdnlolbLeW4V9khtLGfZc1yFyZWy5pxl3Ndj8CfBm68tgNmsuLYZxoH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769521072; c=relaxed/simple;
	bh=CxMYKCSKw2QE4poORmA1SK+NSJK5nohfykCt6J2f6vE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xrxioke+3C4Y3J1UyKq9lw8k55PXx0V58qlVMzi0Cj8dpInVImHiHE2SYjqUuD6XbA9cp41jKpKfT81zZY4BvsZIrgnGixXYA7OISoGVTA34VlLEFNsp2L5ESRqkeCjxCAgp263lSB2TR/CPLRVyWtRLXKC6ViP8h/Ha+etUSuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ArLQaZsC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ArLQaZsC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D929BC116C6;
	Tue, 27 Jan 2026 13:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769521072;
	bh=CxMYKCSKw2QE4poORmA1SK+NSJK5nohfykCt6J2f6vE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ArLQaZsCjh7QGKVXWREIP5FBsspCF0Y1Kd/rsbF4FUqeIJT7Qb+5+VhW4rrZsSOQU
	 829gFp8JfY11+DBpQ+bhdyWjyG0eo08Ee7FcjrSIUZI8YYZtrr6rRnqTyHF0pNMHsA
	 oSP1aICBL1SFdChwY2r5uf1xE3MmmILT9IJJHcMydIpfEZn1LT+fUNtGUNQhaApLoI
	 wOhKBhClRmGlyennBmq7MVkZCVFo84K58v2RsHFxnyI5KL+8QLteyQQGpX5mvnHNHA
	 0+OOJNFaJo7kRYeTYz2OEe9m8wLRwZVHl9xFhyn6vKrdYnhNflMufRWgCCpmrI5UsS
	 ib1xPR7D27czQ==
Date: Tue, 27 Jan 2026 13:37:46 +0000
From: Will Deacon <will@kernel.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jean-philippe@linaro.org, robin.murphy@arm.com, joro@8bytes.org,
	jgg@nvidia.com, balbirs@nvidia.com, miko.lenczewski@arm.com,
	peterz@infradead.org, kevin.tian@intel.com, praan@google.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 0/8] iommu/arm-smmu-v3: Introduce an RCU-protected
 invalidation array
Message-ID: <aXi_qqx8oNn44UbS@willie-the-truck>
References: <cover.1769476588.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1769476588.git.nicolinc@nvidia.com>

On Mon, Jan 26, 2026 at 07:09:11PM -0800, Nicolin Chen wrote:
> Changelog
> v10:
>  * Rebase on arm/smmu/updates
>  * Add Reviewed-by from Pranjal
>  * Fix typo in kdoc and update comments
>  * Add dma_wmb() in arm_smmu_write_entry()
>  * Drop free_fn from arm_smmu_invs_unref()
>  * Replace refcount_t users with WRITE_ONCE/READ_ONCE()
>  * Verify num_trashes in arm_smmu_v3_invs_test_verify()

I think it probably just slipped through the cracks, but Pranjal had a
concern in v9 about the rwlock not being irqsafe:

https://lore.kernel.org/r/aXND9YJTwm6om689@google.com

Did that get discussed someplace that I missed?

Will
