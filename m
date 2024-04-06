Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161B7A50
	for <iommu@lists.linux.dev>; Sat,  6 Apr 2024 04:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712377888; cv=none; b=rS5ffaDsE05i6LsfaF7tvu2Nmhs1KflDZkGkMi2+zyf0jnZXv3V2lLJl1CbPZSZczXR9XE28ndf4vymc5L7GhYVfn/IfblAWMbzFL42HCD0KRhhLIkzTqqecJj4uftgaKAs/Lrddop4oWesq4NsoglHJVb4sybR4eFyZRtuso+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712377888; c=relaxed/simple;
	bh=Sd9whxFabxqaniLOwdOH3BPEIWVV3eaeOVYlENJ62EM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YyNo1xGCILMDGCT7atCpvP5fg5MX1snSCDX69ujvbtRWoo+Ctgn8V+IaTjdQHBi+lcg/EQQiRz3oQDgCwtKLu/holTbvcmPRX5Na0pO0RVMZLdzKngijzpq6UmFUA4azyFsGbSR0tqMC/mj5Q89IrKymTmjW9w6y+se3uzahPMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SZW4ZwY/; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SZW4ZwY/"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-22ea24c9215so1571050fac.0
        for <iommu@lists.linux.dev>; Fri, 05 Apr 2024 21:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712377886; x=1712982686; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ANjvDaQnRfWIu1MTyzhHLGRn9JEs7sjvTWyOy3Vox/8=;
        b=SZW4ZwY/aFFbOJ/Au1Jnlw61WYeuXHKcvN7JKwATuXmwK+JB4QHSXQIwqm9EbT0BiK
         kPC5otvltlQ6jt1efWPGb5W2V07faew9eAA6c17PtSrzfwnUnzryKSO01JcsNob/8dhT
         cdh43GSFtTw9qP8OMmZeSF6tVrVVEfcWl6XBc8v97OQIOmnQ667ARLXQ3V/KjXkIwUSi
         /wYYeEkix8DnAgAHpYdZKwBxYn59AMM+ZDgOh0ZqNq/YEP3LshIc97rfXmo2pnPS4fiI
         txrzAjALrjJwl/OvkjuD72cTcmDc3vqjlMrNaUpD1BaZWlXv8HEsdRsTEAHcDtx5W9FR
         p/LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712377886; x=1712982686;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ANjvDaQnRfWIu1MTyzhHLGRn9JEs7sjvTWyOy3Vox/8=;
        b=VVU7IvDufT2tZIIGgVvCJDo4NiNgXQspvfhQGU+JVO7SprlJ99m8l4MA0ki7+iiY2v
         G3FLkBlXHFWrC5d2VOUOUSyPRmGIYywJ5ZQQJjCpLP5EMxp7OPMyEv1G1giX1ymgdpM+
         zDmI0/oRqJwtmdQhxhzDvyENU9hYu19/SvwSRxIEk1u9sucRnSdz/xzbGAy88ROoK8Q9
         bskKJp0bLAZr4zLLBZGvODfXuatFh1I3wHNSUFaZgTCRUihQKVBTEw3ixMrKzNA7XSeA
         rBJnvxUl4d5nBqfuaxNbzPVbxGjwDUezWDNyX2Xadss9i7BgT7eOYrkHndjARPRh+KBz
         4Zgw==
X-Forwarded-Encrypted: i=1; AJvYcCU6eQQzZLrkxSkVJEHS2KNvce1janjuenMbTy8q4btVrzNxKOUeLa4HugM6rtu2o0vH2MK4qvpmGE8c7YWg8I3pmJLHXek=
X-Gm-Message-State: AOJu0Yy9yidnNJbsxPgPGK3STRrJsJVkqpwO+keDWDO4FQEEiVfPN7N+
	66B4yJsbGnRFsNGZ3uDlFuc5Klit61Adx/yRt61GWlk7I1voUJcw
X-Google-Smtp-Source: AGHT+IGVHOtE7u5B4TTMjGZWtWpzIDvTdtQMJcIi7qs5jUx2J8vwSZ2djbS/jzaSt5bJWLCBAajOqQ==
X-Received: by 2002:a05:6870:1609:b0:22e:9aec:e8fe with SMTP id b9-20020a056870160900b0022e9aece8femr3424231oae.47.1712377886107;
        Fri, 05 Apr 2024 21:31:26 -0700 (PDT)
