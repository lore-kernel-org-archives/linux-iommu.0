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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE90C47094
	for <iommu@archiver.kernel.org>; Thu, 10 Jun 2021 14:25:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3579F613E7
	for <iommu@archiver.kernel.org>; Thu, 10 Jun 2021 14:25:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3579F613E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E91A740647;
	Thu, 10 Jun 2021 14:25:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jDgduwbNY1cM; Thu, 10 Jun 2021 14:25:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 815D64063C;
	Thu, 10 Jun 2021 14:25:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5D76FC000E;
	Thu, 10 Jun 2021 14:25:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 939C5C000B
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 14:25:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 72D9840637
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 14:25:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PFB_vkqAo64L for <iommu@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 14:25:24 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9C8C740633
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 14:25:24 +0000 (UTC)
Received: by mail-pj1-x102c.google.com with SMTP id k7so3751482pjf.5
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 07:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=9LfruKTSmGsaKr3T0KtsgMI2g1V5D5r+FfKoliRoTY8=;
 b=c3W9IY55kAGRSZQMUKIse7CYjATOc/WNsezUixaF5fWDkVciqS0+iWaZcHtL2rFFUw
 q6Af9zyVo5zJyfySRvKv8k+huR+szVR1Xb8GDyTonmbkQ3V0MoPt+EBqk/fvrUpoIhu0
 FpoCg5T+vTYyaf/IELWrWdHqeg6MOtolC1d7jn3ifj33bWYJ1rAiXRMyOW50J2wlpwFG
 OzCk7HbGROQ8oMztcbHmPooQ1M2yg6rOw9Gp0rsVbF3wVqRpT60yIqJM59aQu50FPywK
 5PKEXQwlOBjWNljf/CAPll8LJKaf8zXSJtCqfJmCU42oGpqB5i4sk/wWojxWFZDHy/Ps
 2toA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9LfruKTSmGsaKr3T0KtsgMI2g1V5D5r+FfKoliRoTY8=;
 b=FXqVFw+MW60b8s8VVvp3Q1pIRiUC3qTwNXqlm/B/bDMd7UiumBUdlcJ6CGihvt422b
 g5C3ziyz17w1lRsIeIfdgvdVCkhFZx/Z9govY3cf25LzlPzERe41Cqnd7pkqUMwHqAfH
 r6p3TVMAuiJeAWb9NWtiHvy2gfKs4Du9dEQDUJkGUcaC3Tphn/HBZK3RxgkZUN+N1z4b
 qeQ4X7hz90E/eTGZ/VeXmuTFPPIX2ttSlze3PBjgL1d6z8kGsNz9Bg3s6ZfR67ynjm58
 AzxJhdlE3CsXOI6ZSF6IXi0n6aI6ueX+W13ZK0IOrktvOLY5ZD0yVtwvTt+HJmxPQoIz
 +jag==
X-Gm-Message-State: AOAM533p0iXnt2a7M2ETH7bJDIxIpTCW9ZBkbBHqGIOgV6Oz5YyPVMpy
 10a5KPvxhrg6LtjMKKh12KM=
X-Google-Smtp-Source: ABdhPJzdwp2MX3HMzPasMcsmUlDqisDdNAsXcZ2anZ9ouahX31714ETLaZ+TtT/Nrt8h3xRgpVym6w==
X-Received: by 2002:a17:90a:7bce:: with SMTP id
 d14mr3702065pjl.38.1623335123951; 
 Thu, 10 Jun 2021 07:25:23 -0700 (PDT)
Received: from ?IPv6:2404:f801:0:5:8000::4b1? ([2404:f801:9000:1a:efea::4b1])
 by smtp.gmail.com with ESMTPSA id 1sm8338487pjm.8.2021.06.10.07.25.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Jun 2021 07:25:23 -0700 (PDT)
Subject: Re: [RFC PATCH V3 08/11] swiotlb: Add bounce buffer remap address
 setting function
