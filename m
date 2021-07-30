Return-Path: <SRS0=GV0T=MW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84582C4338F
	for <iommu@archiver.kernel.org>; Fri, 30 Jul 2021 04:11:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3112B60E76
	for <iommu@archiver.kernel.org>; Fri, 30 Jul 2021 04:11:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3112B60E76
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E1852402D5;
	Fri, 30 Jul 2021 04:11:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8s-s5nsBXPGh; Fri, 30 Jul 2021 04:11:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8043E401B9;
	Fri, 30 Jul 2021 04:11:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3F416C0010;
	Fri, 30 Jul 2021 04:11:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8BFFDC000E
 for <iommu@lists.linux-foundation.org>; Fri, 30 Jul 2021 04:11:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 66CE883B2E
 for <iommu@lists.linux-foundation.org>; Fri, 30 Jul 2021 04:11:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fLRybOKqEzxa for <iommu@lists.linux-foundation.org>;
 Fri, 30 Jul 2021 04:11:11 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3B4FB83B2A
 for <iommu@lists.linux-foundation.org>; Fri, 30 Jul 2021 04:11:11 +0000 (UTC)
Received: by mail-pl1-x634.google.com with SMTP id a20so9586443plm.0
 for <iommu@lists.linux-foundation.org>; Thu, 29 Jul 2021 21:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=qJu6CB2LN4QTrxCEOBdOuFEubSp0osjxUw486lmLCCE=;
 b=ZDBlqPk7rrZwfBnBjR5AX1bDAs/03F78a8y9TTalCyS6aeo4BVkIxfh1ObzxANaAgE
 HW8wbFpOlmHwbaCPm5cRL/enrnPzB27Dnubwd4H3F+8zFrVlyM1Smb2LawbtRzGY3LRC
 Gb93dNjedTrLXFAZ6ab+LBvUZZSxiYikb+dLVy6ty9M5d/daHgOsw8Q+y0rAzywv5rJ1
 9vUlTT3Rv5WnELmp/i+W4sb7zRlI3Awvh+AERZBSYUZe0JKeGzcixyqH3H8gStqkO4Ji
 /TjYveizM/zetfPUG8Kk34aKNf2XAzZdOlHSD7bm+KS1YwZA/iLQszfwSj+JpCnElXrL
 5VoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qJu6CB2LN4QTrxCEOBdOuFEubSp0osjxUw486lmLCCE=;
 b=jvRILOoelc8kZcpvqEyUFuYR8sG3e2X13OnhOfjN6fI6jMzJiA9BT0rmzlYNRBiw+h
 2gefufITSywESVZ+CSHjTpLCuU58VB+d6y/9UPPK4mO0tXATwpQs8u7ZT8hJ+l2m9Ai8
 rBL6R7XgHNjyCc7ddjNJZ0K7ftv7lop8nWRlzH84eO8MlS01e+Y4JeJxX0aR22i7S2fm
 mGAKUbWK+pf5yL2WoUngG4Dm+96Fw4iaCeq3KGHTPSiVprAuTiOmZibTdul0oeTlAjaV
 L+2WY2hcAoTQv8jZpJ9kSBQjN/SwqdRGeldkEpkBUydyWBzW5E32mf4kw3mAyi2a7g4h
 zzuw==
X-Gm-Message-State: AOAM530UVChAKLsW/MIk9IjS2tVxi6VKgIwfdXftY9zu23ClFbC8Azo0
 ZPTtGWTx9Y+wMIfiwFbyLoM=
X-Google-Smtp-Source: ABdhPJz3KIEE78AyymdsWAIZFHiwRfrHYC57wifeuRqjNg3M8sSkO4co7S92ZJfiJ7qm9o4/XVu3Vw==
X-Received: by 2002:a17:90a:b795:: with SMTP id
 m21mr872416pjr.143.1627618270672; 
 Thu, 29 Jul 2021 21:11:10 -0700 (PDT)
Received: from ?IPv6:2404:f801:0:5:8000::4b1? ([2404:f801:9000:18:efec::4b1])
 by smtp.gmail.com with ESMTPSA id
 s7sm418969pfk.12.2021.07.29.21.10.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Jul 2021 21:11:10 -0700 (PDT)
Subject: Re: [PATCH 10/13] x86/Swiotlb: Add Swiotlb bounce buffer remap
 function for HV IVM
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
References: <20210728145232.285861-1-ltykernel@gmail.com>
 <20210728145232.285861-11-ltykernel@gmail.com> <YQLXYVaWWdBfF7Sm@fedora>
From: Tianyu Lan <ltykernel@gmail.com>
Message-ID: <7afbbc7f-8f02-ca6c-0c8c-bbf01fae70ea@gmail.com>
Date: Fri, 30 Jul 2021 12:10:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YQLXYVaWWdBfF7Sm@fedora>
Content-Language: en-US
Cc: linux-hyperv@vger.kernel.org, brijesh.singh@amd.com, david@redhat.com,
 peterz@infradead.org, dave.hansen@linux.intel.com, vkuznets@redhat.com,
 hpa@zytor.com, anparri@microsoft.com, kys@microsoft.com, will@kernel.org,
 boris.ostrovsky@oracle.com, linux-arch@vger.kernel.org, sfr@canb.auug.org.au,
 wei.liu@kernel.org, sstabellini@kernel.org, sthemmin@microsoft.com,
 xen-devel@lists.xenproject.org, linux-scsi@vger.kernel.org,
 aneesh.kumar@linux.ibm.com, x86@kernel.org, decui@microsoft.com, hch@lst.de,
 michael.h.kelley@microsoft.com, mingo@redhat.com, pgonda@google.com,
 rientjes@google.com, kuba@kernel.org, haiyangz@microsoft.com,
 martin.b.radev@gmail.com, thomas.lendacky@amd.com, Tianyu.Lan@microsoft.com,
 keescook@chromium.org, arnd@arndb.de, jejb@linux.ibm.com, bp@alien8.de,
 luto@kernel.org, krish.sadhukhan@oracle.com, tglx@linutronix.de,
 akpm@linux-foundation.org, jgross@suse.com, martin.petersen@oracle.com,
 saravanand@fb.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
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

Hi Konrad:
      Thanks for your review.

On 7/30/2021 12:29 AM, Konrad Rzeszutek Wilk wrote:
>> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
>> index 1fa81c096c1d..6866e5784b53 100644
>> --- a/kernel/dma/swiotlb.c
>> +++ b/kernel/dma/swiotlb.c
>> @@ -194,8 +194,13 @@ static void swiotlb_init_io_tlb_mem(struct io_tlb_mem *mem, phys_addr_t start,
>>   		mem->slots[i].alloc_size = 0;
>>   	}
>>   
>> -	set_memory_decrypted((unsigned long)vaddr, bytes >> PAGE_SHIFT);
>> -	memset(vaddr, 0, bytes);
>> +	mem->vaddr = dma_map_decrypted(vaddr, bytes);
>> +	if (!mem->vaddr) {
>> +		pr_err("Failed to decrypt memory.\n");
> I am wondering if it would be worth returning an error code in this
> function instead of just printing an error?

Yes, this is good idea and will update in the next version.

> 
> For this patch I think it is Ok, but perhaps going forward this would be
> better done as I am thinking - is there some global guest->hyperv
> reporting mechanism so that if this fails - it ends up being bubbled up
> to the HyperV console-ish?

Hyper-V has such panic page report mechanism. Guest can pass one page 
log to host during crash.

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
