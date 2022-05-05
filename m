Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F50EC433EF
	for <iommu@archiver.kernel.org>; Thu,  5 May 2022 01:02:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 25A2C4019E;
	Thu,  5 May 2022 01:02:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IE3D0OvufWYQ; Thu,  5 May 2022 01:02:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 188DD40146;
	Thu,  5 May 2022 01:02:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D44FFC0039;
	Thu,  5 May 2022 01:02:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 15644C0032
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 01:02:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F0D5C41924
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 01:02:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vUP31WeS8pWh for <iommu@lists.linux-foundation.org>;
 Thu,  5 May 2022 01:02:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 91C3B402E0
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 01:02:24 +0000 (UTC)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.57])
 by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KtwKH5ctgzCsWg;
 Thu,  5 May 2022 08:57:39 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 5 May 2022 09:02:20 +0800
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 5 May 2022 09:02:19 +0800
Subject: Re: [PATCH v12 2/9] ACPI/IORT: Make iort_iommu_msi_get_resv_regions()
 return void
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 <linux-arm-kernel@lists.infradead.org>, <linux-acpi@vger.kernel.org>,
 <iommu@lists.linux-foundation.org>
References: <20220503163330.509-1-shameerali.kolothum.thodi@huawei.com>
 <20220503163330.509-3-shameerali.kolothum.thodi@huawei.com>
Message-ID: <2471e99d-9bef-97b2-56f4-ac7ce9ba63e0@huawei.com>
Date: Thu, 5 May 2022 09:02:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20220503163330.509-3-shameerali.kolothum.thodi@huawei.com>
Content-Language: en-GB
X-Originating-IP: [10.174.178.247]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
Cc: robin.murphy@arm.com, jon@solid-run.com, linuxarm@huawei.com,
 steven.price@arm.com, hch@infradead.org, Sami.Mujawar@arm.com, will@kernel.org,
 wanghuiqiang@huawei.com
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
From: Hanjun Guo via iommu <iommu@lists.linux-foundation.org>
Reply-To: Hanjun Guo <guohanjun@huawei.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2022/5/4 0:33, Shameer Kolothum wrote:
> At present iort_iommu_msi_get_resv_regions() returns the number of
> MSI reserved regions on success and there are no users for this.
> The reserved region list will get populated anyway for platforms
> that require the HW MSI region reservation. Hence, change the
> function to return void instead.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Tested-by: Steven Price <steven.price@arm.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

Reviewed-by: Hanjun Guo <guohanjun@huawei.com>

Thanks
Hanjun
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
