Return-Path: <SRS0=SOau=JM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE16C43600
	for <iommu@archiver.kernel.org>; Thu, 15 Apr 2021 08:40:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 722D56139A
	for <iommu@archiver.kernel.org>; Thu, 15 Apr 2021 08:40:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 722D56139A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3540140F9C;
	Thu, 15 Apr 2021 08:40:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pK9Q0TpgbW8T; Thu, 15 Apr 2021 08:40:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 01DD840605;
	Thu, 15 Apr 2021 08:39:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C0175C000C;
	Thu, 15 Apr 2021 08:39:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1A582C000A
 for <iommu@lists.linux-foundation.org>; Thu, 15 Apr 2021 08:39:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EE2AD40605
 for <iommu@lists.linux-foundation.org>; Thu, 15 Apr 2021 08:39:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gGE8aKx6rnMk for <iommu@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 08:39:57 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3996F405E9
 for <iommu@lists.linux-foundation.org>; Thu, 15 Apr 2021 08:39:57 +0000 (UTC)
Received: by mail-pf1-x431.google.com with SMTP id 10so6711254pfl.1
 for <iommu@lists.linux-foundation.org>; Thu, 15 Apr 2021 01:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=3tRTg0shzbghpK8s5KkDpORVJgOU6nXvQDc4YptWxp4=;
 b=dzupOljK/n2OhOKq3IFzO/jpubmmgifqonI7cIVcK57nYONTDn0gN+SMqd+LVuhEue
 vSOJmf26iaOeofbY33+7llZWIbG92xNXaeesFkp0AroekPl+iUY+XDIvyc5flXvsoEht
 MVOKE1W2f9eGWDOGOYFjhcZC1B0OTfJfA7W2qzrPcXDekA8tmSlR2QPNB5MryIIYQZbz
 ssdKILAwuvYxQTVduNjgdr6acCBmQgkipEXGjIFt51ycr+XxjnOqTeHVyfVVJxloaLud
 HhtVRgp39rFZsswxe1bP3XX88qm2K7hfI04uSV4FuUyBP6bcWcG9umfpyC/scl3ngPhd
 V10Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3tRTg0shzbghpK8s5KkDpORVJgOU6nXvQDc4YptWxp4=;
 b=FzOvNT4lzzwXkWpCIRV5TgPrUo/L1WAOCShEhrzsfHVEF7k92idFyNFJ3UKdnrhyu1
 X0fm6vM6IHDrmWH1bUpMH3SckB1MaLjwHdGdeMl/aoAATbAmtCNTsY1k1ykn3xJiYTvW
 5D6Pw+TYiCpwffwnQpfJfo6P0R9TgSfmz30/7bIyjE9ZfbaPBxbfrXW8agOR1YMNnalf
 rFqujT12bHKYL7NPrz+xpiCD8mJ7tRNagGZV3HO2f84JtvjcCdFgswoO7FfXMrDXj03i
 EbVVy/+xLbDwnrXqZxTxGKvZ3TG4vSbvPjR16cF4mFOuuKYDocD91c8YglB2NUyPs+wp
 6BYA==
X-Gm-Message-State: AOAM530vx5aZOLO5Sh8DBS69fFz6ug0yG+iK878z33/ro3jcO5LqYtrl
 P6QNNHbOojHBtK1dIlDHjQY=
X-Google-Smtp-Source: ABdhPJz/E8YagRoaQfmGydf9eGCq3z8Im0ouKOCNMw/9TlVzNQ5NsPj3ODCpxu/cZ1XaZZeQpmJi/Q==
X-Received: by 2002:a62:e119:0:b029:245:8e0:820 with SMTP id
 q25-20020a62e1190000b029024508e00820mr2092886pfh.4.1618475996564; 
 Thu, 15 Apr 2021 01:39:56 -0700 (PDT)
Received: from ?IPv6:2404:f801:0:6:8000::a31c? ([2404:f801:9000:1a:efeb::a31c])
 by smtp.gmail.com with ESMTPSA id t67sm1573474pfb.210.2021.04.15.01.39.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Apr 2021 01:39:56 -0700 (PDT)
Subject: Re: [Resend RFC PATCH V2 11/12] HV/Netvsc: Add Isolation VM support
 for netvsc driver
To: Christoph Hellwig <hch@lst.de>
References: <20210414144945.3460554-1-ltykernel@gmail.com>
 <20210414144945.3460554-12-ltykernel@gmail.com>
 <20210414155016.GE32045@lst.de>
From: Tianyu Lan <ltykernel@gmail.com>
Message-ID: <de145e13-2444-aa01-906e-e3abe5a64dc4@gmail.com>
Date: Thu, 15 Apr 2021 16:39:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210414155016.GE32045@lst.de>
Content-Language: en-US
Cc: linux-hyperv@vger.kernel.org, brijesh.singh@amd.com, linux-mm@kvack.org,
 hpa@zytor.com, kys@microsoft.com, will@kernel.org, sunilmut@microsoft.com,
 linux-arch@vger.kernel.org, wei.liu@kernel.org, sthemmin@microsoft.com,
 linux-scsi@vger.kernel.org, x86@kernel.org, mingo@redhat.com, kuba@kernel.org,
 jejb@linux.ibm.com, thomas.lendacky@amd.com,
 Tianyu Lan <Tianyu.Lan@microsoft.com>, arnd@arndb.de, konrad.wilk@oracle.com,
 haiyangz@microsoft.com, bp@alien8.de, tglx@linutronix.de, vkuznets@redhat.com,
 martin.petersen@oracle.com, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 netdev@vger.kernel.org, akpm@linux-foundation.org, robin.murphy@arm.com,
 davem@davemloft.net
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



On 4/14/2021 11:50 PM, Christoph Hellwig wrote:
>> +struct dma_range {
>> +	dma_addr_t dma;
>> +	u32 mapping_size;
>> +};
> 
> That's a rather generic name that is bound to create a conflict sooner
> or later.

Good point. Will update.

> 
>>   #include "hyperv_net.h"
>>   #include "netvsc_trace.h"
>> +#include "../../hv/hyperv_vmbus.h"
> 
> Please move public interfaces out of the private header rather than doing
> this.

OK. Will update.

> 
>> +	if (hv_isolation_type_snp()) {
>> +		area = get_vm_area(buf_size, VM_IOREMAP);
> 
> Err, no.  get_vm_area is private a for a reason.
> 
>> +		if (!area)
>> +			goto cleanup;
>> +
>> +		vaddr = (unsigned long)area->addr;
>> +		for (i = 0; i < buf_size / HV_HYP_PAGE_SIZE; i++) {
>> +			extra_phys = (virt_to_hvpfn(net_device->recv_buf + i * HV_HYP_PAGE_SIZE)
>> +				<< HV_HYP_PAGE_SHIFT) + ms_hyperv.shared_gpa_boundary;
>> +			ret |= ioremap_page_range(vaddr + i * HV_HYP_PAGE_SIZE,
>> +					   vaddr + (i + 1) * HV_HYP_PAGE_SIZE,
>> +					   extra_phys, PAGE_KERNEL_IO);
>> +		}
>> +
>> +		if (ret)
>> +			goto cleanup;
> 
> And this is not something a driver should ever do.  I think you are badly
> reimplementing functionality that should be in the dma coherent allocator
> here.
>
OK. I will try hiding these in the Hyper-V dma ops callback. Thanks.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
