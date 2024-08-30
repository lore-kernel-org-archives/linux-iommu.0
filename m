Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740331DA26;
	Fri, 30 Aug 2024 13:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725024016; cv=none; b=ZzgRyZ3Bq0KU1viL2wzcxpWe5oXHFKVzaJMNXmx3+sfjy+n2xgJYDpn0oTzUp3801iPg9l1bHn55bwRIdZuF44Sqw3XbIVeHfOEovgszUiTJiGosMJC3Gzhb4dqFPqDq31vVwh2UCthScKcgtFvQCoO/j4IeD+RV2A5o81K3mhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725024016; c=relaxed/simple;
	bh=94Welc0bGrekE34PhslUKoQ0m9+lfFsFIl7PO49TEhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E5hEJFvHAr4zLCn9uXyxNh/zjie9/XDqT9XEhZc0vJZs79+8ISiFbET43ZTVMWtbvAKdGoPo/xJr4zBIDi17iE4IuK6+yDk5ALsUpNP4MUbLMAuOj0KaLB6hBNjd7gBg4bk0OrSlIT0UjsCzHwJtgV1hmRrFzamJwNwSbSw/iMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qLAEfU4b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qLAEfU4b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0728AC4CEC5;
	Fri, 30 Aug 2024 13:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725024016;
	bh=94Welc0bGrekE34PhslUKoQ0m9+lfFsFIl7PO49TEhk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qLAEfU4b1/TtXoNEjWy8QSUhNrzegmDQaXsBsjbx4MU6FwUwUdxQvlEr5NsvmVSBf
	 4Xpx0xsFr06IzDPJ1fHSXDq99qxuYLh6dFSitkupG9xyQiFORsm83k4iC7QFSxR1tN
	 6Yw5tItwrxvTBFl2cOVEbir8Mek5tZbZ6CM/Y2heGSMGjt2dUXPtYZefL5g+cGeAup
	 PB/h7rDhhDq/EIG+YvRaU/A7XZwmFmLwnW6sx8wSR/uM+pM39CZG9JjxIW4R7II9lr
	 KttAbtkHle5a0j2+FrIAX8FZBZDIOGmgJXuAjwK6WhrDgYnMtHfmQbV4eSpOylDjLh
	 c6psNc7lsa6cw==
Date: Fri, 30 Aug 2024 14:20:10 +0100
From: Will Deacon <will@kernel.org>
To: Rob Clark <robdclark@gmail.com>
Cc: iommu@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
	Rob Clark <robdclark@chromium.org>, Joerg Roedel <joro@8bytes.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Joao Martins <joao.m.martins@oracle.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Steven Price <steven.price@arm.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	"moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 3/4] iommu/io-pgtable-arm: Add way to debug pgtable
 walk
Message-ID: <20240830132009.GB8615@willie-the-truck>
References: <20240827181717.187245-1-robdclark@gmail.com>
 <20240827181717.187245-4-robdclark@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827181717.187245-4-robdclark@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Aug 27, 2024 at 11:17:11AM -0700, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> Add an io-pgtable method to walk the pgtable returning the raw PTEs that
> would be traversed for a given iova access.
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  drivers/iommu/io-pgtable-arm.c | 25 +++++++++++++++++++++++++
>  include/linux/io-pgtable.h     | 15 +++++++++++++++
>  2 files changed, 40 insertions(+)
> 
> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> index efed8e519111..11af49119f37 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
> @@ -759,6 +759,30 @@ static phys_addr_t arm_lpae_iova_to_phys(struct io_pgtable_ops *ops,
>  	return iopte_to_paddr(d.pte, data) | iova;
>  }
>  
> +static int visit_pgtable_walk(struct io_pgtable_walk_data *walk_data, int lvl,
> +			      arm_lpae_iopte *ptep, size_t size)
> +{
> +	struct arm_lpae_io_pgtable_walk_data *data = walk_data->data;
> +	data->ptes[data->level++] = *ptep;
> +	return 0;
> +}

I'm struggling to see how this works given that the ->visit() callback
is only called for leaf entries in the page-table. What am I missing?

Will
