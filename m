Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB9A345EDE
	for <iommu@lists.linux.dev>; Wed, 19 Aug 2026 19:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787167352; cv=none; b=P2gcqlpsIY2zUEMbyDkI15ro/VKP8EQnjGXpYgzVMlSwIanMGHyOFCOatavCgKhTMFnwdA2/wIF+aGbS7oM6kIx9SZa16cOfC/p8tmqR7pwefW7/CE5SqWbNE+MdgB8Y6lDOc8uafTyqAYbRBNLxFoztalsFSoXDwSTRXqbgW5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787167352; c=relaxed/simple;
	bh=+wcYJH7HD0CotFwcUL/xmQ62D2MQdzvewGPIAAxmfLI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EL+MOUfgpzPTrMRF/SD7GKobp0Nb4e2ud/ZEhYTwhAEDkHH2JoOwdsvjNJ6k8Rr1HDqxWQ1HVqlkO86FYHfICEz0oAU5xiJwOCRneMVbM0MZx1tZ6+tVU07zQiWyiPPlMFlhz+0VyFcmrSC8ucRvbs44xaUws53wR6YHYxcueso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=reactivated.net; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=reactivated.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-49556f97a9dso9604665e9.1
        for <iommu@lists.linux.dev>; Wed, 19 Aug 2026 12:22:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787167349; x=1787772149;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3SmkFPv7x6SaEPIsRjgJHZz2gnZAicBosl7slQRZeBE=;
        b=cW/AHOPA5WHDpz7Dv2EOpkUAAoKBMuS+p/trN0PMxQgWTbRBRmax0ogdXCz6ObunYd
         u+ZST4j3mdx8yDFlWZp5P8VGsaYUCn76iao+d00kCScmzqQpber9rcKNJdEeuuPvnZlC
         BUV5qsEWUUNdMnE8V8DebCzEL3YjPyf3EU6gkWYxJsYaUky69Hp9zfvp+wp8QJvByzYC
         WGAqK3RZ7iB/S3vVHVExAZpxxx/RXuX/FMskFlAlTe6sNda5hYAk/ZkccxiwlT0O3+eE
         7AMMvmegBWsiC56ra/exBUGDYsTQCyrNvjx5QsocuRk1P5QGdNGlRP8oGhfNRBOXmj9l
         a5dg==
X-Forwarded-Encrypted: i=1; AHgh+RqVyBuRk8076M/T8dap/GHM2Lot+NfvXjsRMaalI1amrIv3/tDnktU+nzhVjpjRl3TiaXI1Qw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwscIPI+zj5MLUqhm2dwnxvb81YepU0QzPeUMJ/Wunet8fKtwKa
	/vpAJN2g9+PH8AtOSYiIDylNo/5Zx1nHCQBtq1JopulrdBjOuFIP28RO
X-Gm-Gg: AR+sD13xcOZTP6oDIIFzYuHYt8UFWTHWqE2n20fEz/Rc7qnGuakU+eQCCV95U/1pHSV
	oJgZG74o8RsqNDdDnv7pRmmuFUTAkK59sNTKZa9ES/pveiypNqFjtL/FmJx+jbVFfNMK1JS8gtj
	u1qJVSQGE5BDfXuCQzSVLbJgLhwzq9rJj16VHlif46PlNWbK7hBTjTwXmcnIJ0g5EVylYEAmaAq
	6w0inyyEaFMOxQ/o4dAD5cknrm7RyiJFzB1IvqOUFPCDyjP7aYkXCrMPyWu/YjOouk5uIOSo+cv
	wMtjlka377Y4pv73k9ulgZyior5j/NxlQyWvF85MyZ6b26T/mZC3OHgb8NDMC+YjiuDZ4s6XEAN
	xTh9jeKg9pLNJ/mfwVVugtydVlkFke3js/qir7jp1GfZV7Qh7S6sIXjVnw2VCXqcsSyaycuA+By
	pYqlgBSlVM2XzZy7/lM7e1KTympEOUR/lRJRokhLr5ioqmB2ieGKJrWYWSQuseQA+Oj2AUi4+QL
	qiz/z0mHl3yfjdOeV/Zxqhk16G7uR92sdx76yFYpZ4LisUmJwA2muJfpEVj/PKDXb5uFUW2DQ78
	lfY=
