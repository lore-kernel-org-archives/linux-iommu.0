Return-Path: <SRS0=F2nw=MY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CCEBC4320A
	for <iommu@archiver.kernel.org>; Sun,  1 Aug 2021 04:27:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 840CF61042
	for <iommu@archiver.kernel.org>; Sun,  1 Aug 2021 04:27:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 840CF61042
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4355A607C0;
	Sun,  1 Aug 2021 04:27:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2_qKL2UyzAjn; Sun,  1 Aug 2021 04:27:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id F1616607A6;
	Sun,  1 Aug 2021 04:26:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D3385C001B;
	Sun,  1 Aug 2021 04:26:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4497BC000E
 for <iommu@lists.linux-foundation.org>; Sun,  1 Aug 2021 04:26:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2EA5183388
 for <iommu@lists.linux-foundation.org>; Sun,  1 Aug 2021 04:26:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KpL_AdgXdrFY for <iommu@lists.linux-foundation.org>;
 Sun,  1 Aug 2021 04:26:58 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3350E83381
 for <iommu@lists.linux-foundation.org>; Sun,  1 Aug 2021 04:26:58 +0000 (UTC)
Received: by mail-oo1-xc31.google.com with SMTP id
 t1-20020a4a54010000b02902638ef0f883so3579542ooa.11
 for <iommu@lists.linux-foundation.org>; Sat, 31 Jul 2021 21:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=moYJAI6IKGsvSFokzFbQjWI1AKw/0VGF4EI8VgYlBHI=;
 b=R9jMZ73rYTfklD/SvK3ERhRkt886+N2VNSJ0Im1f0Ge1i9Kx4TUPdZNIuB+QKbKM8c
 Ay1ogTjO2nw1gn222+nDVI7Sgh3KRaDnkepT7ywjvWujqV1iGsDVNX48d6jLd4z8r9TR
 TagAQJRE8Ix3Z+GO9S3E07faghWv7cRHjvzx4RpeQJwYRBn6y9l3sdMTlS0HqHrvsqM4
 S/3yn/B2OrWvj402yMnIIbXlF3wBhAnE5zdVq4aa2zxCpWoK9yv61QyYf6fsJHMxU6MY
 UdZqRrZgrPS865J4EM1PALTmEf/5dSDs74QvwyHkdPO2WnRcPb7GbZzsoirqsMEhHTqG
 spXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=moYJAI6IKGsvSFokzFbQjWI1AKw/0VGF4EI8VgYlBHI=;
 b=J+Khj5DUFhrB6lO/PDGZzMgtvIaAEkFJdSPBsNA+7rgVfSNfSD8oZySQThcW3+ysjr
 wi12MCRAsfxBUqCllHQqiPN73aOizWWlyyJ0AOcnJB7hTB9TXDJJ3XlQ7K4nH8CaXG0b
 LpgW+bj9nw8MmN6AjVRNq4OzIA8m6AAHidnrZtHrJbvZKbAzlsguRPU4TTfFtV6GfgW2
 ZYhIcenbfxN/jWRaJ3sH5gzg4He7qkAd0tk6vvRB18opB4WMzTcUBMA7cQAsnHWCKZRe
 RIzEbaWmhPnVp9ozSWe4d5xuaSMvgw7m3w5/TOAyMiFNN/ySJwJItC2wrUcN45ykWENk
 QX9A==
X-Gm-Message-State: AOAM532Y3qPqO4tN/dcxHUzrMYG0MkpKpRK5mH7veHBUURjRuXHwsEX+
 cduw/pD5p4Q3DMQx83OB8Tc=
X-Google-Smtp-Source: ABdhPJxO6rAWQegQYxqlXfjq9ExGR8l0DVPAjeGk1+qUTQv/1A0+JJevBokaULrCCb6ZhuQ3UPVYXw==
X-Received: by 2002:a4a:4fca:: with SMTP id c193mr6647541oob.33.1627792017269; 
 Sat, 31 Jul 2021 21:26:57 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 h2sm1238131oti.24.2021.07.31.21.26.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 31 Jul 2021 21:26:56 -0700 (PDT)
Subject: Re: [PATCH v2 4/4] swiotlb: Free tbl memory in swiotlb_exit()
To: Konrad Rzeszutek Wilk <konrad@darnok.org>, will@kernel.org
References: <20210720133826.9075-1-will@kernel.org>
 <20210720133826.9075-5-will@kernel.org>
 <20210731182611.GA3792424@roeck-us.net> <YQYHDYnRegV0Xlv5@fedora>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <52cc40eb-3f6b-5abc-9130-af9216760701@roeck-us.net>
