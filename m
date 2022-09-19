Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E98A7C
	for <iommu@lists.linux.dev>; Mon, 19 Sep 2022 03:02:32 +0000 (UTC)
Received: by mail-pf1-f182.google.com with SMTP id l65so26768458pfl.8
        for <iommu@lists.linux.dev>; Sun, 18 Sep 2022 20:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date;
        bh=Rrb1GWEMi9ffsowkjXESsGPuxxviTZnGekRYguH1g3A=;
        b=E1M+PVT9l7jTqd/R20YDxSFv++yg3N9mIBAx71hxCP38IcGVF8m4vJha6fx779ArsM
         Dppi8ivbAG7OB4xUQdEeDSUDLF6Zdb2fanSNSh2ZHb4fErZo/b+lnAbdTk3v7LCHTTgt
         edW4FYrqV+hjqgNS/8VlkF20TvbFC2GRAOsCfd2DYU4q7D9G55Q4+vVCuDVmv+unSjsa
         iP5kwi8GDFjlXjQUfzCTJ4c4Jt/AfVJ7AtP72aHzJ7QKZRMRE3ueL6V7INcb70UmRdVv
         DhjtXpM4/G1Q7HnzZYqaIPRHfSYwFSVlnu6SDj8vKjiOb96HNoW967GmbmOjyKf7hTTd
         T9XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date;
        bh=Rrb1GWEMi9ffsowkjXESsGPuxxviTZnGekRYguH1g3A=;
        b=4w97wKqjUcdQeKqpg4/YoZZMQln1hDwSKgwKSiyZaZdkN4rVYUKekFFRZeHgzXcs96
         fnNbURE1VuQFeznIuSOeA5t/7hPmWVwnQBtEotpG9PR9pv8a+cy6QRcM5DFXKe01XJW4
         tPsOK20xVyVXdpSMrb82ov7UpPSC7kJjXOwhRI/00Xn592mXwtEiTLnnlV4vrS9mcbv4
         m+OTwC771L1+4BD4r8lUcnb9zqZ6fpW90WXvKjCNqDFLrUCzd9WiD8yxxlSes7iFMZG+
         Ld1qcpHIlX23OHU9qQINmcgSvgHqlP/j993guodMlQzT04K1ScKgYUvI8my6nGlNdI0e
         NELw==
X-Gm-Message-State: ACrzQf1pDabcjNQgsG6Tyd83RT5x4UBxXzRM8tj007tUkIy7Uk6gNr+G
	AMA2odUq4623NmoLEGatNkA=
X-Google-Smtp-Source: AMsMyM5IYzek8yQ8JIcgEHTBXzCsxpR0XZ21e/zCT7QqzL9Jyva9cG1uhoxgNbpqlBV5/lNuzKYBZw==
X-Received: by 2002:a63:6cc1:0:b0:42b:d2c5:74a2 with SMTP id h184-20020a636cc1000000b0042bd2c574a2mr13745792pgc.420.1663556552270;
        Sun, 18 Sep 2022 20:02:32 -0700 (PDT)
Received: from [10.211.55.4] ([143.92.127.237])
        by smtp.gmail.com with ESMTPSA id h7-20020aa796c7000000b0053f2505318asm19440000pfq.142.2022.09.18.20.02.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Sep 2022 20:02:31 -0700 (PDT)
Message-ID: <74df1635-138a-1346-2756-60db7a03855b@gmail.com>
Date: Mon, 19 Sep 2022 11:02:28 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH] iommu/iova: using separate rcache for SAC and DAC
To: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org, will@kernel.org
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220916154613.104965-1-brookxu.cn@gmail.com>
 <7317c5f1-be57-7ddd-36d0-5b80226462fd@arm.com>
From: "brookxu.cn@gmail.com" <brookxu.cn@gmail.com>
In-Reply-To: <7317c5f1-be57-7ddd-36d0-5b80226462fd@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2022/9/17 1:03, Robin Murphy 写道:
> On 2022-09-16 16:46, brookxu.cn wrote:
>> From: Chunguang Xu <chunguang.xu@shopee.com>
>>
>> While iommu_dma_forcedac disable, for PCI device kernel
>> try SAC first, if failed then try DAC. Since now rcache
>> does not distinguish SAC and DAC, if all PFNs contained
>> in cpu loaded cache is larger than SAC max PFN, but the
>> SAC address space is sufficient, as cpu loaded cached is
>> not empty, kernel will iova_alloc () to alloc IOVA. For
>> PCI device, kernel alloc SAC most, loaded cache may
>> invalid for SAC alloc for a long time, kernel will enter
>> alloc_iova() slow path frequencely, as result performance
>> is degrade. To circumvent this problem, SAC and DAC maybe
>> better to use separate caches.
> 
> I really dislike the idea of doubling the already significantly large 
> footprint of rcaches purely to optimise for the stupid case. If you've 
> got to the point of hitting contention in the SAC path, you presumably 
> don't have broken hardware/drivers so you're infinitely better off using 
> forcedac and avoiding it entirely to begin with. And frankly even if you 
> *do* have broken hardware, if you care about performance you're still 
> better off fixing the relevant driver(s) to set correct DMA masks so you 
> can use forcedac.

Some of our NICs have poor performance after heavy traffic impact. We 
found that it maybe caused by a large number of 1-2 order IOVA SAC 
address applications to make SAC address space fragmentation during 
taffic impact, which in turn causes some 3 order IOVA SAC address 
applications to fail. Kernel will try DAC address and release it into 
rcache. After the traffic recovery, and SAC address space recovery from 
fragmentation, but due to the existence of several DAC PFN on the cache 
of a certain CPU,  which will broken the usage of rcache for SAC address 
application. As a result, kernel will enter alloc_iova() slow path 
frequencely and performance is poor. So I think this issue should be not 
too much of a broken hardware or driver,  but they maybe can also be 
optimized.

