Return-Path: <SRS0=85So=MN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 689C8C07E9B
	for <iommu@archiver.kernel.org>; Wed, 21 Jul 2021 10:29:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07E4360FF2
	for <iommu@archiver.kernel.org>; Wed, 21 Jul 2021 10:29:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07E4360FF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BFDA9402B9;
	Wed, 21 Jul 2021 10:29:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kH1IZnhiqUzl; Wed, 21 Jul 2021 10:29:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 222774020A;
	Wed, 21 Jul 2021 10:29:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D0045C0010;
	Wed, 21 Jul 2021 10:29:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 691CDC000E
 for <iommu@lists.linux-foundation.org>; Wed, 21 Jul 2021 10:29:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 56EC6605E2
 for <iommu@lists.linux-foundation.org>; Wed, 21 Jul 2021 10:29:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FPQhwORIlpFo for <iommu@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 10:29:06 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1C736605A0
 for <iommu@lists.linux-foundation.org>; Wed, 21 Jul 2021 10:29:06 +0000 (UTC)
Received: by mail-pf1-x42c.google.com with SMTP id d5so310738pfq.12
 for <iommu@lists.linux-foundation.org>; Wed, 21 Jul 2021 03:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:subject:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=crPkDkWQEoNERdMjzIoNvDVdZYJX2jUbiteH/e0Of1o=;
 b=dpQF0qK/cZ1PBWjC1lNEtBNPQIY0ndTZOqudg/5nG+laJtg1EvtFbUy2df++wHmiLi
 c6BCC2uROfhvdYwDWYWD1jecOacp6hyTQ93iH+xQCYDh0nO8befGldO1/+g9lnr74Jsv
 CmOUB7aNlqIYBSVTdBy1KAz3fTJhPWw+/jwvvEOOadVZwZ+pWi0tv3SIK/XfCdM4Yw0C
 CMWaIHisnetIQUkh+1i2GqoZdEdpLDithfUWVY4II/1DHvEJRJ2d7y6Gld4xfxrZsKbY
 6Msig5LVrt5yFu08e+wuLM0X3juclFNnUEU2LztUJ2yenbExU+zvtkxD1pUa0R4LM97z
 RFOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:subject:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=crPkDkWQEoNERdMjzIoNvDVdZYJX2jUbiteH/e0Of1o=;
 b=J26cJp0HE3OD5hfLUqL4y/giBhwb6w8/kqHorBPOoVASCiBtERMnfgIC2Tdb7cLFOp
 p94XBvws2TFUQjuOe69CyBAVZcvLXQ1eyOB/LoVZZfmzEKNuA7O3Nsh6/G1I4wnOanxc
 pRmmDGdwKgyApFvcq9lMZ7LsUp1XjN78roPfH1GMIT00uNM3YIeTKH422wwx66wGyTj/
 JHmTmzuRUVfWyGnpB/YWfGXjBxR3h362dOL7bzH/D5+IW2W08SccYcwE0DDaQVCyS2mQ
 GFIVQ4GD95i42NAU9UQoTk/qIHvT4lvLaHW13YXtCRQ2UYjwkzAxBSAwU1hjymaQFjvQ
 Ol4Q==
X-Gm-Message-State: AOAM533bM7IazbBOTztXLLt6+KeUR2mGxb6mj6NI/JVTMunnoAfGciBw
 Lah/PFIg+dwXktZh8kdoanY=
X-Google-Smtp-Source: ABdhPJwGK1w7GFZui+UX4nxgbHVeI56Iu2D5hjeSldD82+ip3NkTL1jWcNoRnxoO7LnJTjwfoGvugw==
X-Received: by 2002:a65:6187:: with SMTP id c7mr35068030pgv.349.1626863345481; 
 Wed, 21 Jul 2021 03:29:05 -0700 (PDT)
Received: from ?IPv6:2404:f801:0:5:8000::4b1? ([2404:f801:9000:18:efec::4b1])
 by smtp.gmail.com with ESMTPSA id
 t37sm26803912pfg.14.2021.07.21.03.28.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Jul 2021 03:29:05 -0700 (PDT)
From: Tianyu Lan <ltykernel@gmail.com>
Subject: Re: [Resend RFC PATCH V4 09/13] x86/Swiotlb/HV: Add Swiotlb bounce
 buffer remap function for HV IVM
To: Christoph Hellwig <hch@lst.de>
References: <20210707154629.3977369-1-ltykernel@gmail.com>
 <20210707154629.3977369-10-ltykernel@gmail.com>
 <20210720135437.GA13554@lst.de>
