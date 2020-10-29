Return-Path: <SRS0=7pZu=EE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB9E6C4363A
	for <iommu@archiver.kernel.org>; Thu, 29 Oct 2020 00:47:11 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2F232076B
	for <iommu@archiver.kernel.org>; Thu, 29 Oct 2020 00:47:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="wyUORgbJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2F232076B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 38E2F868D4;
	Thu, 29 Oct 2020 00:47:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0MHqQUAojlgi; Thu, 29 Oct 2020 00:47:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id DF29D8687D;
	Thu, 29 Oct 2020 00:47:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B7128C088B;
	Thu, 29 Oct 2020 00:47:08 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 05262C0051
 for <iommu@lists.linux-foundation.org>; Thu, 29 Oct 2020 00:47:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id EBB9285EBB
 for <iommu@lists.linux-foundation.org>; Thu, 29 Oct 2020 00:47:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id awXjrW-staRu for <iommu@lists.linux-foundation.org>;
 Thu, 29 Oct 2020 00:47:05 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com
 [209.85.210.196])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id B517C85E99
 for <iommu@lists.linux-foundation.org>; Thu, 29 Oct 2020 00:47:05 +0000 (UTC)
Received: by mail-pf1-f196.google.com with SMTP id 13so907161pfy.4
 for <iommu@lists.linux-foundation.org>; Wed, 28 Oct 2020 17:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ldq+BaCHFGxiQTunTg58Jqzdh7VCGURX37mdUjZn1eU=;
 b=wyUORgbJvh+A575hdAXGUhNMCPw2wjQqdKzftI+f9ACZ1VWqKMv2WzlcukXSGHIcQT
 O4SGKDkosOnrJcbFMx5mGpjzLYeu1wBdshKLKwvJo4ZtCVfJHt88nV6rwcNZRyLCcuBK
 WVKbePw2HHKJIMcwmeprnWx/gMfEJKOGWu1A6PQfxS5gXwsYa5EYNW9ZgkaRJD6NXdHy
 UwnvCCMf7VA/g3JCio7G29RkHOvr7uEbJawL51kzBquv9WVcdKW5CKAWL8Vu59p2Worl
 wlw/bljoUorb5DkysNzoumwxLEi0oHQk9XsUaS6x8RfbfndUZlGC1j9zvmQkwQnvSex5
 GGEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ldq+BaCHFGxiQTunTg58Jqzdh7VCGURX37mdUjZn1eU=;
 b=t/qmBE5nllNJpwPyyw37k99H9E4ysHWQByWdfFO8EPXHw9VVgD7dqbfqa6jll3pkOw
 7qXDMqba8AHB3C8eEBLjLIa33GOXrFbdt6rpR6GmCLeegfCkgGTV0VPnalcv8i+4GuHz
 7QIyyi5+JgAxO93AiOUtwy8q7X7rF2dtO+JH8tUCiLht8SH64kO5VXn27vayGjlEiFKG
 vZzjzVHYQc86bUwk6kx8t7dylWpQwRf45H01VnnV/20Pq16dPa+9FUHp0VAVVGmeHNq+
 ThrE9RaT05A5XSUFVe5BxgZbxa98I4qfe6XojMpsgsQzJS9obIG/bXnogtzPPmtwe4MY
 mCzQ==
X-Gm-Message-State: AOAM530JJOsmkGv8ypzewFpVT7gxWL27Uhr3Cx9Fg3+1ZFxnKZx4YR2h
 RzDiKVLt5zLYARZFXaWR6otFyg==
X-Google-Smtp-Source: ABdhPJwQeHwGAhLun9jUEWuolN0Z952UoAYpqBQvc1TiN1O0YqY/U4Wvi4c0j0oLKnp0h8WabeYK3g==
X-Received: by 2002:a63:b516:: with SMTP id y22mr1772608pge.154.1603932425075; 
 Wed, 28 Oct 2020 17:47:05 -0700 (PDT)
Received: from [192.168.10.88] (124-171-72-187.dyn.iinet.net.au.
 [124.171.72.187])
 by smtp.gmail.com with UTF8SMTPSA id v16sm533051pgk.26.2020.10.28.17.47.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2020 17:47:04 -0700 (PDT)
