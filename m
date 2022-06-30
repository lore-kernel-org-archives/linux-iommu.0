Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 334F1C43334
	for <iommu@archiver.kernel.org>; Thu, 30 Jun 2022 23:41:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id AE40D40236;
	Thu, 30 Jun 2022 23:41:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AE40D40236
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=adpt6bQB;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=opensource.wdc.com header.i=@opensource.wdc.com header.a=rsa-sha256 header.s=dkim header.b=P9iYGd3H
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jFOYMeJHFx0r; Thu, 30 Jun 2022 23:41:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 779A6401DF;
	Thu, 30 Jun 2022 23:41:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 779A6401DF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4DC5BC002D;
	Thu, 30 Jun 2022 23:41:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 90918C0011
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jun 2022 23:41:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5BEDC404C0
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jun 2022 23:41:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5BEDC404C0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bSXlIuBZw6Bi for <iommu@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 23:41:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 87EC4401DF
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 87EC4401DF
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jun 2022 23:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1656632504; x=1688168504;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=HnKju8kjGOSRgTCWdAK1YkRQ7CqpE1nsYg1ASv8QOFQ=;
 b=adpt6bQBy7vdwblR+2PyMA3FjWDFqvAaLgZfrk/a9pgKuzBW2d+5oK1M
 dm2vOo65HMZgPx6PY5vaFR3fnjq/fBISQ5tz1RxZqx0O+xDL3SjgFSJYs
 E1DLVm7xygghootonaW+rbadWs68r0Th9xGElbwg1lj0roxcRxXR9Ei0s
 J50+yLY2dplRW2/BMEXLGkyGiNwPd75XoZlNCOIacucnDi/RaJhTiEwJa
 PVhs4NlA42wB46yrvRGMAKjDkHs32jYY1GhRvxW+LaAfeHbVJc5N5Re+g
 EzCbKroWLMzdSFYb/+JtKGRXPbW42Qq+m8APF9K7WcPxNwrkoVPSiBiPi w==;
X-IronPort-AV: E=Sophos;i="5.92,235,1650902400"; d="scan'208";a="204534653"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 01 Jul 2022 07:41:42 +0800
IronPort-SDR: Vj9NxWhNTQokCqnniN5m/73T2Qv8KJ4bt7o5pISK1WDOum0KVmnKU2b6IO6OB++c9P4cAf+riK
 BtYWAJ1Sx0fjm4nUiU3DwO806TbEt9oo4ruOsu9wvDhmOTgCfjMho13OY4hU9+IYvClr3uw5uI
 XDCx+eKW7vOYr7kqtiuilruSR87+sgpjzS3OOWJwRuDIIczoSqgKrXoOHXxXRX91feeDf6734B
 +a+YLx6uuzyPkWAdUFHjmOIVcQsD0MVMr3X/2skfJ5lQjsenXR3b9zEm8i021aiWgFlDZMMg1Z
 SDQ+sdIfPzw0emq9gsbdkevS
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 30 Jun 2022 15:59:17 -0700
IronPort-SDR: n6rG0SwlsiHXARUwsgXNWlReXX2xcTEs5Tc9PfSMZH8GQUV/jT/TF36phR6fNrdx5bwFLCoSHW
 VB8L5K3gybBd2onblSxPvtjDZdcIz0sRZlKVi8MYvveM87U40zMyUG2pQsCuVgHj+483NbkhLp
 PldvgZqtmKP9RIKKtxmmv9LKSLY7IOAKkjARsjr0mE3sT4kMyfku33OXmdBJa62yZyOPTBlbXr
 bumr5LeW9DdMCSdcZcI0jNZ2nCM9NplybuOaEuE7KO/yEWEKY60Ikm4hsEOyksiKtB3R/VczB0
 Jlc=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
 by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 30 Jun 2022 16:41:44 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LYvxM3wZtz1Rw4L
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jun 2022 16:41:43 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
 reason="pass (just generated, assumed good)"
 header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
 opensource.wdc.com; h=content-transfer-encoding:content-type
 :in-reply-to:organization:from:references:to:content-language
 :subject:user-agent:mime-version:date:message-id; s=dkim; t=
 1656632502; x=1659224503; bh=HnKju8kjGOSRgTCWdAK1YkRQ7CqpE1nsYg1
 ASv8QOFQ=; b=P9iYGd3HCrOxjqwh9g498JZGUki12Yfnka0lruYdSrS51RQi9dB
 4C36ZcMv5PQ2ayLdnbSLbZFyCziR2qZ7NXX02FI2JtsEHBvJv0K+hVe/JpmkW3o5
 lzjaWmF/XO4hGnvVhA4SNMmXmn6NIEWc/pkOeRZYh6Uwbf+8LWcpJxiTS48GyJJ7
 EQSNyd/s8Zs1i7oqHOHKMKajVL16c+qo9RZWXdRIMMXV2PsmkGXpOfiYKukihmBD
 Eryw0wrAkirDxdsAy1lHf/eBUFwKd9eWuvO7B6Rj359rXI/h4+M+Hj6pAM0FKdeU
 arXm7l4IWe9UTRVWxp8up6NLQqov8cKXlSQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
 by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new,
 port 10026)
 with ESMTP id MaWrMpu31G-h for <iommu@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 16:41:42 -0700 (PDT)
