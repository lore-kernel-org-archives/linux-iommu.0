Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94DF3876A1
	for <iommu@lists.linux.dev>; Tue, 28 Jul 2026 12:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785243055; cv=none; b=BaQL9OCMXjlcmDmu8yoaXXDpfw1jUbTItbX+b6Jiiibp8t5Kzp17tVl+sppqbTPAmwz2QF2XwtyWkNJmpKV14w53CupN55lhD5xSYb+L8MZKAJ0gudrAMezeN5pFdfdwqgeAJc/RVtdkkmKDBM6XHA8F/11GBUvhaX8cfppAsaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785243055; c=relaxed/simple;
	bh=+4MAcUMifAN4Lhq+OMwl+pTKUksq2YjMG7EJXCsjloc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EutRSBQe+PNduJLuNRJo1jyQTYURphyLzMHsUYM1D7OYRYTvcwIBdR6IYvUO/W+NDuzlCggysRK6AFkHjlgrIybmPXhTxIpDZwSEZ/5SgwJ/x+u0aUlFG6hjDVu8n4evs5p90eii+YAOPEX8eoevUrMMVjONEaO3+Klw2ePGMaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=cCmI9qFP; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="cCmI9qFP"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F22CA175D;
	Tue, 28 Jul 2026 05:50:46 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3D8D83F86F;
	Tue, 28 Jul 2026 05:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785243051; bh=+4MAcUMifAN4Lhq+OMwl+pTKUksq2YjMG7EJXCsjloc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cCmI9qFPj8sWBD4IhBPCS8AEopOfRp1+ljHkEd5ecF+6XR1mNlKHxKgpmBlU9mHU7
	 p3unjvmJCd+CMm8JHpdIFaCKRVv+3KNF8fLzep2c7kSF9byO057wKrzzSWU2PKY5g4
	 xcWD+0ARpcrS1eCEGDV95G5v3ggMOMkQ0YECOqSc=
