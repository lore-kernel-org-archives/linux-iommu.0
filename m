Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D029C4332F
	for <iommu@archiver.kernel.org>; Tue, 14 Dec 2021 17:16:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DD98E60C00;
	Tue, 14 Dec 2021 17:16:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vvxklvz3tFJX; Tue, 14 Dec 2021 17:16:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D182C60750;
	Tue, 14 Dec 2021 17:16:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8E624C002F;
	Tue, 14 Dec 2021 17:16:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BC287C0012
 for <iommu@lists.linux-foundation.org>; Tue, 14 Dec 2021 17:16:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9B41140580
 for <iommu@lists.linux-foundation.org>; Tue, 14 Dec 2021 17:16:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NzwoCtHUYOqE for <iommu@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 17:16:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 81851400E9
 for <iommu@lists.linux-foundation.org>; Tue, 14 Dec 2021 17:16:36 +0000 (UTC)
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.226])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JD4gH1MyYz67xdg;
 Wed, 15 Dec 2021 01:12:11 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 14 Dec 2021 18:16:33 +0100
Received: from [10.47.83.94] (10.47.83.94) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Tue, 14 Dec
 2021 17:16:32 +0000
Subject: Re: [PATCH v2 11/11] iommu: Move flush queue data into
 iommu_dma_cookie
To: Robin Murphy <robin.murphy@arm.com>, <joro@8bytes.org>, <will@kernel.org>
References: <cover.1639157090.git.robin.murphy@arm.com>
 <e2e24e5f4174a56c725cde3164f86a3e234f6d7f.1639157090.git.robin.murphy@arm.com>
Message-ID: <e997d299-9f51-6d17-19ce-d9116c26c967@huawei.com>
Date: Tue, 14 Dec 2021 17:16:09 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <e2e24e5f4174a56c725cde3164f86a3e234f6d7f.1639157090.git.robin.murphy@arm.com>
Content-Language: en-US
X-Originating-IP: [10.47.83.94]
X-ClientProxiedBy: lhreml701-chm.china.huawei.com (10.201.108.50) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: linux-kernel@vger.kernel.org, willy@infradead.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
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
From: John Garry via iommu <iommu@lists.linux-foundation.org>
Reply-To: John Garry <john.garry@huawei.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 10/12/2021 17:54, Robin Murphy wrote:
> Complete the move into iommu-dma by refactoring the flush queues
> themselves to belong to the DMA cookie rather than the IOVA domain.
> 
> The refactoring may as well extend to some minor cosmetic aspects
> too, to help us stay one step ahead of the style police.
> 
> Signed-off-by: Robin Murphy<robin.murphy@arm.com>
> ---

Again, FWIW:

Reviewed-by: John Garry <john.garry@huawei.com>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
