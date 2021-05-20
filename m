Return-Path: <SRS0=ObaZ=KP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D118BC433B4
	for <iommu@archiver.kernel.org>; Thu, 20 May 2021 08:29:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53650610A2
	for <iommu@archiver.kernel.org>; Thu, 20 May 2021 08:29:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53650610A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 108DC83C59;
	Thu, 20 May 2021 08:29:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wZ6f3-YF8RRA; Thu, 20 May 2021 08:29:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id DF55E83C33;
	Thu, 20 May 2021 08:29:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B1693C000D;
	Thu, 20 May 2021 08:29:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3D2A4C0001
 for <iommu@lists.linux-foundation.org>; Thu, 20 May 2021 08:29:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 23D7383C3F
 for <iommu@lists.linux-foundation.org>; Thu, 20 May 2021 08:29:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id E7TzJPr1QQvl for <iommu@lists.linux-foundation.org>;
 Thu, 20 May 2021 08:29:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by smtp1.osuosl.org (Postfix) with ESMTPS id ACFB883C33
 for <iommu@lists.linux-foundation.org>; Thu, 20 May 2021 08:29:50 +0000 (UTC)
Received: from dggems701-chm.china.huawei.com (unknown [172.30.72.59])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Fm2sJ2V8WzkY72;
 Thu, 20 May 2021 16:27:00 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 dggems701-chm.china.huawei.com (10.3.19.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 20 May 2021 16:29:46 +0800
Received: from [10.47.87.246] (10.47.87.246) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Thu, 20 May
 2021 09:29:42 +0100
Subject: Re: [PATCH v2 00/15] dma mapping/iommu: Allow IOMMU IOVA rcache range
 to be configured
To: <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
 <hch@lst.de>, <m.szyprowski@samsung.com>
References: <1620656249-68890-1-git-send-email-john.garry@huawei.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <42aff9e5-096c-f47d-60f5-08cd39152c1c@huawei.com>
Date: Thu, 20 May 2021 09:28:36 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <1620656249-68890-1-git-send-email-john.garry@huawei.com>
Content-Language: en-US
X-Originating-IP: [10.47.87.246]
X-ClientProxiedBy: lhreml745-chm.china.huawei.com (10.201.108.195) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: iommu@lists.linux-foundation.org, linuxarm@huawei.com,
 linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
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

On 10/05/2021 15:17, John Garry wrote:

Hi Robin, guys,

A friendly reminder on this one...

Thanks

> For streaming DMA mappings involving an IOMMU and whose IOVA len regularly
> exceeds the IOVA rcache upper limit (meaning that they are not cached),
> performance can be reduced.
> 
> This is much more pronounced from commit 4e89dce72521 ("iommu/iova: Retry
> from last rb tree node if iova search fails"), as discussed at [0].
> 
> IOVAs which cannot be cached are highly involved in the IOVA aging issue,
> as discussed at [1].
> 
> This series allows the IOVA rcache range be configured, so that we may
> cache all IOVAs per domain, thus improving performance.
> 
> A new IOMMU group sysfs file is added - max_opt_dma_size - which is used
> indirectly to configure the IOVA rcache range:
> /sys/kernel/iommu_groups/X/max_opt_dma_size
> 
> This file is updated same as how the IOMMU group default domain type is
> updated, i.e. must unbind the only device in the group first. However, the
> IOMMU default domain is reallocated in the device driver reprobe, and not
> immediately.
> 
> In addition, we keep (from v1 series) the DMA mapping API to allow DMA max
> optimised size be set from a LLDD. How it works is a lot different. When
> the LLDD calls this during probe, once the value is successfully recorded, we
> return -EDEFER_PROBE. In the reprobe, the IOMM group default domain is
> reallocated, and the new IOVA domain rcache upper limit is set according
> to that DMA max optimised size. As such, we don't operate on a live IOMMU
> domain.
> 
> Note that the DMA mapping API frontend is not strictly required, but saves
> the LLDD calling IOMMU APIs directly, that being not preferred.
> 
> Some figures for storage scenario:
> v5.13-rc1 baseline:			1200K IOPS
> With series:				1800K IOPS
> 
> All above are for IOMMU strict mode. Non-strict mode gives ~1800K IOPS in
> all scenarios.
> 
> Patch breakdown:
> 1-11: Add support for setting DMA max optimised size via sysfs
> 12-15: Add support for setting DMA max optimised size from LLDD
> 
> [0] https://lore.kernel.org/linux-iommu/20210129092120.1482-1-thunder.leizhen@huawei.com/
> [1] https://lore.kernel.org/linux-iommu/1607538189-237944-1-git-send-email-john.garry@huawei.com/
> 
> Differences to v1:
> - Many
> - Change method to not operate on a 'live' IOMMU domain:
> 	- rather, force device driver to be re-probed once
> 	  dma_max_opt_size is set, and reconfig a new IOMMU group then
> - Add iommu sysfs max_dma_opt_size file, and allow updating same as how
>    group type is changed
> 
> John Garry (15):
>    iommu: Reactor iommu_group_store_type()
>    iova: Allow rcache range upper limit to be flexible
>    iommu: Allow max opt DMA len be set for a group via sysfs
>    iommu: Add iommu_group_get_max_opt_dma_size()
>    iova: Add iova_domain_len_is_cached()
>    iommu: Allow iommu_change_dev_def_domain() realloc default domain for
>      same type
>    iommu: Add iommu_realloc_dev_group()
>    dma-iommu: Add iommu_reconfig_dev_group_dma()
>    iova: Add init_iova_domain_ext()
>    dma-iommu: Use init_iova_domain_ext() for IOVA domain init
>    dma-iommu: Reconfig group domain
>    iommu: Add iommu_set_dev_dma_opt_size()
>    dma-mapping: Add dma_set_max_opt_size()
>    dma-iommu: Add iommu_dma_set_opt_size()
>    scsi: hisi_sas: Set max optimal DMA size for v3 hw
> 
>   drivers/iommu/dma-iommu.c              |  51 +++++-
>   drivers/iommu/iommu.c                  | 231 +++++++++++++++++++------
>   drivers/iommu/iova.c                   |  61 +++++--
>   drivers/scsi/hisi_sas/hisi_sas_v3_hw.c |   5 +
>   include/linux/dma-iommu.h              |   4 +
>   include/linux/dma-map-ops.h            |   1 +
>   include/linux/dma-mapping.h            |   8 +
>   include/linux/iommu.h                  |  19 ++
>   include/linux/iova.h                   |  21 ++-
>   kernel/dma/mapping.c                   |  11 ++
>   10 files changed, 344 insertions(+), 68 deletions(-)
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
