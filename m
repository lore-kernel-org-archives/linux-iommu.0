Return-Path: <SRS0=eQNl=EL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B06D5C55178
	for <iommu@archiver.kernel.org>; Thu,  5 Nov 2020 17:58:23 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 092F02074B
	for <iommu@archiver.kernel.org>; Thu,  5 Nov 2020 17:58:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="E1HBlRXY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 092F02074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id A1BE7866E7;
	Thu,  5 Nov 2020 17:58:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id r9ClFfrmRArT; Thu,  5 Nov 2020 17:58:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1F2888553C;
	Thu,  5 Nov 2020 17:58:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 00B76C088B;
	Thu,  5 Nov 2020 17:58:22 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AE25AC0889
 for <iommu@lists.linux-foundation.org>; Thu,  5 Nov 2020 17:58:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 9CBD787158
 for <iommu@lists.linux-foundation.org>; Thu,  5 Nov 2020 17:58:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QhLNMEda027R for <iommu@lists.linux-foundation.org>;
 Thu,  5 Nov 2020 17:58:18 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-qk1-f194.google.com (mail-qk1-f194.google.com
 [209.85.222.194])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 5902586D42
 for <iommu@lists.linux-foundation.org>; Thu,  5 Nov 2020 17:58:18 +0000 (UTC)
Received: by mail-qk1-f194.google.com with SMTP id 11so2007945qkd.5
 for <iommu@lists.linux-foundation.org>; Thu, 05 Nov 2020 09:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=IV2pMAD0GDkCc858XzaHv7E4h3K+d+uW6Iv2k0uw7L8=;
 b=E1HBlRXYwbDvEdNlW4RmkR7rTF1T1GLQXH1l6KDVxZadZr6pW2rmQlTxGBBVRuROLf
 yi3XZGVa7/ZfRjpI2YW5sUs3BbknwOQL2gGRoLqZixEj7lh7JDdZTYjcQT0QxDvXCqYv
 d8sQLyr8J1r5mlty6l39ypIuuYAhvrht+miISyAhXZWienxSWr5xZ6xhY/UwYYExZVk4
 eUnzv/UqYLRYKEPSxdVPsxZezSeeMmKqUM9YfPkKpT+W2w85lrT0Jo8bmeK2rUn3xAqI
 QDyxBcvY8IOa+RqgsRlDZnjd8jh+EtbKJWHLeljDmllAoV2ZNTd+c5g8cxbbZp2QWdf1
 8Spw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=IV2pMAD0GDkCc858XzaHv7E4h3K+d+uW6Iv2k0uw7L8=;
 b=L1XuWWLsSmJYMnoyBMGJJafPiA9gJe7ZXbl4+Y4Z4I1r3qYmfVGcayocqXM0XR1cuG
 LLGByeichkv2wzMyHJM1HcubjEHgI9p4EXeYa4hC8sMP1G7B2tUmo2KqCTswEmLBhmoM
 qgjL8NqA7GT+WAPrgTTPKxKTLyqsCIVYZt71krIAU+BBJPhAb+soQQb4gfiMtonGfhTz
 3a+W/vYggvdsPJYINjDBLH/byTsMFx3DZFJbnTyM/XaqszenMpgUwvG581g7NyzGvBJK
 xe3L0OYMnGQIKxWhMsed/Gx2VsENBu43j8LvnkBHsGgDzrhlijg+ef+sOc3GMBchl2XU
 XStg==
X-Gm-Message-State: AOAM532cGCuTCj5R16C2LzgY6qRWZMdck2ARFEw3WvepXI4IdBnAGdyU
 qVsReVCchajLrKNW4MoRxE/wQQ==
X-Google-Smtp-Source: ABdhPJxiXODJ6wdpxteKHXxL3pwnTfgdrXuumCF525zWmopkS6fq/JQpD8tKfMhxXjHU8eEOclMa9A==
X-Received: by 2002:a05:620a:a09:: with SMTP id
 i9mr3033099qka.119.1604599097354; 
 Thu, 05 Nov 2020 09:58:17 -0800 (PST)
Received: from ziepe.ca
 (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [156.34.48.30])
 by smtp.gmail.com with ESMTPSA id f1sm1246044qtf.68.2020.11.05.09.58.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2020 09:58:16 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1kajWa-0009LK-68; Thu, 05 Nov 2020 13:58:16 -0400
Date: Thu, 5 Nov 2020 13:58:16 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 3/6] RDMA/core: remove use of dma_virt_ops
Message-ID: <20201105175816.GH36674@ziepe.ca>
References: <20201105074205.1690638-1-hch@lst.de>
 <20201105074205.1690638-4-hch@lst.de>
 <20201105175253.GA35235@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201105175253.GA35235@nvidia.com>
Cc: Zhu Yanjun <yanjunz@nvidia.com>,
 Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
 linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
 Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
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
> drivers/nvme/host/rdma.c:       ctrl->ctrl.numa_node = dev_to_node(ctrl->device->dev->dma_device);

Don't know much about NUMA, but do you think the ib device setup
should autocopy the numa node from the dma_device to the ib_device and
this usage should just refer to the ib_device?

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
