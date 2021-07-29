Return-Path: <SRS0=dGrv=MV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87DF0C4338F
	for <iommu@archiver.kernel.org>; Thu, 29 Jul 2021 12:49:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B26460F23
	for <iommu@archiver.kernel.org>; Thu, 29 Jul 2021 12:49:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1B26460F23
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D4BC4404D3;
	Thu, 29 Jul 2021 12:49:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id U-q0Y6kumoVE; Thu, 29 Jul 2021 12:49:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id BA4FB404D1;
	Thu, 29 Jul 2021 12:49:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 90EBBC001A;
	Thu, 29 Jul 2021 12:49:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8B396C000E
 for <iommu@lists.linux-foundation.org>; Thu, 29 Jul 2021 12:49:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 71BD7404D2
 for <iommu@lists.linux-foundation.org>; Thu, 29 Jul 2021 12:49:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FHTtwI4htpUa for <iommu@lists.linux-foundation.org>;
 Thu, 29 Jul 2021 12:49:48 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5AB15404D1
 for <iommu@lists.linux-foundation.org>; Thu, 29 Jul 2021 12:49:48 +0000 (UTC)
Received: by mail-pl1-x636.google.com with SMTP id k1so6818545plt.12
 for <iommu@lists.linux-foundation.org>; Thu, 29 Jul 2021 05:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Q0SGRNEWOSLrhO9/bSDBCi5NITuZ+vRSfRGxTziJabU=;
 b=hzKyL5WmsMRD8k+m34XXrgdj7/1e9J85KeDCiJLjzHeqLjqVNN2QCjPp4LTbl8n7tq
 kiYmXEtjueHlVfkLJ8A0fmKvkAGZq+7s4OPYyA0r0BplF5amF3k3XUoUsQgPz8D0bLYG
 d/uu5na8UGcsGtBUkC2kT3gdJO2GxEqPZL2kiRMtbua3knkxb2jI3qoK7y+jAWGsPcYP
 PEdCF+dn9EI6vMVdi6PlEaCnPYi6emG2vaA6WRsUJGCwTl68cpIhDOIIyYkeJamoSXUa
 bu5X6znaixSj3iryQEAayd0uzQ2zW3G7sNXtamd3fsj3KVhp3gkX0Kdn2h9rosJI0OHl
 wWSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Q0SGRNEWOSLrhO9/bSDBCi5NITuZ+vRSfRGxTziJabU=;
 b=b3xAUwRhaICHMI+Me35TEuKX7ihnpJZnKApZwq5fQxleGSwyt+jLMtRKFo+bZau2Sg
 dMJiClJplqdHw/KfzJ9uXQmoRuFSXCWy/kaLYWmy6mv/KRvIx+qkFbiN5RCHJjxG1ZfF
 l66pRvR91GXdc1E+WH0KCBTx1oRQ2SEjaJ8xMDh1zLlDXd73amCJnd/qaheAwNg7Xhq1
 rcSqSYakfyp1VhdIfc1WYYnjywDNtYKQIRs7DuPJC+9lBQ+mqXN2NiXQuo0ibN9gtQlN
 ExSZKYigl903/02npKUNqXoxeBeqwDrhw9HrtITs6ERlecQ4E10Q56Okfk4bYgqLb+pp
 COBg==
X-Gm-Message-State: AOAM533ruhsCGek+wnquwnGMQYwBpnCwQiADOREp3ml0lYBhYYXZrYbL
 w20rtE6UuxyDPTFvxZcgkac=
X-Google-Smtp-Source: ABdhPJxEQWV2usuKh29jSoH2loa36HykTtuvI7jMK52U0Q907fZvwTlhcl4mO3CPvQocl1ZpGKnVjQ==
X-Received: by 2002:aa7:9086:0:b029:39b:6377:17c1 with SMTP id
 i6-20020aa790860000b029039b637717c1mr5007664pfa.11.1627562987803; 
 Thu, 29 Jul 2021 05:49:47 -0700 (PDT)
Received: from ?IPv6:2404:f801:0:5:8000::4b1? ([2404:f801:9000:18:efec::4b1])
 by smtp.gmail.com with ESMTPSA id
 k198sm3710340pfd.148.2021.07.29.05.49.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Jul 2021 05:49:47 -0700 (PDT)
Subject: Re: [PATCH 03/13] x86/HV: Add new hvcall guest address host
 visibility support
