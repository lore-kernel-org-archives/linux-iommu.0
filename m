Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793814182;
	b=rhSzqIuc8oEzKxf/Sq3BIKDbKj2wXDb3eWbuA6FwU7ldzSyw3J8juh8yhRAZcm9y5dyg
	 7Y8JZthH2Ge2sbI0aPHpG9SsmYS72Db6rmtzNhQjMt6L4mdX5t72ZzbCGnmXfkPEsd5ur
	 D9YcSD6DxLzZGdg5jTC0d6Ud1GhYZFsh+4iWUpr96tWZHQuGjxLjO5c+3nU3uk1aXoy3w
	 iMKVLrdkC7ouegLGEBcFs449zzaqyRLO2pJlW90/Ss4WWEPfW2Wfn4wkHRcSAG0qklTw+
	 OSicMVTpnIb/0ESWFE5/KZtMyCC6+M+9T8Q9++vVUx1bbKdbZ84zx38RnLShZ4IB8ZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793814182;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=D/ufQuT616L/slKbsMvHsuyGu7FrChwnjA8syXHjneE=;
	b=4rH61OuV7JZ4IGjmNdlefIGHOamChC5lGAfKB9+ugz8i9xjF0U6r2hkzhuvkkyBxGUK2
	 s3/MQzswHZoaheSaK/HWM+C4du9zl3+A3BNGVto/Ko/OddiXOBLNSGf7+V1dYw2BS7bKn
	 MQtdhBp2C/D0w/7t40zbl+FzGPzEuqeYR6BmlsW0auMcW3ufYrz9GLl4fALw1xJD1gVxW
	 zKrT1cQ+ETu/kAWbAwivRosdXOlelSgki+6xaCpwWCca5eqA1X56qEutlAPSGbxWS4tXz
	 cTrqR3bUbdHfm2UAxl4fDxKDoArkYJKUj8t/wop6aLKDQP/NAYuk1H2vpJbexdIrZwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b="KPcKo/04";
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48EB4606A326
	for <iommu@lists.linux.dev>; Wed,  4 Nov 2026 17:43:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48EB4606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=KPcKo/04
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7A7741BB0;
	Wed,  4 Nov 2026 09:42:57 -0800 (PST)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 005123F673;
	Wed,  4 Nov 2026 09:42:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793814180; bh=1CoUnHkJvq7fNArZYhXbaSulQ+DONEx5SVmufR69YZ8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KPcKo/048miBpsrKK9qd7lPKn5afNfN0G0JjZZh9fCJDFIyzkbTShfocwDB9yrqij
	 caTD7IYV8qxi1/LtWKV6CN2UV8LEfhbFkvQ+Nu+qArzsUR7+31CT/vKUyJ2YFX74Ul
	 XECBPwU5it1AttvWJhBPFtDsNHd0Doa4KTaM6jw8=
Message-ID: <2d0fbfdd-4497-492e-be26-9f4b79fe47bb@arm.com>
Date: Wed, 4 Nov 2026 17:42:52 +0000
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] iommu/ipmmu-vmsa: Keep shared micro-TLBs enabled
 while in use
To: Koichiro Den <den@valinux.co.jp>, "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Magnus Damm <damm+renesas@opensource.se>,
 Jason Gunthorpe <jgg@ziepe.ca>, Lu Baolu <baolu.lu@linux.intel.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
 Marek Vasut <marek.vasut@mailbox.org>, iommu@lists.linux.dev,
 linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261104162251.1749998-1-den@valinux.co.jp>
 <20261104162251.1749998-4-den@valinux.co.jp>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20261104162251.1749998-4-den@valinux.co.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/11/2026 4:22 pm, Koichiro Den wrote:
> PCI functions can share a micro-TLB. ipmmu_release_device() disables it
> unconditionally, so removing one function makes DMA from the others
> bypass translation even though they remain attached to a paging domain.
> Switching a device to the identity domain can disable a shared micro-TLB
> in the same way.
> 
> Count the users of each micro-TLB and disable it only when its last user
> leaves. Track whether each device holds a reference so paging-domain
> switches do not add another one and release does not drop a reference
> the device never acquired.

Shouldn't we just not touch the physical enable/disable state at all in 
release_device? Once the device is removed, if it did happen to be the 
last one in the group then the default domain will be torn down, so at 
most I would think it should just be a case of ipmmu_domain_free() 
detecting if the domain being freed is the currently-attached one, and 
if so then resetting the uTLB to its desired default state.

Thanks,
Robin.

