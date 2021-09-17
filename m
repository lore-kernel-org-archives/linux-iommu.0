Return-Path: <SRS0=dQER=OH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C98CDC433EF
	for <iommu@archiver.kernel.org>; Fri, 17 Sep 2021 02:56:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A77661164
	for <iommu@archiver.kernel.org>; Fri, 17 Sep 2021 02:56:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7A77661164
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 371414048D;
	Fri, 17 Sep 2021 02:56:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RmvBqo94EPrG; Fri, 17 Sep 2021 02:56:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id CCA10401B7;
	Fri, 17 Sep 2021 02:56:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A87C2C000F;
	Fri, 17 Sep 2021 02:56:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4101AC000D
 for <iommu@lists.linux-foundation.org>; Fri, 17 Sep 2021 02:56:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2AB5B40802
 for <iommu@lists.linux-foundation.org>; Fri, 17 Sep 2021 02:56:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8Y_6pRS7QNBx for <iommu@lists.linux-foundation.org>;
 Fri, 17 Sep 2021 02:56:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 90467407F2
 for <iommu@lists.linux-foundation.org>; Fri, 17 Sep 2021 02:56:23 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10109"; a="219522160"
X-IronPort-AV: E=Sophos;i="5.85,299,1624345200"; d="scan'208";a="219522160"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2021 19:56:21 -0700
X-IronPort-AV: E=Sophos;i="5.85,299,1624345200"; d="scan'208";a="546107273"
Received: from gao-cwp.sh.intel.com (HELO gao-cwp) ([10.239.159.133])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2021 19:56:19 -0700
Date: Fri, 17 Sep 2021 11:03:35 +0800
From: Chao Gao <chao.gao@intel.com>
To: Konrad Rzeszutek Wilk <konrad@darnok.org>
Subject: Re: [PATCH] swiotlb: allocate memory in a cache-friendly way
Message-ID: <20210917030334.GA20257@gao-cwp>
References: <20210901042135.103981-1-chao.gao@intel.com>
 <YUNnkxiVnHUszg7G@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YUNnkxiVnHUszg7G@localhost.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: Andi Kleen <ak@linux.intel.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>,
 Christoph Hellwig <hch@lst.de>
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

On Thu, Sep 16, 2021 at 11:49:39AM -0400, Konrad Rzeszutek Wilk wrote:
>On Wed, Sep 01, 2021 at 12:21:35PM +0800, Chao Gao wrote:
>> Currently, swiotlb uses a global index to indicate the starting point
>> of next search. The index increases from 0 to the number of slots - 1
>> and then wraps around. It is straightforward but not cache-friendly
>> because the "oldest" slot in swiotlb tends to be used first.
>> 
>> Freed slots are probably accessed right before being freed, especially
>> in VM's case (device backends access them in DMA_TO_DEVICE mode; guest
>> accesses them in other DMA modes). Thus those just freed slots may
>> reside in cache. Then reusing those just freed slots can reduce cache
>> misses.
>> 
>> To that end, maintain a free list for free slots and insert freed slots
>> from the head and searching for free slots always starts from the head.
>> 
>> With this optimization, network throughput of sending data from host to
>> guest, measured by iperf3, increases by 7%.
>
>Wow, that is pretty awesome!
>
>Are there any other benchmarks that you ran that showed a negative
>performance?

TBH, yes. Recently I do fio tests with this patch. The impact of this patch
is: (+ means performance improvement; - means performance regression)

1-job fio:
randread: +6.7%
randwrite: -1.6%
read: +8.2%
write: +7.4%

8-job fio:
randread: -5.5%
randwrite: -12.6%
read: -24.8%
write: -45.5%

I haven't figured out why multi-job fio tests suffer. Will post v2 once
the issue gets resolved.

Thanks
Chao
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
