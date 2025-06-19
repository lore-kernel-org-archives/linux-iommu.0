Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F463085B2
	for <iommu@lists.linux.dev>; Thu, 19 Jun 2025 16:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750350493; cv=pass; b=HFJ77Tbv51dWvDoe3ieKf8c/pHpbQKFE0BMFPE9+CEQ+6jwDKEDdhUk10+DK6NBMd/0MkDnlIEX8uzsoEp68xRCB2J/d6KGpyO7Q5JbGHUyzgAe6qv1JaJUCNvQVyaJWEMSwVkoWM/XYNYijYu5QiVbOpAamP7T4TbxMND9SXDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750350493; c=relaxed/simple;
	bh=0A5Hirrm/1Adlqdoo/cMvx+fh1eWGCy/X/w+oEcbnGc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OUd4dP+bmexreMoJADYqSyCGyUAB+wOZZWoJTLBm+iHVlqj0l5PLcsS1tStZfGGz4oWWtcqQn8L1oBgVd/KOnADkj6sprVaaSrDJBKnydtg0znGXH6/FW8UgNa39qvaqh5zyyyLVtULwmxaYxdOcvRjzuox2tOiq7rUveGo8I5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=benjamin.gaignard@collabora.com header.b=dvQ7yEn2; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=benjamin.gaignard@collabora.com header.b="dvQ7yEn2"
ARC-Seal: i=1; a=rsa-sha256; t=1750350477; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=cv7cshst83TrnjaCmvllkmN1E3sluuWfbFU/aFnHdPxoIiZ74Loz0kiUfgovvgZ9sJYPLVZZ5KaCsNfmfW/eD4viLVe3FzHDtRCrLauA6KTwCPETGX6LMA+xfQWDd/8+AjJwT6ATyCi6mJUwnB067uUd3H/aKvuOEef0p2yENNY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1750350477; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=rVGVg+OYlp1Qk6fmw5rcJaBayL/Ch3LmOzOtD7sBbTQ=; 
	b=B0fqkAYa1GChomZVAEO8hfuVtA/6ws8c7t3h8M1AMqoAjq7gj9nw2PVe8pTi9l1if57Q9V1dfbjTA8gXgrjMOPTMmc8xyQE9IgicFCC2pty4fyQcBfXe9BDZJNR/vOJ9NmbER7U2d12zDxTtQ6yfZ7H+j/HR7Z8PZQ9Skg1GPWU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=benjamin.gaignard@collabora.com;
	dmarc=pass header.from=<benjamin.gaignard@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1750350477;
	s=zohomail; d=collabora.com; i=benjamin.gaignard@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=rVGVg+OYlp1Qk6fmw5rcJaBayL/Ch3LmOzOtD7sBbTQ=;
	b=dvQ7yEn2PkcD9rwE4l1CKHMASbvPLEKc8iMdkF4UT5JFyJbQth2T7ltguaEV52P+
	w6omdqpFnEr5iFwF9Bq66ybOCsFCGpaWNv0ptKQhpWkcujvJm6vvRypW8BxGu7AXeKT
	k9M6aG032aBMEPm9XL3CX86YUj+7zt54lbzahZHM=
Received: by mx.zohomail.com with SMTPS id 1750350476585176.7450336893728;
	Thu, 19 Jun 2025 09:27:56 -0700 (PDT)
Message-ID: <073ffe14-d631-4a4f-8668-ddeb7d611448@collabora.com>
Date: Thu, 19 Jun 2025 18:27:52 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] iommu: Add verisilicon IOMMU driver
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de,
 nicolas.dufresne@collabora.com, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 kernel@collabora.com
References: <20250619131232.69208-1-benjamin.gaignard@collabora.com>
 <20250619131232.69208-4-benjamin.gaignard@collabora.com>
 <20250619134752.GB1643390@ziepe.ca>
