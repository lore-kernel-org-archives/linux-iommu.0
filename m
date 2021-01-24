Return-Path: <SRS0=zB6U=G3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B40C433E0
	for <iommu@archiver.kernel.org>; Sun, 24 Jan 2021 07:17:15 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE11E22C7E
	for <iommu@archiver.kernel.org>; Sun, 24 Jan 2021 07:17:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE11E22C7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7302286A58;
	Sun, 24 Jan 2021 07:17:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6rtAEHyRZ5jj; Sun, 24 Jan 2021 07:17:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id B7C0585B58;
	Sun, 24 Jan 2021 07:17:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8DFC9C088B;
	Sun, 24 Jan 2021 07:17:13 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E2F8DC013A
 for <iommu@lists.linux-foundation.org>; Sun, 24 Jan 2021 07:17:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id C706186981
 for <iommu@lists.linux-foundation.org>; Sun, 24 Jan 2021 07:17:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5LXK4Eje31pE for <iommu@lists.linux-foundation.org>;
 Sun, 24 Jan 2021 07:17:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 2715185B58
 for <iommu@lists.linux-foundation.org>; Sun, 24 Jan 2021 07:17:10 +0000 (UTC)
IronPort-SDR: CG2Y85SkVzEOrdymGBO70jyGSERBBmFJTKJFd7O9pS/p/EFfcC4WaLr+KMYvbAzjvTNt97Y1pK
 4ZjG94leNTHA==
X-IronPort-AV: E=McAfee;i="6000,8403,9873"; a="166701565"
X-IronPort-AV: E=Sophos;i="5.79,370,1602572400"; d="scan'208";a="166701565"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jan 2021 23:17:10 -0800
IronPort-SDR: Cu+Wa8KxtY0DpZTSBmPG0m8XnB+LFEVb/7ZarXdc6luqLnglI+PtrvbdgyIrMjBtPxR+OOOxeM
 gh4CINFgl9uQ==
X-IronPort-AV: E=Sophos;i="5.79,370,1602572400"; d="scan'208";a="386713678"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.255.31.40])
 ([10.255.31.40])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jan 2021 23:17:05 -0800
Subject: Re: performance regression noted in v5.11-rc after c062db039f40
To: Robin Murphy <robin.murphy@arm.com>, Chuck Lever <chuck.lever@oracle.com>
References: <D81314ED-5673-44A6-B597-090E3CB83EB0@oracle.com>
 <20210112143819.GA9689@willie-the-truck>
 <607648D8-BF0C-40D6-9B43-2359F45EE74C@oracle.com>
 <e83eed0d-82cd-c9be-cef1-5fe771de975f@arm.com>
 <3568C74A-A587-4464-8840-24F7A93ABA06@oracle.com>
 <990a7c1e-e8c0-a6a8-f057-03b104cebca3@linux.intel.com>
 <3A4451BB-41BD-429B-BE0C-12AE7D03A99B@oracle.com>
 <f1d38e5a-3136-172f-c792-0bbf59131514@arm.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <463fdf02-3d8e-37d3-c819-4a3c173a4138@linux.intel.com>
Date: Sun, 24 Jan 2021 15:17:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <f1d38e5a-3136-172f-c792-0bbf59131514@arm.com>
Content-Language: en-US
Cc: "isaacm@codeaurora.org" <isaacm@codeaurora.org>,
 linux-rdma <linux-rdma@vger.kernel.org>, Will Deacon <will@kernel.org>,
 "murphyt7@tcd.ie" <murphyt7@tcd.ie>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "logang@deltatee.com" <logang@deltatee.com>, Christoph Hellwig <hch@lst.de>
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

On 2021/1/23 1:38, Robin Murphy wrote:
>>> I kind of believe it's due to the indirect calls. This is also reported
>>> on ARM.
>>>
>>> https://lore.kernel.org/linux-iommu/1610376862-927-1-git-send-email-isaacm@codeaurora.org/ 
>>>
>>>
>>> Maybe we can try changing indirect calls to static ones to verify this
>>> problem.
>>
>> I liked the idea of map_sg() enough to try my hand at building a PoC for
>> Intel, based on Isaac's patch series. It's just a cut-and-paste of the
>> generic iommu.c code with the indirect calls to ops->map() replaced.
>>
>> The indirect calls do not seem to be the problem. Calling intel_iommu_map
>> directly appears to be as costly as calling it indirectly.
>>
>> However, perhaps there are other ways map_sg() can be beneficial. In
>> v5.10, __domain_mapping and iommu_flush_write_buffer() appear to be
>> invoked just once for each large map operation, for example.
> 
> Oh, if the driver needs to do maintenance beyond just installing PTEs, 
> that should probably be devolved to iotlb_sync_map anyway. There's a 
> patch series here generalising that to be more useful, which is 
> hopefully just waiting to be merged now:
> 
> https://lore.kernel.org/linux-iommu/20210107122909.16317-1-yong.wu@mediatek.com/ 
> 

The iotlb_sync_map() could help here as far as I can see. I will post a
call-for-test patch set later.

> 
> Robin.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
