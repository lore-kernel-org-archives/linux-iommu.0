Return-Path: <SRS0=vo+x=MZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA4EC4320A
	for <iommu@archiver.kernel.org>; Mon,  2 Aug 2021 12:35:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8E1B60F58
	for <iommu@archiver.kernel.org>; Mon,  2 Aug 2021 12:35:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B8E1B60F58
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7B39640355;
	Mon,  2 Aug 2021 12:35:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VFmcuNxTCGmQ; Mon,  2 Aug 2021 12:35:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6979B402EE;
	Mon,  2 Aug 2021 12:35:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4C3D6C001B;
	Mon,  2 Aug 2021 12:35:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 90A4DC000E
 for <iommu@lists.linux-foundation.org>; Mon,  2 Aug 2021 12:35:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7CD97403AC
 for <iommu@lists.linux-foundation.org>; Mon,  2 Aug 2021 12:35:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8rk8u5ozZavV for <iommu@lists.linux-foundation.org>;
 Mon,  2 Aug 2021 12:35:28 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4B3F540207
 for <iommu@lists.linux-foundation.org>; Mon,  2 Aug 2021 12:35:28 +0000 (UTC)
Received: by mail-pj1-x1030.google.com with SMTP id a8so1975763pjk.4
 for <iommu@lists.linux-foundation.org>; Mon, 02 Aug 2021 05:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=P17ATPCGukDO//xkLZQBZuaX2KkafCVoCkJP2PCc12U=;
 b=uSz1V29fGX6wnfKClfnD5P1rh/6G4ybzLhb6KPWPPb6eZ2HEzfmHStIAm2N43ack5x
 ETcWD1FyNZMQBoyjY4aCEFCx2Wfye33oL5jKcyzFy4TChrGqa8j99tNqb7Peud6qur0g
 HSxbyh/S9VvDFpJm7czUM9e5UouUkzwjmLx3vV4iYXQnMQPDEp/wTYllcK7ITNHn68Dp
 MOnWhBnFiANNaMTFuwQk3MvS8R2grVLz4JqJf+n7xVj3C562MTurnsVUTflJysxfQYhE
 z53shCXQsRsAmcyYsm/NSjWT+vMCIAA2FisxRh/yWsZWWPV20EW7K2BRieMbbucA+e61
 TZ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=P17ATPCGukDO//xkLZQBZuaX2KkafCVoCkJP2PCc12U=;
 b=epicx/9V81ra3GZ0Vdt4rRNxtiRIJoR+ObqSvq5MOcIXZHNHQ0egC9Y6IWUTgqbRRq
 RDC5mN3zhMxa+Xu0X6+fWY8vEcSLsgAccvL9p9P20eWDi+sYamB5jyLffVOpbiy0+wB8
 yhfd2rmlboD0WZVvqI/zGN6+oCwaoPwMRSD95m/64bIVAvDfUp5PHamt/aUC/Na27zcv
 B+H2VpV2sjWVMdEoLB7DrX9tK70Do3/nVaM0fM0etdfH7NOXE36a/5AAJmSXm2ZrZqFX
 Vur+ZBU+u7Qoq9MENOGTD3Fwc1Cg7XFK83yl9uvAMUtmc9yfFImsMXFVIRExLVxjcnEL
 wzSw==
X-Gm-Message-State: AOAM532Joa3UlyiZZyoCIjc085APYAtlTquXIlxHnTU40i5QvAWA1wLx
 WcQaB1/LDQEmwxXhZJkVXzU=
X-Google-Smtp-Source: ABdhPJzYaozKahVEd/Y/yLXvnuEsqWmP1RjZTZHrtR9OGLLZiEzcQgoWz5sbNZrtoNXJm1QhUBxNOw==
X-Received: by 2002:a17:90b:4a90:: with SMTP id
 lp16mr16910701pjb.74.1627907727675; 
 Mon, 02 Aug 2021 05:35:27 -0700 (PDT)
Received: from ?IPv6:2404:f801:0:5:8000::4b1? ([2404:f801:9000:1a:efea::4b1])
 by smtp.gmail.com with ESMTPSA id
 g11sm10696958pju.13.2021.08.02.05.35.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Aug 2021 05:35:27 -0700 (PDT)
