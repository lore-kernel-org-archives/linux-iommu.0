Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB87220F49
	for <iommu@lists.linux.dev>; Sun, 29 Mar 2026 17:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774803690; cv=pass; b=IfqMmi0ULlXDmKU2Zp5eXEg1IJNak0ri1DXHMoXfiLL0DKBLAr7evSoax+Dn132xVFwt5XAuk1bjmRWa54x6vwoLU7oKzPJElX91Zt40e5qrCHq00lnWwPjv4C60yVEd4vPHNb1gtTVca5PyGibbd3PTE0DLCmvd7wx0VMipsTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774803690; c=relaxed/simple;
	bh=D69gXANH8TBNxZQkgyb8oin9nZ12Y/5FCUwK4Ecf+fo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JzkgjlcNXcxq5mW7hHQcJwljVVZ/exfNRSs4fPUcjT+g1JwppSeWSlehhmBzSSKkbdaai1PMifqbq8HaUSnitFsK+Eod4UIdOp9E2Gh4c/xREpvpT50gypB5hgX+B9XWt1/mbQsPuecbHKWbrus9unToyedP0J9bdi23Dhw9JB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=benjamin.gaignard@collabora.com header.b=KW6WRE8G; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=benjamin.gaignard@collabora.com header.b="KW6WRE8G"
ARC-Seal: i=1; a=rsa-sha256; t=1774803681; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=TcyHnaylvk07QRKxitF9wqW7gG6NVSPQX3bnLz2/hjopfBjKnoAPBFoua96wX7uE/F7lF8qg8Vc1PZMb72wjSI6C0L3c+yMWSE30ag9uvco28XpVexNQGZAYah2Ncy8VmtZh1yDWQhsmVI+ivpLCunmnZdXMRzHSAideamxtA3A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1774803681; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=kdBBo47+/mBAsd9iPiJAysoTiErRL2J2XY5aq4i0hpY=; 
	b=naNTCj/ftIouV+CVDFatmiyxxPolprzt7NXwS5wKsqsEFDnx7hssS/DKUVJ9yWSU4UlCrQfT0b9p7zv8xQJpHKq1LLruNeMYKFnijMENE01iz7f4k/xmq0dsfcDFaUtff8SVOQiTRGY/DCwqzy9TBtXcZtcXdPOipMOsUGNJf4c=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=benjamin.gaignard@collabora.com;
	dmarc=pass header.from=<benjamin.gaignard@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774803681;
	s=zohomail; d=collabora.com; i=benjamin.gaignard@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=kdBBo47+/mBAsd9iPiJAysoTiErRL2J2XY5aq4i0hpY=;
	b=KW6WRE8GxxSw8Xo7Ye4ksZVnyqkFUgx/uA9awoCfs0j3qt0IFJEZRHZOm6rAj9dw
	Hh6OV7LdtYk/dL+mA20+zMkvabuQxSZ2dbWSOuHWnInkY3cQmTYNG3aO4mc5d7Wu910
	LtfcyS8bYAeJ+Uc7F19BdKS1k6lsN30uvGqdBvug=
Received: by mx.zohomail.com with SMTPS id 177480368036818.123364854552847;
	Sun, 29 Mar 2026 10:01:20 -0700 (PDT)
Message-ID: <cfec65cb-398f-4f14-8587-2e2911372cda@collabora.com>
Date: Sun, 29 Mar 2026 19:01:15 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 3/6] iommu: Add verisilicon IOMMU driver
To: Will Deacon <will@kernel.org>
Cc: joro@8bytes.org, robin.murphy@arm.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de,
 nicolas.dufresne@collabora.com, p.zabel@pengutronix.de, mchehab@kernel.org,
 iommu@lists.linux.dev, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-media@vger.kernel.org
References: <20260216095144.107356-1-benjamin.gaignard@collabora.com>
 <20260216095144.107356-4-benjamin.gaignard@collabora.com>
 <acKxzGk1Z541yoZ4@willie-the-truck>
 <e083e933-2746-4b26-ac33-3b32d362b28e@collabora.com>
 <acQPEEd0hQrghGbw@willie-the-truck>
