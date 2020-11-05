Return-Path: <SRS0=eQNl=EL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B57EEC4741F
	for <iommu@archiver.kernel.org>; Thu,  5 Nov 2020 17:56:38 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 245A920715
	for <iommu@archiver.kernel.org>; Thu,  5 Nov 2020 17:56:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="MBcmsgnr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 245A920715
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9DB9D85B94;
	Thu,  5 Nov 2020 17:56:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hpb6JHE3S_q0; Thu,  5 Nov 2020 17:56:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id BE4DE8593F;
	Thu,  5 Nov 2020 17:56:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8EF39C088B;
	Thu,  5 Nov 2020 17:56:36 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EC68FC0889
 for <iommu@lists.linux-foundation.org>; Thu,  5 Nov 2020 17:56:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id D89AC866B8
 for <iommu@lists.linux-foundation.org>; Thu,  5 Nov 2020 17:56:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id n8dXKJonJaPX for <iommu@lists.linux-foundation.org>;
 Thu,  5 Nov 2020 17:56:35 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-qt1-f196.google.com (mail-qt1-f196.google.com
 [209.85.160.196])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 1E4998553C
 for <iommu@lists.linux-foundation.org>; Thu,  5 Nov 2020 17:56:35 +0000 (UTC)
Received: by mail-qt1-f196.google.com with SMTP id r8so1694505qtp.13
 for <iommu@lists.linux-foundation.org>; Thu, 05 Nov 2020 09:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=PkeuaecEHHScjy0gtmL00e+LrPcvo+4cdZQoihz0wZM=;
 b=MBcmsgnrs10gbIIyzWv4uOz9JUTEFxY9v/n9JzvL/W/ZuwJW/GY9YDzqQ6CT8Vc7Ex
 I39mTyNNLmG5UGOMjGKQtDOuUucT8RxUCHx/CIKKSmeUTdwWeHYgBPxrgBYIVq4ZHtjD
 jNw9oAuSYqJW+mTjaNGirHCmz5uBIZZwalyGFSeuQADSuTdIcK3Jxgy9QN2Hs/yNAqu4
 LJEfcxlchXsOTp5ObapYG//92CiXgRoR5TCzi1jlsHAxPl3LnNCSF9eBy0XUryNuVxg7
 HePsWXzXvuf97msTcYoxUEMzzKEkGu22jzfNyAp2VPZ3HYaQUNq2LR105U0VQ3eGj0HM
 hN8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=PkeuaecEHHScjy0gtmL00e+LrPcvo+4cdZQoihz0wZM=;
 b=eHMPH7TcG0dsEJ2KOmb5BtAnpTjfagpdo9iGTJLo1lFOjStEyItjp6IIrxmm9yFX66
 dG8yNRuhB9/u4OXuZKOX9gQJRMz/U0pdU3SXBqUBbbgT2O8vY3AEzQFA+AFx+gLj7Yxg
 bSUayJgzwhmIUEI3nh/613zoa1Dk4DMRN2bBfeR+iNpyX4aTlbdaSBBl08DZtiCZ175V
 IdHmqaGgxvelzzMx2OjkdbqupimccTITmJRXH0QUoBnAEPRxseT0la5d/IiKysyaJxRh
 bv8AUqZU8l/HZdHMWG1AYjWppAffMRWTmD0AA5xuj2C2/UKRxSrU8i7OWXQaka+lTU5s
 NhAQ==
X-Gm-Message-State: AOAM531dhHMt9gMaDw8Wsf8k5zKzjm6bMrpFuVW1YcYC/tQhfcpzLCtJ
 h+PktBWbeB8M4tO9bxEHvog3kQ==
X-Google-Smtp-Source: ABdhPJyXnJXLghwsZVy8iD37UxR+fSCbD1DVIGylUU63uSdLwghrLTDFjtnDXTTQqgFL31+HeP4bng==
X-Received: by 2002:ac8:5745:: with SMTP id 5mr3150700qtx.226.1604598994165;
 Thu, 05 Nov 2020 09:56:34 -0800 (PST)
Received: from ziepe.ca
 (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [156.34.48.30])
 by smtp.gmail.com with ESMTPSA id m26sm1460830qka.118.2020.11.05.09.56.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2020 09:56:33 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1kajUu-0009Js-Tl; Thu, 05 Nov 2020 13:56:32 -0400
Date: Thu, 5 Nov 2020 13:56:32 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 4/6] PCI/P2PDMA: Remove the DMA_VIRT_OPS hacks
Message-ID: <20201105175632.GG36674@ziepe.ca>
References: <20201105074205.1690638-1-hch@lst.de>
 <20201105074205.1690638-5-hch@lst.de>
 <20201105143418.GA4142106@ziepe.ca> <20201105170816.GC7502@lst.de>
 <20201105172357.GE36674@ziepe.ca> <20201105172921.GA9537@lst.de>
 <20201105173930.GF36674@ziepe.ca> <20201105174306.GA10757@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201105174306.GA10757@lst.de>
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

On Thu, Nov 05, 2020 at 06:43:06PM +0100, Christoph Hellwig wrote:
> On Thu, Nov 05, 2020 at 01:39:30PM -0400, Jason Gunthorpe wrote:
> > Hmm. This works for real devices like mlx5, but it means the three SW
> > devices will also resolve to a real PCI device that is not the DMA
> > device.
> 
> Does it?  When I followed the links on my system rxe was a virtual
> device without a physical parent.  Weird.

Yes, Bob also might have seen it oddly be virtual too.. No idea why.

This seems like the right thing to do, looks like virtual is only
possible if the netdev is virtual too..

diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index 575e1a4ec82121..2b4238cdeab953 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -20,18 +20,6 @@
 
 static struct rxe_recv_sockets recv_sockets;
 
-struct device *rxe_dma_device(struct rxe_dev *rxe)
-{
-	struct net_device *ndev;
-
-	ndev = rxe->ndev;
-
-	if (is_vlan_dev(ndev))
-		ndev = vlan_dev_real_dev(ndev);
-
-	return ndev->dev.parent;
-}
-
 int rxe_mcast_add(struct rxe_dev *rxe, union ib_gid *mgid)
 {
 	int err;
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 209c7b3fab97a2..0cc4116d9a1fa6 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -1134,7 +1134,6 @@ int rxe_register_device(struct rxe_dev *rxe, const char *ibdev_name)
 	dev->node_type = RDMA_NODE_IB_CA;
 	dev->phys_port_cnt = 1;
 	dev->num_comp_vectors = num_possible_cpus();
-	dev->dev.parent = rxe_dma_device(rxe);
 	dev->local_dma_lkey = 0;
 	addrconf_addr_eui48((unsigned char *)&dev->node_guid,
 			    rxe->ndev->dev_addr);
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
