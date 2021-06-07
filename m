Return-Path: <SRS0=ynGH=LB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF4EBC47082
	for <iommu@archiver.kernel.org>; Mon,  7 Jun 2021 15:21:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9303660FF0
	for <iommu@archiver.kernel.org>; Mon,  7 Jun 2021 15:21:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9303660FF0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 69821607AB;
	Mon,  7 Jun 2021 15:21:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id i3YQBLxSPE3x; Mon,  7 Jun 2021 15:21:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4E1AA60626;
	Mon,  7 Jun 2021 15:21:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2B2C7C000E;
	Mon,  7 Jun 2021 15:21:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EA7F0C0001
 for <iommu@lists.linux-foundation.org>; Mon,  7 Jun 2021 15:21:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CAFE182CDD
 for <iommu@lists.linux-foundation.org>; Mon,  7 Jun 2021 15:21:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id z3VPS00DQG7g for <iommu@lists.linux-foundation.org>;
 Mon,  7 Jun 2021 15:21:34 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6C981828F5
 for <iommu@lists.linux-foundation.org>; Mon,  7 Jun 2021 15:21:34 +0000 (UTC)
Received: by mail-pj1-x1033.google.com with SMTP id
 o17-20020a17090a9f91b029015cef5b3c50so12161911pjp.4
 for <iommu@lists.linux-foundation.org>; Mon, 07 Jun 2021 08:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=AqJMsqQ4KNSlTkis4vnlFWwGNt3Bx7s+42JKf63F/jc=;
 b=WsBdcRsefCiECb9IqTSuqCUv8coeVKPfrhSnmSii/c3l1gmGod3/U/htpg5pceudXy
 aYMrb18s8dW7vOcfl+l3/JLyfgriswqTmUyfzOzd+MpR4PFDQBqNxGysTptsKMLLdnqS
 jvqIZCDUxhyEXhn3kFG8PvvaL25gkKk9fhLU2Y6GVkr75vdb0Ve9OxPhhCsLOSZbZ46o
 oReEyqo0bUD1A3JvfVwFOyoUdnbneVTJbIjly5SDJg+VKDoLMXo7YsQjaqCn4F5oQkI9
 W8T56TKPKa5QxGA65hUQQsSol/AsF5UgHxkBXTE4sP50uacN6R0GzZbY+xLSbeosBWte
 pywQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=AqJMsqQ4KNSlTkis4vnlFWwGNt3Bx7s+42JKf63F/jc=;
 b=HLbYkGBBcaQCOfdZGc8VVTcBzW0u7UsL04glAOH04JJL+HfHD08lN+vsmExPbKGmKv
 ZKr/6lJjaoUp2xHE3gKa/PO6DVGFsMhfc+iBayFpUoXuL/WrTGDua+sV9XGXkPlZ59O/
 kINRnOYtWjnkVJ0Gx/BxYl31m+rUbwqU0ZkKWe6xzl5wKjCwLEEOS1yK0pTZJBdORRXQ
 l7pC39mH75m17Fh9odemUi1mSIfdd0TnbrTn+9HcXMKk2pzKlq44tpgbSv9D5fKY+GEn
 tx8z5sTbIWU9wcgLKWVTcp0ErGk2W3vXSYirNv5nu1IPEAIyZMibhVz3edlpmREd61o7
 H0Vg==
X-Gm-Message-State: AOAM531JVX0+UDgmAUW53bYsjdqshXGquBpM7ny+C6xV+iKfGa2JL4hx
 Ykpi8ah6hQ5YOpnrhz5Bc5c=
X-Google-Smtp-Source: ABdhPJwKT7FVRh43L9EMp25B1edDg0633yW6Rnccv/gD+CMCio9gORsvm6jnf+jqiJgT4Bx7SQrrGw==
X-Received: by 2002:a17:90a:c68a:: with SMTP id
 n10mr33294547pjt.32.1623079293798; 
 Mon, 07 Jun 2021 08:21:33 -0700 (PDT)
Received: from ?IPv6:2404:f801:0:5:8000::4b1? ([2404:f801:9000:1a:efea::4b1])
 by smtp.gmail.com with ESMTPSA id
 g63sm8507428pfb.55.2021.06.07.08.21.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Jun 2021 08:21:33 -0700 (PDT)
Subject: Re: [RFC PATCH V3 10/11] HV/Netvsc: Add Isolation VM support for
 netvsc driver
To: Christoph Hellwig <hch@lst.de>
References: <20210530150628.2063957-1-ltykernel@gmail.com>
 <20210530150628.2063957-11-ltykernel@gmail.com>
 <20210607065007.GE24478@lst.de>
