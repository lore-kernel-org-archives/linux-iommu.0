Return-Path: <SRS0=1/OX=IR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8551FC433C1
	for <iommu@archiver.kernel.org>; Fri, 19 Mar 2021 15:44:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22A1561955
	for <iommu@archiver.kernel.org>; Fri, 19 Mar 2021 15:44:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22A1561955
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D5A2340141;
	Fri, 19 Mar 2021 15:44:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JbE0kCLqr0qm; Fri, 19 Mar 2021 15:44:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id D8E7F4012F;
	Fri, 19 Mar 2021 15:44:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B039DC000A;
	Fri, 19 Mar 2021 15:44:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5AB7AC0001
 for <iommu@lists.linux-foundation.org>; Fri, 19 Mar 2021 15:44:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3B7204AD66
 for <iommu@lists.linux-foundation.org>; Fri, 19 Mar 2021 15:44:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id E1QbtuR_Mx1b for <iommu@lists.linux-foundation.org>;
 Fri, 19 Mar 2021 15:44:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BABF14BA46
 for <iommu@lists.linux-foundation.org>; Fri, 19 Mar 2021 15:44:21 +0000 (UTC)
Received: from fraeml739-chm.china.huawei.com (unknown [172.18.147.206])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4F27Jb6CZpz67vY9;
 Fri, 19 Mar 2021 23:35:43 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml739-chm.china.huawei.com (10.206.15.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 19 Mar 2021 16:44:15 +0100
Received: from [10.47.10.104] (10.47.10.104) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 19 Mar
 2021 15:44:14 +0000
Subject: Re: [PATCH 0/6] dma mapping/iommu: Allow IOMMU IOVA rcache range to
 be configured
To: Christoph Hellwig <hch@lst.de>
References: <1616160348-29451-1-git-send-email-john.garry@huawei.com>
 <20210319134047.GA5729@lst.de>
From: John Garry <john.garry@huawei.com>
Message-ID: <ff8e54fb-db3f-cf47-f4f7-95b1619bdbf6@huawei.com>
Date: Fri, 19 Mar 2021 15:42:03 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20210319134047.GA5729@lst.de>
Content-Language: en-US
X-Originating-IP: [10.47.10.104]
X-ClientProxiedBy: lhreml717-chm.china.huawei.com (10.201.108.68) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: linux-scsi@vger.kernel.org, martin.petersen@oracle.com, will@kernel.org,
 linux-kernel@vger.kernel.org, linuxarm@huawei.com,
 iommu@lists.linux-foundation.org, robin.murphy@arm.com, jejb@linux.ibm.com
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

On 19/03/2021 13:40, Christoph Hellwig wrote:
> On Fri, Mar 19, 2021 at 09:25:42PM +0800, John Garry wrote:
>> For streaming DMA mappings involving an IOMMU and whose IOVA len regularly
>> exceeds the IOVA rcache upper limit (meaning that they are not cached),
>> performance can be reduced.
>>
>> This is much more pronounced from commit 4e89dce72521 ("iommu/iova: Retry
>> from last rb tree node if iova search fails"), as discussed at [0].
>>
>> IOVAs which cannot be cached are highly involved in the IOVA aging issue,
>> as discussed at [1].
> 
> I'm confused.  If this a limit in the IOVA allocator, dma-iommu should
> be able to just not grow the allocation so larger without help from
> the driver.

This is not an issue with the IOVA allocator.

The issue is with how the IOVA code handles caching of IOVAs. 
Specifically, when we DMA unmap, for an IOVA whose length is above a 
fixed threshold, the IOVA is freed, rather than being cached. See 
free_iova_fast().

For performance reasons, I want that threshold increased for my driver 
to avail of the caching of all lengths of IOVA which we may see - 
currently we see IOVAs whose length exceeds that threshold. But it may 
not be good to increase that threshold for everyone.

 > If contrary to the above description it is device-specific, the driver
 > could simply use dma_get_max_seg_size().
 > .
 >

But that is for a single segment, right? Is there something equivalent 
to tell how many scatter-gather elements which we may generate, like 
scsi_host_template.sg_tablesize?

Thanks,
John


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
