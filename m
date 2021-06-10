Return-Path: <SRS0=Vfdp=LE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDBFDC47094
	for <iommu@archiver.kernel.org>; Thu, 10 Jun 2021 14:16:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 966D7613E9
	for <iommu@archiver.kernel.org>; Thu, 10 Jun 2021 14:16:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 966D7613E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 61E8840643;
	Thu, 10 Jun 2021 14:16:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id a-FaRz9oHoFc; Thu, 10 Jun 2021 14:16:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id EC3EF40653;
	Thu, 10 Jun 2021 14:16:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C17B7C000E;
	Thu, 10 Jun 2021 14:16:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 15DF1C000B
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 14:16:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9F1E740652
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 14:16:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aTPwgMYdqDbH for <iommu@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 14:16:00 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D4F4E40653
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 14:16:00 +0000 (UTC)
Received: by mail-pg1-x52b.google.com with SMTP id t9so22704526pgn.4
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 07:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Z06P6xfCZfBoLzLGshR2eXD11imPLnqUoouenixaYFw=;
 b=APiM6yjkYAKij1RjMOo9hW4vLGKN36RaoDPpCZzJkgCIWIc5bNnUPRKfG+5uelh6im
 ZwmwB/K2y2Z+UnBHFw6Ok84giPqAWtESqJu7RLH3vi1s6Wmdl12YoCN5FEDC7FxVL8S3
 xBQJ/O0hMPtGsBtUowS8mRCmJHg4qC1j99bvIODTP9XmlSIGPDf9QrQ49kI/Ur72auK8
 XR3tyDiPInVQQ5Wc5igpAdJ+WpQK2Nh7QdvgHpHFXPPDhb1Z06nj6QGPTXJjDDNCczPn
 w4fJFgDDWFpzxBgC5Dh+DND5ldxosu/Bv7P7MHz+0qfPe5TrP3iyAg6tpfZqrx3I67eW
 JLfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Z06P6xfCZfBoLzLGshR2eXD11imPLnqUoouenixaYFw=;
 b=n3a6Q2uiApMhwpwuBIdGlsT6b4i46BlJKe8KGIaSNHmN1JVlumczL3DrgZLwGDsQsl
 zoNlsrJaNhzgcYkGDlxyiwZFYtMqehil/u9hB2+bYwROY41AA2n9ERfn1ZFUV5aPW/xZ
 WXBk2rXnRH94W9R7oNl6iGWTVRT1PABwEvP/JM8DoxJB65Li3Y3pToS8d+2cxyhNy2vB
 vkCYHhCctP8WAA5pdzmeyRrEFVDiLLK2O7GG4gYINfGYH9jIXcsSvRtaJ+YKHnAvZz4X
 +QohyKMxRWvLJ59JQ7DZlgLKv9LAMEne8SFxj7hSenPwVrbt9NS7KsWmZubpoUqXEr5P
 yInA==
X-Gm-Message-State: AOAM531ZHTInk7UCLy+XeJl1gro4qpiXZ3KZzunX2856AHzqs+J22vZG
 kkKFPEDk/4fIC+a+TC1bWyY=
X-Google-Smtp-Source: ABdhPJzmTLyJiMIH7/kQoP6L+VhlUA+7RnmijLx7oWBaXhPdpzGgcAEZV6BSepEVhxfy3ZoxIY2hkg==
X-Received: by 2002:a63:4e20:: with SMTP id c32mr5182730pgb.104.1623334560354; 
 Thu, 10 Jun 2021 07:16:00 -0700 (PDT)
Received: from ?IPv6:2404:f801:0:5:8000::4b1? ([2404:f801:9000:1a:efea::4b1])
 by smtp.gmail.com with ESMTPSA id
 f6sm2629239pfb.28.2021.06.10.07.15.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Jun 2021 07:15:59 -0700 (PDT)
