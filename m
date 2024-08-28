Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C62616A95E
	for <iommu@lists.linux.dev>; Wed, 28 Aug 2024 12:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724847845; cv=none; b=QM0BCzc4cMRqcYx0nG1ppILOi0dysAjJQwaVP2xEmdqe2x/vqkI2L/sKHwC+EbPSxFJDmS+GHmfsvrcQ1ohD2FQL6Kku0aAepNWe1x5zXMz9tHT2D5oFekAQh5/7pOQ0mooG1EFGKbyapwzQG2tCuGLJhd8XCL87yAttVMD9p48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724847845; c=relaxed/simple;
	bh=DhbYiKCxIaI5K4X1jElvrVtfLmHG0vgjgkuGIpyae14=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NtmBQh7684QPBJj4xDhvEfhmwNNgsd8xYttzETguKUattz085gqGBkArT3tCL1qCNoR5IMCoFWqTMWFI/+WVpK0FH7xm9DVr+f1tGfRBEPf39oLC+jCcS87l7ynJcDx5mDqx6VXDoHXi4u+j4ROCaQrp2rtqFJjr0iuLyN+ALnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CF559DA7;
	Wed, 28 Aug 2024 05:24:29 -0700 (PDT)
Received: from [10.57.15.188] (unknown [10.57.15.188])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EA1C63F762;
	Wed, 28 Aug 2024 05:24:02 -0700 (PDT)
Message-ID: <ee9b096a-7d23-47ed-850f-f8ca2c9af97f@arm.com>
Date: Wed, 28 Aug 2024 13:24:00 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] iommu/omap: Use IS_ERR_OR_NULL() helper function
To: Hongbo Li <lihongbo22@huawei.com>, joro@8bytes.org, will@kernel.org
Cc: iommu@lists.linux.dev
References: <20240828122152.3697094-1-lihongbo22@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20240828122152.3697094-1-lihongbo22@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-08-28 1:21 pm, Hongbo Li wrote:
> Use the IS_ERR_OR_NULL() helper instead of open-coding a
> NULL and an error pointer checks to simplify the code and
> improve readability.

IS_ERR_OR_NULL() is usually a bad smell to begin with... Sure enough, if 
you really want to simplify and improve this code, it doesn't take much 
to look a little further and see that the suspicious checks are entirely 
pointless anyway. Both callsites have this pattern:

		omap_iommu_detach(oiommu);
		...
		oiommu->domain = NULL;

so clearly the pointer must always be valid.

Thanks,
Robin.
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> ---
>   drivers/iommu/omap-iommu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
> index c9528065a59a..b7e323aa016f 100644
> --- a/drivers/iommu/omap-iommu.c
> +++ b/drivers/iommu/omap-iommu.c
> @@ -881,7 +881,7 @@ static int omap_iommu_attach(struct omap_iommu *obj, u32 *iopgd)
>    **/
>   static void omap_iommu_detach(struct omap_iommu *obj)
>   {
> -	if (!obj || IS_ERR(obj))
> +	if (IS_ERR_OR_NULL(obj))
>   		return;
>   
>   	spin_lock(&obj->iommu_lock);