Date: Sat, 31 Jul 2021 21:26:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YQYHDYnRegV0Xlv5@fedora>
Content-Language: en-US
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 linux-kernel@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
 iommu@lists.linux-foundation.org, Claire Chang <tientzu@chromium.org>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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

On 7/31/21 7:29 PM, Konrad Rzeszutek Wilk wrote:
> On Sat, Jul 31, 2021 at 11:26:11AM -0700, Guenter Roeck wrote:
>> Hi,
>>
>> On Tue, Jul 20, 2021 at 02:38:26PM +0100, Will Deacon wrote:
>>> Although swiotlb_exit() frees the 'slots' metadata array referenced by
>>> 'io_tlb_default_mem', it leaves the underlying buffer pages allocated
>>> despite no longer being usable.
>>>
>>> Extend swiotlb_exit() to free the buffer pages as well as the slots
>>> array.
>>>
>>
>> This patch causes qemu pseries emulations to crash. Backtrace and bisect
>> log see below. Reverting it fixes the problem.
> 
> I am 99% sure it is fixed by this patch (which should be in linux-next
> in 5 minutes):
> 

Yes, it does.

FWIW:

Tested-by: Guenter Roeck <linux@roeck-us.net>

Thanks!
Guenter

> 
>>From a449ffaf9181b5a2dc705d8a06b13e0068207fd4 Mon Sep 17 00:00:00 2001
> From: Will Deacon <will@kernel.org>
> Date: Fri, 30 Jul 2021 12:42:31 +0100
> Subject: [PATCH] powerpc/svm: Don't issue ultracalls if !mem_encrypt_active()
> 
> Commit ad6c00283163 ("swiotlb: Free tbl memory in swiotlb_exit()")
> introduced a set_memory_encrypted() call to swiotlb_exit() so that the
> buffer pages are returned to an encrypted state prior to being freed.
> 
> Sachin reports that this leads to the following crash on a Power server:
> 
> [    0.010799] software IO TLB: tearing down default memory pool
> [    0.010805] ------------[ cut here ]------------
> [    0.010808] kernel BUG at arch/powerpc/kernel/interrupt.c:98!
> 
> Nick spotted that this is because set_memory_encrypted() is issuing an
> ultracall which doesn't exist for the processor, and should therefore
> be gated by mem_encrypt_active() to mirror the x86 implementation.
> 
> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Cc: Claire Chang <tientzu@chromium.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Fixes: ad6c00283163 ("swiotlb: Free tbl memory in swiotlb_exit()")
> Suggested-by: Nicholas Piggin <npiggin@gmail.com>
> Reported-by: Sachin Sant <sachinp@linux.vnet.ibm.com>
> Tested-by: Sachin Sant <sachinp@linux.vnet.ibm.com>
> Tested-by: Nathan Chancellor <nathan@kernel.org>
> Link: https://lore.kernel.org/r/1905CD70-7656-42AE-99E2-A31FC3812EAC@linux.vnet.ibm.com/
> Signed-off-by: Will Deacon <will@kernel.org>
> Signed-off-by: Konrad Rzeszutek Wilk <konrad@kernel.org>
> ---
>   arch/powerpc/platforms/pseries/svm.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/arch/powerpc/platforms/pseries/svm.c b/arch/powerpc/platforms/pseries/svm.c
> index 1d829e257996..87f001b4c4e4 100644
> --- a/arch/powerpc/platforms/pseries/svm.c
> +++ b/arch/powerpc/platforms/pseries/svm.c
> @@ -63,6 +63,9 @@ void __init svm_swiotlb_init(void)
>   
>   int set_memory_encrypted(unsigned long addr, int numpages)
>   {
> +	if (!mem_encrypt_active())
> +		return 0;
> +
>   	if (!PAGE_ALIGNED(addr))
>   		return -EINVAL;
>   
> @@ -73,6 +76,9 @@ int set_memory_encrypted(unsigned long addr, int numpages)
>   
>   int set_memory_decrypted(unsigned long addr, int numpages)
>   {
> +	if (!mem_encrypt_active())
> +		return 0;
> +
>   	if (!PAGE_ALIGNED(addr))
>   		return -EINVAL;
>   
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
