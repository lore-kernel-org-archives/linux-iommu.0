Return-Path: <SRS0=DplC=LI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29976C2B9F4
	for <iommu@archiver.kernel.org>; Mon, 14 Jun 2021 14:04:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5DC161350
	for <iommu@archiver.kernel.org>; Mon, 14 Jun 2021 14:04:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5DC161350
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7F933600C5;
	Mon, 14 Jun 2021 14:04:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yHh0htMiRqBk; Mon, 14 Jun 2021 14:04:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 68649600B5;
	Mon, 14 Jun 2021 14:04:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 21C41C000E;
	Mon, 14 Jun 2021 14:04:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 002C9C000B
 for <iommu@lists.linux-foundation.org>; Mon, 14 Jun 2021 14:04:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D49B840298
 for <iommu@lists.linux-foundation.org>; Mon, 14 Jun 2021 14:04:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tdJ5v8DS0fJF for <iommu@lists.linux-foundation.org>;
 Mon, 14 Jun 2021 14:04:21 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com
 [IPv6:2607:f8b0:4864:20::52e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 01F9040212
 for <iommu@lists.linux-foundation.org>; Mon, 14 Jun 2021 14:04:20 +0000 (UTC)
Received: by mail-pg1-x52e.google.com with SMTP id e22so8700241pgv.10
 for <iommu@lists.linux-foundation.org>; Mon, 14 Jun 2021 07:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=yJB+B/uqyT8Yj8oTe4yW/iwZF1PlGwEGbYmCRyf4VPs=;
 b=WH301YVkd+NT/H+jeV6pcNYHdcjqtaqvIdtbpu0fkkYAmJ7rw0/VnTDAhSvIgbv4c0
 oazbEKmF+c7M1WRPaxGMZU5xoCLTUJgtdxU9APUEzGlzXnchk40ZNp3QFWLwuNrBu83j
 e2ylhCoSYk62pl120eNuhLwuvfMbaggtn+gXAD60VuMlb9RO9aR6yjsww4EENQAJey5G
 2ZzxWZw9pL2yOQEQRAidkW9g0ErNbkj+wegNJA0H7wJ55BH2rzTM1HnAVz1Nh8SFyWFK
 I7BbhU7Q2hwWxihuFlWkGm+R8myZotEgjwBltHJuCwGgHkDJ5/gTI6uquz0y/0l8g0ap
 0ueg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=yJB+B/uqyT8Yj8oTe4yW/iwZF1PlGwEGbYmCRyf4VPs=;
 b=ZqTflMClgJtegLkb0kLU+9gdYETDrXR5TvEE4i1ROdcdyrQHvipJ80aGQVx7BT8XAs
 TobsW4VkDSLcCbwEXmbxaPueNWNNkGlETJLtcAFZ5JsXmNaLqay3V8HWhZ7rsFCa8guT
 eczwjxIdTcbSq2zCY75Duut38J6EzXPzUUOcYkIUB2MiL5iR/7ieBDR4wg0oQvJzn3R5
 2De6ivD0YYdyMuEEhAYlwDJoHM5wxXbRLSJf2S03dkP7NQF69Ns6ciiRKRiCsUO8CJgq
 GPrk/t6ptljwZP8370HKyr7NGMC33HYhTvHz5F5cm43dnpflshUWiviFZEdS66dBDkfo
 TCCQ==
X-Gm-Message-State: AOAM530Vj1E9lvmwvexNZ5pmzT1HCq9XxEHwx9YP5SoyVATnAON6kaaz
 GnHaEWOmVpym9cLqVlIPu6E=
X-Google-Smtp-Source: ABdhPJyxkq2bPSQ3rYusHXFwzEn3le7fAXsaXh5Rh36tAMz0+W6V1tW5a8HSqlbDYgsTNNATX2tI2A==
X-Received: by 2002:a63:5760:: with SMTP id h32mr17200205pgm.367.1623679460361; 
 Mon, 14 Jun 2021 07:04:20 -0700 (PDT)
Received: from ?IPv6:2404:f801:0:5:8000::4b1? ([2404:f801:9000:1a:efea::4b1])
 by smtp.gmail.com with ESMTPSA id
 x206sm12950089pfc.211.2021.06.14.07.04.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Jun 2021 07:04:20 -0700 (PDT)
Subject: Re: [RFC PATCH V3 10/11] HV/Netvsc: Add Isolation VM support for
 netvsc driver
To: Christoph Hellwig <hch@lst.de>
References: <20210530150628.2063957-1-ltykernel@gmail.com>
 <20210530150628.2063957-11-ltykernel@gmail.com>
 <20210607065007.GE24478@lst.de>
 <279cb4bf-c5b6-6db9-0f1e-9238e902c8f2@gmail.com>
 <20210614070903.GA29976@lst.de>
From: Tianyu Lan <ltykernel@gmail.com>
Message-ID: <e10c2696-23c3-befe-4f4d-25e18918132f@gmail.com>
Date: Mon, 14 Jun 2021 22:04:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210614070903.GA29976@lst.de>
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


On 6/14/2021 3:09 PM, Christoph Hellwig wrote:
> On Mon, Jun 07, 2021 at 11:21:20PM +0800, Tianyu Lan wrote:
>>> dma_map_single can only be used on page baked memory, and if this is
>>> using page backed memory you wouldn't need to do thee phys_to_virt
>>> tricks.  Can someone explain the mess here in more detail?
>>
>> Sorry. Could you elaborate the issue? These pages in the pb array are not
>> allocated by DMA API and using dma_map_single() here is to map these pages'
>> address to bounce buffer physical address.
> 
> dma_map_single just calls dma_map_page using virt_to_page.  So this
> can't work on addresses not in the kernel linear mapping.
> 

The pages in the hv_page_buffer array here are in the kernel linear 
mapping. The packet sent to host will contain an array which contains 
transaction data. In the isolation VM, data in the these pages needs to 
be copied to bounce buffer and so call dma_map_single() here to map 
these data pages with bounce buffer. The vmbus has ring buffer where the 
send/receive packets are copied to/from. The ring buffer has been 
remapped to the extra space above shared gpa boundary/vTom during 
probing Netvsc driver and so not call dma map function for vmbus ring
buffer.




_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
