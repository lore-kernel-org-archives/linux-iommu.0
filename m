Return-Path: <SRS0=Y/Kh=OV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F2E0C433F5
	for <iommu@archiver.kernel.org>; Fri,  1 Oct 2021 13:49:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A00B7615A4
	for <iommu@archiver.kernel.org>; Fri,  1 Oct 2021 13:49:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A00B7615A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7275741965;
	Fri,  1 Oct 2021 13:49:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cwODdFsX998R; Fri,  1 Oct 2021 13:49:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3B61241831;
	Fri,  1 Oct 2021 13:49:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1F65BC000F;
	Fri,  1 Oct 2021 13:49:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D5DCAC000D
 for <iommu@lists.linux-foundation.org>; Fri,  1 Oct 2021 13:49:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C2CCD614D8
 for <iommu@lists.linux-foundation.org>; Fri,  1 Oct 2021 13:49:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=ziepe.ca
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id M1wlNOybHOgX for <iommu@lists.linux-foundation.org>;
 Fri,  1 Oct 2021 13:48:59 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 88A0E614D1
 for <iommu@lists.linux-foundation.org>; Fri,  1 Oct 2021 13:48:59 +0000 (UTC)
Received: by mail-qk1-x72e.google.com with SMTP id b65so9104794qkc.13
 for <iommu@lists.linux-foundation.org>; Fri, 01 Oct 2021 06:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=LG5nuVM12UKCUvMUz/H7oZ+JnPtb7xeOrg+cdikjdUw=;
 b=i2nZSJalGl2HFR2lljteQga9LLzznj1VY4sKfMFrOuI5TPw+9fxa9Y7VF6ORCDu6gf
 s1VZcbmu8prmAySSW0muDV9sPFy+ocsOAHMu7czDjdTka8/r9gDirvuLv+DjNcMP+yu2
 2vpgG0jpIzFJO3o2EESr3Knc9sAVcu/3zrGpfyryk0rXsa3CM7UVEgJZI2lyiRkkfNpM
 06X0/la9ZF1/JOw1nIH1hT6QVKTk7TJuv33hiHw5ih9p7MWcfmzNHEd0oxDuij3diKPb
 ruwnbMTM1vlfPcAVocSCOhTaVtV1FJ3tIhW47hPjbC6RUYlSTDx8/p4BvGKL4lQu/579
 YBXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=LG5nuVM12UKCUvMUz/H7oZ+JnPtb7xeOrg+cdikjdUw=;
 b=gVKWlc92oKXsSlvGF7WwSJ8nS9+B4wXeUJImLbPD6eSRLXcliMtGeJ64GqbttKAkHv
 V0cnrVp0YsJo26VKU+AJ2HtE/HvR3fhD2KanwA6z0uPXoinE962fXMXfKOHNgc8plGIm
 2MmoadEEXhagZXlz3LDVI9yGnwdiCO01MJRpw29MHho9fWx/C/WX61/4gpACXw+PfsWq
 AlY+z4Ctf1jvo75ctzn4h3TfDOn1jT5ssdsmcOBy8UWCGw29OucHifdpFQorYyBJIzXM
 c5fLVzf2L9KO6ecFWpjt4+YjyrDxO6IUqpBOSs4Nvhs+T3/mbkwM6V48DYmKxXtYlOnQ
 gqAg==
X-Gm-Message-State: AOAM531NZNHpOnC+7VulcWnQm6oDksL43MpVT63qxJMixSi+EMKzU3Ck
 G7KrTLyvE5voU/SRBSrjxvoNFg==
X-Google-Smtp-Source: ABdhPJxAWiRAix1MOnP+fusB3RWFs4aefuUjIqiau0+pjC7MwPUEHTq7EjNfCISJpSPUQC5qQMYTaw==
X-Received: by 2002:a37:65d6:: with SMTP id z205mr9907719qkb.522.1633096138367; 
 Fri, 01 Oct 2021 06:48:58 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.113.129])
 by smtp.gmail.com with ESMTPSA id u19sm3747206qtx.40.2021.10.01.06.48.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Oct 2021 06:48:57 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1mWIuG-008R2P-Oj; Fri, 01 Oct 2021 10:48:56 -0300
Date: Fri, 1 Oct 2021 10:48:56 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Logan Gunthorpe <logang@deltatee.com>,
 Alistair Popple <apopple@nvidia.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Christoph Hellwig <hch@lst.de>,
 Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v3 19/20] PCI/P2PDMA: introduce pci_mmap_p2pmem()
Message-ID: <20211001134856.GN3544071@ziepe.ca>
References: <20210916234100.122368-1-logang@deltatee.com>
 <20210916234100.122368-20-logang@deltatee.com>
 <20210928195518.GV3544071@ziepe.ca>
 <8d386273-c721-c919-9749-fc0a7dc1ed8b@deltatee.com>
 <20210929230543.GB3544071@ziepe.ca>
 <32ce26d7-86e9-f8d5-f0cf-40497946efe9@deltatee.com>
 <20210929233540.GF3544071@ziepe.ca>
 <f9a83402-3d66-7437-ca47-77bac4108424@deltatee.com>
 <20210930003652.GH3544071@ziepe.ca>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210930003652.GH3544071@ziepe.ca>
Cc: linux-pci@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
 linux-nvme@lists.infradead.org, Stephen Bates <sbates@raithlin.com>,
 linux-mm@kvack.org, Jason Ekstrand <jason@jlekstrand.net>,
 Ira Weiny <ira.weiny@intel.com>, Minturn Dave B <dave.b.minturn@intel.com>,
 Martin Oliveira <martin.oliveira@eideticom.com>,
 Matthew Wilcox <willy@infradead.org>,
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Daniel Vetter <daniel.vetter@ffwll.ch>,
 John Hubbard <jhubbard@nvidia.com>, linux-block@vger.kernel.org,
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

On Wed, Sep 29, 2021 at 09:36:52PM -0300, Jason Gunthorpe wrote:

> Why would DAX want to do this in the first place?? This means the
> address space zap is much more important that just speeding up
> destruction, it is essential for correctness since the PTEs are not
> holding refcounts naturally...

It is not really for this series to fix, but I think the whole thing
is probably racy once you start allowing pte_special pages to be
accessed by GUP.

If we look at unmapping the PTE relative to GUP fast the important
sequence is how the TLB flushing doesn't decrement the page refcount
until after it knows any concurrent GUP fast is completed. This is
arch specific, eg it could be done async through a call_rcu handler.

This ensures that pages can't cross back into the free pool and be
reallocated until we know for certain that nobody is walking the PTEs
and could potentially take an additional reference on it. The scheme
cannot rely on the page refcount being 0 because oce it goes into the
free pool it could be immeidately reallocated back to a non-zero
refcount.

A DAX user that simply does an address space invalidation doesn't
sequence itself with any of this mechanism. So we can race with a
thread doing GUP fast and another thread re-cycling the page into
another use - creating a leakage of the page from one security context
to another.

This seems to be made worse for the pgmap stuff due to the wonky
refcount usage - at least if the refcount had dropped to zero gup fast
would be blocked for a time, but even that doesn't happen.

In short, I think using pg special for anything that can be returned
by gup fast (and maybe even gup!) is racy/wrong. We must have the
normal refcount mechanism work for correctness of the recycling flow.

I don't know why DAX did this, I think we should be talking about
udoing it all of it, not just the wonky refcounting Alistair and Felix
are working on, but also the use of MIXEDMAP and pte special for
struct page backed memory.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