Received: from [172.27.237.3] (ec2-16-163-40-128.ap-east-1.compute.amazonaws.com. [16.163.40.128])
        by smtp.gmail.com with ESMTPSA id c10-20020a056a00008a00b006ecfa91a210sm2332154pfj.100.2024.04.05.21.31.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Apr 2024 21:31:25 -0700 (PDT)
Message-ID: <8871e541-4991-44f3-aab7-d3a657fc59db@gmail.com>
Date: Sat, 6 Apr 2024 12:31:14 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/13] iommu/vt-d: Make posted MSI an opt-in cmdline
 option
To: Jacob Pan <jacob.jun.pan@linux.intel.com>,
 LKML <linux-kernel@vger.kernel.org>, X86 Kernel <x86@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, iommu@lists.linux.dev,
 Thomas Gleixner <tglx@linutronix.de>, Lu Baolu <baolu.lu@linux.intel.com>,
 kvm@vger.kernel.org, Dave Hansen <dave.hansen@intel.com>,
 Joerg Roedel <joro@8bytes.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>
Cc: Paul Luse <paul.e.luse@intel.com>, Dan Williams
 <dan.j.williams@intel.com>, Jens Axboe <axboe@kernel.dk>,
 Raj Ashok <ashok.raj@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 maz@kernel.org, seanjc@google.com, Robin Murphy <robin.murphy@arm.com>,
 jim.harris@samsung.com, a.manzanares@samsung.com,
 Bjorn Helgaas <helgaas@kernel.org>, guang.zeng@intel.com
References: <20240405223110.1609888-1-jacob.jun.pan@linux.intel.com>
 <20240405223110.1609888-12-jacob.jun.pan@linux.intel.com>
Content-Language: en-US
From: Robert Hoo <robert.hoo.linux@gmail.com>
In-Reply-To: <20240405223110.1609888-12-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/6/2024 6:31 AM, Jacob Pan wrote:
> Add a command line opt-in option for posted MSI if CONFIG_X86_POSTED_MSI=y.
> 
> Also introduce a helper function for testing if posted MSI is supported on
> the platform.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>   Documentation/admin-guide/kernel-parameters.txt |  1 +
>   arch/x86/include/asm/irq_remapping.h            | 11 +++++++++++
>   drivers/iommu/irq_remapping.c                   | 13 ++++++++++++-
>   3 files changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index bb884c14b2f6..e5fd02423c4c 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2251,6 +2251,7 @@
>   			no_x2apic_optout
>   				BIOS x2APIC opt-out request will be ignored
>   			nopost	disable Interrupt Posting
> +			posted_msi enable MSIs delivered as posted interrupts
>   
>   	iomem=		Disable strict checking of access to MMIO memory
>   		strict	regions from userspace.
> diff --git a/arch/x86/include/asm/irq_remapping.h b/arch/x86/include/asm/irq_remapping.h
> index 7a2ed154a5e1..e46bde61029b 100644
> --- a/arch/x86/include/asm/irq_remapping.h
> +++ b/arch/x86/include/asm/irq_remapping.h
> @@ -50,6 +50,17 @@ static inline struct irq_domain *arch_get_ir_parent_domain(void)
>   	return x86_vector_domain;
>   }
>   
> +#ifdef CONFIG_X86_POSTED_MSI
> +extern int enable_posted_msi;
> +
> +static inline bool posted_msi_supported(void)
> +{
> +	return enable_posted_msi && irq_remapping_cap(IRQ_POSTING_CAP);
> +}

Out of this patch set's scope, but, dropping into irq_remappping_cap(), I'd like 
to bring this change for discussion:

diff --git a/drivers/iommu/irq_remapping.c b/drivers/iommu/irq_remapping.c
index 4047ac396728..ef2de9034897 100644
--- a/drivers/iommu/irq_remapping.c
+++ b/drivers/iommu/irq_remapping.c
@@ -98,7 +98,7 @@ void set_irq_remapping_broken(void)

  bool irq_remapping_cap(enum irq_remap_cap cap)
  {
-       if (!remap_ops || disable_irq_post)
+       if (!remap_ops || disable_irq_remap)
                 return false;

         return (remap_ops->capability & (1 << cap));


1. irq_remapping_cap() is to exam some cap, though at present it has only 1 cap, 
i.e. IRQ_POSTING_CAP, simply return false just because of disable_irq_post isn't 
good. Instead, IRQ_REMAP is the foundation of all remapping caps.
2. disable_irq_post is used by Intel iommu code only, here irq_remapping_cap() 
is common code. e.g. AMD iommu code doesn't use it to judge set cap of irq_post 
or not.

> +#else
> +static inline bool posted_msi_supported(void) { return false; };
> +#endif