> Cc: stable@vger.kernel.org
> Fixes: 24dfb197c3b7 ("iommu/ipmmu-vmsa: Call arm_iommu_release_mapping() in release path")
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
>   drivers/iommu/ipmmu-vmsa.c | 121 ++++++++++++++++++++++++++-----------
>   1 file changed, 86 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
> index cea9348ac10d..bfbb6795ec13 100644
> --- a/drivers/iommu/ipmmu-vmsa.c
> +++ b/drivers/iommu/ipmmu-vmsa.c
> @@ -7,6 +7,7 @@
>    */
>   
>   #include <linux/bitmap.h>
> +#include <linux/cleanup.h>
>   #include <linux/delay.h>
>   #include <linux/dma-mapping.h>
>   #include <linux/err.h>
> @@ -59,14 +60,26 @@ struct ipmmu_vmsa_device {
>   	struct ipmmu_vmsa_device *root;
>   	const struct ipmmu_features *features;
>   	unsigned int num_ctx;
> -	spinlock_t lock;			/* Protects ctx and domains[] */
> +	/* Protects ctx, domains[], utlb_ctx[] and utlb_users[] */
> +	spinlock_t lock;
>   	DECLARE_BITMAP(ctx, IPMMU_CTX_MAX);
>   	struct ipmmu_vmsa_domain *domains[IPMMU_CTX_MAX];
>   	s8 utlb_ctx[IPMMU_UTLB_MAX];
> +	unsigned int utlb_users[IPMMU_UTLB_MAX];
>   
>   	struct dma_iommu_mapping *mapping;
>   };
>   
> +/*
> + * Per bus master (device) data. Several bus masters can be connected to the
> + * same microTLB, which stays enabled until the last translated master using it
> + * is gone (see ipmmu_vmsa_device.utlb_users[]).
> + */
> +struct ipmmu_vmsa_master {
> +	struct ipmmu_vmsa_device *mmu;
> +	bool translated;		/* Counted in mmu->utlb_users[] */
> +};
> +
>   struct ipmmu_vmsa_domain {
>   	struct ipmmu_vmsa_device *mmu;
>   	struct iommu_domain io_domain;
> @@ -83,11 +96,18 @@ static struct ipmmu_vmsa_domain *to_vmsa_domain(struct iommu_domain *dom)
>   	return container_of(dom, struct ipmmu_vmsa_domain, io_domain);
>   }
>   
> -static struct ipmmu_vmsa_device *to_ipmmu(struct device *dev)
> +static struct ipmmu_vmsa_master *to_master(struct device *dev)
>   {
>   	return dev_iommu_priv_get(dev);
>   }
>   
> +static struct ipmmu_vmsa_device *to_ipmmu(struct device *dev)
> +{
> +	struct ipmmu_vmsa_master *master = to_master(dev);
> +
> +	return master ? master->mmu : NULL;
> +}
> +
>   #define TLB_LOOP_TIMEOUT		100	/* 100us */
>   
>   /* -----------------------------------------------------------------------------
> @@ -281,11 +301,6 @@ static void ipmmu_utlb_enable(struct ipmmu_vmsa_domain *domain,
>   {
>   	struct ipmmu_vmsa_device *mmu = domain->mmu;
>   
> -	/*
> -	 * TODO: Reference-count the microTLB as several bus masters can be
> -	 * connected to the same microTLB.
> -	 */
> -
>   	/* TODO: What should we set the ASID to ? */
>   	ipmmu_imuasid_write(mmu, utlb, 0);
>   	/* TODO: Do we need to flush the microTLB ? */
> @@ -297,15 +312,63 @@ static void ipmmu_utlb_enable(struct ipmmu_vmsa_domain *domain,
>   /*
>    * Disable MMU translation for the microTLB.
>    */
> -static void ipmmu_utlb_disable(struct ipmmu_vmsa_domain *domain,
> +static void ipmmu_utlb_disable(struct ipmmu_vmsa_device *mmu,
>   			       unsigned int utlb)
>   {
> -	struct ipmmu_vmsa_device *mmu = domain->mmu;
> -
>   	ipmmu_imuctr_write(mmu, utlb, 0);
>   	mmu->utlb_ctx[utlb] = IPMMU_CTX_INVALID;
>   }
>   
> +/*
> + * Enable this master's micro-TLBs using the domain's context.
> + *
> + * Several bus masters can be connected to the same microTLB, so count the
> + * masters translated through each of them. Moving a master from one paging
> + * domain to another keeps its reference and only updates the context selection.
> + */
> +static void ipmmu_attach_utlbs(struct ipmmu_vmsa_domain *domain,
> +			       struct device *dev)
> +{
> +	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> +	struct ipmmu_vmsa_master *master = to_master(dev);
> +	struct ipmmu_vmsa_device *mmu = domain->mmu;
> +	unsigned int i;
> +
> +	guard(spinlock_irqsave)(&mmu->lock);
> +
> +	for (i = 0; i < fwspec->num_ids; ++i) {
> +		if (!master->translated)
> +			mmu->utlb_users[fwspec->ids[i]]++;
> +		ipmmu_utlb_enable(domain, fwspec->ids[i]);
> +	}
> +	master->translated = true;
> +}
> +
> +/*
> + * Drop this master's references to its micro-TLBs. A micro-TLB stays enabled
> + * as long as other bus masters connected to it are still translated.
> + */
> +static void ipmmu_detach_utlbs(struct device *dev)
> +{
> +	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> +	struct ipmmu_vmsa_master *master = to_master(dev);
> +	struct ipmmu_vmsa_device *mmu = master->mmu;
> +	unsigned int i;
> +
> +	guard(spinlock_irqsave)(&mmu->lock);
> +
> +	if (!master->translated)
> +		return;
> +
> +	for (i = 0; i < fwspec->num_ids; ++i) {
> +		unsigned int utlb = fwspec->ids[i];
> +
> +		if (!--mmu->utlb_users[utlb])
> +			ipmmu_utlb_disable(mmu, utlb);
> +	}
> +	master->translated = false;
> +}
> +
>   static void ipmmu_tlb_flush_all(void *cookie)
>   {
>   	struct ipmmu_vmsa_domain *domain = cookie;
> @@ -592,10 +655,8 @@ static void ipmmu_domain_free(struct iommu_domain *io_domain)
>   static int ipmmu_attach_device(struct iommu_domain *io_domain,
>   			       struct device *dev, struct iommu_domain *old)
>   {
> -	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
>   	struct ipmmu_vmsa_device *mmu = to_ipmmu(dev);
>   	struct ipmmu_vmsa_domain *domain = to_vmsa_domain(io_domain);
> -	unsigned int i;
>   	int ret = 0;
>   
>   	if (!mmu) {
> @@ -630,8 +691,7 @@ static int ipmmu_attach_device(struct iommu_domain *io_domain,
>   	if (ret < 0)
>   		return ret;
>   
> -	for (i = 0; i < fwspec->num_ids; ++i)
> -		ipmmu_utlb_enable(domain, fwspec->ids[i]);
> +	ipmmu_attach_utlbs(domain, dev);
>   
>   	return 0;
>   }
> @@ -640,16 +700,7 @@ static int ipmmu_iommu_identity_attach(struct iommu_domain *identity_domain,
>   				       struct device *dev,
>   				       struct iommu_domain *old)
>   {
> -	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> -	struct ipmmu_vmsa_domain *domain;
> -	unsigned int i;
> -
> -	if (old == identity_domain || !old)
> -		return 0;
> -
> -	domain = to_vmsa_domain(old);
> -	for (i = 0; i < fwspec->num_ids; ++i)
> -		ipmmu_utlb_disable(domain, fwspec->ids[i]);
> +	ipmmu_detach_utlbs(dev);
>   
>   	/*
>   	 * TODO: Optimize by disabling the context when no device is attached.
> @@ -815,6 +866,7 @@ static struct iommu_device *ipmmu_probe_device(struct device *dev)
>   {
>   	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
>   	struct platform_device *ipmmu_pdev;
> +	struct ipmmu_vmsa_master *master;
>   	struct ipmmu_vmsa_device *mmu;
>   
>   	if (!fwspec)
> @@ -830,7 +882,12 @@ static struct iommu_device *ipmmu_probe_device(struct device *dev)
>   	if (!mmu)
>   		return ERR_PTR(-ENODEV);
>   
> -	dev_iommu_priv_set(dev, mmu);
> +	master = kzalloc_obj(*master);
> +	if (!master)
> +		return ERR_PTR(-ENOMEM);
> +
> +	master->mmu = mmu;
> +	dev_iommu_priv_set(dev, master);
>   
>   	return &mmu->iommu;
>   }
> @@ -848,18 +905,12 @@ static void ipmmu_probe_finalize(struct device *dev)
>   
>   static void ipmmu_release_device(struct device *dev)
>   {
> -	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> -	struct ipmmu_vmsa_device *mmu = to_ipmmu(dev);
> -	unsigned int i;
> +	struct ipmmu_vmsa_master *master = to_master(dev);
>   
> -	for (i = 0; i < fwspec->num_ids; ++i) {
> -		unsigned int utlb = fwspec->ids[i];
> +	ipmmu_detach_utlbs(dev);
>   
> -		ipmmu_imuctr_write(mmu, utlb, 0);
> -		mmu->utlb_ctx[utlb] = IPMMU_CTX_INVALID;
> -	}
> -
> -	arm_iommu_release_mapping(mmu->mapping);
> +	arm_iommu_release_mapping(master->mmu->mapping);
> +	kfree(master);
>   }
>   
>   static const struct iommu_ops ipmmu_ops = {

