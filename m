Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9AD20DC8
	for <iommu@lists.linux.dev>; Thu, 25 Apr 2024 10:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714042361; cv=none; b=m4VJx/qhe821v9S7J+TPFq0/Ol9vP2S7Jt7a0PPJuXk6HFNkrFzEas2+mEVCh8YLnqa3pKpkLATrKTzp7nkrYjYRO0cySx7eVEexMZZ+2mGh6ImH1TaRH2tk3nB8wNw6ipyZrUHjC9ARh5Dw8/4CfeUR4c9twL4BLdILKyONcTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714042361; c=relaxed/simple;
	bh=Ar1GqtbHV7TvYScxEgkS4ik5kDQlPzxCfA0GlbTjt+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X+Tq/RxC0mg4loKCDVB9ouG+kpcNuHmS9PdCQKhqOGFcNkaUqTbNLx6xIo+S9zQQNIBUh2LnTPjCDVZhb54LVQQFSe8wByVjSgRWBa8iaU0qM4lqSvDomjWt+CQO6AruhX8Eglc7j9Lbt/8yRFdjxBmZeyhTJCFy2k4qfLQEUZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6D9E71007;
	Thu, 25 Apr 2024 03:53:07 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6CBBC3F7BD;
	Thu, 25 Apr 2024 03:52:38 -0700 (PDT)
Message-ID: <e3175546-5357-4946-97b1-7677b0596772@arm.com>
Date: Thu, 25 Apr 2024 11:52:36 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] iommu/amd: Fix memory leak in alloc_pci_segment()
To: "Kun(llfl)" <llfl@linux.alibaba.com>, Joerg Roedel <joro@8bytes.org>,
 Vasant Hegde <vasant.hegde@amd.com>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <a06d50c3a82214a82ccb88c22aa4e4a1d595b39c.1714040214.git.llfl@linux.alibaba.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <a06d50c3a82214a82ccb88c22aa4e4a1d595b39c.1714040214.git.llfl@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25/04/2024 11:17 am, Kun(llfl) wrote:
> Fix the memory leak issue that occurs when resource allocation fails in
> alloc_pci_segment(). The dev_table, alias_table, and rlookup_table were
> introduced individually in three commits. But they all fail to release
> allocated resources when other allocations fail.

As far as I can tell the returned error should end up being handled in 
state_next(), which *will* then clean these up again, at least in the 
!irq_remapping_enabled path. If there's any cleanup missing from the 
other path, then I think it should be fixed there, since it may well 
represent more than just these particular allocations.

Thanks,
Robin.

> Fixes: 04230c119930 ("iommu/amd: Introduce per PCI segment device table")
> Fixes: 99fc4ac3d297 ("iommu/amd: Introduce per PCI segment alias_table"),
> Fixes: eda797a27795 ("iommu/amd: Introduce per PCI segment rlookup table").
> Reported-by: Xuchun Shang <xuchun.shang@linux.alibaba.com>
> Signed-off-by: Kun(llfl) <llfl@linux.alibaba.com>
> ---
>   drivers/iommu/amd/init.c | 15 ++++++++++++---
>   1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index ac6754a85f35..4ce567f39473 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -1642,13 +1642,22 @@ static struct amd_iommu_pci_seg *__init alloc_pci_segment(u16 id,
>   	list_add_tail(&pci_seg->list, &amd_iommu_pci_seg_list);
>   
>   	if (alloc_dev_table(pci_seg))
> -		return NULL;
> +		goto alloc_dev_fail;
>   	if (alloc_alias_table(pci_seg))
> -		return NULL;
> +		goto alloc_alias_fail;
>   	if (alloc_rlookup_table(pci_seg))
> -		return NULL;
> +		goto alloc_rlookup_fail;
>   
>   	return pci_seg;
> +
> +alloc_rlookup_fail:
> +	free_rlookup_table(pci_seg);
> +alloc_alias_fail:
> +	free_alias_table(pci_seg);
> +alloc_dev_fail:
> +	free_dev_table(pci_seg);
> +	kfree(pci_seg);
> +	return NULL;
>   }
>   
>   static struct amd_iommu_pci_seg *__init get_pci_segment(u16 id,
