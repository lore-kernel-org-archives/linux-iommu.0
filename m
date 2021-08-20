Return-Path: <SRS0=ckUw=NL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D40AEC4338F
	for <iommu@archiver.kernel.org>; Fri, 20 Aug 2021 09:32:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 664926113E
	for <iommu@archiver.kernel.org>; Fri, 20 Aug 2021 09:32:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 664926113E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 177B2613F0;
	Fri, 20 Aug 2021 09:32:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RrJuzAH74Qla; Fri, 20 Aug 2021 09:32:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E399260590;
	Fri, 20 Aug 2021 09:32:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AF923C001A;
	Fri, 20 Aug 2021 09:32:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 328DFC000E
 for <iommu@lists.linux-foundation.org>; Fri, 20 Aug 2021 09:32:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1EC7280F55
 for <iommu@lists.linux-foundation.org>; Fri, 20 Aug 2021 09:32:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rsxuAAy4e1Zb for <iommu@lists.linux-foundation.org>;
 Fri, 20 Aug 2021 09:32:35 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com
 [IPv6:2607:f8b0:4864:20::533])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 88C4B80F4D
 for <iommu@lists.linux-foundation.org>; Fri, 20 Aug 2021 09:32:35 +0000 (UTC)
Received: by mail-pg1-x533.google.com with SMTP id t1so8576910pgv.3
 for <iommu@lists.linux-foundation.org>; Fri, 20 Aug 2021 02:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=F/INelQk2As+/GtcCaMtJ+YzY5fXWvqQ9IG9ehmEJG8=;
 b=NOsRg08JE9vqoPHWkIYlLgvhL+MicNH2byE8RBT270hR7Y34lewYGmzCG7ZiSOPfst
 hHwY77aZbHyaZy74ak1zDkDcJThEyYHT+phdATRZfrBFvdCFxZDPgNsT5HA2ACIGOssj
 5flQeCaYSnsS7x235BGVvDlZVJfoVF2viLSRLpv9bgZw/C28yjBIhSKVFmgAWxO0RwLs
 SqRSs/9c3L856W6LO84v1LhAxpS7IpBUWCu4vR1ZWSmuRYMsAqASRYQzmnl0WEeB+EGQ
 v8cJErq4KMIgeGnBvkCcPfJfi85pvA0P+J4N0lc0Qhk1awxXio8YvgLwIqm9BpqqWqJj
 KSgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=F/INelQk2As+/GtcCaMtJ+YzY5fXWvqQ9IG9ehmEJG8=;
 b=LMhhCLRI6oUgZmHeYmUBx0BpGegos4vo1y0EWeQe61dfz3XT9QFTxLy8w0J7hhsVSf
 aeFeEQtGRTQqJ4vDRImME+D8fLAJGwKzQf14Lzq1J8Eco4+NFwaqaQwH5sjrT3gdt/bw
 ZNLqA20upmNgPHG/Dght/OU6RI43aOYjlUa9LoxPNFU9q6VfrSynKU0N9k1M5VbSDJmj
 beIW8bXDTnYquQtKqjlWwViIx+7k0Zz59d4GAX0udbgggnDbZqGaLoKibCFLxZhkzk/m
 R3D1dut7psrLuGocbKM25nuyCAgIvFrikCWQqQG4wRsgLsLQyOqho2exDwwZYn2uciuq
 rQBA==
X-Gm-Message-State: AOAM5300s7Vww8cBT5QmmFllmLqYFFM/jt2CN+o6LgrIF8JUw0jwop/y
 L0T1jwUlgAz1FuCac7Y2MqE=
X-Google-Smtp-Source: ABdhPJyMzC9zZ4t/lY/N9LWV+o+9MRA4tnKQgAYkkUeEh5Y8L6QkAwqXlqjG86qeQ0htTXLK/F9JXQ==
X-Received: by 2002:a63:1a46:: with SMTP id a6mr17708253pgm.226.1629451955046; 
 Fri, 20 Aug 2021 02:32:35 -0700 (PDT)
Received: from ?IPv6:2404:f801:0:5:8000::50b? ([2404:f801:9000:18:efec::50b])
 by smtp.gmail.com with ESMTPSA id
 x42sm6108890pfh.205.2021.08.20.02.32.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Aug 2021 02:32:34 -0700 (PDT)
