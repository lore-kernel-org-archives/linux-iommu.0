Return-Path: <SRS0=IJZW=OS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21225C433FE
	for <iommu@archiver.kernel.org>; Tue, 28 Sep 2021 19:43:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3DA961139
	for <iommu@archiver.kernel.org>; Tue, 28 Sep 2021 19:43:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A3DA961139
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6791B4000B;
	Tue, 28 Sep 2021 19:43:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2rOzJh5RlBFM; Tue, 28 Sep 2021 19:43:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0BD6D4014C;
	Tue, 28 Sep 2021 19:43:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ABBFBC000F;
	Tue, 28 Sep 2021 19:43:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1E32EC000D
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 19:43:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 13E8F829B6
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 19:43:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=ziepe.ca
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Etf4Rx9CgN4g for <iommu@lists.linux-foundation.org>;
 Tue, 28 Sep 2021 19:43:28 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6FF45829B1
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 19:43:28 +0000 (UTC)
Received: by mail-io1-xd2b.google.com with SMTP id y197so42321iof.11
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 12:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=rjLk0h/mLxEL3Q6/W9L7mqQkVvY6tzCz4tgaLSgLx3s=;
 b=hhjthCUJo5WhNKDnLCpo+MVqy6n87T1pJjZguVrbGVB7rs1TEqj8vSzkH1OSVJ4aHY
 Y4CBMG1r9Rmy0NZyrlH5NzTg+Y8qxZoKLG0AvCFUREnWT/psrYWEBqSqvzXvNv5yTDIr
 on4+mWLbQe9rhU1sJ0QNKudA3/36oLT7Zw6sZzQBD1xnoS8UNH2nV0XaX4yDc24jjF2F
 7QkD0f5nx2AT5EawBHny0YCDHI8greowW1MBzYmGKp/2RhkC/7+QDf784bbYh0ttqPja
 SIBG9NG6TFsrj3x8A3HpfCET+Sjd2Z1Hfpwi/GMS9Z23rUtCt6WAlr+9cdU9alzqPn1Q
 1OpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=rjLk0h/mLxEL3Q6/W9L7mqQkVvY6tzCz4tgaLSgLx3s=;
 b=7dcVAJagtmI37y0doKvqrCWeHfaxu722MYyUF8oRrbL5shwwFXbA9zT7ugFP4t5BYd
 941bZp3qDouorDe1QOBBfU5d0o52lackG+FaTg3dq2AUOgHpAc2lOvfSH5LRBTM7oWLa
 Gv0HVA/Y4hi4nONZkUlT+WhUXRAmL3Jz4bLKXgRtr2j44+3NqM2WeuttEDVV7kNaanfB
 HGFJehyM8fr7icaZmmUAKHvWgojygWYCkzsTd0SfUMxw+mSx78VmLZnSBRFc80gngAXN
 PYMhYVPD4tppQPxTb5R7J2X6AfpZsTRwLTquLFj+9IIWzpnxsQdNzz7yFOGQCm6F7486
 8wsw==
X-Gm-Message-State: AOAM533PDACoFYMaa2RNQBc8ehgWxLA/X6IjOvhOBaBhn7ER9AGrWkYq
 iJ3avIpOMYBI17sHYPngQfPHCw==
X-Google-Smtp-Source: ABdhPJxTc9Esg662iHYF19mOveiU9FtR9gwP3ZO8mFkHuFuDP2iiQ1yQeLzvOs2cq2YVQPchFaVZug==
X-Received: by 2002:a02:b91a:: with SMTP id v26mr6047050jan.78.1632858207605; 
 Tue, 28 Sep 2021 12:43:27 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
 by smtp.gmail.com with ESMTPSA id a11sm12090741ilm.36.2021.09.28.12.43.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Sep 2021 12:43:27 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1mVJ0f-007GWk-Q4; Tue, 28 Sep 2021 16:43:25 -0300
Date: Tue, 28 Sep 2021 16:43:25 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH v3 12/20] RDMA/rw: use dma_map_sgtable()
Message-ID: <20210928194325.GS3544071@ziepe.ca>
References: <20210916234100.122368-1-logang@deltatee.com>
 <20210916234100.122368-13-logang@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210916234100.122368-13-logang@deltatee.com>
Cc: linux-pci@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
 linux-nvme@lists.infradead.org, Stephen Bates <sbates@raithlin.com>,
 linux-mm@kvack.org, Jason Ekstrand <jason@jlekstrand.net>,
 Ira Weiny <ira.weiny@intel.com>, Christoph Hellwig <hch@lst.de>,
 Minturn Dave B <dave.b.minturn@intel.com>,
 Martin Oliveira <martin.oliveira@eideticom.com>,
 Matthew Wilcox <willy@infradead.org>,
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Daniel Vetter <daniel.vetter@ffwll.ch>,
 John Hubbard <jhubbard@nvidia.com>, linux-block@vger.kernel.org,
 Dan Williams <dan.j.williams@intel.com>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
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

On Thu, Sep 16, 2021 at 05:40:52PM -0600, Logan Gunthorpe wrote:
> dma_map_sg() now supports the use of P2PDMA pages so pci_p2pdma_map_sg()
> is no longer necessary and may be dropped.
> 
> Switch to the dma_map_sgtable() interface which will allow for better
> error reporting if the P2PDMA pages are unsupported.
> 
> The change to sgtable also appears to fix a couple subtle error path
> bugs:
> 
>   - In rdma_rw_ctx_init(), dma_unmap would be called with an sg
>     that could have been incremented from the original call, as
>     well as an nents that was not the original number of nents
>     called when mapped.
>   - Similarly in rdma_rw_ctx_signature_init, both sg and prot_sg
>     were unmapped with the incorrect number of nents.

Those bugs should definately get fixed.. I might extract the sgtable
conversion into a stand alone patch to do it.

But as it is, this looks fine

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
