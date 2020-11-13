Return-Path: <SRS0=vtxH=ET=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98AF0C388F7
	for <iommu@archiver.kernel.org>; Fri, 13 Nov 2020 08:50:44 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6C53206CA
	for <iommu@archiver.kernel.org>; Fri, 13 Nov 2020 08:50:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6C53206CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 42207873A3;
	Fri, 13 Nov 2020 08:50:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AKn3dpuwkBMm; Fri, 13 Nov 2020 08:50:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 93C8386A19;
	Fri, 13 Nov 2020 08:50:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8014DC1833;
	Fri, 13 Nov 2020 08:50:42 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B79C1C0FAA
 for <iommu@lists.linux-foundation.org>; Fri, 13 Nov 2020 08:50:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 9A15987389
 for <iommu@lists.linux-foundation.org>; Fri, 13 Nov 2020 08:50:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9pB9z4vdbiUT for <iommu@lists.linux-foundation.org>;
 Fri, 13 Nov 2020 08:50:40 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 0440B86E35
 for <iommu@lists.linux-foundation.org>; Fri, 13 Nov 2020 08:50:28 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 1918467357; Fri, 13 Nov 2020 09:50:23 +0100 (CET)
Date: Fri, 13 Nov 2020 09:50:23 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: remove dma_virt_ops v2
Message-ID: <20201113085023.GA17412@lst.de>
References: <20201106181941.1878556-1-hch@lst.de>
 <20201112165935.GA932629@nvidia.com> <20201112170956.GA18813@lst.de>
 <20201112173906.GT244516@ziepe.ca>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201112173906.GT244516@ziepe.ca>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: rds-devel@oss.oracle.com, Zhu Yanjun <yanjunz@nvidia.com>,
 Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
 linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
 Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
 iommu@lists.linux-foundation.org, Bjorn Helgaas <bhelgaas@google.com>,
 Bernard Metzler <bmt@zurich.ibm.com>, Logan Gunthorpe <logang@deltatee.com>,
 Christoph Hellwig <hch@lst.de>,
 Santosh Shilimkar <santosh.shilimkar@oracle.com>
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

On Thu, Nov 12, 2020 at 01:39:06PM -0400, Jason Gunthorpe wrote:
> On Thu, Nov 12, 2020 at 06:09:56PM +0100, Christoph Hellwig wrote:
> > On Thu, Nov 12, 2020 at 12:59:35PM -0400, Jason Gunthorpe wrote:
> > >  RMDA/sw: Don't allow drivers using dma_virt_ops on highmem configs
> > 
> > I think this one actually is something needed in 5.10 and -stable.
> 
> Done, I added a
> 
> Fixes: 551199aca1c3 ("lib/dma-virt: Add dma_virt_ops")

Note that the drivers had open coded versions of this earlier.  I think
this goes back to the addition of the qib driver which is now gone
or the addition of the hfi1 or rxe drivers for something that still
matters.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
