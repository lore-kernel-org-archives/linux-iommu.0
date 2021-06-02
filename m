Return-Path: <SRS0=kThj=K4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_NONE,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A5D2C4708F
	for <iommu@archiver.kernel.org>; Wed,  2 Jun 2021 04:38:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B713E61182
	for <iommu@archiver.kernel.org>; Wed,  2 Jun 2021 04:38:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B713E61182
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7199E606CA;
	Wed,  2 Jun 2021 04:38:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EwCKpLBN6qmi; Wed,  2 Jun 2021 04:38:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 38579605D8;
	Wed,  2 Jun 2021 04:38:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 129E3C000D;
	Wed,  2 Jun 2021 04:38:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 61166C0001
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 04:38:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4212960641
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 04:38:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8SFn_YTGGd-f for <iommu@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 04:38:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 968F1605D8
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 04:38:38 +0000 (UTC)
IronPort-SDR: BjrD5qwlf8SFnJrvN2eEY6cKh6+ZXg6UGZoFwKByGV5MKb0VgSNyeDH79H/XWICTlb+HRFLkM+
 Io4bR3aKrnCw==
X-IronPort-AV: E=McAfee;i="6200,9189,10002"; a="289327961"
X-IronPort-AV: E=Sophos;i="5.83,241,1616482800"; d="scan'208";a="289327961"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jun 2021 21:38:36 -0700
IronPort-SDR: WnxDIDJVtYV3cqi62LfVUsTHx0jekxNgcPoporyzqfr3Kmq/YTcQXgtBigUP9h1PnoepDUO6vb
 CcHBzb8MVLZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,241,1616482800"; d="scan'208";a="633098715"
Received: from allen-box.sh.intel.com (HELO [10.239.159.105])
 ([10.239.159.105])
 by fmsmga006.fm.intel.com with ESMTP; 01 Jun 2021 21:38:34 -0700
Subject: Re: [PATCH v3 0/7] iommu: Allow IOVA rcache range be configured
To: John Garry <john.garry@huawei.com>, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com
References: <1622557781-211697-1-git-send-email-john.garry@huawei.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <834ad35a-7310-1738-7d17-7c061ca73e4c@linux.intel.com>
Date: Wed, 2 Jun 2021 12:37:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1622557781-211697-1-git-send-email-john.garry@huawei.com>
Content-Language: en-US
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 linuxarm@huawei.com
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

On 6/1/21 10:29 PM, John Garry wrote:
> For streaming DMA mappings involving an IOMMU and whose IOVA len regularly
> exceeds the IOVA rcache upper limit (meaning that they are not cached),
> performance can be reduced.
> 
> This is much more pronounced from commit 4e89dce72521 ("iommu/iova: Retry
> from last rb tree node if iova search fails"), as discussed at [0].
> 
> IOVAs which cannot be cached are highly involved in the IOVA ageing issue,
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
> updated, i.e. must unbind the only device in the group first.

Could you explain why it requires singleton group and driver unbinding
if the user only wants to increase the upper limit? I haven't dived into
the details yet, sorry if this is a silly question.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