From: Tianyu Lan <ltykernel@gmail.com>
To: Christoph Hellwig <hch@lst.de>
References: <20210530150628.2063957-1-ltykernel@gmail.com>
 <20210530150628.2063957-9-ltykernel@gmail.com>
 <20210607064312.GB24478@lst.de>
 <48516ce3-564c-419e-b355-0ce53794dcb1@gmail.com>
Message-ID: <9c05f7fd-6460-5d4a-aa83-08626839d18e@gmail.com>
Date: Thu, 10 Jun 2021 22:25:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <48516ce3-564c-419e-b355-0ce53794dcb1@gmail.com>
Content-Language: en-US
Cc: linux-hyperv@vger.kernel.org, brijesh.singh@amd.com, peterz@infradead.org,
 dave.hansen@linux.intel.com, hpa@zytor.com, kys@microsoft.com, will@kernel.org,
 boris.ostrovsky@oracle.com, linux-arch@vger.kernel.org, wei.liu@kernel.org,
 sstabellini@kernel.org, sthemmin@microsoft.com, linux-scsi@vger.kernel.org,
 x86@kernel.org, decui@microsoft.com, mingo@redhat.com,
 xen-devel@lists.xenproject.org, jejb@linux.ibm.com, thomas.lendacky@amd.com,
 Tianyu.Lan@microsoft.com, arnd@arndb.de, konrad.wilk@oracle.com,
 haiyangz@microsoft.com, kuba@kernel.org, bp@alien8.de, luto@kernel.org,
 krish.sadhukhan@oracle.com, tglx@linutronix.de, vkuznets@redhat.com,
 jgross@suse.com, martin.petersen@oracle.com, saravanand@fb.com,
 netdev@vger.kernel.org, sunilmut@microsoft.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, kirill.shutemov@linux.intel.com,
 hannes@cmpxchg.org, cai@lca.pw, akpm@linux-foundation.org,
 robin.murphy@arm.com, davem@davemloft.net, rppt@kernel.org
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



On 6/7/2021 10:56 PM, Tianyu Lan wrote:
> 
> On 6/7/2021 2:43 PM, Christoph Hellwig wrote:
>> On Sun, May 30, 2021 at 11:06:25AM -0400, Tianyu Lan wrote:
>>> From: Tianyu Lan <Tianyu.Lan@microsoft.com>
>>>
>>> For Hyper-V isolation VM with AMD SEV SNP, the bounce buffer(shared 
>>> memory)
>>> needs to be accessed via extra address space(e.g address above bit39).
>>> Hyper-V code may remap extra address space outside of swiotlb. swiotlb_
>>> bounce() needs to use remap virtual address to copy data from/to bounce
>>> buffer. Add new interface swiotlb_set_bounce_remap() to do that.
>>
>> Why can't you use the bus_dma_region ranges to remap to your preferred
>> address?
>>
> 
> Thanks for your suggestion.
> 
> These addresses in extra address space works as system memory mirror. 
> The shared memory with host in Isolation VM needs to be accessed via 
> extra address space which is above shared gpa boundary. During 
> initializing swiotlb bounce buffer pool, only address bellow shared gpa 
> boundary can be accepted by swiotlb API because it is treated as system 
> memory and managed by memory management. This is why Hyper-V swiotlb 
> bounce buffer pool needs to be allocated in Hyper-V code and map
> associated physical address in extra address space. The patch target is
> to add the new interface to set start virtual address of bounce buffer
> pool and let swiotlb boucne buffer copy function to use right virtual 
> address for extra address space.
> 
> bus_dma_region is to translate cpu physical address to dma address.
> It can't modify the virtual address of bounce buffer pool and let
> swiotlb code to copy data with right address. If some thing missed,
> please correct me.
> 

Hi Christoph:
	Sorry to bother you. Could you have a look at my previous reply?
I try figuring out the right way.

Thanks.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
