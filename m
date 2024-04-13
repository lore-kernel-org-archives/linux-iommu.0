Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A87376E2
	for <iommu@lists.linux.dev>; Sat, 13 Apr 2024 10:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713005967; cv=none; b=O4qWqA6N4WX0YqQ4+BZmMu80kQtD26mF9tTT3HlBGtdbfuJI85XcCsLLVcx5cyVqPIghXVwkKMN0TD5VqJAOSf2FT8yDo8gRLyX/zV9PP8box3Yj+FpCXCEpz3JM4dsc8ATJo7cWSsByLOvnw8ebKrvnzmJVGGQfjWDEaVh1+dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713005967; c=relaxed/simple;
	bh=uOjaUGqPKVq3+j2VJs/TEKafBEYOo8VXLsRCY3RPo/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c+0roipmVakyGdTwPFtIUAWO/0H6G+XLzOd+2nkcTxsrlPGay/7OdVk8eW9Ejjo0uNk0cW8IsD5c7Tbami058fyXUFg1PYXnufqHB2fuab9KjX8TFj02Nemv+YfKYWFq6Gu3AgUp2qI5pSFNVCmTjpjW9ATw2LXjXMdhNfTdBtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IcugEgpB; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IcugEgpB"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-22f078f1aecso997351fac.3
        for <iommu@lists.linux.dev>; Sat, 13 Apr 2024 03:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713005965; x=1713610765; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9hUP/8ZgJ+b6bN2VxVCxAiZaitZzpbRs5WnErLxeF08=;
        b=IcugEgpBqgiXz6edvNPtU5m5pXQFE4gA2hV09eu/Rr5Bo77GewW6EOmHK9hj0BcHNg
         Kvq+cWzThR86UrN9rgqj8X+ztOxzhZTUPw++6j1v3YjOeYZyj59ACzafW4vDeZiC5NCh
         wHcH0BUYwYutult42e06FaZ9GwHrqPBu2sJ2vrEBbhSZxdYsl9GBuWQ90VM+Gtox81cu
         XzzUO//cm3KnT/iadBrMANe26Fa9MauF1VipTAcrAvNvYvddtvy+txPs4nXgwvx086zB
         Jt7io75kLIE7Vi8zVPzuQiCabICikZwGwPqbWopKfc4qQGAgsf/Lu/RnWU1vabj1V0iV
         dnIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713005965; x=1713610765;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9hUP/8ZgJ+b6bN2VxVCxAiZaitZzpbRs5WnErLxeF08=;
        b=HwWTIoiZRRjkCc/Q8AIEqp/bDnByxUOEi2mYzdwgNKrQTyNhFpVwQEE8BXzK2wkv4T
         xWn0f9QUEalyafokH1P4TXhcLPgKEWO4RelGPEQYYtN584Wny8L1N8eN12yaUCqRDFUh
         mfeDQ0I/YywmtynfVihF/rO2XQJuMOCsbSwVJ2IdvljIoEFS/DSEFzUYiPWHuP73dM+8
         1KDm68DW4OOoGn1LZnZZefFRlNRBdlWzX5u0xzSXK50MsbHut5ztiM+0ESrLpW/mF8Ul
         2pI1L21RhbOktJlgxsADGfSTnyD6vkzUEMefqADzU495TPi2NC18VcvrfPQbXQROleHi
         Cehg==
X-Forwarded-Encrypted: i=1; AJvYcCWbLD25kncOVPzuS1IrKhACmm+bYAdEmfYdStna0Zo0sISaGI3p8TQ5SEZ2NVhrnevhX3w5CDYuU/+Ejio/p1yuMMt0pPM=
X-Gm-Message-State: AOJu0YzMAxOgEbK3UBJDFO1kcKxJKyp2aZyHxK5dxY29dhLY83PSbgJ9
	j2Mba2P23Tj+zyY22p+pXHFZwAGzJM88KKJXJhIdcHmIbM89tlyY
X-Google-Smtp-Source: AGHT+IGyBscLxvzKjs9tfnJDbxZslNl53miRQHsAAQdFdgIgfp+w8iJsvtPKqDglEFKZeub/xcSWOw==
X-Received: by 2002:a05:6870:d0c3:b0:22e:e416:a5ea with SMTP id k3-20020a056870d0c300b0022ee416a5eamr5443820oaa.51.1713005964673;
        Sat, 13 Apr 2024 03:59:24 -0700 (PDT)
Received: from [172.27.234.129] (ec2-16-163-40-128.ap-east-1.compute.amazonaws.com. [16.163.40.128])
        by smtp.gmail.com with ESMTPSA id gb10-20020a056a00628a00b006e6ae26625asm4169308pfb.68.2024.04.13.03.59.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Apr 2024 03:59:24 -0700 (PDT)
Message-ID: <6153f44c-841a-4eea-a51b-5a68c84faf47@gmail.com>
Date: Sat, 13 Apr 2024 18:59:16 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/13] iommu/vt-d: Make posted MSI an opt-in cmdline
 option
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, X86 Kernel <x86@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, iommu@lists.linux.dev,
 Thomas Gleixner <tglx@linutronix.de>, Lu Baolu <baolu.lu@linux.intel.com>,
 kvm@vger.kernel.org, Dave Hansen <dave.hansen@intel.com>,
 Joerg Roedel <joro@8bytes.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
 Paul Luse <paul.e.luse@intel.com>, Dan Williams <dan.j.williams@intel.com>,
 Jens Axboe <axboe@kernel.dk>, Raj Ashok <ashok.raj@intel.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, maz@kernel.org, seanjc@google.com,
 Robin Murphy <robin.murphy@arm.com>, jim.harris@samsung.com,
 a.manzanares@samsung.com, Bjorn Helgaas <helgaas@kernel.org>,
 guang.zeng@intel.com
