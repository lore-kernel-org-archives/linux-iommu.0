Return-Path: <SRS0=NW7i=JD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D9C2C433ED
	for <iommu@archiver.kernel.org>; Tue,  6 Apr 2021 16:56:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D02DB613C0
	for <iommu@archiver.kernel.org>; Tue,  6 Apr 2021 16:56:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D02DB613C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 97B8A84A47;
	Tue,  6 Apr 2021 16:56:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Xu_WY2_K4Oe4; Tue,  6 Apr 2021 16:56:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 77C6784A3F;
	Tue,  6 Apr 2021 16:56:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3FF41C000C;
	Tue,  6 Apr 2021 16:56:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 83F29C000A
 for <iommu@lists.linux-foundation.org>; Tue,  6 Apr 2021 16:56:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 722C560B80
 for <iommu@lists.linux-foundation.org>; Tue,  6 Apr 2021 16:56:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2JrbJqVu3IKH for <iommu@lists.linux-foundation.org>;
 Tue,  6 Apr 2021 16:56:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 04C78606E0
 for <iommu@lists.linux-foundation.org>; Tue,  6 Apr 2021 16:56:39 +0000 (UTC)
Received: from fraeml744-chm.china.huawei.com (unknown [172.18.147.226])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FFD2j4tTVz6824f;
 Wed,  7 Apr 2021 00:47:09 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml744-chm.china.huawei.com (10.206.15.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 6 Apr 2021 18:56:37 +0200
Received: from [10.210.166.136] (10.210.166.136) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 6 Apr 2021 17:56:35 +0100
Subject: Re: [PATCH 1/6] iommu: Move IOVA power-of-2 roundup into allocator
To: Robin Murphy <robin.murphy@arm.com>, "joro@8bytes.org" <joro@8bytes.org>, 
 "will@kernel.org" <will@kernel.org>, "jejb@linux.ibm.com"
 <jejb@linux.ibm.com>, "martin.petersen@oracle.com"
 <martin.petersen@oracle.com>, "hch@lst.de" <hch@lst.de>,
 "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>
References: <1616160348-29451-1-git-send-email-john.garry@huawei.com>
 <1616160348-29451-2-git-send-email-john.garry@huawei.com>
 <ee935a6d-a94c-313e-f0ed-e14cc6dac055@arm.com>
 <73d459de-b5cc-e2f5-bcd7-2ee23c8d5075@huawei.com>
 <afc2fc05-a799-cb14-debd-d36afed8f456@arm.com>
 <08c0f4b9-8713-fa97-3986-3cfb0d6b820b@huawei.com>
 <e4b9146a-ca32-50f5-4fe0-42aa0b66d2d6@arm.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <4914d134-5a63-f683-b14b-25ab71a57cd4@huawei.com>
Date: Tue, 6 Apr 2021 17:54:07 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <e4b9146a-ca32-50f5-4fe0-42aa0b66d2d6@arm.com>
Content-Language: en-US
X-Originating-IP: [10.210.166.136]
X-ClientProxiedBy: lhreml711-chm.china.huawei.com (10.201.108.62) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 Linuxarm <linuxarm@huawei.com>
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

>>>> So then we have the issue of how to dynamically increase this rcache
>>>> threshold. The problem is that we may have many devices associated with
>>>> the same domain. So, in theory, we can't assume that when we increase
>>>> the threshold that some other device will try to fast free an IOVA 
>>>> which
>>>> was allocated prior to the increase and was not rounded up.
>>>>
>>>> I'm very open to better (or less bad) suggestions on how to do this ...
>>> ...but yes, regardless of exactly where it happens, rounding up or not
>>> is the problem for rcaches in general. I've said several times that my
>>> preferred approach is to not change it that dynamically at all, but
>>> instead treat it more like we treat the default domain type.
>>>
>>
>> Can you remind me of that idea? I don't remember you mentioning using 
>> default domain handling as a reference in any context.
> 

Hi Robin,

> Sorry if the phrasing was unclear there - the allusion to default 
> domains is new, it just occurred to me that what we do there is in fact 
> fairly close to what I've suggested previously for this. In that case, 
> we have a global policy set by the command line, which *can* be 
> overridden per-domain via sysfs at runtime, provided the user is willing 
> to tear the whole thing down. Using a similar approach here would give a 
> fair degree of flexibility but still mean that changes never have to be 
> made dynamically to a live domain.

So are you saying that we can handle it similar to how we now can handle 
changing default domain for an IOMMU group via sysfs? If so, that just 
is not practical here. Reason being that this particular DMA engine 
provides the block device giving / mount point, so if we unbind the 
driver, we lose / mount point.

And I am not sure if the end user would even know how to set such a 
tunable. Or, in this case, why the end user would not want the optimized 
range configured always.

I'd still rather if the device driver could provide info which can be 
used to configure this before or during probing.

Cheers,
John
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
