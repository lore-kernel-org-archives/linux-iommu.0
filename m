Return-Path: <SRS0=eQNl=EL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F62C4741F
	for <iommu@archiver.kernel.org>; Thu,  5 Nov 2020 17:39:37 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F01E12072E
	for <iommu@archiver.kernel.org>; Thu,  5 Nov 2020 17:39:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="E++Hclqm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F01E12072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 63293870EA;
	Thu,  5 Nov 2020 17:39:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lc8bVBBpYwST; Thu,  5 Nov 2020 17:39:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id A7F32870E2;
	Thu,  5 Nov 2020 17:39:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 893C2C088B;
	Thu,  5 Nov 2020 17:39:35 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 09886C0889
 for <iommu@lists.linux-foundation.org>; Thu,  5 Nov 2020 17:39:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id E432C85AB5
 for <iommu@lists.linux-foundation.org>; Thu,  5 Nov 2020 17:39:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Rj0ZWFS4vpvl for <iommu@lists.linux-foundation.org>;
 Thu,  5 Nov 2020 17:39:32 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-qv1-f66.google.com (mail-qv1-f66.google.com
 [209.85.219.66])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 6DAC885A84
 for <iommu@lists.linux-foundation.org>; Thu,  5 Nov 2020 17:39:32 +0000 (UTC)
Received: by mail-qv1-f66.google.com with SMTP id g13so1083904qvu.1
 for <iommu@lists.linux-foundation.org>; Thu, 05 Nov 2020 09:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=ubXxQSNX1b1oqxlICbUVJ8ka1QZRYtb9rgzYhqrREuI=;
 b=E++HclqmQVeK92papBPF4aIcnXcN7nQrgTwqb5TYWE+kVi3biy3Pr+xFPeoPzc+vkl
 haPfPdFVl3+6NE0S+pEPlGv0uynG18Tq/AoX78TJYIaICvZbDLZYASeMow80Cb0EMtO9
 82fxXgUS8G++0gS1rZwPFffiaxeqNtL36E1CUZYQTgo/e6WLkqNBShxnWmJfup4jkyqp
 /PcgP3Xwu+p8jV0wiO3SiGzvGP1aDHvi1kbSjEWmk5R31h7Jm3q3p9XYedzANbb83h/M
 tOeaaAAkWZ2HusMuRnBgLCI2OHIO+cdzQBpr293za1JoX5HlMfar+r9LU2MN31PG0H0i
 lZFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ubXxQSNX1b1oqxlICbUVJ8ka1QZRYtb9rgzYhqrREuI=;
 b=M+dXVpG2xh2B8AVph7AMT1TLHludkJXsW7hjnLObboAD6nrKuUQ8jXXMMGSxmXTPCM
 2BCesc9AVWfG0RcQ5rF+13sg2vVYBmb/T9nkj2iyg8uKD9ebhJbmB1g5Xhmcg6QFpIbA
 ovYkz6SJsTdryj6XdpX7GJRmTfVzR1wsARk03844TaWXmHwG98UAx7EzdwDvKTlqf+E5
 rNBCiivi6XfnDK8FmfsSUDyYxtj4CjpFpPCP2fgJDxLurFFdSGTLpsHOggC84O/R5w3x
 IgiMhnagLqLEMeTcfIONyS+eYzuom2FPFLZNxWmMLrZRyt1pS9jKyJWc2gOree6xr8pE
 4IcA==
X-Gm-Message-State: AOAM5325J3w4m0z0xQZ03xZH72S6EA+RbkOPwg1VakxW1Nt+GV8uBnir
 PgwuPf7qGkFrJ5NdTI4Ht6pPsg==
X-Google-Smtp-Source: ABdhPJx+0vEjrI7P8UuwVjg1neN0lTplv9fazt5XCR/ixwReG/F1831L+mIEo9skzDNwWI1oj7cgeA==
X-Received: by 2002:a05:6214:1188:: with SMTP id
 t8mr3117414qvv.18.1604597971538; 
 Thu, 05 Nov 2020 09:39:31 -0800 (PST)
Received: from ziepe.ca
 (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [156.34.48.30])
 by smtp.gmail.com with ESMTPSA id j5sm1298744qtv.91.2020.11.05.09.39.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2020 09:39:30 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1kajEQ-0008oJ-B8; Thu, 05 Nov 2020 13:39:30 -0400
Date: Thu, 5 Nov 2020 13:39:30 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 4/6] PCI/P2PDMA: Remove the DMA_VIRT_OPS hacks
Message-ID: <20201105173930.GF36674@ziepe.ca>
References: <20201105074205.1690638-1-hch@lst.de>
 <20201105074205.1690638-5-hch@lst.de>
 <20201105143418.GA4142106@ziepe.ca> <20201105170816.GC7502@lst.de>
 <20201105172357.GE36674@ziepe.ca> <20201105172921.GA9537@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201105172921.GA9537@lst.de>
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

On Thu, Nov 05, 2020 at 06:29:21PM +0100, Christoph Hellwig wrote:
> On Thu, Nov 05, 2020 at 01:23:57PM -0400, Jason Gunthorpe wrote:
> > But that depends on the calling driver doing this properly, and we
> > don't expose an API to get the PCI device of the struct ib_device
> > .. how does nvme even work here?
> 
> The PCI p2pdma APIs walk the parent chains of a struct device until
> they find a PCI device.  And the ib_device eventually ends up there.

Hmm. This works for real devices like mlx5, but it means the three SW
devices will also resolve to a real PCI device that is not the DMA
device.

If nvme wants to do something like this it should walk from the
ibdev->dma_device, after these patches to make dma_device NULL.

eg rxe is like:

$ sudo rdma link add rxe0 type rxe netdev eth1

lrwxrwxrwx 1 root root 0 Nov  5 17:34 /sys/class/infiniband/rxe0/device -> ../../../0000:00:09.0/

I think this is a bug, these virtual devices should have NULL
parents...

> > If we can't get here then why did you add the check to the unmap side?
> 
> Because I added them to the map and unmap side, but forgot to commit
> the map side.  Mostly to be prepared for the case where we could
> end up there.  And thinking out loud I actually need to double check
> rdmavt if that is true there as well.  It certainly is for rxe and
> siw as I checked it on a live system.

rdmavt parents itself to the HFI/QIB PCI device, so the walk above
should also find a real PCI device

> > The SW drivers can't handle PCI pages at all, they are going to try to
> > memcpy them or something else not __iomem, so we really do need to
> > prevent P2P pages going into them.
> 
> Ok, let's prevent it for now.  And if someone wants to do it there
> they have to do all the work.

Yes, that is the safest - just block the SW devices from ever touch
P2P pages.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
