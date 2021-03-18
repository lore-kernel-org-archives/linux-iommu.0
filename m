Return-Path: <SRS0=56b4=IQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D6DFC433DB
	for <iommu@archiver.kernel.org>; Thu, 18 Mar 2021 19:22:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 015BF64F45
	for <iommu@archiver.kernel.org>; Thu, 18 Mar 2021 19:22:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 015BF64F45
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B6907400C7;
	Thu, 18 Mar 2021 19:22:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZeRLYORbe2ge; Thu, 18 Mar 2021 19:22:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 93FA2400BC;
	Thu, 18 Mar 2021 19:22:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6F1C1C000B;
	Thu, 18 Mar 2021 19:22:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AEFBCC0001
 for <iommu@lists.linux-foundation.org>; Thu, 18 Mar 2021 19:22:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 961866062D
 for <iommu@lists.linux-foundation.org>; Thu, 18 Mar 2021 19:22:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id n02OGtTUWuwI for <iommu@lists.linux-foundation.org>;
 Thu, 18 Mar 2021 19:22:20 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id ED8856062A
 for <iommu@lists.linux-foundation.org>; Thu, 18 Mar 2021 19:22:19 +0000 (UTC)
Received: by mail-pl1-x62f.google.com with SMTP id ay2so1799347plb.3
 for <iommu@lists.linux-foundation.org>; Thu, 18 Mar 2021 12:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=TM+vEBqjvzmGZFh854VHWSVx/dlysQ2NuONxv+B86HU=;
 b=LBxnTBlH06B0fQtsE0BvxU3j7rlfq3katQi7WoUGretXjpngZM5x897LI0NpbDoopk
 hX9iBFP1dRVeJ5lS7Yl+9a5OIDATku9d98R1Rx/4FFArP6hpBi0J3iDd+Rsz0PQwTw5c
 R7rsUuPuCQGPFsFO98LjnZNtEuIuaNEt1RD0TCsr7vxGZBm7MRs0f+S9DO/WW5b2H9f9
 M/2bQqXtzMxL2aZnVTEeR0mnDwnH90eSyMZ2Z4GwX2+Hh3LbpAfBUZGEU5vhgSpsP3L5
 eo9J50pKpEeagWcG3ytdINWi0vle6C8TvUyy2NJly5kyWfI6GqZVMYO9r7Ww35jE4yJA
 f74g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=TM+vEBqjvzmGZFh854VHWSVx/dlysQ2NuONxv+B86HU=;
 b=WCumiCRazxN0rgsVlrSe7rB6TxNyxlMJ0Wg6xC87dKlRP1gr5nKNX4XcI3dgJVHAAg
 BK0FWVATmlcVFv72fLQGqWJ1og0JcIh6Z5+0YwbJNa5ZfkSbIgYkUtqLJHhObZDBEmoa
 usSG8VNUSa72SKp/J85OFAWk8p+0pY6DeXdmbcXds4zcuszWe+5CDIod6U5ecDHpahs2
 X+VDsQ1gZo3oCx4VOEhTUJLqzpnFlk/hjpBitfRT3iVB6Q583o6Fef8xgGzDjiYsZhlS
 6f1Pl92UE5gf7Q/Ub3UjbQOX7cq2hgTPy+Ctz9YTpp5smcAb8FB+YkEfmez/5TRN0zE7
 vAsA==
X-Gm-Message-State: AOAM5334xbbKYoO7XaCdcu06M3iTyVBRdjKvDU5SK4HcCcxrXSaGzYjW
 k470qfaI7UK5Tq8rrDJtDYF0GaH2QXc=
X-Google-Smtp-Source: ABdhPJw09QkiSEVKSoCdawiAp/3PCs1M1aROIkZX2/evRD9NZFUJ9/DhqAKS6v+Uak31oZ4vJmhfdw==
X-Received: by 2002:a17:90a:e556:: with SMTP id
 ei22mr5793082pjb.214.1616095338892; 
 Thu, 18 Mar 2021 12:22:18 -0700 (PDT)
