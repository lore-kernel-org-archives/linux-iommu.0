Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE40DEC5
	for <iommu@lists.linux.dev>; Thu, 30 Jun 2022 23:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656632579; x=1688168579;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HnKju8kjGOSRgTCWdAK1YkRQ7CqpE1nsYg1ASv8QOFQ=;
  b=Nj8QUOy2bGrfs5K6hjUcPCFobXd3To29JHiqsCa6YVXn801wek5xs7JT
   +afklpsptTAMe7INem1ayT/ar2sNP8s6bety4TSnxZ/hLqCzfiCMrHOYV
   1J7AH96iPQKw+ZWku76V4Jd9bXtWIGf/CEQ3MTGXWYvipuUXxtn+b5iDy
   YtPXVhLZcwG0DKl1r4E/l2u0Lw+fStb+qXoa1YR4T65jdBgZiiVZ0lAv2
   PtoIsIsUDqB1WAjjTvoR+9f4La07Q7ZYzCT+4Mm0MdF3GlloA8Nxobp4T
   Ni/g6Ko3gnSnd3RDkgRc0//0sirfv7UwrMR8thPUnTOi8jzz2wAkXpxaW
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,235,1650902400"; 
   d="scan'208";a="204534658"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 01 Jul 2022 07:41:48 +0800
IronPort-SDR: 8CZpRwsYOZzfYUAwoadPkxuNdssaZeSlDKRVlnSJgwQfLwTGkvRbgVRGCEM6HA1kgtkawouoi2
 208m9anYS3WLYdQG+SVLN3yMDZvCwecGjwxPwtJXLri2ah960BsOOCTFcwJXRIoeWJdul233Cr
 SCNF817XpKRR4ONhuEd65kjhmjW7z8zwnKh5SRxSQQfdnTSRKUmjc+quL3TYcHWcXu7Wi0fYVV
 lZoRonSedOYqu2KlZi6HhUkEh/VS3IF7Y42n6YCE43E4Nq+uROHqrBvtnUnYeGhHJwn1LDUwXk
 MPhg+DZrFlksF+p7jzSvKozM
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jun 2022 16:04:01 -0700
IronPort-SDR: RG8GqkYadn8ZXwy/D/H+w+u+ryx8lepCo/nKF16EVb++qQmZObIRlAiBpuUAj8d0KdSTqVWrSq
 v9PxglaHvvnUKkvhBZLph/GJYpYTUpKgHYZy52Bc5NcYdKxZ5JKvOFHwJAxYgUneCG266lYI0+
 5kcVhbcGZIxMKvl8GBnurE658MhqgtcUKx9ktD4N5mce8mtKFFmkSaWmLpRKlBkGaL0oDHFJsA
 gPjfPYacEf7lWkHlXlgPmpWC6mBymIDGzoYfn7a2xSHkDJo3h5G+HGSNyMPddNEkpCpFr8l0Eq
 CbM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jun 2022 16:41:49 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LYvxS50cGz1Rw4L
	for <iommu@lists.linux.dev>; Thu, 30 Jun 2022 16:41:48 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)"
	header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	opensource.wdc.com; h=content-transfer-encoding:content-type
	:in-reply-to:organization:from:references:to:content-language
	:subject:user-agent:mime-version:date:message-id; s=dkim; t=
	1656632503; x=1659224504; bh=HnKju8kjGOSRgTCWdAK1YkRQ7CqpE1nsYg1
	ASv8QOFQ=; b=fdFA/DMDUNnWuoxJvFEs4k2Sfhy5E++sWBTPTy7Eka2qQe5b4mq
	K1cqPQRJIRjxU4I+lTd3cniw8UUNIt4E1vRoLMmXU/+WW8sNXEtQGCeQQ62ueY27
	BkMHptRLqxK7DSBl1PVhxn0Q2raAR55Vjk2ftBKTTqbj5snr7GAzxAAQsLoEC3d8
	moh50EvOR0sbHP4CjAhaFDbFTlgb/9bJrklDerRkifo/RFZLxf5XiVdXksiz+kOO
	VLi038cZnQfYw0wPVMb8pi6gv3iAaCAVcSGneOiK8xo0rse7dZlPYJUEnZcEJzMF
	p67yuDm7TRtgrBenfZLtsyYUVg6E4bj6K1g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
	by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id X9Bs6-8peQU1 for <iommu@lists.linux.dev>;
	Thu, 30 Jun 2022 16:41:43 -0700 (PDT)
Received: from [10.225.163.102] (unknown [10.225.163.102])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LYvxJ3cq3z1RtVk;
	Thu, 30 Jun 2022 16:41:40 -0700 (PDT)
Message-ID: <5f79d8e7-0035-cfb0-d612-3e1c7f243f22@opensource.wdc.com>
Date: Fri, 1 Jul 2022 08:41:39 +0900
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v5 3/5] scsi: core: Cap shost max_sectors according to DMA
 limits only once
Content-Language: en-US
To: John Garry <john.garry@huawei.com>, joro@8bytes.org, will@kernel.org,
 jejb@linux.ibm.com, martin.petersen@oracle.com, hch@lst.de,
 m.szyprowski@samsung.com, robin.murphy@arm.com
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-ide@vger.kernel.org, iommu@lists.linux-foundation.org,
 iommu@lists.linux.dev, linux-scsi@vger.kernel.org, linuxarm@huawei.com
References: <1656590892-42307-1-git-send-email-john.garry@huawei.com>
 <1656590892-42307-4-git-send-email-john.garry@huawei.com>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <1656590892-42307-4-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID: <20220630234139.BOnw8NZMQKyMIiuwJ118WHHfJVFGdDf88yqP1W6YFjg@z>

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
