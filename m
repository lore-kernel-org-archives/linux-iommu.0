Return-Path: <SRS0=AxcK=KG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53412C43461
	for <iommu@archiver.kernel.org>; Tue, 11 May 2021 07:40:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D71DA61926
	for <iommu@archiver.kernel.org>; Tue, 11 May 2021 07:40:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D71DA61926
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7C99A843A5;
	Tue, 11 May 2021 07:40:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bk5ksRCgd1PN; Tue, 11 May 2021 07:40:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4196984359;
	Tue, 11 May 2021 07:40:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 16DE3C000E;
	Tue, 11 May 2021 07:40:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5C704C0001
 for <iommu@lists.linux-foundation.org>; Tue, 11 May 2021 07:40:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3CA214056C
 for <iommu@lists.linux-foundation.org>; Tue, 11 May 2021 07:40:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WodwidIcBV0B for <iommu@lists.linux-foundation.org>;
 Tue, 11 May 2021 07:40:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7B94440564
 for <iommu@lists.linux-foundation.org>; Tue, 11 May 2021 07:40:17 +0000 (UTC)
Received: from dggeml764-chm.china.huawei.com (unknown [172.30.72.55])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FfV8c1LbKzWhXN;
 Tue, 11 May 2021 15:36:00 +0800 (CST)
Received: from dggpemm000003.china.huawei.com (7.185.36.128) by
 dggeml764-chm.china.huawei.com (10.1.199.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 11 May 2021 15:40:13 +0800
Received: from [10.174.187.224] (10.174.187.224) by
 dggpemm000003.china.huawei.com (7.185.36.128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 11 May 2021 15:40:13 +0800
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
From: Keqian Zhu <zhukeqian1@huawei.com>
Message-ID: <60182a35-e151-7150-3708-4e58dd8e78da@huawei.com>
Date: Tue, 11 May 2021 15:40:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <f47e90c6-f3c4-b28f-a810-e03afe79e62d@linux.intel.com>
X-Originating-IP: [10.174.187.224]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

Hi Baolu,

On 2021/5/11 11:12, Lu Baolu wrote:
> Hi Keqian,
> 
> On 5/10/21 7:07 PM, Keqian Zhu wrote:
>>>>> I suppose this interface is to ask the vendor IOMMU driver to check
>>>>> whether each device/iommu in the domain supports dirty bit tracking.
>>>>> But what will happen if new devices with different tracking capability
>>>>> are added afterward?
>>>> Yep, this is considered in the vfio part. We will query again after attaching or
>>>> detaching devices from the domain.  When the domain becomes capable, we enable
>>>> dirty log for it. When it becomes not capable, we disable dirty log for it.
>>> If that's the case, why not putting this logic in the iommu subsystem so
>>> that it doesn't need to be duplicate in different upper layers?
>>>
>>> For example, add something like dirty_page_trackable in the struct of
>>> iommu_domain and ask the vendor iommu driver to update it once any
>>> device is added/removed to/from the domain. It's also better to disallow
>> If we do it, the upper layer still needs to query the capability from domain and switch
>> dirty log tracking for it. Or do you mean the domain can switch dirty log tracking automatically
>> when its capability change? If so, I think we're lack of some flexibility. The upper layer
>> may have it's own policy, such as only enable dirty log tracking when all domains are capable,
>> and disable dirty log tracking when just one domain is not capable.
> 
> I may not get you.
> 
> Assume that dirty_page_trackable is an attribution of an iommu_domain.
> This attribution might be changed once a new device (with different
> capability) added or removed. So it should be updated every time a new
> device is attached or detached. This work could be done by the vendor
> iommu driver on the path of dev_attach/dev_detach callback.
Yes, this is what I understand you.

> 
> For upper layers, before starting page tracking, they check the
> dirty_page_trackable attribution of the domain and start it only it's
> capable. Once the page tracking is switched on the vendor iommu driver
> (or iommu core) should block further device attach/detach operations
> until page tracking is stopped.
But when a domain becomes capable after detaching a device, the upper layer
still needs to query it and enable dirty log for it...

To make things coordinated, maybe the upper layer can register a notifier,
when the domain's capability change, the upper layer do not need to query, instead
they just need to realize a callback, and do their specific policy in the callback.
What do you think?

> 
>>
>>> any domain attach/detach once the dirty page tracking is on.
>> Yep, this can greatly simplify our code logic, but I don't know whether our maintainers
>> agree that, as they may think that IOMMU dirty logging should not change original domain
>> behaviors.
> 
> The maintainer owns the last word, but we need to work out a generic and
> self-contained API set.
OK, I see.

Thanks,
Keqian
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
