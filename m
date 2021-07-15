Return-Path: <SRS0=9Lhb=MH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B017C12002
	for <iommu@archiver.kernel.org>; Thu, 15 Jul 2021 01:25:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94CD2613D0
	for <iommu@archiver.kernel.org>; Thu, 15 Jul 2021 01:25:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94CD2613D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 532F74053F;
	Thu, 15 Jul 2021 01:25:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id s2EfX8rjIK7f; Thu, 15 Jul 2021 01:25:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D7D784058A;
	Thu, 15 Jul 2021 01:25:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A1A7AC0010;
	Thu, 15 Jul 2021 01:25:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C789AC000E
 for <iommu@lists.linux-foundation.org>; Thu, 15 Jul 2021 01:25:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AE39C40130
 for <iommu@lists.linux-foundation.org>; Thu, 15 Jul 2021 01:25:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id juvnXENLJw4h for <iommu@lists.linux-foundation.org>;
 Thu, 15 Jul 2021 01:25:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 174E94011D
 for <iommu@lists.linux-foundation.org>; Thu, 15 Jul 2021 01:25:27 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10045"; a="197638816"
X-IronPort-AV: E=Sophos;i="5.84,240,1620716400"; d="scan'208";a="197638816"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2021 18:25:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,240,1620716400"; d="scan'208";a="466322019"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by fmsmga008.fm.intel.com with ESMTP; 14 Jul 2021 18:25:23 -0700
Subject: Re: [PATCH v7 00/15] Optimizing iommu_[map/unmap] performance
To: Georgi Djakov <djakov@kernel.org>,
 Georgi Djakov <quic_c_gdjako@quicinc.com>, will@kernel.org,
 robin.murphy@arm.com
References: <1623850736-389584-1-git-send-email-quic_c_gdjako@quicinc.com>
 <e6c8993e-353e-6a05-9b6d-9a49de471cb6@kernel.org>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <4d466ea9-2c1a-2e19-af5b-0434441ee7cb@linux.intel.com>
Date: Thu, 15 Jul 2021 09:23:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <e6c8993e-353e-6a05-9b6d-9a49de471cb6@kernel.org>
Content-Language: en-US
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

On 7/14/21 10:24 PM, Georgi Djakov wrote:
> On 16.06.21 16:38, Georgi Djakov wrote:
>> When unmapping a buffer from an IOMMU domain, the IOMMU framework unmaps
>> the buffer at a granule of the largest page size that is supported by
>> the IOMMU hardware and fits within the buffer. For every block that
>> is unmapped, the IOMMU framework will call into the IOMMU driver, and
>> then the io-pgtable framework to walk the page tables to find the entry
>> that corresponds to the IOVA, and then unmaps the entry.
>>
>> This can be suboptimal in scenarios where a buffer or a piece of a
>> buffer can be split into several contiguous page blocks of the same size.
>> For example, consider an IOMMU that supports 4 KB page blocks, 2 MB page
>> blocks, and 1 GB page blocks, and a buffer that is 4 MB in size is being
>> unmapped at IOVA 0. The current call-flow will result in 4 indirect 
>> calls,
>> and 2 page table walks, to unmap 2 entries that are next to each other in
>> the page-tables, when both entries could have been unmapped in one shot
>> by clearing both page table entries in the same call.
>>
>> The same optimization is applicable to mapping buffers as well, so
>> these patches implement a set of callbacks called unmap_pages and
>> map_pages to the io-pgtable code and IOMMU drivers which unmaps or maps
>> an IOVA range that consists of a number of pages of the same
>> page size that is supported by the IOMMU hardware, and allows for
>> manipulating multiple page table entries in the same set of indirect
>> calls. The reason for introducing these callbacks is to give other IOMMU
>> drivers/io-pgtable formats time to change to using the new callbacks, so
>> that the transition to using this approach can be done piecemeal.
> 
> Hi Will,
> 
> Did you get a chance to look at this patchset? Most patches are already
> acked/reviewed and all still applies clean on rc1.

I also have the ops->[un]map_pages implementation for the Intel IOMMU
driver. I will post them once the iommu/core part get applied.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