Subject: Re: [PATCH V3 11/13] HV/IOMMU: Enable swiotlb bounce buffer for
 Isolation VM
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
 <martin.petersen@oracle.com>, "arnd@arndb.de" <arnd@arndb.de>,
 "hch@lst.de" <hch@lst.de>,
 "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
 "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
 "ardb@kernel.org" <ardb@kernel.org>, Tianyu Lan <Tianyu.Lan@microsoft.com>,
 "pgonda@google.com" <pgonda@google.com>,
 "martin.b.radev@gmail.com" <martin.b.radev@gmail.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
 "rppt@kernel.org" <rppt@kernel.org>,
 "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
 "saravanand@fb.com" <saravanand@fb.com>,
 "krish.sadhukhan@oracle.com" <krish.sadhukhan@oracle.com>,
 "aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 "rientjes@google.com" <rientjes@google.com>,
 "hannes@cmpxchg.org" <hannes@cmpxchg.org>, "tj@kernel.org" <tj@kernel.org>
References: <20210809175620.720923-1-ltykernel@gmail.com>
 <20210809175620.720923-12-ltykernel@gmail.com>
 <MWHPR21MB159315B335EB0B064B0B0F23D7C09@MWHPR21MB1593.namprd21.prod.outlook.com>
From: Tianyu Lan <ltykernel@gmail.com>
Message-ID: <e933f7e3-5573-bb8a-c313-75884d59235c@gmail.com>
Date: Fri, 20 Aug 2021 17:32:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <MWHPR21MB159315B335EB0B064B0B0F23D7C09@MWHPR21MB1593.namprd21.prod.outlook.com>
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



On 8/20/2021 2:11 AM, Michael Kelley wrote:
>>   }
>> +
>> +/*
>> + * hv_map_memory - map memory to extra space in the AMD SEV-SNP Isolation VM.
>> + */
>> +void *hv_map_memory(void *addr, unsigned long size)
>> +{
>> +	unsigned long *pfns = kcalloc(size / HV_HYP_PAGE_SIZE,
>> +				      sizeof(unsigned long), GFP_KERNEL);
>> +	void *vaddr;
>> +	int i;
>> +
>> +	if (!pfns)
>> +		return NULL;
>> +
>> +	for (i = 0; i < size / HV_HYP_PAGE_SIZE; i++)
>> +		pfns[i] = virt_to_hvpfn(addr + i * HV_HYP_PAGE_SIZE) +
>> +			(ms_hyperv.shared_gpa_boundary >> HV_HYP_PAGE_SHIFT);
>> +
>> +	vaddr = vmap_pfn(pfns, size / HV_HYP_PAGE_SIZE,	PAGE_KERNEL_IO);
>> +	kfree(pfns);
>> +
>> +	return vaddr;
>> +}
> This function is manipulating page tables in the guest VM.  It is not involved
> in communicating with Hyper-V, or passing PFNs to Hyper-V.  The pfn array
> contains guest PFNs, not Hyper-V PFNs.  So it should use PAGE_SIZE
> instead of HV_HYP_PAGE_SIZE, and similarly PAGE_SHIFT and virt_to_pfn().
> If this code were ever to run on ARM64 in the future with PAGE_SIZE other
> than 4 Kbytes, the use of PAGE_SIZE is correct choice.

OK. Will update with PAGE_SIZE.


> 
>> +void __init hyperv_iommu_swiotlb_init(void)
>> +{
>> +	unsigned long bytes;
>> +
>> +	/*
>> +	 * Allocate Hyper-V swiotlb bounce buffer at early place
>> +	 * to reserve large contiguous memory.
>> +	 */
>> +	hyperv_io_tlb_size = 256 * 1024 * 1024;
> A hard coded size here seems problematic.   The memory size of
> Isolated VMs can vary by orders of magnitude.  I see that
> xen_swiotlb_init() uses swiotlb_size_or_default(), which at least
> pays attention to the value specified on the kernel boot line.
> 
> Another example is sev_setup_arch(), which in the native case sets
> the size to 6% of main memory, with a max of 1 Gbyte.  This is
> the case that's closer to Isolated VMs, so doing something
> similar could be a good approach.
> 

Yes, agree. It's better to keep bounce buffer size with AMD SEV.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
