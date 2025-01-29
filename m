Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98871D8E10
	for <iommu@lists.linux.dev>; Wed, 29 Jan 2025 12:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738153760; cv=none; b=IsPyTVqJYNbT5r6WBc6jC5rsH9B7Y+npn+6TC3XP+ufvYPxEgKYzDB+ft8HCma4vP8vP0Zq2j9b1yvaS0wTbJxqBCiwScaDzAshbZinlKsiOfmIXrc5T5Cxfo8xKyQqHDbs5IdzL6ICqI0OfRe0OmDwWdGKXnureutj4mbdwr+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738153760; c=relaxed/simple;
	bh=aGlAAuEIVLY1trq7D4Y9/0tyfynruVWNn7IwhthU0vc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F2dzjTDp2mwVjiJAXF4ClhJKWIYPUtaHIwM3UZII26lbFOHq9KgA/ykg6pfcbA5dtWmRH/mEqn2rm2QGQOSYdfJjOFFRaMYCq6uQwP1vY4Xw0dFWo3viT5WpA+MGDr98v5SqgzgCFzicZkDCRiab2MY8t/Ay+kzqEoaGIAk3Mjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EGV4Qk8e; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EGV4Qk8e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738153756;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z2rZzWmBPUWvjcNF+Tp2W7jWB2lbA7lN2MnSH0V5dqM=;
	b=EGV4Qk8ehTO8IFvb0O0pkB81nogWzMaZkdxmm0XPSBSxZXk9ceZFp4rHBSwOc9NSfrCvkW
	adM6Z4dZ5q3kEDHkG1QWFe6woBB5wQoEuhG7Ku5Ts5hpzc0Z39bmvYTf9ednnAN7VCeHrY
	4SiqWmQ87YJJlnZlKCfNLHktetU/4OM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-FsiiUciyOtSpDt3z86jiVg-1; Wed, 29 Jan 2025 07:29:15 -0500
X-MC-Unique: FsiiUciyOtSpDt3z86jiVg-1
X-Mimecast-MFC-AGG-ID: FsiiUciyOtSpDt3z86jiVg
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-385d80576abso4100048f8f.3
        for <iommu@lists.linux.dev>; Wed, 29 Jan 2025 04:29:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738153754; x=1738758554;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z2rZzWmBPUWvjcNF+Tp2W7jWB2lbA7lN2MnSH0V5dqM=;
        b=BB+GMSKZ840+W0Ty5mwr/J75EdJyA4kWGRMTfkCAa2vh8CjvdPHfDdvwEzDwB0BdIr
         /AEblYhgfvpXckJblQbyK2ORHQPlmNyRpVOPQf/izhiZ7SpeF9Sjk29o3A9k2NRMnmen
         cI9wboF/7IKEOWf7J5uAvjJFWn1VYuVdu1Nys6qhhuk4JOSDG0gpkVkVsI9Hi/AkfWw/
         xA/2h2RaTLtYY716ekgCd7UFmcyuO04YbunfXTyNjILmYylLZWFrbiT4O8zDAen6G3cU
         PXs+kO6OIVGz8LU3mj56JV6ixDQo/csjksnqD4gFMfGjvLl2XRv8DHl3m6mwDfhquEvv
         s+Jg==
X-Forwarded-Encrypted: i=1; AJvYcCVQAieEEyYRoYTwkTJ9g8IIPk7Sw9qWTgs7Bm3wa1Edy8Wk2DGTKqe5YYy2kydrgZHTLmWHVg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxjR88qv1ExNVS9lnJMepVzIy1GopPQoy1XaKjLTQ435lneEBMl
	cKFsGNgoWVQcMa4b4ew/JnT9cFG7iiCxCnGkHt186b4ylMj1HtDnKa6cMyEl4kcxtb0EpvlT3rA
	kxAW8H697cIXI50/+6p0AEZAIibCc+V/HzbiwpaGbMlair2q9EWlz
X-Gm-Gg: ASbGncvFxND7SpPdyTq2wlBqvCex6E/sJdse8I1DjgIEUWyzP7G0is/kuWUH4x/enNd
	v7YZ5yDVcfTjFRgJDEUhf/t3KH+wP6N/iKHeVJsYFhvFdDpExj0fuATIoFaYg+ZCMP+iJ1dY5+E
	2Xhy1fVPm+Sr8roGheRPkvsHheH88RL4bsmG7CFA80PePeZiwR3gNF12aJjysq0VpAGUjxVHrYt
	xD5lMFU2wMsbK86UI6oyB7KRrASaX+JgGhV5G4hgOULahWxjjDPF03WTn5GHNr63Ih1EtmAgjI+
	CSW1FTxZ5fvl6AWpaIszaNwchWeck617xyRflRptXegpCqen+yRA
X-Received: by 2002:a05:6000:2a6:b0:38c:2745:2df3 with SMTP id ffacd0b85a97d-38c51e95dc8mr2661455f8f.37.1738153754456;
        Wed, 29 Jan 2025 04:29:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEd8a98Fk4FsyLzo/fsw4POBiKHb+ykWAZ+mPPkOyJLd/auzYk5opYB2Di0YY/K4rHi8Qvhrw==
X-Received: by 2002:a05:6000:2a6:b0:38c:2745:2df3 with SMTP id ffacd0b85a97d-38c51e95dc8mr2661397f8f.37.1738153754034;
        Wed, 29 Jan 2025 04:29:14 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438d7aa296esm34288705e9.1.2025.01.29.04.29.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2025 04:29:13 -0800 (PST)
