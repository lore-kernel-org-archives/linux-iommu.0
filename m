Return-Path: <SRS0=KWJS=QG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 705FEC433F5
	for <iommu@archiver.kernel.org>; Fri, 19 Nov 2021 14:24:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24B1961264
	for <iommu@archiver.kernel.org>; Fri, 19 Nov 2021 14:24:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 24B1961264
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E66FE8195C;
	Fri, 19 Nov 2021 14:23:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FP2WUblGafhq; Fri, 19 Nov 2021 14:23:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id CD63A81764;
	Fri, 19 Nov 2021 14:23:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B1662C001E;
	Fri, 19 Nov 2021 14:23:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ABA28C0012
 for <iommu@lists.linux-foundation.org>; Fri, 19 Nov 2021 14:23:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8CF398101A
 for <iommu@lists.linux-foundation.org>; Fri, 19 Nov 2021 14:23:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wFzzgSvqv3H7 for <iommu@lists.linux-foundation.org>;
 Fri, 19 Nov 2021 14:23:56 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com
 [IPv6:2607:f8b0:4864:20::530])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C166B80C94
 for <iommu@lists.linux-foundation.org>; Fri, 19 Nov 2021 14:23:56 +0000 (UTC)
Received: by mail-pg1-x530.google.com with SMTP id p17so8797816pgj.2
 for <iommu@lists.linux-foundation.org>; Fri, 19 Nov 2021 06:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language
 :from:to:cc:references:in-reply-to:content-transfer-encoding;
 bh=dvjMlZBI3ldb1jXqYwhDV7AWs1lj5LCSS81ZY56RgHg=;
 b=lD29CjzOk03sgDLP+GNvSpxJtgVkW5rJkK+91U6AQudAzMZxrwkaky9OEq6jf27Gw7
 +El3go4e6gBFGCWthIzBWcaH6MtynoVd2Asx0s8lF4AHh9KTCrYFWAivyI8ee0X1Vv36
 V2FQuAVabQQBAbOL0fIquaORLXE6V2pQuWoxP4p8Bdmk66ffMTRypmvZJws3ZQPoiG7R
 xBnlvWtgNAT1CZU5CVKw8D3+cafHZ/lwicgnA/RP75ZpQaa+0T4cnXOpdWgAZYBmS+Ds
 D+JWFTqNXrZl80kk+n0WgCyZhptSAvKOJXiZ1wT44+Ikfkw7mB3QMLEop9ypqPjQJy3c
 M8pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:from:to:cc:references:in-reply-to
 :content-transfer-encoding;
 bh=dvjMlZBI3ldb1jXqYwhDV7AWs1lj5LCSS81ZY56RgHg=;
 b=72e+etM5uQtIXLMfA47gcwQfVkDVqI5cRrYZMJ6QGpuW7q35sHDGUNbt3yt/7DI4m8
 Gz570cL6SdY6ZNgN1q408/4iHpdDCWEWrkgxegUQp5UO6QzRRKauVXtIvzuPZ11a8eMv
 gEPCEcoNegU49iSYbUVJpkPgMWGiP5cA0wdzwDHIDHc+MRb+fbOmjqIlAAxTTIisR+Fw
 6TDZJgJqg8yBitZ51+OuD3/1c1I5NmLVJhwQU3k7SC62wQmjRJJsy4k+SvJIA+bcf8OT
 0tpULop/mtHrWHzi8X31Ha4NZ1ll+1SCnU9btUEW/D6m6SnonWtwkFEo+zqGZaj99alF
 YI3Q==
X-Gm-Message-State: AOAM532DuMs4Oc/Wh/rpv3ZdABG47f1fUwf5SabnanfENfD8aXXoqTes
 bxnLVKp7O09k4xagmGtTSLA=
X-Google-Smtp-Source: ABdhPJzKRBXlcGt3waRWzaH9R47/6SD0/IgoWcAgajHv/fxOJufbEPJI6hNEQ9SuwB+/pum/5oX3UA==
X-Received: by 2002:a63:b54a:: with SMTP id u10mr17506905pgo.69.1637331836308; 
 Fri, 19 Nov 2021 06:23:56 -0800 (PST)
Received: from ?IPV6:2404:f801:0:5:8000::50b? ([2404:f801:9000:1a:efea::50b])
 by smtp.gmail.com with ESMTPSA id
 l12sm3181520pfu.100.2021.11.19.06.23.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Nov 2021 06:23:55 -0800 (PST)
Message-ID: <f7fcb4d5-fcdd-0d24-60ed-62c27ed8e2d9@gmail.com>
Date: Fri, 19 Nov 2021 22:23:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH 3/5] hyperv/IOMMU: Enable swiotlb bounce buffer for
 Isolation VM
Content-Language: en-US
From: Tianyu Lan <ltykernel@gmail.com>
To: Christoph Hellwig <hch@lst.de>
References: <20211116153923.196763-1-ltykernel@gmail.com>
 <20211116153923.196763-4-ltykernel@gmail.com> <20211117100142.GB10330@lst.de>
 <c93bf3d4-75c1-bc3d-2789-1d65e7c19158@gmail.com>
In-Reply-To: <c93bf3d4-75c1-bc3d-2789-1d65e7c19158@gmail.com>
Cc: linux-hyperv@vger.kernel.org, brijesh.singh@amd.com, peterz@infradead.org,
 dave.hansen@linux.intel.com, dave.hansen@intel.com, hpa@zytor.com,
 kys@microsoft.com, will@kernel.org, boris.ostrovsky@oracle.com,
 wei.liu@kernel.org, sstabellini@kernel.org, sthemmin@microsoft.com,
 linux-scsi@vger.kernel.org, x86@kernel.org, decui@microsoft.com,
 michael.h.kelley@microsoft.com, mingo@redhat.com, kuba@kernel.org,
 haiyangz@microsoft.com, parri.andrea@gmail.com, thomas.lendacky@amd.com,
 Tianyu Lan <Tianyu.Lan@microsoft.com>, konrad.wilk@oracle.com,
 jejb@linux.ibm.com, bp@alien8.de, luto@kernel.org,
 xen-devel@lists.xenproject.org, tglx@linutronix.de, jgross@suse.com,
 martin.petersen@oracle.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 vkuznets@redhat.com, robin.murphy@arm.com, davem@davemloft.net
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

On 11/17/2021 10:00 PM, Tianyu Lan wrote:
> On 11/17/2021 6:01 PM, Christoph Hellwig wrote:
>> This doesn't really have much to do with normal DMA mapping,
>> so why does this direct through the dma ops?
>>
> 
> According to the previous discussion, dma_alloc_noncontigous()
> and dma_vmap_noncontiguous() may be used to handle the noncontigous
> memory alloc/map in the netvsc driver. So add alloc/free and vmap/vunmap
> callbacks here to handle the case. The previous patch v4 & v5 handles
> the allocation and map in the netvsc driver. If this should not go 
> though dma ops, We also may make it as vmbus specific function and keep
> the function in the vmbus driver.
> 
> https://lkml.org/lkml/2021/9/28/51


Hi Christoph:
       Sorry to bother you. Could you have a look? Which solution do you
prefer? If we need to call dma_alloc/map_noncontigous() function in the
netvsc driver what patch 4 does. The Hyper-V specific implementation
needs to be hided in some callbacks and call these callback in the
dma_alloc/map_noncontigous(). I used dma ops here. If the allocation and
map operation should be Hyper-V specific function, we may put these
functions in the vmbus driver and other vmbus device drivers also may
reuse these functions if necessary.

Thanks.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
