Return-Path: <SRS0=gpU2=JR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EFCBC43460
	for <iommu@archiver.kernel.org>; Tue, 20 Apr 2021 08:03:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF07A613C4
	for <iommu@archiver.kernel.org>; Tue, 20 Apr 2021 08:03:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF07A613C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4E0CF404C8;
	Tue, 20 Apr 2021 08:03:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ye6GYPtWwtwJ; Tue, 20 Apr 2021 08:03:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 25AA840457;
	Tue, 20 Apr 2021 08:03:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E8886C000E;
	Tue, 20 Apr 2021 08:03:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E0A5FC000B
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 08:03:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B657283455
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 08:03:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id q7SRE1QOON6Y for <iommu@lists.linux-foundation.org>;
 Tue, 20 Apr 2021 08:03:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D975283A56
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 08:03:30 +0000 (UTC)
IronPort-SDR: +y4Fjkuv+00YIaCxKa+UGGGTI4NNG8BhyB66tyypII1uryz/DjNv1lFMgbDL2FaV1AUrvdlIzt
 xeOEm2nBv5Tg==
X-IronPort-AV: E=McAfee;i="6200,9189,9959"; a="195579333"
X-IronPort-AV: E=Sophos;i="5.82,236,1613462400"; d="scan'208";a="195579333"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Apr 2021 01:03:28 -0700
IronPort-SDR: Z/FXrr1+Q8RHYWYTPCkRgeeVNOB0M1lOdZtfcdF5lOyNzlNN1zJuhw7h+LSq846Ny0wAAABWVv
 KsyxWlidK47A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,236,1613462400"; d="scan'208";a="426828770"
Received: from allen-box.sh.intel.com (HELO [10.239.159.128])
 ([10.239.159.128])
 by orsmga008.jf.intel.com with ESMTP; 20 Apr 2021 01:03:24 -0700
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
 <3c34baf1-6a57-5666-38a2-0c9d6188b8b8@linux.intel.com>
 <a09830f8-b08f-9b80-8f75-17f13088ff6d@huawei.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <8a25f78b-9153-d21b-013d-d7f64ab48c54@linux.intel.com>
Date: Tue, 20 Apr 2021 15:53:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <a09830f8-b08f-9b80-8f75-17f13088ff6d@huawei.com>
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

On 4/20/21 3:32 PM, Keqian Zhu wrote:
> Hi Baolu,
> 
> Cheers for the your quick reply.
> 
> On 2021/4/20 10:09, Lu Baolu wrote:
>> Hi Keqian,
>>
>> On 4/20/21 9:25 AM, Keqian Zhu wrote:
>>> Hi Baolu,
>>>
>>> On 2021/4/19 21:33, Lu Baolu wrote:
>>>> Hi Keqian,
>>>>
>>>> On 2021/4/19 17:32, Keqian Zhu wrote:
>>>>>>> +EXPORT_SYMBOL_GPL(iommu_split_block);
>>>>>> Do you really have any consumers of this interface other than the dirty
>>>>>> bit tracking? If not, I don't suggest to make this as a generic IOMMU
>>>>>> interface.
>>>>>>
>>>>>> There is an implicit requirement for such interfaces. The
>>>>>> iommu_map/unmap(iova, size) shouldn't be called at the same time.
>>>>>> Currently there's no such sanity check in the iommu core. A poorly
>>>>>> written driver could mess up the kernel by misusing this interface.
>>>>> Yes, I don't think up a scenario except dirty tracking.
>>>>>
>>>>> Indeed, we'd better not make them as a generic interface.
>>>>>
>>>>> Do you have any suggestion that underlying iommu drivers can share these code but
>>>>> not make it as a generic iommu interface?
>>>>>
>>>>> I have a not so good idea. Make the "split" interfaces as a static function, and
>>>>> transfer the function pointer to start_dirty_log. But it looks weird and inflexible.
>>>>
>>>> I understand splitting/merging super pages is an optimization, but not a
>>>> functional requirement. So is it possible to let the vendor iommu driver
>>>> decide whether splitting super pages when starting dirty bit tracking
>>>> and the opposite operation during when stopping it? The requirement for
>>> Right. If I understand you correct, actually that is what this series does.
>>
>> I mean to say no generic APIs, jut do it by the iommu subsystem itself.
>> It's totally transparent to the upper level, just like what map() does.
>> The upper layer doesn't care about either super page or small page is
>> in use when do a mapping, right?
>>
>> If you want to consolidate some code, how about putting them in
>> start/stop_tracking()?
> 
> Yep, this reminds me. What we want to reuse is the logic of "chunk by chunk" in split().
> We can implement switch_dirty_log to be "chunk by chunk" too (just the same as sync/clear),
> then the vendor iommu driver can invoke it's own private implementation of split().
> So we can completely remove split() in the IOMMU core layer.
> 
> example code logic
> 
> iommu.c:
> switch_dirty_log(big range) {
>      for_each_iommu_page(big range) {
>            ops->switch_dirty_log(iommu_pgsize)
>      }
> }
> 
> vendor iommu driver:
> switch_dirty_log(iommu_pgsize) {
> 
>      if (enable) {
>          ops->split_block(iommu_pgsize)
>          /* And other actions, such as enable hardware capability */
>      } else {
>          for_each_continuous_physical_address(iommu_pgsize)
>              ops->merge_page()
>      }
> }
> 
> Besides, vendor iommu driver can invoke split() in clear_dirty_log instead of in switch_dirty_log.
> The benefit is that we usually clear dirty log gradually during dirty tracking, then we can split
> large page mapping gradually, which speedup start_dirty_log and make less side effect on DMA performance.
> 
> Does it looks good for you?

Yes. It's clearer now.

> 
> Thanks,
> Keqian
> 

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