Received: from [10.225.163.102] (unknown [10.225.163.102])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LYvxJ3cq3z1RtVk;
 Thu, 30 Jun 2022 16:41:40 -0700 (PDT)
Message-ID: <5f79d8e7-0035-cfb0-d612-3e1c7f243f22@opensource.wdc.com>
Date: Fri, 1 Jul 2022 08:41:39 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v5 3/5] scsi: core: Cap shost max_sectors according to DMA
 limits only once
Content-Language: en-US
To: John Garry <john.garry@huawei.com>, joro@8bytes.org, will@kernel.org,
 jejb@linux.ibm.com, martin.petersen@oracle.com, hch@lst.de,
 m.szyprowski@samsung.com, robin.murphy@arm.com
References: <1656590892-42307-1-git-send-email-john.garry@huawei.com>
 <1656590892-42307-4-git-send-email-john.garry@huawei.com>
Organization: Western Digital Research
In-Reply-To: <1656590892-42307-4-git-send-email-john.garry@huawei.com>
Cc: linux-scsi@vger.kernel.org, linux-doc@vger.kernel.org, linuxarm@huawei.com,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
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
From: Damien Le Moal via iommu <iommu@lists.linux-foundation.org>
Reply-To: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 6/30/22 21:08, John Garry wrote:
> The shost->max_sectors is repeatedly capped according to the host DMA
> mapping limit for each sdev in __scsi_init_queue(). This is unnecessary, so
> set only once when adding the host.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>  drivers/scsi/hosts.c    | 5 +++++
>  drivers/scsi/scsi_lib.c | 4 ----
>  2 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c
> index 8352f90d997d..d04bd2c7c9f1 100644
> --- a/drivers/scsi/hosts.c
> +++ b/drivers/scsi/hosts.c
> @@ -236,6 +236,11 @@ int scsi_add_host_with_dma(struct Scsi_Host *shost, struct device *dev,
>  
>  	shost->dma_dev = dma_dev;
>  
> +	if (dma_dev->dma_mask) {
> +		shost->max_sectors = min_t(unsigned int, shost->max_sectors,
> +				dma_max_mapping_size(dma_dev) >> SECTOR_SHIFT);
> +	}

Nit: you could remove the curly brackets... But it being a multi-line
statement, having them is OK too I think.

> +
>  	error = scsi_mq_setup_tags(shost);
>  	if (error)
>  		goto fail;
> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> index 6ffc9e4258a8..6ce8acea322a 100644
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

Looks good.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
