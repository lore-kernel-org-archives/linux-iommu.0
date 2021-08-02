Return-Path: <SRS0=vo+x=MZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F161C4338F
	for <iommu@archiver.kernel.org>; Mon,  2 Aug 2021 02:03:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F7F160F5A
	for <iommu@archiver.kernel.org>; Mon,  2 Aug 2021 02:03:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7F7F160F5A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2CC2C60737;
	Mon,  2 Aug 2021 02:03:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id soqR3Eis1-FS; Mon,  2 Aug 2021 02:03:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 01C21606EA;
	Mon,  2 Aug 2021 02:03:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DBE2BC0010;
	Mon,  2 Aug 2021 02:03:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 94FDDC000E
 for <iommu@lists.linux-foundation.org>; Mon,  2 Aug 2021 02:03:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7A0FB40010
 for <iommu@lists.linux-foundation.org>; Mon,  2 Aug 2021 02:03:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id M_KKhgIhpdwP for <iommu@lists.linux-foundation.org>;
 Mon,  2 Aug 2021 02:03:25 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6206040018
 for <iommu@lists.linux-foundation.org>; Mon,  2 Aug 2021 02:03:25 +0000 (UTC)
Received: by mail-pj1-x1030.google.com with SMTP id
 g23-20020a17090a5797b02901765d605e14so22532580pji.5
 for <iommu@lists.linux-foundation.org>; Sun, 01 Aug 2021 19:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :message-id:content-transfer-encoding;
 bh=qRAGhi37lhF1sunuSfrr1C0LvoIqLv4kahSQWWZ31Ss=;
 b=lax88g34cj6deV6YZblYxmwfptSOzpkqmyB+B4Vn1fweUniem1asTRHasAOxZ55XZJ
 zqsiJgmLq/+cRjJh0nO5k2UN7G0HlE2kugBTza3Og3GUw7rG2N+SwGBi9+uA1T1Er2yA
 6Qe1ETEHjQvyXkez1SmHzAkGP3+ymXApiEOpV1FzAMyW6KGMKhL0TpJK/qLv87h87dWh
 0pq5ri7OReltA40mhbAKM7zvrUxaTPAeuVXsDc1yJrWOdJcIdfTM/vcBcPyM1RuXikNs
 1llU3wtFXO0lSeXGbvldh/bTWKHqwYxzmauFRFoxe05GNbONOLErhKlh9idTSR22x3fR
 HSTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:message-id:content-transfer-encoding;
 bh=qRAGhi37lhF1sunuSfrr1C0LvoIqLv4kahSQWWZ31Ss=;
 b=oK2C0fvwnRtBPCyZkLvnTTdDuKipRcXSM6SeXvZ4HQyQ9BtG+jSE1EgZpewYcXY9oz
 W2ovieuEMD2XYDaii6OobsQklEvKZwKlksUTvHf4vwe381805StCwSYQdwKzLQFDgwFU
 dgI0ZZD2OFEr+YqJ1TeZdMWmLGM/XtRaHdL2jeqj8fp5CnYis3nmmP22tLY+hyxl5wab
 aAf3HTkaFHY3FUhpNIT8rkidJ5eTgOW5lDNbMwtcf3HJ1gwfAhtKSL1H4kg6sYEZk2Ze
 xWB4z8H6sQRevEB7wSdlfISIk5LwptxELvR/9jNCBgRJdUz0wT/9PsKVepdr3kzx7sj2
 snZA==
X-Gm-Message-State: AOAM531jy9RvtMwNvQbr9p9rYIGPdQ7VBEJk62TlaMZO1/J1uIOuPTjp
 E4B8FR8KRZ8lQrmWvP5IQsM=
X-Google-Smtp-Source: ABdhPJzV7KdTwX/eRoeMqY3JPzEDww/yit821nvXnqkx9bMQbO1GpBQJFlJezLK900wCL/Z+zR4LDg==
X-Received: by 2002:a17:90a:de16:: with SMTP id
 m22mr14997962pjv.38.1627869804836; 
 Sun, 01 Aug 2021 19:03:24 -0700 (PDT)
Received: from localhost (60-242-181-102.static.tpgi.com.au. [60.242.181.102])
 by smtp.gmail.com with ESMTPSA id
 j10sm10189936pfd.200.2021.08.01.19.03.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Aug 2021 19:03:24 -0700 (PDT)
Date: Mon, 02 Aug 2021 12:03:19 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] powerpc/svm: Don't issue ultracalls if
 !mem_encrypt_active()
To: linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>
References: <20210730114231.23445-1-will@kernel.org>
In-Reply-To: <20210730114231.23445-1-will@kernel.org>
MIME-Version: 1.0
Message-Id: <1627869720.jrkx2xunfl.astroid@bobo.none>
Cc: Sachin Sant <sachinp@linux.vnet.ibm.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linuxppc-dev@lists.ozlabs.org,
 Nathan Chancellor <nathan@kernel.org>, iommu@lists.linux-foundation.org,
 Claire Chang <tientzu@chromium.org>, Robin Murphy <robin.murphy@arm.com>,
 Christoph Hellwig <hch@lst.de>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Excerpts from Will Deacon's message of July 30, 2021 9:42 pm:
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
> ---

Thanks for writing it.

Acked-by: Nicholas Piggin <npiggin@gmail.com>

>  arch/powerpc/platforms/pseries/svm.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/powerpc/platforms/pseries/svm.c b/arch/powerpc/platforms/pseries/svm.c
> index 1d829e257996..87f001b4c4e4 100644
> --- a/arch/powerpc/platforms/pseries/svm.c
> +++ b/arch/powerpc/platforms/pseries/svm.c
> @@ -63,6 +63,9 @@ void __init svm_swiotlb_init(void)
>  
>  int set_memory_encrypted(unsigned long addr, int numpages)
>  {
> +	if (!mem_encrypt_active())
> +		return 0;
> +
>  	if (!PAGE_ALIGNED(addr))
>  		return -EINVAL;
>  
> @@ -73,6 +76,9 @@ int set_memory_encrypted(unsigned long addr, int numpages)
>  
>  int set_memory_decrypted(unsigned long addr, int numpages)
>  {
> +	if (!mem_encrypt_active())
> +		return 0;
> +
>  	if (!PAGE_ALIGNED(addr))
>  		return -EINVAL;
>  
> -- 
> 2.32.0.554.ge1b32706d8-goog
> 
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
