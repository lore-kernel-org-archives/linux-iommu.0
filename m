Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E499C433FE
	for <iommu@archiver.kernel.org>; Sat, 21 May 2022 00:06:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D692A426C1;
	Sat, 21 May 2022 00:06:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id T_cilLZvSfL0; Sat, 21 May 2022 00:06:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2A052426B7;
	Sat, 21 May 2022 00:06:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F04B5C0032;
	Sat, 21 May 2022 00:06:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D110AC002D
 for <iommu@lists.linux-foundation.org>; Fri, 20 May 2022 23:30:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A9CF6847C9
 for <iommu@lists.linux-foundation.org>; Fri, 20 May 2022 23:30:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=wdc.com header.b="Cdhxwvv8";
 dkim=pass (2048-bit key) header.d=opensource.wdc.com
 header.b="Nk8Hxo8+"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iVS3j0z4E9LY for <iommu@lists.linux-foundation.org>;
 Fri, 20 May 2022 23:30:38 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EAAEE847C4
 for <iommu@lists.linux-foundation.org>; Fri, 20 May 2022 23:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1653089439; x=1684625439;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=mC23Js+fgQ42aR1x1h3Crwa5qeNduvEcgjySjZ6gkSE=;
 b=Cdhxwvv8UENU76yQZk09raIt7JYswpWr96ncTec/7notDTqY+D/fe+B2
 HALPCE5QjC/MEjVA8BV2VUKx3OWOjANOA9cShaRhXOp19LsSVA+EO9/0g
 RY2kn7reYeQ1/aRxcjJ/KADtHor+M0cw8jl+OwBPN2ncno/YR7BQYwA5H
 N+dku+bqcPo68+WknCVLT4WHTmhF0Qqn8j5D0WBUGK8PvzvFmYvb086YV
 +XHbUC4HoGGvx9lOLMMXXmpWc+TW5Nu93kcrMBePzVT1r1rg+Zdw+5Do9
 RGX2DzyIOH/b3voLbQjCJo3dwCMkNQ3t/6xdI77Tv+y+YNXT4gSgux8vD A==;
X-IronPort-AV: E=Sophos;i="5.91,240,1647273600"; d="scan'208";a="201808511"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 21 May 2022 07:30:37 +0800
IronPort-SDR: Tr+KKgNLeg/k+yyT+pDW7YG6NuZY8VS5u7melzY4/28VW26jtocvEj1IXo53TPpuryt51hGmo3
 vC55QKryiyRNGIqR100B5oQiAi2xNFEdMsGi0WJM4/tWSJXVP+68xts32Wz5ZXk+akHj8oF3WD
 g4PtUpsMrINEM2IsxZmQu0lVV1eoXfpQ9EMn0f0ROA7PDaWclyT7Vu4VAKUIKt8RPvS3pkSCQ3
 4HYUVQCYXRxBokxNiHM22CD/0DIUaBV40sdQPIdIQKDEtOV2W/GEk6lvzIs75KnjgQcHH/eWu4
 0F+nPlUo8iNQJfC1DRPs1Lcl
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 20 May 2022 15:55:57 -0700
IronPort-SDR: avXC3LBzzKO2FQQAQnWZ0c6RvTAhSOI+lafDtuXyOCWq2TVpBPhbZPSOPPZJmziGJ4ijZp80Iu
 fmDs3kr1uFSI4lqmVjRKbgC+jPj8eyrs79U/0d30e9niVVnQY9E+9krwvIeWJsgvThk9g7iDcL
 To6/jVdbU43CSgZTgb7VTYJfSJr7SkAEMdCZSZgk5sAY1tLIK/7ge/ACMVqDmNrC8LfLcMAE1a
 2h6Toi32mBABiZcgHC37Gosm5m+2AVqfNfsqEakaZubsp4r8+LFsApx8Xz98E8nMNDaxO9r5Vu
 N4M=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
 by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 20 May 2022 16:30:36 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4L4jdR1ZnVz1SVnx
 for <iommu@lists.linux-foundation.org>; Fri, 20 May 2022 16:30:35 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
 reason="pass (just generated, assumed good)"
 header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
 opensource.wdc.com; h=content-transfer-encoding:content-type
 :in-reply-to:organization:from:references:to:content-language
 :subject:user-agent:mime-version:date:message-id; s=dkim; t=
 1653089434; x=1655681435; bh=mC23Js+fgQ42aR1x1h3Crwa5qeNduvEcgjy
 SjZ6gkSE=; b=Nk8Hxo8+XR7/VqUuVjQ5LqiJPLj5h7vTFa/tWJg11fe3HCm13hn
 b70LJIxRTW43v6GNhZEwLiDvFaFUAxs5i/nG5e8PxJF5WO463aNgJ+xmnTYRjBd7
 RySZ5jWJQqmIkDz+LEeoz6rIgGGNzuDQvDMbRxWGmyyV/cFJpPkw7DHXKHdH+Lft
 6PpNvvml7iiRSpRAP8MLMUrxTHuF/uloCDy+a6pQuQj/F8pwNU+gx8m5uBoht8hf
 0vnnpYuYTOx/aDHe1k3AR1MO/x4gSoAgX7Cjl4VgQeD74fncW/Y75z2TrB7/CZMp
 nZEBM0HcRilBjsU7QQ79PFhTR/8WUDihf0A==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
 by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new,
 port 10026)
 with ESMTP id nSc7lFn6cJu2 for <iommu@lists.linux-foundation.org>;
 Fri, 20 May 2022 16:30:34 -0700 (PDT)
