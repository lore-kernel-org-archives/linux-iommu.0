Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A5ECC43334
	for <iommu@archiver.kernel.org>; Thu,  2 Jun 2022 16:31:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AD9BB60B56;
	Thu,  2 Jun 2022 16:31:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fh2tSY6F1XTs; Thu,  2 Jun 2022 16:31:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 82D4460B1C;
	Thu,  2 Jun 2022 16:31:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4F842C0039;
	Thu,  2 Jun 2022 16:31:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 23513C002D
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jun 2022 16:31:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 09BEC40570
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jun 2022 16:31:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=ziepe.ca
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aJtqcncu1UH0 for <iommu@lists.linux-foundation.org>;
 Thu,  2 Jun 2022 16:31:02 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E4C87400D8
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jun 2022 16:31:01 +0000 (UTC)
Received: by mail-qt1-x829.google.com with SMTP id x7so3739871qta.6
 for <iommu@lists.linux-foundation.org>; Thu, 02 Jun 2022 09:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=k8kPkxVeNMtdQt55yGN/Nkf+fdNFP4n1eqHNYFzt/EM=;
 b=RBKGIdGVGyENiynuzvWzxsfKrlShOYG7LDNM6zk7j/0cpFAWM0CNoQ/RikC676Zwip
 BMHOMh5FSPCGjY61J1z6G+8c1X+4G/XGBmJ3fum6tDtClMi6od+zOdkcyAAKXb0oiOit
 b12jjL7nGu0mjk8vwPx18er2whDmGOBIM4slv0jp+xyv6iWVZkV8Hkprx2Ft3TnlNr8S
 F3ZKnuaS0udbsMCk0y55d04otKL6PRXBEyvPN62xIots/ndr10XIEf2q5FJvYZj2hwlD
 Ppp12ccOTvvIFXm+WxGW6jlLIOBk5xmPC4ktWEJBo/O94h/wW5jv5ZkhHpnGnc8M8pyV
 u4zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=k8kPkxVeNMtdQt55yGN/Nkf+fdNFP4n1eqHNYFzt/EM=;
 b=IsOkYp4N5zo+r77uuQUcjs2fIOGQ+GsE07Pnp+qcG1x69Xthzu3hp8CVIu2wJHZkrP
 DEC4f7KaF+dKwMRMpZZLrVlE4uSyJ8cMVoRRTfDpxtkXVG28GjtN3Yr7Com3CE6MyQKL
 m8K/KYckSK2iCO5AWGBKvf+XZILrYza908NTMRCj+kvXeBEBh9Wblpu0GEvQ8N0aHrDX
 DLWVgG9uLsnYSmeBa2h7grSw0zhj4Yrb/uJOImWna9P3h9KCe2gNWUEqXyB6VuOnWBoz
 /E7NJu6jAN+MxypsJZ642C28D9day9GfUITMovHcFvptJW2q0FKUhI2ryardQPfjA6Pu
 Oyow==
X-Gm-Message-State: AOAM530ldS7JL7R4Hm6ekQ698lDIQBO6CHXTpxYPyoXqIKW+2Qn1o+7c
 nZwiS6bI9ZdERP47qbwB27mGxQ==
X-Google-Smtp-Source: ABdhPJzLJBnwcPaBtEw6VCmlLIOgqY/pJrxby5kBrBBtbBNr2VGXxQBgSbsEw14Z2kEr0zlwr/+sfg==
X-Received: by 2002:ac8:5e49:0:b0:304:c7db:6a2f with SMTP id
 i9-20020ac85e49000000b00304c7db6a2fmr4316676qtx.274.1654187460731; 
 Thu, 02 Jun 2022 09:31:00 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.113.129]) by smtp.gmail.com with ESMTPSA id
 ci11-20020a05622a260b00b00304bc2acc25sm3261689qtb.6.2022.06.02.09.30.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jun 2022 09:30:59 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1nwnit-00GTLv-7Y; Thu, 02 Jun 2022 13:30:59 -0300
Date: Thu, 2 Jun 2022 13:30:59 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH v6 20/21] PCI/P2PDMA: Introduce pci_mmap_p2pmem()
Message-ID: <20220602163059.GL2960187@ziepe.ca>
References: <20220407154717.7695-1-logang@deltatee.com>
 <20220407154717.7695-21-logang@deltatee.com>
 <20220527125501.GD2960187@ziepe.ca>
 <a2590e27-41e8-59dc-3576-b5b8d716a198@deltatee.com>
 <20220527190307.GG2960187@ziepe.ca>
 <d336cfe8-2451-04c3-a2ce-0e8e47afd1e3@deltatee.com>
 <20220602000038.GK2960187@ziepe.ca>
 <400baba7-1cd6-09d4-4de9-2a73f08afc79@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <400baba7-1cd6-09d4-4de9-2a73f08afc79@deltatee.com>
Cc: linux-pci@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
 linux-nvme@lists.infradead.org, Stephen Bates <sbates@raithlin.com>,
 linux-mm@kvack.org, Jason Ekstrand <jason@jlekstrand.net>,
 Ira Weiny <ira.weiny@intel.com>, Christoph Hellwig <hch@lst.de>,
 Minturn Dave B <dave.b.minturn@intel.com>,
 Martin Oliveira <martin.oliveira@eideticom.com>,
 Matthew Wilcox <willy@infradead.org>,
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Daniel Vetter <daniel.vetter@ffwll.ch>,
 Ralph Campbell <rcampbell@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
 linux-block@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
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

On Thu, Jun 02, 2022 at 10:16:10AM -0600, Logan Gunthorpe wrote:

> > Just stuff the pages into the mmap, and your driver unprobe will
> > automatically block until all the mmaps are closed - no different than
> > having an open file descriptor or something.
> 
> Oh is that what we want?

Yes, it is the typical case - eg if you have a sysfs file open unbind
hangs indefinitely. Many drivers can't unbind while they have open file
descriptors/etc.

A couple drivers go out of their way to allow unbinding while a live
userspace exists but this can get complicated. Usually there should be
a good reason.

The module will already be refcounted anyhow because the mmap points
to a char file which holds a module reference - meaning a simple rmmod
of the driver shouldn't work already..

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
