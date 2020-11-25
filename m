Return-Path: <SRS0=GPDh=E7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE0E7C56202
	for <iommu@archiver.kernel.org>; Wed, 25 Nov 2020 18:22:39 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4B34206CA
	for <iommu@archiver.kernel.org>; Wed, 25 Nov 2020 18:22:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4B34206CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2114686B7A;
	Wed, 25 Nov 2020 18:22:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MR3QxJO9z4Dv; Wed, 25 Nov 2020 18:22:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8E10E86B70;
	Wed, 25 Nov 2020 18:22:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6D24BC0891;
	Wed, 25 Nov 2020 18:22:36 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 70256C0052
 for <iommu@lists.linux-foundation.org>; Wed, 25 Nov 2020 18:22:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 5ED118761D
 for <iommu@lists.linux-foundation.org>; Wed, 25 Nov 2020 18:22:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id h57lMcCr0-By for <iommu@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 18:22:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 2B18D875F2
 for <iommu@lists.linux-foundation.org>; Wed, 25 Nov 2020 18:22:31 +0000 (UTC)
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.56])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Ch8Nr1jqjzVfv2;
 Thu, 26 Nov 2020 02:21:48 +0800 (CST)
Received: from dggemi711-chm.china.huawei.com (10.3.20.110) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Thu, 26 Nov 2020 02:22:24 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggemi711-chm.china.huawei.com (10.3.20.110) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Thu, 26 Nov 2020 02:22:24 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.1913.007;
 Thu, 26 Nov 2020 02:22:24 +0800
From: "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To: Colin King <colin.king@canonical.com>, Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy
 <robin.murphy@arm.com>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>
Subject: RE: [PATCH] dma-mapping: fix an uninitialized pointer read due to
 typo in argp assignment
Thread-Topic: [PATCH] dma-mapping: fix an uninitialized pointer read due to
 typo in argp assignment
Thread-Index: AQHWwzK8QvyQYoZZJ0ueAMVQnzAXH6nZJ9kw
Date: Wed, 25 Nov 2020 18:22:24 +0000
Message-ID: <1b430a80dec14cb9aa612ff7e5dddac4@hisilicon.com>
References: <20201125135535.1880307-1-colin.king@canonical.com>
In-Reply-To: <20201125135535.1880307-1-colin.king@canonical.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.202.201]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Cc: "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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



> -----Original Message-----
> From: Colin King [mailto:colin.king@canonical.com]
> Sent: Thursday, November 26, 2020 2:56 AM
> To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>; Christoph
> Hellwig <hch@lst.de>; Marek Szyprowski <m.szyprowski@samsung.com>;
> Robin Murphy <robin.murphy@arm.com>; iommu@lists.linux-foundation.org
> Cc: kernel-janitors@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [PATCH] dma-mapping: fix an uninitialized pointer read due to typo in
> argp assignment
> 
> From: Colin Ian King <colin.king@canonical.com>
> 
> The assignment of argp is currently using argp as the source because of
> a typo. Fix this by assigning it the value passed in arg instead.
> 
> Addresses-Coverity: ("Uninitialized pointer read")
> Fixes: bfd2defed94d ("dma-mapping: add benchmark support for streaming
> DMA APIs")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Acked-by: Barry Song <song.bao.hua@hisilicon.com>

> ---
>  kernel/dma/map_benchmark.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
> index ca616b664f72..e1e37603d01b 100644
> --- a/kernel/dma/map_benchmark.c
> +++ b/kernel/dma/map_benchmark.c
> @@ -192,7 +192,7 @@ static long map_benchmark_ioctl(struct file *file,
> unsigned int cmd,
>  		unsigned long arg)
>  {
>  	struct map_benchmark_data *map = file->private_data;
> -	void __user *argp = (void __user *)argp;
> +	void __user *argp = (void __user *)arg;
>  	u64 old_dma_mask;
> 
>  	int ret;
> --
> 2.29.2

Thanks
Barry

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
