Return-Path: <SRS0=SOau=JM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C337CC433B4
	for <iommu@archiver.kernel.org>; Thu, 15 Apr 2021 13:10:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B74D611AC
	for <iommu@archiver.kernel.org>; Thu, 15 Apr 2021 13:10:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B74D611AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 49E218450E;
	Thu, 15 Apr 2021 13:10:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id j35huCPNWx9O; Thu, 15 Apr 2021 13:10:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4342C84536;
	Thu, 15 Apr 2021 13:10:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 216EFC000B;
	Thu, 15 Apr 2021 13:10:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 47629C000A
 for <iommu@lists.linux-foundation.org>; Thu, 15 Apr 2021 13:10:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 350646075E
 for <iommu@lists.linux-foundation.org>; Thu, 15 Apr 2021 13:10:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wFuiKyHVuwTk for <iommu@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 13:10:06 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9476960680
 for <iommu@lists.linux-foundation.org>; Thu, 15 Apr 2021 13:10:06 +0000 (UTC)
Received: by mail-pj1-x102f.google.com with SMTP id
 b8-20020a17090a5508b029014d0fbe9b64so14368868pji.5
 for <iommu@lists.linux-foundation.org>; Thu, 15 Apr 2021 06:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=poev2NLsdLHtupyejHZKkNm25xi1OhRVKq9U5bDqj4Y=;
 b=KNPOcw6j5OJVFQEITV0zl9nFv5wKiaDDOVhQTVZrioNOvxNbbVVePVc0Sac2AFTGrn
 LlCmeEVxZX+TnHB0bM5v2GNgxRliBXndsENyyTgtkkKKBcDSLLVHjcAeoy4/izS0zN1a
 etTIL7G7cjXthlIai4+MlcuJE55+AsRYbU2INYQgl6CQrMKyUFjcADhDGiNrtlqiOCt6
 wqIhbyYLAjYpIB7wZSTDzWH/LqGKTXUWPUaFeTmioIxNh4vGA/JPtduGa0Fz34q5nXcW
 zfPZgL0526MtUGxhiF/6saD0A/Ce6362fgGEfoId8ApT8eB6FOZH1vjk4OXKV65p4axK
 y3MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=poev2NLsdLHtupyejHZKkNm25xi1OhRVKq9U5bDqj4Y=;
 b=T1cptL/2S27xk/Xz9Mz6xGk72+2+cWMeiYs28c9zXICWqDYEjrqLDN4AJisQlKi2wx
 D6yS3Fv6r1bYNJ+MqdA/HG8SyIbYkfdD2+1icLGZOaKLTmfE/5Jnrz6psME4JVvrStEu
 NZngzpXICeLWE41yiXrCM0u+khWRSVZ9qYL4SUdMbRK9pWc7HR1hMa2lRNLMSvxQME+Z
 roA+5UjC4qdpkbHTQyCS5KLgsuqCj4Noyjrj6RXfAv5z4B66TmKfpr9hPq3klUYWBnca
 1XllTsXY5ZezZq+mf/H8D4M/Ia+NXcITUSm/L1JXH41dKk+tbGGz28YG17azRS/eDwLH
 DVfQ==
X-Gm-Message-State: AOAM5316WQRIkaMapciAsuPCZ81KsIkAvLjW/d36DfsMj96ctZ1vxWMs
 +f5HaG4F56AZJAKCVHs0k/0=
X-Google-Smtp-Source: ABdhPJwLo3XW1PFky/UiL6FgUhppPKomCXhZ8RcTFkrZOoCyJE0LFKn72YJmHoMyXVfQisS1eSMY5A==
X-Received: by 2002:a17:90a:94ca:: with SMTP id
 j10mr3897484pjw.126.1618492205922; 
 Thu, 15 Apr 2021 06:10:05 -0700 (PDT)
Received: from ?IPv6:2404:f801:0:6:8000::a31c? ([2404:f801:9000:1a:efeb::a31c])
 by smtp.gmail.com with ESMTPSA id s21sm2499994pjr.52.2021.04.15.06.09.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Apr 2021 06:10:05 -0700 (PDT)
Subject: Re: [Resend RFC PATCH V2 08/12] UIO/Hyper-V: Not load UIO HV driver
 in the isolation VM.
To: Greg KH <gregkh@linuxfoundation.org>
References: <20210414144945.3460554-1-ltykernel@gmail.com>
 <20210414144945.3460554-9-ltykernel@gmail.com> <YHcOL+HlEoh5jPb8@kroah.com>
From: Tianyu Lan <ltykernel@gmail.com>
Message-ID: <eec53f89-4a18-39ce-aff8-c07be2ce3971@gmail.com>
Date: Thu, 15 Apr 2021 21:09:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <YHcOL+HlEoh5jPb8@kroah.com>
Content-Language: en-US
Cc: linux-hyperv@vger.kernel.org, brijesh.singh@amd.com, linux-mm@kvack.org,
 hpa@zytor.com, kys@microsoft.com, will@kernel.org, hch@lst.de,
 linux-arch@vger.kernel.org, wei.liu@kernel.org, sthemmin@microsoft.com,
 linux-scsi@vger.kernel.org, x86@kernel.org, mingo@redhat.com, kuba@kernel.org,
 jejb@linux.ibm.com, thomas.lendacky@amd.com,
 Tianyu Lan <Tianyu.Lan@microsoft.com>, arnd@arndb.de, konrad.wilk@oracle.com,
 haiyangz@microsoft.com, bp@alien8.de, tglx@linutronix.de, vkuznets@redhat.com,
 martin.petersen@oracle.com, netdev@vger.kernel.org, sunilmut@microsoft.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 akpm@linux-foundation.org, robin.murphy@arm.com, davem@davemloft.net
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



On 4/14/2021 11:45 PM, Greg KH wrote:
> On Wed, Apr 14, 2021 at 10:49:41AM -0400, Tianyu Lan wrote:
>> From: Tianyu Lan <Tianyu.Lan@microsoft.com>
>>
>> UIO HV driver should not load in the isolation VM for security reason.
>> Return ENOTSUPP in the hv_uio_probe() in the isolation VM.
>>
>> Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
>> ---
>>   drivers/uio/uio_hv_generic.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/uio/uio_hv_generic.c b/drivers/uio/uio_hv_generic.c
>> index 0330ba99730e..678b021d66f8 100644
>> --- a/drivers/uio/uio_hv_generic.c
>> +++ b/drivers/uio/uio_hv_generic.c
>> @@ -29,6 +29,7 @@
>>   #include <linux/hyperv.h>
>>   #include <linux/vmalloc.h>
>>   #include <linux/slab.h>
>> +#include <asm/mshyperv.h>
>>   
>>   #include "../hv/hyperv_vmbus.h"
>>   
>> @@ -241,6 +242,10 @@ hv_uio_probe(struct hv_device *dev,
>>   	void *ring_buffer;
>>   	int ret;
>>   
>> +	/* UIO driver should not be loaded in the isolation VM.*/
>> +	if (hv_is_isolation_supported())
>> +		return -ENOTSUPP;
>> +		
>>   	/* Communicating with host has to be via shared memory not hypercall */
>>   	if (!channel->offermsg.monitor_allocated) {
>>   		dev_err(&dev->device, "vmbus channel requires hypercall\n");
>> -- 
>> 2.25.1
>>
> 
> Again you send out known-wrong patches?
> 
> :(
> 
Sorry for noise. Will fix this next version and I think we should make 
sure user space driver to check data from host. This patch will be removed.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
