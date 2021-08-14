Return-Path: <SRS0=e2ZE=NF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A3DEC4338F
	for <iommu@archiver.kernel.org>; Sat, 14 Aug 2021 13:33:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C117060F4B
	for <iommu@archiver.kernel.org>; Sat, 14 Aug 2021 13:33:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C117060F4B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 81307605F1;
	Sat, 14 Aug 2021 13:33:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0ufyKS-rKffR; Sat, 14 Aug 2021 13:33:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5A47860745;
	Sat, 14 Aug 2021 13:33:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1F2E3C001A;
	Sat, 14 Aug 2021 13:33:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E8F24C000E
 for <iommu@lists.linux-foundation.org>; Sat, 14 Aug 2021 13:33:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C3DDA80F3C
 for <iommu@lists.linux-foundation.org>; Sat, 14 Aug 2021 13:33:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mmE-255g4urx for <iommu@lists.linux-foundation.org>;
 Sat, 14 Aug 2021 13:33:16 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1037480F3B
 for <iommu@lists.linux-foundation.org>; Sat, 14 Aug 2021 13:33:15 +0000 (UTC)
Received: by mail-pj1-x102b.google.com with SMTP id
 om1-20020a17090b3a8100b0017941c44ce4so6646823pjb.3
 for <iommu@lists.linux-foundation.org>; Sat, 14 Aug 2021 06:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=E3l49fTTRVE56Vn9goxprKRxj2T85G+ePpi3voIcgqM=;
 b=UOFvhoKWqadKBxrSEwyDxHW1dWTJrafMlGKdpwz34n27UmdJ5/7Kx0SVLSJnJnFQc0
 nBK93oRsNiOTXjOfX8P7bs71iCBHOyCMi130oWpbhdiSiTZv1X/wd8e1Dj3KcUJudx+R
 IiqXfbcAXEMH0PHFY4CPHcc6MLxtKitkrnXiZwk/JUIU/s315UCEdfhd1VSWcmQTQ7bc
 88Mt4SuCTPB8JkUJy7jP8ClgGplB8Sp8dTkRZqlPwgTonhZ6vEZD5ZWAEDT99qVSUv5r
 jvnFloTwcCW37+swxtjfc/+FSQfYl++e87I3fcJuYu/lMrJjsO1ALvs02uq1jjhNUXax
 DYCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=E3l49fTTRVE56Vn9goxprKRxj2T85G+ePpi3voIcgqM=;
 b=hkooEXWl+zRumiHoRg5Z541Suf9uCTqndSqWB96/IImH61Mx/C2BkAY84gfizKtsfU
 pTxHOZ5CdQiOTjRFbgsjmFpTDGJIXj7gGm6UzhDAjQS4UkwLbuUpnofQl1JkR82/CjiJ
 yX9nbAbV4Ne16dEgah/6qHR/fhEyTo8IykKpnvQ1potLV/0K4b7HqJM0zVZj1ax/ROzw
 Y7jzU1XLBxQiyUC+zKLbyVD7Y2Lb+Qio/AWJ0zjmlOtKs/hrv54pCKHK52Xgl1uCvVkZ
 Rqo2cfPqvKESEIgr3IuuSwKcvxnez+TjzdoTB6LJjI56Kfsne2F1NW3JyKN5IQ8LtEVk
 eg3w==
X-Gm-Message-State: AOAM531T/iokjGqRzEBifb04Gicl/yjJQa3DsgOjBoY7tG+/6Dm5p2Iq
 rvWwxgY7xXOliMssef0m9zM=
X-Google-Smtp-Source: ABdhPJxx4GFAlWpOOAKq3xGwVTJFNnwgLV853vArASgiLYYXySIM5R+pCZYOCQaXwPK3prs4ee+uNQ==
X-Received: by 2002:a17:90a:ad07:: with SMTP id
 r7mr7575975pjq.110.1628947995429; 
 Sat, 14 Aug 2021 06:33:15 -0700 (PDT)