Content-Language: en-US
From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <20250619134752.GB1643390@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Le 19/06/2025 à 15:47, Jason Gunthorpe a écrit :
> On Thu, Jun 19, 2025 at 03:12:24PM +0200, Benjamin Gaignard wrote:
>
>> +static struct iommu_domain *vsi_iommu_domain_alloc_paging(struct device *dev)
>> +{
>> +	struct vsi_iommu *iommu = vsi_iommu_get_from_dev(dev);
>> +	struct vsi_iommu_domain *vsi_domain;
>> +
>> +	vsi_domain = kzalloc(sizeof(*vsi_domain), GFP_KERNEL);
>> +	if (!vsi_domain)
>> +		return NULL;
>> +
>> +	vsi_domain->dma_dev = iommu->dev;
>> +	iommu->domain = &vsi_identity_domain;
> ?? alloc paging should not change the iommu.
>
> Probably this belongs in vsi_iommu_probe_device if the device starts
> up in an identity translation mode.

Your are right it useless here, I will remove it.

>
>> +static u32 *vsi_dte_get_page_table(struct vsi_iommu_domain *vsi_domain, dma_addr_t iova)
>> +{
>> +	u32 *page_table, *dte_addr;
>> +	u32 dte_index, dte;
>> +	phys_addr_t pt_phys;
>> +	dma_addr_t pt_dma;
>> +
>> +	assert_spin_locked(&vsi_domain->dt_lock);
>> +
>> +	dte_index = vsi_iova_dte_index(iova);
>> +	dte_addr = &vsi_domain->dt[dte_index];
>> +	dte = *dte_addr;
>> +	if (vsi_dte_is_pt_valid(dte))
>> +		goto done;
>> +
>> +	page_table = (u32 *)iommu_alloc_pages_sz(GFP_ATOMIC | GFP_DMA32, SPAGE_SIZE);
> Unnecessary casts are not the kernel style, I saw a couple others too
>
> Ugh. This ignores the gfp flags that are passed into map because you
> have to force atomic due to the spinlock that shouldn't be there :(
> This means it does not set GFP_KERNEL_ACCOUNT when required. It would
> be better to continue to use the passed in GFP flags but override them
> to atomic mode.

I will add a gfp_t parameter and use it like that:
page_table = iommu_alloc_pages_sz(gfp | GFP_ATOMIC | GFP_DMA32, SPAGE_SIZE);

>
>> +static int vsi_iommu_identity_attach(struct iommu_domain *domain,
>> +				     struct device *dev)
>> +{
>> +	struct vsi_iommu *iommu = dev_iommu_priv_get(dev);
>> +	struct vsi_iommu_domain *vsi_domain = to_vsi_domain(domain);
>> +	unsigned long flags;
>> +	int ret;
>> +
>> +	if (WARN_ON(!iommu))
>> +		return -ENODEV;
> These WARN_ON's should be removed. ops are never called by the core
> without a probed device.

ok

>
>> +static int vsi_iommu_attach_device(struct iommu_domain *domain,
>> +				   struct device *dev)
>> +{
>> +	struct vsi_iommu *iommu = dev_iommu_priv_get(dev);
>> +	struct vsi_iommu_domain *vsi_domain = to_vsi_domain(domain);
>> +	unsigned long flags;
>> +	int ret;
>> +
>> +	if (WARN_ON(!iommu))
>> +		return -ENODEV;
>> +
>> +	/* iommu already attached */
>> +	if (iommu->domain == domain)
>> +		return 0;
>> +
>> +	ret = vsi_iommu_identity_attach(&vsi_identity_domain, dev);
>> +	if (ret)
>> +		return ret;
> Hurm, this is actually quite bad, now that it is clear the HW is in an
> identity mode it is actually a security problem for VFIO to switch the
> translation to identity during attach_device. I'd really prefer new
> drivers don't make this mistake.
>
> It seems the main thing motivating this is the fact a linked list has
> only a single iommu->node so you can't attach the iommu to both the
> new/old domain and atomically update the page table base.
>
> Is it possible for the HW to do a blocking behavior? That would be an
> easy fix.. You should always be able to force this by allocating a
> shared top page table level during probe time and making it entirely
> empty while staying always in the paging mode. Maybe there is a less
> expensive way.
>
> Otherwise you probably have work more like the other drivers and
> allocate a struct for each attachment so you can have the iommu
> attached two domains during the switch over and never drop to an
> identity mode.

I will remove the switch to identity domain and it will works fine.

>
>> +	iommu->domain = domain;
>> +
>> +	spin_lock_irqsave(&vsi_domain->iommus_lock, flags);
>> +	list_add_tail(&iommu->node, &vsi_domain->iommus);
>> +	spin_unlock_irqrestore(&vsi_domain->iommus_lock, flags);
>> +
>> +	ret = pm_runtime_get_if_in_use(iommu->dev);
>> +	if (!ret || WARN_ON_ONCE(ret < 0))
>> +		return 0;
> This probably should have a comment, is the idea the resume will setup
> the domain? How does locking of iommu->domain work in that case?
>
> Maybe the suspend resume paths should be holding the group mutex..
>
>> +	ret = vsi_iommu_enable(iommu);
>> +	if (ret)
>> +		WARN_ON(vsi_iommu_identity_attach(&vsi_identity_domain, dev));
> Is this necessary though? vsi_iommu_enable failure cases don't change
> the HW, and a few lines above was an identity_attach. Just delay
> setting iommu->domain until it succeeds, and this is a simple error.

I think I will change vsi_iommu_enable() prototype to:
static int vsi_iommu_enable(struct vsi_iommu *iommu, struct iommu_domain *domain)
and do iommu->domain = domain; at the end of the function if everything goes correctly.


> iommu->domain = domain;
>
>
>> +static struct iommu_ops vsi_iommu_ops = {
>> +	.identity_domain = &vsi_identity_domain,
> Add:
>
>    .release_domain = &vsi_identity_domain,
>
> Which will cause the core code to automatically run through to
> vsi_iommu_disable() prior to calling vsi_iommu_release_device(), which
> will avoid UAF problems.
>
> Also, should the probe functions be doing some kind of validation that
> there is only one struct device attached?

which kind of validation ?

>
> Jason
