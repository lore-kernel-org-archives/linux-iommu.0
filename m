Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEBA33CEAF;
	Tue,  6 Jan 2026 18:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767725442; cv=none; b=iIuJJUMLYxQUQboxAy0XixNrlJXNbCsWTMs2LbH8DzubuQOwLzAEsp33HnbAiVedhBphJRGoUTcIswkMP8JRq5CajuCYErjRSDGfJmAMirSyIAH2b09m20F4Mxk0iWLFoHgxPQbDZg17Mfxwfyg4B2Krw5YrUC29N1n7eiRzHio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767725442; c=relaxed/simple;
	bh=I/bcoXQ6kDpOCwpshNUvwwN7/ElnY0U8t+Mw0UoO0lI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZGEyv6X/DwAgmCShnoCWmiVFHIzWKLAMNKjYKCMZ38bxiEH1o9h54KRIXr1RzoLZdDw7GB1O/H01dxrRTQtbJGKLSeNngplBYvt100zYTY2U+JKYBjDHFT+PCA/opBgb4Ev1u/lxZ0I69oHlOhTcqsCqRroFczPKC/R7tPG9p+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tq1cJ425; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tq1cJ425"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3307C116C6;
	Tue,  6 Jan 2026 18:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767725442;
	bh=I/bcoXQ6kDpOCwpshNUvwwN7/ElnY0U8t+Mw0UoO0lI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tq1cJ425gNeqChPTy3WE50LL9HdUJu7POBrgUKJL2W39VOA8vFF9xtEHWEFS06gNC
	 G0tn/jVfDVZIXidulUSDfbuE/7b/1Uvlh/jdU4uMr1A7fq773YAomQwKIrmtDWp5D+
	 SwTtTSnSYEqrfbDCerRJTcMggsHFUooFYGJBhTwOVCH8DDIysH3NunrfEJGwsStVWT
	 PLt/OueGqUbk+drqJgYTWW1SEY4mzR9Dy+LF6Lazkpn893XXR/rREFeiSZGEOcksIj
	 9nBDcd9fSVfbNevQWcZSmdNu5672lu7FwE2Fx9YTwxqBdDsgvVNF1e3XkE5UYOom2E
	 f/Y5MqCbL0+yQ==
Message-ID: <42286636-2fca-4658-a79d-145ad1c37b37@kernel.org>
Date: Tue, 6 Jan 2026 19:50:33 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/4] iommu: Add page_ext for IOMMU_DEBUG_PAGEALLOC
To: Mostafa Saleh <smostafa@google.com>, linux-mm@kvack.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Cc: corbet@lwn.net, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
 akpm@linux-foundation.org, vbabka@suse.cz, surenb@google.com,
 mhocko@suse.com, jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, rppt@kernel.org,
 xiaqinxin@huawei.com, baolu.lu@linux.intel.com, rdunlap@infradead.org
References: <20260106162200.2223655-1-smostafa@google.com>
 <20260106162200.2223655-2-smostafa@google.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
In-Reply-To: <20260106162200.2223655-2-smostafa@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/6/26 17:21, Mostafa Saleh wrote:
> Add a new config IOMMU_DEBUG_PAGEALLOC, which registers new data to
> page_ext.
> 
> This config will be used by the IOMMU API to track pages mapped in
> the IOMMU to catch drivers trying to free kernel memory that they
> still map in their domains, causing all types of memory corruption.
> 
> This behaviour is disabled by default and can be enabled using
> kernel cmdline iommu.debug_pagealloc.
> 
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> ---

[...]

> +#endif /* __LINUX_IOMMU_DEBUG_PAGEALLOC_H */
> diff --git a/mm/page_ext.c b/mm/page_ext.c
> index d7396a8970e5..297e4cd8ce90 100644
> --- a/mm/page_ext.c
> +++ b/mm/page_ext.c
> @@ -11,6 +11,7 @@
>   #include <linux/page_table_check.h>
>   #include <linux/rcupdate.h>
>   #include <linux/pgalloc_tag.h>
> +#include <linux/iommu-debug-pagealloc.h>
>   
>   /*
>    * struct page extension
> @@ -89,6 +90,9 @@ static struct page_ext_operations *page_ext_ops[] __initdata = {
>   #ifdef CONFIG_PAGE_TABLE_CHECK
>   	&page_table_check_ops,
>   #endif
> +#ifdef CONFIG_IOMMU_DEBUG_PAGEALLOC
> +	&page_iommu_debug_ops,
> +#endif
>   };
>   
>   unsigned long page_ext_size;

The MM bits LGTM

Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>

-- 
Cheers

David
