Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C37A4CCA473
	for <iommu@archiver.kernel.org>; Fri, 24 Jun 2022 16:48:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5C98061494;
	Fri, 24 Jun 2022 16:48:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5C98061494
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=y/IbSUpX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YTCwQZqPY9KF; Fri, 24 Jun 2022 16:48:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0C19360DC6;
	Fri, 24 Jun 2022 16:48:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0C19360DC6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C4813C0039;
	Fri, 24 Jun 2022 16:48:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3049EC002D
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jun 2022 16:48:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F08A8425E6
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jun 2022 16:48:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F08A8425E6
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=y/IbSUpX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KZl48_TGgtWB for <iommu@lists.linux-foundation.org>;
 Fri, 24 Jun 2022 16:48:39 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 065E041C9B
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 065E041C9B
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jun 2022 16:48:38 +0000 (UTC)
Received: by mail-pl1-x631.google.com with SMTP id d5so2562434plo.12
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jun 2022 09:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=7vaOGSSaS2BSeF0eCGOBdnJBKLvorCKIGcPWI6JfN0M=;
 b=y/IbSUpXpt2dGe1jDFLOsSSUkh1YBHRUnJmUb8sFZZm5NLih02wnUPXYt5zjjKeypb
 5Ffpu8piazgJRDNC42kW6T6j1S8K0mebrE7N0RwQPnfu+w8dFmATyybUe8Li6Ax2Pbsq
 6i0tJIm6mnulrZuaP8LlD+bk0IDIh7ztPilxJLZ2r82xW5PSaATQjSK6ypPckDxrjzPQ
 1bJK58MfXrbD6UbHeCtj6QwHeNzd3TOhfuFAniLjlYZ5xRUrZA93EYYGbms/FfDtCwRZ
 fD3/L6ZsvUORcp5roVkzX0bDUqQJrvcXD+t6BkwOR2kijU8lP3ghEMss2dpRQ7RGgeA7
 3xtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=7vaOGSSaS2BSeF0eCGOBdnJBKLvorCKIGcPWI6JfN0M=;
 b=q3cp5okjNoG6dTGZxVW02nhX31sgwsN6S9I5mpDPsEPOUn6dJXrcnnvHj3XNPybPUs
 mfD42Vqscc0AvRO33l+BbGox6WCKS31QHgj1YEirG1ZNzlX0DoJqmCsZo4KDo09uMVD8
 ylDBKIooM64cSsaaZJOLPVThsmQoORytjpRmNUXJ/084Ywl6sA7mWMsUENTlU9sFQYLr
 CrcU3SC1NX5B/bjcOrrNyKMytWArZx47zWNozH6QTVvwWrlAf9UDokwcqWlWl8+mu9Pk
 w0LtJ72mkUwj+akZmR9ORrEJ+3jT9oz0383F+wPpnOpXX1uhuzIoQVxuNyU8LVQeBbNd
 +94Q==
X-Gm-Message-State: AJIora/r3txC2NGvoatrrquY7jnQrV5R+TwC/4BvhRVfORkYuSrg5yx/
 9SNQv1l0IaJg7AmTzHZHfi9NtQ==
X-Google-Smtp-Source: AGRyM1sMTKHk1czlE8w1vn1du6WoyJEAfH19Gy+e0hnTwhXskgrBEnEhnbwsZHR1W2asFkceOKtghg==
X-Received: by 2002:a17:902:e8d7:b0:168:e2da:893c with SMTP id
 v23-20020a170902e8d700b00168e2da893cmr45709631plg.152.1656089318365; 
 Fri, 24 Jun 2022 09:48:38 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
 by smtp.gmail.com with ESMTPSA id
 h9-20020a170902f70900b001663cf001besm2033477plo.174.2022.06.24.09.48.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jun 2022 09:48:36 -0700 (PDT)
Date: Fri, 24 Jun 2022 10:48:34 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Subject: Re: [PATCH 0/2] dma-mapping, remoteproc: Fix dma_mem leak after
 rproc_shutdown
Message-ID: <20220624164834.GA1736477@p14s>
References: <20220422062436.14384-1-mark-pk.tsai@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220422062436.14384-1-mark-pk.tsai@mediatek.com>
Cc: yj.chiang@mediatek.com, linux-remoteproc@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
 robin.murphy@arm.com, hch@lst.de, linux-arm-kernel@lists.infradead.org
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

On Fri, Apr 22, 2022 at 02:24:34PM +0800, Mark-PK Tsai wrote:
> Release dma coherent memory before rvdev is free in
> rproc_rvdev_release().
> 
> Below is the kmemleak report:
> unreferenced object 0xffffff8051c1a980 (size 128):
>   comm "sh", pid 4895, jiffies 4295026604 (age 15481.896s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<000000003a0f3ec0>] dma_declare_coherent_memory+0x44/0x11c
>     [<00000000ad243164>] rproc_add_virtio_dev+0xb8/0x20c
>     [<00000000d219c8e9>] rproc_vdev_do_start+0x18/0x24
>     [<00000000e694b468>] rproc_start+0x22c/0x3e0
>     [<000000000b938941>] rproc_boot+0x4a4/0x860
>     [<000000003c4dc532>] state_store.52856+0x10c/0x1b8
>     [<00000000df2297ac>] dev_attr_store+0x34/0x84
>     [<0000000083a53bdb>] sysfs_kf_write+0x60/0xbc
>     [<000000008ed830df>] kernfs_fop_write+0x198/0x458
>     [<0000000072b9ad06>] __vfs_write+0x50/0x210
>     [<00000000377d7469>] vfs_write+0xe4/0x1a8
>     [<00000000c3fc594e>] ksys_write+0x78/0x144
>     [<000000009aef6f4b>] __arm64_sys_write+0x1c/0x28
>     [<0000000003496a98>] el0_svc_common+0xc8/0x22c
>     [<00000000ea3fe7a3>] el0_svc_compat_handler+0x1c/0x28
>     [<00000000d1a85a4e>] el0_svc_compat+0x8/0x24
> 
> Mark-PK Tsai (2):
>   dma-mapping: Add dma_release_coherent_memory to DMA API
>   remoteproc: Fix dma_mem leak after rproc_shutdown
> 
>  drivers/remoteproc/remoteproc_core.c |  1 +
>  include/linux/dma-map-ops.h          |  3 +++
>  kernel/dma/coherent.c                | 10 ++++++++--
>  3 files changed, 12 insertions(+), 2 deletions(-)

Applied.

Thanks,
Mathieu

> 
> -- 
> 2.18.0
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
