Return-Path: <SRS0=gpU2=JR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC91C433ED
	for <iommu@archiver.kernel.org>; Tue, 20 Apr 2021 02:19:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55A09613AB
	for <iommu@archiver.kernel.org>; Tue, 20 Apr 2021 02:19:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55A09613AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0C19C607C2;
	Tue, 20 Apr 2021 02:19:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zfCudKPIpB7I; Tue, 20 Apr 2021 02:18:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id D58926067E;
	Tue, 20 Apr 2021 02:18:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B7BD4C000E;
	Tue, 20 Apr 2021 02:18:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 183B2C000B
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 02:18:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F0B44606BB
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 02:18:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id COfYPVleH2iy for <iommu@lists.linux-foundation.org>;
 Tue, 20 Apr 2021 02:18:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B97736067E
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 02:18:56 +0000 (UTC)
IronPort-SDR: 6HRFsSxOoUETUFihBYKWiAKeVnYe0kxGq/84EiFvpGNbSA+RujMp/Nb0Wd25FQi+gdyi1MwrkB
 qXZiwUK6aGXQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9959"; a="182923690"
X-IronPort-AV: E=Sophos;i="5.82,235,1613462400"; d="scan'208";a="182923690"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Apr 2021 19:18:55 -0700
IronPort-SDR: fj3nSR0UD0M+1ZmhfSfTPFQayhH08zsxu5MyYhCrQgQEfLxxYiko6p5L+7/2ovmkyzaVaw/6FT
 LJTZBxoOLAMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,235,1613462400"; d="scan'208";a="426737090"
Received: from allen-box.sh.intel.com (HELO [10.239.159.128])
 ([10.239.159.128])
 by orsmga008.jf.intel.com with ESMTP; 19 Apr 2021 19:18:50 -0700
Subject: Re: [PATCH v3 02/12] iommu: Add iommu_split_block interface
To: Keqian Zhu <zhukeqian1@huawei.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org,
 Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
 Joerg Roedel <joro@8bytes.org>, Yi Sun <yi.y.sun@linux.intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Tian Kevin <kevin.tian@intel.com>
References: <20210413085457.25400-1-zhukeqian1@huawei.com>
 <20210413085457.25400-3-zhukeqian1@huawei.com>
 <fb350f27-be8b-80bf-1ce8-e7e8aba26f02@linux.intel.com>
 <491da550-dc54-42e6-ac91-13d411575fad@huawei.com>
 <bc2da48b-f4f7-5a46-2696-2c412a83d190@linux.intel.com>
 <ac966fbc-7bc6-9d88-e53e-bcd92d536fdb@huawei.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <3c34baf1-6a57-5666-38a2-0c9d6188b8b8@linux.intel.com>
Date: Tue, 20 Apr 2021 10:09:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <ac966fbc-7bc6-9d88-e53e-bcd92d536fdb@huawei.com>
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

On 4/20/21 9:25 AM, Keqian Zhu wrote:
> Hi Baolu,
> 
> On 2021/4/19 21:33, Lu Baolu wrote:
>> Hi Keqian,
>>
>> On 2021/4/19 17:32, Keqian Zhu wrote:
>>>>> +EXPORT_SYMBOL_GPL(iommu_split_block);
>>>> Do you really have any consumers of this interface other than the dirty
>>>> bit tracking? If not, I don't suggest to make this as a generic IOMMU
>>>> interface.
>>>>
>>>> There is an implicit requirement for such interfaces. The
>>>> iommu_map/unmap(iova, size) shouldn't be called at the same time.
>>>> Currently there's no such sanity check in the iommu core. A poorly
>>>> written driver could mess up the kernel by misusing this interface.
>>> Yes, I don't think up a scenario except dirty tracking.
>>>
>>> Indeed, we'd better not make them as a generic interface.
>>>
>>> Do you have any suggestion that underlying iommu drivers can share these code but
>>> not make it as a generic iommu interface?
>>>
>>> I have a not so good idea. Make the "split" interfaces as a static function, and
>>> transfer the function pointer to start_dirty_log. But it looks weird and inflexible.
>>
>> I understand splitting/merging super pages is an optimization, but not a
>> functional requirement. So is it possible to let the vendor iommu driver
>> decide whether splitting super pages when starting dirty bit tracking
>> and the opposite operation during when stopping it? The requirement for
> Right. If I understand you correct, actually that is what this series does.

I mean to say no generic APIs, jut do it by the iommu subsystem itself.
It's totally transparent to the upper level, just like what map() does.
The upper layer doesn't care about either super page or small page is
in use when do a mapping, right?

If you want to consolidate some code, how about putting them in
start/stop_tracking()?

Best regards,
baolu

> We realized split/merge in IOMMU core layer, but don't force vendor driver to use it.
> 
> The problem is that when we expose these interfaces to vendor IOMMU driver, will also
> expose them to upper driver.
> 
>> upper layer is that starting/stopping dirty bit tracking and
>> mapping/unmapping are mutually exclusive.
> OK, I will explicitly add the hints. Thanks.
> 
> Thanks,
> Keqian
>>
>>>
>>> On the other hand, if a driver calls map/unmap with split/merge at the same time,
>>> it's a bug of driver, it should follow the rule.
>>>
>>
>> Best regards,
>> baolu
>> .
>>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
