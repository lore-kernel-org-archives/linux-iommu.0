Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6519E12880D
	for <iommu@lists.linux.dev>; Thu,  4 Apr 2024 13:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712237927; cv=none; b=lcCKTOXd87kBPzx5NkhmqonUa6l4E9tYOLH2W/NhfqnWEsncRV8Zr/PK1pUMze1wYAsfwoq/UbtNYDt2VeyNFyYDdEHarjKf+Ol0cnaKW/tmzPsf68F7OKH7xEcBd/3qAjhu8r6fF/RYtj+mOopOk0HmRy9laT8ZpdyGIvZUhnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712237927; c=relaxed/simple;
	bh=x8Lyghgp6/F9G9gkl5wcYiiVhCfyHgsqvEtMNlGYbZ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uBn6edHR25IaZBVgb3tG9a5oON8uNYnnujWaA68C9+LIlgT1p14tHwz7AOKBVpc8eDKMnsCQDJh7P1CEtACQUZb1PvxHG7mYCLqu/Hje0zE4gajjbsJMTVT7ybWZ1gMPBurshZc9r4LfsG9c/X7608lqvCXMcSldHQeNt+doLY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kYFbsyMO; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kYFbsyMO"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6ecea46e1bfso684797b3a.3
        for <iommu@lists.linux.dev>; Thu, 04 Apr 2024 06:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712237926; x=1712842726; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tft6OeeDgSbfAOUrN5Xx5Zopkyg1jcKnp2CiC8iZD30=;
        b=kYFbsyMOWlYs825X5I7vP83GrMS+3TfjZ8cFpNNxUi4QnJxh7h9zpZB+s1wohxJSAD
         7oPkbnHKYYc4NnitJBDwPW/5YDPXTRjAUVUYKVx+j/bMvujAHMhTOJq8XgyaKeGYhJcg
         J1+I/WPs/q/heBN+XzCVWiRUzbkNBWKyVvbT7zTSVNZXg1QbcpLmybNh2eIndJAyRgnC
         +51UyffIX5BBTIW5ZNq9HP0R9lbO7+8wHppBEGLxUX4EybD0gAevgrmIbhXe1EUsLfce
         zfdhiMBYsp2FqnUzWvSSAWixKzGxgzuteQZL6xtXZx15yxflAGFJqkpQebHdvCg/01Gf
         J8cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712237926; x=1712842726;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tft6OeeDgSbfAOUrN5Xx5Zopkyg1jcKnp2CiC8iZD30=;
        b=Ibq7diYxpL/G5xFMXK3tLzXuwOaJ0I9iX79UJ+yGJgqhYv+T2naXySsdh2JAx2VuLM
         y7Btv7Re8vwnHsNI9eKih/efFNYP8dKqX5rdELwaLMLaGPRUtXYvnjg7IVfXSpeyrfdB
         yhJxHBObDNK4HoFEEgGQPiGsO5Wq7ZnswxvMUI8HOKin4F5r+uLAIAktHlVScZp5kD+W
         OBZ5BZaVeZJBMCosyrGg1UMTajNtQo1xqxD/EDV4g++I0+gmMv1PVItOIjWy2rkCoG4v
         dJAHNqZqJm3MD0D7sCO0s9u6K8XBT1LvhPCDGy7rljXxPBOV2fZWOvmiCFre5noZxvmJ
         imFw==
X-Forwarded-Encrypted: i=1; AJvYcCXLt1jvewnntxhUaMScIQKF3zYfn14q3Pz4hDMPSB1uydVfzH2/UeClJlCy6/06towwVjPOaUmfP7VEs/1z/JMvoKoNYgQ=
X-Gm-Message-State: AOJu0YyiIX4x82VAZAiIpzLOXYjUIY5rtgWD3kZtuNMfFJEAtiCHcUxJ
	X8duepSzehabQYH1EAvtQjEMhrMiOqWDly5spS/qV6PORp8UH6Wm
X-Google-Smtp-Source: AGHT+IGwYVCu7BN5Om9yXuxMS4L968QGnax7Rwa27cBqDVDI8qtrAZwX1+ZMyVsGVLwlnJVcobYbTw==
X-Received: by 2002:a05:6a20:3254:b0:1a3:bd8a:141f with SMTP id hm20-20020a056a20325400b001a3bd8a141fmr2516552pzc.54.1712237925633;
        Thu, 04 Apr 2024 06:38:45 -0700 (PDT)
Received: from [172.27.237.1] (ec2-16-163-40-128.ap-east-1.compute.amazonaws.com. [16.163.40.128])
        by smtp.gmail.com with ESMTPSA id g21-20020a631115000000b005df58c83e89sm13472352pgl.84.2024.04.04.06.38.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 06:38:45 -0700 (PDT)
Message-ID: <9734e080-96e4-4119-8ae6-28abb7877a3c@gmail.com>
Date: Thu, 4 Apr 2024 21:38:34 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/15] x86/irq: Reserve a per CPU IDT vector for posted
 MSIs
Content-Language: en-US
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
 maz@kernel.org, seanjc@google.com, Robin Murphy <robin.murphy@arm.com>
References: <20240126234237.547278-1-jacob.jun.pan@linux.intel.com>
 <20240126234237.547278-6-jacob.jun.pan@linux.intel.com>
From: Robert Hoo <robert.hoo.linux@gmail.com>
In-Reply-To: <20240126234237.547278-6-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/27/2024 7:42 AM, Jacob Pan wrote:
> When posted MSI is enabled, all device MSIs are multiplexed into a single
> notification vector. MSI handlers will be de-multiplexed at run-time by
> system software without IDT delivery.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>   arch/x86/include/asm/irq_vectors.h | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/irq_vectors.h b/arch/x86/include/asm/irq_vectors.h
> index 3a19904c2db6..08329bef5b1d 100644
> --- a/arch/x86/include/asm/irq_vectors.h
> +++ b/arch/x86/include/asm/irq_vectors.h
> @@ -99,9 +99,16 @@
>   
>   #define LOCAL_TIMER_VECTOR		0xec
>   
> +/*
> + * Posted interrupt notification vector for all device MSIs delivered to
> + * the host kernel.
> + */
> +#define POSTED_MSI_NOTIFICATION_VECTOR	0xeb
>   #define NR_VECTORS			 256
>   
> -#ifdef CONFIG_X86_LOCAL_APIC
> +#ifdef X86_POSTED_MSI

X86_POSTED_MSI --> CONFIG_X86_POSTED_MSI?

> +#define FIRST_SYSTEM_VECTOR		POSTED_MSI_NOTIFICATION_VECTOR
> +#elif defined(CONFIG_X86_LOCAL_APIC)
>   #define FIRST_SYSTEM_VECTOR		LOCAL_TIMER_VECTOR
>   #else
>   #define FIRST_SYSTEM_VECTOR		NR_VECTORS

