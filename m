Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF29D1B4257
	for <iommu@lists.linux.dev>; Wed, 29 Jan 2025 12:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738152675; cv=none; b=MMUwhE0s+bNxNSuk9/HMaYL0oZJpGt43JroUCYg27+8MLdawowwocszlAU2xz72cAjr5KSb0wIqNksTr7d1DgbhQyF+ouS32m3+MO4u4CSkYP/qj8e3OXWNQF4mSj3tbaovJ4U9pqvnHjv4XWaYPXtQQCxwnez+Y1kuun2Ek7ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738152675; c=relaxed/simple;
	bh=6IdA7SqmTNXeAUkejuPdnOPZIQXSzN75bEY9k/EhdgA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LOuoBhpOLW3SS+wpuNfLPvjGHZjy/hOKY7trMkYHo0VLA/uOkXi0K4l328v1p0N5Y6u4g+gr/FtL9un7rM0FimblsWJh0YtFjI25MsnGGl7KFDt0EFSV4Bi35VHIsDArRXxwjtV206kfDM5okZGnhtBEhOTciERx+0TA+XKuzxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ir5WDZu1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ir5WDZu1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738152671;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FfYT43qInjD7+NE+73mPjG28PGMRFzMEZ6xoue/ST5Q=;
	b=ir5WDZu1E2XC2kFyD1y6DjnX5k67KU3J8HPHwoYg9O0jwLQLkp82fskNYFQix6sE7wHUoV
	sDiZKCbdY5WdLxxKjTF5+Rhk4qwAL72yswApb7hYz957UEo7omf5N1OY11sGnG12p+H2CM
	Rr/NMfqN2eVhoS5vMYbW3K3A/W0iEVM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-vnOl-gSbNO6RZ082aIPUQg-1; Wed, 29 Jan 2025 07:11:10 -0500
X-MC-Unique: vnOl-gSbNO6RZ082aIPUQg-1
X-Mimecast-MFC-AGG-ID: vnOl-gSbNO6RZ082aIPUQg
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5da0ce0ee51so5909467a12.2
        for <iommu@lists.linux.dev>; Wed, 29 Jan 2025 04:11:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738152669; x=1738757469;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FfYT43qInjD7+NE+73mPjG28PGMRFzMEZ6xoue/ST5Q=;
        b=HlIN9Fk13ESr5NgzDqQAwvDIDeH5c5UK+pyHgrfZX2XO6fHtJvUxt0NAuJwBdmtA0r
         wMVNM/CvA/RKpYslJDMzmD+9PUJ/ps6c+3C6vr6EOv1Z1HH8iCX2q0gJWIW7vNE28mGr
         IM9sWIqhCoMIZPqc8ZFFbX/rE/ywwMByot/fofRQukgu7e4LPbF2bdNWKxDxRidwAGNr
         ea0oJI30KCv2+XsrLtbC9HgOI/nar9zK9Gj7f7pmPuMhtxaO7CHLlk1hc7gtfb/UUCc+
         B/L6tYuh+rKEd22z3STbfnnt/Vlxn+sx1M8nn3S16Inem2XikMohi3q4fxv30GYHV+Kz
         3S0A==
X-Forwarded-Encrypted: i=1; AJvYcCUp+FxypaCwKXM7roGMXuI4omfpmWLSiy0tKdapTeq6Eh16pbdBo+vYSSKdaic+L0hiAzIpng==@lists.linux.dev
X-Gm-Message-State: AOJu0YwwaBI81XUpLLDxNxY4+Ubj2DpjdkVtjl12rt3D2pvDXKpN1Llb
	5ePzFlzNGhQ4pL+S0ZGPrqCK27PVpHRYSmJ/H1YGRWBNWBGGULMCdgMFsExq8ZEInpLrFmbyd9r
	hiVN91Z5gHVPdO5z6grKUHIgedvl+rCmISAsn1SNFITS5O7X226zw
X-Gm-Gg: ASbGncuUMkdGETkt18rikUJ9W7C3cjbasjWMMZvVSG8ukG+YAank1h3Ak+7RG3x37xq
	GLJofgQn1NmWOkjcc0C2vUA7yQ795As19Em5rgzBJu4gRDc47rLB0apkmiMBUw8w3j7cbSAsExL
	7p9gmYOMXkwKUbI8qwYUPNcygFIop9moXaaEfQRiXLo/W/vZQ00yFt1Re2baf399J82Gm0gZeA1
	pRu9T1WV1HOHVPlLEgZdVR/P/1yLiXNhQgecekkIad9fm748Qem1TXM1H7YdIwgQpbs032EzSk+
	6HFOIAw98P310PRGugRg+82c5mJziji5qtWxq0Z3soQEpnVffpCM
