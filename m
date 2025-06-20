Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CC528DF1F
	for <iommu@lists.linux.dev>; Fri, 20 Jun 2025 14:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750430544; cv=pass; b=SRLS7+JZzgcl0O4idYLYPf6xpP0a58B0PVKVVHhGhZF0H0YXGd9pdeEDRYV5rKabBnENcdcUfB/owjkBz9kQWiTY2hMKO7CAvvuNzY6EmgS+rAxfR1Un91Y7fOuJ6pLEKW913oDTsBqyx8XnM6amE2OLisGNpSa3LAC0DA+7leo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750430544; c=relaxed/simple;
	bh=rMJu2UXBnvM9uD9OHpHx6JI8BGT6zoxThOLhRn3Aijw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=sOmylOj4SYaZg3CyBbzP28Ua21zP/+Y72ws9ew3NlWi9sFk96gkrBMv7yF6mZ023JSdSwpgzoOwhq/ciBjStJw4HnNLiiiYD4bidntXi+lc87j7hT6yElm9ekOqljk3Zwlp4XUR/oIkskUJ1lYoE2yTvVm9TFIFO1vydt6+PLjw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=benjamin.gaignard@collabora.com header.b=eeBxYF7s; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=benjamin.gaignard@collabora.com header.b="eeBxYF7s"
ARC-Seal: i=1; a=rsa-sha256; t=1750430529; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=QQdc9mPxR21z/9fW611G9vSMqf7TsDD27B7xiWMPks+eyo2+3ZeYj5m/DLkJrmt1I1HtgTB0wbFUR09QywUhWsqzCCeNf3jTYFU0eAUphFWdx0mI1regBAGCvCwPYik6HADPRbwJG6JyG2RMh5P4G2H48xH/9ehi3+ErNJwhNpo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1750430529; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=0RgeqPv/W813/uRIAYius/Svm9hUK+Z0QxNA+vZX/e0=; 
	b=BPGm4OMEh4iJHEQuXmOmQsjy79cZnAnSA3FYnTDkVEQPaUzcN4p/YDaCJhdy7KRgXUts3FztdupVCsxFYnjcvIpeS1PSwgap4qhL551ZLpPy2wI+LeeNxpxMq7ogqYm+WI3ZJiaQRDvJ6pA/YNOOjvdjWhWcUdZ9DLgMbevZ8p8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=benjamin.gaignard@collabora.com;
	dmarc=pass header.from=<benjamin.gaignard@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1750430528;
	s=zohomail; d=collabora.com; i=benjamin.gaignard@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:From:From:To:To:Cc:Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=0RgeqPv/W813/uRIAYius/Svm9hUK+Z0QxNA+vZX/e0=;
	b=eeBxYF7sktRJuUwtk9bJLpOwGIhCSnAjt9GkIFf2aMQlsB6mkNzNb9higiqQOBpw
	DngTI9DNQlNFkBjewa5cJE1lSQ/GzsYKv0XVZlpyYhyum0km3MS9mwQNZDfkydDd3M8
	FMxgGiQHKNpIfYWgVsSFYiEyW6dduLrearp1cDRI=
Received: by mx.zohomail.com with SMTPS id 1750430526349829.0777010527344;
	Fri, 20 Jun 2025 07:42:06 -0700 (PDT)
Message-ID: <3337df6c-f800-4610-8689-fbd4b4a5d07a@collabora.com>
Date: Fri, 20 Jun 2025 16:42:02 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] iommu: Add verisilicon IOMMU driver
From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
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
 <073ffe14-d631-4a4f-8668-ddeb7d611448@collabora.com>
 <20250619165928.GA10257@ziepe.ca>
 <e034a111-93eb-42e8-a533-46553b4f5588@collabora.com>
 <20250620120509.GA39770@ziepe.ca>
 <d9a1b9ab-b6ab-4364-a1b7-df4debc21bc1@collabora.com>
Content-Language: en-US
In-Reply-To: <d9a1b9ab-b6ab-4364-a1b7-df4debc21bc1@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Le 20/06/2025 à 15:52, Benjamin Gaignard a écrit :
>
> Le 20/06/2025 à 14:05, Jason Gunthorpe a écrit :
>> On Fri, Jun 20, 2025 at 10:57:49AM +0200, Benjamin Gaignard wrote:
>>> Le 19/06/2025 à 18:59, Jason Gunthorpe a écrit :
>>>> On Thu, Jun 19, 2025 at 06:27:52PM +0200, Benjamin Gaignard wrote:
>>>>> Le 19/06/2025 à 15:47, Jason Gunthorpe a écrit :
>>>>>> Ugh. This ignores the gfp flags that are passed into map because you
>>>>>> have to force atomic due to the spinlock that shouldn't be there :(
>>>>>> This means it does not set GFP_KERNEL_ACCOUNT when required. It 
>>>>>> would
>>>>>> be better to continue to use the passed in GFP flags but override 
>>>>>> them
>>>>>> to atomic mode.
>>>>> I will add a gfp_t parameter and use it like that:
>>>>> page_table = iommu_alloc_pages_sz(gfp | GFP_ATOMIC | GFP_DMA32, 
>>>>> SPAGE_SIZE);
>>>> This will or together GFP_ATOMIC and GFP_KERNEL, I don't think that
>>>> works..
>>> I have test it, I don't see conflicts or errors. What worries you ?
>> Just looking at the bitmaps I'm not sure? Did you run with lockdep?
>
> Yes and it complains about that.
> I see that sun50i driver have more less the same struct than my driver
> but doesn't use lock. I will try see if I can remove the lock.

