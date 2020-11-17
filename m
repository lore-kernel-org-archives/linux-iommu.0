Return-Path: <SRS0=JfyE=EX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B56DC56202
	for <iommu@archiver.kernel.org>; Tue, 17 Nov 2020 15:30:55 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6BF9221E2
	for <iommu@archiver.kernel.org>; Tue, 17 Nov 2020 15:30:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6BF9221E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cornelisnetworks.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 19FD187026;
	Tue, 17 Nov 2020 15:30:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id A7fQVo1BSsHc; Tue, 17 Nov 2020 15:30:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 17A8B87020;
	Tue, 17 Nov 2020 15:30:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E5EB9C1834;
	Tue, 17 Nov 2020 15:30:52 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1E8CBC07FF
 for <iommu@lists.linux-foundation.org>; Tue, 17 Nov 2020 14:33:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 0062C8705B
 for <iommu@lists.linux-foundation.org>; Tue, 17 Nov 2020 14:33:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Hech-HAA7D2O for <iommu@lists.linux-foundation.org>;
 Tue, 17 Nov 2020 14:33:17 +0000 (UTC)
X-Greylist: delayed 00:30:56 by SQLgrey-1.7.6
Received: from bosmailout02.eigbox.net (bosmailout02.eigbox.net [66.96.188.2])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 7953C8704A
 for <iommu@lists.linux-foundation.org>; Tue, 17 Nov 2020 14:33:17 +0000 (UTC)
Received: from bosmailscan06.eigbox.net ([10.20.15.6])
 by bosmailout02.eigbox.net with esmtp (Exim) id 1kf1Yq-0002Xx-5j
 for iommu@lists.linux-foundation.org; Tue, 17 Nov 2020 09:02:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=cornelisnetworks.com; s=dkim; h=Sender:Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:
 Subject:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OQ/j0tk/3/6taMHML6/LZ+8wC6OlN+24PAxPKRw0GKQ=; b=ovmOuOEw81+FTaKijMmKPkDwFI
 L3zmnOhkLMctmZ1Q6LA7RAliMKRgfBgoAsNQFvmbkQFMScNSBcGmpMWyOm5XQgV65HTPK0eCQfONo
 /P+AYXYPMRSxc4SMh/cOzp6b6GGHlEcdrU24kh4HrOO9/EMqBZ24ayvL7Y+Q3BBk/eUmMzigfzkP8
 FYS0l4C8YrQ1zsF//erM5Cg/IeOgD31UsmuULDUYXVJkeVuUZab0zSohhojch9Di3OLzEOWBy73m8
 LbvbatIZ5ku4BiRjOg1uQQgDwgUAwI+7/zTOrjv7DPCIeoB8eUZsPj9gdrdXQJVJsfjBhaOMsw/DX
 Wl3fTnKg==;
Received: from [10.115.3.32] (helo=bosimpout12)
 by bosmailscan06.eigbox.net with esmtp (Exim) id 1kf1Yp-0004uM-JW
 for iommu@lists.linux-foundation.org; Tue, 17 Nov 2020 09:02:19 -0500
Received: from bosauthsmtp13.yourhostingaccount.com ([10.20.18.13])
 by bosimpout12 with 
 id tS2F2300B0GvDVm01S2JKD; Tue, 17 Nov 2020 09:02:19 -0500
X-Authority-Analysis: v=2.3 cv=WuawzeXv c=1 sm=1 tr=0
 a=UH8/iCWBfdUmbm4Ft4Vi3Q==:117 a=t5jG6c9IKFG8al4zq+RKCw==:17
 a=IkcTkHD0fZMA:10 a=nNwsprhYR40A:10 a=sI1n-BzLCC4A:10 a=VwQbUJbxAAAA:8
 a=LRYjQimtAAAA:8 a=gm1xG5NVYmixJIDKLiEA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=JC7xiqAVgOyvJ6DxgMma:22
Received: from fmdmzpr03-ext.fm.intel.com ([192.55.54.38]:53205)
 by bosauthsmtp13.eigbox.net with esmtpa (Exim)
 id 1kf1Yl-0008WK-DA; Tue, 17 Nov 2020 09:02:15 -0500
From: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Subject: Re: remove dma_virt_ops v2
To: Christoph Hellwig <hch@lst.de>, Jason Gunthorpe <jgg@ziepe.ca>
References: <20201106181941.1878556-1-hch@lst.de>
 <20201112165935.GA932629@nvidia.com> <20201112170956.GA18813@lst.de>
 <20201112173906.GT244516@ziepe.ca> <20201113085023.GA17412@lst.de>
Message-ID: <b6834645-d62b-f88b-9fc6-d1207ae33549@cornelisnetworks.com>
Date: Tue, 17 Nov 2020 09:01:56 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201113085023.GA17412@lst.de>
Content-Language: en-US
X-EN-UserInfo: 0c01d0184442a6165e428d14bd4242e2:931c98230c6409dcc37fa7e93b490c27
X-EN-AuthUser: mike.marciniszyn@cornelisnetworks.com
X-EN-OrigIP: 192.55.54.38
X-EN-OrigHost: fmdmzpr03-ext.fm.intel.com
X-Mailman-Approved-At: Tue, 17 Nov 2020 15:30:51 +0000
Cc: rds-devel@oss.oracle.com, Zhu Yanjun <yanjunz@nvidia.com>,
 Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
 linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
 Santosh Shilimkar <santosh.shilimkar@oracle.com>,
 iommu@lists.linux-foundation.org, Bjorn Helgaas <bhelgaas@google.com>,
 Bernard Metzler <bmt@zurich.ibm.com>, Logan Gunthorpe <logang@deltatee.com>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

>> Fixes: 551199aca1c3 ("lib/dma-virt: Add dma_virt_ops")
> 
> Note that the drivers had open coded versions of this earlier.  I think
> this goes back to the addition of the qib driver which is now gone
> or the addition of the hfi1 or rxe drivers for something that still
> matters

Christoph,Jason

I built a branch using the following recipe:
https://patchwork.kernel.org/project/linux-rdma/patch/:
20201106181941.1878556-11-hch@lst.de/ dma-mapping: remove dma_virt_ops 
20201106181941.1878556-10-hch@lst.de/ PCI/P2PDMA: Cleanup 
__pci_p2pdma_map_sg a bit
20201106181941.1878556-9-hch@lst.de/  PCI/P2PDMA: Remove the 
DMA_VIRT_OPS hacks
20201106181941.1878556-8-hch@lst.de/  RDMA/core: remove use of dma_virt_ops
20201106181941.1878556-7-hch@lst.de/  RDMA/core: remove 
ib_dma_{alloc,free}_coherent
20201106181941.1878556-6-hch@lst.de/  rds: stop using dmapool
20201106181941.1878556-5-hch@lst.de/  nvme-rdma: use ibdev_to_node 
instead of dereferencing ->dma_device
20201106181941.1878556-4-hch@lst.de/  RDMA: lift ibdev_to_node from rds 
to common code
20201106181941.1878556-3-hch@lst.de/  RDMA/umem: use ib_dma_max_seg_size 
instead of dma_get_max_seg_size
rdma/for-rc dabbd6abcdbe which has RMDA/sw: don't allow drivers using 
dma_virt_ops on highmem configs

All of our rdmavt/hfi1 tests passed.

So I can at least vouch for "RDMA/core: remove use of dma_virt_ops"

Mike
Tested-by: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
