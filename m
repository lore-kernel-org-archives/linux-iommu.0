Return-Path: <SRS0=cE/7=NY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B110AC432BE
	for <iommu@archiver.kernel.org>; Thu,  2 Sep 2021 06:35:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 453A5610CF
	for <iommu@archiver.kernel.org>; Thu,  2 Sep 2021 06:35:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 453A5610CF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 00E7C40459;
	Thu,  2 Sep 2021 06:35:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2QzyrC4pzvn9; Thu,  2 Sep 2021 06:35:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id CAB9A40460;
	Thu,  2 Sep 2021 06:35:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A5889C0010;
	Thu,  2 Sep 2021 06:35:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0D9E7C000E
 for <iommu@lists.linux-foundation.org>; Thu,  2 Sep 2021 06:35:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id ED81F40252
 for <iommu@lists.linux-foundation.org>; Thu,  2 Sep 2021 06:35:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cDZEdqVf4wKP for <iommu@lists.linux-foundation.org>;
 Thu,  2 Sep 2021 06:35:29 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2454A40004
 for <iommu@lists.linux-foundation.org>; Thu,  2 Sep 2021 06:35:29 +0000 (UTC)
Received: by mail-pl1-x62e.google.com with SMTP id x16so559398pll.2
 for <iommu@lists.linux-foundation.org>; Wed, 01 Sep 2021 23:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=p4zDh7Zmvhg146z4qnwrQjuDGyGfYeNoi9EXmtV3vCk=;
 b=D1rnGa8kIjiZ7syMAy++5cDhLy8JHAOLoRVSufAq+d7fBo+t78Ke3s5Yz1uPgVHodR
 U6y3CPKzBmSzyPUZn2Il5d6T3nJ0NLYayesHqiQlQ4AEq/1OrsdnVq5iF5qtETbh4p6f
 YgZRdRXpDzg75R4rrFTDxF1Zz1nXCMjG9r/QcQXP8xK1ZctdFRxf6VSwgwv/ubG846BU
 K739MDCHAYaN+1tdvPFg/QEZ+f5A+dgNahgxMiNjqV+fKo13+NpkXyburB09UGN30GsF
 XrTtEDpmj/CBGDgU+QPL5YGf1gME4ItHnSLzoIa1FCF+YWcVe+sOEyV7VJxulilpk/4U
 stQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=p4zDh7Zmvhg146z4qnwrQjuDGyGfYeNoi9EXmtV3vCk=;
 b=DK3W02bq6SjPEd6AusTwlZaI5yMEAePP/nkpzU9xDc6kSxrgFsKkCWeHyLX+DfMTHa
 Uu/eIF8gymHxGAckxu86D3mmQut2glgIHGmz5FHCB6udgSRR0qmytzibbQFY6Bfyy5gs
 yYnayqF3ZRohr/Ez6Kh8TrPBOGBEesBt8kfjL1iceAKLfB5DsIehGoi1XfvsmPVp/c8N
 B/pL2VeuxLgdAh46B6oI4YIq1Z90i+7aug+uDrp0TIhoy9utpi8kvOxHQXerSgRo9GXA
 EEVJQ8l3hV084fD7XPxXCILj6StxBe0idQe2LEfUcs3mGYY4b7F8+p8YT1TrBflb2J2h
 i4wQ==
X-Gm-Message-State: AOAM531s44rWFDK2JpgqgFMD0UlXEtog2dMO8qQRfgn5J78qTtv808bl
 E5veqt5pPkinJUwvmm8UnLQ=
X-Google-Smtp-Source: ABdhPJz4pUoRMJIRNU1Ww7Cq95vazM9v9pAhLPt1toZi1VH9XpEJzie9uEpEa09aj/QIF3t5VvMn8Q==
X-Received: by 2002:a17:90a:509:: with SMTP id h9mr2194087pjh.71.1630564528531; 
 Wed, 01 Sep 2021 23:35:28 -0700 (PDT)
Received: from ?IPv6:2404:f801:0:5:8000::50b? ([2404:f801:9000:1a:efea::50b])
 by smtp.gmail.com with ESMTPSA id
 g4sm1018401pjt.56.2021.09.01.23.35.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Sep 2021 23:35:28 -0700 (PDT)
Subject: Re: [PATCH V4 02/13] x86/hyperv: Initialize shared memory boundary in
 the Isolation VM.
