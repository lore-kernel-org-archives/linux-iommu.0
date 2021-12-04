Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC144C433F5
	for <iommu@archiver.kernel.org>; Sat,  4 Dec 2021 07:26:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 79C4C8343E;
	Sat,  4 Dec 2021 07:26:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mTU0N7SUVFRt; Sat,  4 Dec 2021 07:26:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 522F183417;
	Sat,  4 Dec 2021 07:26:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 09B8AC006E;
	Sat,  4 Dec 2021 07:26:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8A2FDC0012
 for <iommu@lists.linux-foundation.org>; Sat,  4 Dec 2021 07:26:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6FA2D40254
 for <iommu@lists.linux-foundation.org>; Sat,  4 Dec 2021 07:26:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id X8YcwNZCVCHR for <iommu@lists.linux-foundation.org>;
 Sat,  4 Dec 2021 07:26:50 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com
 [IPv6:2607:f8b0:4864:20::432])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 314D44011B
 for <iommu@lists.linux-foundation.org>; Sat,  4 Dec 2021 07:26:50 +0000 (UTC)
Received: by mail-pf1-x432.google.com with SMTP id k26so695622pfp.10
 for <iommu@lists.linux-foundation.org>; Fri, 03 Dec 2021 23:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=eCoo4UdX0KSai3rgxqp+sZCsWhUUBGl2p1rpp3l5eBw=;
 b=SrgtERJGlFYclhGBMZWqWPGAIZbR6fQ6Uu4tpnTSOZi4kEEMeogHi+38ibOB1Ey21P
 NsKwL8E3bcEDfz8ZW+SzX7lW4BoeQcApz4UUqds31/0hKjtB8GC+RLIm017R9iXqjTQ5
 5L1ib+SOX+p6av7/1hxf7B+3Qxk2Iw7WqrJvdJo9bhmIi2CFI/RD70cSaIdmmD4TnbkS
 5y6tetKfkLX0NGXFeSmkkx7JTdHF8qPgaL8esKv9vgiuB4mG86p3+JuYbDIU/22ynW84
 XgstoStjjO1fceJiyUS6HIleMKpq85ai6WbYYTiWfwnyb44HUdjQ0qsdqcUOoB5fcM8p
 lk9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=eCoo4UdX0KSai3rgxqp+sZCsWhUUBGl2p1rpp3l5eBw=;
 b=n2Ox4JAmIMZP+Mp/mijIiQdBMebIVwslS1OrzS94cgLvZIRjIFM1QhpOmy9Loa09iD
 4m4B0WOha3htPSChrbGpz4oqDrEITpyRgtzAg8k+himuRhDZ6q7f2TnNTWGKWzgCsC5P
 1bDP2JeNfPu0ALKvzopCWNNF+UKC3yB7qLNJIzo2EblIQwuBPfnIo3duxYXHqdVWhHZt
 mAVheN5gNtY/AHhdJTrgP4n8ABpH5vxCNCb3beKol9/ONgFtE7zO7B+6eDpmTFRM7ZS5
 mW+jHs9lFDJKG+mSeKdrGpKL2vMp0+K+8Sns3zLCinqKGgowh14LYw1KB/5zUDYxMv6v
 1exg==
X-Gm-Message-State: AOAM533Oc3znv0wGV72kXQuTmWSQX1UlIJDv73Cau6SpQrozaZAc6aAO
 l6AYDuqm3KLMKdCDKS+BPk8=
X-Google-Smtp-Source: ABdhPJwCQRkn3xmR+kfR3YlZKVCxe03wvGUj2OGYKR6Vkh9NokqMfnW2TUg5Koi/TslOtDsFr3TRJg==
X-Received: by 2002:a63:8ac1:: with SMTP id y184mr8696835pgd.48.1638602809615; 
 Fri, 03 Dec 2021 23:26:49 -0800 (PST)
Received: from ?IPV6:2404:f801:0:5:8000::50b? ([2404:f801:9000:18:efec::50b])
 by smtp.gmail.com with ESMTPSA id
 m184sm4248180pga.61.2021.12.03.23.26.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Dec 2021 23:26:49 -0800 (PST)
Message-ID: <877e6f24-2004-0681-f9f3-241fb6ace427@gmail.com>
Date: Sat, 4 Dec 2021 15:26:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH V3 3/5] hyperv/IOMMU: Enable swiotlb bounce buffer for
 Isolation VM
Content-Language: en-US
To: "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
 KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
 "jgross@suse.com" <jgross@suse.com>,
 "sstabellini@kernel.org" <sstabellini@kernel.org>,
 "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
 "joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "kuba@kernel.org" <kuba@kernel.org>, "jejb@linux.ibm.com"
 <jejb@linux.ibm.com>, "martin.petersen@oracle.com"
 <martin.petersen@oracle.com>, "arnd@arndb.de" <arnd@arndb.de>,
 "hch@infradead.org" <hch@infradead.org>,
 "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 Tianyu Lan <Tianyu.Lan@microsoft.com>,
 "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
References: <20211201160257.1003912-1-ltykernel@gmail.com>
 <20211201160257.1003912-4-ltykernel@gmail.com>
 <MWHPR21MB159390BE1B546A6F90FB1F18D76A9@MWHPR21MB1593.namprd21.prod.outlook.com>
From: Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <MWHPR21MB159390BE1B546A6F90FB1F18D76A9@MWHPR21MB1593.namprd21.prod.outlook.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 "parri.andrea@gmail.com" <parri.andrea@gmail.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "dave.hansen@intel.com" <dave.hansen@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 vkuznets <vkuznets@redhat.com>, "hch@lst.de" <hch@lst.de>
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



On 12/4/2021 3:17 AM, Michael Kelley (LINUX) wrote:
>> +static void __init hyperv_iommu_swiotlb_init(void)
>> +{
>> +	unsigned long hyperv_io_tlb_size;
>> +	void *hyperv_io_tlb_start;
>> +
>> +	/*
>> +	 * Allocate Hyper-V swiotlb bounce buffer at early place
>> +	 * to reserve large contiguous memory.
>> +	 */
>> +	hyperv_io_tlb_size = swiotlb_size_or_default();
>> +	hyperv_io_tlb_start = memblock_alloc(hyperv_io_tlb_size, PAGE_SIZE);
>> +
>> +	if (!hyperv_io_tlb_start)
>> +		pr_warn("Fail to allocate Hyper-V swiotlb buffer.\n");
> In the error case, won't swiotlb_init_with_tlb() end up panic'ing when
> it tries to zero out the memory?   The only real choice here is to
> return immediately after printing the message, and not call
> swiotlb_init_with_tlb().
> 

Yes, agree. Will update.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
