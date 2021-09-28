Return-Path: <SRS0=IJZW=OS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED80C433F5
	for <iommu@archiver.kernel.org>; Tue, 28 Sep 2021 19:43:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11E8761139
	for <iommu@archiver.kernel.org>; Tue, 28 Sep 2021 19:43:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 11E8761139
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D52C9829B6;
	Tue, 28 Sep 2021 19:43:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YceMVpFlWlxc; Tue, 28 Sep 2021 19:43:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 29247829B1;
	Tue, 28 Sep 2021 19:43:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 056BEC000F;
	Tue, 28 Sep 2021 19:43:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 74E8BC000D
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 19:43:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 54D4B4014C
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 19:43:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=ziepe.ca
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id n94J1EhBCc4g for <iommu@lists.linux-foundation.org>;
 Tue, 28 Sep 2021 19:43:49 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 263ED4000B
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 19:43:49 +0000 (UTC)
Received: by mail-io1-xd2d.google.com with SMTP id b10so56320ioq.9
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 12:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=KMNjWRPS+Q/mkVMPwwRkvOHehmG3YaypC9IFrB3ZJ9Y=;
 b=ZaQqv4m808BuxDtGeChZCPzv4c52NMfLQHqoImEoIEMRktgEpidQ0ZAlaBzLiOgw2y
 4l7Us3OLiVksCSNisKnyEb1D4P1RyMjFLOa8HY/XMbPST1a9XRronsuCK46GdHIoKvOQ
 rVc1XwfKxHSsXcs4HW1yvQf7l+k9oqiRzK1FppsrZ71WeRxwfhW2epLKyirhoD9pZcR+
 9N3kupzPvhNrqC2t4nGZ1pxzZaEA8+UhDCVzAe12EQrq909NaIgptNCZerW6CzU7kfEF
 kpwTu4O75rJ2ShP1PWF7I9mYl3Pu9O8QL99v+c/gI+XAsb1bLcUON8byaZpmO5mXC6R5
 uPjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=KMNjWRPS+Q/mkVMPwwRkvOHehmG3YaypC9IFrB3ZJ9Y=;
 b=CE4CJVAOJcEoNIfc7rpl89tBk6Gz02E77ru5KO7s0xVA08Bul8pkST8tF+FVFsERbc
 O7ZXylqT71o6hYXAYv8xuQwpW9KLX95ZQrauoxG7/yVvr+nGKmaOKx+HylVh3tukkHaH
 CIlovov+1MEtX0Hb11LAofLENcavz10o3QiuvSjPYSASCVPgbQdZFS0O4H/hQdkiiGze
 iCkK5F4HO254LRe8siPG63o4vNzIPdXgi2Gl/BLyaPcFBWxh1KHUVfcmJa2DyaZa85wD
 oMK/E0mIzkklk4WCtgW0ICHiJk2uJ6RZPF3y9A+qyGuxzgva1W5ka0idPT/86kZMIuE9
 6g5g==
X-Gm-Message-State: AOAM532ROg7um2Yi7sbH9xqaN7uE8iiXgujTYicJbrqMCfasAFc3QBBK
 mq+YOnEZlXsAwR3RiG/L63Gr+A==
X-Google-Smtp-Source: ABdhPJxmxz+0kmlqXJtf+sZu5nJ5PkoIQJaS8/KyXSBNASkg5OkMz+upj0MvOj1bWgx5qCPm07nk2g==
X-Received: by 2002:a6b:8f47:: with SMTP id r68mr5097857iod.18.1632858228189; 
 Tue, 28 Sep 2021 12:43:48 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
 by smtp.gmail.com with ESMTPSA id l1sm11703946ilc.65.2021.09.28.12.43.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Sep 2021 12:43:47 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1mVJ10-007GXo-Qu; Tue, 28 Sep 2021 16:43:46 -0300
Date: Tue, 28 Sep 2021 16:43:46 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH v3 13/20] PCI/P2PDMA: remove pci_p2pdma_[un]map_sg()
Message-ID: <20210928194346.GT3544071@ziepe.ca>
References: <20210916234100.122368-1-logang@deltatee.com>
 <20210916234100.122368-14-logang@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210916234100.122368-14-logang@deltatee.com>
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

On Thu, Sep 16, 2021 at 05:40:53PM -0600, Logan Gunthorpe wrote:
> This interface is superseded by support in dma_map_sg() which now supports
> heterogeneous scatterlists. There are no longer any users, so remove it.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>  drivers/pci/p2pdma.c       | 65 --------------------------------------
>  include/linux/pci-p2pdma.h | 27 ----------------
>  2 files changed, 92 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Good riddance :)

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
