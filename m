Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24158C433EF
	for <iommu@archiver.kernel.org>; Wed, 24 Nov 2021 17:25:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A5C9180D1C;
	Wed, 24 Nov 2021 17:25:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nwcK0O1yWijH; Wed, 24 Nov 2021 17:25:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8E8C780CAD;
	Wed, 24 Nov 2021 17:25:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7181BC001E;
	Wed, 24 Nov 2021 17:25:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 270A3C0012
 for <iommu@lists.linux-foundation.org>; Wed, 24 Nov 2021 17:25:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 086AA600D4
 for <iommu@lists.linux-foundation.org>; Wed, 24 Nov 2021 17:25:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id e-7f9BSLVLJM for <iommu@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 17:25:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 73E47600CA
 for <iommu@lists.linux-foundation.org>; Wed, 24 Nov 2021 17:25:26 +0000 (UTC)
Received: from fraeml741-chm.china.huawei.com (unknown [172.18.147.206])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HznqG0SXmz67rcd;
 Thu, 25 Nov 2021 01:21:30 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml741-chm.china.huawei.com (10.206.15.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 24 Nov 2021 18:25:23 +0100
Received: from [10.202.227.179] (10.202.227.179) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 24 Nov 2021 17:25:23 +0000
Subject: Re: [PATCH 9/9] iommu: Move flush queue data into iommu_dma_cookie
To: Robin Murphy <robin.murphy@arm.com>, <joro@8bytes.org>, <will@kernel.org>
References: <cover.1637671820.git.robin.murphy@arm.com>
 <49bfd9636fd21c4b40e07558db6bfbbf82a449ac.1637674723.git.robin.murphy@arm.com>
Message-ID: <9dece0b8-2832-f467-91f3-f63ef0f70d16@huawei.com>
Date: Wed, 24 Nov 2021 17:25:22 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <49bfd9636fd21c4b40e07558db6bfbbf82a449ac.1637674723.git.robin.murphy@arm.com>
Content-Language: en-US
X-Originating-IP: [10.202.227.179]
X-ClientProxiedBy: lhreml721-chm.china.huawei.com (10.201.108.72) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 willy@infradead.org
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

On 23/11/2021 14:10, Robin Murphy wrote:
> ruct iommu_dma_msi_page {
>   	struct list_head	list;
> @@ -41,7 +43,19 @@ struct iommu_dma_cookie {
>   	enum iommu_dma_cookie_type	type;
>   	union {
>   		/* Full allocator for IOMMU_DMA_IOVA_COOKIE */
> -		struct iova_domain	iovad;
> +		struct {
> +			struct iova_domain	iovad;
> +
> +			struct iova_fq __percpu *fq;	/* Flush queue */
> +			/* Number of TLB flushes that have been started */
> +			atomic64_t		fq_flush_start_cnt;
> +			/* Number of TLB flushes that have been finished */
> +			atomic64_t		fq_flush_finish_cnt;
> +			/* Timer to regularily empty the flush queues */
> +			struct timer_list	fq_timer;
> +			/* 1 when timer is active, 0 when not */
> +			atomic_t		fq_timer_on;

I thought that putting all the FQ stuff in its own structure would be 
neater, but that's just personal preference.

Thanks,
John
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
