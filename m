Return-Path: <SRS0=kThj=K4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BDBDC4708F
	for <iommu@archiver.kernel.org>; Wed,  2 Jun 2021 15:01:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B8CC613BA
	for <iommu@archiver.kernel.org>; Wed,  2 Jun 2021 15:01:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B8CC613BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 112C5403FF;
	Wed,  2 Jun 2021 15:01:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5mLJvHVWuWDs; Wed,  2 Jun 2021 15:01:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 739A04025E;
	Wed,  2 Jun 2021 15:01:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 552D0C000E;
	Wed,  2 Jun 2021 15:01:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6C7E8C0001
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 15:01:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5105E83CB1
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 15:01:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mk8MuD2pSlIM for <iommu@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 15:01:52 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C8356833DB
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 15:01:52 +0000 (UTC)
Received: by mail-pg1-x531.google.com with SMTP id r1so2451503pgk.8
 for <iommu@lists.linux-foundation.org>; Wed, 02 Jun 2021 08:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=+az3hl/4w22b3I/rRlTcQ1/sSF9KD2GATy/NbYn2SjU=;
 b=LFh9HsM5N4yAOGzJ85RpIVWyAjUPznHirCf8/j7G4yx59JLH20/Uh4u7wbdu1FOv1R
 BMS/VcyQyPaNyIBLyV79xaZ6CaUNzIjmBxRj8Fe+1khO8KcH3zpgVSaCPqyrS/mPSxUA
 SxH1O0RaYnJym4R1ouc54zGTJI9ko785LbI0cE/6JrbOl++1vJMUiWvQ+YxS/x02SX1A
 GtQ9eZiWdQ81n3fEqhZUgWSVZqHZymyGyts8taigNA7xByYUg2QhaEC1Sqw034dlDQ+n
 EaQjVI9wbITemQxMjxw+B5xkVM7JxSTIPhVvW43gJtVIEw3fB0lKjLuGjHRyUK5Iy7k4
 pXzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+az3hl/4w22b3I/rRlTcQ1/sSF9KD2GATy/NbYn2SjU=;
 b=Vd6ifc8NwfsUIlInwuOG9F5r8+z1yIVbca3Bs33p22Zfms3G0g6wEFDM1sVxqzbmou
 eN9ptXbZ7JRnhDp4irYoWKjTVpVE5baDu1du4O0L6w74PYXwh7y1JO1yb4jh8O+aRkAE
 UCM7A+crIMWyOgB9jJd380kZ9jag1LtXEHfXJzYaIq+01eTI4vYLCCuaGJuxLks+pf2A
 SGA2CXLbDfAxJiHtxDP3iiPHjcj/U7fHDjEHI0HlGQvBTJ321iza3AigCEuZgfHAb1y6
 nWoeYaE4jVPflxsK6nKuXRBZpo8x5dB4JrPPpdmIZ6n1l++bNOCTvB6yVyEw4Sm8bCLj
 QarA==
X-Gm-Message-State: AOAM530rlu0RKYK+0Z4RvnofOG9lr7I7qO7poUqW1Sa85ZgLpdUFC6yO
 czjGnqMz8lt5ysZIrr/oaTg=
X-Google-Smtp-Source: ABdhPJztpeXS5x/Q7Ocwttmq+13ab9HvNAwDx8hEcPtnl/lWI6mAldnzn4lX5IPnQcCsuOUMA5JO9w==
X-Received: by 2002:a62:4e96:0:b029:2ea:2244:5e31 with SMTP id
 c144-20020a624e960000b02902ea22445e31mr3354423pfb.43.1622646112263; 
 Wed, 02 Jun 2021 08:01:52 -0700 (PDT)
Received: from ?IPv6:2404:f801:0:5:8000::4b1? ([2404:f801:9000:1a:efea::4b1])
 by smtp.gmail.com with ESMTPSA id
 y13sm97917pgp.16.2021.06.02.08.01.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jun 2021 08:01:51 -0700 (PDT)
Subject: Re: [RFC PATCH V3 09/11] HV/IOMMU: Enable swiotlb bounce buffer for
 Isolation VM
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>, kys@microsoft.com,
 haiyangz@microsoft.com, sthemmin@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 x86@kernel.org, hpa@zytor.com, arnd@arndb.de, dave.hansen@linux.intel.com,
 luto@kernel.org, peterz@infradead.org, akpm@linux-foundation.org,
 kirill.shutemov@linux.intel.com, rppt@kernel.org, hannes@cmpxchg.org,
 cai@lca.pw, krish.sadhukhan@oracle.com, saravanand@fb.com,
 Tianyu.Lan@microsoft.com, konrad.wilk@oracle.com, hch@lst.de,
 m.szyprowski@samsung.com, robin.murphy@arm.com, jgross@suse.com,
 sstabellini@kernel.org, joro@8bytes.org, will@kernel.org,
 xen-devel@lists.xenproject.org, davem@davemloft.net, kuba@kernel.org,
 jejb@linux.ibm.com, martin.petersen@oracle.com
References: <20210530150628.2063957-1-ltykernel@gmail.com>
 <20210530150628.2063957-10-ltykernel@gmail.com>
 <9488c114-81ad-eb67-79c0-5ed319703d3e@oracle.com>
From: Tianyu Lan <ltykernel@gmail.com>
Message-ID: <a023ee3f-ce85-b54f-79c3-146926bf3279@gmail.com>
Date: Wed, 2 Jun 2021 23:01:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <9488c114-81ad-eb67-79c0-5ed319703d3e@oracle.com>
Content-Language: en-US
Cc: linux-arch@vger.kernel.org, thomas.lendacky@amd.com,
 linux-hyperv@vger.kernel.org, brijesh.singh@amd.com,
 linux-scsi@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 vkuznets@redhat.com, sunilmut@microsoft.com
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

Hi Boris:
	Thanks for your review.

On 6/2/2021 9:16 AM, Boris Ostrovsky wrote:
> 
> On 5/30/21 11:06 AM, Tianyu Lan wrote:
>> @@ -91,6 +92,6 @@ int pci_xen_swiotlb_init_late(void)
>>   EXPORT_SYMBOL_GPL(pci_xen_swiotlb_init_late);
>>   
>>   IOMMU_INIT_FINISH(2,
>> -		  NULL,
>> +		  hyperv_swiotlb_detect,
>>   		  pci_xen_swiotlb_init,
>>   		  NULL);
> 
> 
> Could you explain this change?

Hyper-V allocates its own swiotlb bounce buffer and the default
swiotlb buffer should not be allocated. swiotlb_init() in 
pci_swiotlb_init() is to allocate default swiotlb buffer.
To achieve this, put hyperv_swiotlb_detect() as the first entry in the 
iommu_table_entry list. The detect loop in the pci_iommu_alloc() will 
exit once hyperv_swiotlb_detect() is called in Hyper-V VM and other 
iommu_table_entry callback will not be called.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
