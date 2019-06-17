Return-Path: <SRS0=Kmd8=UQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5538DC31E57
	for <iommu@archiver.kernel.org>; Mon, 17 Jun 2019 13:39:21 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A2AC20657
	for <iommu@archiver.kernel.org>; Mon, 17 Jun 2019 13:39:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A2AC20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 0FD26D12;
	Mon, 17 Jun 2019 13:39:21 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 37A3CACC
	for <iommu@lists.linux-foundation.org>;
	Mon, 17 Jun 2019 13:39:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 333457E9
	for <iommu@lists.linux-foundation.org>;
	Mon, 17 Jun 2019 13:39:18 +0000 (UTC)
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
	by Forcepoint Email with ESMTP id 842461C5D07151DC37FC;
	Mon, 17 Jun 2019 21:39:12 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.238) by DGGEMS403-HUB.china.huawei.com
	(10.3.19.203) with Microsoft SMTP Server id 14.3.439.0;
	Mon, 17 Jun 2019 21:39:04 +0800
Subject: Re: [RFC CFT 0/6] Try to reduce lock contention on the SMMUv3 command
	queue
To: Will Deacon <will.deacon@arm.com>, <iommu@lists.linux-foundation.org>
References: <20190611134603.4253-1-will.deacon@arm.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <7c5a590c-dd7f-2e17-6c99-ac95ff59af07@huawei.com>
Date: Mon, 17 Jun 2019 14:38:59 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
	Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190611134603.4253-1-will.deacon@arm.com>
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Cc: Vijay Kilary <vkilari@codeaurora.org>,
	Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
	Jon Masters <jcm@redhat.com>, Jan Glauber <jglauber@marvell.com>,
	Jayachandran Chandrasekharan Nair <jnair@marvell.com>,
	Robin Murphy <robin.murphy@arm.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On 11/06/2019 14:45, Will Deacon wrote:
> Hi all,
>
> This patch series is an attempt to reduce lock contention when inserting
> commands into the Arm SMMUv3 command queue. Unfortunately, our initial
> benchmarking has shown mixed results across the board and the changes in
> the last patch don't appear to justify their complexity. Based on that,
> I only plan to queue the first patch for the time being.
>
> Anyway, before I park this series, I thought it was probably worth
> sharing it in case it's useful to somebody. If you have a system where
> you believe I/O performance to be limited by the SMMUv3 command queue
> then please try these patches and let me know what happens, even if it's
> just more bad news.
>
> Patches based on 5.2-rc3. I've also pushed them out to my iommu/devel
> branch for the moment:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/log/?h=iommu/devel
>

Hi Will,

For command queue lock contention, we had this series previously:
https://lore.kernel.org/linux-iommu/61b4c3e5f1322dfe96ca2062a7fe058298340996.1539782799.git.robin.murphy@arm.com/#t

I am just wondering does this have any future?

IIRC we only tested the v3 of the series on a board which does not 
support msi.

Thanks,
john

> Thanks,
>
> Will
>
> --->8
>
> Cc: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Jayachandran Chandrasekharan Nair <jnair@marvell.com>
> Cc: Jan Glauber <jglauber@marvell.com>
> Cc: Jon Masters <jcm@redhat.com>
> Cc: Eric Auger <eric.auger@redhat.com>
> Cc: Zhen Lei <thunder.leizhen@huawei.com>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Vijay Kilary <vkilari@codeaurora.org>
> Cc: Joerg Roedel <joro@8bytes.org>
>
> Will Deacon (6):
>   iommu/arm-smmu-v3: Increase maximum size of queues
>   iommu/arm-smmu-v3: Separate s/w and h/w views of prod and cons indexes
>   iommu/arm-smmu-v3: Drop unused 'q' argument from Q_OVF macro
>   iommu/arm-smmu-v3: Move low-level queue fields out of arm_smmu_queue
>   iommu/arm-smmu-v3: Operate directly on low-level queue where possible
>   iommu/arm-smmu-v3: Reduce contention during command-queue insertion
>
>  drivers/iommu/arm-smmu-v3.c | 725 ++++++++++++++++++++++++++++++++------------
>  1 file changed, 534 insertions(+), 191 deletions(-)
>


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
