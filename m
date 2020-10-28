Return-Path: <SRS0=WwkY=ED=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F80C4363A
	for <iommu@archiver.kernel.org>; Wed, 28 Oct 2020 23:15:26 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D6B6206FB
	for <iommu@archiver.kernel.org>; Wed, 28 Oct 2020 23:15:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="GORSieNJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D6B6206FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 792F420796;
	Wed, 28 Oct 2020 23:15:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jSqiQezEZqjM; Wed, 28 Oct 2020 23:15:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id D26D5203BD;
	Wed, 28 Oct 2020 23:15:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B7019C0859;
	Wed, 28 Oct 2020 23:15:22 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5C94FC0051
 for <iommu@lists.linux-foundation.org>; Wed, 28 Oct 2020 23:15:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 3F39D869A5
 for <iommu@lists.linux-foundation.org>; Wed, 28 Oct 2020 23:15:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OQuSIL-OQgBd for <iommu@lists.linux-foundation.org>;
 Wed, 28 Oct 2020 23:15:19 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com
 [209.85.210.196])
 by whitealder.osuosl.org (Postfix) with ESMTPS id DF8568687D
 for <iommu@lists.linux-foundation.org>; Wed, 28 Oct 2020 23:15:19 +0000 (UTC)
Received: by mail-pf1-f196.google.com with SMTP id b3so750065pfo.2
 for <iommu@lists.linux-foundation.org>; Wed, 28 Oct 2020 16:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=CR2wnnNlKWCuS4v8a17nk31my7ihb+hmRpvNks7K5nk=;
 b=GORSieNJXfwskxaxCjowLoxfeZJAJBnAwv32Jxo7LchBcWcFZsNgs2td3VwO2FpDap
 8VS39JtTsIkN16uJZ91UjVSKg4D3cjZTUmYyXQ4EdU4q/synSnECkjtEEBSLoN2otDf7
 WidryILLCwpaAcfIjcoMYYJeqknpRUgQLpKW8ZiXIT4GTH22ibwSOYE/7ay6ySN41mWG
 oBy2gdO7DYhHQrcSrV0NKdA93mlC3+0KwYn9PnadvEmLMuu4Vks70zDrrpf8Or7HUlKg
 V/RzNKoAwyVmp2MqwFjfjGLo55FVa9S6YmZfMC0064eqqicggyfyaL5fjTTN9yJRVcUS
 l80w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=CR2wnnNlKWCuS4v8a17nk31my7ihb+hmRpvNks7K5nk=;
 b=bu45ExX+szx4NWVJOnHAVYytmB/2d7JplBXNdBY8Ba6GrHHWyyd2f/ZN7lRQBbF6wV
 2uKgqnq596I+G99251IHjRDtcDMlsQ6TJ5B3DY+ZIwlawGXrMM4H/eordpAovibzugHo
 oc0+k1aRx7DSwjjwlWgktQZxuf5by87aDXAyTew8zLmHaCr+o0MuLpkHWOBSriuabraY
 vOq+LTPT/7WbHiENnOrkGo6NOdsfnHaZwEGhtX9IrDVD2HoQ0hfXv4wo8JalAtg00vdQ
 uX7/af/U9W7kAor6rjiMj+SKYBs8oBPAJ9FMUX5WJBT8UdPXrRm71lm9A9MTiVIjiYhr
 ufSw==
X-Gm-Message-State: AOAM530G9OL9t3VtCMihBRhJ4+Pi34BN42HQfNOPN/X7oEV/94uqFG+v
 YzSFIX6Y+dWwz9mhoLMWlim6Wg==
X-Google-Smtp-Source: ABdhPJxWh5VuvnxVzHg1hXVvHKS4O8oUFbCH3BrcZ/J9wYqZvKrr/xcdDBUJybZIB3+Txzd8Jp2CCg==
X-Received: by 2002:a62:f846:0:b029:15f:f897:7647 with SMTP id
 c6-20020a62f8460000b029015ff8977647mr1225887pfm.75.1603926919318; 
 Wed, 28 Oct 2020 16:15:19 -0700 (PDT)