Message-ID: <7c8097fb-2f4c-442b-9aaa-4c04d10a1988@arm.com>
Date: Tue, 28 Jul 2026 13:50:48 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/dma: Restore locking around msi_page_list
To: Andrew Jones <andrew.jones@oss.qualcomm.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Cc: joro@8bytes.org, will@kernel.org, nicolinc@nvidia.com, jgg@ziepe.ca
References: <20260728123313.1284782-1-andrew.jones@oss.qualcomm.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260728123313.1284782-1-andrew.jones@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28/07/2026 1:33 pm, Andrew Jones wrote:
> Unlike a group's default domain, which is always freshly allocated
> and privately owned (iommu_group_alloc_default_domain()), VFIO type1's
> legacy container merges any newly attached group into an existing
> domain whenever their iommu_ops and cache-coherency enforcement match.
> 
> iommu_dma_get_msi_page() only asserts the caller's own group mutex is
> held (iommu_group_mutex_assert()). On an IOMMU that publishes
> IOMMU_RESV_SW_MSI, e.g. ARM SMMU, a VM with two such devices assigned
> through the legacy container can have their guest drivers probe and
> allocate MSIs in parallel; each host-side VFIO_DEVICE_SET_IRQS lands
> on a different device fd and group mutex, but both devices' domains
> are the same merged domain, so both can enter
> iommu_dma_get_msi_page() concurrently and corrupt msi_page_list.
> 
> commit 288683c92b1a ("iommu: Make iommu_dma_prepare_msi() into a
> generic operation") dropped the prior msi_prepare_lock on the
> reasoning that "each iommu_domain is unique to a group," which holds
> for default domains but not this VFIO type1 case. iommufd already
> handles its analogous list correctly: iommufd_sw_msi_get_map()'s
> sw_msi_list is explicitly ctx-wide and protected by ctx->sw_msi_lock,
> not a per-group lock. Give dma-iommu's cookie the same treatment: a
> mutex scoped to the domain, held around the lookup-or-insert in
> iommu_dma_get_msi_page().
> 
> Fixes: 288683c92b1a ("iommu: Make iommu_dma_prepare_msi() into a generic operation")
> Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
> ---
> 
> Sashiko reported this issue while reviewing a riscv iommu series[1].
> I've only compile-tested this fix.
> 
> [1] https://sashiko.dev/#/patchset/20260724151218.965929-1-andrew.jones@oss.qualcomm.com
> 
> 
>   drivers/iommu/dma-iommu.c | 26 ++++++++++++++++++++++++++
>   1 file changed, 26 insertions(+)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 9abaec0703ef..0b5da4579aaf 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -58,6 +58,7 @@ struct iommu_dma_options {
>   struct iommu_dma_cookie {
>   	struct iova_domain iovad;
>   	struct list_head msi_page_list;
> +	struct mutex msi_lock;
>   	/* Flush queue */
>   	union {
>   		struct iova_fq *single_fq;
> @@ -80,6 +81,7 @@ struct iommu_dma_cookie {
>   struct iommu_dma_msi_cookie {
>   	dma_addr_t msi_iova;
>   	struct list_head msi_page_list;
> +	struct mutex msi_lock;
>   };
>   
>   static DEFINE_STATIC_KEY_FALSE(iommu_deferred_attach_enabled);
> @@ -378,6 +380,7 @@ int iommu_get_dma_cookie(struct iommu_domain *domain)
>   		return -ENOMEM;
>   
>   	INIT_LIST_HEAD(&cookie->msi_page_list);
> +	mutex_init(&cookie->msi_lock);
>   	domain->cookie_type = IOMMU_COOKIE_DMA_IOVA;
>   	domain->iova_cookie = cookie;
>   	return 0;
> @@ -411,6 +414,7 @@ int iommu_get_msi_cookie(struct iommu_domain *domain, dma_addr_t base)
>   
>   	cookie->msi_iova = base;
>   	INIT_LIST_HEAD(&cookie->msi_page_list);
> +	mutex_init(&cookie->msi_lock);
>   	domain->cookie_type = IOMMU_COOKIE_DMA_MSI;
>   	domain->msi_cookie = cookie;
>   	return 0;
> @@ -2196,6 +2200,18 @@ static struct list_head *cookie_msi_pages(const struct iommu_domain *domain)
>   	}
>   }
>   
> +static struct mutex *cookie_msi_lock(const struct iommu_domain *domain)
> +{
> +	switch (domain->cookie_type) {
> +	case IOMMU_COOKIE_DMA_IOVA:
> +		return &domain->iova_cookie->msi_lock;
> +	case IOMMU_COOKIE_DMA_MSI:
> +		return &domain->msi_cookie->msi_lock;
> +	default:
> +		BUG();
> +	}
> +}
> +
>   static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
>   		phys_addr_t msi_addr, struct iommu_domain *domain)
>   {
> @@ -2205,6 +2221,16 @@ static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
>   	int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
>   	size_t size = cookie_msi_granule(domain);
>   
> +	/*
> +	 * A VFIO type1 container can attach the same domain to devices in
> +	 * different iommu groups, each serialised by its own group mutex, so
> +	 * the group mutex held by iommu_dma_sw_msi()'s caller isn't enough to
> +	 * serialise msi_page_list lookups and insertions against each other
> +	 * here; take the cookie's own lock instead, scoped to just this
> +	 * domain.
> +	 */
> +	guard(mutex)(cookie_msi_lock(domain));

If this is still the sole place it's needed, why not just bring back the 
static lock as before? I can't see that requesting MSIs would be a 
particularly performance-sensitive or highly-contended operation to 
justify cluttering up domains with something that in one case is known 
to be unnecessary and in the other is still only for a rare corner case.

Alternatively, if IOMMUFD is able to do the right thing at the higher 
level, is there any scope for VFIO type1 to similarly serialise its own 
calls?

Thanks,
Robin.

> +
>   	msi_addr &= ~(phys_addr_t)(size - 1);
>   	list_for_each_entry(msi_page, msi_page_list, list)
>   		if (msi_page->phys == msi_addr)