Message-ID: <8f1a285d-4b67-8041-d326-af565b2756c0@gmail.com>
Date: Wed, 21 Jul 2021 18:28:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210720135437.GA13554@lst.de>
Content-Language: en-US
Cc: linux-hyperv@vger.kernel.org, brijesh.singh@amd.com, david@redhat.com,
 peterz@infradead.org, dave.hansen@linux.intel.com, hpa@zytor.com,
 anparri@microsoft.com, kys@microsoft.com, will@kernel.org,
 boris.ostrovsky@oracle.com, linux-arch@vger.kernel.org, robh@kernel.org,
 wei.liu@kernel.org, sstabellini@kernel.org, sthemmin@microsoft.com,
 xen-devel@lists.xenproject.org, linux-scsi@vger.kernel.org, x86@kernel.org,
 decui@microsoft.com, ardb@kernel.org, michael.h.kelley@microsoft.com,
 nramas@linux.microsoft.com, mingo@redhat.com, pgonda@google.com,
 rientjes@google.com, kuba@kernel.org, jejb@linux.ibm.com,
 martin.b.radev@gmail.com, thomas.lendacky@amd.com, Tianyu.Lan@microsoft.com,
 keescook@chromium.org, arnd@arndb.de, konrad.wilk@oracle.com,
 haiyangz@microsoft.com, bp@alien8.de, luto@kernel.org,
 krish.sadhukhan@oracle.com, tglx@linutronix.de, vkuznets@redhat.com,
 jgross@suse.com, martin.petersen@oracle.com, saravanand@fb.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, rppt@kernel.org, hannes@cmpxchg.org,
 akpm@linux-foundation.org, robin.murphy@arm.com, davem@davemloft.net,
 kirill.shutemov@linux.intel.com
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

Thanks for review.

On 7/20/2021 9:54 PM, Christoph Hellwig wrote:
> 
> Please split the swiotlb changes into a separate patch from the
> consumer.

OK. Will update.

> 
>>   }
>> +
>> +/*
>> + * hv_map_memory - map memory to extra space in the AMD SEV-SNP Isolation VM.
>> + */
>> +unsigned long hv_map_memory(unsigned long addr, unsigned long size)
>> +{
>> +	unsigned long *pfns = kcalloc(size / HV_HYP_PAGE_SIZE,
>> +				      sizeof(unsigned long),
>> +		       GFP_KERNEL);
>> +	unsigned long vaddr;
>> +	int i;
>> +
>> +	if (!pfns)
>> +		return (unsigned long)NULL;
>> +
>> +	for (i = 0; i < size / HV_HYP_PAGE_SIZE; i++)
>> +		pfns[i] = virt_to_hvpfn((void *)addr + i * HV_HYP_PAGE_SIZE) +
>> +			(ms_hyperv.shared_gpa_boundary >> HV_HYP_PAGE_SHIFT);
>> +
>> +	vaddr = (unsigned long)vmap_pfn(pfns, size / HV_HYP_PAGE_SIZE,
>> +					PAGE_KERNEL_IO);
>> +	kfree(pfns);
>> +
>> +	return vaddr;
> 
> This seems to miss a 'select VMAP_PFN'. 

VMAP_PFN has been selected in the previous patch "RFC PATCH V4 08/13]
HV/Vmbus: Initialize VMbus ring buffer for Isolation VM"

> But more importantly I don't
> think this actually works.  Various DMA APIs do expect a struct page
> backing, so how is this going to work with say dma_mmap_attrs or
> dma_get_sgtable_attrs?

dma_mmap_attrs() and dma_get_sgtable_attrs() get input virtual address
belonging to backing memory with struct page and returns bounce buffer
dma physical address which is below shared_gpa_boundary(vTOM) and passed
to Hyper-V via vmbus protocol.

The new map virtual address is only to access bounce buffer in swiotlb
code and will not be used other places. It's stored in the mem->vstart.
So the new API set_memory_decrypted_map() in this series is only called
in the swiotlb code. Other platforms may replace set_memory_decrypted()
with set_memory_decrypted_map() as requested.

> 
>> +static unsigned long __map_memory(unsigned long addr, unsigned long size)
>> +{
>> +	if (hv_is_isolation_supported())
>> +		return hv_map_memory(addr, size);
>> +
>> +	return addr;
>> +}
>> +
>> +static void __unmap_memory(unsigned long addr)
>> +{
>> +	if (hv_is_isolation_supported())
>> +		hv_unmap_memory(addr);
>> +}
>> +
>> +unsigned long set_memory_decrypted_map(unsigned long addr, unsigned long size)
>> +{
>> +	if (__set_memory_enc_dec(addr, size / PAGE_SIZE, false))
>> +		return (unsigned long)NULL;
>> +
>> +	return __map_memory(addr, size);
>> +}
>> +
>> +int set_memory_encrypted_unmap(unsigned long addr, unsigned long size)
>> +{
>> +	__unmap_memory(addr);
>> +	return __set_memory_enc_dec(addr, size / PAGE_SIZE, true);
>> +}
> 
> Why this obsfucation into all kinds of strange helpers?  Also I think
> we want an ops vectors (or alternative calls) instead of the random
> if checks here.

Yes, agree and will add ops for different platforms to map/unmap memory.

> 
>> + * @vstart:	The virtual start address of the swiotlb memory pool. The swiotlb
>> + *		memory pool may be remapped in the memory encrypted case and store
> 
> Normall we'd call this vaddr or cpu_addr.

OK. Will update.

> 
>> -	set_memory_decrypted((unsigned long)vaddr, bytes >> PAGE_SHIFT);
>> -	memset(vaddr, 0, bytes);
>> +	mem->vstart = (void *)set_memory_decrypted_map((unsigned long)vaddr, bytes);
> 
> Please always pass kernel virtual addresses as pointers.
> 
> And I think these APIs might need better names, e.g.
> 
> arch_dma_map_decrypted and arch_dma_unmap_decrypted.
> 
> Also these will need fallback versions for non-x86 architectures that
> currently use memory encryption.

Sure. Will update in the next version.

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
