Return-Path: <SRS0=RnLw=MA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EEFEC07E96
	for <iommu@archiver.kernel.org>; Thu,  8 Jul 2021 13:55:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CA966141A
	for <iommu@archiver.kernel.org>; Thu,  8 Jul 2021 13:55:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CA966141A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 07D1541612;
	Thu,  8 Jul 2021 13:55:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bO7mgc6lG_qM; Thu,  8 Jul 2021 13:55:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id BFE1C415E5;
	Thu,  8 Jul 2021 13:55:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 956EEC0010;
	Thu,  8 Jul 2021 13:55:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8CA43C0010
 for <iommu@lists.linux-foundation.org>; Thu,  8 Jul 2021 13:55:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7AB0341CDA
 for <iommu@lists.linux-foundation.org>; Thu,  8 Jul 2021 13:54:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iVnCO91jVSrV for <iommu@lists.linux-foundation.org>;
 Thu,  8 Jul 2021 13:54:33 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com
 [IPv6:2607:f8b0:4864:20::52a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3791741CED
 for <iommu@lists.linux-foundation.org>; Thu,  8 Jul 2021 13:54:33 +0000 (UTC)
Received: by mail-pg1-x52a.google.com with SMTP id v7so6046823pgl.2
 for <iommu@lists.linux-foundation.org>; Thu, 08 Jul 2021 06:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=flXS1TuPwc//SKu4jyAw/jiI5sdlmmbGzljFY5ti5Is=;
 b=XPkbMtvNl1RRRIvI1exOBM0vNgLKe6Jr87NeF6M+XhU9hnWhIdYPy6g62fwe5U7Scv
 3OrZnM5xlgUHY4f2QkjgEeTcpa0o7dLnUyXfN9mRo8UFkwC9CeIap+ugcNZHLtK80D4t
 8wj5AZpA2H01PaBi7V8Kr6OodXxWYwqaKRbRwr4D/HdqeXVSeWVPyWGFP9JDZE8rPpuq
 b1I1cNp+0ih77D2DO6KbMwqCi2Da2EhcxiCcJG4ylxqWFEI1KpNBSWZO6ZthAYh6sGk7
 5b0XLFqNbcA1I9TlauYSplfC94nkC/MEEMZPwarYocJlHfxxxZoTys2fUSvH0P62QbMn
 xy8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=flXS1TuPwc//SKu4jyAw/jiI5sdlmmbGzljFY5ti5Is=;
 b=im3Hyd7lAdB9oaKo6jypNq81V8R9DBRaible9iEyohkcNYlAH/mbKOYfAyIt0rZTbE
 yXbZ+nQ4mwlcp83YBc3Yk4kjkA1iC8eIZtap63nvpvGX40ms5r0s3fh3Rx6Rj8bnlkaq
 QL14NLuYbJhPPm8WmLm7WuEyXj82VbkkPXv6v351ZVsimbGar+8EREGw5mw1rKrvhKNi
 6df54MoyJFmEC7Y5aWeo4AL7oDiA9oh+iDQef4zNsuQ6vMI8s3OwIxpVZx/kjD4Tvuip
 JnE3qCw/xOYL66okQNTKAf44kmgCFeAW8l7Far2nQGcmfMgBKb5HlCCEZkLNDsgJyKWT
 GIDg==
X-Gm-Message-State: AOAM530wkOmyG9Ti52N7acLhPXZ5bQaDyCJJDxYb+wYSJgT2jPrsMZaD
 FuOQp/LLyAJ+kBhT5b/Hz7o=
X-Google-Smtp-Source: ABdhPJz+HRb86cNh6Rdrx5mbqP68t5brrjDI0iQFQSntirGPjVbEL5v53qALGvweTO+18SVX/9PgGQ==
X-Received: by 2002:a63:f556:: with SMTP id e22mr32044865pgk.189.1625752472618; 
 Thu, 08 Jul 2021 06:54:32 -0700 (PDT)
Received: from ?IPv6:2404:f801:0:5:8000::4b1? ([2404:f801:9000:1a:efea::4b1])
 by smtp.gmail.com with ESMTPSA id
 s6sm10053656pjp.45.2021.07.08.06.54.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jul 2021 06:54:32 -0700 (PDT)
Subject: Re: [Resend RFC PATCH V4 13/13] x86/HV: Not set memory
 decrypted/encrypted during kexec alloc/free page in IVM
To: Dave Hansen <dave.hansen@intel.com>, kys@microsoft.com,
 haiyangz@microsoft.com, sthemmin@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 x86@kernel.org, hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org,
 peterz@infradead.org, konrad.wilk@oracle.com, boris.ostrovsky@oracle.com,
 jgross@suse.com, sstabellini@kernel.org, joro@8bytes.org, will@kernel.org,
 davem@davemloft.net, kuba@kernel.org, jejb@linux.ibm.com,
 martin.petersen@oracle.com, arnd@arndb.de, hch@lst.de,
 m.szyprowski@samsung.com, robin.murphy@arm.com,
 kirill.shutemov@linux.intel.com, akpm@linux-foundation.org, rppt@kernel.org,
 Tianyu.Lan@microsoft.com, thomas.lendacky@amd.com, ardb@kernel.org,
 robh@kernel.org, nramas@linux.microsoft.com, pgonda@google.com,
 martin.b.radev@gmail.com, david@redhat.com, krish.sadhukhan@oracle.com,
 saravanand@fb.com, xen-devel@lists.xenproject.org, keescook@chromium.org,
 rientjes@google.com, hannes@cmpxchg.org, michael.h.kelley@microsoft.com
References: <20210707154629.3977369-1-ltykernel@gmail.com>
 <20210707154629.3977369-14-ltykernel@gmail.com>
 <3b5a1bd0-369a-2723-97c1-4ab4edb14eda@intel.com>
From: Tianyu Lan <ltykernel@gmail.com>
Message-ID: <e4508d82-826e-86be-96cf-feecc1b4a260@gmail.com>
Date: Thu, 8 Jul 2021 21:54:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <3b5a1bd0-369a-2723-97c1-4ab4edb14eda@intel.com>
Content-Language: en-US
Cc: linux-arch@vger.kernel.org, linux-hyperv@vger.kernel.org,
 brijesh.singh@amd.com, linux-scsi@vger.kernel.org, netdev@vger.kernel.org,
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

On 7/8/2021 12:14 AM, Dave Hansen wrote:
> On 7/7/21 8:46 AM, Tianyu Lan wrote:
>> @@ -598,7 +599,7 @@ void arch_kexec_unprotect_crashkres(void)
>>    */
>>   int arch_kexec_post_alloc_pages(void *vaddr, unsigned int pages, gfp_t gfp)
>>   {
>> -	if (sev_active())
>> +	if (sev_active() || hv_is_isolation_supported())
>>   		return 0;
>>   
>>   	/*
>> @@ -611,7 +612,7 @@ int arch_kexec_post_alloc_pages(void *vaddr, unsigned int pages, gfp_t gfp)
>>   
>>   void arch_kexec_pre_free_pages(void *vaddr, unsigned int pages)
>>   {
>> -	if (sev_active())
>> +	if (sev_active() || hv_is_isolation_supported())
>>   		return;
> 
> You might want to take a look through the "protected guest" patches.  I
> think this series is touching a few of the same locations that TDX and
> recent SEV work touch.
> 
> https://lore.kernel.org/lkml/20210618225755.662725-5-sathyanarayanan.kuppuswamy@linux.intel.com/

Thanks for reminder. You are right. There will be a generic API to check 
"proteced guest" type.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
