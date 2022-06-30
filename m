Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 943E0C43334
	for <iommu@archiver.kernel.org>; Thu, 30 Jun 2022 23:49:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1B82041BA8;
	Thu, 30 Jun 2022 23:49:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1B82041BA8
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=NuwRXc77;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=opensource.wdc.com header.i=@opensource.wdc.com header.a=rsa-sha256 header.s=dkim header.b=WLH01e7E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 18cV_2CTjpVh; Thu, 30 Jun 2022 23:49:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 843AE4239D;
	Thu, 30 Jun 2022 23:49:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 843AE4239D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 48232C002D;
	Thu, 30 Jun 2022 23:49:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 02EDEC0011
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jun 2022 23:49:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CB89A60AED
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jun 2022 23:49:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CB89A60AED
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com
 header.a=rsa-sha256 header.s=dkim.wdc.com header.b=NuwRXc77; 
 dkim=pass (2048-bit key) header.d=opensource.wdc.com
 header.i=@opensource.wdc.com header.a=rsa-sha256 header.s=dkim
 header.b=WLH01e7E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mwm55mFf7wDN for <iommu@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 23:49:43 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C584760A83
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C584760A83
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jun 2022 23:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1656632983; x=1688168983;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=nwEn1VMZrx8GUvODDT0OaTNy6z1BOZ2HCe57NZ02Lbc=;
 b=NuwRXc77mg7D0z6ESleFWPK/voKE1fZ5/UsBSQMUOinFpLQBElriIpMv
 YoFw9MuXbHr6vG+stpXo4geZAjYdfqIWlTKAr7nGWHFVgGNKiNQTBiPv8
 yxHbq7ni+uNlbpTCTEC8zbQNVXsoaACLqZVz6SZrzfVpG/MssMLUgMtIs
 2z6e/gklj3ZnpXbbBrfXCPG7l1RZtHg/m43jArLgfY/SMGSOKQSi9X7h4
 ggIl5E64F4qE8myWSRfIPVnax45FXeGfBAHqispwb9RoLruu+fomTXIyT
 N9g2sXzSuTGgtqcO6Dc4CYgtBZTqys5eveaM3Z4P1F8IfIIR78PD9b+s2 w==;
X-IronPort-AV: E=Sophos;i="5.92,235,1650902400"; d="scan'208";a="205257834"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 01 Jul 2022 07:49:41 +0800
IronPort-SDR: Ol7D9irA/2D+4zTFUoIKJ84aELJrzYNW71irlGpXrm8sq/oqm1NmulGIzGjbUkRTKSzRXC7yXm
 8Ba6d1IlvFcilHcp1aXSbAWmVuhQgSInNHs1EzAGFSp6NpivU3M4JzElPtPHUEa4pj9Tvjd0lZ
 vtX+U8PEGCJGQHZ8RTvqdwRfX/1tNhApeP+VvIotoAf/Fr+hIK2XT2GnaQzn6r5IEiUg5IM4C8
 MaNRu1qg5sth8NzMNSTmwtGR/dqh+4j1KXUsQYKrqZ5bQZumDYhdZd+uUlWs9NQfglIJAFB38M
 BV71OP3Zcc/TuX+xK1JvzHfw
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 30 Jun 2022 16:11:53 -0700
IronPort-SDR: YLO94rT781hn+8+IC4JYv352htL/wwtYRtJJU2ocKLqqt1H7zbyJoutBsdtaKi/tYSz/HjNhmo
 EPxOmPK+HkAmEEXKXmvkngxVU1xXEysWCObdSE88KS4lG+99/plshAjBYLAk9nECCufj+qB99f
 SppMjpNSMKaEBfwVhEkjOJ8/xF439R9eXFdKOfofv0uWryigUHwZhsgws6QkDMnPUZ3yZ0KG2/
 lFRrXyLY/3ARnqCbtTbKGQgPLTqH+4VdU0baL7bLkHEc0xff7AUrifrAB8EA2jX0Wouy5DsTsj
 KSs=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
 by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 30 Jun 2022 16:49:41 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LYw6X4FM7z1Rw4L
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jun 2022 16:49:40 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
 reason="pass (just generated, assumed good)"
 header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
 opensource.wdc.com; h=content-transfer-encoding:content-type
 :in-reply-to:organization:from:references:to:content-language
 :subject:user-agent:mime-version:date:message-id; s=dkim; t=
 1656632980; x=1659224981; bh=nwEn1VMZrx8GUvODDT0OaTNy6z1BOZ2HCe5
 7NZ02Lbc=; b=WLH01e7EcYJscXnwQ3vvbmxQTuNCz3i5pBQVZdrz66seSwF49h1
 +8GS6jTrsLEAkuw/tD2AknhPYioGLd4d7sT3GQLnO6xu/H8Jja/BvPtC53e7auQP
 2ySivAr3YR8mb2/bi7YxGSMXNxKQK4k66W4nuilErMzlwRy3gJ/aBV7BiQf2lZgN
 w3Be/GZWvaOFz6780wZxse2VtnKneGGzbV4SXNJ7ACmPrxcECYPahoxF1WbKesDe
 Kdmo3OxJxKftQgVnI75yZCLNb1RE5mbPQy6HR+ycBckrjlDzqPdHq0Q3XHuPEaRr
 ThWJqmi9TPbB2tm7FvbOONX5x4GDU+VLEEw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
 by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new,
 port 10026)
 with ESMTP id Et1sngT2Rfp3 for <iommu@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 16:49:40 -0700 (PDT)
Received: from [10.225.163.102] (unknown [10.225.163.102])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LYw6T5Ymgz1RtVk;
 Thu, 30 Jun 2022 16:49:37 -0700 (PDT)
Message-ID: <2e6475e5-4899-1e3a-1418-918b9510ec6d@opensource.wdc.com>
Date: Fri, 1 Jul 2022 08:49:36 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v5 4/5] scsi: scsi_transport_sas: Cap shost max_sectors
 according to DMA optimal limit
Content-Language: en-US
To: John Garry <john.garry@huawei.com>, joro@8bytes.org, will@kernel.org,
 jejb@linux.ibm.com, martin.petersen@oracle.com, hch@lst.de,
 m.szyprowski@samsung.com, robin.murphy@arm.com
References: <1656590892-42307-1-git-send-email-john.garry@huawei.com>
 <1656590892-42307-5-git-send-email-john.garry@huawei.com>
Organization: Western Digital Research
In-Reply-To: <1656590892-42307-5-git-send-email-john.garry@huawei.com>
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
> index 12bff64dade6..1b45248748e0 100644
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
> +	if (dma_dev) {
> +		shost->max_sectors = min_t(unsigned int, shost->max_sectors,
> +				dma_opt_mapping_size(dma_dev) >> SECTOR_SHIFT);
> +	}

Hmm... shost->max_sectors becomes the max_hw_sectors limit for the block
dev. So using dma_max_mapping_size(dma_dev) for that limit makes sense.
Shouldn't dma_opt_mapping_size(dma_dev) be used to limit only the default
"soft" limit (queue max_sectors limit) instead of the hard limit ?

> +
>  	return 0;
>  }
>  
-- 
Damien Le Moal
Western Digital Research
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