Message-ID: <94a6414e-d047-41c7-b740-4b57fae0ebbb@redhat.com>
Date: Wed, 29 Jan 2025 13:29:10 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH RFCv2 03/13] iommu: Make iommu_dma_prepare_msi() into a
 generic operation
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org,
 robin.murphy@arm.com, kevin.tian@intel.com, tglx@linutronix.de,
 maz@kernel.org, alex.williamson@redhat.com, joro@8bytes.org,
 shuah@kernel.org, reinette.chatre@intel.com, yebin10@huawei.com,
 apatel@ventanamicro.com, shivamurthy.shastri@linutronix.de,
 bhelgaas@google.com, anna-maria@linutronix.de, yury.norov@gmail.com,
 nipun.gupta@amd.com, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, patches@lists.linux.dev,
 jean-philippe@linaro.org, mdf@kernel.org, mshavit@google.com,
 shameerali.kolothum.thodi@huawei.com, smostafa@google.com, ddutile@redhat.com
References: <cover.1736550979.git.nicolinc@nvidia.com>
 <9914f9e6b32d49f74ace2200fd50583def9f15f6.1736550979.git.nicolinc@nvidia.com>
 <787fd89b-fbc0-4fd5-a1af-63dfddf13435@redhat.com>
 <20250123181657.GT5556@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250123181657.GT5556@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _Or9wfjv7WthmD-j78sT3QAC3EBH92qR1R86eNKhkAw_1738153754
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jason,


On 1/23/25 7:16 PM, Jason Gunthorpe wrote:
> On Thu, Jan 23, 2025 at 06:10:47PM +0100, Eric Auger wrote:
>> Hi,
>>
>>
>> On 1/11/25 4:32 AM, Nicolin Chen wrote:
>>> From: Jason Gunthorpe <jgg@nvidia.com>
>>>
>>> SW_MSI supports IOMMU to translate an MSI message before the MSI message
>>> is delivered to the interrupt controller. On such systems the iommu_domain
>>> must have a translation for the MSI message for interrupts to work.
>>>
>>> The IRQ subsystem will call into IOMMU to request that a physical page be
>>> setup to receive MSI message, and the IOMMU then sets an IOVA that maps to
>>> that physical page. Ultimately the IOVA is programmed into the device via
>>> the msi_msg.
>>>
>>> Generalize this to allow the iommu_domain owner to provide its own
>>> implementation of this mapping. Add a function pointer to struct
>>> iommu_domain to allow the domain owner to provide an implementation.
>>>
>>> Have dma-iommu supply its implementation for IOMMU_DOMAIN_DMA types during
>>> the iommu_get_dma_cookie() path. For IOMMU_DOMAIN_UNMANAGED types used by
>>> VFIO (and iommufd for now), have the same iommu_dma_sw_msi set as well in
>>> the iommu_get_msi_cookie() path.
>>>
>>> Hold the group mutex while in iommu_dma_prepare_msi() to ensure the domain
>>> doesn't change or become freed while running. Races with IRQ operations
>>> from VFIO and domain changes from iommufd are possible here.
>> this was my question in previous comments
> Ah, well there is the answer :)
>
>>> Rreplace the msi_prepare_lock with a lockdep assertion for the group mutex
>> Replace
>>> as documentation. For the dma_iommu.c each iommu_domain unique to a
>> is?
>>> group.
> Yes
>
> Replace the msi_prepare_lock with a lockdep assertion for the group mutex
> as documentation. For the dmau_iommu.c each iommu_domain is unique to a
> group.
>
>>> @@ -443,6 +449,9 @@ void iommu_put_dma_cookie(struct iommu_domain *domain)
>>>  	struct iommu_dma_cookie *cookie = domain->iova_cookie;
>>>  	struct iommu_dma_msi_page *msi, *tmp;
>>>  
>>> +	if (domain->sw_msi != iommu_dma_sw_msi)
>>> +		return;
>>> +
>> I don't get the above check.
> It is because of this:
>
> void iommu_domain_free(struct iommu_domain *domain)
> {
> 	if (domain->type == IOMMU_DOMAIN_SVA)
> 		mmdrop(domain->mm);
> 	iommu_put_dma_cookie(domain);
>
> iommufd may be using domain->sw_msi so iommu_put_dma_cookie() needs to
> be a NOP. Also, later we move cookie into a union so it is not
> reliably NULL anymore.
OK
>
>> The comment says this is also called for a
>> cookie prepared with iommu_get_dma_cookie(). Don't you need to do some
>> cleanup for this latter?
> That seems seems OK, only two places set domain->iova_cookie:
>
> int iommu_get_dma_cookie(struct iommu_domain *domain)
> {
> 	domain->iova_cookie = cookie_alloc(IOMMU_DMA_IOVA_COOKIE);
> 	iommu_domain_set_sw_msi(domain, iommu_dma_sw_msi);
>
> and
>
> int iommu_get_msi_cookie(struct iommu_domain *domain, dma_addr_t base)
> {
> 	domain->iova_cookie = cookie;
> 	iommu_domain_set_sw_msi(domain, iommu_dma_sw_msi);
>
> So (domain->sw_msi == iommu_dma_sw_msi) in iommu_put_dma_cookie() for
> both cases..
makes sense.

Thanks

Eric
>
> Jason
>

