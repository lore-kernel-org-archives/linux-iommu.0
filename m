Return-Path: <SRS0=d63v=UZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA5DC48BD6
	for <iommu@archiver.kernel.org>; Wed, 26 Jun 2019 14:43:07 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96C5F2080C
	for <iommu@archiver.kernel.org>; Wed, 26 Jun 2019 14:43:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="uCmi320p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96C5F2080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 6C5A8DCE;
	Wed, 26 Jun 2019 14:43:07 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 5564BED2
	for <iommu@lists.linux-foundation.org>;
	Wed, 26 Jun 2019 10:04:33 +0000 (UTC)
X-Greylist: delayed 01:20:14 by SQLgrey-1.7.6
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id CBDE3710
	for <iommu@lists.linux-foundation.org>;
	Wed, 26 Jun 2019 10:04:32 +0000 (UTC)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x5Q8i5Ep068189;
	Wed, 26 Jun 2019 03:44:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1561538645;
	bh=LtR8YqPAxJoiiaQr+rKC4/jbAgDp9J8cOhOylP72rFk=;
	h=To:CC:From:Subject:Date;
	b=uCmi320peXxY+9VVMxlqGczAuesFTOnvNiO719Tx3/VfLpv8kLRtAVEsLt4v9TA7u
	5S+K5IDrMWs93S4SgZ9ClOyFe6U6KQdl8IHCb3oj1q3y7mPbMhe7PSkHAchIXdmQDp
	J4CK53JrZx6ou4nwx9Ry5ka0o64SD8lcxWmsRaA0=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x5Q8i5lN006920
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 26 Jun 2019 03:44:05 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE115.ent.ti.com
	(10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5;
	Wed, 26 Jun 2019 03:44:03 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE113.ent.ti.com
	(10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
	Frontend Transport; Wed, 26 Jun 2019 03:44:03 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
	by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x5Q8hxVh129407;
	Wed, 26 Jun 2019 03:44:00 -0500
To: <hch@lst.de>, "hdegoede@redhat.com" <hdegoede@redhat.com>
Subject: SATA broken with LPAE
Message-ID: <16f065ef-f4ac-46b4-de2a-6b5420ae873a@ti.com>
Date: Wed, 26 Jun 2019 11:43:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Wed, 26 Jun 2019 14:43:06 +0000
Cc: axboe@kernel.dk, Vignesh Raghavendra <vigneshr@ti.com>,
	martin.petersen@oracle.com, Tony Lindgren <tony@atomide.com>,
	jejb@linux.ibm.com, "Nori, Sekhar" <nsekhar@ti.com>,
	linux-ide@vger.kernel.org, iommu@lists.linux-foundation.org,
	rmk+kernel@arm.linux.org.uk, linux-omap@vger.kernel.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
From: Roger Quadros via iommu <iommu@lists.linux-foundation.org>
Reply-To: Roger Quadros <rogerq@ti.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Hi Christoph / Hans,

SATA has been broken on TI platforms with LPAE, on systems with RAM addresses > 32-bits,
(e.g. DRA7 rev.H+) since v4.18.

The commit at which it breaks is
21e07dba9fb1179148089d611fc9e6e70d1887c3 ("scsi: reduce use of block bounce buffers").

The effect is that the SATA controller starts to see DMA addresses
above 32-bit which it does not support.

Could you please shed some light on how it is supposed to work if
we don't call blk_queue_bounce_limit() for devices that can do only 32-bit DMA
on a system that has addressable RAM above 32-bit Physical?

The below patch fixes it. Is this the right thing to do?

diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
index 3aab2e3d57f3..b925dc54cfa5 100644
--- a/drivers/ata/ahci_platform.c
+++ b/drivers/ata/ahci_platform.c
@@ -62,6 +62,9 @@ static int ahci_probe(struct platform_device *pdev)
 	if (of_device_is_compatible(dev->of_node, "hisilicon,hisi-ahci"))
 		hpriv->flags |= AHCI_HFLAG_NO_FBS | AHCI_HFLAG_NO_NCQ;
 
+	if (of_device_is_compatible(dev->of_node, "snps,dwc-ahci"))
+		hpriv->flags |= AHCI_HFLAG_32BIT_ONLY;
+
 	port = acpi_device_get_match_data(dev);
 	if (!port)
 		port = &ahci_port_info;
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 65d0a10c76ad..9083c7b89dfc 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1750,6 +1750,21 @@ static int scsi_map_queues(struct blk_mq_tag_set *set)
 	return blk_mq_map_queues(&set->map[HCTX_TYPE_DEFAULT]);
 }
 
+static u64 scsi_calculate_bounce_limit(struct Scsi_Host *shost)
+{
+	struct device *dma_dev = shost->dma_dev;
+	u64 bounce_limit = 0xffffffff;
+
+	if (shost->unchecked_isa_dma)
+		return BLK_BOUNCE_ISA;
+
+	if (dma_dev && dma_dev->dma_mask)
+		bounce_limit = (u64)dma_max_pfn(dma_dev) << PAGE_SHIFT;
+
+	return bounce_limit;
+}
+
 void __scsi_init_queue(struct Scsi_Host *shost, struct request_queue *q)
 {
 	struct device *dev = shost->dma_dev;
@@ -1769,8 +1784,7 @@ void __scsi_init_queue(struct Scsi_Host *shost, struct request_queue *q)
 	}
 
 	blk_queue_max_hw_sectors(q, shost->max_sectors);
-	if (shost->unchecked_isa_dma)
-		blk_queue_bounce_limit(q, BLK_BOUNCE_ISA);
+	blk_queue_bounce_limit(q, scsi_calculate_bounce_limit(shost));
 	blk_queue_segment_boundary(q, shost->dma_boundary);
 	dma_set_seg_boundary(dev, shost->dma_boundary);

cheers,
-roger
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
