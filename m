Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6618F6F
	for <iommu@lists.linux.dev>; Wed, 18 Oct 2023 06:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by verein.lst.de (Postfix, from userid 2407)
	id DB69768BEB; Wed, 18 Oct 2023 08:24:39 +0200 (CEST)
Date: Wed, 18 Oct 2023 08:24:39 +0200
From: Christoph Hellwig <hch@lst.de>
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, luto@kernel.org,
	peterz@infradead.org, kirill.shutemov@linux.intel.com,
	elena.reshetova@intel.com, isaku.yamahata@intel.com,
	seanjc@google.com, Michael Kelley <mikelley@microsoft.com>,
	thomas.lendacky@amd.com, decui@microsoft.com,
	sathyanarayanan.kuppuswamy@linux.intel.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev
Subject: Re: [PATCH 06/10] dma: Use free_decrypted_pages()
Message-ID: <20231018062439.GA18260@lst.de>
References: <20231017202505.340906-1-rick.p.edgecombe@intel.com> <20231017202505.340906-7-rick.p.edgecombe@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017202505.340906-7-rick.p.edgecombe@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Oct 17, 2023 at 01:25:01PM -0700, Rick Edgecombe wrote:
>  struct cma;
>  
> @@ -165,7 +166,7 @@ static inline struct page *dma_alloc_contiguous(struct device *dev, size_t size,
>  static inline void dma_free_contiguous(struct device *dev, struct page *page,
>  		size_t size)
>  {
> -	__free_pages(page, get_order(size));
> +	free_decrypted_pages((unsigned long)page_address(page), get_order(size));

CMA can be highmem, so this won't work totally independent of what
free_decrypted_pages actually does.  Also please avoid the overly long line.
