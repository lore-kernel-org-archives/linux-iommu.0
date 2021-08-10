Return-Path: <SRS0=o4oj=NB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 455DBC4338F
	for <iommu@archiver.kernel.org>; Tue, 10 Aug 2021 12:25:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1CCD61051
	for <iommu@archiver.kernel.org>; Tue, 10 Aug 2021 12:25:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F1CCD61051
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B6D2C834C6;
	Tue, 10 Aug 2021 12:25:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Vzs7I-j0ObAD; Tue, 10 Aug 2021 12:25:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8BE1783187;
	Tue, 10 Aug 2021 12:25:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5F2E7C001A;
	Tue, 10 Aug 2021 12:25:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D76D4C000E
 for <iommu@lists.linux-foundation.org>; Tue, 10 Aug 2021 12:25:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B881640522
 for <iommu@lists.linux-foundation.org>; Tue, 10 Aug 2021 12:25:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vZKYb0rYanqj for <iommu@lists.linux-foundation.org>;
 Tue, 10 Aug 2021 12:25:37 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 353C240517
 for <iommu@lists.linux-foundation.org>; Tue, 10 Aug 2021 12:25:37 +0000 (UTC)
Received: by mail-pj1-x1033.google.com with SMTP id
 u13-20020a17090abb0db0290177e1d9b3f7so4078878pjr.1
 for <iommu@lists.linux-foundation.org>; Tue, 10 Aug 2021 05:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=KL/EO4tx0TgX51zBlp9/CRNMvpFlpR97J3ss4EOthZ4=;
 b=Ku17ZPCf0pl6UbjbC+OHRNn+ACNBAQsVDchdBbllR6na7JEZVKeCa/0V92DnHTF4iu
 ltIgOtvQG3ChEWFKQGS+ZCmo2X5SwNpdvKDzPZ6w0gyO5dvGz4wCAvWk5byjwwrwUcRC
 5GXqtBHSfAX3q8Kpy97hYWlFUn1WyjEzTjjzbz4eIMRpPJ/3pBUQT0IeP+6w+Os/n12x
 G3057aJUPMJ9DEYkyOBYuaABfzqFcCP+cS+hRvjLg1IN1XmahkLLELPX+1i2xq4zJ7oh
 O3GJi71MYUghn8gllMllI0c3neKMWm0JGzHgfC7goYCwLqZcdx+lapv2oLk7A8os2kge
 ueiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=KL/EO4tx0TgX51zBlp9/CRNMvpFlpR97J3ss4EOthZ4=;
 b=UKYywsBllVBIgQO7/IF58kByTbDf6fON+hEysMw6sEqXHFVZaDnLtJiEVURySLvMhF
 rNSUTotgpxjfkfb32tfO0BcnsWZEG/zfQMXGFJfGvutDr9YMcRm7iKH6NvEx3rOlz9QR
 iz9wBnx1NDvdak5BLDCIeZWBrtf5cYjsvym/R5vAl9uvGHDqWui0ozhpMIDCE0oVNcV9
 d0ooJnp+qL7niQP/qLw87WvAJEnMbfyRbJfrYViriDQYiQWX+g2UJGMM80q7wUHR/UgZ
 /aCu44NnMC34COKkl/A6XdR/4OqQzshGJVwUqbeUFMKZlpWD1L2tz9MQ/9MBxXvKJ8bv
 xgZw==
X-Gm-Message-State: AOAM532Se0eR2uyrUPq879wjylYkL38QWFAqxUer5+ekpJb+USr/fJyx
 64nEuEoutxz8PhkDadd7GQw=
X-Google-Smtp-Source: ABdhPJxebFlgnG0NPPgyE6OjM0zu1XGnchtqFN1rLMZ/uNLQlKSp1bY7DCu3pvqaqyd/DJ1LphsUcQ==
X-Received: by 2002:a63:e116:: with SMTP id z22mr254278pgh.361.1628598336671; 
 Tue, 10 Aug 2021 05:25:36 -0700 (PDT)
Received: from ?IPv6:2404:f801:0:5:8000::4b1? ([2404:f801:9000:1a:efea::4b1])
 by smtp.gmail.com with ESMTPSA id
 c14sm27323452pgv.86.2021.08.10.05.25.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Aug 2021 05:25:35 -0700 (PDT)
Subject: Re: [PATCH V3 03/13] x86/HV: Add new hvcall guest address host
 visibility support