To: Dave Hansen <dave.hansen@intel.com>, kys@microsoft.com,
 haiyangz@microsoft.com, sthemmin@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 x86@kernel.org, hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org,
 peterz@infradead.org, konrad.wilk@oracle.com, boris.ostrovsky@oracle.com,
 jgross@suse.com, sstabellini@kernel.org, joro@8bytes.org, will@kernel.org,
 davem@davemloft.net, kuba@kernel.org, jejb@linux.ibm.com,
 martin.petersen@oracle.com, arnd@arndb.de, hch@lst.de,
 m.szyprowski@samsung.com, robin.murphy@arm.com, thomas.lendacky@amd.com,
 brijesh.singh@amd.com, ardb@kernel.org, Tianyu.Lan@microsoft.com,
 rientjes@google.com, martin.b.radev@gmail.com, akpm@linux-foundation.org,
 rppt@kernel.org, kirill.shutemov@linux.intel.com,
 aneesh.kumar@linux.ibm.com, krish.sadhukhan@oracle.com, saravanand@fb.com,
 xen-devel@lists.xenproject.org, pgonda@google.com, david@redhat.com,
 keescook@chromium.org, hannes@cmpxchg.org, sfr@canb.auug.org.au,
 michael.h.kelley@microsoft.com
References: <20210728145232.285861-1-ltykernel@gmail.com>
 <20210728145232.285861-4-ltykernel@gmail.com>
 <c00e269c-da4c-c703-0182-0221c73a76cc@intel.com>
From: Tianyu Lan <ltykernel@gmail.com>
Message-ID: <ccbe6f4c-5ffe-4d63-67ab-6384fcb8691d@gmail.com>
Date: Thu, 29 Jul 2021 20:49:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <c00e269c-da4c-c703-0182-0221c73a76cc@intel.com>
Content-Language: en-US
Cc: linux-arch@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-scsi@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 anparri@microsoft.com, vkuznets@redhat.com
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

Hi Dave:
      Thanks for your review.

On 7/28/2021 11:29 PM, Dave Hansen wrote:
> On 7/28/21 7:52 AM, Tianyu Lan wrote:
>> @@ -1986,7 +1988,9 @@ static int __set_memory_enc_dec(unsigned long addr, int numpages, bool enc)
>>   	int ret;
>>   
>>   	/* Nothing to do if memory encryption is not active */
>> -	if (!mem_encrypt_active())
>> +	if (hv_is_isolation_supported())
>> +		return hv_set_mem_enc(addr, numpages, enc);
>> +	else if (!mem_encrypt_active())
>>   		return 0;
> 
> __set_memory_enc_dec() is turning into a real mess.  SEV, TDX and now
> Hyper-V are messing around in here.
> 
> It doesn't help that these additions are totally uncommented.  Even
> worse is that hv_set_mem_enc() was intentionally named "enc" when it
> presumably has nothing to do with encryption.
> 
> This needs to be refactored.  The current __set_memory_enc_dec() can
> become __set_memory_enc_pgtable().  It gets used for the hypervisors
> that get informed about "encryption" status via page tables: SEV and TDX.
> 
> Then, rename hv_set_mem_enc() to hv_set_visible_hcall().  You'll end up
> with:
> 
> int __set_memory_enc_dec(unsigned long addr, int numpages, bool enc)
> {
> 	if (hv_is_isolation_supported())
> 		return hv_set_visible_hcall(...);
> 
> 	if (mem_encrypt_active() || ...)
> 		return __set_memory_enc_pgtable();
> 
> 	/* Nothing to do */
> 	return 0;
> }
> 
> That tells the story pretty effectively, in code.

Yes, this is good idea. Thanks for your suggestion.

> 
>> +int hv_set_mem_enc(unsigned long addr, int numpages, bool enc)
>> +{
>> +	return hv_set_mem_host_visibility((void *)addr,
>> +			numpages * HV_HYP_PAGE_SIZE,
>> +			enc ? VMBUS_PAGE_NOT_VISIBLE
>> +			: VMBUS_PAGE_VISIBLE_READ_WRITE);
>> +}
> 
> I know this is off in Hyper-V code, but this just makes my eyes bleed.
> I'd much rather see something which is less compact but readable.

OK. Will update.

> 
>> +/* Hyper-V GPA map flags */
>> +#define	VMBUS_PAGE_NOT_VISIBLE		0
>> +#define	VMBUS_PAGE_VISIBLE_READ_ONLY	1
>> +#define	VMBUS_PAGE_VISIBLE_READ_WRITE	3
> 
> That looks suspiciously like an enum.
>

OK. Will update.

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
