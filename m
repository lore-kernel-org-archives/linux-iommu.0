Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2F5335542;
	Thu, 13 Nov 2025 11:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763031607; cv=none; b=Vpl+bZhEgIj1Rjvr3UkS24EVWAat5BeZQKh4uDirR+0QupTlGXYb5xjwYKHZnlaonLBBgua8aluAgrmqKGQHLIPuCaBxc7OFCTis2n+ND/+5WEFm3xME+kZmpdjVDeMy1kR0YxvJ9HQsx0FnlVbwWaYpdlJ+0pzBjUWLFTzcAo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763031607; c=relaxed/simple;
	bh=+oFomDfNiypPBJ4AIDYzOAA6/B/jV4Ws0uR6/ZMqwj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oUkbYdt2C9FQ7eBFaV/b0AboXZ8sYLbl++NgNUF3CV3N9t/Q1rtotpdb/traPEJbQ4g3V87gexHwzbv9AWuM5ob8f8xuUAKssAVgB389dBFV4K/0Ff3MLSL4eGp5egFWDKSjKPUjew8yXK33mhTkI+sFAZggZIDPzpkDULhS2Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uEENvqv9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uEENvqv9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76F2AC4CEF5;
	Thu, 13 Nov 2025 11:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763031605;
	bh=+oFomDfNiypPBJ4AIDYzOAA6/B/jV4Ws0uR6/ZMqwj4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uEENvqv9HfAuHD1WXdsKCusGJtCe0M2Ji3b8nXPR13TYeZZA4mxGUOfOSfBqQhceY
	 47poSSR5CIsAcvbTJ6uQzDMDicEQvnD2oKnzxZ/CjpPrYr3MHV13B03P8qRBfdrFKz
	 tzqJzmOFh/BZIGLPHJMWlUATAyXI42mRv+4ufNiduC5OPYRa9ypmwXNV+/euspTNBq
	 G020TvDeAO6iJZMOAnDUJIJJjI8SWxbbg5ELBCIktBkC92xoOoyGufr/s98AnW7CXP
	 pnlFOMV1dXEPugSThOmfoXJdgssakONNpFSJ0q8IgRkBYpkBJMXd0VAjuxnQZbpX1I
	 wW2CKqZzeekIQ==
Date: Thu, 13 Nov 2025 10:59:57 +0000
From: Will Deacon <will@kernel.org>
To: Mostafa Saleh <smostafa@google.com>
Cc: linux-mm@kvack.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, corbet@lwn.net, joro@8bytes.org,
	robin.murphy@arm.com, akpm@linux-foundation.org, vbabka@suse.cz,
	surenb@google.com, mhocko@suse.com, jackmanb@google.com,
	hannes@cmpxchg.org, ziy@nvidia.com, david@redhat.com,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
	rppt@kernel.org, Qinxin Xia <xiaqinxin@huawei.com>
Subject: Re: [PATCH v2 4/4] drivers/iommu-debug-pagealloc: Check
 mapped/unmapped kernel memory
Message-ID: <aRW6LWh_1lTce7kU@willie-the-truck>
References: <20251106163953.1971067-1-smostafa@google.com>
 <20251106163953.1971067-5-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251106163953.1971067-5-smostafa@google.com>

On Thu, Nov 06, 2025 at 04:39:53PM +0000, Mostafa Saleh wrote:
> Now, as the page_ext holds count of IOMMU mappings, we can use it to
> assert that any page allocated/freed is indeed not in the IOMMU.
> 
> The sanitizer doesn’t protect against mapping/unmapping during this
> period. However, that’s less harmful as the page is not used by the
> kernel.
> 
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> Tested-by: Qinxin Xia <xiaqinxin@huawei.com>
> ---
>  drivers/iommu/iommu-debug-pagealloc.c | 19 +++++++++++++++++++
>  include/linux/iommu-debug-pagealloc.h | 12 ++++++++++++
>  include/linux/mm.h                    |  5 +++++
>  3 files changed, 36 insertions(+)
> 
> diff --git a/drivers/iommu/iommu-debug-pagealloc.c b/drivers/iommu/iommu-debug-pagealloc.c
> index 0e14104b971c..5b26c84d3a0e 100644
> --- a/drivers/iommu/iommu-debug-pagealloc.c
> +++ b/drivers/iommu/iommu-debug-pagealloc.c
> @@ -71,6 +71,25 @@ static size_t iommu_debug_page_size(struct iommu_domain *domain)
>  	return 1UL << __ffs(domain->pgsize_bitmap);
>  }
>  
> +static unsigned int iommu_debug_page_count(unsigned long phys)

'phys_addr_t phys' ?

But having said that, wouldn't you be better off taking the
'struct page *' here rather than converting it to a physical address
only for get_iommu_page_ext() to convert it straight back again?

> +{
> +	unsigned int ref;
> +	struct page_ext *page_ext = get_iommu_page_ext(phys);
> +	struct iommu_debug_metadate *d = get_iommu_data(page_ext);
> +
> +	ref = atomic_read(&d->ref);
> +	page_ext_put(page_ext);
> +	return ref;
> +}
> +
> +void __iommu_debug_check_unmapped(const struct page *page, int numpages)
> +{
> +	while (numpages--) {
> +		WARN_ON(iommu_debug_page_count(page_to_phys(page)));

Since you only care about the count being non-zero, perhaps tweak
iommu_debug_page_count() to be something like:

	bool iommu_debug_page_referenced(struct page *);

Will
