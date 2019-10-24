Return-Path: <SRS0=zRLl=YR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27915CA9EAF
	for <iommu@archiver.kernel.org>; Thu, 24 Oct 2019 15:20:32 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D30E20679
	for <iommu@archiver.kernel.org>; Thu, 24 Oct 2019 15:20:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=st.com header.i=@st.com header.b="IUvVhRIp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D30E20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 59DFA18F7;
	Thu, 24 Oct 2019 15:20:31 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 23B6C18D6
	for <iommu@lists.linux-foundation.org>;
	Thu, 24 Oct 2019 15:20:30 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
	[91.207.212.93])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 4815E8AD
	for <iommu@lists.linux-foundation.org>;
	Thu, 24 Oct 2019 15:20:28 +0000 (UTC)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
	x9OFH3GS017635; Thu, 24 Oct 2019 17:20:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com;
	h=subject : to : cc :
	references : from : message-id : date : mime-version : in-reply-to :
	content-type : content-transfer-encoding; s=STMicroelectronics;
	bh=QNHsJ9uUMrIhvHvb+yJoqP6loqC0Nl6kUiQ33jAuBWo=;
	b=IUvVhRIpmtjKgWasVawi6TYzF62atHW326S3fcxhDyhIAlCV1YCUeWHAfFyZLrhUXXij
	yywJjncFvB7woWM7t35KSmfAkeQBJwAf0v1HMetSyxJpbNV5q8XRMkGxlns7B/OPN5Oa
	nBDBlj2OzjZivifzHtaiuwgufQtVKwjXfSDrllI4m/XZxDEwmPtEEmVIEV02/kFBQuwA
	ZBAj7vUZ9lq2KnbWSP19LeldffOO81PMSdWp8theGOntRCpYzBAbrZiwvHZvsfqiScyR
	fm9Iu18n3asDI92+3VoISEpKIpkEE6dEFdpEWToMWw8Mvg+iiFyc5+M+nfUZnCLg6lkJ
	rw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
	by mx08-00178001.pphosted.com with ESMTP id 2vt9s52guq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NOT); Thu, 24 Oct 2019 17:20:24 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B52FD100034;
	Thu, 24 Oct 2019 17:20:23 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8463F2C49F4; 
	Thu, 24 Oct 2019 17:20:23 +0200 (CEST)