To: Michael Kelley <mikelley@microsoft.com>, KY Srinivasan
 <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "will@kernel.org" <will@kernel.org>, "tglx@linutronix.de"
 <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>,
 "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
 "hpa@zytor.com" <hpa@zytor.com>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "luto@kernel.org" <luto@kernel.org>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
 "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
 "jgross@suse.com" <jgross@suse.com>,
 "sstabellini@kernel.org" <sstabellini@kernel.org>,
 "joro@8bytes.org" <joro@8bytes.org>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "kuba@kernel.org" <kuba@kernel.org>, "jejb@linux.ibm.com"
 <jejb@linux.ibm.com>, "martin.petersen@oracle.com"
 <martin.petersen@oracle.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "arnd@arndb.de" <arnd@arndb.de>, "hch@lst.de" <hch@lst.de>,
 "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
 "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
 Tianyu Lan <Tianyu.Lan@microsoft.com>, "pgonda@google.com"
 <pgonda@google.com>, "martin.b.radev@gmail.com" <martin.b.radev@gmail.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
 "rppt@kernel.org" <rppt@kernel.org>, "hannes@cmpxchg.org"
 <hannes@cmpxchg.org>, "aneesh.kumar@linux.ibm.com"
 <aneesh.kumar@linux.ibm.com>,
 "krish.sadhukhan@oracle.com" <krish.sadhukhan@oracle.com>,
 "saravanand@fb.com" <saravanand@fb.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 "rientjes@google.com" <rientjes@google.com>,
 "ardb@kernel.org" <ardb@kernel.org>
References: <20210827172114.414281-1-ltykernel@gmail.com>
 <20210827172114.414281-3-ltykernel@gmail.com>
 <MWHPR21MB1593EF63423A2422DA839793D7CE9@MWHPR21MB1593.namprd21.prod.outlook.com>
From: Tianyu Lan <ltykernel@gmail.com>
Message-ID: <3162bb35-f047-ddbb-3836-6b048b7358e7@gmail.com>
Date: Thu, 2 Sep 2021 14:35:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <MWHPR21MB1593EF63423A2422DA839793D7CE9@MWHPR21MB1593.namprd21.prod.outlook.com>
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


Hi Michael:
       Thanks for your review.

On 9/2/2021 8:15 AM, Michael Kelley wrote:
> From: Tianyu Lan <ltykernel@gmail.com> Sent: Friday, August 27, 2021 10:21 AM
>>
>> Hyper-V exposes shared memory boundary via cpuid
>> HYPERV_CPUID_ISOLATION_CONFIG and store it in the
>> shared_gpa_boundary of ms_hyperv struct. This prepares
>> to share memory with host for SNP guest.
>>
>> Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
>> ---
>> Change since v3:
>> 	* user BIT_ULL to get shared_gpa_boundary
>> 	* Rename field Reserved* to reserved
>> ---
>>   arch/x86/kernel/cpu/mshyperv.c |  2 ++
>>   include/asm-generic/mshyperv.h | 12 +++++++++++-
>>   2 files changed, 13 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
>> index 20557a9d6e25..8bb001198316 100644
>> --- a/arch/x86/kernel/cpu/mshyperv.c
>> +++ b/arch/x86/kernel/cpu/mshyperv.c
>> @@ -313,6 +313,8 @@ static void __init ms_hyperv_init_platform(void)
>>   	if (ms_hyperv.priv_high & HV_ISOLATION) {
>>   		ms_hyperv.isolation_config_a = cpuid_eax(HYPERV_CPUID_ISOLATION_CONFIG);
>>   		ms_hyperv.isolation_config_b = cpuid_ebx(HYPERV_CPUID_ISOLATION_CONFIG);
>> +		ms_hyperv.shared_gpa_boundary =
>> +			BIT_ULL(ms_hyperv.shared_gpa_boundary_bits);
>>
>>   		pr_info("Hyper-V: Isolation Config: Group A 0x%x, Group B 0x%x\n",
>>   			ms_hyperv.isolation_config_a, ms_hyperv.isolation_config_b);
>> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
>> index 0924bbd8458e..7537ae1db828 100644
>> --- a/include/asm-generic/mshyperv.h
>> +++ b/include/asm-generic/mshyperv.h
>> @@ -35,7 +35,17 @@ struct ms_hyperv_info {
>>   	u32 max_vp_index;
>>   	u32 max_lp_index;
>>   	u32 isolation_config_a;
>> -	u32 isolation_config_b;
>> +	union {
>> +		u32 isolation_config_b;
>> +		struct {
>> +			u32 cvm_type : 4;
>> +			u32 reserved11 : 1;
>> +			u32 shared_gpa_boundary_active : 1;
>> +			u32 shared_gpa_boundary_bits : 6;
>> +			u32 reserved12 : 20;
> 
> I'm still curious about the "11" and "12" in the reserved
> field names.  Why not just "reserved1" and "reserved2"?
> Having the "11" and "12" isn't wrong, but it makes one
> wonder why since it's not usual. :-)
> 

Yes, will update. Thanks.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