X-Received: by 2002:a05:600c:3e0c:b0:499:4e47:eaf2 with SMTP id 5b1f17b1804b1-499aa1a3e87mr144312755e9.6.1787167349071;
        Wed, 19 Aug 2026 12:22:29 -0700 (PDT)
Received: from ?IPV6:2001:8a0:d6cd:9000:86f4:4e71:9fc8:3183? ([2001:8a0:d6cd:9000:86f4:4e71:9fc8:3183])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499aa17f202sm75178105e9.13.2026.08.19.12.22.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2026 12:22:28 -0700 (PDT)
Message-ID: <45a31ea4-7660-44c6-980e-daec6655629e@reactivated.net>
Date: Wed, 19 Aug 2026 20:22:26 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] iommu: Add Broadcom BCM2712 IOMMU driver
To: Jim Quinlan <james.quinlan@broadcom.com>
Cc: bcm-kernel-feedback-list@broadcom.com, conor+dt@kernel.org,
 devicetree@vger.kernel.org, florian.fainelli@broadcom.com,
 iommu@lists.linux.dev, jgg@ziepe.ca, joro@8bytes.org, krzk+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, nick.hollinghurst@raspberrypi.com,
 robh@kernel.org, robin.murphy@arm.com, will@kernel.org
References: <20260727-bcm2712-iommu-submit-v2-0-0247b5c03de8@reactivated.net>
 <20260728225727.148778-1-james.quinlan@broadcom.com>
Content-Language: en-US
From: Daniel Drake <dan@reactivated.net>
In-Reply-To: <20260728225727.148778-1-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28/07/2026 23:57, Jim Quinlan wrote:
>> +#define MMMU_CTRL_OPERATING_FLAGS (\
>> +	MMMU_CTRL_CAP_EXCEEDED_ABORT_EN    | \
>> +	MMMU_CTRL_PT_INVALID_ABORT_EN      | \
>> +	MMMU_CTRL_PT_INVALID_EN            | \
>> +	MMMU_CTRL_WRITE_VIOLATION_ABORT_EN | \
>> +	MMMU_CTRL_STATS_ENABLE             | \
>> +	MMMU_CTRL_ENABLE)
> 
> Hello,
> 
> Why not request the MMU interrupt and use the "INT_EN" version, e.g.
> MMMU_CTRL_PT_INVALID_INT_EN?  It seems better than "ABORT", as with an
> interrupt you have a fighting chance of the handler printing out something
> helpful and shutting down gracefully.

That could indeed be useful, but the only info I have about this 
hardware is the RPi kernel's bcm2712-iommu driver which also does not 
handle this interrupt, so I don't have the required info to set up an 
interrupt handler.

Could you let me know the interrupt routing details for all of the 
bcm2712 iommu blocks? e.g. which GIC/L2 IRQ lines they connect to.
>> +	/* Shootdown register deals with 4 pages at a time */
>> +	for (page_group = iova >> (IOMMU_PAGE_SHIFT + 2);
>> +	     page_group <= iova_end >> (IOMMU_PAGE_SHIFT + 2); page_group++) {
>> +		MMU_WR(MMMU_SHOOT_DOWN_OFFSET,
>> +		       MMMU_SHOOT_DOWN_SHOOT + (page_group << 2));
>> +		readl_poll_timeout_atomic(
>> +			mmu->reg_base + MMMU_SHOOT_DOWN_OFFSET, val,
>> +			!(val & MMMU_SHOOT_DOWN_SHOOTING), 0, 1000);
> 
> I think it would be prudent to have this function return the
> readl_poll_timeout_atomic() result and then do a dev_{warn,err}() call once
> you are out of the containing spinlock.  Also, why 1ms -- seems a long
> time to have a spinlock.

I'll do that. And yeah, that is way too long. I took some measurements 
and all 3 of the TLB-related cache flush codepaths take around 100ns on 
average. So I'm reducing the timeouts to 50usec.

Thanks!