Subject: Re: [PATCH 01/13] x86/HV: Initialize GHCB page in Isolation VM
To: Joerg Roedel <joro@8bytes.org>
References: <20210728145232.285861-1-ltykernel@gmail.com>
 <20210728145232.285861-2-ltykernel@gmail.com> <YQfctjRm16IP0qZy@8bytes.org>
From: Tianyu Lan <ltykernel@gmail.com>
Message-ID: <e8918379-5c59-c718-3cec-27da931660e9@gmail.com>
Date: Mon, 2 Aug 2021 20:35:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YQfctjRm16IP0qZy@8bytes.org>
Content-Language: en-US
Cc: linux-hyperv@vger.kernel.org, brijesh.singh@amd.com, david@redhat.com,
 peterz@infradead.org, dave.hansen@linux.intel.com, vkuznets@redhat.com,
 hpa@zytor.com, anparri@microsoft.com, kys@microsoft.com, will@kernel.org,
 boris.ostrovsky@oracle.com, linux-arch@vger.kernel.org, sfr@canb.auug.org.au,
 wei.liu@kernel.org, sstabellini@kernel.org, sthemmin@microsoft.com,
 xen-devel@lists.xenproject.org, linux-scsi@vger.kernel.org,
 aneesh.kumar@linux.ibm.com, x86@kernel.org, decui@microsoft.com, hch@lst.de,
 michael.h.kelley@microsoft.com, mingo@redhat.com, pgonda@google.com,
 rientjes@google.com, kuba@kernel.org, jejb@linux.ibm.com,
 martin.b.radev@gmail.com, thomas.lendacky@amd.com, Tianyu.Lan@microsoft.com,
 keescook@chromium.org, arnd@arndb.de, konrad.wilk@oracle.com,
 haiyangz@microsoft.com, bp@alien8.de, luto@kernel.org,
 krish.sadhukhan@oracle.com, tglx@linutronix.de, akpm@linux-foundation.org,
 jgross@suse.com, martin.petersen@oracle.com, saravanand@fb.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, kirill.shutemov@linux.intel.com,
 hannes@cmpxchg.org, ardb@kernel.org, robin.murphy@arm.com, davem@davemloft.net,
 rppt@kernel.org
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

Hi Joerg:
      Thanks for your review.


On 8/2/2021 7:53 PM, Joerg Roedel wrote:
> On Wed, Jul 28, 2021 at 10:52:16AM -0400, Tianyu Lan wrote:
>> +static int hyperv_init_ghcb(void)
>> +{
>> +	u64 ghcb_gpa;
>> +	void *ghcb_va;
>> +	void **ghcb_base;
>> +
>> +	if (!ms_hyperv.ghcb_base)
>> +		return -EINVAL;
>> +
>> +	rdmsrl(MSR_AMD64_SEV_ES_GHCB, ghcb_gpa);
>> +	ghcb_va = memremap(ghcb_gpa, HV_HYP_PAGE_SIZE, MEMREMAP_WB);
> 
> This deserves a comment. As I understand it, the GHCB pa is set by
> Hyper-V or the paravisor, so the page does not need to be allocated by
> Linux.
> And it is not mapped unencrypted because the GHCB page is allocated
> above the VTOM boundary?

You are right. The ghdb page is allocated by paravisor and its physical 
address is above VTOM boundary. Will add a comment to describe this.
Thanks for suggestion.

> 
>> @@ -167,6 +190,31 @@ static int hv_cpu_die(unsigned int cpu)
>>   {
>>   	struct hv_reenlightenment_control re_ctrl;
>>   	unsigned int new_cpu;
>> +	unsigned long flags;
>> +	void **input_arg;
>> +	void *pg;
>> +	void **ghcb_va = NULL;
>> +
>> +	local_irq_save(flags);
>> +	input_arg = (void **)this_cpu_ptr(hyperv_pcpu_input_arg);
>> +	pg = *input_arg;
> 
> Pg is never used later on, why is it set?

Sorry for noise. This should be removed during rebase and will fix in 
the next version.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