Received: from ?IPv6:2404:f801:0:5:8000::50b? ([2404:f801:9000:1a:efea::50b])
 by smtp.gmail.com with ESMTPSA id
 n31sm2319766pfv.22.2021.08.14.06.33.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Aug 2021 06:33:15 -0700 (PDT)
Subject: Re: [PATCH V3 02/13] x86/HV: Initialize shared memory boundary in the
 Isolation VM.
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
 <20210809175620.720923-3-ltykernel@gmail.com>
 <MWHPR21MB159376E024639D8F0465BCA2D7F99@MWHPR21MB1593.namprd21.prod.outlook.com>
From: Tianyu Lan <ltykernel@gmail.com>
Message-ID: <03fea66e-b2b4-af9c-5e06-2de63960a8b4@gmail.com>
Date: Sat, 14 Aug 2021 21:32:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <MWHPR21MB159376E024639D8F0465BCA2D7F99@MWHPR21MB1593.namprd21.prod.outlook.com>
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


On 8/13/2021 3:18 AM, Michael Kelley wrote:
> From: Tianyu Lan <ltykernel@gmail.com> Sent: Monday, August 9, 2021 10:56 AM
>> Subject: [PATCH V3 02/13] x86/HV: Initialize shared memory boundary in the Isolation VM.
> 
> As with Patch 1, use the "x86/hyperv:" tag in the Subject line.
> 
>>
>> From: Tianyu Lan <Tianyu.Lan@microsoft.com>
>>
>> Hyper-V exposes shared memory boundary via cpuid
>> HYPERV_CPUID_ISOLATION_CONFIG and store it in the
>> shared_gpa_boundary of ms_hyperv struct. This prepares
>> to share memory with host for SNP guest.
>>
>> Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
>> ---
>>   arch/x86/kernel/cpu/mshyperv.c |  2 ++
>>   include/asm-generic/mshyperv.h | 12 +++++++++++-
>>   2 files changed, 13 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
>> index 6b5835a087a3..2b7f396ef1a5 100644
>> --- a/arch/x86/kernel/cpu/mshyperv.c
>> +++ b/arch/x86/kernel/cpu/mshyperv.c
>> @@ -313,6 +313,8 @@ static void __init ms_hyperv_init_platform(void)
>>   	if (ms_hyperv.priv_high & HV_ISOLATION) {
>>   		ms_hyperv.isolation_config_a = cpuid_eax(HYPERV_CPUID_ISOLATION_CONFIG);
>>   		ms_hyperv.isolation_config_b = cpuid_ebx(HYPERV_CPUID_ISOLATION_CONFIG);
>> +		ms_hyperv.shared_gpa_boundary =
>> +			(u64)1 << ms_hyperv.shared_gpa_boundary_bits;
> 
> You could use BIT_ULL() here, but it's kind of a shrug.


Good suggestion. Thanks.

> 
>>
>>   		pr_info("Hyper-V: Isolation Config: Group A 0x%x, Group B 0x%x\n",
>>   			ms_hyperv.isolation_config_a, ms_hyperv.isolation_config_b);
>> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
>> index 4269f3174e58..aa26d24a5ca9 100644
>> --- a/include/asm-generic/mshyperv.h
>> +++ b/include/asm-generic/mshyperv.h
>> @@ -35,8 +35,18 @@ struct ms_hyperv_info {
>>   	u32 max_vp_index;
>>   	u32 max_lp_index;
>>   	u32 isolation_config_a;
>> -	u32 isolation_config_b;
>> +	union {
>> +		u32 isolation_config_b;
>> +		struct {
>> +			u32 cvm_type : 4;
>> +			u32 Reserved11 : 1;
>> +			u32 shared_gpa_boundary_active : 1;
>> +			u32 shared_gpa_boundary_bits : 6;
>> +			u32 Reserved12 : 20;
> 
> Any reason to name the reserved fields as "11" and "12"?  It
> just looks a bit unusual.  And I'd suggest lowercase "r".
> 

Yes, will update in the next version.

>> +		};
>> +	};
>>   	void  __percpu **ghcb_base;
>> +	u64 shared_gpa_boundary;
>>   };
>>   extern struct ms_hyperv_info ms_hyperv;
>>
>> --
>> 2.25.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