Received: from [10.230.29.202] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id h19sm3290393pfc.172.2021.03.18.12.22.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Mar 2021 12:22:18 -0700 (PDT)
Subject: Re: [PATCH] swiotlb: Add swiotlb=off to disable SWIOTLB
To: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20210318191816.4185226-1-f.fainelli@gmail.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <bbd44c42-cedc-7bd6-a443-c991fd080298@gmail.com>
Date: Thu, 18 Mar 2021 12:22:13 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210318191816.4185226-1-f.fainelli@gmail.com>
Content-Language: en-US
Cc: opendmb@gmail.com, "Paul E. McKenney" <paulmck@kernel.org>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Jonathan Corbet <corbet@lwn.net>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 "open list:SWIOTLB SUBSYSTEM" <iommu@lists.linux-foundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Mike Kravetz <mike.kravetz@oracle.com>, Robin Murphy <robin.murphy@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>
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



On 3/18/2021 12:18 PM, Florian Fainelli wrote:
> It may be useful to disable the SWIOTLB completely for testing or when a
> platform is known not to have any DRAM addressing limitations what so
> ever.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Christoph, in addition to this change, how would you feel if we
qualified the swiotlb_init() in arch/arm/mm/init.c with a:


if (memblock_end_of_DRAM() >= SZ_4G)
	swiotlb_init(1)

right now this is made unconditional whenever ARM_LPAE is enabled which
is the case for the platforms I maintain (ARCH_BRCMSTB) however we do
not really need a SWIOTLB so long as the largest DRAM physical address
does not exceed 4GB AFAICT.

Thanks!

> ---
>  Documentation/admin-guide/kernel-parameters.txt | 1 +
>  include/linux/swiotlb.h                         | 1 +
>  kernel/dma/swiotlb.c                            | 9 +++++++++
>  3 files changed, 11 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 04545725f187..b0223e48921e 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -5278,6 +5278,7 @@
>  			force -- force using of bounce buffers even if they
>  			         wouldn't be automatically used by the kernel
>  			noforce -- Never use bounce buffers (for debugging)
> +			off -- Completely disable SWIOTLB
>  
>  	switches=	[HW,M68k]
>  
> diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> index 5857a937c637..23f86243defe 100644
> --- a/include/linux/swiotlb.h
> +++ b/include/linux/swiotlb.h
> @@ -15,6 +15,7 @@ enum swiotlb_force {
>  	SWIOTLB_NORMAL,		/* Default - depending on HW DMA mask etc. */
>  	SWIOTLB_FORCE,		/* swiotlb=force */
>  	SWIOTLB_NO_FORCE,	/* swiotlb=noforce */
> +	SWIOTLB_OFF,		/* swiotlb=off */
>  };
>  
>  /*
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index c10e855a03bc..d7a4a789c7d3 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -126,6 +126,8 @@ setup_io_tlb_npages(char *str)
>  	} else if (!strcmp(str, "noforce")) {
>  		swiotlb_force = SWIOTLB_NO_FORCE;
>  		io_tlb_nslabs = 1;
> +	} else if (!strcmp(str, "off")) {
> +		swiotlb_force = SWIOTLB_OFF;
>  	}
>  
>  	return 0;
> @@ -229,6 +231,9 @@ int __init swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose)
>  	unsigned long i, bytes;
>  	size_t alloc_size;
>  
> +	if (swiotlb_force == SWIOTLB_OFF)
> +		return 0;
> +
>  	bytes = nslabs << IO_TLB_SHIFT;
>  
>  	io_tlb_nslabs = nslabs;
> @@ -284,6 +289,9 @@ swiotlb_init(int verbose)
>  	unsigned char *vstart;
>  	unsigned long bytes;
>  
> +	if (swiotlb_force == SWIOTLB_OFF)
> +		goto out;
> +
>  	if (!io_tlb_nslabs) {
>  		io_tlb_nslabs = (default_size >> IO_TLB_SHIFT);
>  		io_tlb_nslabs = ALIGN(io_tlb_nslabs, IO_TLB_SEGSIZE);
> @@ -302,6 +310,7 @@ swiotlb_init(int verbose)
>  		io_tlb_start = 0;
>  	}
>  	pr_warn("Cannot allocate buffer");
> +out:
>  	no_iotlb_memory = true;
>  }
>  
> 

-- 
Florian
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