To: Wei Liu <wei.liu@kernel.org>
References: <20210809175620.720923-1-ltykernel@gmail.com>
 <20210809175620.720923-4-ltykernel@gmail.com>
 <20210810110359.i4qodw7h36zrsicp@liuwe-devbox-debian-v2>
From: Tianyu Lan <ltykernel@gmail.com>
Message-ID: <3a888810-69cf-fa4d-b374-2053432e1e56@gmail.com>
Date: Tue, 10 Aug 2021 20:25:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210810110359.i4qodw7h36zrsicp@liuwe-devbox-debian-v2>
Content-Language: en-US
Cc: parri.andrea@gmail.com, linux-hyperv@vger.kernel.org, brijesh.singh@amd.com,
 peterz@infradead.org, dave.hansen@linux.intel.com, vkuznets@redhat.com,
 hpa@zytor.com, kys@microsoft.com, will@kernel.org, boris.ostrovsky@oracle.com,
 linux-arch@vger.kernel.org, sfr@canb.auug.org.au, sstabellini@kernel.org,
 sthemmin@microsoft.com, xen-devel@lists.xenproject.org,
 linux-scsi@vger.kernel.org, aneesh.kumar@linux.ibm.com, x86@kernel.org,
 decui@microsoft.com, hch@lst.de, michael.h.kelley@microsoft.com,
 mingo@redhat.com, pgonda@google.com, rientjes@google.com, kuba@kernel.org,
 jejb@linux.ibm.com, martin.b.radev@gmail.com, thomas.lendacky@amd.com,
 Tianyu.Lan@microsoft.com, arnd@arndb.de, konrad.wilk@oracle.com,
 haiyangz@microsoft.com, bp@alien8.de, luto@kernel.org,
 krish.sadhukhan@oracle.com, tglx@linutronix.de, akpm@linux-foundation.org,
 jgross@suse.com, martin.petersen@oracle.com, saravanand@fb.com,
 netdev@vger.kernel.org, dave.hansen@intel.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, rppt@kernel.org, hannes@cmpxchg.org,
 tj@kernel.org, ardb@kernel.org, robin.murphy@arm.com, davem@davemloft.net,
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

On 8/10/2021 7:03 PM, Wei Liu wrote:
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
> Nit: false instead of 0.
> 

OK. Will fix in the next version.

>> +int hv_mark_gpa_visibility(u16 count, const u64 pfn[],
>> +			   enum hv_mem_host_visibility visibility)
>> +{
>> +	struct hv_gpa_range_for_visibility **input_pcpu, *input;
>> +	u16 pages_processed;
>> +	u64 hv_status;
>> +	unsigned long flags;
>> +
>> +	/* no-op if partition isolation is not enabled */
>> +	if (!hv_is_isolation_supported())
>> +		return 0;
>> +
>> +	if (count > HV_MAX_MODIFY_GPA_REP_COUNT) {
>> +		pr_err("Hyper-V: GPA count:%d exceeds supported:%lu\n", count,
>> +			HV_MAX_MODIFY_GPA_REP_COUNT);
>> +		return -EINVAL;
>> +	}
>> +
>> +	local_irq_save(flags);
>> +	input_pcpu = (struct hv_gpa_range_for_visibility **)
>> +			this_cpu_ptr(hyperv_pcpu_input_arg);
>> +	input = *input_pcpu;
>> +	if (unlikely(!input)) {
>> +		local_irq_restore(flags);
>> +		return -EINVAL;
>> +	}
>> +
>> +	input->partition_id = HV_PARTITION_ID_SELF;
>> +	input->host_visibility = visibility;
>> +	input->reserved0 = 0;
>> +	input->reserved1 = 0;
>> +	memcpy((void *)input->gpa_page_list, pfn, count * sizeof(*pfn));
>> +	hv_status = hv_do_rep_hypercall(
>> +			HVCALL_MODIFY_SPARSE_GPA_PAGE_HOST_VISIBILITY, count,
>> +			0, input, &pages_processed);
>> +	local_irq_restore(flags);
>> +
>> +	if (!(hv_status & HV_HYPERCALL_RESULT_MASK))
>> +		return 0;
>> +
>> +	return hv_status & HV_HYPERCALL_RESULT_MASK;
> Joseph introduced a few helper functions in 753ed9c95c37d. They will
> make the code simpler.

OK. Will update in the next version.

Thanks.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
