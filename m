Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20561D9665
	for <iommu@lists.linux.dev>; Mon,  6 Jan 2025 10:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736159513; cv=none; b=LuIeeQFtF0Q6wk6lvV55kqETQ/trgSW/jky1cxnT5DMYgDJHi2I3ch3+M0JQdAWQ0a9+gWOJTdxYqp4N/tihOq3bbyaPAUZAXhL+3XGoWrtn3/uVNYJCDBRSZyGHN8RiNBGrHLiwblYw7DTz0V6PqmsU7a1k6ckq1QnRQpng7sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736159513; c=relaxed/simple;
	bh=Hoa8HUSvup5nIRzjQk2vYCIhvSM56aLelF7wG8Ms4mo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MfcC0hy7eksVf5AgeAXEkrlJMCj7ujgVIVnAZd8Z2Wv3wkXSmnP9jBnEBI3BLZ+QMSk46+a0VK4bgE7/Ekrw3LgVHyRPS01Knld2PooYkoi9LaPBbV7xBHP2al9s4/75W5OURzI1Pbp/DO9CrhibztJw+qhmKgwFJYuk+0Bz7Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 97A2DC0003;
	Mon,  6 Jan 2025 10:31:45 +0000 (UTC)
Message-ID: <a110be11-923e-4943-8741-43b5513c9691@ghiti.fr>
Date: Mon, 6 Jan 2025 11:31:45 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/riscv: Fixup compile warning
Content-Language: en-US
To: guoren@kernel.org, tjeznach@rivosinc.com
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
 paul.walmsley@sifive.com, palmer@dabbelt.com, baolu.lu@linux.intel.com,
 zong.li@sifive.com, iommu@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
References: <20250103024616.3359159-1-guoren@kernel.org>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20250103024616.3359159-1-guoren@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

Hi Guo,

On 03/01/2025 03:46, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
>
> When __BITS_PER_LONG == 32, size_t is defined as unsigned int rather


RISCV_IOMMU depends on 64BIT so how do you get __BITS_PER_LONG == 32?

Thanks,

Alex


> than unsigned long. Therefore, we should use size_t to avoid
> type-checking errors.
>
> Fixes: 488ffbf18171 ("iommu/riscv: Paging domain support")
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> Cc: Tomasz Jeznach <tjeznach@rivosinc.com>
> ---
>   drivers/iommu/riscv/iommu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> index 8a05def774bd..38d381164385 100644
> --- a/drivers/iommu/riscv/iommu.c
> +++ b/drivers/iommu/riscv/iommu.c
> @@ -1270,7 +1270,7 @@ static phys_addr_t riscv_iommu_iova_to_phys(struct iommu_domain *iommu_domain,
>   					    dma_addr_t iova)
>   {
>   	struct riscv_iommu_domain *domain = iommu_domain_to_riscv(iommu_domain);
> -	unsigned long pte_size;
> +	size_t pte_size;
>   	unsigned long *ptr;
>   
>   	ptr = riscv_iommu_pte_fetch(domain, iova, &pte_size);