X-Received: by 2002:a05:6402:42d4:b0:5d9:a54:f8b4 with SMTP id 4fb4d7f45d1cf-5dc5efbf5bamr2757086a12.11.1738152669154;
        Wed, 29 Jan 2025 04:11:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHWwGofFlveJZZ8Y8RCQ261keTvS+w2IGgafzQLJiEPoI+LUqDstLACEsFV9aVwDeaatRYmZg==
X-Received: by 2002:a05:6402:42d4:b0:5d9:a54:f8b4 with SMTP id 4fb4d7f45d1cf-5dc5efbf5bamr2757022a12.11.1738152668668;
        Wed, 29 Jan 2025 04:11:08 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dc1863978asm8680072a12.33.2025.01.29.04.11.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2025 04:11:06 -0800 (PST)
Message-ID: <38896dfc-b5d9-4efd-8aff-bbe8cdb47c6e@redhat.com>
Date: Wed, 29 Jan 2025 13:11:03 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH RFCv2 01/13] genirq/msi: Store the IOMMU IOVA directly in
 msi_desc instead of iommu_cookie
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
 <671b2128c193fc9ac9af0f4add96f85a785f513a.1736550979.git.nicolinc@nvidia.com>
 <1b48e138-3134-442a-9796-e3a33b106221@redhat.com>
 <20250123184855.GU5556@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250123184855.GU5556@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7YS88p6hyfLqTddJdAlEH0nByMiOlP4hJ1LXNK1RCvY_1738152669
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,


On 1/23/25 7:48 PM, Jason Gunthorpe wrote:
> On Thu, Jan 23, 2025 at 06:10:48PM +0100, Eric Auger wrote:
>
>>> However iommufd now permits the domain to change while the driver is
>>> probed and VFIO userspace can create races with IRQ changes calling
>>> iommu_dma_prepare/compose_msi_msg() and changing/freeing the iommu_domain.
>> and is it safe in iommu_dma_prepare_msi()?
> iommu_dma_prepare_msi() takes the group mutex:
>
> int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr)
> {
> 	struct device *dev = msi_desc_to_dev(desc);
> 	struct iommu_group *group = dev->iommu_group;
>
> 	mutex_lock(&group->mutex);
> 	if (group->domain && group->domain->sw_msi)
> 		ret = group->domain->sw_msi(group->domain, desc, msi_addr);
>
> Which prevents changing domain attachments during execution.
>
> For iommufd, if the domain attachment changes immediately after
> iommu_dma_prepare_msi() unlocks, then the information given to
> msi_desc_set_iommu_msi_iova() is still valid on the new domain.
>
> This is because the iommufd implementation of sw_msi keeps the same
> IOVA for the same ITS page globally across all domains. Any racing
> change of domain will attach a new domain with the right ITS IOVA
> already mapped and populated.
> It is why this series stops using the domain pointer as a cookie
> inside the msi_desc, immediately after the group->mutex is unlocked
> a new domain can be attached and the old domain can be freed, which
> would UAF the domain pointer in the cookie.
OK thank you for the clarification
>
>>> diff --git a/include/linux/msi.h b/include/linux/msi.h
>>> index b10093c4d00e..d442b4a69d56 100644
>>> --- a/include/linux/msi.h
>>> +++ b/include/linux/msi.h
>>> @@ -184,7 +184,8 @@ struct msi_desc {
>>>  	struct msi_msg			msg;
>>>  	struct irq_affinity_desc	*affinity;
>>>  #ifdef CONFIG_IRQ_MSI_IOMMU
>>> -	const void			*iommu_cookie;
>> you may add kernel doc comments above
> I wondered if internal stuff was not being documented as the old
> iommu_cookie didn't have a comment..
>
> But sure:
>
>  * @iommu_msi_iova: Optional IOVA from the IOMMU to overide the msi_addr.
>  *                  Only used if iommu_msi_page_shift != 0
>  * @iommu_msi_page_shift: Indicates how many bits of the original address
>  *                        should be preserved when using iommu_msi_iova.
Sounds good

Eric
>
> Jason
>