Received: from [10.225.163.51] (unknown [10.225.163.51])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4L4jdM62rXz1Rvlc;
 Fri, 20 May 2022 16:30:31 -0700 (PDT)
Message-ID: <e65e7329-67e3-016f-e213-86e51b8021d6@opensource.wdc.com>
Date: Sat, 21 May 2022 08:30:30 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 3/4] scsi: core: Cap shost max_sectors according to DMA
 optimum mapping limits
Content-Language: en-US
To: John Garry <john.garry@huawei.com>, joro@8bytes.org, will@kernel.org,
 jejb@linux.ibm.com, martin.petersen@oracle.com, hch@lst.de,
 m.szyprowski@samsung.com, robin.murphy@arm.com
References: <1653035003-70312-1-git-send-email-john.garry@huawei.com>
 <1653035003-70312-4-git-send-email-john.garry@huawei.com>
Organization: Western Digital Research
In-Reply-To: <1653035003-70312-4-git-send-email-john.garry@huawei.com>
X-Mailman-Approved-At: Sat, 21 May 2022 00:06:20 +0000
Cc: linux-scsi@vger.kernel.org, linux-doc@vger.kernel.org,
 liyihang6@hisilicon.com, linux-kernel@vger.kernel.org,
 linux-ide@vger.kernel.org, iommu@lists.linux-foundation.org
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
From: Damien Le Moal via iommu <iommu@lists.linux-foundation.org>
Reply-To: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 5/20/22 17:23, John Garry wrote:
> Streaming DMA mappings may be considerably slower when mappings go through
> an IOMMU and the total mapping length is somewhat long. This is because the
> IOMMU IOVA code allocates and free an IOVA for each mapping, which may
> affect performance.
> 
> For performance reasons set the request_queue max_sectors from
> dma_opt_mapping_size(), which knows this mapping limit.
> 
> In addition, the shost->max_sectors is repeatedly set for each sdev in
> __scsi_init_queue(). This is unnecessary, so set once when adding the
> host.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>  drivers/scsi/hosts.c    | 5 +++++
>  drivers/scsi/scsi_lib.c | 4 ----
>  2 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c
> index f69b77cbf538..a3ae6345473b 100644
> --- a/drivers/scsi/hosts.c
> +++ b/drivers/scsi/hosts.c
> @@ -225,6 +225,11 @@ int scsi_add_host_with_dma(struct Scsi_Host *shost, struct device *dev,
>  	shost->cmd_per_lun = min_t(int, shost->cmd_per_lun,
>  				   shost->can_queue);
>  
> +	if (dma_dev->dma_mask) {
> +		shost->max_sectors = min_t(unsigned int, shost->max_sectors,
> +				dma_opt_mapping_size(dma_dev) >> SECTOR_SHIFT);
> +	}

Nit: you could drop the curly brackets here.

> +
>  	error = scsi_init_sense_cache(shost);
>  	if (error)
>  		goto fail;
> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> index 8d18cc7e510e..2d43bb8799bd 100644
> --- a/drivers/scsi/scsi_lib.c
> +++ b/drivers/scsi/scsi_lib.c
> @@ -1884,10 +1884,6 @@ void __scsi_init_queue(struct Scsi_Host *shost, struct request_queue *q)
>  		blk_queue_max_integrity_segments(q, shost->sg_prot_tablesize);
>  	}
>  
> -	if (dev->dma_mask) {
> -		shost->max_sectors = min_t(unsigned int, shost->max_sectors,
> -				dma_max_mapping_size(dev) >> SECTOR_SHIFT);
> -	}
>  	blk_queue_max_hw_sectors(q, shost->max_sectors);
>  	blk_queue_segment_boundary(q, shost->dma_boundary);
>  	dma_set_seg_boundary(dev, shost->dma_boundary);

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
