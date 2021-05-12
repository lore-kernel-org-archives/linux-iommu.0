Return-Path: <SRS0=CJHf=KH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21CACC433B4
	for <iommu@archiver.kernel.org>; Wed, 12 May 2021 11:37:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 718C8613E9
	for <iommu@archiver.kernel.org>; Wed, 12 May 2021 11:37:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 718C8613E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EAA6360753;
	Wed, 12 May 2021 11:37:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id O89w9elMIAY1; Wed, 12 May 2021 11:37:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id D64466071D;
	Wed, 12 May 2021 11:37:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BC3FBC000E;
	Wed, 12 May 2021 11:37:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C43DFC0001
 for <iommu@lists.linux-foundation.org>; Wed, 12 May 2021 11:37:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B310760753
 for <iommu@lists.linux-foundation.org>; Wed, 12 May 2021 11:37:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id g_1MSn-kMGCA for <iommu@lists.linux-foundation.org>;
 Wed, 12 May 2021 11:37:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2BDC76071D
 for <iommu@lists.linux-foundation.org>; Wed, 12 May 2021 11:37:02 +0000 (UTC)
IronPort-SDR: D0OCSk8yGrM0MuGNsyy3Gak7S2sXzHmIOjDczgw+ygc7i8L84oaJgZdUDMCDiL6fK1uCLsEyBZ
 pig/1IFo6iSw==
X-IronPort-AV: E=McAfee;i="6200,9189,9981"; a="285185307"
X-IronPort-AV: E=Sophos;i="5.82,293,1613462400"; d="scan'208";a="285185307"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2021 04:37:01 -0700
IronPort-SDR: /H5FLzSrZq+cwNz0Azt92onxkumHrnfiBrY3Lf5zJuvazIodXgHxSAY4WCiCCFCq8gbo3W8m6h
 rUxD+mRhMjiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,293,1613462400"; d="scan'208";a="622372334"
Received: from allen-box.sh.intel.com (HELO [10.239.159.128])
 ([10.239.159.128])
 by fmsmga006.fm.intel.com with ESMTP; 12 May 2021 04:36:57 -0700
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
 <55fda826-9ab6-a3a0-b17e-a4d4879f00bc@linux.intel.com>
 <a8df289a-47c2-c193-cd6f-8415f68b900f@huawei.com>
 <f47e90c6-f3c4-b28f-a810-e03afe79e62d@linux.intel.com>
 <60182a35-e151-7150-3708-4e58dd8e78da@huawei.com>
 <36cc7267-6aa3-db54-b08c-c2dfc0bbacb6@linux.intel.com>
 <e38f1837-b814-3717-2faf-4df8349cb57c@huawei.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <7fb678c7-509b-dbb5-d533-32c5ce2a0476@linux.intel.com>
Date: Wed, 12 May 2021 19:36:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <e38f1837-b814-3717-2faf-4df8349cb57c@huawei.com>
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

Hi keqian,

On 5/12/21 4:44 PM, Keqian Zhu wrote:
> 
> 
> On 2021/5/12 11:20, Lu Baolu wrote:
>> On 5/11/21 3:40 PM, Keqian Zhu wrote:
>>>> For upper layers, before starting page tracking, they check the
>>>> dirty_page_trackable attribution of the domain and start it only it's
>>>> capable. Once the page tracking is switched on the vendor iommu driver
>>>> (or iommu core) should block further device attach/detach operations
>>>> until page tracking is stopped.
>>> But when a domain becomes capable after detaching a device, the upper layer
>>> still needs to query it and enable dirty log for it...
>>>
>>> To make things coordinated, maybe the upper layer can register a notifier,
>>> when the domain's capability change, the upper layer do not need to query, instead
>>> they just need to realize a callback, and do their specific policy in the callback.
>>> What do you think?
>>>
>>
>> That might be an option. But why not checking domain's attribution every
>> time a new tracking period is about to start?
> Hi Baolu,
> 
> I'll add an attribution in iommu_domain, and the vendor iommu driver will update
> the attribution when attach/detach devices.
> 
> The attribute should be protected by a lock, so the upper layer shouldn't access
> the attribute directly. Then the iommu_domain_support_dirty_log() still should be
> retained. Does this design looks good to you?

Yes, that's what I was thinking of. But I am not sure whether it worth
of a lock here. It seems not to be a valid behavior for upper layer to
attach or detach any device while doing the dirty page tracking.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
