Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC523382D3
	for <iommu@lists.linux.dev>; Wed, 21 Jan 2026 13:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769003438; cv=pass; b=naDUa4eQf0m1O+or7H5i/nMXgkLnS3XcY7ounzTv/FxzN+sT97NgENHxAAAvXHl/RDnxZATjztQDuIO+Y1j+sKM2W6W3pbIwlKGz8g73vnECfOoF9el/z3lR2FMyggd/GJxACjKHzuwUqKIlCwnQvQtTrPJO3gMw8feem0Eria4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769003438; c=relaxed/simple;
	bh=8KNoVv3pnxVsTo8YM0cJ0lrpeTXSxWfU7j81uJZx/D4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DE2OfTiGBBSiXeGZyDEFMDtFp8lTHZ1l50FlUcb5eIJE++w5cQRd9/YYZOs1xukQjYRZV8X7nMMLDk0zNAdUwggS8MpGu7ukJ+9NFBFYyiZXHdbqJX7Fhft7KGTmwOXvG1HOrYowYwmE+pg9uiVcdbPwiEsrbLffZRZlglcB+Ag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=benjamin.gaignard@collabora.com header.b=FgHTyAym; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=benjamin.gaignard@collabora.com header.b="FgHTyAym"
ARC-Seal: i=1; a=rsa-sha256; t=1769003425; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=oMD3DvxuLuEzLSKEQ+n7wJ4m/xJbJL42ySs6VOCov2+etqD4CgyPmKR8dkzx4g41ouAyqQO62NoJmbCaOtROJc7sd0f6R40oSBIx78qL6ybgkLBuv2rDFMaO/5EhdG55m8UuI97tr7tzCiQJSiJ39lWOQviRPlrDP3vbU1zyLJM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1769003425; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=9j0aEnPsFf4ht23DVuEjYMMqdJpKWzWkgwC3q2GqT3A=; 
	b=AbgOsVL6Ef6WBq9f5iily7oU2CPu1sGMgiO0qjOsCI5xkur+8tRusuPAKEHZUEZ3V2aO1UJnSxkwDDRRNxoSiDYCwg7T835rgSWb67ZqHx9iJM1AxWy6Cv+DWVpo8cmOYYzFz3NM0AiKfr7u4ZoWj6luSFuJlyp8HjLuMnUGV10=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=benjamin.gaignard@collabora.com;
	dmarc=pass header.from=<benjamin.gaignard@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1769003425;
	s=zohomail; d=collabora.com; i=benjamin.gaignard@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=9j0aEnPsFf4ht23DVuEjYMMqdJpKWzWkgwC3q2GqT3A=;
	b=FgHTyAymulI5Ru9lYKyZMIbtyQLW1up5yzp5g/XMCPX5Snig5KqTiaTFvUb2GMG7
	AWA2tt6krbxfxurKZ0M2qTryuy+IwA/fgwMmdmw+uDE94mfzKFW4cGkVOfXbRGgfVsh
	qlJrHcSEgf5HEUGrk7+QkMbz0DL7z037nqsloBQM=
Received: by mx.zohomail.com with SMTPS id 1769003423843237.2758502026851;
	Wed, 21 Jan 2026 05:50:23 -0800 (PST)
Message-ID: <4b33b50f-f0c3-4db8-b394-dd2d4d6e3a55@collabora.com>
Date: Wed, 21 Jan 2026 14:50:18 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 3/7] iommu: Add verisilicon IOMMU driver
To: Will Deacon <will@kernel.org>
Cc: joro@8bytes.org, robin.murphy@arm.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de,
 nicolas.dufresne@collabora.com, p.zabel@pengutronix.de, mchehab@kernel.org,
 iommu@lists.linux.dev, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-media@vger.kernel.org,
 kernel@collabora.com
