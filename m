Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FF3311591;
	Tue,  9 Sep 2025 13:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757423199; cv=none; b=Kdj1w4De/MfyEC6fhSgb5A2rDNGVJV1aJmu+bn345Z7/AMN9nAj4BlvSENPGKdhC8uZHasIJkFmOgWDdROt7/x0eGfMXqBj+yh2GTaJSofte3dRbHwyKFvXl8t1zJDQbeTk3+GM+VeGqfbzCa5qSMnRz8Vro9WlN0/AJ1+FFV68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757423199; c=relaxed/simple;
	bh=qD3qU9O4hlrWhqMeW5jgxqVBElkWJH2c2E7/Z1BSu6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C8qdFHvdc9uxhyXVCji9rtyYu5NoFxQUfZzycl8SyeEtLpIeFzyRWE9Cc6y4fvAdLlbncBTDDwUtElfs3UYhVZKGdbROoEd96AUCTNcUxAgXqCkvqyZI27Fj0p8bghYi4ngW15Ens27ZwTTvEEzlDbTlVp+hrEPb8K+oDWTioIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rot2GEcQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rot2GEcQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB552C4CEF5;
	Tue,  9 Sep 2025 13:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757423199;
	bh=qD3qU9O4hlrWhqMeW5jgxqVBElkWJH2c2E7/Z1BSu6M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rot2GEcQCJuw19L4oJjHHEmn/gp9gGTbjsbZB15G3pfXwHp2rhi+7dwYum6IPmC88
	 H4+LtAugy5wda6Ay31wKIZFcNznjpD+4lAIlsH7f2MgUBBjmiDvn0DzpydQmoxxqHj
	 9cgknz8DROKFqNQeUjCok2xacqJRa/ip9fuHHipB/rthodIAgM7JruLmjUrgv7bbzC
	 oRvZ9yraynZUF/e5ihhvklsZT2gw7sHZ8QV9TKkJVq8xNOZwH3HfuHtp0G4doHG/tZ
	 akpgbgcMPbQ71HQZUCD0LWST4W747Js1bAV9ZF89mIzPmDsn+OwANl9PQK218ef64j
	 FBvO0AKp0XcgQ==
Date: Tue, 9 Sep 2025 14:06:33 +0100
From: Will Deacon <will@kernel.org>
To: Qinxin Xia <xiaqinxin@huawei.com>
Cc: robin.murphy@arm.com, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	yangyicong@huawei.com, wangzhou1@hisilicon.com,
	prime.zeng@hisilicon.com, xuwei5@huawei.com, fanghao11@huawei.com,
	jonathan.cameron@huawei.com, linuxarm@huawei.com
Subject: Re: [PATCH 1/2] iommu/debug: Add IOMMU page table dump debug facility
Message-ID: <aMAmWQJy_G50xoBf@willie-the-truck>
References: <20250814093005.2040511-1-xiaqinxin@huawei.com>
 <20250814093005.2040511-2-xiaqinxin@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814093005.2040511-2-xiaqinxin@huawei.com>

On Thu, Aug 14, 2025 at 05:30:04PM +0800, Qinxin Xia wrote:
> +/**
> + * iova_info_dump - dump iova alloced
> + * @s - file structure used to generate serialized output
> + * @iovad: - iova domain in question.
> + */
> +static int iommu_iova_info_dump(struct seq_file *s, struct iommu_domain *domain)
> +{
> +	struct iova_domain *iovad;
> +	unsigned long long pfn;
> +	unsigned long i_shift;
> +	struct rb_node *node;
> +	unsigned long flags;
> +	size_t prot_size;
> +
> +	iovad = iommu_domain_to_iovad(domain);
> +	if (!iovad)
> +		return -ENOMEM;
> +
> +	i_shift = iova_shift(iovad);
> +
> +	/* Take the lock so that no other thread is manipulating the rbtree */
> +	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
> +	assert_spin_locked(&iovad->iova_rbtree_lock);
> +
> +	for (node = rb_first(&iovad->rbroot); node; node = rb_next(node)) {
> +		struct iova *iova = rb_entry(node, struct iova, node);
> +
> +		if (iova->pfn_hi <= iova->pfn_lo)
> +			continue;
> +
> +		for (pfn = iova->pfn_lo; pfn <= iova->pfn_hi; ) {
> +			prot_size = domain->ops->dump_iova_prot(s, domain, pfn << i_shift);
> +			pfn = ((pfn << i_shift) + prot_size) >> i_shift;
> +		}
> +	}
> +
> +	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);

Why is the IOVA rbtree lock sufficient for serialising the page-table
accesses made by ->dump_iova_prot()? I don't see anything here that
prevents the walker walking into page-table pages that are e.g. being
freed or manipulated concurrently.

Will
