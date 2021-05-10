Return-Path: <SRS0=b4g5=KF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1242AC43460
	for <iommu@archiver.kernel.org>; Mon, 10 May 2021 18:15:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B657761483
	for <iommu@archiver.kernel.org>; Mon, 10 May 2021 18:15:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B657761483
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xen.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7B05640214;
	Mon, 10 May 2021 18:15:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gPQoz_7kJBfR; Mon, 10 May 2021 18:15:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4FCCF40192;
	Mon, 10 May 2021 18:15:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 26838C000D;
	Mon, 10 May 2021 18:15:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 03257C0001
 for <iommu@lists.linux-foundation.org>; Mon, 10 May 2021 18:15:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DD2A183A69
 for <iommu@lists.linux-foundation.org>; Mon, 10 May 2021 18:15:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=xen.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id f0PIK5DeXcrf for <iommu@lists.linux-foundation.org>;
 Mon, 10 May 2021 18:15:21 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.xenproject.org (mail.xenproject.org [104.130.215.37])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 567B1837DA
 for <iommu@lists.linux-foundation.org>; Mon, 10 May 2021 18:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=xen.org;
 s=20200302mail; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:Cc:To:Subject;
 bh=U5oB8mfFZLEuy5Yg/E0zgF4iSW40BPLFycfVFKKLR18=; b=bOJV5SmQ0O2K2VSbIDK/2BxZ2Q
 hA+OjDCuSuM4X73YxfSLnzK4PkvUYT13yWt3F9Kp4L/luL4z544C+SikxjoGEzsAhlfyw5WbInzbj
 BoLURVvENjwaKuMRzgEPeOb3k9kixOubpH6Ut322sIfARM84GOZ8pWvwuCQcPyNHUdZw=;
Received: from xenbits.xenproject.org ([104.239.192.120])
 by mail.xenproject.org with esmtp (Exim 4.92)
 (envelope-from <julien@xen.org>)
 id 1lgAR5-000343-IE; Mon, 10 May 2021 18:15:19 +0000
Received: from [54.239.6.185] (helo=a483e7b01a66.ant.amazon.com)
 by xenbits.xenproject.org with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <julien@xen.org>)
 id 1lgAR5-00056p-BN; Mon, 10 May 2021 18:15:19 +0000
Subject: Re: Regression when booting 5.15 as dom0 on arm64 (WAS: Re:
 [linux-linus test] 161829: regressions - FAIL)
To: Christoph Hellwig <hch@lst.de>
References: <osstest-161829-mainreport@xen.org>
 <4ea1e89f-a7a0-7664-470c-b3cf773a1031@xen.org> <20210510084057.GA933@lst.de>
From: Julien Grall <julien@xen.org>
Message-ID: <8b851596-acf7-9d3b-b08a-848cae5adada@xen.org>
Date: Mon, 10 May 2021 19:15:17 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210510084057.GA933@lst.de>
Content-Language: en-GB
Cc: f.fainelli@gmail.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 osstest service owner <osstest-admin@xenproject.org>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>
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

Hi Christoph,

On 10/05/2021 09:40, Christoph Hellwig wrote:
> On Sat, May 08, 2021 at 12:32:37AM +0100, Julien Grall wrote:
>> The pointer dereferenced seems to suggest that the swiotlb hasn't been
>> allocated. From what I can tell, this may be because swiotlb_force is set
>> to SWIOTLB_NO_FORCE, we will still enable the swiotlb when running on top
>> of Xen.
>>
>> I am not entirely sure what would be the correct fix. Any opinions?
> 
> Can you try something like the patch below (not even compile tested, but
> the intent should be obvious?
> 
> 
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 16a2b2b1c54d..7671bc153fb1 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -44,6 +44,8 @@
>   #include <asm/tlb.h>
>   #include <asm/alternative.h>
>   
> +#include <xen/arm/swiotlb-xen.h>
> +
>   /*
>    * We need to be able to catch inadvertent references to memstart_addr
>    * that occur (potentially in generic code) before arm64_memblock_init()
> @@ -482,7 +484,7 @@ void __init mem_init(void)
>   	if (swiotlb_force == SWIOTLB_FORCE ||
>   	    max_pfn > PFN_DOWN(arm64_dma_phys_limit))
>   		swiotlb_init(1);
> -	else
> +	else if (!IS_ENABLED(CONFIG_XEN) || !xen_swiotlb_detect())
>   		swiotlb_force = SWIOTLB_NO_FORCE;
>   
>   	set_max_mapnr(max_pfn - PHYS_PFN_OFFSET);

I have applied the patch on top of 5.13-rc1 and can confirm I am able to 
boot dom0. Are you going to submit the patch?

Thank you for your help!

Best regards,

-- 
Julien Grall
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