Subject: Re: [RFC PATCH V3 04/11] HV: Add Write/Read MSR registers via ghcb
To: Joerg Roedel <joro@8bytes.org>
References: <20210530150628.2063957-1-ltykernel@gmail.com>
 <20210530150628.2063957-5-ltykernel@gmail.com> <YMC4JdtYO+eLDKh5@8bytes.org>
From: Tianyu Lan <ltykernel@gmail.com>
Message-ID: <bd84a1a1-1dae-1dc0-8175-ed8bf19e705c@gmail.com>
Date: Thu, 10 Jun 2021 22:15:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YMC4JdtYO+eLDKh5@8bytes.org>
Content-Language: en-US
Cc: linux-hyperv@vger.kernel.org, brijesh.singh@amd.com,
 thomas.lendacky@amd.com, peterz@infradead.org, dave.hansen@linux.intel.com,
 hpa@zytor.com, kys@microsoft.com, will@kernel.org, hch@lst.de,
 linux-arch@vger.kernel.org, wei.liu@kernel.org, sstabellini@kernel.org,
 sthemmin@microsoft.com, linux-scsi@vger.kernel.org, x86@kernel.org,
 decui@microsoft.com, mingo@redhat.com, xen-devel@lists.xenproject.org,
 jejb@linux.ibm.com, jgross@suse.com, Tianyu.Lan@microsoft.com, arnd@arndb.de,
 konrad.wilk@oracle.com, haiyangz@microsoft.com, kuba@kernel.org, bp@alien8.de,
 luto@kernel.org, krish.sadhukhan@oracle.com, tglx@linutronix.de,
 vkuznets@redhat.com, boris.ostrovsky@oracle.com, martin.petersen@oracle.com,
 saravanand@fb.com, netdev@vger.kernel.org, sunilmut@microsoft.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 kirill.shutemov@linux.intel.com, hannes@cmpxchg.org, cai@lca.pw,
 akpm@linux-foundation.org, robin.murphy@arm.com, davem@davemloft.net,
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



On 6/9/2021 8:46 PM, Joerg Roedel wrote:
> On Sun, May 30, 2021 at 11:06:21AM -0400, Tianyu Lan wrote:
>> +void hv_ghcb_msr_write(u64 msr, u64 value)
>> +{
>> +	union hv_ghcb *hv_ghcb;
>> +	void **ghcb_base;
>> +	unsigned long flags;
>> +
>> +	if (!ms_hyperv.ghcb_base)
>> +		return;
>> +
>> +	local_irq_save(flags);
>> +	ghcb_base = (void **)this_cpu_ptr(ms_hyperv.ghcb_base);
>> +	hv_ghcb = (union hv_ghcb *)*ghcb_base;
>> +	if (!hv_ghcb) {
>> +		local_irq_restore(flags);
>> +		return;
>> +	}
>> +
>> +	memset(hv_ghcb, 0x00, HV_HYP_PAGE_SIZE);
>> +
>> +	hv_ghcb->ghcb.protocol_version = 1;
>> +	hv_ghcb->ghcb.ghcb_usage = 0;
>> +
>> +	ghcb_set_sw_exit_code(&hv_ghcb->ghcb, SVM_EXIT_MSR);
>> +	ghcb_set_rcx(&hv_ghcb->ghcb, msr);
>> +	ghcb_set_rax(&hv_ghcb->ghcb, lower_32_bits(value));
>> +	ghcb_set_rdx(&hv_ghcb->ghcb, value >> 32);
>> +	ghcb_set_sw_exit_info_1(&hv_ghcb->ghcb, 1);
>> +	ghcb_set_sw_exit_info_2(&hv_ghcb->ghcb, 0);
>> +
>> +	VMGEXIT();
> 
> This is not safe to use from NMI context. You need at least some
> checking or WARN_ON/assertion/whatever to catch cases where this is
> violated. Otherwise it will result in some hard to debug bug reports.
> 

Nice catch. Will update in the next version.

Thanks.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
