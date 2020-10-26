Return-Path: <SRS0=cbBT=EB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4707DC4363A
	for <iommu@archiver.kernel.org>; Mon, 26 Oct 2020 20:07:53 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D41D21BE5
	for <iommu@archiver.kernel.org>; Mon, 26 Oct 2020 20:07:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D41D21BE5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id C717D866DE;
	Mon, 26 Oct 2020 20:07:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id q+38FsPDgqfs; Mon, 26 Oct 2020 20:07:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1E6F286499;
	Mon, 26 Oct 2020 20:07:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DF8BDC088B;
	Mon, 26 Oct 2020 20:07:50 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DB020C0051
 for <iommu@lists.linux-foundation.org>; Mon, 26 Oct 2020 20:07:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id C0CEA866DD
 for <iommu@lists.linux-foundation.org>; Mon, 26 Oct 2020 20:07:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wFtXkGZ8NxMg for <iommu@lists.linux-foundation.org>;
 Mon, 26 Oct 2020 20:07:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 3CC2A86499
 for <iommu@lists.linux-foundation.org>; Mon, 26 Oct 2020 20:07:47 +0000 (UTC)
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.53])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4CKm9103g5zXfvM;
 Tue, 27 Oct 2020 04:07:49 +0800 (CST)
Received: from dggemi711-chm.china.huawei.com (10.3.20.110) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Tue, 27 Oct 2020 04:07:43 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggemi711-chm.china.huawei.com (10.3.20.110) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Tue, 27 Oct 2020 04:07:43 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.1913.007;
 Tue, 27 Oct 2020 04:07:43 +0800
From: "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To: Robin Murphy <robin.murphy@arm.com>, "hch@lst.de" <hch@lst.de>
Subject: RE: [PATCH] dma: Per-NUMA-node CMA should depend on NUMA
Thread-Topic: [PATCH] dma: Per-NUMA-node CMA should depend on NUMA
Thread-Index: AQHWq5MUDdH3/+jmF0KiWtaQJmX8fKmqTnfw
Date: Mon, 26 Oct 2020 20:07:43 +0000
Message-ID: <75cad228694b4f1587265a887069b241@hisilicon.com>
References: <74b66725883f065eb7d156f866678abb5be934bd.1603714996.git.robin.murphy@arm.com>
In-Reply-To: <74b66725883f065eb7d156f866678abb5be934bd.1603714996.git.robin.murphy@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.203.184]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
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
> From: Robin Murphy [mailto:robin.murphy@arm.com]
> Sent: Tuesday, October 27, 2020 1:25 AM
> To: hch@lst.de
> Cc: iommu@lists.linux-foundation.org; linux-kernel@vger.kernel.org; Song Bao
> Hua (Barry Song) <song.bao.hua@hisilicon.com>
> Subject: [PATCH] dma: Per-NUMA-node CMA should depend on NUMA
> 
> Offering DMA_PERNUMA_CMA to non-NUMA configs is pointless.
> 

This is right.

> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  kernel/dma/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
> index c99de4a21458..964b74c9b7e3 100644
> --- a/kernel/dma/Kconfig
> +++ b/kernel/dma/Kconfig
> @@ -125,7 +125,8 @@ if  DMA_CMA
> 
>  config DMA_PERNUMA_CMA
>  	bool "Enable separate DMA Contiguous Memory Area for each NUMA
> Node"
> -	default NUMA && ARM64
> +	depends on NUMA
> +	default ARM64

On the other hand, at this moment, only ARM64 is calling the init code
to get per_numa cma. Do we need to
depends on NUMA && ARM64 ?
so that this is not enabled by non-arm64?

>  	help
>  	  Enable this option to get pernuma CMA areas so that devices like
>  	  ARM64 SMMU can get local memory by DMA coherent APIs.
> --
 
Thanks
Barry


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
