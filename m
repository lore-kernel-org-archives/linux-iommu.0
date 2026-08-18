Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D469F344031
	for <iommu@lists.linux.dev>; Tue, 18 Aug 2026 12:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787055065; cv=none; b=oH57942K4UwFZVlk0sfOjdOzj4SnUowljjrHyC7KGdiqnHNtPwAY4ffcITIlyiTofC9BNzoxxuXU8Pe6sflN59kJFgTD28T4+aqYdXKP74eMZaechJFtKxCZkpyDUeWLMQz+qB+FaI6w8pqD1PA+D6Dq1uMmO0Nq+9HpYL6a23E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787055065; c=relaxed/simple;
	bh=gPQBa9KcGWS0r9ToFsywECZH43XCjCsQKv6COXNFFxw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OiIehviUbB9pgotXxskvVSRo/7b+kozDoA2eGIlVDAW9M/M5WNu4BTa3AFJ0mAQ9YmH4Md6f4c5v5ikd5oaPdK45jbmcaRRbp+wTD3XslcLYhOAqXjx9qRwPxuFJ1747ei25o48flI7vF+Uig7lgjzsSLji6w94iTUJguoIfufY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=PSzyDs5V; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="PSzyDs5V"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 914E914BF;
	Tue, 18 Aug 2026 05:10:51 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3E1963F85F;
	Tue, 18 Aug 2026 05:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1787055055; bh=gPQBa9KcGWS0r9ToFsywECZH43XCjCsQKv6COXNFFxw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PSzyDs5VtnqKSk8EMFuTeQWMCqVF4gvA4k/i4fsxsl25+BxU6Isdi5qvludgV0nYI
	 gVkfXsGoptPxJsanWP+W4dqCbSnTp6x5gTGC45UcfmzaukRkvNFlaX4r2bPlpxNUWD
	 3AcOKbLM9G4AOXqKeblyX3Vm9cIZYNbSu8htc5lA=
Message-ID: <8c9066f6-e460-458b-bad4-26d441a742ab@arm.com>
Date: Tue, 18 Aug 2026 13:10:52 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/6] iommu/dma: Catch scatterlist length overflows
To: Krzysztof Karas <krzysztof.karas@intel.com>,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 iommu@lists.linux.dev
Cc: Andi Shyti <andi.shyti@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 =?UTF-8?Q?Micha=C5=82_Grzelak?= <michal.grzelak@intel.com>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
 Sebastian Brzezinka <sebastian.brzezinka@intel.com>,
 Krzysztof Niemiec <krzysztof.niemiec@intel.com>
References: <20260817095648.2438192-1-krzysztof.karas@intel.com>
 <20260817095648.2438192-4-krzysztof.karas@intel.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260817095648.2438192-4-krzysztof.karas@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/08/2026 10:56 am, Krzysztof Karas wrote:
> It is possible, when a very large mapping uses only one
> scatterlist, that padding overflows scatterlist's length field.
> This results in:
>   1) silently wrapping the value
>   2) smaller than desired mappings produced by iommu_map_sg
>   3) leaving mapped bytes in memory (no iommu_unmap)
> 
> Address this issue by adding overflow detection for scatterlist
> length field.
> 
> Fixes: 809eac54cdd6 ("iommu/dma: Implement scatterlist segment merging")
> Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
> ---
> v5 (sashiko review):
>   * Included overflow checking on addition, previously silently
>   omitted inside iova_align arguments.
>   * Added check for zero-mapping via temporary variable comparison.
>   * Added overflows_type on s->length to satisfy 64 bit systems.
> 
>   drivers/iommu/dma-iommu.c | 32 ++++++++++++++++++++++++++++++--
>   1 file changed, 30 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 9abaec0703ef..0bd5b13f006f 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -21,6 +21,7 @@
>   #include <linux/iommu-dma.h>
>   #include <linux/iova.h>
>   #include <linux/irq.h>
> +#include <linux/limits.h>
>   #include <linux/list_sort.h>
>   #include <linux/memremap.h>
>   #include <linux/mm.h>
> @@ -1445,6 +1446,7 @@ int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
>   	for_each_sg(sg, s, nents, i) {
>   		size_t s_iova_off = iova_offset(iovad, s->offset);
>   		size_t s_length = s->length;
> +		size_t s_length_tmp;
>   		size_t pad_len = (mask - iova_len + 1) & mask;
>   
>   		switch (pci_p2pdma_state(&p2pdma_state, dev, sg_page(s))) {
> @@ -1476,7 +1478,22 @@ int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
>   		sg_dma_address(s) = s_iova_off;
>   		sg_dma_len(s) = s_length;
>   		s->offset -= s_iova_off;
> -		s_length = iova_align(iovad, s_length + s_iova_off);
> +
> +		if (check_add_overflow(s_length, s_iova_off, &s_length_tmp)) {
> +			ret = -EOVERFLOW;
> +			goto out_restore_sg;
> +		}

This is unnecessary - s_iova_off will always be <= sg->offset, and since 
the maximum possible segment boundary mask is 32 bits, if sg->offset + 
sg->length would overflow then by definition it must cross a segment 
boundary, so the segment is malformed to begin with and all bets are off.

> +		s_length = iova_align(iovad, s_length_tmp);
> +
> +		if (s_length_tmp != 0 && s_length == 0) {
> +			ret = -EOVERFLOW;
> +			goto out_restore_sg;
> +		}

Similarly, a 0-length segment wouldn't be valid either (consider in the 
simple case it would end up with sg_dma_len() == 0 which means "end of 
mapping")

Thanks,
Robin.

> +
> +		if (overflows_type(s_length, s->length)) {
> +			ret = -EOVERFLOW;
> +			goto out_restore_sg;
> +		}
>   		s->length = s_length;
>   
>   		/*
> @@ -1493,7 +1510,18 @@ int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
>   		 *   time through here (i.e. before it has a meaningful value).
>   		 */
>   		if (pad_len && pad_len < s_length - 1) {
> -			prev->length += pad_len;
> +			unsigned int new_prev_len;
> +			/*
> +			 * For large mappings spanning multiple GBs we
> +			 * may not be able to fit all needed padding into
> +			 * sg->length.
> +			 */
> +			if (check_add_overflow(prev->length, pad_len, &new_prev_len)) {
> +				ret = -EOVERFLOW;
> +				goto out_restore_sg;
> +			}
> +
> +			prev->length = new_prev_len;
>   			iova_len += pad_len;
>   		}
>   

