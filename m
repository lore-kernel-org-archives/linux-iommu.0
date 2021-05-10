Return-Path: <SRS0=b4g5=KF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF047C433ED
	for <iommu@archiver.kernel.org>; Mon, 10 May 2021 01:09:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FB3A6112F
	for <iommu@archiver.kernel.org>; Mon, 10 May 2021 01:09:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FB3A6112F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 009394031D;
	Mon, 10 May 2021 01:09:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id U5uoanhaAYaV; Mon, 10 May 2021 01:09:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9BD0A40315;
	Mon, 10 May 2021 01:09:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 57F22C000D;
	Mon, 10 May 2021 01:09:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DC200C0001
 for <iommu@lists.linux-foundation.org>; Mon, 10 May 2021 01:09:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BD4E083AC9
 for <iommu@lists.linux-foundation.org>; Mon, 10 May 2021 01:09:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SX-Xg8xqnqVm for <iommu@lists.linux-foundation.org>;
 Mon, 10 May 2021 01:09:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0107683AC5
 for <iommu@lists.linux-foundation.org>; Mon, 10 May 2021 01:09:48 +0000 (UTC)
IronPort-SDR: t8nk3R4ufxSqLD2ZaXzOOrYK5y2me6IwxedonLHKdBuPnR8hXoTASd/4PfGe5o9fN79ITsqsNc
 8BIxQuSpfvrA==
X-IronPort-AV: E=McAfee;i="6200,9189,9979"; a="197099038"
X-IronPort-AV: E=Sophos;i="5.82,286,1613462400"; d="scan'208";a="197099038"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 May 2021 18:09:47 -0700
IronPort-SDR: ZBtY8N/+MVvY5N4tMR5NoQUFqfIMbL4Q9bmxKKMYewPvlWIWbS0mwXSF89kXVmnusuD1rH4tZb
 DuvHUsGfIQ4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,286,1613462400"; d="scan'208";a="621024331"
Received: from allen-box.sh.intel.com (HELO [10.239.159.128])
 ([10.239.159.128])
 by fmsmga006.fm.intel.com with ESMTP; 09 May 2021 18:09:43 -0700
Subject: Re: [RFC PATCH v4 01/13] iommu: Introduce dirty log tracking framework
To: Keqian Zhu <zhukeqian1@huawei.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org,
 Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
 Joerg Roedel <joro@8bytes.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Yi Sun <yi.y.sun@linux.intel.com>, Tian Kevin <kevin.tian@intel.com>
References: <20210507102211.8836-1-zhukeqian1@huawei.com>
 <20210507102211.8836-2-zhukeqian1@huawei.com>
 <efc2d868-28ba-8ed9-1d6b-610b67d671b5@linux.intel.com>
 <18ac787a-179e-71f7-728b-c43feda80a16@huawei.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <55fda826-9ab6-a3a0-b17e-a4d4879f00bc@linux.intel.com>
Date: Mon, 10 May 2021 09:08:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <18ac787a-179e-71f7-728b-c43feda80a16@huawei.com>
Content-Language: en-US
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Keqian,

On 5/8/21 3:35 PM, Keqian Zhu wrote:
> Hi Baolu,
> 
> On 2021/5/8 11:46, Lu Baolu wrote:
>> Hi Keqian,
>>
>> On 5/7/21 6:21 PM, Keqian Zhu wrote:
>>> Some types of IOMMU are capable of tracking DMA dirty log, such as
>>> ARM SMMU with HTTU or Intel IOMMU with SLADE. This introduces the
>>> dirty log tracking framework in the IOMMU base layer.
>>>
>>> Four new essential interfaces are added, and we maintaince the status
>>> of dirty log tracking in iommu_domain.
>>> 1. iommu_support_dirty_log: Check whether domain supports dirty log tracking
>>> 2. iommu_switch_dirty_log: Perform actions to start|stop dirty log tracking
>>> 3. iommu_sync_dirty_log: Sync dirty log from IOMMU into a dirty bitmap
>>> 4. iommu_clear_dirty_log: Clear dirty log of IOMMU by a mask bitmap
>>>
>>> Note: Don't concurrently call these interfaces with other ops that
>>> access underlying page table.
>>>
>>> Signed-off-by: Keqian Zhu<zhukeqian1@huawei.com>
>>> Signed-off-by: Kunkun Jiang<jiangkunkun@huawei.com>
>>> ---
>>>    drivers/iommu/iommu.c        | 201 +++++++++++++++++++++++++++++++++++
>>>    include/linux/iommu.h        |  63 +++++++++++
>>>    include/trace/events/iommu.h |  63 +++++++++++
>>>    3 files changed, 327 insertions(+)
>>>
>>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>>> index 808ab70d5df5..0d15620d1e90 100644
>>> --- a/drivers/iommu/iommu.c
>>> +++ b/drivers/iommu/iommu.c
>>> @@ -1940,6 +1940,7 @@ static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
>>>        domain->type = type;
>>>        /* Assume all sizes by default; the driver may override this later */
>>>        domain->pgsize_bitmap  = bus->iommu_ops->pgsize_bitmap;
>>> +    mutex_init(&domain->switch_log_lock);
>>>          return domain;
>>>    }
>>> @@ -2703,6 +2704,206 @@ int iommu_set_pgtable_quirks(struct iommu_domain *domain,
>>>    }
>>>    EXPORT_SYMBOL_GPL(iommu_set_pgtable_quirks);
>>>    +bool iommu_support_dirty_log(struct iommu_domain *domain)
>>> +{
>>> +    const struct iommu_ops *ops = domain->ops;
>>> +
>>> +    return ops->support_dirty_log && ops->support_dirty_log(domain);
>>> +}
>>> +EXPORT_SYMBOL_GPL(iommu_support_dirty_log);
>> I suppose this interface is to ask the vendor IOMMU driver to check
>> whether each device/iommu in the domain supports dirty bit tracking.
>> But what will happen if new devices with different tracking capability
>> are added afterward?
> Yep, this is considered in the vfio part. We will query again after attaching or
> detaching devices from the domain.  When the domain becomes capable, we enable
> dirty log for it. When it becomes not capable, we disable dirty log for it.

If that's the case, why not putting this logic in the iommu subsystem so
that it doesn't need to be duplicate in different upper layers?

For example, add something like dirty_page_trackable in the struct of
iommu_domain and ask the vendor iommu driver to update it once any
device is added/removed to/from the domain. It's also better to disallow
any domain attach/detach once the dirty page tracking is on.

> 
>> To make things simple, is it possible to support this tracking only when
>> all underlying IOMMUs support dirty bit tracking?
> IIUC, all underlying IOMMUs you refer is of system wide. I think this idea may has
> two issues. 1) The target domain may just contains part of system IOMMUs. 2) The
> dirty tracking capability can be related to the capability of devices. For example,
> we can track dirty log based on IOPF, which needs the capability of devices. That's
> to say, we can make this framework more common.

Yes. Fair enough. Thanks for sharing.

> 
>> Or, the more crazy idea is that we don't need to check this capability
>> at all. If dirty bit tracking is not supported by hardware, just mark
>> all pages dirty?
> Yeah, I think this idea is nice:).
> 
> Still one concern is that we may have other dirty tracking methods in the future,
> if we can't track dirty through iommu, we can still try other methods.
> 
> If there is no interface to check this capability, we have no chance to try
> other methods. What do you think?
> 

Agreed.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
