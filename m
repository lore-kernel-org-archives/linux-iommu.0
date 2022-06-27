Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21F93229
	for <iommu@lists.linux.dev>; Mon, 27 Jun 2022 23:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656372322; x=1687908322;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=S8N+p0moc3MloWqEEauJLXVpb/5eTV2AD6EVivHGR+Q=;
  b=Xr7Bp28sIjV1QUqJkwht3XZTeRmMGhmZsCf5utVkqmK1wAqIhWjPCiCW
   kiUFg/ycBNK+3zNd4QWD3h1ENrm3mQB4QIunpJFWvI8CDFc9wCRncqVyS
   tOMnHVMcIj6H2sTx4Rj37VFUgmjyv38HWM8HLjd5HTHpWBnxZV0EbBxHi
   W1PRbM7eafCamuHKk7pUge29he/G8dmp7KNBMR3MLybQlTbhgqGVTY2hX
   ML+QecaZ4tzyMx4Vib3blDeO+Ejf1I4S/9uTcUNZT7UI2Zs37DlqW9LaK
   bfpCrk9imi+XaMOAAlsWEydyKToaxNeC8ZdhyXMy1b0jHrmJbKc5B5Rod
   w==;
X-IronPort-AV: E=Sophos;i="5.92,227,1650902400"; 
   d="scan'208";a="316342591"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jun 2022 07:24:14 +0800
IronPort-SDR: OGvQM7G2u0FDdgd4iuxXChA2yhwkxZfe+monG3d7fjMdjKBwfxVvbiRVylyABi1qgdz843QHoP
 s++IHpCxZ/f0hsIeMztm8pe3NrIwX5ppekQVUdgSMpPncR+RI3ERmfQ9OsqlQL3unmbKHlz+we
 SEyevS80mbw1xhKTf8Szsaj5lfNIYtONbmJxmUuUR6VPpMVFkIHSqSuzGL93jgvIpKHNEzR9N1
 UuLxH0AHTHt5Q5HDj/+SNaKZwqeLY4k8OQzkCwnhlfgcmhZH5633nVksyz30gMZDXqsBzvIbbL
 6dYti9rwI2LOuvq4pUmOEu69
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Jun 2022 15:46:36 -0700
IronPort-SDR: 82ccldV4X6jZiNan/ZZVuzJGkz7X8r0qvSATWEATvTl15v6ksJWf/vVIbh+++KK35o+z8pnEVr
 snTBMniAoCEIHsfCRqiAtT52lBpK39XrwIL3+aCqmVHhO+PIBmXS07ZUNvYWDwskxRj/O7P7N+
 lIJIMphs5YY4PeV/t1NQmtLcifPwuSfdmCjoeZUPBkl5tf3KN9GoW34zlLLkWo9csxh0W0CA+g
 Eq7Bt3WJgs4rcAnwwGjm1I+ChyvgH40zqzfQJLvErQ71RMBFNOzqRxIiLYPdIyLhKnGixqOr+h
 Wbw=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Jun 2022 16:24:14 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LX3hY5hfZz1Rws9
	for <iommu@lists.linux.dev>; Mon, 27 Jun 2022 16:24:13 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)"
	header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	opensource.wdc.com; h=content-transfer-encoding:content-type
	:in-reply-to:organization:from:references:to:content-language
	:subject:user-agent:mime-version:date:message-id; s=dkim; t=
	1656372253; x=1658964254; bh=S8N+p0moc3MloWqEEauJLXVpb/5eTV2AD6E
	VivHGR+Q=; b=lh+Tk4Jv063rd1udyttDvM/8TxvedbRcRkj0NzA/f3V3fi9EDSj
	FiElQ1SrBdoes9IhtsS2IEWG8dJOQkfeqF5uYIrlu53qf5wuRsyO1sCa7nUFMy5i
	TEM/IQLLtxKeEbLYOKlnYLg5Edd2El8t1ZaALozmQVqg2+mSU+jKm6i8mPGWupQK
	LKyXbCciOStUrocicuIVJ/ZT6pK6F2/WiTkxukTX6lX5gPjfCgv7XA4jL5XmLv8A
	FXhgCvwJislg2YkCoqQFBoBMYNHgrfWc+CP8eY//j5KU5Ko24M9/QzUx7Luh2FIM
	9SX3HkWjJGd8LGIjh7aMdNYLBttsnm8nZ/Q==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
	by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id gwCiLXKjKAdp for <iommu@lists.linux.dev>;
	Mon, 27 Jun 2022 16:24:13 -0700 (PDT)
Received: from [10.225.163.99] (unknown [10.225.163.99])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LX3hV0cq4z1RtVk;
	Mon, 27 Jun 2022 16:24:09 -0700 (PDT)
Message-ID: <b69c6112-98b7-3890-9d11-bb321a7c877a@opensource.wdc.com>
Date: Tue, 28 Jun 2022 08:24:08 +0900
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v4 5/5] libata-scsi: Cap ata_device->max_sectors according
 to shost->max_sectors
Content-Language: en-US
To: John Garry <john.garry@huawei.com>, joro@8bytes.org, will@kernel.org,
 jejb@linux.ibm.com, martin.petersen@oracle.com, hch@lst.de,
 m.szyprowski@samsung.com, robin.murphy@arm.com
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-ide@vger.kernel.org, iommu@lists.linux-foundation.org,
 iommu@lists.linux.dev, linux-scsi@vger.kernel.org, linuxarm@huawei.com
References: <1656343521-62897-1-git-send-email-john.garry@huawei.com>
 <1656343521-62897-6-git-send-email-john.garry@huawei.com>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <1656343521-62897-6-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID: <20220627232408.Gy0I42zq7jzNwydP10JNiMnrsqnUdCfDvzRUAmbUhJM@z>

On 6/28/22 00:25, John Garry wrote:
> ATA devices (struct ata_device) have a max_sectors field which is
> configured internally in libata. This is then used to (re)configure the
> associated sdev request queue max_sectors value from how it is earlier set
> in __scsi_init_queue(). In __scsi_init_queue() the max_sectors value is set
> according to shost limits, which includes host DMA mapping limits.
> 
> Cap the ata_device max_sectors according to shost->max_sectors to respect
> this shost limit.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> Acked-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

Nit: please change the patch title to "ata: libata-scsi: Cap ..."

> ---
>  drivers/ata/libata-scsi.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 86dbb1cdfabd..24a43d540d9f 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -1060,6 +1060,7 @@ int ata_scsi_dev_config(struct scsi_device *sdev, struct ata_device *dev)
>  		dev->flags |= ATA_DFLAG_NO_UNLOAD;
>  
>  	/* configure max sectors */
> +	dev->max_sectors = min(dev->max_sectors, sdev->host->max_sectors);
>  	blk_queue_max_hw_sectors(q, dev->max_sectors);
>  
>  	if (dev->class == ATA_DEV_ATAPI) {


-- 
Damien Le Moal
Western Digital Research
