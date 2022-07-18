Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B99ECC
	for <iommu@lists.linux.dev>; Mon, 18 Jul 2022 10:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1658141321; x=1689677321;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ICBy3sF/NsNEHPOB6+kzZdomREf/FmWtWHtPkhQaSng=;
  b=q0s/jPId28MHwAd/QejBdwidKtXRbHU7UIM+DerkoY9dDBABcVY0rRDz
   1fs+V3d6yBmoBXS9HBnBo2pM0bDua5vTb92mkWOA8fw2ZCrTDWjyRaq7c
   6otCEut7o89hgGJ12sepHgXbDDRIPeDTrQ31+OiaW553ryVIRqP1EbAGI
   JauQFySg8zJfXAVFCyW5RENlVMETXD31SsjkGwVbXK5YFsqp2TfhGkSqs
   qdCDxgddykSeolZaWQSlGh0iw+yVPjGCYD8Xhs82kooWQ5a9V63Kkfn4M
   ECVPiCSyFYqjugWE03MYiquGupf3z5DPVDjJFqwrnLaeG9uLwcl/L6mQS
   g==;
X-IronPort-AV: E=Sophos;i="5.92,280,1650902400"; 
   d="scan'208";a="210984675"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jul 2022 18:47:33 +0800
IronPort-SDR: GXXQSHRDyf6bJuYAjMJty5GQ7TnSVtb6LalSnVwsUc0WNveGpZYVYRpXegwumo3YI2oWTnq8lX
 ISKKXqFCjPIEEDdYeEa6HFL8IGbZxSLMVVPH2fxHsVxZtlquRetNcJUTici5MCapHO9QUpLbVW
 CpD5A8ZWLfZ4fULpEYfyTeRKBIRHKfN+gYjBLV1P8nlxZgXLzJVfiNKkZQmd4XZjBpoy1IoHH2
 uRyuLAUkmVeeDdB122h4IErbXbWn4NBPZz3u6H0UexYTIKj7w2Bl1Po94pr4/BATVTKu7HQ1gy
 QduetzV3Oyw2p+gEmDlz7c5R
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Jul 2022 03:09:00 -0700
IronPort-SDR: A9vB2/mVDDQyzSFK0J3PUEG/feKMtfSaokEeECb2EiIAeHx79JQKy8cWEREn0i+d7hpsmakNMW
 EVKuoUw3oKg0vqeWxGLOLbVHZLGRZNTQhfXXBHhzNzWkEju3BnwgEhRXyaIRKPHRxOuFwnr5yX
 FsNwPr5MR+jtvFsEQYVytsb3VN1Vkns8Vqvs5NMlfFQAvulS91Jjdf4SeUgL5ycUGBRS/gkGWS
 9JScynvtMP6qpARvQT/cQFlgkR9CmeY0JJRAsxL/Vg+S3omBibiI1Ko3tHviXeYwJmd0fFgumr
 0Z4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Jul 2022 03:47:34 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Lmdvn5Dm0z1Rws7
	for <iommu@lists.linux.dev>; Mon, 18 Jul 2022 03:47:33 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)"
	header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	opensource.wdc.com; h=content-transfer-encoding:content-type
	:in-reply-to:organization:from:references:to:content-language
	:subject:user-agent:mime-version:date:message-id; s=dkim; t=
	1658141252; x=1660733253; bh=ICBy3sF/NsNEHPOB6+kzZdomREf/FmWtWHt
	PkhQaSng=; b=ffy3r4QzJl2eMxIGeYvZDxhndyaiLEBA6fObdRuA9MXXWuuAuiB
	zxy2PZue182NyNIs04OSk2RsuUJHRg1ElHOVGtXKOX0xUbQAqa615RJPLSPZbOk6
	tgjaNfOx5LbKyKliH7H1EJXWmR6bKjTbD2Lsjb0S+1zqNlcakLIYxDDMDF7pgJpm
	OyOGmOMuDR4RZuFjFX+RVZsMPb0VhGzJ2aDMcdHEUamVC3CuoZt8+m2Mcyb9bHLT
	malHx8Lm/DEhM60u7f8h6dsj57P5IU0HEjZ83ME2zYrTjqB6SFgHwzkujjGyAuUe
	WnQPWsMgLhRBfdAGPCNZOXKZ0yxHnoXANag==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
	by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id WIkFt30NVIke for <iommu@lists.linux.dev>;
	Mon, 18 Jul 2022 03:47:32 -0700 (PDT)
Received: from [10.225.163.120] (unknown [10.225.163.120])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Lmdvk2p0qz1RtVk;
	Mon, 18 Jul 2022 03:47:30 -0700 (PDT)
Message-ID: <6725df4f-4e27-3320-8b7b-22ba15a07866@opensource.wdc.com>
Date: Mon, 18 Jul 2022 19:47:29 +0900
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v6 4/6] scsi: sd: Allow max_sectors be capped at DMA
 optimal size limit
Content-Language: en-US
To: John Garry <john.garry@huawei.com>, joro@8bytes.org, will@kernel.org,
 jejb@linux.ibm.com, martin.petersen@oracle.com, hch@lst.de,
 m.szyprowski@samsung.com, robin.murphy@arm.com
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-ide@vger.kernel.org, iommu@lists.linux.dev,
 linux-scsi@vger.kernel.org, linuxarm@huawei.com
References: <1657797329-98541-1-git-send-email-john.garry@huawei.com>
 <1657797329-98541-5-git-send-email-john.garry@huawei.com>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <1657797329-98541-5-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/14/22 20:15, John Garry wrote:
> Streaming DMA mappings may be considerably slower when mappings go through
> an IOMMU and the total mapping length is somewhat long. This is because the
> IOMMU IOVA code allocates and free an IOVA for each mapping, which may
> affect performance.
> 
> New member Scsi_Host.opt_sectors is added, which is the optimal host
> max_sectors, and use this value to cap the request queue max_sectors when
> set.
> 
> It could be considered to have request queues io_opt value initially
> set at Scsi_Host.opt_sectors in __scsi_init_queue(), but that is not
> really the purpose of io_opt.
> 
> Finally, even though Scsi_Host.opt_sectors value should never be greater
> than the request queue max_hw_sectors value, continue to limit to this
> value for safety.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>  drivers/scsi/sd.c        | 2 ++
>  include/scsi/scsi_host.h | 1 +
>  2 files changed, 3 insertions(+)
> 
> diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
> index a1a2ac09066f..3eaee1f7aaca 100644
> --- a/drivers/scsi/sd.c
> +++ b/drivers/scsi/sd.c
> @@ -3296,6 +3296,8 @@ static int sd_revalidate_disk(struct gendisk *disk)
>  				      (sector_t)BLK_DEF_MAX_SECTORS);
>  	}
>  
> +	rw_max = min_not_zero(rw_max, sdp->host->opt_sectors);
> +

Adding a comment explaining what the cap is would be nice.

>  	/* Do not exceed controller limit */
>  	rw_max = min(rw_max, queue_max_hw_sectors(q));
>  
> diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
> index 667d889b92b5..d32a84b2bb40 100644
> --- a/include/scsi/scsi_host.h
> +++ b/include/scsi/scsi_host.h
> @@ -607,6 +607,7 @@ struct Scsi_Host {
>  	short unsigned int sg_tablesize;
>  	short unsigned int sg_prot_tablesize;
>  	unsigned int max_sectors;
> +	unsigned int opt_sectors;
>  	unsigned int max_segment_size;
>  	unsigned long dma_boundary;
>  	unsigned long virt_boundary_mask;

Otherwise, looks good.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research