Received: from lmecxl0912.lme.st.com (10.75.127.45) by SFHDAG3NODE2.st.com
	(10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2;
	Thu, 24 Oct 2019 17:20:23 +0200
Subject: Re: [BUG] dma-ranges, reserved memory regions, dma_alloc_coherent:
	possible bug?
To: Vladimir Murzin <vladimir.murzin@arm.com>, Robin Murphy
	<robin.murphy@arm.com>, Daniele Alessandrelli
	<daniele.alessandrelli@gmail.com>, Christoph Hellwig <hch@lst.de>, Marek
	Szyprowski <m.szyprowski@samsung.com>
References: <CAA2QUqLv+eLXuA_TdJ7zM4oBnGoFVOjRjAimuct2y=0MDuaZVQ@mail.gmail.com>
	<d983cf57-f13d-a680-21c4-09b5ca93bc64@arm.com>
	<acf0dd2c-7e12-fba6-b7f8-dfd78c892fe5@arm.com>
	<417fa080-08f9-9f35-687b-c0b82a61628d@arm.com>
	<376133e3-25f2-ffe7-ef9f-4613388b2bf7@arm.com>
From: Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <84747008-85e9-e71a-b9ad-cefcc6c0f661@st.com>
Date: Thu, 24 Oct 2019 17:20:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <376133e3-25f2-ffe7-ef9f-4613388b2bf7@arm.com>
Content-Language: en-US
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG3NODE1.st.com (10.75.127.7) To SFHDAG3NODE2.st.com
	(10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
	definitions=2019-10-24_09:2019-10-23,2019-10-24 signatures=0
Cc: iommu@lists.linux-foundation.org, Arnd Bergmann <arnd@arndb.de>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Hi Vlad,

On 10/24/19 2:43 PM, Vladimir Murzin wrote:
> On 10/17/19 10:46 AM, Vladimir Murzin wrote:
>> I'm wondering if I've missed something with diff bellow (it was a long time ago when I touched DMA)?
> 
> Any comments on that? I can only build test it, so lack of testing stopping me from sending it as a
> proper patch :(

I can make some tests tomorrow. Which particular setup I need to test: 
cortex M7 + cache + dma + xip ? Let me know.

regards
alex

> 
>>
>> diff --git a/arch/arm/mm/dma-mapping-nommu.c b/arch/arm/mm/dma-mapping-nommu.c
>> index db92478..287ef89 100644
>> --- a/arch/arm/mm/dma-mapping-nommu.c
>> +++ b/arch/arm/mm/dma-mapping-nommu.c
>> @@ -35,7 +35,7 @@ static void *arm_nommu_dma_alloc(struct device *dev, size_t size,
>>   				 unsigned long attrs)
>>   
>>   {
>> -	void *ret = dma_alloc_from_global_coherent(size, dma_handle);
>> +	void *ret = dma_alloc_from_global_coherent(dev, size, dma_handle);
>>   
>>   	/*
>>   	 * dma_alloc_from_global_coherent() may fail because:
>> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
>> index 4a1c4fc..10918c5 100644
>> --- a/include/linux/dma-mapping.h
>> +++ b/include/linux/dma-mapping.h
>> @@ -162,7 +162,7 @@ int dma_release_from_dev_coherent(struct device *dev, int order, void *vaddr);
>>   int dma_mmap_from_dev_coherent(struct device *dev, struct vm_area_struct *vma,
>>   			    void *cpu_addr, size_t size, int *ret);
>>   
>> -void *dma_alloc_from_global_coherent(ssize_t size, dma_addr_t *dma_handle);
>> +void *dma_alloc_from_global_coherent(struct device *dev, ssize_t size, dma_addr_t *dma_handle);
>>   int dma_release_from_global_coherent(int order, void *vaddr);
>>   int dma_mmap_from_global_coherent(struct vm_area_struct *vma, void *cpu_addr,
>>   				  size_t size, int *ret);
>> @@ -172,7 +172,7 @@ int dma_mmap_from_global_coherent(struct vm_area_struct *vma, void *cpu_addr,
>>   #define dma_release_from_dev_coherent(dev, order, vaddr) (0)
>>   #define dma_mmap_from_dev_coherent(dev, vma, vaddr, order, ret) (0)
>>   
>> -static inline void *dma_alloc_from_global_coherent(ssize_t size,
>> +static inline void *dma_alloc_from_global_coherent(struct device *dev, ssize_t size,
>>   						   dma_addr_t *dma_handle)
>>   {
>>   	return NULL;
>> diff --git a/kernel/dma/coherent.c b/kernel/dma/coherent.c
>> index 545e386..551b0eb 100644
>> --- a/kernel/dma/coherent.c
>> +++ b/kernel/dma/coherent.c
>> @@ -123,8 +123,9 @@ int dma_declare_coherent_memory(struct device *dev, phys_addr_t phys_addr,
>>   	return ret;
>>   }
>>   
>> -static void *__dma_alloc_from_coherent(struct dma_coherent_mem *mem,
>> -		ssize_t size, dma_addr_t *dma_handle)
>> +static void *__dma_alloc_from_coherent(struct device *dev,
>> +				       struct dma_coherent_mem *mem,
>> +				       ssize_t size, dma_addr_t *dma_handle)
>>   {
>>   	int order = get_order(size);
>>   	unsigned long flags;
>> @@ -143,7 +144,7 @@ static void *__dma_alloc_from_coherent(struct dma_coherent_mem *mem,
>>   	/*
>>   	 * Memory was found in the coherent area.
>>   	 */
>> -	*dma_handle = mem->device_base + (pageno << PAGE_SHIFT);
>> +	*dma_handle = dma_get_device_base(dev, mem) + (pageno << PAGE_SHIFT);
>>   	ret = mem->virt_base + (pageno << PAGE_SHIFT);
>>   	spin_unlock_irqrestore(&mem->spinlock, flags);
>>   	memset(ret, 0, size);
>> @@ -175,17 +176,18 @@ int dma_alloc_from_dev_coherent(struct device *dev, ssize_t size,
>>   	if (!mem)
>>   		return 0;
>>   
>> -	*ret = __dma_alloc_from_coherent(mem, size, dma_handle);
>> +	*ret = __dma_alloc_from_coherent(dev, mem, size, dma_handle);
>>   	return 1;
>>   }
>>   
>> -void *dma_alloc_from_global_coherent(ssize_t size, dma_addr_t *dma_handle)
>> +void *dma_alloc_from_global_coherent(struct device *dev, ssize_t size,
>> +				     dma_addr_t *dma_handle)
>>   {
>>   	if (!dma_coherent_default_memory)
>>   		return NULL;
>>   
>> -	return __dma_alloc_from_coherent(dma_coherent_default_memory, size,
>> -			dma_handle);
>> +	return __dma_alloc_from_coherent(dev, dma_coherent_default_memory, size,
>> +					 dma_handle);
>>   }
>>   
>>   static int __dma_release_from_coherent(struct dma_coherent_mem *mem,
> 
> 
> Thanks
> Vladimir
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