Content-Language: en-US
From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <acQPEEd0hQrghGbw@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Le 25/03/2026 à 17:36, Will Deacon a écrit :
> On Tue, Mar 24, 2026 at 05:28:44PM +0100, Benjamin Gaignard wrote:
>> Le 24/03/2026 à 16:46, Will Deacon a écrit :
>>> On Mon, Feb 16, 2026 at 10:51:35AM +0100, Benjamin Gaignard wrote:
>>>> The Verisilicon IOMMU hardware block can be found in combination
>>>> with Verisilicon hardware video codecs (encoders or decoders) on
>>>> different SoCs.
>>>> Enable it will allow us to use non contiguous memory allocators
>>>> for Verisilicon video codecs.
>>>> If both decoder and this iommu driver are compiled has modules
>>>> there is undefined symboles issues so this iommu driver could
>>>> only be compiled has built-in.
>>>>
>>>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>>>> ---
>>>>    MAINTAINERS               |   8 +
>>>>    drivers/iommu/Kconfig     |  11 +
>>>>    drivers/iommu/Makefile    |   1 +
>>>>    drivers/iommu/vsi-iommu.c | 794 ++++++++++++++++++++++++++++++++++++++
>>>>    include/linux/vsi-iommu.h |  21 +
>>>>    5 files changed, 835 insertions(+)
>>>>    create mode 100644 drivers/iommu/vsi-iommu.c
>>>>    create mode 100644 include/linux/vsi-iommu.h
>>> [...]
>>>
>>>> +static size_t vsi_iommu_unmap(struct iommu_domain *domain, unsigned long _iova,
>>>> +			      size_t size, size_t count, struct iommu_iotlb_gather *gather)
>>>> +{
>>>> +	struct vsi_iommu_domain *vsi_domain = to_vsi_domain(domain);
>>>> +	dma_addr_t pte_dma, iova = (dma_addr_t)_iova;
>>>> +	unsigned long flags;
>>>> +	phys_addr_t pt_phys;
>>>> +	u32 dte;
>>>> +	u32 *pte_addr;
>>>> +	size_t unmap_size = 0;
>>>> +
>>>> +	spin_lock_irqsave(&vsi_domain->lock, flags);
>>>> +
>>>> +	dte = vsi_domain->dt[vsi_iova_dte_index(iova)];
>>>> +	/* Just return 0 if iova is unmapped */
>>>> +	if (!vsi_dte_is_pt_valid(dte))
>>>> +		goto unlock;
>>>> +
>>>> +	pt_phys = vsi_dte_pt_address(dte);
>>>> +	pte_addr = (u32 *)phys_to_virt(pt_phys) + vsi_iova_pte_index(iova);
>>>> +	pte_dma = pt_phys + vsi_iova_pte_index(iova) * sizeof(u32);
>>>> +	unmap_size = vsi_iommu_unmap_iova(vsi_domain, pte_addr, pte_dma, size);
>>>> +
>>>> +unlock:
>>>> +	spin_unlock_irqrestore(&vsi_domain->lock, flags);
>>>> +
>>>> +	return unmap_size;
>>>> +}
>>> I still think you need TLB invalidation here.
>>>
>>> I looked at the downstream code that you linked to and it litters the
>>> invalidation in the callers via mpp_iommu_flush_tlb(), which tend to
>>> invalidate _before_ starting an operation. That's very likely buggy and
>>> certainly not something we want upstream.
>>>
>>> The unmap routine should do the invalidation so that, when it returns,
>>> the pages really are unmapped from the device (assuming strict mode).
>>>
>>> I know you said that you tried to add invalidation here and it "didn't
>>> work", but that's not something I can really help you with.
>> I know you expect the hardware to work like that but that isn't not the
>> case.
> The hardware appears to have a register to invalidate the entire TLB.
> We can use that if there's nothing else.

VSI_MMU_BIT_FLUSH ? it discards everything.
Is there an api to call it when all buffers have been unmapped ?

>
>> I spend quite long to try to found hidden bit(s) or an other way to do like
>> you want but I can't find any solution.
> Then we can invalidate the entire TLB.
>
>> As you mention the downstream code suggest that the iommu can't invalidate
>> TLB in unmap routine so I don't see how to progress.
> The downstream code is a tangled mess; I don't think it suggests anything
> about what the IOMMU hardware is capable of.

If you have an other source to tell the hardware capabilities, I will be
more than happy to read it and fix the driver.

Benjamin

>
>> Maybe we should just admit that is how the hardware work.
> No.
>
> The upstream kernel isn't a dumping ground for vendor crap. The hardware
> has TLB invalidation functionality and so we should use it. If we don't,
> then we're not giving the IOMMU API what it expects and any callers
> outside of the video codecs will be landed with problems when unmap
> doesn't work as expected.
>
>> This v13 has fixed the documentation so I don't plan to spend more time on this driver.
> That's a shame, I'm really not asking for much.
>
> Will
>