From: Tianyu Lan <ltykernel@gmail.com>
Message-ID: <279cb4bf-c5b6-6db9-0f1e-9238e902c8f2@gmail.com>
Date: Mon, 7 Jun 2021 23:21:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210607065007.GE24478@lst.de>
Content-Language: en-US
Cc: linux-hyperv@vger.kernel.org, brijesh.singh@amd.com, peterz@infradead.org,
 dave.hansen@linux.intel.com, hpa@zytor.com, kys@microsoft.com, will@kernel.org,
 boris.ostrovsky@oracle.com, linux-arch@vger.kernel.org, wei.liu@kernel.org,
 sstabellini@kernel.org, sthemmin@microsoft.com, linux-scsi@vger.kernel.org,
 x86@kernel.org, decui@microsoft.com, mingo@redhat.com,
 xen-devel@lists.xenproject.org, jejb@linux.ibm.com, thomas.lendacky@amd.com,
 Tianyu.Lan@microsoft.com, arnd@arndb.de, konrad.wilk@oracle.com,
 haiyangz@microsoft.com, kuba@kernel.org, bp@alien8.de, luto@kernel.org,
 krish.sadhukhan@oracle.com, tglx@linutronix.de, vkuznets@redhat.com,
 jgross@suse.com, martin.petersen@oracle.com, saravanand@fb.com,
 netdev@vger.kernel.org, sunilmut@microsoft.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, kirill.shutemov@linux.intel.com,
 hannes@cmpxchg.org, cai@lca.pw, akpm@linux-foundation.org,
 robin.murphy@arm.com, davem@davemloft.net, rppt@kernel.org
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



On 6/7/2021 2:50 PM, Christoph Hellwig wrote:
> On Sun, May 30, 2021 at 11:06:27AM -0400, Tianyu Lan wrote:
>> +	if (hv_isolation_type_snp()) {
>> +		pfns = kcalloc(buf_size / HV_HYP_PAGE_SIZE, sizeof(unsigned long),
>> +			       GFP_KERNEL);
>> +		for (i = 0; i < buf_size / HV_HYP_PAGE_SIZE; i++)
>> +			pfns[i] = virt_to_hvpfn(net_device->recv_buf + i * HV_HYP_PAGE_SIZE) +
>> +				(ms_hyperv.shared_gpa_boundary >> HV_HYP_PAGE_SHIFT);
>> +
>> +		vaddr = vmap_pfn(pfns, buf_size / HV_HYP_PAGE_SIZE, PAGE_KERNEL_IO);
>> +		kfree(pfns);
>> +		if (!vaddr)
>> +			goto cleanup;
>> +		net_device->recv_original_buf = net_device->recv_buf;
>> +		net_device->recv_buf = vaddr;
>> +	}
> 
> This probably wnats a helper to make the thing more readable.  But who
> came up with this fucked up communication protocol where the host needs
> to map random pfns into a contigous range?  Sometime I really have to
> wonder what crack the hyper-v people take when comparing this to the
> relatively sane approach others take.

Agree. Will add a helper function.
> 
>> +	for (i = 0; i < page_count; i++)
>> +		dma_unmap_single(&hv_dev->device, packet->dma_range[i].dma,
>> +				 packet->dma_range[i].mapping_size,
>> +				 DMA_TO_DEVICE);
>> +
>> +	kfree(packet->dma_range);
> 
> Any reason this isn't simply using a struct scatterlist?

I will have a look. Thanks to reminder scatterlist.

> 
>> +	for (i = 0; i < page_count; i++) {
>> +		char *src = phys_to_virt((pb[i].pfn << HV_HYP_PAGE_SHIFT)
>> +					 + pb[i].offset);
>> +		u32 len = pb[i].len;
>> +
>> +		dma = dma_map_single(&hv_dev->device, src, len,
>> +				     DMA_TO_DEVICE);
> 
> dma_map_single can only be used on page baked memory, and if this is
> using page backed memory you wouldn't need to do thee phys_to_virt
> tricks.  Can someone explain the mess here in more detail?

Sorry. Could you elaborate the issue? These pages in the pb array are 
not allocated by DMA API and using dma_map_single() here is to map these 
pages' address to bounce buffer physical address.

> 
>>   	struct rndis_device *dev = nvdev->extension;
>>   	struct rndis_request *request = NULL;
>> +	struct hv_device *hv_dev = ((struct net_device_context *)
>> +			netdev_priv(ndev))->device_ctx;
> 
> Why not use a net_device_context local variable instead of this cast
> galore?
> 

OK. I will update.


Thanks.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
