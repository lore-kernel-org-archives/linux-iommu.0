Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F95749B
	for <iommu@lists.linux.dev>; Wed, 30 Aug 2023 21:50:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C09E1C433C7;
	Wed, 30 Aug 2023 21:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693432204;
	bh=OGc+LfkYBQySHlSntBlsKXI/UcufIS548SjZfr7mroQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rd8Q6DhBwUgRClZMRUKSEtwN+6EDSNQNpVA6FiKuJBnQqyJpF6gZFIb8quGIcb98H
	 iTP73712DKtlzoti6gemSAePS8lw2/HXExBVPWLM1vOAeykoKCr8kSskeK9uWCI9AJ
	 GhjTiXJPvmx6hCAHk4SWdAX2tVVD3JBBozMWBQ9PKq+q2F6EKbDDywiKytQgMO9DNa
	 KDeei3iDgN4iSl3oRaHB4PzRi6Xb9UpO39ErUtl9DETNSQ/GSpU14Ojk9PSOtN3AkY
	 O8H3Bi2n4ymg08fd3dTTh6qdcoQzm2kvv2e8aH4O12IlVIiL7ssD10FLC5rdfa2PWd
	 yysHdw5ehQ8Sg==
Date: Wed, 30 Aug 2023 22:49:59 +0100
From: Will Deacon <will@kernel.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Robin Murphy <robin.murphy@arm.com>, jgg@nvidia.com, joro@8bytes.org,
	jean-philippe@linaro.org, apopple@nvidia.com,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev
Subject: Re: [PATCH 1/3] iommu/io-pgtable-arm: Add nents_per_pgtable in
 struct io_pgtable_cfg
Message-ID: <20230830214958.GA30121@willie-the-truck>
References: <cover.1692693557.git.nicolinc@nvidia.com>
 <0fe68babdb3a07adf024ed471fead4e3eb7e703f.1692693557.git.nicolinc@nvidia.com>
 <f468b461-b203-5179-eb6d-9432b9911329@arm.com>
 <ZOTlcFs2NG6nJEPN@Asurada-Nvidia>
 <61f9b371-7c45-26b1-ec0f-600765280c89@arm.com>
 <ZO5R5i4n2WI2GnKQ@Asurada-Nvidia>
 <d234fa8d-d945-3f7f-1110-fe55bea88587@arm.com>
 <ZO5uGKzGsaliQ1fF@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZO5uGKzGsaliQ1fF@Asurada-Nvidia>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Aug 29, 2023 at 03:15:52PM -0700, Nicolin Chen wrote:
> Meanwhile, by re-looking at Will's commit log:
>     arm64: tlbi: Set MAX_TLBI_OPS to PTRS_PER_PTE
> 
>     In order to reduce the possibility of soft lock-ups, we bound the
>     maximum number of TLBI operations performed by a single call to
>     flush_tlb_range() to an arbitrary constant of 1024.
> 
>     Whilst this does the job of avoiding lock-ups, we can actually be a bit
>     smarter by defining this as PTRS_PER_PTE. Due to the structure of our
>     page tables, using PTRS_PER_PTE means that an outer loop calling
>     flush_tlb_range() for entire table entries will end up performing just a
>     single TLBI operation for each entry. As an example, mremap()ing a 1GB
>     range mapped using 4k pages now requires only 512 TLBI operations when
>     moving the page tables as opposed to 262144 operations (512*512) when
>     using the current threshold of 1024.
> 
> I found that I am actually not quite getting the calculation at the
> end for the comparison between 512 and 262144.
> 
> For a 4K pgsize setup, MAX_TLBI_OPS is set to 512, calculated from
> 4096 / 8. Then, any VA range >= 2MB will trigger a flush_tlb_all().
> By setting the threshold to 1024, the 2MB size bumps up to 4MB, i.e.
> the condition becomes range >= 4MB.
> 
> So, it seems to me that requesting a 1GB invalidation will trigger
> a flush_tlb_all() in either case of having a 2MB or a 4MB threshold?
> 
> I can get that the 262144 is the number of pages in a 1GB size, so
> the number of per-page invalidations will be 262144 operations if
> there was no threshold to replace with a full-as invalidation. Yet,
> that wasn't the case since we had a 4MB threshold with an arbitrary
> 1024 for MAX_TLBI_OPS?

I think this is because you can't always batch up the entire range as
you'd like due to things like locking concerns. For example,
move_page_tables() can end up invalidating 2MiB at a time, which is
too low to trigger the old threshold and so you end up doing ever single
pte individually.

Will
