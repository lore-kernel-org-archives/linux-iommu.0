Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAFC4C43334
	for <iommu@archiver.kernel.org>; Wed, 29 Jun 2022 05:40:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 30CB24049D;
	Wed, 29 Jun 2022 05:40:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 30CB24049D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LqIVvbnlS6Gd; Wed, 29 Jun 2022 05:40:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 154EB40112;
	Wed, 29 Jun 2022 05:40:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 154EB40112
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C5B9DC0039;
	Wed, 29 Jun 2022 05:40:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 62914C002D
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jun 2022 05:40:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2A1B240465
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jun 2022 05:40:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2A1B240465
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8WhDun1-zz_X for <iommu@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 05:40:33 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2DDB740112
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2DDB740112
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jun 2022 05:40:32 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 1586067373; Wed, 29 Jun 2022 07:40:28 +0200 (CEST)
Date: Wed, 29 Jun 2022 07:40:27 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.garry@huawei.com>
Subject: Re: [PATCH v4 5/5] libata-scsi: Cap ata_device->max_sectors
 according to shost->max_sectors
Message-ID: <20220629054027.GB16297@lst.de>
References: <1656343521-62897-1-git-send-email-john.garry@huawei.com>
 <1656343521-62897-6-git-send-email-john.garry@huawei.com>
 <b69c6112-98b7-3890-9d11-bb321a7c877a@opensource.wdc.com>
 <6619638c-52e8-cb67-c56c-9c9d38c18161@huawei.com>
 <ba59a0da-a982-e3eb-1cb7-6e60f80fd319@opensource.wdc.com>
 <38ae1cc8-1411-bb54-e082-0f7b91cb9e63@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <38ae1cc8-1411-bb54-e082-0f7b91cb9e63@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: iommu@lists.linux.dev, martin.petersen@oracle.com,
 linux-scsi@vger.kernel.org, linux-doc@vger.kernel.org, robin.murphy@arm.com,
 Damien Le Moal <damien.lemoal@opensource.wdc.com>,
 linux-kernel@vger.kernel.org, linuxarm@huawei.com, linux-ide@vger.kernel.org,
 iommu@lists.linux-foundation.org, jejb@linux.ibm.com, will@kernel.org,
 hch@lst.de
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Tue, Jun 28, 2022 at 12:33:58PM +0100, John Garry wrote:
> Well Christoph originally offered to take this series via the dma-mapping 
> tree.
>
> @Christoph, is that still ok with you? If so, would you rather I send this 
> libata patch separately?

The offer still stands, and I don't really care where the libata
patch is routed.  Just tell me what you prefer.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