I have replace the two spinlock by a mutex in vsi_iommu structure.
It seems it works well and lockdep doesn't complain anymore.

>
>>>>>>> +static int vsi_iommu_attach_device(struct iommu_domain *domain,
>>>>>>> +                   struct device *dev)
>>>>>>> +{
>>>>>>> +    struct vsi_iommu *iommu = dev_iommu_priv_get(dev);
>>>>>>> +    struct vsi_iommu_domain *vsi_domain = to_vsi_domain(domain);
>>>>>>> +    unsigned long flags;
>>>>>>> +    int ret;
>>>>>>> +
>>>>>>> +    if (WARN_ON(!iommu))
>>>>>>> +        return -ENODEV;
>>>>>>> +
>>>>>>> +    /* iommu already attached */
>>>>>>> +    if (iommu->domain == domain)
>>>>>>> +        return 0;
>>>>>>> +
>>>>>>> +    ret = vsi_iommu_identity_attach(&vsi_identity_domain, dev);
>>>>>>> +    if (ret)
>>>>>>> +        return ret;
>>>>>> Hurm, this is actually quite bad, now that it is clear the HW is 
>>>>>> in an
>>>>>> identity mode it is actually a security problem for VFIO to 
>>>>>> switch the
>>>>>> translation to identity during attach_device. I'd really prefer new
>>>>>> drivers don't make this mistake.
>>>>>>
>>>>>> It seems the main thing motivating this is the fact a linked list 
>>>>>> has
>>>>>> only a single iommu->node so you can't attach the iommu to both the
>>>>>> new/old domain and atomically update the page table base.
>>>>>>
>>>>>> Is it possible for the HW to do a blocking behavior? That would 
>>>>>> be an
>>>>>> easy fix.. You should always be able to force this by allocating a
>>>>>> shared top page table level during probe time and making it entirely
>>>>>> empty while staying always in the paging mode. Maybe there is a less
>>>>>> expensive way.
>>>>>>
>>>>>> Otherwise you probably have work more like the other drivers and
>>>>>> allocate a struct for each attachment so you can have the iommu
>>>>>> attached two domains during the switch over and never drop to an
>>>>>> identity mode.
>>>>> I will remove the switch to identity domain and it will works fine.
>>>> You'll loose invalidations..
>>>>
>>>> Maybe the easiest thing is to squish vsi_iommu_enable() and reorganize
>>>> it so that the spinlock is held across the register programming and
>>>> then you can atomically under the lock change the registers and change
>>>> the linked list. The register write cannot fail so this is fine.
>>>>
>>>> This should probably also flush the iotlb inside the lock.
>>> I will try to summarize:
>>> in vsi_iommu_attach_device() I should:
>>> - take the lock
>>> - do nothing if the domain is the same.
>>> - if iommu is used (ie powered up):
>>>    - update the registers to enable the iommu
>>>    - flush
>>>    - update the link list
>>> - update iommu->domain
>>> - release the lock
>> That sounds believable, yes.. Though can you do the "powered up" checks
>> inside the spinlock - are they sleeping? Can they be done before the
>> spinlock?
>>
>>> in vsi_iommu_identity_attach() I should:
>>> - take the lock
>>> - do nothing if the domain is the same.
>>> - if iommu is used (ie powered up):
>>>    - disable the iommu
>>>    - remove the node from the list
>>> - update iommu->domain
>>> - release the lock
>> And maybe flush too? How does the caching hw work at this point? You
>> can't have stale entries in the cache when you switch back to an
>> enabled/translating configuration. So either the HW flushes implicitly
>> or you need to add a flush somewhere..
>
> I do not have the documentation for the hardware but it seems that
> enable/disable are enough to do the job.
>
>
>>> vsi_iommu_suspend() and vsi_iommu_resume() will also have to take 
>>> the lock
>>> before calling vsi_iommu_disable() and vsi_iommu_enable().
>> Yes, if they use iommu->domain that seems good
>>
>> If the above locking is a problem then I'd use the group mutex instead
>> during resume/suspend. The attach functions are already called with
>> the group mutex held.
>
> Does group mutex is also called when using vsi_iommu_map or 
> vsi_iommu_unmap ?
>
>>
>>> Do I have to switch to identity domain in vsi_iommu_attach_device()
>>> before applying the requested domain ?
>> No, that is what creates the security problem. What you want is to
>> update the HW registers in a way that the HW just changes hitlessly
>> from one translation to another, then flush the cache.
>>
>> Jason