Subject: Re: [PATCH kernel v3 2/2] powerpc/dma: Fallback to dma_ops when
 persistent memory present
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
References: <20201028070030.60643-1-aik@ozlabs.ru>
 <20201028070030.60643-3-aik@ozlabs.ru> <87eelhx3t6.fsf@mpe.ellerman.id.au>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <2f285412-9e19-7888-1102-f50658c43b9d@ozlabs.ru>
Date: Thu, 29 Oct 2020 11:46:59 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:83.0) Gecko/20100101
 Thunderbird/83.0
MIME-Version: 1.0
In-Reply-To: <87eelhx3t6.fsf@mpe.ellerman.id.au>
Content-Language: en-US
Cc: iommu@lists.linux-foundation.org, Christoph Hellwig <hch@lst.de>,
 linux-kernel@vger.kernel.org
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



On 29/10/2020 11:40, Michael Ellerman wrote:
> Alexey Kardashevskiy <aik@ozlabs.ru> writes:
>> diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
>> index e4198700ed1a..91112e748491 100644
>> --- a/arch/powerpc/platforms/pseries/iommu.c
>> +++ b/arch/powerpc/platforms/pseries/iommu.c
>> @@ -1111,11 +1112,13 @@ static void reset_dma_window(struct pci_dev *dev, struct device_node *par_dn)
>>    */
>>   static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
>>   {
>> -	int len, ret;
>> +	int len = 0, ret;
>> +	bool pmem_present = of_find_node_by_type(NULL, "ibm,pmemory") != NULL;
> 
> That leaks a reference on the returned node.
> 
> 	dn = of_find_node_by_type(NULL, "ibm,pmemory");
> 	pmem_present = dn != NULL;
> 	of_node_put(dn);


ah, true. v4 then.


> 
> 
>> @@ -1126,7 +1129,7 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
>>   
>>   	mutex_lock(&direct_window_init_mutex);
>>   
>> -	dma_addr = find_existing_ddw(pdn);
>> +	dma_addr = find_existing_ddw(pdn, &len);
> 
> I don't see len used anywhere?
> 
>>   	if (dma_addr != 0)
>>   		goto out_unlock;
>>   
>> @@ -1212,14 +1215,26 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
>>   	}
>>   	/* verify the window * number of ptes will map the partition */
>>   	/* check largest block * page size > max memory hotplug addr */
>> -	max_addr = ddw_memory_hotplug_max();
>> -	if (query.largest_available_block < (max_addr >> page_shift)) {
>> -		dev_dbg(&dev->dev, "can't map partition max 0x%llx with %llu "
>> -			  "%llu-sized pages\n", max_addr,  query.largest_available_block,
>> -			  1ULL << page_shift);
>> +	/*
>> +	 * The "ibm,pmemory" can appear anywhere in the address space.
>> +	 * Assuming it is still backed by page structs, try MAX_PHYSMEM_BITS
>> +	 * for the upper limit and fallback to max RAM otherwise but this
>> +	 * disables device::dma_ops_bypass.
>> +	 */
>> +	len = max_ram_len;
> 
> Here you override whatever find_existing_ddw() wrote to len?


Not always, there is a bunch of gotos before this line to the end of the 
function and one (which returns the existing window) is legit. Thanks,



> 
>> +	if (pmem_present) {
>> +		if (query.largest_available_block >=
>> +		    (1ULL << (MAX_PHYSMEM_BITS - page_shift)))
>> +			len = MAX_PHYSMEM_BITS - page_shift;
>> +		else
>> +			dev_info(&dev->dev, "Skipping ibm,pmemory");
>> +	}
>> +
>> +	if (query.largest_available_block < (1ULL << (len - page_shift))) {
>> +		dev_dbg(&dev->dev, "can't map partition max 0x%llx with %llu %llu-sized pages\n",
>> +			1ULL << len, query.largest_available_block, 1ULL << page_shift);
>>   		goto out_failed;
>>   	}
>> -	len = order_base_2(max_addr);
>>   	win64 = kzalloc(sizeof(struct property), GFP_KERNEL);
>>   	if (!win64) {
>>   		dev_info(&dev->dev,
> 
> 
> cheers
> 

-- 
Alexey
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
