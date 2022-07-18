Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73787ECC
	for <iommu@lists.linux.dev>; Mon, 18 Jul 2022 10:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1658141351; x=1689677351;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7rBMGEx1YSGdVB6fbYn5Y5KkPOqfQscgrLN9anE2Owo=;
  b=aDbbYy/6SQcs0mhOKIZkXKDXWynhzGsUuU9Iwj8gxhQrg2FSi8ezqkU+
   z0Dhrt5n/voM/6O+IbggO6CvBtwKo1sAqUg3Ov1Pwo1HP69251wt38ZVt
   BX0pM1sdbiqzPOeKtBbIm0R6Xz2kYpCpLxk7K4gapvXd1eMWqTYbbzvoI
   51RqMn0JHVVjF0pvPDIhwkR8xVT3VpvwfeWkZhZqD3dADQNVFqk1PCt2n
   g1/9hr6XYQRV9JQeiorbbWRQlWqkvSuaV5Bxd+Aog0lK8COaS3hd2Ljgu
   kwxsjHmobvMIPaHwaac053gUIwHqVr62BgmMHkbk8bmFq5O17JxIG4gdM
   w==;
X-IronPort-AV: E=Sophos;i="5.92,280,1650902400"; 
   d="scan'208";a="310361195"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jul 2022 18:48:01 +0800
IronPort-SDR: EAkcZx1ZL46aKn0nWgdMXlzTFj7P007yyCWem9iutwQmQBtL+5ChQPjAFw4954gbFzBMKqJVrh
 cNfLE98CRZzItvb7MqMqhgAlg0eE/3qELAg2uA1ze8qtFoiCrmd/rKkaTI8kTfU4qcdjQS4xsS
 xY3LBtR+59jIAoqxwV/jnCUsTzMsLZDOTRAPbEn+lRS6Sl7vmixzswnM9enIYbHo5YGax5iUkU
 q7u7RpUAnxAV8UOhRP9RdYrXZnxXTwVeIK8CNifFJYkaKJI5NeYD0jIQW0J+sMTdnVpoX3sPbb
 JoAxDPa7QJpzFYjjiWGpLeB6
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Jul 2022 03:09:27 -0700
IronPort-SDR: VI92L1u0z8oFCyCIdOP2kX/cwWR/LxrAYz/mgJ9NpCnVWqArrGTO+m2id9QNa+IWUeBtPNpfrU
 yBQagh2DFZQJuQTt6ajd1dkvyckRUnAGgmHPMX6taeE7bXusOujWahUgxw0Gu+Vjm9n83tE8Zy
 u4u2uN7W2Is0w4lDx9OSFBCyXCxLCcoBMc0oVNHS7FwfGdNumxlgl82yRht045MaJY1CM17Ht9
 0h/wpCPNBUIyeHpcs+rFXow6uMKrKdlFNniRfhGSI6FebtF07xvLr8ucg1PGcoV8TUgcjX7HvP
 wG0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Jul 2022 03:48:02 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LmdwK1Kq8z1Rw4L
	for <iommu@lists.linux.dev>; Mon, 18 Jul 2022 03:48:01 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)"
	header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	opensource.wdc.com; h=content-transfer-encoding:content-type
	:in-reply-to:organization:from:references:to:content-language
	:subject:user-agent:mime-version:date:message-id; s=dkim; t=
	1658141280; x=1660733281; bh=7rBMGEx1YSGdVB6fbYn5Y5KkPOqfQscgrLN
	9anE2Owo=; b=bjN5B1j0Rkc2vSnTaBg0I6yZlDKb3jC/Ey1Ow71t0OK/WvsEBS6
	zcLef5xxzvKAk6dN3xoqmSaUtbHCa7GpME+/Gyjh24WSx+3oRTp/RTNJw0MQirr9
	/HS1V4UnLFvDu+T4pFMk4KY+3/YbTd/C+0K+2mxZS9H9jBJuF+QtICaIVfDFwcoq
	Xf2U2c1D81NnxfOvu3UB2HOllG4nhOn6akT3u2/VfBdiWtKfjfBzx9y4PQm2k+Ek
	0JsdZ2kx7xVyP3FIIgro3g3SbxmL5fcX2NKc1Qc5XkWcUaSyDtLMWWgD9RAD5Dqz
	CmPSh/wyz5ZJehHEEZge/Uqk7PRq0biCTqg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
	by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id CotKiXahLB0Q for <iommu@lists.linux.dev>;
	Mon, 18 Jul 2022 03:48:00 -0700 (PDT)
Received: from [10.225.163.120] (unknown [10.225.163.120])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LmdwG3P48z1RtVk;
	Mon, 18 Jul 2022 03:47:58 -0700 (PDT)
Message-ID: <dad18548-8487-e059-9538-f34ed46d39c0@opensource.wdc.com>
Date: Mon, 18 Jul 2022 19:47:57 +0900
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v6 5/6] scsi: scsi_transport_sas: Cap shost opt_sectors
 according to DMA optimal limit
Content-Language: en-US
To: John Garry <john.garry@huawei.com>, joro@8bytes.org, will@kernel.org,
 jejb@linux.ibm.com, martin.petersen@oracle.com, hch@lst.de,
 m.szyprowski@samsung.com, robin.murphy@arm.com
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-ide@vger.kernel.org, iommu@lists.linux.dev,
 linux-scsi@vger.kernel.org, linuxarm@huawei.com
References: <1657797329-98541-1-git-send-email-john.garry@huawei.com>
 <1657797329-98541-6-git-send-email-john.garry@huawei.com>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <1657797329-98541-6-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/14/22 20:15, John Garry wrote:
> Streaming DMA mappings may be considerably slower when mappings go through
> an IOMMU and the total mapping length is somewhat long. This is because the
> IOMMU IOVA code allocates and free an IOVA for each mapping, which may
> affect performance.
> 
> For performance reasons set the request queue max_sectors from
> dma_opt_mapping_size(), which knows this mapping limit.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>  drivers/scsi/scsi_transport_sas.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/scsi/scsi_transport_sas.c b/drivers/scsi/scsi_transport_sas.c
> index 12bff64dade6..2f88c61216ee 100644
> --- a/drivers/scsi/scsi_transport_sas.c
> +++ b/drivers/scsi/scsi_transport_sas.c
> @@ -225,6 +225,7 @@ static int sas_host_setup(struct transport_container *tc, struct device *dev,
>  {
>  	struct Scsi_Host *shost = dev_to_shost(dev);
>  	struct sas_host_attrs *sas_host = to_sas_host_attrs(shost);
> +	struct device *dma_dev = shost->dma_dev;
>  
>  	INIT_LIST_HEAD(&sas_host->rphy_list);
>  	mutex_init(&sas_host->lock);
> @@ -236,6 +237,11 @@ static int sas_host_setup(struct transport_container *tc, struct device *dev,
>  		dev_printk(KERN_ERR, dev, "fail to a bsg device %d\n",
>  			   shost->host_no);
>  
> +	if (dma_dev->dma_mask) {
> +		shost->opt_sectors = min_t(unsigned int, shost->max_sectors,
> +				dma_opt_mapping_size(dma_dev) >> SECTOR_SHIFT);
> +	}
> +
>  	return 0;
>  }
>  

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research
