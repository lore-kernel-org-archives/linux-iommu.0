Return-Path: <SRS0=4E9V=2A=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0195DC00454
	for <iommu@archiver.kernel.org>; Tue, 10 Dec 2019 14:53:34 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE41D207FF
	for <iommu@archiver.kernel.org>; Tue, 10 Dec 2019 14:53:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE41D207FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 81A0C86AB3;
	Tue, 10 Dec 2019 14:53:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XlEOJn-UxYvc; Tue, 10 Dec 2019 14:53:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D58A486A75;
	Tue, 10 Dec 2019 14:53:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C2333C1796;
	Tue, 10 Dec 2019 14:53:32 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DEE45C0881
 for <iommu@lists.linux-foundation.org>; Tue, 10 Dec 2019 14:53:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id CE6492268C
 for <iommu@lists.linux-foundation.org>; Tue, 10 Dec 2019 14:53:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vGUr8Qarrod2 for <iommu@lists.linux-foundation.org>;
 Tue, 10 Dec 2019 14:53:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (lhrrgout.huawei.com [185.176.76.210])
 by silver.osuosl.org (Postfix) with ESMTPS id 8A1E32266C
 for <iommu@lists.linux-foundation.org>; Tue, 10 Dec 2019 14:53:29 +0000 (UTC)
Received: from lhreml704-cah.china.huawei.com (unknown [172.18.7.108])
 by Forcepoint Email with ESMTP id F08F0B0D3C4BB7E5B4A8;
 Tue, 10 Dec 2019 14:53:26 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml704-cah.china.huawei.com (10.201.108.45) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 10 Dec 2019 14:53:26 +0000
Received: from [127.0.0.1] (10.202.226.46) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 10 Dec
 2019 14:53:26 +0000
Subject: Re: [Patch v3 0/3] iommu: reduce spinlock contention on fast path
To: Cong Wang <xiyou.wangcong@gmail.com>, <iommu@lists.linux-foundation.org>
References: <20191206213803.12580-1-xiyou.wangcong@gmail.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <5d517a33-2e5a-529c-578c-707ae0a40e88@huawei.com>
Date: Tue, 10 Dec 2019 14:53:25 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191206213803.12580-1-xiyou.wangcong@gmail.com>
Content-Language: en-US
X-Originating-IP: [10.202.226.46]
X-ClientProxiedBy: lhreml728-chm.china.huawei.com (10.201.108.79) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: linux-kernel@vger.kernel.org
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

On 06/12/2019 21:38, Cong Wang wrote:
> This patchset contains three small optimizations for the global spinlock
> contention in IOVA cache. Our memcache perf test shows this reduced its
> p999 latency down by 45% on AMD when IOMMU is enabled.
> 
> Cong Wang (3):
>    iommu: avoid unnecessary magazine allocations
>    iommu: optimize iova_magazine_free_pfns()
>    iommu: avoid taking iova_rbtree_lock twice
> ---
>   drivers/iommu/iova.c | 75 ++++++++++++++++++++++++++------------------
>   1 file changed, 45 insertions(+), 30 deletions(-)
> 

I retested, and got a ~1.1% gain in throughput for my storage test - 
results here if interested https://pastebin.com/dSQxYpN8

Thanks,
John
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
