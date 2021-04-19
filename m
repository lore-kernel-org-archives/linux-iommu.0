Return-Path: <SRS0=soV1=JQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C46FBC433ED
	for <iommu@archiver.kernel.org>; Mon, 19 Apr 2021 13:34:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 233AA6113C
	for <iommu@archiver.kernel.org>; Mon, 19 Apr 2021 13:34:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 233AA6113C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B8AAB60A49;
	Mon, 19 Apr 2021 13:34:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WHLW1fFTn8Mm; Mon, 19 Apr 2021 13:34:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9ED8060718;
	Mon, 19 Apr 2021 13:34:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6C836C000F;
	Mon, 19 Apr 2021 13:34:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7BC6FC000B
 for <iommu@lists.linux-foundation.org>; Mon, 19 Apr 2021 13:34:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 57C7383841
 for <iommu@lists.linux-foundation.org>; Mon, 19 Apr 2021 13:34:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3OOwZRDCe58e for <iommu@lists.linux-foundation.org>;
 Mon, 19 Apr 2021 13:33:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7579F837C4
 for <iommu@lists.linux-foundation.org>; Mon, 19 Apr 2021 13:33:58 +0000 (UTC)
IronPort-SDR: PuT4drwBtgIyScGMm4jsr2HyfCUlnZHI2m+GJadHGSvvRO5UD1I5sgbJhJmAQhG4L6Gd6Pzlju
 Ttf2v3zYaR1A==
X-IronPort-AV: E=McAfee;i="6200,9189,9959"; a="280650672"
X-IronPort-AV: E=Sophos;i="5.82,234,1613462400"; d="scan'208";a="280650672"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Apr 2021 06:33:55 -0700
IronPort-SDR: 0i+wEhGbCQP8Avpf0xm0vMRCRN4QY7mcaZHGnZjD6+zAPyurprhJLO6MMtOQfxvnKw4hGQi5iT
 gQehU6KPWmxA==
X-IronPort-AV: E=Sophos;i="5.82,234,1613462400"; d="scan'208";a="426512252"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.210.121])
 ([10.254.210.121])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Apr 2021 06:33:51 -0700
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
From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v3 02/12] iommu: Add iommu_split_block interface
Message-ID: <bc2da48b-f4f7-5a46-2696-2c412a83d190@linux.intel.com>
Date: Mon, 19 Apr 2021 21:33:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <491da550-dc54-42e6-ac91-13d411575fad@huawei.com>
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

On 2021/4/19 17:32, Keqian Zhu wrote:
>>> +EXPORT_SYMBOL_GPL(iommu_split_block);
>> Do you really have any consumers of this interface other than the dirty
>> bit tracking? If not, I don't suggest to make this as a generic IOMMU
>> interface.
>>
>> There is an implicit requirement for such interfaces. The
>> iommu_map/unmap(iova, size) shouldn't be called at the same time.
>> Currently there's no such sanity check in the iommu core. A poorly
>> written driver could mess up the kernel by misusing this interface.
> Yes, I don't think up a scenario except dirty tracking.
> 
> Indeed, we'd better not make them as a generic interface.
> 
> Do you have any suggestion that underlying iommu drivers can share these code but
> not make it as a generic iommu interface?
> 
> I have a not so good idea. Make the "split" interfaces as a static function, and
> transfer the function pointer to start_dirty_log. But it looks weird and inflexible.

I understand splitting/merging super pages is an optimization, but not a
functional requirement. So is it possible to let the vendor iommu driver
decide whether splitting super pages when starting dirty bit tracking
and the opposite operation during when stopping it? The requirement for
upper layer is that starting/stopping dirty bit tracking and
mapping/unmapping are mutually exclusive.

> 
> On the other hand, if a driver calls map/unmap with split/merge at the same time,
> it's a bug of driver, it should follow the rule.
> 

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
