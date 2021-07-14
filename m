Return-Path: <SRS0=i+j8=MG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B97C07E9A
	for <iommu@archiver.kernel.org>; Wed, 14 Jul 2021 15:04:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5505A613C5
	for <iommu@archiver.kernel.org>; Wed, 14 Jul 2021 15:04:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5505A613C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0060683CBB;
	Wed, 14 Jul 2021 15:04:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qkTps4LTewbu; Wed, 14 Jul 2021 15:04:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id EDCBB83CA3;
	Wed, 14 Jul 2021 15:04:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 94B6AC001A;
	Wed, 14 Jul 2021 15:04:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B12E4C000E
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 14:24:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 92CCE83BFB
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 14:24:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pgaSQ9rQjEPg for <iommu@lists.linux-foundation.org>;
 Wed, 14 Jul 2021 14:24:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1DB6383BF8
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 14:24:36 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 57CFD61154;
 Wed, 14 Jul 2021 14:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1626272675;
 bh=uGr4g/Ee6pV+EYvldgWLzrmg2C688Tc8vlJSlq63pk8=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=cET9p+pZsUlfkwOTPAtB5/mDe7yDJsg4FzfZffrQRnOVuD0rYqFVb6ZeVscmNktjM
 bNA7IV3qJNt14ok7rAS5FJ3LfAXGNCKyl42bXGsyuyHfNyQIkBZURhjTYhGVDqTBSH
 TxgYKIosOSty1JV9snDp7ZdJ2NYRoq/gkKi0nMNIZMI7NA/frs3I90G5cVnZT1Cid6
 WIvbWsHG0zjCrPhEFXqGGcASjc9YI16y+p/Xh8ELeyNyhOoZo7e9/786yUHZUa6oAg
 Do/lYC41xrtfNZS757OeycCgPNWOg2pYEI3fjwaTGVfKxUaSRe6HSlXOboC0wLIOdF
 XC0EsUYXlRjdg==
Subject: Re: [PATCH v7 00/15] Optimizing iommu_[map/unmap] performance
To: Georgi Djakov <quic_c_gdjako@quicinc.com>, will@kernel.org,
 robin.murphy@arm.com
References: <1623850736-389584-1-git-send-email-quic_c_gdjako@quicinc.com>
From: Georgi Djakov <djakov@kernel.org>
Message-ID: <e6c8993e-353e-6a05-9b6d-9a49de471cb6@kernel.org>
Date: Wed, 14 Jul 2021 17:24:29 +0300
MIME-Version: 1.0
In-Reply-To: <1623850736-389584-1-git-send-email-quic_c_gdjako@quicinc.com>
Content-Language: en-US
X-Mailman-Approved-At: Wed, 14 Jul 2021 15:04:27 +0000
Cc: isaacm@codeaurora.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, pratikp@codeaurora.org,
 linux-arm-kernel@lists.infradead.org
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

On 16.06.21 16:38, Georgi Djakov wrote:
> When unmapping a buffer from an IOMMU domain, the IOMMU framework unmaps
> the buffer at a granule of the largest page size that is supported by
> the IOMMU hardware and fits within the buffer. For every block that
> is unmapped, the IOMMU framework will call into the IOMMU driver, and
> then the io-pgtable framework to walk the page tables to find the entry
> that corresponds to the IOVA, and then unmaps the entry.
> 
> This can be suboptimal in scenarios where a buffer or a piece of a
> buffer can be split into several contiguous page blocks of the same size.
> For example, consider an IOMMU that supports 4 KB page blocks, 2 MB page
> blocks, and 1 GB page blocks, and a buffer that is 4 MB in size is being
> unmapped at IOVA 0. The current call-flow will result in 4 indirect calls,
> and 2 page table walks, to unmap 2 entries that are next to each other in
> the page-tables, when both entries could have been unmapped in one shot
> by clearing both page table entries in the same call.
> 
> The same optimization is applicable to mapping buffers as well, so
> these patches implement a set of callbacks called unmap_pages and
> map_pages to the io-pgtable code and IOMMU drivers which unmaps or maps
> an IOVA range that consists of a number of pages of the same
> page size that is supported by the IOMMU hardware, and allows for
> manipulating multiple page table entries in the same set of indirect
> calls. The reason for introducing these callbacks is to give other IOMMU
> drivers/io-pgtable formats time to change to using the new callbacks, so
> that the transition to using this approach can be done piecemeal.

Hi Will,

Did you get a chance to look at this patchset? Most patches are already
acked/reviewed and all still applies clean on rc1.

Thanks,
Georgi
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
