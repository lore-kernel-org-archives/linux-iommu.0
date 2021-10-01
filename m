Return-Path: <SRS0=Y/Kh=OV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37441C433F5
	for <iommu@archiver.kernel.org>; Fri,  1 Oct 2021 17:45:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2F2661A8E
	for <iommu@archiver.kernel.org>; Fri,  1 Oct 2021 17:45:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E2F2661A8E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id AA30F40111;
	Fri,  1 Oct 2021 17:45:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IbbBOBn08Z8b; Fri,  1 Oct 2021 17:45:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3A120401F3;
	Fri,  1 Oct 2021 17:45:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0CB1BC000F;
	Fri,  1 Oct 2021 17:45:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 27152C000D
 for <iommu@lists.linux-foundation.org>; Fri,  1 Oct 2021 17:45:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 08ED04074D
 for <iommu@lists.linux-foundation.org>; Fri,  1 Oct 2021 17:45:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=ziepe.ca
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pHtO1ZnfD8t4 for <iommu@lists.linux-foundation.org>;
 Fri,  1 Oct 2021 17:45:14 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 36708406CE
 for <iommu@lists.linux-foundation.org>; Fri,  1 Oct 2021 17:45:14 +0000 (UTC)
Received: by mail-qk1-x731.google.com with SMTP id q81so9953679qke.5
 for <iommu@lists.linux-foundation.org>; Fri, 01 Oct 2021 10:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=CY+QWSave8EGEaNVpceAJQ+ky5w1DWCyy9j7COQnHFM=;
 b=askYTJzym7O5yaOqpeMzKwOj0j6Qwo04kEM179/a3sFhqrYyXzPAu1ifpOhcFl9q0Y
 F/PLEDnH9R02hCpQbyV2Dzb5iXF38C6sxpIDCyRjVSLdg9m4x9mzmxGfikoOrIb4KO5g
 KK7/5+UqT19eZNeA5mH/CtKtbeSKvPvg7bkvpD2k5W8s0SA56gdmbn7g92dyRjv6qzWm
 NApTHpAV13PnJqbcQXh1/icou6aS6s4O8Q5naDdwg2J2VccmTim8IhxnqvDSONGlD1i/
 3CEpYbeXydKMWMWPJCbhj1ViExG40KWNfqcSecJq4GbUKkEnpgalIV0poHVYP2TUwniL
 UMFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=CY+QWSave8EGEaNVpceAJQ+ky5w1DWCyy9j7COQnHFM=;
 b=2wdpcnCjfsboKRifAjm9jozbpuT/7B1eSlpHTRr7yj4uEXXx7dqf66uUAVQ/SlhZWp
 hGjz+01ppny/KyTk7IocW+N5SuDOjvd6eiHbxyPb+Omz0AbaIx4hbj+kMMCG8SDEAbfa
 7tGIRzLstCAH4X8amvLV8YZiFEYk8ow+pfYEIRk3n4N7mIKjOjdjR0cpfqOENCTvZr1+
 dJU8prd/TwcsaIbGBVTaqri4lhKql0946hCliRx8XQQz0qevumGx+UhODFDEVRoxyuqW
 nzFwv8yuX6/CGANjdfd3rG3WumdNOQJWQNfKdeR9vnf4hDWiazORWxe1l4dlTO18PJxE
 BG0A==
X-Gm-Message-State: AOAM533pI5U8BRitkz0p5/upzaWldWRoW20ZyIoQlXBHTV5xGk1U1EgM
 QB1N7tOFjcO+NXpw/boEH7Qz2A==
X-Google-Smtp-Source: ABdhPJx/K6VNm0duCKrTeu/4uI4ViO+0lSC4pUeGkBrnh5E8R/aNPnPsk6AlICpx2DIIm1QpxAom9A==
X-Received: by 2002:a37:8747:: with SMTP id j68mr10365945qkd.165.1633110313062; 
 Fri, 01 Oct 2021 10:45:13 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.113.129])
 by smtp.gmail.com with ESMTPSA id w17sm3357837qkf.97.2021.10.01.10.45.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Oct 2021 10:45:12 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1mWMat-0097tt-HS; Fri, 01 Oct 2021 14:45:11 -0300
