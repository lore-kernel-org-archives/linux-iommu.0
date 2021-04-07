Return-Path: <SRS0=DRkM=JE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25966C433B4
	for <iommu@archiver.kernel.org>; Wed,  7 Apr 2021 08:31:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE2166139C
	for <iommu@archiver.kernel.org>; Wed,  7 Apr 2021 08:31:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE2166139C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7B9B0401FF;
	Wed,  7 Apr 2021 08:31:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id twRdy-pGOlUG; Wed,  7 Apr 2021 08:31:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 68837400BF;
	Wed,  7 Apr 2021 08:31:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 274CBC000B;
	Wed,  7 Apr 2021 08:31:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3456CC000A
 for <iommu@lists.linux-foundation.org>; Wed,  7 Apr 2021 08:31:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 14B5740F0F
 for <iommu@lists.linux-foundation.org>; Wed,  7 Apr 2021 08:31:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Lk6gt5QkdTLM for <iommu@lists.linux-foundation.org>;
 Wed,  7 Apr 2021 08:31:26 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B643440F0E
 for <iommu@lists.linux-foundation.org>; Wed,  7 Apr 2021 08:31:26 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 34F6F2A6; Wed,  7 Apr 2021 10:31:23 +0200 (CEST)
Date: Wed, 7 Apr 2021 10:31:21 +0200
From: Joerg Roedel <joro@8bytes.org>
To: John Garry <john.garry@huawei.com>
Subject: Re: [PATCH v2 0/4] iommu/iova: Add CPU hotplug handler to flush
 rcaches to core code
Message-ID: <YG1t2W3Inf+55KER@8bytes.org>
References: <1616675401-151997-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1616675401-151997-1-git-send-email-john.garry@huawei.com>
Cc: will@kernel.org, linuxarm@huawei.com, robin.murphy@arm.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 dwmw2@infradead.org
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

On Thu, Mar 25, 2021 at 08:29:57PM +0800, John Garry wrote:
> John Garry (4):
>   iova: Add CPU hotplug handler to flush rcaches
>   iommu/vt-d: Remove IOVA domain rcache flushing for CPU offlining
>   iommu: Delete iommu_dma_free_cpu_cached_iovas()
>   iommu: Stop exporting free_iova_fast()
> 
>  drivers/iommu/dma-iommu.c   |  9 ---------
>  drivers/iommu/intel/iommu.c | 31 -------------------------------
>  drivers/iommu/iova.c        | 34 +++++++++++++++++++++++++++++++---
>  include/linux/cpuhotplug.h  |  2 +-
>  include/linux/dma-iommu.h   |  8 --------
>  include/linux/iova.h        |  6 +-----
>  6 files changed, 33 insertions(+), 57 deletions(-)

Okay, newer version. Applied this one instead, thanks.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
