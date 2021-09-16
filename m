Return-Path: <SRS0=vqUx=OG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5C0AC433EF
	for <iommu@archiver.kernel.org>; Thu, 16 Sep 2021 10:57:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87E6D60FC0
	for <iommu@archiver.kernel.org>; Thu, 16 Sep 2021 10:57:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 87E6D60FC0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4EF7A613CC;
	Thu, 16 Sep 2021 10:57:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zKz9enrOyMqo; Thu, 16 Sep 2021 10:57:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3309B613C2;
	Thu, 16 Sep 2021 10:57:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F2FC0C000F;
	Thu, 16 Sep 2021 10:57:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 179E5C000D
 for <iommu@lists.linux-foundation.org>; Thu, 16 Sep 2021 10:57:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 014A7401FA
 for <iommu@lists.linux-foundation.org>; Thu, 16 Sep 2021 10:57:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0-55YJevq3t6 for <iommu@lists.linux-foundation.org>;
 Thu, 16 Sep 2021 10:57:35 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com
 [IPv6:2607:f8b0:4864:20::42b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1865C4014D
 for <iommu@lists.linux-foundation.org>; Thu, 16 Sep 2021 10:57:34 +0000 (UTC)
Received: by mail-pf1-x42b.google.com with SMTP id q22so5616284pfu.0
 for <iommu@lists.linux-foundation.org>; Thu, 16 Sep 2021 03:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=zetJ5G0LMyibhhBY6/35VWLw2vAGWh3kCNdD5BxkSZI=;
 b=Iq+3mvGj2jY0H1hK5L2+2LJkiT3nS6liFloV8Frq8+FJ3Y0LxB2A38VNCla7awjuhj
 Q3Cl5qmmvoV1YWOZQweI486bIgofq+t3jwjAQ3GGQ1BTx00wXTwDzZt3wO26vvMZXlEU
 Srw78VlxUG3ClRIenDB9DS9KklBz8Gy2Kt0AIAheRW83PteD9N403WMbpA39HXJuq8IF
 JiYUmg4zDGjeRBVLjEF25+aPcjKe8oOTUL3KuuMaaLo1G4aP3SLUOfZT+6b94AvHMe5Q
 tcf8/9xlWcz7WQzaFSNkMRaXjJszFIpx0K2ojEu+E4bzhBM/xSgQmOnlb5Oz/8Q8cN9d
 Qp1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zetJ5G0LMyibhhBY6/35VWLw2vAGWh3kCNdD5BxkSZI=;
 b=uT76uwtJFmOOFJ7YjvyjI2jZ6aj5lABamiid6dyyyxuPdjufKScuJ9kdSepwPnNaHf
 37IwnUTg8f79tWPmz3UQO3f7SxMdc1GbovGRO1fRTW32gssR2sSPOjTkPXATH3XAB6HW
 kVfKI6sDK1ZoJnZdKLU6H0YSCWgGy8oooTZrL3TvGQ0bK/ss8Uan1NYSfJUVrQVRRiO6
 r8/6n92bwUVqeBnkxzWPQjWs0wQPF9/5AMevh4RuesBr4sgkGO6w5P0kuU5vlonQyuyY
 NX6JgD6H569znpC1Rccjz4DUlo860zPyGDFofDJD3XC5RnqmlBrwgOdPbfGr88ClYhsA
 r0Hw==
X-Gm-Message-State: AOAM533P/cdvCjYSgFVlzQ8obDU1ttjYVqhDhBKBDhzk00ZTEt/lHtGH
 uX6JFb1KkHXzXb6C/6ii5Ww=
X-Google-Smtp-Source: ABdhPJyJnHqPNf+opjGA7LpPgHFY6nzsERWLwilu6XCHi7kaSPNw+MpELyJKztS12zzhPWoDpdap2Q==
X-Received: by 2002:aa7:959a:0:b0:43b:adeb:ef58 with SMTP id
 z26-20020aa7959a000000b0043badebef58mr4426857pfj.19.1631789854486; 
 Thu, 16 Sep 2021 03:57:34 -0700 (PDT)
Received: from ?IPv6:2404:f801:0:5:8000::50b? ([2404:f801:9000:1a:efea::50b])
 by smtp.gmail.com with ESMTPSA id
 n141sm2856237pfd.90.2021.09.16.03.57.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Sep 2021 03:57:34 -0700 (PDT)
Subject: Re: [PATCH V5 09/12] x86/Swiotlb: Add Swiotlb bounce buffer remap
 function for HV IVM
To: Michael Kelley <mikelley@microsoft.com>, KY Srinivasan
 <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
 "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "luto@kernel.org" <luto@kernel.org>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
 "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
 "jgross@suse.com" <jgross@suse.com>,
 "sstabellini@kernel.org" <sstabellini@kernel.org>,
 "joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "kuba@kernel.org" <kuba@kernel.org>, "jejb@linux.ibm.com"
 <jejb@linux.ibm.com>, "martin.petersen@oracle.com"
 <martin.petersen@oracle.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "arnd@arndb.de" <arnd@arndb.de>, "hch@lst.de" <hch@lst.de>,
 "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
 Tianyu Lan <Tianyu.Lan@microsoft.com>,
 "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
 "pgonda@google.com" <pgonda@google.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
 "rppt@kernel.org" <rppt@kernel.org>,
 "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
 "aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>,
 "saravanand@fb.com" <saravanand@fb.com>,
 "krish.sadhukhan@oracle.com" <krish.sadhukhan@oracle.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 "tj@kernel.org" <tj@kernel.org>, "rientjes@google.com" <rientjes@google.com>
References: <20210914133916.1440931-1-ltykernel@gmail.com>
 <20210914133916.1440931-10-ltykernel@gmail.com>
 <MWHPR21MB159349234C15D0F04F87845CD7DB9@MWHPR21MB1593.namprd21.prod.outlook.com>
From: Tianyu Lan <ltykernel@gmail.com>
Message-ID: <3f6a6407-b8fd-803b-e4fe-ea9a873a5840@gmail.com>
Date: Thu, 16 Sep 2021 18:57:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <MWHPR21MB159349234C15D0F04F87845CD7DB9@MWHPR21MB1593.namprd21.prod.outlook.com>
Content-Language: en-US
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 "parri.andrea@gmail.com" <parri.andrea@gmail.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "dave.hansen@intel.com" <dave.hansen@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 vkuznets <vkuznets@redhat.com>
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

On 9/15/2021 11:42 PM, Michael Kelley wrote:
>> @@ -196,13 +199,34 @@ static void swiotlb_init_io_tlb_mem(struct io_tlb_mem *mem, phys_addr_t start,
>>   		mem->slots[i].orig_addr = INVALID_PHYS_ADDR;
>>   		mem->slots[i].alloc_size = 0;
>>   	}
>> +
>> +	if (set_memory_decrypted((unsigned long)vaddr, bytes >> PAGE_SHIFT))
>> +		return -EFAULT;
>> +
>> +	/*
>> +	 * Map memory in the unencrypted physical address space when requested
>> +	 * (e.g. for Hyper-V AMD SEV-SNP Isolation VMs).
>> +	 */
>> +	if (swiotlb_unencrypted_base) {
>> +		phys_addr_t paddr = __pa(vaddr) + swiotlb_unencrypted_base;
> Nit:  Use "start" instead of "__pa(vaddr)" since "start" is already the needed
> physical address.


Yes, "start" should be used here.

> 
>> @@ -304,7 +332,7 @@ int
>>   swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs)
>>   {
>>   	struct io_tlb_mem *mem = &io_tlb_default_mem;
>> -	unsigned long bytes = nslabs << IO_TLB_SHIFT;
>> +	int ret;
>>
>>   	if (swiotlb_force == SWIOTLB_NO_FORCE)
>>   		return 0;
>> @@ -318,8 +346,9 @@ swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs)
>>   	if (!mem->slots)
>>   		return -ENOMEM;
>>
>> -	set_memory_decrypted((unsigned long)tlb, bytes >> PAGE_SHIFT);
>> -	swiotlb_init_io_tlb_mem(mem, virt_to_phys(tlb), nslabs, true);
>> +	ret = swiotlb_init_io_tlb_mem(mem, virt_to_phys(tlb), nslabs, true);
>> +	if (ret)
> Before returning the error, free the pages obtained from the earlier call
> to __get_free_pages()?
> 

Yes, will fix.

Thanks.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
