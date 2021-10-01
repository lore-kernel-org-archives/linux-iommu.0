Return-Path: <SRS0=Y/Kh=OV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDDDEC433FE
	for <iommu@archiver.kernel.org>; Fri,  1 Oct 2021 17:02:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57E0161AD0
	for <iommu@archiver.kernel.org>; Fri,  1 Oct 2021 17:02:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 57E0161AD0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 213D84160C;
	Fri,  1 Oct 2021 17:02:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PHUNDOxFJxbT; Fri,  1 Oct 2021 17:02:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C4A984053F;
	Fri,  1 Oct 2021 17:02:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9BD37C0011;
	Fri,  1 Oct 2021 17:02:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AA188C000D
 for <iommu@lists.linux-foundation.org>; Fri,  1 Oct 2021 17:02:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 970FF844B4
 for <iommu@lists.linux-foundation.org>; Fri,  1 Oct 2021 17:02:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=deltatee.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oY34obd54O6d for <iommu@lists.linux-foundation.org>;
 Fri,  1 Oct 2021 17:02:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1178A844AF
 for <iommu@lists.linux-foundation.org>; Fri,  1 Oct 2021 17:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:content-disposition;
 bh=bYDtmI7g7itWVy9sZ7LZkZ5dph2F7VuLw3CuGucti2U=; b=s+nPOYtyQCnFiiolUwnh/1xJPy
 jCHFyQWGtLHmjRe53BoYJrs5hmHckB4NFM/qIqfZZZO5lTiS7WvK2SdMyNLJFlg/bu1oE74AOhejB
 d8wOCUasBDys2glJalldfVv6TUiPSaUxZQRWbLKjUapjMR9RAWlxkjwxG02a9pFpI4Gm2d9rkTZvo
 MUIcjHvQyuIvcitOyZoy7CF5UB1SgjTDqFkjiJJQCp52iC4QOlz1FBbMJh3IJ15gS9P3+8jQvA8Pp
 ZwM053wanqfZc2CKQodO+KbEyKtRkTlqcOjGOp7F5HI4U+2r/Iy2q0dU7FPTXU8n5UDQG6zzytd/7
 FnJI3MUg==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200]
 helo=[192.168.0.10])
 by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <logang@deltatee.com>)
 id 1mWLv1-0002AH-Aj; Fri, 01 Oct 2021 11:01:56 -0600
To: Jason Gunthorpe <jgg@ziepe.ca>, Alistair Popple <apopple@nvidia.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Christoph Hellwig <hch@lst.de>,
 Dan Williams <dan.j.williams@intel.com>
References: <20210916234100.122368-1-logang@deltatee.com>
 <20210916234100.122368-20-logang@deltatee.com>
 <20210928195518.GV3544071@ziepe.ca>
 <8d386273-c721-c919-9749-fc0a7dc1ed8b@deltatee.com>
 <20210929230543.GB3544071@ziepe.ca>
 <32ce26d7-86e9-f8d5-f0cf-40497946efe9@deltatee.com>
 <20210929233540.GF3544071@ziepe.ca>
 <f9a83402-3d66-7437-ca47-77bac4108424@deltatee.com>
 <20210930003652.GH3544071@ziepe.ca> <20211001134856.GN3544071@ziepe.ca>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <4fdd337b-fa35-a909-5eee-823bfd1e9dc4@deltatee.com>
