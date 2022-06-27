Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5005ACCA47B
	for <iommu@archiver.kernel.org>; Mon, 27 Jun 2022 23:24:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CFB6260AC3;
	Mon, 27 Jun 2022 23:24:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CFB6260AC3
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=MIAVbTMn;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=opensource.wdc.com header.i=@opensource.wdc.com header.a=rsa-sha256 header.s=dkim header.b=DOmB0q+y
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bTnXGrVyHqH1; Mon, 27 Jun 2022 23:24:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 722CA607FF;
	Mon, 27 Jun 2022 23:24:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 722CA607FF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3A456C0039;
	Mon, 27 Jun 2022 23:24:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5DBCDC002D
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jun 2022 23:24:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 24FAC82660
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jun 2022 23:24:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 24FAC82660
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com
 header.a=rsa-sha256 header.s=dkim.wdc.com header.b=MIAVbTMn; 
 dkim=pass (2048-bit key) header.d=opensource.wdc.com
 header.i=@opensource.wdc.com header.a=rsa-sha256 header.s=dkim
 header.b=DOmB0q+y
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Szt4H8wUx_6K for <iommu@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 23:24:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 324C6824DD
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 324C6824DD
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jun 2022 23:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1656372256; x=1687908256;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=S8N+p0moc3MloWqEEauJLXVpb/5eTV2AD6EVivHGR+Q=;
 b=MIAVbTMnTlw9z1Et63FOp32sCeJD7NpQIBhLe8r5QJYq0bzuglITBRfm
 7rOgUWxiYt+S8rrhyQdH/dCFBfJBXS/35gZil8Vc39gwPx+bf2XnPt0LX
 0wC0l/fcDxevG9j29QWVGAi6TnG6o4mYr2bTxbHN7GzZge9vsuUt4pGP3
 k5umIhWKhD4oQj/MHd6lh93ei/wLaWaVWXEKxfHx078oQPZWPN8XFwJRC
 QirhAL39f8A4tbY3+xFZ3Ya2BdQcl29m+hgIdK9h6GjpvldQH8g6hNrTK
 TR8EvT7+5QKFJ0K9PTE7EYWzY/7XMcBKfwMvYYGUFsxKHhhZBzPqLEl/r g==;
X-IronPort-AV: E=Sophos;i="5.92,227,1650902400"; d="scan'208";a="308558889"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 28 Jun 2022 07:24:13 +0800
IronPort-SDR: s2QXo2XQw2qLWDnK2ZSM6IUkQ1jebepae9502cO3oQrfuX5hAGRAtYMW25o1BUqf/XcZPiLW0F
 AOubR3Nn8ssiaJz5P78COOdIscCx2nmbu+gECgARGATp40sfriqMSOP7wWE/VUfX1tFpAylDbc
 aVVL7WwzO1wxt9L7UWd2brgC7kFPNcAHlIt3IdpjbYbm/J4mlNU6AkYjR1R0J71CMuKX7G63k3
 hYK1bApY91oaU1k8DD2exUGKwccFjtTDTotmoiTlsgPOZ/4XBIhrEXz8YVHir9+qOCEf0zVxdA
 qTA3VgDNOm51BiUr60W23umE
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 27 Jun 2022 15:41:54 -0700
IronPort-SDR: CTERwHnuXHxjfqL89ZDJ19U8crnZ4qHToW1+V978xDVaWmlJGcl2yjHOOgZLweme5sHMWitj+Q
 YIv1q2P9muj2XsZkjZ7gfpkF04VAdSRhHFEUkzG1GaqcAY5txgMdYGRHhrKEUBB48F0F2o1kvx
 ltiF0NpcYoLcymWDSlVycnS6yyEFjz6UOmLtd9OkzTjc9lBjON+sIBwXpgKd9ybHCkb71fMYWd
 eDiLJ2TN5mEduloOIUMuM7YYa3R7Roiuez8MLvRF2mAd5IMX1heB78jTj68aUT1lbiFR1eqTod
 NEY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
 by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 27 Jun 2022 16:24:13 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LX3hY19fqz1Rw4L
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jun 2022 16:24:13 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
 reason="pass (just generated, assumed good)"
 header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
 opensource.wdc.com; h=content-transfer-encoding:content-type
 :in-reply-to:organization:from:references:to:content-language
 :subject:user-agent:mime-version:date:message-id; s=dkim; t=
 1656372252; x=1658964253; bh=S8N+p0moc3MloWqEEauJLXVpb/5eTV2AD6E
 VivHGR+Q=; b=DOmB0q+yumadQfEfKMysp6ZcnZ0HtW72qJdwM5m8B0Kc9Tad+dF
 7gDs0OfNHqCTGeSJfqD9/6sW1evo3sq7cfUvTRWVJIHK1cvpn/iA0skUc9IIKiE8
 KNmo/tqZYLCa5cn5qWD0Ryij/7qx8e/kumjGMwTGlY2HfYRxOMPtvr9WNC/dUNhF
 menESGNdXZJXjqA+MtrgYPevYEFlhkjHja7G3apSDEhYWjiRMEr2hwIPvwtYRb3G
 oGa6nySA/D6iv8hrxLg69E36edryEq45dv95ZCgDqaDMBUQ/0rXQ/5OSFkcyN4S3
 m/oYW8SWIyUKCVcIwEf/+kyLjCcbBjt44xA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
 by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new,
 port 10026)
 with ESMTP id n_u29azrjc2T for <iommu@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 16:24:12 -0700 (PDT)
Received: from [10.225.163.99] (unknown [10.225.163.99])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LX3hV0cq4z1RtVk;
 Mon, 27 Jun 2022 16:24:09 -0700 (PDT)
Message-ID: <b69c6112-98b7-3890-9d11-bb321a7c877a@opensource.wdc.com>
Date: Tue, 28 Jun 2022 08:24:08 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v4 5/5] libata-scsi: Cap ata_device->max_sectors according
 to shost->max_sectors
Content-Language: en-US
To: John Garry <john.garry@huawei.com>, joro@8bytes.org, will@kernel.org,
 jejb@linux.ibm.com, martin.petersen@oracle.com, hch@lst.de,
 m.szyprowski@samsung.com, robin.murphy@arm.com
References: <1656343521-62897-1-git-send-email-john.garry@huawei.com>
 <1656343521-62897-6-git-send-email-john.garry@huawei.com>
Organization: Western Digital Research
In-Reply-To: <1656343521-62897-6-git-send-email-john.garry@huawei.com>
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
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