> 
> Since this mechanism now officially serves as a bandage for broken 
> hardware/drivers and little else, I had an idea to make it a lot better, 
> guess it's time to have a go at writing that patch up...
> 
> Thanks,
> Robin.
> 
>> Signed-off-by: Chunguang Xu <chunguang.xu@shopee.com>
>> ---
>>   drivers/iommu/iova.c | 28 +++++++++++++++++++++-------
>>   1 file changed, 21 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
>> index 47d1983dfa2a..d5775719a143 100644
>> --- a/drivers/iommu/iova.c
>> +++ b/drivers/iommu/iova.c
>> @@ -16,6 +16,7 @@
>>   #define IOVA_ANCHOR    ~0UL
>>   #define IOVA_RANGE_CACHE_MAX_SIZE 6    /* log of max cached IOVA 
>> range size (in pages) */
>> +#define IOVA_RANGE_CACHE_ARRAY_SIZE (2 * IOVA_RANGE_CACHE_MAX_SIZE)
>>   static bool iova_rcache_insert(struct iova_domain *iovad,
>>                      unsigned long pfn,
>> @@ -723,13 +724,13 @@ int iova_domain_init_rcaches(struct iova_domain 
>> *iovad)
>>       unsigned int cpu;
>>       int i, ret;
>> -    iovad->rcaches = kcalloc(IOVA_RANGE_CACHE_MAX_SIZE,
>> +    iovad->rcaches = kcalloc(IOVA_RANGE_CACHE_ARRAY_SIZE,
>>                    sizeof(struct iova_rcache),
>>                    GFP_KERNEL);
>>       if (!iovad->rcaches)
>>           return -ENOMEM;
>> -    for (i = 0; i < IOVA_RANGE_CACHE_MAX_SIZE; ++i) {
>> +    for (i = 0; i < IOVA_RANGE_CACHE_ARRAY_SIZE; ++i) {
>>           struct iova_cpu_rcache *cpu_rcache;
>>           struct iova_rcache *rcache;
>> @@ -825,11 +826,15 @@ static bool iova_rcache_insert(struct 
>> iova_domain *iovad, unsigned long pfn,
>>                      unsigned long size)
>>   {
>>       unsigned int log_size = order_base_2(size);
>> +    unsigned int index;
>>       if (log_size >= IOVA_RANGE_CACHE_MAX_SIZE)
>>           return false;
>> -    return __iova_rcache_insert(iovad, &iovad->rcaches[log_size], pfn);
>> +    if (pfn > DMA_BIT_MASK(32))
>> +        index = log_size + IOVA_RANGE_CACHE_MAX_SIZE;
>> +
>> +    return __iova_rcache_insert(iovad, &iovad->rcaches[index], pfn);
>>   }
>>   /*
>> @@ -881,11 +886,20 @@ static unsigned long iova_rcache_get(struct 
>> iova_domain *iovad,
>>                        unsigned long limit_pfn)
>>   {
>>       unsigned int log_size = order_base_2(size);
>> +    unsigned long iova_pfn;
>> +    unsigned int index;
>>       if (log_size >= IOVA_RANGE_CACHE_MAX_SIZE || !iovad->rcaches)
>>           return 0;
>> -    return __iova_rcache_get(&iovad->rcaches[log_size], limit_pfn - 
>> size);
>> +    iova_pfn = __iova_rcache_get(&iovad->rcaches[log_size], limit_pfn 
>> - size);
>> +
>> +    if (!iova_pfn && limit_pfn > DMA_BIT_MASK(32)) {
>> +        index = log_size + IOVA_RANGE_CACHE_MAX_SIZE;
>> +        iova_pfn = __iova_rcache_get(&iovad->rcaches[index], 
>> limit_pfn - size);
>> +    }
>> +
>> +    return iova_pfn
>>   }
>>   /*
>> @@ -898,7 +912,7 @@ static void free_iova_rcaches(struct iova_domain 
>> *iovad)
>>       unsigned int cpu;
>>       int i, j;
>> -    for (i = 0; i < IOVA_RANGE_CACHE_MAX_SIZE; ++i) {
>> +    for (i = 0; i < IOVA_RANGE_CACHE_ARRAY_SIZE; ++i) {
>>           rcache = &iovad->rcaches[i];
>>           if (!rcache->cpu_rcaches)
>>               break;
>> @@ -926,7 +940,7 @@ static void free_cpu_cached_iovas(unsigned int 
>> cpu, struct iova_domain *iovad)
>>       unsigned long flags;
>>       int i;
>> -    for (i = 0; i < IOVA_RANGE_CACHE_MAX_SIZE; ++i) {
>> +    for (i = 0; i < IOVA_RANGE_CACHE_ARRAY_SIZE; ++i) {
>>           rcache = &iovad->rcaches[i];
>>           cpu_rcache = per_cpu_ptr(rcache->cpu_rcaches, cpu);
>>           spin_lock_irqsave(&cpu_rcache->lock, flags);
>> @@ -945,7 +959,7 @@ static void free_global_cached_iovas(struct 
>> iova_domain *iovad)
>>       unsigned long flags;
>>       int i, j;
>> -    for (i = 0; i < IOVA_RANGE_CACHE_MAX_SIZE; ++i) {
>> +    for (i = 0; i < IOVA_RANGE_CACHE_ARRAY_SIZE; ++i) {
>>           rcache = &iovad->rcaches[i];
>>           spin_lock_irqsave(&rcache->lock, flags);
>>           for (j = 0; j < rcache->depot_size; ++j) {