References: <20240405223110.1609888-1-jacob.jun.pan@linux.intel.com>
 <20240405223110.1609888-12-jacob.jun.pan@linux.intel.com>
 <8871e541-4991-44f3-aab7-d3a657fc59db@gmail.com>
 <20240408163312.7b7f3d18@jacob-builder>
Content-Language: en-US
From: Robert Hoo <robert.hoo.linux@gmail.com>
In-Reply-To: <20240408163312.7b7f3d18@jacob-builder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/9/2024 7:33 AM, Jacob Pan wrote:
> Hi Robert,
> 
> On Sat, 6 Apr 2024 12:31:14 +0800, Robert Hoo <robert.hoo.linux@gmail.com>
> wrote:
> 
>> On 4/6/2024 6:31 AM, Jacob Pan wrote:
>>> Add a command line opt-in option for posted MSI if
>>> CONFIG_X86_POSTED_MSI=y.
>>>
>>> Also introduce a helper function for testing if posted MSI is supported
>>> on the platform.
>>>
>>> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
>>> ---
>>>    Documentation/admin-guide/kernel-parameters.txt |  1 +
>>>    arch/x86/include/asm/irq_remapping.h            | 11 +++++++++++
>>>    drivers/iommu/irq_remapping.c                   | 13 ++++++++++++-
>>>    3 files changed, 24 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/admin-guide/kernel-parameters.txt
>>> b/Documentation/admin-guide/kernel-parameters.txt index
>>> bb884c14b2f6..e5fd02423c4c 100644 ---
>>> a/Documentation/admin-guide/kernel-parameters.txt +++
>>> b/Documentation/admin-guide/kernel-parameters.txt @@ -2251,6 +2251,7 @@
>>>    			no_x2apic_optout
>>>    				BIOS x2APIC opt-out request will be
>>> ignored nopost	disable Interrupt Posting
>>> +			posted_msi enable MSIs delivered as posted
>>> interrupts
>>>    	iomem=		Disable strict checking of access to
>>> MMIO memory strict	regions from userspace.
>>> diff --git a/arch/x86/include/asm/irq_remapping.h
>>> b/arch/x86/include/asm/irq_remapping.h index 7a2ed154a5e1..e46bde61029b
>>> 100644 --- a/arch/x86/include/asm/irq_remapping.h
>>> +++ b/arch/x86/include/asm/irq_remapping.h
>>> @@ -50,6 +50,17 @@ static inline struct irq_domain
>>> *arch_get_ir_parent_domain(void) return x86_vector_domain;
>>>    }
>>>    
>>> +#ifdef CONFIG_X86_POSTED_MSI
>>> +extern int enable_posted_msi;
>>> +
>>> +static inline bool posted_msi_supported(void)
>>> +{
>>> +	return enable_posted_msi && irq_remapping_cap(IRQ_POSTING_CAP);
>>> +}
>>
>> Out of this patch set's scope, but, dropping into irq_remappping_cap(),
>> I'd like to bring this change for discussion:
>>
>> diff --git a/drivers/iommu/irq_remapping.c b/drivers/iommu/irq_remapping.c
>> index 4047ac396728..ef2de9034897 100644
>> --- a/drivers/iommu/irq_remapping.c
>> +++ b/drivers/iommu/irq_remapping.c
>> @@ -98,7 +98,7 @@ void set_irq_remapping_broken(void)
>>
>>    bool irq_remapping_cap(enum irq_remap_cap cap)
>>    {
>> -       if (!remap_ops || disable_irq_post)
>> +       if (!remap_ops || disable_irq_remap)
>>                   return false;
>>
>>           return (remap_ops->capability & (1 << cap));
>>
>>
>> 1. irq_remapping_cap() is to exam some cap, though at present it has only
>> 1 cap, i.e. IRQ_POSTING_CAP, simply return false just because of
>> disable_irq_post isn't good. Instead, IRQ_REMAP is the foundation of all
>> remapping caps. 2. disable_irq_post is used by Intel iommu code only,
>> here irq_remapping_cap() is common code. e.g. AMD iommu code doesn't use
>> it to judge set cap of irq_post or not.
> I agree, posting should be treated as a sub-capability of remapping.
> IRQ_POSTING_CAP is only set when remapping is on.
> 
> We need to delete this such that posting is always off when remapping is
> off.
> 
> --- a/drivers/iommu/intel/irq_remapping.c
> +++ b/drivers/iommu/intel/irq_remapping.c
> @@ -1038,11 +1038,7 @@ static void disable_irq_remapping(void)
>                  iommu_disable_irq_remapping(iommu);
>          }
>   
> -       /*
> -        * Clear Posted-Interrupts capability.
> -        */
> -       if (!disable_irq_post)
> -               intel_irq_remap_ops.capability &= ~(1 << IRQ_POSTING_CAP);
> +       intel_irq_remap_ops.capability &= ~(1 << IRQ_POSTING_CAP);
>   }
> 
Right.

