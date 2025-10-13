Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030DE2E7192;
	Mon, 13 Oct 2025 07:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760340495; cv=none; b=TEZtsfYbt141+MeDL2iYti3MQ8fgpOQJCGLgXBBYLpokbAwI3Ixt+rxH53d7Jqnl2z8D/VzfDpoVeSCaLmQJzUpRuXqrmHvl2o3eulSuLEkYsnRU2tL+FQdvFDxkQrfL6CXHAq+HNYKNx51Hx8HDdBS90jdYBer++dFwfPg0R/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760340495; c=relaxed/simple;
	bh=LXq06zOJDZCJjFxJSMriSR2r1NN0TNY9ryW7UFEsHNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CIofKfE8gUIrcyxlTtzoGdOYXmoC4JCtVniD/bT6KM8n0LqJDr+IweE8tmNSGGBrOe4228bxrpydTppJkjJaSGEKquszvcQfxl5v7WNk9DSSFpu/MwpwlXXf1/lI5B6FaRyX3s8yScm+d+4RomHB6BQaoRfsK9ycYXPzuD6w5vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nbL2UtGh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nbL2UtGh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC21AC4CEE7;
	Mon, 13 Oct 2025 07:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760340494;
	bh=LXq06zOJDZCJjFxJSMriSR2r1NN0TNY9ryW7UFEsHNE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nbL2UtGhHwSUcGWW+HFftTr1Zex2h56UWPi+59Dlbir/2koiJXfOyrHQboEf6dLFp
	 DYECR09j/iAerh8uOTGkq3WkobLDm3Kp1DAN5ThsizadNmN9snCCVcjNt+sh3H/SRi
	 9R8SvKkNNdcmwOqnJqo1kZ6mIvWSCEqzE6qVnN7efWns9muMgrNEAH6pGZoqjzQQ7o
	 MLIY7oXQVhj3QtNHmSuaYExcIgWzSaK27QgdY3UuvUaXb1ZcmNuW1ZAkOQYodFtOWo
	 eUyo1Rm/AoUSn7fraueBneQSX4KBMfTlQsdXCd69lPvhULXHr6e/qObo9nvsq+IS+t
	 zAL5OVBdmdBeA==
Date: Mon, 13 Oct 2025 10:28:04 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
	Jann Horn <jannh@google.com>, Vasant Hegde <vasant.hegde@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@intel.com>,
	Alistair Popple <apopple@nvidia.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Andy Lutomirski <luto@kernel.org>, Yi Lai <yi1.lai@intel.com>,
	iommu@lists.linux.dev, security@kernel.org, x86@kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 5/8] x86/mm: Use pagetable_free()
Message-ID: <aOyqBKjIut4fNr_B@kernel.org>
References: <20250919054007.472493-1-baolu.lu@linux.intel.com>
 <20250919054007.472493-6-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919054007.472493-6-baolu.lu@linux.intel.com>

On Fri, Sep 19, 2025 at 01:40:03PM +0800, Lu Baolu wrote:
> The kernel's memory management subsystem provides a dedicated interface,
> pagetable_free(), for freeing page table pages. Updates two call sites to
> use pagetable_free() instead of the lower-level __free_page() or
> free_pages(). This improves code consistency and clarity, and ensures the
> correct freeing mechanism is used.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  arch/x86/mm/init_64.c        | 2 +-
>  arch/x86/mm/pat/set_memory.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> index b9426fce5f3e..3d9a5e4ccaa4 100644
> --- a/arch/x86/mm/init_64.c
> +++ b/arch/x86/mm/init_64.c
> @@ -1031,7 +1031,7 @@ static void __meminit free_pagetable(struct page *page, int order)
>  		free_reserved_pages(page, nr_pages);
>  #endif
>  	} else {
> -		free_pages((unsigned long)page_address(page), order);
> +		pagetable_free(page_ptdesc(page));
>  	}
>  }
>  
> diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> index 8834c76f91c9..8b78a8855024 100644
> --- a/arch/x86/mm/pat/set_memory.c
> +++ b/arch/x86/mm/pat/set_memory.c
> @@ -438,7 +438,7 @@ static void cpa_collapse_large_pages(struct cpa_data *cpa)
>  
>  	list_for_each_entry_safe(ptdesc, tmp, &pgtables, pt_list) {
>  		list_del(&ptdesc->pt_list);
> -		__free_page(ptdesc_page(ptdesc));
> +		pagetable_free(ptdesc);
>  	}
>  }
>  
> -- 
> 2.43.0
> 

-- 
Sincerely yours,
Mike.
