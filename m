Return-Path: <SRS0=YXze=KI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8995C433B4
	for <iommu@archiver.kernel.org>; Thu, 13 May 2021 10:58:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C50D611BE
	for <iommu@archiver.kernel.org>; Thu, 13 May 2021 10:58:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C50D611BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A1AEF40E88;
	Thu, 13 May 2021 10:58:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XRqBTl_hHg5d; Thu, 13 May 2021 10:58:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4A3E34053E;
	Thu, 13 May 2021 10:58:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 12973C000D;
	Thu, 13 May 2021 10:58:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 21652C0001
 for <iommu@lists.linux-foundation.org>; Thu, 13 May 2021 10:58:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 04D33401C3
 for <iommu@lists.linux-foundation.org>; Thu, 13 May 2021 10:58:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9KiUwgWrCAws for <iommu@lists.linux-foundation.org>;
 Thu, 13 May 2021 10:58:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4CC76403B7
 for <iommu@lists.linux-foundation.org>; Thu, 13 May 2021 10:58:09 +0000 (UTC)
Received: from dggeml712-chm.china.huawei.com (unknown [172.30.72.54])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FgpV05v16zYhMv;
 Thu, 13 May 2021 18:55:36 +0800 (CST)
Received: from dggpemm000003.china.huawei.com (7.185.36.128) by
 dggeml712-chm.china.huawei.com (10.3.17.123) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Thu, 13 May 2021 18:58:05 +0800
Received: from [10.174.187.224] (10.174.187.224) by
 dggpemm000003.china.huawei.com (7.185.36.128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 13 May 2021 18:58:04 +0800
Subject: Re: [RFC PATCH v4 01/13] iommu: Introduce dirty log tracking framework
To: Lu Baolu <baolu.lu@linux.intel.com>, <linux-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux-foundation.org>,
 Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>, "Joerg
 Roedel" <joro@8bytes.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Yi Sun <yi.y.sun@linux.intel.com>, Tian Kevin <kevin.tian@intel.com>
References: <20210507102211.8836-1-zhukeqian1@huawei.com>
 <20210507102211.8836-2-zhukeqian1@huawei.com>
 <efc2d868-28ba-8ed9-1d6b-610b67d671b5@linux.intel.com>
 <18ac787a-179e-71f7-728b-c43feda80a16@huawei.com>
 <55fda826-9ab6-a3a0-b17e-a4d4879f00bc@linux.intel.com>
 <a8df289a-47c2-c193-cd6f-8415f68b900f@huawei.com>
 <f47e90c6-f3c4-b28f-a810-e03afe79e62d@linux.intel.com>
 <60182a35-e151-7150-3708-4e58dd8e78da@huawei.com>
 <36cc7267-6aa3-db54-b08c-c2dfc0bbacb6@linux.intel.com>
 <e38f1837-b814-3717-2faf-4df8349cb57c@huawei.com>
 <7fb678c7-509b-dbb5-d533-32c5ce2a0476@linux.intel.com>
From: Keqian Zhu <zhukeqian1@huawei.com>
Message-ID: <bbc1960c-24f3-680a-b6ff-c81f70fa9c04@huawei.com>
Date: Thu, 13 May 2021 18:58:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <7fb678c7-509b-dbb5-d533-32c5ce2a0476@linux.intel.com>
X-Originating-IP: [10.174.187.224]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm000003.china.huawei.com (7.185.36.128)
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



On 2021/5/12 19:36, Lu Baolu wrote:
> Hi keqian,
> 
> On 5/12/21 4:44 PM, Keqian Zhu wrote:
>>
>>
>> On 2021/5/12 11:20, Lu Baolu wrote:
>>> On 5/11/21 3:40 PM, Keqian Zhu wrote:
>>>>> For upper layers, before starting page tracking, they check the
>>>>> dirty_page_trackable attribution of the domain and start it only it's
>>>>> capable. Once the page tracking is switched on the vendor iommu driver
>>>>> (or iommu core) should block further device attach/detach operations
>>>>> until page tracking is stopped.
>>>> But when a domain becomes capable after detaching a device, the upper layer
>>>> still needs to query it and enable dirty log for it...
>>>>
>>>> To make things coordinated, maybe the upper layer can register a notifier,
>>>> when the domain's capability change, the upper layer do not need to query, instead
>>>> they just need to realize a callback, and do their specific policy in the callback.
>>>> What do you think?
>>>>
>>>
>>> That might be an option. But why not checking domain's attribution every
>>> time a new tracking period is about to start?
>> Hi Baolu,
>>
>> I'll add an attribution in iommu_domain, and the vendor iommu driver will update
>> the attribution when attach/detach devices.
>>
>> The attribute should be protected by a lock, so the upper layer shouldn't access
>> the attribute directly. Then the iommu_domain_support_dirty_log() still should be
>> retained. Does this design looks good to you?
> 
> Yes, that's what I was thinking of. But I am not sure whether it worth
> of a lock here. It seems not to be a valid behavior for upper layer to
> attach or detach any device while doing the dirty page tracking.
Hi Baolu,

Right, if the "detach|attach" interfaces and "dirty tracking" interfaces can be called concurrently,
a lock in iommu_domain_support_dirty_log() is still not enough. I will add another note for the dirty
tracking interfaces.

Do you have other suggestions? I will accelerate the progress, so I plan to send out v5 next week.

Thanks,
Keqian
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
