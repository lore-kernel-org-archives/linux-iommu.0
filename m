Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D147C433EF
	for <iommu@archiver.kernel.org>; Tue, 14 Dec 2021 17:19:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A4B6F40580;
	Tue, 14 Dec 2021 17:19:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YIvPrZ4icYlD; Tue, 14 Dec 2021 17:19:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4BEDF400E9;
	Tue, 14 Dec 2021 17:19:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 22AAFC002F;
	Tue, 14 Dec 2021 17:19:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A024CC0012
 for <iommu@lists.linux-foundation.org>; Tue, 14 Dec 2021 17:19:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7BFF681470
 for <iommu@lists.linux-foundation.org>; Tue, 14 Dec 2021 17:19:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qI5X3Mw-jfdc for <iommu@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 17:19:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DB499814BA
 for <iommu@lists.linux-foundation.org>; Tue, 14 Dec 2021 17:19:19 +0000 (UTC)
Received: from fraeml706-chm.china.huawei.com (unknown [172.18.147.206])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JD4kR2flTz67xBm;
 Wed, 15 Dec 2021 01:14:55 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml706-chm.china.huawei.com (10.206.15.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.20; Tue, 14 Dec 2021 18:19:17 +0100
Received: from [10.47.83.94] (10.47.83.94) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Tue, 14 Dec
 2021 17:19:16 +0000
Subject: Re: [PATCH v2 10/11] iommu/iova: Move flush queue code to iommu-dma
To: Robin Murphy <robin.murphy@arm.com>, <joro@8bytes.org>, <will@kernel.org>
References: <cover.1639157090.git.robin.murphy@arm.com>
 <0752bfc207b974e76eab7564058b5a7b9e8d5e6e.1639157090.git.robin.murphy@arm.com>
Message-ID: <f0ec6978-4571-2d7c-f94c-cd92ba167074@huawei.com>
Date: Tue, 14 Dec 2021 17:18:53 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <0752bfc207b974e76eab7564058b5a7b9e8d5e6e.1639157090.git.robin.murphy@arm.com>
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
> +	iovad->fq_domain = fq_domain;
> +	iovad->fq = queue;
> +
> +	timer_setup(&iovad->fq_timer, fq_flush_timeout, 0);
> +	atomic_set(&iovad->fq_timer_on, 0);
> +
> +	return 0;
> +}
> +
> +

nit: a single blank line is standard, I think

Cheers

>   static inline size_t cookie_msi_granule(struct iommu_dma_cookie *cookie)
>   {


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
