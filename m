Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2249F187560
	for <iommu@lists.linux.dev>; Fri, 14 Jun 2024 12:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718367645; cv=none; b=jFVcQQ8lvffM/8kI2JrLF58FjTj7BI4DTLCGrFVrTNBgx9zebObxp2wzv+J+8wxRCxSAyTCbtk34ZreD9y7lZmqxu8c8u/0wQByBB6i5Zs9SV37z7LnOrU+LzcL1f5VaisIDsRih7qOiZ/VGW3/TvakpFpE138VYaLkijETAK6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718367645; c=relaxed/simple;
	bh=AQjmUgnkIYBObU9R4yF5y+8pGugJxUIcztwj75zUnTI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UcylDH6W4g0TRAIydm0gg7hQcJvryBsVh98Cn97MMBdnF9v7/i7aaLtVCPVgN9wLM2mJfB2pBccp8zyYX8xHBCEaxCkI4W5v9cRhnr80eQWPr0QCKjUT/9hAZvPQLoqJ7YFwe8rdr3AgpxGKuCCWR+QcUp6jGBT534mzkde21ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 176E7FEC;
	Fri, 14 Jun 2024 05:21:06 -0700 (PDT)
Received: from [10.57.71.136] (unknown [10.57.71.136])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 572BD3F64C;
	Fri, 14 Jun 2024 05:20:40 -0700 (PDT)
Message-ID: <f22db70d-01da-4b49-a13c-6c4639215468@arm.com>
Date: Fri, 14 Jun 2024 13:20:39 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/iova: add missing MODULE_DESCRIPTION() macro
To: Jeff Johnson <quic_jjohnson@quicinc.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <20240613-md-arm-drivers-iommu-v1-1-1fe0bd953119@quicinc.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20240613-md-arm-drivers-iommu-v1-1-1fe0bd953119@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-06-14 2:14 am, Jeff Johnson wrote:
> With ARCH=arm, make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/iommu/iova.o
> 
> Add the missing invocation of the MODULE_DESCRIPTION() macro.

Acked-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
>   drivers/iommu/iova.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index d59d0ea2fd21..16c6adff3eb7 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -1000,4 +1000,5 @@ void iova_cache_put(void)
>   EXPORT_SYMBOL_GPL(iova_cache_put);
>   
>   MODULE_AUTHOR("Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>");
> +MODULE_DESCRIPTION("IOMMU I/O Virtual Address management");
>   MODULE_LICENSE("GPL");
> 
> ---
> base-commit: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
> change-id: 20240613-md-arm-drivers-iommu-f637be6ec5c8
> 
