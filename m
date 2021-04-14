Return-Path: <SRS0=7Zqx=JL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E079AC433B4
	for <iommu@archiver.kernel.org>; Wed, 14 Apr 2021 17:47:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64A0061177
	for <iommu@archiver.kernel.org>; Wed, 14 Apr 2021 17:47:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64A0061177
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id F1E9540189;
	Wed, 14 Apr 2021 17:47:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1sNDCNTCQTKS; Wed, 14 Apr 2021 17:47:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id D60D5401B7;
	Wed, 14 Apr 2021 17:47:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B6317C000C;
	Wed, 14 Apr 2021 17:47:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 82EDEC000A
 for <iommu@lists.linux-foundation.org>; Wed, 14 Apr 2021 17:47:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5D094607DF
 for <iommu@lists.linux-foundation.org>; Wed, 14 Apr 2021 17:47:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id f2mrXgMH_3Cl for <iommu@lists.linux-foundation.org>;
 Wed, 14 Apr 2021 17:47:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 81C8C606B8
 for <iommu@lists.linux-foundation.org>; Wed, 14 Apr 2021 17:47:36 +0000 (UTC)
Received: from fraeml738-chm.china.huawei.com (unknown [172.18.147.226])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FL8nJ6kwxz6898S;
 Thu, 15 Apr 2021 01:37:40 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml738-chm.china.huawei.com (10.206.15.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 14 Apr 2021 19:47:33 +0200
Received: from [10.47.25.158] (10.47.25.158) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Wed, 14 Apr
 2021 18:47:32 +0100
From: John Garry <john.garry@huawei.com>
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
 <4914d134-5a63-f683-b14b-25ab71a57cd4@huawei.com>
Message-ID: <8fce915b-18fa-2bfb-66d7-325cb7837894@huawei.com>
Date: Wed, 14 Apr 2021 18:44:58 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <4914d134-5a63-f683-b14b-25ab71a57cd4@huawei.com>
Content-Language: en-US
X-Originating-IP: [10.47.25.158]
X-ClientProxiedBy: lhreml730-chm.china.huawei.com (10.201.108.81) To
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

On 06/04/2021 17:54, John Garry wrote:

Hi Robin,

> 
>> Sorry if the phrasing was unclear there - the allusion to default 
>> domains is new, it just occurred to me that what we do there is in 
>> fact fairly close to what I've suggested previously for this. In that 
>> case, we have a global policy set by the command line, which *can* be 
>> overridden per-domain via sysfs at runtime, provided the user is 
>> willing to tear the whole thing down. Using a similar approach here 
>> would give a fair degree of flexibility but still mean that changes 
>> never have to be made dynamically to a live domain.
> 
> So are you saying that we can handle it similar to how we now can handle 
> changing default domain for an IOMMU group via sysfs? If so, that just 
> is not practical here. Reason being that this particular DMA engine 
> provides the block device giving / mount point, so if we unbind the 
> driver, we lose / mount point.
> 
> And I am not sure if the end user would even know how to set such a 
> tunable. Or, in this case, why the end user would not want the optimized 
> range configured always.
> 
> I'd still rather if the device driver could provide info which can be 
> used to configure this before or during probing.

As a new solution, how about do both of these:
a. Add a per-IOMMU group sysfs file to set this tunable. Works same as 
how we change the default domain, and has all the same 
restrictions/steps. I think that this is what you are already suggesting.
b. Provide a DMA mapping API to set this value, similar to this current 
series. In the IOMMU backend for that API, we record a new range value 
and return -EPROBE_DEFER when successful. In the reprobe we reset the 
default domain for the devices' IOMMU group, with the IOVA domain rcache 
range configured as previously requested. Again, allocating the new 
default domain is similar to how we change default domain type today.
This means that we don't play with a live domain. Downside is that we 
need to defer the probe.

Thanks,
John
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
