Return-Path: <SRS0=n6uX=NS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8383AC432BE
	for <iommu@archiver.kernel.org>; Fri, 27 Aug 2021 17:47:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A83860FC4
	for <iommu@archiver.kernel.org>; Fri, 27 Aug 2021 17:47:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3A83860FC4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id F02C74081B;
	Fri, 27 Aug 2021 17:47:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id omBSH7NO1NrR; Fri, 27 Aug 2021 17:47:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A97B640810;
	Fri, 27 Aug 2021 17:47:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 72546C001A;
	Fri, 27 Aug 2021 17:47:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 62785C000E
 for <iommu@lists.linux-foundation.org>; Fri, 27 Aug 2021 17:47:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3D0C54279E
 for <iommu@lists.linux-foundation.org>; Fri, 27 Aug 2021 17:47:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZxxYv0BxwyU7 for <iommu@lists.linux-foundation.org>;
 Fri, 27 Aug 2021 17:47:01 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A23634279B
 for <iommu@lists.linux-foundation.org>; Fri, 27 Aug 2021 17:47:01 +0000 (UTC)
Received: by mail-pl1-x631.google.com with SMTP id x16so2740092pll.2
 for <iommu@lists.linux-foundation.org>; Fri, 27 Aug 2021 10:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=i9TmDZ+esw/3ZLUDMU0ftSn23gEkgnQwCRuas4CrT3U=;
 b=IHtobvTQGY1nPT3/rK9A1D4px0mz9BbFo22Zema5+9nth1Iz8xRjEgbud3ecsrTACs
 Vi0LRfmP6pC0DYOfU30m5IkT0RTdx1CV7IJxATteIxw8CIRTVVgLMm1G9RvSeC8txy3w
 3vkVe4JLgdQHuErnQrEWdxOE6rP0ErL9md4E0hh+apLDdJ7WZ48WHolfWdjVexGKS4Fg
 64VkrIaGeWHwfHBR7pDlwiNy9s7exrN3vRd0AJl72z/zDyU7wj7/6rHEM1CVLs3fMsSi
 383OW19VKOeS1sl5t8aORjPeFCc0nn+WtBx09yLwfzvn3x+xousu5jOLlDzZAsqMezkN
 xg2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=i9TmDZ+esw/3ZLUDMU0ftSn23gEkgnQwCRuas4CrT3U=;
 b=QMG8PHy0U1PUgFyoDTlCUPzDg3TT38bSbx0GehcKxm/x/N6fJn1Az3Z7P39rbtuOyE
 2bSn4RIMaZLkyL1aMDroSt4WCZJea6MYAGvvx+r+Bzbp7kh2+EZKzkpDAQjs7i3vmFoz
 Lg4uATkPHkiADCrj6Ysl94KKuMsx10gfZ5N7pHwfqd6v091IEzNh3znUfrF1FJ/fZ+tz
 b+FPYveZDRdQhQ1r2VZpTQJEuzTFW7WuwTxryrJjQ3FAZu6e9FoAUL7ODCU1Ncc+/lkb
 Y+OzXPP98R9WkKbYuScbL4Zp6bY49L22V3mPX51rX3GoRcFFe5lKYcoKZh5Ypb/Gxy0c
 81xg==
X-Gm-Message-State: AOAM531MLCtk2EXA9lOeCce7mGv/XmnLagfvzZv9GOfmg7QfU0aKFvQi
 3B5bm8TLDtf2bV+FHEfCxrI=
X-Google-Smtp-Source: ABdhPJwCpp1CTTpUQk7qWKnIh/yFBudGLOgzTmHXJL1o6YBu8x2FX5yDDzUTnumdUgFfk3BNuYTWSw==
X-Received: by 2002:a17:902:8d8a:b029:12d:3774:3630 with SMTP id
 v10-20020a1709028d8ab029012d37743630mr9735558plo.65.1630086421011; 
 Fri, 27 Aug 2021 10:47:01 -0700 (PDT)
Received: from ?IPv6:2404:f801:0:5:8000::50b? ([2404:f801:9000:1a:efea::50b])
 by smtp.gmail.com with ESMTPSA id
 h13sm6970553pgh.93.2021.08.27.10.46.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Aug 2021 10:47:00 -0700 (PDT)
Subject: Re: [PATCH V4 05/13] hyperv: Add Write/Read MSR registers via ghcb
 page
To: Greg KH <gregkh@linuxfoundation.org>
References: <20210827172114.414281-1-ltykernel@gmail.com>
 <20210827172114.414281-6-ltykernel@gmail.com> <YSkj2kvYoYW8kDiF@kroah.com>