Received: from [192.168.10.88] (124-171-72-187.dyn.iinet.net.au.
 [124.171.72.187])
 by smtp.gmail.com with UTF8SMTPSA id e6sm634704pfn.190.2020.10.28.16.15.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2020 16:15:18 -0700 (PDT)
Subject: Re: [PATCH kernel v3 1/2] dma: Allow mixing bypass and mapped DMA
 operation
To: Christoph Hellwig <hch@lst.de>
References: <20201028070030.60643-1-aik@ozlabs.ru>
 <20201028070030.60643-2-aik@ozlabs.ru> <20201028172201.GB10015@lst.de>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <2d9957af-23b6-943f-faac-fc7607b6e250@ozlabs.ru>
Date: Thu, 29 Oct 2020 10:15:13 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:83.0) Gecko/20100101
 Thunderbird/83.0
MIME-Version: 1.0
In-Reply-To: <20201028172201.GB10015@lst.de>
Content-Language: en-US
Cc: Michael Ellerman <mpe@ellerman.id.au>, iommu@lists.linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>



On 29/10/2020 04:22, Christoph Hellwig wrote:
> On Wed, Oct 28, 2020 at 06:00:29PM +1100, Alexey Kardashevskiy wrote:
>> At the moment we allow bypassing DMA ops only when we can do this for
>> the entire RAM. However there are configs with mixed type memory
>> where we could still allow bypassing IOMMU in most cases;
>> POWERPC with persistent memory is one example.
>>
>> This adds an arch hook to determine where bypass can still work and
>> we invoke direct DMA API. The following patch checks the bus limit
>> on POWERPC to allow or disallow direct mapping.
>>
>> This adds a CONFIG_ARCH_HAS_DMA_SET_MASK config option to make arch_xxxx
>> hooks no-op by default.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> ---
>>   kernel/dma/mapping.c | 24 ++++++++++++++++++++----
>>   kernel/dma/Kconfig   |  4 ++++
>>   2 files changed, 24 insertions(+), 4 deletions(-)
>>
>> diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
>> index 51bb8fa8eb89..a0bc9eb876ed 100644
>> --- a/kernel/dma/mapping.c
>> +++ b/kernel/dma/mapping.c
>> @@ -137,6 +137,18 @@ static inline bool dma_map_direct(struct device *dev,
>>   	return dma_go_direct(dev, *dev->dma_mask, ops);
>>   }
>>   
>> +#ifdef CONFIG_ARCH_HAS_DMA_MAP_DIRECT
>> +bool arch_dma_map_page_direct(struct device *dev, phys_addr_t addr);
>> +bool arch_dma_unmap_page_direct(struct device *dev, dma_addr_t dma_handle);
>> +bool arch_dma_map_sg_direct(struct device *dev, struct scatterlist *sg, int nents);
>> +bool arch_dma_unmap_sg_direct(struct device *dev, struct scatterlist *sg, int nents);
>> +#else
>> +#define arch_dma_map_page_direct(d, a) (0)
>> +#define arch_dma_unmap_page_direct(d, a) (0)
>> +#define arch_dma_map_sg_direct(d, s, n) (0)
>> +#define arch_dma_unmap_sg_direct(d, s, n) (0)
>> +#endif
> 
> A bunch of overly long lines here.  Except for that this looks ok to me.
> If you want me to queue up the series I can just fix it up.

I thought 100 is the new limit since 
https://lkml.org/lkml/2020/5/29/1038 (yeah that mentioned some Christoph 
:) ) and having these multiline does not make a huge difference but feel 
free fixing them up.

Are you going to take both patches? Do you need mpe's ack? Thanks,


-- 
Alexey
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