Date: Fri, 1 Oct 2021 14:45:11 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH v3 19/20] PCI/P2PDMA: introduce pci_mmap_p2pmem()
Message-ID: <20211001174511.GQ3544071@ziepe.ca>
References: <20210916234100.122368-20-logang@deltatee.com>
 <20210928195518.GV3544071@ziepe.ca>
 <8d386273-c721-c919-9749-fc0a7dc1ed8b@deltatee.com>
 <20210929230543.GB3544071@ziepe.ca>
 <32ce26d7-86e9-f8d5-f0cf-40497946efe9@deltatee.com>
 <20210929233540.GF3544071@ziepe.ca>
 <f9a83402-3d66-7437-ca47-77bac4108424@deltatee.com>
 <20210930003652.GH3544071@ziepe.ca>
 <20211001134856.GN3544071@ziepe.ca>
 <4fdd337b-fa35-a909-5eee-823bfd1e9dc4@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4fdd337b-fa35-a909-5eee-823bfd1e9dc4@deltatee.com>
Cc: linux-pci@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
 linux-nvme@lists.infradead.org, Stephen Bates <sbates@raithlin.com>,
 linux-mm@kvack.org, Jason Ekstrand <jason@jlekstrand.net>,
 Ira Weiny <ira.weiny@intel.com>, Christoph Hellwig <hch@lst.de>,
 Minturn Dave B <dave.b.minturn@intel.com>,
 Alistair Popple <apopple@nvidia.com>,
 Martin Oliveira <martin.oliveira@eideticom.com>,
 Matthew Wilcox <willy@infradead.org>,
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Daniel Vetter <daniel.vetter@ffwll.ch>,
 John Hubbard <jhubbard@nvidia.com>, linux-block@vger.kernel.org,
 Dan Williams <dan.j.williams@intel.com>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>, linux-kernel@vger.kernel.org,
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

On Fri, Oct 01, 2021 at 11:01:49AM -0600, Logan Gunthorpe wrote:

> In device-dax, the refcount is only used to prevent the device, and
> therefore the pages, from going away on device unbind. Pages cannot be
> recycled, as you say, as they are mapped linearly within the device. The
> address space invalidation is done only when the device is unbound.

By address space invalidation I mean invalidation of the VMA that is
pointing to those pages.

device-dax may not have a issue with use-after-VMA-invalidation by
it's very nature since every PFN always points to the same
thing. fsdax and this p2p stuff are different though.

> Before the invalidation, an active flag is cleared to ensure no new
> mappings can be created while the unmap is proceeding.
> unmap_mapping_range() should sequence itself with the TLB flush and

AFIAK unmap_mapping_range() kicks off the TLB flush and then
returns. It doesn't always wait for the flush to fully finish. Ie some
cases use RCU to lock the page table against GUP fast and so the
put_page() doesn't happen until the call_rcu completes - after a grace
period. The unmap_mapping_range() does not wait for grace periods.

This is why for normal memory the put_page is done after the TLB flush
completes, not when unmap_mapping_range() finishes. This ensures that
before the refcount reaches 0 no concurrent GUP fast can still observe
the old PTEs.

> GUP-fast using the same mechanism it does for regular pages. As far as I
> can see, by the time unmap_mapping_range() returns, we should be
> confident that there are no pages left in any mapping (seeing no new
> pages could be added since before the call). 

When viewed under the page table locks this is true, but the 'fast'
walkers like gup_fast and hmm_range_fault can continue to be working
on old data in the ptes because they don't take the page table locks.

They interact with unmap_mapping_range() via the IPI/rcu (gup fast) or
mmu notifier sequence count (hmm_range_fault)

> P2PDMA follows this pattern, except pages are not mapped linearly and
> are returned to the genalloc when their refcount falls to 1. This only
> happens after a VMA is closed which should imply the PTEs have already
> been unlinked from the pages. 

And here is the problem, since the genalloc is being used we now care
that a page should not continue to be accessed by userspace after it
has be placed back into the genalloc. I suppose fsdax has the same
basic issue too.

> Not to say that all this couldn't use a big conceptual cleanup. A
> similar question exists with the single find_special_page() user
> (xen/gntdev) and it's definitely not clear what the differences are
> between the find_special_page() and vmf_insert_mixed() techniques and
> when one should be used over the other. Or could they both be merged to
> use the same technique?

Oh that gntdev stuff is just nonsense. IIRC is trying to delegate
control over a PTE entry itself to the hypervisor.

		/*
		 * gntdev takes the address of the PTE in find_grant_ptes() and
		 * passes it to the hypervisor in gntdev_map_grant_pages(). The
		 * purpose of the notifier is to prevent the hypervisor pointer
		 * to the PTE from going stale.
		 *
		 * Since this vma's mappings can't be touched without the
		 * mmap_lock, and we are holding it now, there is no need for
		 * the notifier_range locking pattern.

I vaugely recall it stuffs in a normal page then has the hypervisor
overwrite the PTE. When it comes time to free the PTE it recovers the
normal page via the 'find_special_page' hack and frees it. Somehow the
hypervisor is also using the normal page for something.

It is all very strange and one shouldn't think about it :|

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
