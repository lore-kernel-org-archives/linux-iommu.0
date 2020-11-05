Return-Path: <SRS0=eQNl=EL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 291FEC55178
	for <iommu@archiver.kernel.org>; Thu,  5 Nov 2020 17:09:21 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B645206F9
	for <iommu@archiver.kernel.org>; Thu,  5 Nov 2020 17:09:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B645206F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 08E3C23504;
	Thu,  5 Nov 2020 17:09:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jL1jCGg3QXh5; Thu,  5 Nov 2020 17:09:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id E1A8D2041A;
	Thu,  5 Nov 2020 17:09:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C8A2EC088B;
	Thu,  5 Nov 2020 17:09:18 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CF378C0889
 for <iommu@lists.linux-foundation.org>; Thu,  5 Nov 2020 17:09:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id CAC53857D1
 for <iommu@lists.linux-foundation.org>; Thu,  5 Nov 2020 17:09:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2GqupxGQFkZ5 for <iommu@lists.linux-foundation.org>;
 Thu,  5 Nov 2020 17:09:17 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 54886857CE
 for <iommu@lists.linux-foundation.org>; Thu,  5 Nov 2020 17:09:17 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id E09B768B02; Thu,  5 Nov 2020 18:09:14 +0100 (CET)
Date: Thu, 5 Nov 2020 18:09:14 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH 3/6] RDMA/core: remove use of dma_virt_ops
Message-ID: <20201105170914.GD7502@lst.de>
References: <20201105074205.1690638-1-hch@lst.de>
 <20201105074205.1690638-4-hch@lst.de> <20201105143415.GB36674@ziepe.ca>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201105143415.GB36674@ziepe.ca>
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

On Thu, Nov 05, 2020 at 10:34:15AM -0400, Jason Gunthorpe wrote:
> On Thu, Nov 05, 2020 at 08:42:02AM +0100, Christoph Hellwig wrote:
> > diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
> > index 5f8fd7976034e0..661e4a22b3cb81 100644
> > +++ b/include/rdma/ib_verbs.h
> > @@ -3950,6 +3950,8 @@ static inline int ib_req_ncomp_notif(struct ib_cq *cq, int wc_cnt)
> >   */
> >  static inline int ib_dma_mapping_error(struct ib_device *dev, u64 dma_addr)
> >  {
> > +	if (!dev->dma_device)
> > +		return 0;
> 
> How about:
> 
> static inline bool ib_uses_virt_dma(struct ib_device *dev)
> {
> 	return IS_ENABLED(CONFIG_INFINIBAND_VIRT_DMA) && !dev->dma_device;
> }
> 
> Which is a a little more guidance that driver authors need to set this
> config symbol.

Sure, I'll do that.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
