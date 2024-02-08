Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973AB2E3F9
	for <iommu@lists.linux.dev>; Thu,  8 Feb 2024 04:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707364881; cv=none; b=ZA0pgTo+wQSkOU3iHqjsAaLrBr7KQnJH9iiFjXmlcyl28A99vsjl+6DDxvankTYDXGotvpQR0WOQnboD10sYk3w23F475a/gH0CQAgvvkgcCded7WC0/fuQq5hm+ow9AjQoKxYSqsPAGSjAraiUiR7OHoaqU3hgG/MXqFXKlxoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707364881; c=relaxed/simple;
	bh=qssGJbK0ESJ7STyLMPwWaFGvgaAgAgGZ/WWghYc5FsA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bcU2rZsToayHR/fu8QC5CoFDGt26VxxVkZzlibuSVWbMEGwgM5bkQWIWM6KGgGKqHwHTBHSDga9HRjtiCeggVwiw6UkrLbBEFmvBscmor0cb5do1r9jcE/UQ+KP6Bi8qQw0BsV9FGXiVxgEuhcF4KXlDDRQg9K99F6qc4iVTs2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D9F6D1FB;
	Wed,  7 Feb 2024 20:01:58 -0800 (PST)
Received: from [10.163.44.57] (unknown [10.163.44.57])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0F3EC3F5A1;
	Wed,  7 Feb 2024 20:01:13 -0800 (PST)
Message-ID: <180491ea-d4b4-4d70-a615-595492175efd@arm.com>
Date: Thu, 8 Feb 2024 09:31:11 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma-contiguous: remove debug code to removed
 CONFIG_CMA_DEBUG
Content-Language: en-US
To: Lukas Bulwahn <lukas.bulwahn@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240207143825.986-1-lukas.bulwahn@gmail.com>
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20240207143825.986-1-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/7/24 20:08, Lukas Bulwahn wrote:
> Commit acc2f3e42d4a ("mm/cma: drop CONFIG_CMA_DEBUG") removes the config
> CMA_DEBUG and the debug code in cma.c, but misses debug code in
> kernel/dma/contiguous.c.
> 
> Remove this dead code from this removed config option.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> Andrew, please pick this minor clean-up patch of top of the commit above.
> 
>  kernel/dma/contiguous.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
> index f005c66f378c..055da410ac71 100644
> --- a/kernel/dma/contiguous.c
> +++ b/kernel/dma/contiguous.c
> @@ -37,12 +37,6 @@
>  
>  #define pr_fmt(fmt) "cma: " fmt
>  
> -#ifdef CONFIG_CMA_DEBUG
> -#ifndef DEBUG
> -#  define DEBUG
> -#endif
> -#endif
> -
>  #include <asm/page.h>
>  
>  #include <linux/memblock.h>

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