References: <20260107101005.84039-1-benjamin.gaignard@collabora.com>
 <20260107101005.84039-4-benjamin.gaignard@collabora.com>
 <aWZui-rn5RDPwpEO@willie-the-truck>
 <68a49f8b-178c-4fa2-b4a9-315ad602271d@collabora.com>
 <aWeTQ50DOtntcniN@willie-the-truck>
 <db0950f1-b357-47c2-9829-e33262ab456d@collabora.com>
 <aW4kb5EbxbrhTOxK@willie-the-truck>
 <b8f43fe8-3e07-4d98-a50d-817c31370710@collabora.com>
 <aXDL2JH_4RCDmAJv@willie-the-truck>
Content-Language: en-US
From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <aXDL2JH_4RCDmAJv@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Le 21/01/2026 à 13:51, Will Deacon a écrit :
> On Mon, Jan 19, 2026 at 03:03:44PM +0100, Benjamin Gaignard wrote:
>>>>>>>> +static const struct iommu_ops vsi_iommu_ops = {
>>>>>>>> +	.identity_domain = &vsi_identity_domain,
>>>>>>>> +	.release_domain = &vsi_identity_domain,
>>>>>>>> +	.domain_alloc_paging = vsi_iommu_domain_alloc_paging,
>>>>>>>> +	.of_xlate = vsi_iommu_of_xlate,
>>>>>>>> +	.probe_device = vsi_iommu_probe_device,
>>>>>>>> +	.release_device = vsi_iommu_release_device,
>>>>>>>> +	.device_group = generic_single_device_group,
>>>>>>>> +	.owner = THIS_MODULE,
>>>>>>>> +	.default_domain_ops = &(const struct iommu_domain_ops) {
>>>>>>>> +		.attach_dev		= vsi_iommu_attach_device,
>>>>>>>> +		.map_pages		= vsi_iommu_map,
>>>>>>>> +		.unmap_pages		= vsi_iommu_unmap,
>>>>>>>> +		.flush_iotlb_all	= vsi_iommu_flush_tlb_all,
>>>>>>> This has no callers and so your unmap routine appears to be broken.
>>>>>> It is a leftover of previous attempt to allow video decoder to clean/flush
>>>>>> the iommu by using a function from the API.
>>>>>> Now it is using vsi_iommu_restore_ctx().
>>>>>> I while remove it in version 12.
>>>>> Don't you still need some invalidation on the unmap path?
>>>> In vsi_iommu_unmap_iova() page is invalided by calling vsi_mk_pte_invalid().
>>> But that just writes an invalid descriptor and doesn't appear to invalidate
>>> the TLB at all.
>>>
>>>> That clear BIT(0) so the hardware knows the page is invalid.
>>>> Do I have miss something here ?
>>> Yes, the TLB structure needs to be invalidated so that the page-table
>>> walker sees the new value that you have written in memory.
>>>
>>> The rockchip driver gets this correct...
>> Rockchip hardware have a ZAP_ONE_LINE register which didn't exist on Verisilicon
>> hardware.
> Presumably you have some sort of Verisilicon datasheet or downstream driver
> from which you can infer the TLB invalidation runes?

I have only this downstream driver:
https://github.com/rockchip-linux/kernel/blob/develop-6.1/drivers/iommu/rockchip-iommu-av1d.c
No datasheet...

>
>> I have tried to use VSI_MMU_BIT_FLUSH on VSI driver after unmapping iova
>> but it doesn't work.
> What do you mean by "doesn't work"? If it works without doing any
> invalidation at all, then it's very peculiar that adding the invalidation
> would introduce issues.

I mean VSI_MMU_BIT_FLUSH register can't be used to invalid the TLB.
I think the hardware iterates over the pages tables in memory and
check the valid/invalid bit.

Benjamin

>
>> So far calling dma_sync_single_for_device() seems to be enough to make iommu
>> and video decoder work together.
> I don't think we should settle for "seems to enough"! If we can reason
> about the operation of the hardware then the driver will be undebuggable
> when it eventually goes wrong.
>
> Will
>