Date: Fri, 1 Oct 2021 11:01:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211001134856.GN3544071@ziepe.ca>
Content-Language: en-CA
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: ckulkarnilinux@gmail.com, martin.oliveira@eideticom.com,
 robin.murphy@arm.com, ira.weiny@intel.com, helgaas@kernel.org,
 jianxin.xiong@intel.com, dave.hansen@linux.intel.com, jason@jlekstrand.net,
 dave.b.minturn@intel.com, andrzej.jakowski@intel.com, daniel.vetter@ffwll.ch,
 willy@infradead.org, ddutile@redhat.com, jhubbard@nvidia.com,
 christian.koenig@amd.com, sbates@raithlin.com,
 iommu@lists.linux-foundation.org, linux-mm@kvack.org,
 linux-pci@vger.kernel.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 dan.j.williams@intel.com, hch@lst.de, Felix.Kuehling@amd.com,
 apopple@nvidia.com, jgg@ziepe.ca
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v3 19/20] PCI/P2PDMA: introduce pci_mmap_p2pmem()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
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
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
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




On 2021-10-01 7:48 a.m., Jason Gunthorpe wrote:
> On Wed, Sep 29, 2021 at 09:36:52PM -0300, Jason Gunthorpe wrote:
> 
>> Why would DAX want to do this in the first place?? This means the
>> address space zap is much more important that just speeding up
>> destruction, it is essential for correctness since the PTEs are not
>> holding refcounts naturally...
> 
> It is not really for this series to fix, but I think the whole thing
> is probably racy once you start allowing pte_special pages to be
> accessed by GUP.
> 
> If we look at unmapping the PTE relative to GUP fast the important
> sequence is how the TLB flushing doesn't decrement the page refcount
> until after it knows any concurrent GUP fast is completed. This is
> arch specific, eg it could be done async through a call_rcu handler.
> 
> This ensures that pages can't cross back into the free pool and be
> reallocated until we know for certain that nobody is walking the PTEs
> and could potentially take an additional reference on it. The scheme
> cannot rely on the page refcount being 0 because oce it goes into the
> free pool it could be immeidately reallocated back to a non-zero
> refcount.
> 
> A DAX user that simply does an address space invalidation doesn't
> sequence itself with any of this mechanism. So we can race with a
> thread doing GUP fast and another thread re-cycling the page into
> another use - creating a leakage of the page from one security context
> to another.
> 
> This seems to be made worse for the pgmap stuff due to the wonky
> refcount usage - at least if the refcount had dropped to zero gup fast
> would be blocked for a time, but even that doesn't happen.
> 
> In short, I think using pg special for anything that can be returned
> by gup fast (and maybe even gup!) is racy/wrong. We must have the
> normal refcount mechanism work for correctness of the recycling flow.

I'm not quite following all of this. I'm not entirely sure how fs/dax
works in this regard, but for device-dax (and similarly p2pdma) it
doesn't seem as bad as you say.

In device-dax, the refcount is only used to prevent the device, and
therefore the pages, from going away on device unbind. Pages cannot be
recycled, as you say, as they are mapped linearly within the device. The
address space invalidation is done only when the device is unbound.
Before the invalidation, an active flag is cleared to ensure no new
mappings can be created while the unmap is proceeding.
unmap_mapping_range() should sequence itself with the TLB flush and
GUP-fast using the same mechanism it does for regular pages. As far as I
can see, by the time unmap_mapping_range() returns, we should be
confident that there are no pages left in any mapping (seeing no new
pages could be added since before the call). Then before finishing the
unbind, device-dax decrements the refcount of all pages and then waits
for the refcount of all pages to go to zero. Thus, any pages that
successfully were got with GUP, during or before unmap_mapping_range
should hold a reference and once all those references are returned,
unbind can finish.

P2PDMA follows this pattern, except pages are not mapped linearly and
are returned to the genalloc when their refcount falls to 1. This only
happens after a VMA is closed which should imply the PTEs have already
been unlinked from the pages. And the same situation occurs on unbind
with a flag preventing new mappings from being created before
unmap_mapping_range(), etc.

Not to say that all this couldn't use a big conceptual cleanup. A
similar question exists with the single find_special_page() user
(xen/gntdev) and it's definitely not clear what the differences are
between the find_special_page() and vmf_insert_mixed() techniques and
when one should be used over the other. Or could they both be merged to
use the same technique?

Logan
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
