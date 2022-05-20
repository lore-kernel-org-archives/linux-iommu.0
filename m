Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A1C0C43217
	for <iommu@archiver.kernel.org>; Sat, 21 May 2022 00:06:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B5178411AE;
	Sat, 21 May 2022 00:06:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FsAa3vxNXMYw; Sat, 21 May 2022 00:06:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 846AE411B3;
	Sat, 21 May 2022 00:06:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7EDBBC0089;
	Sat, 21 May 2022 00:06:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E0D41C002D
 for <iommu@lists.linux-foundation.org>; Fri, 20 May 2022 23:34:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B6CD1411B4
 for <iommu@lists.linux-foundation.org>; Fri, 20 May 2022 23:34:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id A-9QdW0F8tbH for <iommu@lists.linux-foundation.org>;
 Fri, 20 May 2022 23:34:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B7047411B3
 for <iommu@lists.linux-foundation.org>; Fri, 20 May 2022 23:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1653089648; x=1684625648;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=cxD0WkTRuBGs7QMn33plUCWC3KT9kbapNpgQIUmBMA8=;
 b=WU5QGbVXgqoJSzhNmD0ZQxyYaacyb/Ed78b452a9wN95QxdWblf1U4RN
 C6yLFNm52sfJAzzO+yeoEuZL39zb+iLQE8GgXSP1nIH09XTVpEM0ILyfo
 WCByek4HZobNKbDysRkyAU0D/sCncSg70flQ2tGU2kYkdZw7p0nizW1lT
 4TnZRnpAOXgjbfu2i57q77IKeTDRXsWx59Gj75CO5aqppWURkJbJL4IDS
 DvwJEarG0WhhoGHRVbo6p/soc1qATBAbHgcoT51CQ7wu1vgX0/GToGOEW
 3wU4gk0X5fUQV5n39vVnDyNXi2O+83znuSUDcJvKyYBaQ1NsM8MH//oaU w==;
X-IronPort-AV: E=Sophos;i="5.91,240,1647273600"; d="scan'208";a="305178384"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 21 May 2022 07:34:07 +0800
IronPort-SDR: 1PsErXo0B4Fnu0qRu58GMor965gPHtBkuLP8A62uNC/Uc7tstjbkb0Ta1zMj5m2sD9eGbedr7K
 sSHm4Gyoxgg7hqnrivrdErGGLFn0k90TM9fVHVVskct87gENtMr3tG7QlTQUz//89yXcEz7dyO
 z/iTUPX7H2MX/Yhq8JIWV8iuC9iuyETskTaWAi0i/ZjnIDGfc673lL08w14g2zQ01JTDKr4In6
 CnX35A7buWLRuIaKqaYlufTCqmNy2vD0IU7LoH4arFkIudfEcFQI8gaM+g5XiRd7FSk2JMLOjM
 62aPz/CnkFBKAO24OZXoGmwS
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 20 May 2022 15:59:29 -0700
IronPort-SDR: HLIknvsiLNy/3TiGqJjE4pDOCDtaLwr9UXuTVlzHqFg38qcKobDcUt4ChYjkW3HeZViVOmaEMO
 tPPko1ffyA/3+UG/RIWXzk+Jn9CcIylbDo8g9XylBXSvqpMMVkJlI5k1L4D7aStNRJpPrCq+uu
 5vgSnFxhNcYd6f4uxiFWhDqlkJn4cGlSO9taicNJoHHV6i/bkDsbUZpBXtTV6g4NhiQWZzQfkG
 y3RbzDkaB0I6LVh/g/3uVY0FsjfScNOyg+yr0z3e6OrQM7lYVzkzAIjpbz6++nq53Y508AGSdn
 x5U=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
 by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 20 May 2022 16:34:07 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4L4jjW0dYgz1SVp4
 for <iommu@lists.linux-foundation.org>; Fri, 20 May 2022 16:34:07 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
 reason="pass (just generated, assumed good)"
 header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
 opensource.wdc.com; h=content-transfer-encoding:content-type
 :in-reply-to:organization:from:references:to:content-language
 :subject:user-agent:mime-version:date:message-id; s=dkim; t=
 1653089646; x=1655681647; bh=cxD0WkTRuBGs7QMn33plUCWC3KT9kbapNpg
 QIUmBMA8=; b=IAZfh2N/A1jItIRu6RNK4GCq/n7NLG1+opKeFCVPmNoD3nU4SpR
 bC6akAQHrRKjwDRGh4NXwXV/FMrBCZ6GcNYZcuC2ARib1r2sjAHkGU9Ep1cDFwop
 mDfqvuMSQssge51ujkq7vQ5pCjovouoGBfDz3E5IaM9G2Qqp9uzAo46qFsID7yHl
 Vw6amvteVP/EJl7jEGH7Boh6b3YkUpvvr5IwG9eq9uJub53GSlGzOb852GLfBhb/
 JW5MGlFzL5zQEqnjhAL3oRx/o0N9qjqNC1su+SaebsoCtTk5dX1J8MyoLkNh1FZr
 qCDdMdkk9R1i9CbzUDAwGjlwztQvrlS+5aw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
 by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new,
 port 10026)
 with ESMTP id 7nWrl14zjU-D for <iommu@lists.linux-foundation.org>;
 Fri, 20 May 2022 16:34:06 -0700 (PDT)
Received: from [10.225.163.51] (unknown [10.225.163.51])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4L4jjS0PF4z1Rvlc;
 Fri, 20 May 2022 16:34:03 -0700 (PDT)
Message-ID: <1a683059-d718-9536-e8fe-d7d47e25e935@opensource.wdc.com>
Date: Sat, 21 May 2022 08:34:03 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 4/4] libata-scsi: Cap ata_device->max_sectors according to
 shost->max_sectors
Content-Language: en-US
To: John Garry <john.garry@huawei.com>, joro@8bytes.org, will@kernel.org,
 jejb@linux.ibm.com, martin.petersen@oracle.com, hch@lst.de,
 m.szyprowski@samsung.com, robin.murphy@arm.com
References: <1653035003-70312-1-git-send-email-john.garry@huawei.com>
 <1653035003-70312-5-git-send-email-john.garry@huawei.com>
Organization: Western Digital Research
In-Reply-To: <1653035003-70312-5-git-send-email-john.garry@huawei.com>
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
> ---
>  drivers/ata/libata-scsi.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 06c9d90238d9..25fe89791641 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -1036,6 +1036,7 @@ int ata_scsi_dev_config(struct scsi_device *sdev, struct ata_device *dev)
>  		dev->flags |= ATA_DFLAG_NO_UNLOAD;
>  
>  	/* configure max sectors */
> +	dev->max_sectors = min(dev->max_sectors, sdev->host->max_sectors);
>  	blk_queue_max_hw_sectors(q, dev->max_sectors);
>  
>  	if (dev->class == ATA_DEV_ATAPI) {

Acked-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
