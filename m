Return-Path: <SRS0=B6PL=JN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,URIBL_RED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95273C433ED
	for <iommu@archiver.kernel.org>; Fri, 16 Apr 2021 09:07:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09A3F613B7
	for <iommu@archiver.kernel.org>; Fri, 16 Apr 2021 09:07:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09A3F613B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C4F5660DD6;
	Fri, 16 Apr 2021 09:07:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6iVHSVi3AtUx; Fri, 16 Apr 2021 09:07:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9A34660712;
	Fri, 16 Apr 2021 09:07:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 81287C000B;
	Fri, 16 Apr 2021 09:07:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DE4D9C000A
 for <iommu@lists.linux-foundation.org>; Fri, 16 Apr 2021 09:07:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B560760DD6
 for <iommu@lists.linux-foundation.org>; Fri, 16 Apr 2021 09:07:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SPbYDn4JzjZ5 for <iommu@lists.linux-foundation.org>;
 Fri, 16 Apr 2021 09:07:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 61E3960712
 for <iommu@lists.linux-foundation.org>; Fri, 16 Apr 2021 09:07:38 +0000 (UTC)
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FM9K82181zwRnd;
 Fri, 16 Apr 2021 17:05:16 +0800 (CST)
Received: from [10.174.187.224] (10.174.187.224) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.498.0; Fri, 16 Apr 2021 17:07:28 +0800
Subject: Re: [PATCH v3 01/12] iommu: Introduce dirty log tracking framework
To: Lu Baolu <baolu.lu@linux.intel.com>, <linux-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux-foundation.org>,
 Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>, "Joerg
 Roedel" <joro@8bytes.org>, Yi Sun <yi.y.sun@linux.intel.com>, "Jean-Philippe
 Brucker" <jean-philippe@linaro.org>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Tian Kevin <kevin.tian@intel.com>
References: <20210413085457.25400-1-zhukeqian1@huawei.com>
 <20210413085457.25400-2-zhukeqian1@huawei.com>
 <fe337950-f8d0-3d21-a7b1-98b385d71f3e@linux.intel.com>
 <e42373e3-10d5-5a34-8f33-8bb82d64fb19@huawei.com>
 <56b001fa-b4fe-c595-dc5e-f362d2f07a19@linux.intel.com>
 <88cba608-2f22-eb83-f22e-50cb547b6ee8@huawei.com>
 <2c01425f-813c-4278-ba06-26d651496a5c@linux.intel.com>
From: Keqian Zhu <zhukeqian1@huawei.com>
Message-ID: <64c87f67-3687-61bd-1587-724cc2f9cc97@huawei.com>
Date: Fri, 16 Apr 2021 17:07:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <2c01425f-813c-4278-ba06-26d651496a5c@linux.intel.com>
X-Originating-IP: [10.174.187.224]
X-CFilter-Loop: Reflected
Cc: jiangkunkun@huawei.com, Cornelia Huck <cohuck@redhat.com>,
 Kirti Wankhede <kwankhede@nvidia.com>, lushenming@huawei.com,
 Alex Williamson <alex.williamson@redhat.com>, wanghaibin.wang@huawei.com
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

Hi Baolu,

On 2021/4/15 18:21, Lu Baolu wrote:
> Hi,
> 
> On 2021/4/15 15:43, Keqian Zhu wrote:
>>>> design it as not switchable. I will modify the commit message of patch#12, thanks!
>>> I am not sure that I fully get your point. But I can't see any gaps of
>>> using iommu_dev_enable/disable_feature() to switch dirty log on and off.
>>> Probably I missed anything.
>> IOMMU_DEV_FEAT_HWDBM just tells user whether underlying IOMMU driver supports
>> dirty tracking, it is not used to management the status of dirty log tracking.
>>
>> The feature reporting is per device, but the status management is per iommu_domain.
>> Only when all devices in a domain support HWDBM, we can start dirty log for the domain.
> 
> So why not
> 
>     for_each_device_attached_domain()
>         iommu_dev_enable_feature(IOMMU_DEV_FEAT_HWDBM)
Looks reasonable, but the problem is that we just need to enable dirty log once per domain.

> 
> ?
>>
>> And I think we'd better not mix the feature reporting and status management. Thoughts?
>>
> 
> I am worrying about having two sets of APIs for single purpose. From
> vendor iommu driver's point of view, this feature is per device. Hence,
> it still needs to do the same thing.
Yes, we can unify the granule of feature reporting and status management.

The basic granule of dirty tracking is iommu_domain, I think it's very reasonable. We need an
interface to report the feature of iommu_domain, then the logic is much more clear.

Every time we add new device or remove device from the domain, we should update the feature (e.g.,
maintain a counter of unsupported devices).

What do you think about this idea?

Thanks,
Keqian
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
