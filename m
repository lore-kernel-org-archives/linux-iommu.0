Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA4941747
	for <iommu@lists.linux.dev>; Tue,  5 Dec 2023 13:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D0UiMYbN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701782733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gET9du08BmvB9xnJGl327V4v6DwSpl5CMpPFLBUY7xY=;
	b=D0UiMYbNQIJpYJU7Eos1yPRKOdfD9ApJoPfKSDqAixYgvUr+ukiBKP+SVXNUTbRNpMb8Px
	FXv4W6ny6Cu/zIPZ2c1K9YdNkdxt5K/tTHDgAvSn7+fscXFOJ2B+2TcE4rFvmqGQylQ5ZC
	50u1/LITc1q/C6rereg2mP5QIrdWNFo=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-er07thaaMMC_DPJ6DLF7Ew-1; Tue, 05 Dec 2023 08:25:32 -0500
X-MC-Unique: er07thaaMMC_DPJ6DLF7Ew-1
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3b9b33ada9eso2186611b6e.0
        for <iommu@lists.linux.dev>; Tue, 05 Dec 2023 05:25:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701782732; x=1702387532;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gET9du08BmvB9xnJGl327V4v6DwSpl5CMpPFLBUY7xY=;
        b=VtCUwIbcFV4RiHpWm0PfjriyqC6gSkyuceM5GSjMPUaybR2w0QemPHf8MoJxzCHZ2A
         gULh78PAGD/VYpEPEAjVEViNkAhw7BLP/xI5O/8o3EQkNjH+bvpuGNXXPN0RPUGAdNzj
         D2nx7IXjoAhyZ5pVjuj9gv3qn6BjBbAEiwseY7eGkitG0xtb0mOSft2P2tqpuNCPBtSp
         1MkJcL6WjyhLkjw/cl9zhvml9zzAwUD7IA20DraEtwUn7zhxMvq+xErG08z5kZ7ZloFd
         SIwwjTENDObLiZ2FoSCycx/ssnBL+0GHQevPMdKUH++lLTCW94bUU1f9ajRBum6/9/nn
         dduw==
X-Gm-Message-State: AOJu0YzquF35N+QOhKPCQ98iYIEOz2uOLD0Rl0fofxAVpm2lwm1Vjy6P
	bSd4xaopsmRbJKvRSMvDtFbzNF6Ss+/ze5hqQd28hTd0/lBRT0jFjMxU/DNMUscNAqB/0/9xkMj
	dwfvYr+nS9FHCFLc=
X-Received: by 2002:a05:6871:5213:b0:1fb:75b:2bb9 with SMTP id ht19-20020a056871521300b001fb075b2bb9mr3399051oac.117.1701782732130;
        Tue, 05 Dec 2023 05:25:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IECMAmTismgKntArm+XZeEWXmEQ5+qKaP2PKMQykRuQmVv63gLdp3/GxWzAQ2GHBy/8TwkJuA==
X-Received: by 2002:a05:6871:5213:b0:1fb:75b:2bb9 with SMTP id ht19-20020a056871521300b001fb075b2bb9mr3399036oac.117.1701782731800;
        Tue, 05 Dec 2023 05:25:31 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id s28-20020a0cb31c000000b0067a364eea86sm5139895qve.142.2023.12.05.05.25.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 05:25:31 -0800 (PST)
Message-ID: <8bed7afd-d180-4b71-8211-e3fb7a653b8a@redhat.com>
Date: Tue, 5 Dec 2023 14:25:27 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/19] iommu/arm-smmu-v3: Remove
 arm_smmu_master->domain
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
 linux-arm-kernel@lists.infradead.org, Robin Murphy <robin.murphy@arm.com>,
 Will Deacon <will@kernel.org>, Michael Shavit <mshavit@google.com>,
 Nicolin Chen <nicolinc@nvidia.com>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
References: <14-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
 <6fff20dd-46d5-4974-a4a5-fb4e7a59ce44@redhat.com>
 <20231130120340.GA1124924@nvidia.com>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <20231130120340.GA1124924@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jason,

On 11/30/23 13:03, Jason Gunthorpe wrote:
> On Mon, Nov 27, 2023 at 06:14:30PM +0100, Eric Auger wrote:
>> Hi Jason,
>>
>> On 11/13/23 18:53, Jason Gunthorpe wrote:
>>> Introducing global statics which are of type struct iommu_domain, not
>>> struct arm_smmu_domain makes it difficult to retain
>>> arm_smmu_master->domain, as it can no longer point to an IDENTITY or
>>> BLOCKED domain.
>>>
>>> The only place that uses the value is arm_smmu_detach_dev(). Change things
>>> to work like other drivers and call iommu_get_domain_for_dev() to obtain
>>> the current domain.
>>>
>>> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
>>
>> This patch introduces a crash on my machine. See below.
> 
> Ah, your system must have multi-device groups
> 
> The master->domain was subtly protecting the domain_head to ensure
> we don't touch it unless it is already in a domain list. This issue is
> solved in part 2 (iommu/arm-smmu-v3: Make smmu_domain->devices into an
> allocated list) which removes the domain_head.
> 
> This hunk should fix this patch. I updated the github

I confirm that the hunk hereafter fixes the crash.

Thanks

Eric
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 23dda64722ea17..102e13b65bcdec 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2491,7 +2491,7 @@ static void arm_smmu_detach_dev(struct arm_smmu_master *master)
>  	arm_smmu_disable_ats(master, smmu_domain);
>  
>  	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
> -	list_del(&master->domain_head);
> +	list_del_init(&master->domain_head);
>  	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
>  
>  	master->ats_enabled = false;
> @@ -2606,7 +2606,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
>  
>  out_list_del:
>  	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
> -	list_del(&master->domain_head);
> +	list_del_init(&master->domain_head);
>  	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
>  
>  out_unlock:
> @@ -2810,6 +2810,7 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
>  	master->dev = dev;
>  	master->smmu = smmu;
>  	INIT_LIST_HEAD(&master->bonds);
> +	INIT_LIST_HEAD(&master->domain_head);
>  	dev_iommu_priv_set(dev, master);
>  
>  	ret = arm_smmu_insert_master(smmu, master);
> 
> 
> 
> Thank!!
> Jason
> 

