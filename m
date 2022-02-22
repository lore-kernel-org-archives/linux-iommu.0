Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 353F7C433EF
	for <iommu@archiver.kernel.org>; Tue, 22 Feb 2022 15:07:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C431840200;
	Tue, 22 Feb 2022 15:07:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sg4Srds79EtR; Tue, 22 Feb 2022 15:07:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 967E54014D;
	Tue, 22 Feb 2022 15:07:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 72FC6C0021;
	Tue, 22 Feb 2022 15:07:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A9123C0011
 for <iommu@lists.linux-foundation.org>; Tue, 22 Feb 2022 15:07:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9080C813F6
 for <iommu@lists.linux-foundation.org>; Tue, 22 Feb 2022 15:07:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id m2oWvyRWUuPP for <iommu@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 15:07:29 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D405F813D5
 for <iommu@lists.linux-foundation.org>; Tue, 22 Feb 2022 15:07:29 +0000 (UTC)
Received: by mail-pl1-x62f.google.com with SMTP id w20so15832748plq.12
 for <iommu@lists.linux-foundation.org>; Tue, 22 Feb 2022 07:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=A0la35tNJG/t3KT4ifjVJqnO2+6KZI4cizqAVsM0shA=;
 b=Z+UShjS78aAT5Tl3+/AV+OD6pcYvg0Lhm0mNhZBRILwY71LwT0JOYNJt0BTHlItsLx
 AB5YQ9KmBE1O08Uku5rCaKzNG3iupQ0oT9IwMu2loGgSy3NuWG2md/M6cC6/+zzF58XC
 gHNfRLi4HKzrIUna5mBUo7DzQ1JS5v+JmzO21IkD227FdBMX24MgRyeqmG7EdGlTg5B1
 rjGvhfccoDS0TrhVAJx5BaYAca7lEbbeB+UNaSrkKOt1D2qonEtK98NSlY2dtwp+BqOu
 J4BCndcEzAcAj0t43P7FlIaFqLqaIQC37JNEmZ60QeOdZcLYlkyCkZlXVz+0V7VVNgnf
 fAdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=A0la35tNJG/t3KT4ifjVJqnO2+6KZI4cizqAVsM0shA=;
 b=KUkvVF5bmeNicfAQ+xwvFryiYdr2afWIL4X4mnJGy859tuTd4yVxf64tS79QjDw1Fu
 3c1n2ZoZ+eU33GA3ufsr5Flv/31PWEQkDNAz7gZHgb8EHZbF7op2l2jOI3pktSwXzC2K
 /0V9U2AuQB+TSsTKWoJ+aMe+goTIO2bcezUyW12BFziOdzj4IFONv00VlwyGu1lSGM9R
 Roy+nLtkIHEwI8MMcX2SCwRYoqiRtcAKnow44QbdTQBHoFvQ+pDKK/9tWnni92/zF+Iq
 jjzIYsXG2kGtiz9teHIkpvbVRyYpM9y8g7Ap1cCgHDIts8IsUHibWKijmiefMHVOL03X
 DBXg==
X-Gm-Message-State: AOAM530BS8et2xaZtp/SGKkfl1dIyeQkK59BbGL093CyOA8R0fq+te9+
 IV2VKSDMnvs4P11awunavWs=
X-Google-Smtp-Source: ABdhPJxjZkuvhI0jYoEUrZ80PpIgvPyPzdJ2YaYFn255LvM62G54tIqeHQLdgJWP9o8kfhl7eScsWA==
X-Received: by 2002:a17:90b:4b92:b0:1b7:aca7:b2f3 with SMTP id
 lr18-20020a17090b4b9200b001b7aca7b2f3mr4632014pjb.169.1645542449216; 
 Tue, 22 Feb 2022 07:07:29 -0800 (PST)
Received: from ?IPV6:2404:f801:0:5:8000::754? ([2404:f801:9000:18:efec::754])
 by smtp.gmail.com with ESMTPSA id
 m17-20020a17090a859100b001bc20ddcc67sm2949253pjn.34.2022.02.22.07.07.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Feb 2022 07:07:28 -0800 (PST)
Message-ID: <00112505-4999-ac41-877e-49c4cc45312e@gmail.com>
Date: Tue, 22 Feb 2022 23:07:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH V2 1/2] Swiotlb: Add swiotlb_alloc_from_low_pages switch
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
References: <20220209122302.213882-1-ltykernel@gmail.com>
 <20220209122302.213882-2-ltykernel@gmail.com> <20220214081919.GA18337@lst.de>
 <4f433f07-05be-f81f-43e8-55c3f1af23b3@gmail.com>
 <20220214135834.GA30150@lst.de>
 <8d052867-ccff-f00f-7c89-cc26a4bfa347@gmail.com>
 <23f4a64d-5977-1816-8faa-fe7691ace2ff@gmail.com>
 <20220222080543.GA5412@lst.de>
From: Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <20220222080543.GA5412@lst.de>
Cc: linux-hyperv@vger.kernel.org, brijesh.singh@amd.com,
 dave.hansen@linux.intel.com, hpa@zytor.com, kys@microsoft.com,
 hch@infradead.org, wei.liu@kernel.org, sthemmin@microsoft.com, x86@kernel.org,
 decui@microsoft.com, michael.h.kelley@microsoft.com, mingo@redhat.com,
 parri.andrea@gmail.com, thomas.lendacky@amd.com,
 Tianyu Lan <Tianyu.Lan@microsoft.com>, konrad.wilk@oracle.com,
 haiyangz@microsoft.com, bp@alien8.de, tglx@linutronix.de,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 vkuznets@redhat.com, robin.murphy@arm.com
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



On 2/22/2022 4:05 PM, Christoph Hellwig wrote:
> On Mon, Feb 21, 2022 at 11:14:58PM +0800, Tianyu Lan wrote:
>> Sorry. The boot failure is not related with these patches and the issue
>> has been fixed in the latest upstream code.
>>
>> There is a performance bottleneck due to io tlb mem's spin lock during
>> performance test. All devices'io queues uses same io tlb mem entry
>> and the spin lock of io tlb mem introduce overheads. There is a fix patch
>> from Andi Kleen in the github. Could you have a look?
>>
>> https://github.com/intel/tdx/commit/4529b5784c141782c72ec9bd9a92df2b68cb7d45
> 
> Please post these things to the list.
> 
> But I suspect the right answer for the "secure" hypervisor case is to
> use the per-device swiotlb regions that we've recently added.

Thanks for your comment. That means we need to expose an 
swiotlb_device_init() interface to allocate bounce buffer and initialize
io tlb mem entry. DMA API Current  rmem_swiotlb_device_init() only works
for platform with device tree. The new API should be called in the bus
driver or new DMA API. Could you check whether this is a right way 
before we start the work.

Thanks.

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
