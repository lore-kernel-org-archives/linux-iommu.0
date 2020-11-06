Return-Path: <SRS0=4FG6=EM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF36C388F2
	for <iommu@archiver.kernel.org>; Fri,  6 Nov 2020 10:01:26 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 281102087E
	for <iommu@archiver.kernel.org>; Fri,  6 Nov 2020 10:01:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 281102087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A321485D95;
	Fri,  6 Nov 2020 10:01:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ob6aZ4V4unLx; Fri,  6 Nov 2020 10:01:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B44FC85C9D;
	Fri,  6 Nov 2020 10:01:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9321DC088B;
	Fri,  6 Nov 2020 10:01:22 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 00897C0889
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 10:01:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id E1B5486FC1
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 10:01:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id n04z8BY3LftA for <iommu@lists.linux-foundation.org>;
 Fri,  6 Nov 2020 10:01:19 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 663EF86FBE
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 10:01:19 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 96D3468B02; Fri,  6 Nov 2020 11:01:15 +0100 (CET)
Date: Fri, 6 Nov 2020 11:01:15 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH 3/6] RDMA/core: remove use of dma_virt_ops
Message-ID: <20201106100115.GA5951@lst.de>
References: <20201105074205.1690638-1-hch@lst.de>
 <20201105074205.1690638-4-hch@lst.de> <20201105175253.GA35235@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201105175253.GA35235@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: Zhu Yanjun <yanjunz@nvidia.com>,
 Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
 linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
 Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
 iommu@lists.linux-foundation.org, Bjorn Helgaas <bhelgaas@google.com>,
 Bernard Metzler <bmt@zurich.ibm.com>, Logan Gunthorpe <logang@deltatee.com>,
 Christoph Hellwig <hch@lst.de>
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

On Thu, Nov 05, 2020 at 01:52:53PM -0400, Jason Gunthorpe wrote:
> On Thu, Nov 05, 2020 at 08:42:02AM +0100, Christoph Hellwig wrote:
> > @@ -1341,7 +1322,14 @@ int ib_register_device(struct ib_device *device, const char *name,
> >  	if (ret)
> >  		return ret;
> >  
> > -	setup_dma_device(device, dma_device);
> > +	/*
> > +	 * If the caller does not provide a DMA capable device then the IB core
> > +	 * will set up ib_sge and scatterlist structures that stash the kernel
> > +	 * virtual address into the address field.
> > +	 */
> > +	device->dma_device = dma_device;
> > +	WARN_ON(dma_device && !dma_device->dma_parms);
> 
> I noticed there were a couple of places expecting dma_device to be set
> to !NULL:
> 
> drivers/infiniband/core/umem.c:                 dma_get_max_seg_size(device->dma_device), sg, npages,

This needs to use ib_dma_max_seg_size.

> drivers/nvme/host/rdma.c:       ctrl->ctrl.numa_node = dev_to_node(ctrl->device->dev->dma_device);

> Don't know much about NUMA, but do you think the ib device setup
> should autocopy the numa node from the dma_device to the ib_device and
> this usage should just refer to the ib_device?

IMHO we could add a ib_device_get_numa_node API or something like that,
which uses dev_to_node on the DMA device is present and otherwise returns
-1.  If needed we can refine that later.

> net/rds/ib.c:                                              device->dma_device,
> 
> No sure what to do about RDS..

Yikes, this is completely broken.  We either need a wrapper for the
dma_pool API, or get rid of it.  Let me dig into that.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
