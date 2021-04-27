Return-Path: <SRS0=GIAn=JY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1175C433B4
	for <iommu@archiver.kernel.org>; Tue, 27 Apr 2021 19:22:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EDC4613EE
	for <iommu@archiver.kernel.org>; Tue, 27 Apr 2021 19:22:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EDC4613EE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B821C608E3;
	Tue, 27 Apr 2021 19:22:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZsF7_3Tfhd-r; Tue, 27 Apr 2021 19:22:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9496E600CB;
	Tue, 27 Apr 2021 19:22:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 63512C0023;
	Tue, 27 Apr 2021 19:22:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A4E76C001A
 for <iommu@lists.linux-foundation.org>; Tue, 27 Apr 2021 19:22:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 84BAE405C1
 for <iommu@lists.linux-foundation.org>; Tue, 27 Apr 2021 19:22:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=ziepe.ca
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 735v9B1hIvH4 for <iommu@lists.linux-foundation.org>;
 Tue, 27 Apr 2021 19:22:36 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0C7AD4059B
 for <iommu@lists.linux-foundation.org>; Tue, 27 Apr 2021 19:22:35 +0000 (UTC)
Received: by mail-il1-x135.google.com with SMTP id a9so2468518ilh.9
 for <iommu@lists.linux-foundation.org>; Tue, 27 Apr 2021 12:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=9A9KdhpIimzuD5OzCChHO2CjGhCpPan1yRAo2/CAv+c=;
 b=KmmcN+wJO4XJEW8i1n4M8fdsVxKICGd+cicWY6PhIyfMntf61DWDbN0lYONPfv7avX
 7FxH4J1DcHU+d/BPW07cIeL7M0+KsL2H3xjnwnUShzOsbwp4p1Mstgek0/DJDywqlAvj
 pvQ4AeQxgT8d2B9boE2xCyb2V/QcKRwgqazkbOV36nIXZRCI1I41ENBc9O94GPWzuGWn
 ZoVb91ruebPuMOxROumRJF1bkL3LMcW5p3RL67vEkcYBqN+97GnMi303v4vqdgIYcysj
 J3wZPapZMjRdKb47N21dcq6V8IXSfFXXFfDtIZJD9rm1L4Cs5YgpeYsNB9gao99MRN+M
 bnKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=9A9KdhpIimzuD5OzCChHO2CjGhCpPan1yRAo2/CAv+c=;
 b=rFpiaa8HlpEicbqETj2H38Q9MhhFuTISlsqLAOk1oReyV0bXUp2E+eE5sCnGgGmbY4
 o8DCkKE1zn281gTUIk8va9swhDwrv8/Gfp0qRVB73s2z+ZETV/Fv9pH76XetdkAAKk9U
 fnzt6QJll9l9EGaXsn3OtmL1zDYh3tM3BaeWKWM1pykaZOOeOgwbU94cb13lnOIVaox4
 F38dJ2eHKEm3C4YSt7zeNNZBLldslfK368l7xv5quQ/CpwEWlLnByaS/xkKE93YF2tkp
 AjuXGA3kxHFNxJqRHMB5XKDuk+9lI9o9Q1l6TJAqO6x8KD3YZAJqFI9UgrOr2HQOjITQ
 Lu5g==
X-Gm-Message-State: AOAM532gkDZWvueWbw4xZTDeCP1EgBsCs8J9e8yyhElCs9oUupjxqBIx
 fCeXdrT5d37VkWvkVZzQjeHqrA==
X-Google-Smtp-Source: ABdhPJx4F96uXqpXKJbkwUaij1OmBpJfBrZ4CVUAcProKFEqjv4XzeMalTF3wkg8sv23tVBPaKB/YA==
X-Received: by 2002:a05:6e02:13ca:: with SMTP id
 v10mr18478934ilj.191.1619551354939; 
 Tue, 27 Apr 2021 12:22:34 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
 by smtp.gmail.com with ESMTPSA id d2sm1817918ile.18.2021.04.27.12.22.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Apr 2021 12:22:34 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1lbTI0-00Dglq-Rs; Tue, 27 Apr 2021 16:22:32 -0300
Date: Tue, 27 Apr 2021 16:22:32 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH 05/16] dma-mapping: Introduce dma_map_sg_p2pdma()
Message-ID: <20210427192232.GO2047089@ziepe.ca>
References: <20210408170123.8788-1-logang@deltatee.com>
 <20210408170123.8788-6-logang@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210408170123.8788-6-logang@deltatee.com>
Cc: linux-pci@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
 linux-nvme@lists.infradead.org, Stephen Bates <sbates@raithlin.com>,
 linux-mm@kvack.org, Jason Ekstrand <jason@jlekstrand.net>,
 Ira Weiny <ira.weiny@intel.com>, Christoph Hellwig <hch@lst.de>,
 Minturn Dave B <dave.b.minturn@intel.com>,
 Matthew Wilcox <willy@infradead.org>, Bjorn Helgaas <helgaas@kernel.org>,
 Daniel Vetter <daniel.vetter@ffwll.ch>, John Hubbard <jhubbard@nvidia.com>,
 linux-block@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
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

On Thu, Apr 08, 2021 at 11:01:12AM -0600, Logan Gunthorpe wrote:
> dma_map_sg() either returns a positive number indicating the number
> of entries mapped or zero indicating that resources were not available
> to create the mapping. When zero is returned, it is always safe to retry
> the mapping later once resources have been freed.
> 
> Once P2PDMA pages are mixed into the SGL there may be pages that may
> never be successfully mapped with a given device because that device may
> not actually be able to access those pages. Thus, multiple error
> conditions will need to be distinguished to determine weather a retry
> is safe.
> 
> Introduce dma_map_sg_p2pdma[_attrs]() with a different calling
> convention from dma_map_sg(). The function will return a positive
> integer on success or a negative errno on failure.
> 
> ENOMEM will be used to indicate a resource failure and EREMOTEIO to
> indicate that a P2PDMA page is not mappable.
> 
> The __DMA_ATTR_PCI_P2PDMA attribute is introduced to inform the lower
> level implementations that P2PDMA pages are allowed and to warn if a
> caller introduces them into the regular dma_map_sg() interface.

So this new API is all about being able to return an error code
because auditing the old API is basically terrifying?

OK, but why name everything new P2PDMA? It seems nicer to give this
some generic name and have some general program to gradually deprecate
normal non-error-capable dma_map_sg() ?

I think that will raise less questions when subsystem people see the
changes, as I was wondering why RW was being moved to use what looked
like a p2pdma only API.

dma_map_sg_or_err() would have been clearer

The flag is also clearer as to the purpose if it is named
__DMA_ATTR_ERROR_ALLOWED

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
