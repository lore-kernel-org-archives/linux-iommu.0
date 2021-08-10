Return-Path: <SRS0=o4oj=NB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39BD7C4338F
	for <iommu@archiver.kernel.org>; Tue, 10 Aug 2021 13:09:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3FBE60F38
	for <iommu@archiver.kernel.org>; Tue, 10 Aug 2021 13:09:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B3FBE60F38
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 72B0F40231;
	Tue, 10 Aug 2021 13:09:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nTzdOtYeCOr7; Tue, 10 Aug 2021 13:09:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4EFDB401CB;
	Tue, 10 Aug 2021 13:09:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1A7B3C0010;
	Tue, 10 Aug 2021 13:09:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F0400C000E
 for <iommu@lists.linux-foundation.org>; Tue, 10 Aug 2021 13:09:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DF93A607F1
 for <iommu@lists.linux-foundation.org>; Tue, 10 Aug 2021 13:09:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6vKoAyBacoBH for <iommu@lists.linux-foundation.org>;
 Tue, 10 Aug 2021 13:09:31 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CF5D8606CE
 for <iommu@lists.linux-foundation.org>; Tue, 10 Aug 2021 13:09:31 +0000 (UTC)
Received: by mail-pj1-x1033.google.com with SMTP id
 w13-20020a17090aea0db029017897a5f7bcso5241172pjy.5
 for <iommu@lists.linux-foundation.org>; Tue, 10 Aug 2021 06:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=66KGVVLHGJOMxSHzgJj6VDCRB8/apj3sR/Ynuos6wU8=;
 b=pt4Qw4Gt2cFRP884fMrdBTfJzkwL2gx6Mo1qS6xvvDhfSdIustLAFX7++VkRY1h4um
 tTehujaFm9rbEjIEwB0Xu4QM2VZRfXhLGrMo8JNp/sDj6XoPD9WPfZ8v2F3qn2rH9A9d
 OGCnPFdaPpTRfjqukxIeWiIpd6XfYc4MZvSVh7tbwIwGO2vT6u6skC56ab4LGrfYsBku
 cbFUdZZjMM6VnimGAjkoLRcPks9PLwbJP0vFH3G0Hbv47WNqW4yslC4eCkDCDu113c9j
 ijT0klWyzKut4iQ2YBiKGjugVqCFd+8zcrAniUpAohoQSh6qC1V2Qr33L9WPJqBDjAdX
 IuxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=66KGVVLHGJOMxSHzgJj6VDCRB8/apj3sR/Ynuos6wU8=;
 b=S0Y+SQXaLk0ITKqsejXgoNEXwmgKk2E+C125q2E3MW7HzlkKQ5skzAff09IbmYuevq
 73PedafnsxbmGAu879cEJ6BSOdnVj5qPeUPesspjCJ05mTkhdhXCMw1RcTDIuCOOfVPc
 Ks/I8YEdmj1OYtgkHJvlfnGIxNgGbs6jsED64l1DNHCDuJ5YQ10MVdbbsQR1oZACDyge
 wC2HJagqsa1itoHfiyvpy03pz+ad+AmmnFdi1FeP5kwIvaWvrwYuptF+RnXCtBoWuE3z
 HD6P5PANs+jMQZmVqO0XZLg4Q8FvuvjMDUZql/Xfw1eyAjBLZWbUVsBdEiidT5HLrLz/
 4WnA==
X-Gm-Message-State: AOAM530rHVxgRd1nnJ4kMjLW3hZaTszO0+cohjRbXWgxpiA7RNuKUgdv
 JKlbpzEa89BIJyljWwkh2Eo=
X-Google-Smtp-Source: ABdhPJzfPih5Ybmexq3iu0hKNG6YxeEAVSzL4u+nolQ/+flfaaM1LfzobnQ7JyAdR0R5YSEGRoeWmg==
X-Received: by 2002:aa7:8f05:0:b029:3b4:ff54:9a10 with SMTP id
 x5-20020aa78f050000b02903b4ff549a10mr29132627pfr.29.1628600971342; 
 Tue, 10 Aug 2021 06:09:31 -0700 (PDT)
Received: from ?IPv6:2404:f801:0:5:8000::4b1? ([2404:f801:9000:18:efec::4b1])
 by smtp.gmail.com with ESMTPSA id
 c9sm22240121pgq.58.2021.08.10.06.09.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Aug 2021 06:09:30 -0700 (PDT)
Subject: Re: [PATCH V3 03/13] x86/HV: Add new hvcall guest address host
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
 pgonda@google.com, martin.b.radev@gmail.com, akpm@linux-foundation.org,
 kirill.shutemov@linux.intel.com, rppt@kernel.org, sfr@canb.auug.org.au,
 saravanand@fb.com, krish.sadhukhan@oracle.com, aneesh.kumar@linux.ibm.com,
 xen-devel@lists.xenproject.org, rientjes@google.com, hannes@cmpxchg.org,
 tj@kernel.org, michael.h.kelley@microsoft.com
References: <20210809175620.720923-1-ltykernel@gmail.com>
 <20210809175620.720923-4-ltykernel@gmail.com>
 <a0499916-38e2-0b1e-f2b9-ef760f6d4d92@intel.com>
From: Tianyu Lan <ltykernel@gmail.com>
Message-ID: <3f09c505-3e4d-3b06-e92a-db6fd3e50d0c@gmail.com>
Date: Tue, 10 Aug 2021 21:09:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <a0499916-38e2-0b1e-f2b9-ef760f6d4d92@intel.com>
Content-Language: en-US
Cc: linux-arch@vger.kernel.org, parri.andrea@gmail.com,
 linux-hyperv@vger.kernel.org, linux-scsi@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, vkuznets@redhat.com
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

On 8/10/2021 6:12 AM, Dave Hansen wrote:
> On 8/9/21 10:56 AM, Tianyu Lan wrote:
>> From: Tianyu Lan <Tianyu.Lan@microsoft.com>
>>
>> Add new hvcall guest address host visibility support to mark
>> memory visible to host. Call it inside set_memory_decrypted
>> /encrypted(). Add HYPERVISOR feature check in the
>> hv_is_isolation_supported() to optimize in non-virtualization
>> environment.
> 
>  From an x86/mm perspective:
> 
> Acked-by: Dave Hansen <dave.hansen@intel.com>
> 

Thanks for your ACK.


> A tiny nit:
> 
>> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
>> index 0bb4d9ca7a55..b3683083208a 100644
>> --- a/arch/x86/hyperv/hv_init.c
>> +++ b/arch/x86/hyperv/hv_init.c
>> @@ -607,6 +607,12 @@ EXPORT_SYMBOL_GPL(hv_get_isolation_type);
>>   
>>   bool hv_is_isolation_supported(void)
>>   {
>> +	if (!cpu_feature_enabled(X86_FEATURE_HYPERVISOR))
>> +		return 0;
>> +
>> +	if (!hypervisor_is_type(X86_HYPER_MS_HYPERV))
>> +		return 0;
>> +
>>   	return hv_get_isolation_type() != HV_ISOLATION_TYPE_NONE;
>>   }
> This might be worthwhile to move to a header.  That ensures that
> hv_is_isolation_supported() use can avoid even a function call.  But, I
> see this is used in modules and its use here is also in a slow path, so
> it's not a big deal
> 

I will move it to header in the following version.


Thanks.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
