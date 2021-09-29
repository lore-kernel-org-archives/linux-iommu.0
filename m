Return-Path: <SRS0=Xpq5=OT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C5D6C4332F
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 23:35:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9523617E2
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 23:35:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B9523617E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7C3A54013C;
	Wed, 29 Sep 2021 23:35:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PN27S8IZAM0x; Wed, 29 Sep 2021 23:35:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0676D400C7;
	Wed, 29 Sep 2021 23:35:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A7B3DC0011;
	Wed, 29 Sep 2021 23:35:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 718FEC000D
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 23:35:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4CC9F83BEE
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 23:35:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=ziepe.ca
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qGx2MmOX5WxD for <iommu@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 23:35:42 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9AD8D83B75
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 23:35:42 +0000 (UTC)
Received: by mail-qk1-x736.google.com with SMTP id i132so4089405qke.1
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 16:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=Wzv2Y27ogc32S6oHMWAfyL0EMJPS0sYiDo6umdEuZ90=;
 b=S4PKYlTphsjTeGSO6MfruYx4DLjFDyu6ZBDQXU7sgBQUZglbnWFts2iTn8upvshkwO
 /dxY5MJJ3K9bbBOWdcCpUDQryqEQ6B6xsCI4XTkHAaouYDnzj48xV27k94PZY12XJM5q
 EV90TNvBvPJrxWONr5qi4YLqPbT6TkJpX2ov+sLJirRsIUAvrOi36HyZfvihTjc8VRvy
 y9qkzSc3lHxRJ2joe2EKnBI4kW39e2li3GiaMVt6OA83/KD9UTxgkGPf5QdOygqePR/u
 RbANXP74mA2FQxLulY5GQdT3oKcIiqhjOBThg85Hi5BfdV/hy7RpkZ8VNDP3qSTgV52G
 3oKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Wzv2Y27ogc32S6oHMWAfyL0EMJPS0sYiDo6umdEuZ90=;
 b=sDEmojUALUvvxGHdeHCcgN10XSCRbXlMSoBGx292hK1GiMj63tqgFZtb+a2kdWJ4lh
 pCXUROTBOBtUWEEgw9wxubx6qmmXqxXavECUHNkxczCrggnvflSeGz7xMVqjZMYqLX2x
 3orPXw/BMssngeAfQ44qzDdMRDzVxrwCBBws2T8p61116xFUZ/bYtVLyqGE2NpJGfgKt
 aczxfwoHaUz0+1QfAjeNfOVIMLcSuPK/w1BSBlHznj+B73Ng/3/72HeaqRvofCjxgvl5
 6AZABNgZ3b7LOyRUA3CEXngntEH5kM7HO4ZxUUN9YUDVhDx/sN3miuTgkvtzg9GUdilH
 JI3w==
X-Gm-Message-State: AOAM533W7jjeoYDiStVe/aGPTViappAc4M09+hnM/cnOEO3gemnze2fE
 6kV/uPUfeu+aEsmyzYDrxcsxjQ==
X-Google-Smtp-Source: ABdhPJxG17Iq4sMkmS8x7eqi3cbKInix861xKtGJRezs+18cQeCiP6r35EC+3tlGMr1TedfVtU4v5g==
X-Received: by 2002:a37:afc4:: with SMTP id y187mr2254066qke.520.1632958541600; 
 Wed, 29 Sep 2021 16:35:41 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.113.129])
 by smtp.gmail.com with ESMTPSA id j184sm705904qkd.74.2021.09.29.16.35.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Sep 2021 16:35:41 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1mVj6y-007ivO-CU; Wed, 29 Sep 2021 20:35:40 -0300
Date: Wed, 29 Sep 2021 20:35:40 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH v3 19/20] PCI/P2PDMA: introduce pci_mmap_p2pmem()
Message-ID: <20210929233540.GF3544071@ziepe.ca>
References: <20210916234100.122368-1-logang@deltatee.com>
 <20210916234100.122368-20-logang@deltatee.com>
 <20210928195518.GV3544071@ziepe.ca>
 <8d386273-c721-c919-9749-fc0a7dc1ed8b@deltatee.com>
 <20210929230543.GB3544071@ziepe.ca>
 <32ce26d7-86e9-f8d5-f0cf-40497946efe9@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <32ce26d7-86e9-f8d5-f0cf-40497946efe9@deltatee.com>
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

On Wed, Sep 29, 2021 at 05:27:22PM -0600, Logan Gunthorpe wrote:

> > finish_fault() should set the pte_devmap - eg by passing the
> > PFN_DEV|PFN_MAP somehow through the vma->vm_page_prot to mk_pte() or
> > otherwise signaling do_set_pte() that it should set those PTE bits
> > when it creates the entry.
> > 
> > (or there should be a vmf_* helper for this special case, but using
> > the vmf->page seems righter to me)
> 
> I'm not opposed to this. Though I'm not sure what's best here.
> 
> >> If we don't set pte_devmap(), then every single page that GUP
> >> processes needs to check if it's a ZONE_DEVICE page and also if it's
> >> a P2PDMA page (thus dereferencing pgmap) in order to satisfy the
> >> requirements of FOLL_PCI_P2PDMA.
> > 
> > Definately not suggesting not to set pte_devmap(), only that
> > VM_MIXEDMAP should not be set on VMAs that only contain struct
> > pages. That is an abuse of what it is intended for.
> > 
> > At the very least there should be a big comment above the usage
> > explaining that this is just working around a limitation in
> > finish_fault() where it cannot set the PFN_DEV|PFN_MAP bits today.
> 
> Is it? Documentation on vmf_insert_mixed() and VM_MIXEDMAP is not good
> and the intention is not clear. I got the impression that mm people
> wanted those interfaces used for users of pte_devmap().

I thought VM_MIXEDMAP was quite clear:

#define VM_MIXEDMAP	0x10000000	/* Can contain "struct page" and pure PFN pages */

This VMA does not include PFN pages, so it should not be tagged
VM_MIXEDMAP.

Aside from enabling the special vmf_ API, it only controls some
special behavior in vm_normal_page:

 * VM_MIXEDMAP mappings can likewise contain memory with or without "struct
 * page" backing, however the difference is that _all_ pages with a struct
 * page (that is, those where pfn_valid is true) are refcounted and considered
 * normal pages by the VM. The disadvantage is that pages are refcounted
 * (which can be slower and simply not an option for some PFNMAP users). The
 * advantage is that we don't have to follow the strict linearity rule of
 * PFNMAP mappings in order to support COWable mappings.

Which again does not describe this case.

> device-dax uses these interfaces and as far as I can see it also only
> contains struct pages (or at least  dev_dax_huge_fault() calls
> pfn_to_page() on every page when VM_FAULT_NOPAGE happens).

hacky hacky :)

I think DAX probably did it that way for the same reason you are
doing it that way - no other choice without changing something

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
