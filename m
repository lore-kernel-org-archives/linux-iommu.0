Return-Path: <SRS0=soV1=JQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A41C433ED
	for <iommu@archiver.kernel.org>; Mon, 19 Apr 2021 02:09:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B0D7610E9
	for <iommu@archiver.kernel.org>; Mon, 19 Apr 2021 02:09:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B0D7610E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CA6044011B;
	Mon, 19 Apr 2021 02:09:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 93NTPf9X77OI; Mon, 19 Apr 2021 02:09:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id B9A3A400C0;
	Mon, 19 Apr 2021 02:09:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8DF93C000E;
	Mon, 19 Apr 2021 02:09:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 48C73C000B
 for <iommu@lists.linux-foundation.org>; Mon, 19 Apr 2021 02:09:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 28745600D1
 for <iommu@lists.linux-foundation.org>; Mon, 19 Apr 2021 02:09:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id b_31d2dLWqVP for <iommu@lists.linux-foundation.org>;
 Mon, 19 Apr 2021 02:09:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 89F66600C6
 for <iommu@lists.linux-foundation.org>; Mon, 19 Apr 2021 02:09:22 +0000 (UTC)
IronPort-SDR: OLRB/RwpdjqZR/6aw1RhvYxcFvWsts29FQNMJHqT7/b+Ydmkpqo2g0rc37XudOkra9REzeymhs
 uiD5jho7rtzg==
X-IronPort-AV: E=McAfee;i="6200,9189,9958"; a="182750345"
X-IronPort-AV: E=Sophos;i="5.82,232,1613462400"; d="scan'208";a="182750345"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Apr 2021 19:09:21 -0700
IronPort-SDR: zxuHjgLbcM9BtCHqQCZ13ZYmO7rMenKxwRxWp6ygS8GE0+VyAbOHSkgSEuqzA05JJwQLR+P5AF
 LRu1uAXt3CzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,232,1613462400"; d="scan'208";a="426330304"
Received: from allen-box.sh.intel.com (HELO [10.239.159.128])
 ([10.239.159.128])
 by orsmga008.jf.intel.com with ESMTP; 18 Apr 2021 19:09:17 -0700
Subject: Re: [PATCH v3 01/12] iommu: Introduce dirty log tracking framework
To: Keqian Zhu <zhukeqian1@huawei.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org,
 Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
 Joerg Roedel <joro@8bytes.org>, Yi Sun <yi.y.sun@linux.intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Tian Kevin <kevin.tian@intel.com>
References: <20210413085457.25400-1-zhukeqian1@huawei.com>
 <20210413085457.25400-2-zhukeqian1@huawei.com>
 <fe337950-f8d0-3d21-a7b1-98b385d71f3e@linux.intel.com>
 <e42373e3-10d5-5a34-8f33-8bb82d64fb19@huawei.com>
 <56b001fa-b4fe-c595-dc5e-f362d2f07a19@linux.intel.com>
 <88cba608-2f22-eb83-f22e-50cb547b6ee8@huawei.com>
 <2c01425f-813c-4278-ba06-26d651496a5c@linux.intel.com>
 <64c87f67-3687-61bd-1587-724cc2f9cc97@huawei.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <4e7ae083-08f5-b273-f873-21a2960ea68a@linux.intel.com>
Date: Mon, 19 Apr 2021 09:59:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <64c87f67-3687-61bd-1587-724cc2f9cc97@huawei.com>
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

On 4/16/21 5:07 PM, Keqian Zhu wrote:
>> I am worrying about having two sets of APIs for single purpose. From
>> vendor iommu driver's point of view, this feature is per device. Hence,
>> it still needs to do the same thing.
> Yes, we can unify the granule of feature reporting and status management.
> 
> The basic granule of dirty tracking is iommu_domain, I think it's very reasonable. We need an
> interface to report the feature of iommu_domain, then the logic is much more clear.
> 
> Every time we add new device or remove device from the domain, we should update the feature (e.g.,
> maintain a counter of unsupported devices).

Yes. This looks cleaner.

> 
> What do you think about this idea?
> 
> Thanks,
> Keqian

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
