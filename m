Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB47B28B7E1
	for <iommu@lists.linux.dev>; Thu, 10 Jul 2025 08:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752136006; cv=pass; b=ms2eylc731TImE9fWt3500IqVj87gRPvAmdMLUCg6y5zFkl5lEe4YiMnuIpwykrWX2BffRvNx4CmYaMrn6y29osNjUGyblc3QI4PH8uj2680/PMscHR9egBp3JYr4SycIwOwd1SQ5s/i4HTzwVSsM8AFq//9CuOZYImj4NYEhCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752136006; c=relaxed/simple;
	bh=lbeUnTq/B7snjcaJQidorTDMiThcF1mq0FCi/lYJKuQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qqqv1kSOiwGcmvRz3C+GLyNX4WfFIBe0Tb50eFaq6UZpmWujVnUtAscgwldlwp0ZTH9RwDQV2enINLM9FsPju3sVNjTBxz6xtedrUaAqMyvdQH261Ni42je/thRL4DIiEzmw9RQ3J1vYunPfkMBe04AS59dle63JAknI2do8hIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=benjamin.gaignard@collabora.com header.b=SxXMR1Oi; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=benjamin.gaignard@collabora.com header.b="SxXMR1Oi"
ARC-Seal: i=1; a=rsa-sha256; t=1752135991; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=UIVN/T8EgEA8ZWRjjnBLTVntc+IxhfMD6aHGUKeTQA/zAkWRha78G3UIhtJBF//0ZfU3UWy6WaTFa4uTCQU7+GQz42g5/fWmVMb0jC0f7Y1nsnOQkT6rZ6jJKnxJqdC49jJH0yKPlK9Xg9X1Zw4bPy0BlZLkUkWbbWA1frJS6QU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1752135991; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=E84MMCBx0xpgoES+NnhMP12vSRnynaQmVJ5b2UIKw+U=; 
	b=JNywPzIAPiI4UaBnIxo40F7/q6agriArIReObqRi0c8C9xz8hej1juBMEARZ4TcOcJSt5OShK4lFRoDjol74+qfMS4ljVFNcxJCGsfy5WMnOjcDoXPlBD3qPc5xGi8Qbf43habnd6zlVucM+pPmE70MWnBKDej459OMr7XmA89k=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=benjamin.gaignard@collabora.com;
	dmarc=pass header.from=<benjamin.gaignard@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752135991;
	s=zohomail; d=collabora.com; i=benjamin.gaignard@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=E84MMCBx0xpgoES+NnhMP12vSRnynaQmVJ5b2UIKw+U=;
	b=SxXMR1Oij/dhJgr72YZNsBIf4bcHJllEF32lheb7Utsm0k/TWQ3ktodpS6VK9SXf
	mvpvDjhX4Jawd8e++ylmEVlybocCRm6Erb3iu3aTeM0YB8sOMlF9HhldjWbAW+5xFTy
	Tip3nmb/EOq2mFGzBYGMFm5qVzWLnphv2pFm/LS4=
Received: by mx.zohomail.com with SMTPS id 1752135988944558.2751903621047;
	Thu, 10 Jul 2025 01:26:28 -0700 (PDT)
Message-ID: <2759380e-51a5-4437-8caa-0039ccd79559@collabora.com>
Date: Thu, 10 Jul 2025 10:26:24 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/5] iommu: Add verisilicon IOMMU driver
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de,
 nicolas.dufresne@collabora.com, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 kernel@collabora.com
References: <20250709085337.53697-1-benjamin.gaignard@collabora.com>
 <20250709085337.53697-4-benjamin.gaignard@collabora.com>
 <20250709164533.GA1759573@ziepe.ca>
Content-Language: en-US
From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <20250709164533.GA1759573@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Le 09/07/2025 à 18:45, Jason Gunthorpe a écrit :
> On Wed, Jul 09, 2025 at 10:53:28AM +0200, Benjamin Gaignard wrote:
>> +static int vsi_iommu_attach_device(struct iommu_domain *domain,
>> +				   struct device *dev)
>> +{
>> +	struct vsi_iommu *iommu = dev_iommu_priv_get(dev);
>> +	struct vsi_iommu_domain *vsi_domain = to_vsi_domain(domain);
>> +	unsigned long flags;
>> +	int ret = 0;
>> +
>> +	ret = pm_runtime_resume_and_get(iommu->dev);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	spin_lock_irqsave(&iommu->lock, flags);
>> +	/* iommu already attached */
>> +	if (iommu->domain == domain)
>> +		goto unlock;
>> +
>> +	vsi_iommu_enable(iommu, domain);
>> +	list_add_tail(&iommu->node, &vsi_domain->iommus);
>> +	iommu->domain = domain;
>> +
>> +unlock:
>> +	spin_unlock_irqrestore(&iommu->lock, flags);
>> +	pm_runtime_put_autosuspend(iommu->dev);
>> +	return ret;
> I thought this was mentioned before, but this doesn't handle
> attach_device being called twice without an identity attach in
> between.
>
> And now the new locking doesn't protect concurrent invalidation races,
> the lock is in the wrong place.
>
> hold the domain lock across the whole sequence to hold off any
> invalidation until the linked list is consistent with the HW
> programming:
>
>   spin_lock_irqsave(&vsi_domain->lock, flags2); // Prevent invalidation
>
>   vsi_iommu_enable(iommu, domain);
>   list_del(&iommu->node);
>   list_add_tail(&iommu->node, &vsi_domain->iommus);
>
>   spin_unlock_irqrestore(&vsi_domain->lock, flags);
>
> Then remove this:
>
>   +	/* iommu already attached */
>   +	if (iommu->domain == domain)
>   +		goto unlock;
>
> Since the fix above makes it safe regardless.
>
> And, also feels like again, but vsi_iommu_enable() needs to fully
> flush the cache since the translation is being changed, shouldn't
> there also be writes to VSI_MMU_FLUSH_BASE ?
>
> Otherwise the locking change looks OK and I don't have other comments.

I have fix that in v6.

Thanks a lot for your review.

Benjamin

>
> Jason
