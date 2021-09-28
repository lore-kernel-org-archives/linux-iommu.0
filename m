Return-Path: <SRS0=IJZW=OS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C35CC4332F
	for <iommu@archiver.kernel.org>; Tue, 28 Sep 2021 18:58:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4A5061209
	for <iommu@archiver.kernel.org>; Tue, 28 Sep 2021 18:58:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A4A5061209
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6E3B6414BD;
	Tue, 28 Sep 2021 18:58:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id j1f7kdVHC_2t; Tue, 28 Sep 2021 18:57:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6734E414B6;
	Tue, 28 Sep 2021 18:57:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3CC03C0011;
	Tue, 28 Sep 2021 18:57:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C491BC000D
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 18:57:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AD045414BD
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 18:57:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id c3EPJDPGZ7fd for <iommu@lists.linux-foundation.org>;
 Tue, 28 Sep 2021 18:57:58 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 27C67414B6
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 18:57:58 +0000 (UTC)
Received: by mail-pj1-x1036.google.com with SMTP id
 rm6-20020a17090b3ec600b0019ece2bdd20so3582327pjb.1
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 11:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=oHaryRFi/fpZmucH1uQxicsHfaWcwCrvG9TbLYxvHTw=;
 b=Jx2GOuLqIF/s/mi2Zrk/xAaRKuyWPWZHCfm+XwkC1Yr0Dv0vjM+OfZQXVIMiJLsjmt
 UrV/wXbA0S/kA8NHbPEFpp1dbqLg5YihHJ0daxdbRmoiYipdrvH9aE1GR+5dg2ru+RLb
 D9RlleKhxyRZz7x683IeC5JDgX+RCiwr9h+iGzv5av3RkyBoFDWC4oGW5kDI8NZqd+wU
 GG0wiVbU0tcwD2OsUIWVh8MXHIcG0Qmyu9kG4Cl/ZJH0N5wnluQLcxjz6xhITElaiUL1
 soubsWJ2CeaU97V7PVulKA29iDPu0PVzaYdGQFsHPsL8RlHji5XVx44zUSja9oX1iGFJ
 ehCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=oHaryRFi/fpZmucH1uQxicsHfaWcwCrvG9TbLYxvHTw=;
 b=fS40xPgPg6sQKMJP+QaMG5KeI/DuGRhzEFxtH1ZrGHIqyNiPI3XlWbM3JF3jgGacSU
 jxJqMN4EVR/rdTEErjR3ZjJIxb0nBENSJJiXCbyK4jxrj5KQV/Qc9Wx7MW8d4couyP8E
 CBLScnPPJkrwDwtGGpfMTRmyXRq3Z0U82LgYvo+meb+semqKPS5IHPjzR3B8AN/v4G8j
 PLXRwc9HGg4lg/6MxpjcGeRffdXWjL/qPHXYJY8VTRTz8PvaKrTybwDIJt1yiCPyBswO
 g+/klG0CA2mIy+aIfkCqcipViMFq77HxTfmh04NVJiSCbOrCrTtObcBYLYiJX0ndXNH1
 aypA==
X-Gm-Message-State: AOAM531TbiUQJm7G6qFOuTpufskc5wBPx9NN3yDiEKYD9NtZyRbYn+EM
 p3r2jWeF8nH8QMcEQNRDy0I5Fg==
X-Google-Smtp-Source: ABdhPJx53FQmydkeg1NJ3LXDS/rZkMGUByvF4f/aWGCpIOOYUi1lNT78rKchyK327J3h0Fhk9/CHgw==
X-Received: by 2002:a17:902:a604:b029:12c:dda2:30c4 with SMTP id
 u4-20020a170902a604b029012cdda230c4mr6060505plq.73.1632855477627; 
 Tue, 28 Sep 2021 11:57:57 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
 by smtp.gmail.com with ESMTPSA id o20sm22682349pgd.31.2021.09.28.11.57.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Sep 2021 11:57:57 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1mVIId-007FjO-20; Tue, 28 Sep 2021 15:57:55 -0300
Date: Tue, 28 Sep 2021 15:57:55 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH v3 05/20] dma-mapping: allow EREMOTEIO return code for
 P2PDMA transfers
Message-ID: <20210928185755.GM3544071@ziepe.ca>
References: <20210916234100.122368-1-logang@deltatee.com>
 <20210916234100.122368-6-logang@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210916234100.122368-6-logang@deltatee.com>
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

On Thu, Sep 16, 2021 at 05:40:45PM -0600, Logan Gunthorpe wrote:
> Add EREMOTEIO error return to dma_map_sgtable() which will be used
> by .map_sg() implementations that detect P2PDMA pages that the
> underlying DMA device cannot access.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>  kernel/dma/mapping.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