From: Tianyu Lan <ltykernel@gmail.com>
Message-ID: <aed9409f-8708-2599-e441-c6a0c92b737b@gmail.com>
Date: Sat, 28 Aug 2021 01:46:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YSkj2kvYoYW8kDiF@kroah.com>
Content-Language: en-US
Cc: parri.andrea@gmail.com, linux-hyperv@vger.kernel.org, brijesh.singh@amd.com,
 peterz@infradead.org, catalin.marinas@arm.com, dave.hansen@linux.intel.com,
 dave.hansen@intel.com, hpa@zytor.com, kys@microsoft.com, will@kernel.org,
 boris.ostrovsky@oracle.com, linux-arch@vger.kernel.org, wei.liu@kernel.org,
 sstabellini@kernel.org, sthemmin@microsoft.com, xen-devel@lists.xenproject.org,
 linux-scsi@vger.kernel.org, aneesh.kumar@linux.ibm.com, x86@kernel.org,
 decui@microsoft.com, hch@lst.de, michael.h.kelley@microsoft.com,
 mingo@redhat.com, pgonda@google.com, rientjes@google.com, kuba@kernel.org,
 jejb@linux.ibm.com, martin.b.radev@gmail.com, thomas.lendacky@amd.com,
 Tianyu.Lan@microsoft.com, arnd@arndb.de, konrad.wilk@oracle.com,
 haiyangz@microsoft.com, bp@alien8.de, luto@kernel.org,
 krish.sadhukhan@oracle.com, tglx@linutronix.de, vkuznets@redhat.com,
 linux-arm-kernel@lists.infradead.org, jgross@suse.com,
 martin.petersen@oracle.com, saravanand@fb.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 rppt@kernel.org, hannes@cmpxchg.org, ardb@kernel.org,
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

On 8/28/2021 1:41 AM, Greg KH wrote:
> On Fri, Aug 27, 2021 at 01:21:03PM -0400, Tianyu Lan wrote:
>> From: Tianyu Lan <Tianyu.Lan@microsoft.com>
>>
>> Hyperv provides GHCB protocol to write Synthetic Interrupt
>> Controller MSR registers in Isolation VM with AMD SEV SNP
>> and these registers are emulated by hypervisor directly.
>> Hyperv requires to write SINTx MSR registers twice. First
>> writes MSR via GHCB page to communicate with hypervisor
>> and then writes wrmsr instruction to talk with paravisor
>> which runs in VMPL0. Guest OS ID MSR also needs to be set
>> via GHCB page.
>>
>> Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
>> ---
>> Change since v1:
>>           * Introduce sev_es_ghcb_hv_call_simple() and share code
>>             between SEV and Hyper-V code.
>> Change since v3:
>>           * Pass old_msg_type to hv_signal_eom() as parameter.
>> 	 * Use HV_REGISTER_* marcro instead of HV_X64_MSR_*
>> 	 * Add hv_isolation_type_snp() weak function.
>> 	 * Add maros to set syinc register in ARM code.
>> ---
>>   arch/arm64/include/asm/mshyperv.h |  23 ++++++
>>   arch/x86/hyperv/hv_init.c         |  36 ++--------
>>   arch/x86/hyperv/ivm.c             | 112 ++++++++++++++++++++++++++++++
>>   arch/x86/include/asm/mshyperv.h   |  80 ++++++++++++++++++++-
>>   arch/x86/include/asm/sev.h        |   3 +
>>   arch/x86/kernel/sev-shared.c      |  63 ++++++++++-------
>>   drivers/hv/hv.c                   | 112 ++++++++++++++++++++----------
>>   drivers/hv/hv_common.c            |   6 ++
>>   include/asm-generic/mshyperv.h    |   4 +-
>>   9 files changed, 345 insertions(+), 94 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/mshyperv.h b/arch/arm64/include/asm/mshyperv.h
>> index 20070a847304..ced83297e009 100644
>> --- a/arch/arm64/include/asm/mshyperv.h
>> +++ b/arch/arm64/include/asm/mshyperv.h
>> @@ -41,6 +41,29 @@ static inline u64 hv_get_register(unsigned int reg)
>>   	return hv_get_vpreg(reg);
>>   }
>>   
>> +#define hv_get_simp(val)	{ val = hv_get_register(HV_REGISTER_SIMP); }
>> +#define hv_set_simp(val)	hv_set_register(HV_REGISTER_SIMP, val)
>> +
>> +#define hv_get_siefp(val)	{ val = hv_get_register(HV_REGISTER_SIEFP); }
>> +#define hv_set_siefp(val)	hv_set_register(HV_REGISTER_SIEFP, val)
>> +
>> +#define hv_get_synint_state(int_num, val) {			\
>> +	val = hv_get_register(HV_REGISTER_SINT0 + int_num);	\
>> +	}
>> +
>> +#define hv_set_synint_state(int_num, val)			\
>> +	hv_set_register(HV_REGISTER_SINT0 + int_num, val)
>> +
>> +#define hv_get_synic_state(val) {			\
>> +	val = hv_get_register(HV_REGISTER_SCONTROL);	\
>> +	}
>> +
>> +#define hv_set_synic_state(val)			\
>> +	hv_set_register(HV_REGISTER_SCONTROL, val)
>> +
>> +#define hv_signal_eom(old_msg_type)		 \
>> +	hv_set_register(HV_REGISTER_EOM, 0)
> 
> Please just use real inline functions and not #defines if you really
> need it.
> 

OK. Will update. Thanks.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
