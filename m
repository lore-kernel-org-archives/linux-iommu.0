Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0858F1D516C;
	Thu,  6 Nov 2025 19:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762458619; cv=none; b=lyvuiuaJ7+A0OCU7lnEwoaH+1Ggu0iqu4Jor+UfE59pTnsbI6I38KMlPedWSw812j9sI89P8qioWCuI2EawpwJX07p/HacwZ1bZhR1qOWeqP4pDd1iBV7wWSNmqV9t/E+ys8Je2AhBwWle8L0g1BDmYEH7R8Pwetyz2+eTG0qHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762458619; c=relaxed/simple;
	bh=e6MGKfjRHLnKxUpXaJe/vSW7BmU3T7nlGRAaC6kqrsk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a6jy9bH4olPlq/W6f6Lu+OC/L4bb2qf+oNXHbrmHI4ztUuIeL0+cdoYYhF++IPsKvRZ4xPgapQhC0MZB1eIvGfszQZGdOYKNpfYkliWel/cfYE0UDwP+MoKUR1bpRtTJv9i2wLzodcvPgrhlBKiojZAPGn8NcaszA56S3jw5Ibs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=0S5PF1s7; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0S5PF1s7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=TZQw23ttLoTVA2bBH5a8WLwflYyR1wSU2x8Igu6ImY8=; b=0S5PF1s7Z3+3+S6pQIKmCqY0jP
	drS+pA0q9aVjtmISaobTvzTl1jkOZSfzgOc92RcJr0DRdkWda9yrlj0uSCAAF0rOy8SFZ6Wk+v498
	GrwMCgA0Gf+XAwNNlx54m4zqyFG/N7iMaEW/G6riJ7FFy3GWOwUV9g7sQybKR0y9Kt5gUcIhw2gpK
	ezbUCFqCKnkr7z4pC/vUOfLdfx7HR+Dj3EP21Gmv54rSN/gEygFVeTQjMtzVLJ+COODhPItpH40Ac
	aLZabhu3/6JZ+AyPJlobFEVROiucfiI7QysjlT2LBC6b1c6f3mb7jfWjLZ5wUhhxLYtaPCUITJpJM
	p/UkTvCw==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vH5zn-0000000GBF5-3TGi;
	Thu, 06 Nov 2025 19:50:11 +0000
Message-ID: <55391dad-339b-47f8-8996-afe337b238e0@infradead.org>
Date: Thu, 6 Nov 2025 11:50:11 -0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] drivers/iommu: Add page_ext for
 IOMMU_DEBUG_PAGEALLOC
To: Mostafa Saleh <smostafa@google.com>, linux-mm@kvack.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Cc: corbet@lwn.net, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
 akpm@linux-foundation.org, vbabka@suse.cz, surenb@google.com,
 mhocko@suse.com, jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com,
 david@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 rppt@kernel.org, Qinxin Xia <xiaqinxin@huawei.com>
References: <20251106163953.1971067-1-smostafa@google.com>
 <20251106163953.1971067-2-smostafa@google.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20251106163953.1971067-2-smostafa@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index 70d29b14d851..6b5e9a2d936a 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -383,4 +383,19 @@ config SPRD_IOMMU
>  
>  	  Say Y here if you want to use the multimedia devices listed above.
>  
> +config IOMMU_DEBUG_PAGEALLOC
> +	bool "Debug page memory allocations against IOMMU"
> +	depends on DEBUG_PAGEALLOC && IOMMU_API && PAGE_EXTENSION
> +	help
> +	  This config checks that a page is freed(unmapped) or mapped by the
> +	  kernel is not mapped in any IOMMU domain. It can help with debugging
> +	  use-after-free or out-of-bound maps from drivers doing DMA through
> +	  the IOMMU API.
> +	  This santaizer can have false-negative cases where some problems

	       sanitizer

> +	  won't be detected.
> +	  Expect overhead when enabling this and enabling the kernel command
> +	  line iommu.debug_pagealloc.
> +
> +	  If unsure, say N here.
> +
>  endif # IOMMU_SUPPORT


-- 
~Randy

