Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7322746B
	for <iommu@lists.linux.dev>; Mon, 27 Nov 2023 17:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GFt8tGj/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701107488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aer8fJjQ+wrrXZRz8cD/oMQGc4UteK4s0NzIKeWzWIQ=;
	b=GFt8tGj/Sdc1UuVAfllnJyVo5koniqzcaPgResrC9UvemzPe9aVC7XPgVN1oGWyRm6IqR9
	AsdS9+jcDkwMqApcfRGSb3lzF8CdJhdwhITubv20CvNdmaIwYf+EQ6dNmAksC2S7L4CZb+
	qDXYADPKSXHKe7eLyDAC5vvwRqWaA7s=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-quJfTlIPO_SYs6MG9KhsTw-1; Mon, 27 Nov 2023 12:51:27 -0500
X-MC-Unique: quJfTlIPO_SYs6MG9KhsTw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40b2977d6baso26218995e9.2
        for <iommu@lists.linux.dev>; Mon, 27 Nov 2023 09:51:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701107486; x=1701712286;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aer8fJjQ+wrrXZRz8cD/oMQGc4UteK4s0NzIKeWzWIQ=;
        b=AeKgtrMLXab7FzlFphrgoTbc83b4M/icO7gPu52rUhtm8MNXkDZLc7Vf/8Or1s+aJr
         tvPmHCJUYAPrEl/ycpjgrMoZalohktdg1DL7DWelcO+6nuSJGbCMY9UXrn/D3II6RJZA
         CH7w/vPoismbbDbvFa32ZmK0T+zVK1zROmBv55lFyVdcfADPmQp/7dypbZdoVbzMQb/o
         qjX4ilKsd92TEQ0oFchAVc7UhyP+2fP1IXxIdt6LA1bZ8vHWk6UIBf+ye3XSesQ6PEE/
         Z/Fm0+xff64vc9S/257/XOVMSG+AkIxDhB5CTKzPpW3zQrsE+eQ8Kkunjp2jm7ZDVRCa
         7LvQ==
X-Gm-Message-State: AOJu0YyBWjOF8pOeS6BdCrbbiCKiVgouMI+Z/p2Yy//apBSxoz9VoA8P
	LXxrEu0u3k8QBpIBCU8D5TYqDyETvbYMGdyKkMjNUYVSSbX4xpeQac5zEobvII18AAbpwl+0T9F
	3iQ5Yqvt8CuhxOGU=
X-Received: by 2002:a5d:4108:0:b0:332:f3c9:1c95 with SMTP id l8-20020a5d4108000000b00332f3c91c95mr5128622wrp.21.1701107485991;
        Mon, 27 Nov 2023 09:51:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEC7wCqmPwk5yODdC1mrKef2nYj1QWSCSCYwfha4Hq5cZB2h6iX52pz9LJctejYVMhpn+L9Kw==
X-Received: by 2002:a5d:4108:0:b0:332:f3c9:1c95 with SMTP id l8-20020a5d4108000000b00332f3c91c95mr5128610wrp.21.1701107485706;
        Mon, 27 Nov 2023 09:51:25 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id z14-20020a05600c0a0e00b0040b47b5be25sm3149454wmp.48.2023.11.27.09.51.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Nov 2023 09:51:25 -0800 (PST)
Message-ID: <5ebcbd88-bd2a-4853-a0c7-1c2f0f7dc592@redhat.com>
Date: Mon, 27 Nov 2023 18:51:21 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/19] iommu/arm-smmu-v3: Add a type for the STE
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
 linux-arm-kernel@lists.infradead.org, Robin Murphy <robin.murphy@arm.com>,
 Will Deacon <will@kernel.org>, Michael Shavit <mshavit@google.com>,
 Nicolin Chen <nicolinc@nvidia.com>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
References: <1-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
 <0a2a9fb5-0506-4a46-9c93-3c4001d0b966@redhat.com>
 <20231127174235.GA1165737@nvidia.com>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <20231127174235.GA1165737@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jason,

On 11/27/23 18:42, Jason Gunthorpe wrote:
> On Mon, Nov 27, 2023 at 05:03:36PM +0100, Eric Auger wrote:
> 
>>> -static __le64 *arm_smmu_get_step_for_sid(struct arm_smmu_device *smmu, u32 sid)
>>> +static struct arm_smmu_ste *
>>> +arm_smmu_get_step_for_sid(struct arm_smmu_device *smmu, u32 sid)
>>>  {
>>> -	__le64 *step;
>>>  	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
>>>  
>>>  	if (smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB) {
>>> -		struct arm_smmu_strtab_l1_desc *l1_desc;
>>>  		int idx;
>>>  
>>>  		/* Two-level walk */
>>>  		idx = (sid >> STRTAB_SPLIT) * STRTAB_L1_DESC_DWORDS;
>>> -		l1_desc = &cfg->l1_desc[idx];
>>> -		idx = (sid & ((1 << STRTAB_SPLIT) - 1)) * STRTAB_STE_DWORDS;
>>> -		step = &l1_desc->l2ptr[idx];
>>> +		return &cfg->l1_desc[idx].l2ptr[sid & ((1 << STRTAB_SPLIT) - 1)];
>> This looks less readable to me than it was before.
> 
> You would like the idx calculation outside?
> 
>   		idx1 = (sid >> STRTAB_SPLIT) * STRTAB_L1_DESC_DWORDS;
> 		idx2 = sid & ((1 << STRTAB_SPLIT) - 1);
> 		return &cfg->l1_desc[idx].l2ptr[idx2];
Yes this looks more readable to me

Eric
> 
> ?
> 
> Thanks,
> Jason
> 

