Return-Path: <SRS0=Y/Kh=OV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 083E8C433EF
	for <iommu@archiver.kernel.org>; Fri,  1 Oct 2021 20:13:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E142619EC
	for <iommu@archiver.kernel.org>; Fri,  1 Oct 2021 20:13:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9E142619EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 642A3407A0;
	Fri,  1 Oct 2021 20:13:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Q-h5ic7lzNU0; Fri,  1 Oct 2021 20:13:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id BAA44400E6;
	Fri,  1 Oct 2021 20:13:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8E299C0011;
	Fri,  1 Oct 2021 20:13:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3F15DC000D
 for <iommu@lists.linux-foundation.org>; Fri,  1 Oct 2021 20:13:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 27CC8844BB
 for <iommu@lists.linux-foundation.org>; Fri,  1 Oct 2021 20:13:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=deltatee.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5zuG4LxNtEQM for <iommu@lists.linux-foundation.org>;
 Fri,  1 Oct 2021 20:13:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1DCB384461
 for <iommu@lists.linux-foundation.org>; Fri,  1 Oct 2021 20:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:content-disposition;
 bh=MT0f0inatgvWHt9y6q41qCoiZgUB0hemG4eYA9iG0ZI=; b=gqh8dihCcDiD7/l4vhuUnLDPle
 9EFzkzLPUy1dTkJIIS1JcbckiRfeXzJ3oPIWHHWu13MU5vZZTHs9K3VGis/f5lP/HAvCEkb2bDCoN
 TVp36+euwLuf/+pQqIkLxjeOadBmDXsgBbgQIXRtYh3SCtOVuof43ew53y5WYQK1MoKHHMWFWrxpj
 YV8lkp6q6VCo8sHUFpLphXcyAeg2LlwFDBTBjy2/jUe8+CL2T7gCQhwH9jY3nmRmA9+owtn82wpNH
 GNBBBIIzV1eUB0QsANCVQCY6M7rzdY6M85FAsLTdYcDm8qwoj53La4rnmlpfbJDQo7Qm8m25f65pS
 GXXa4xSA==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200]
 helo=[192.168.0.10])
 by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <logang@deltatee.com>)
 id 1mWOuH-000696-1t; Fri, 01 Oct 2021 14:13:22 -0600
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20210916234100.122368-20-logang@deltatee.com>
 <20210928195518.GV3544071@ziepe.ca>
 <8d386273-c721-c919-9749-fc0a7dc1ed8b@deltatee.com>
 <20210929230543.GB3544071@ziepe.ca>
 <32ce26d7-86e9-f8d5-f0cf-40497946efe9@deltatee.com>
 <20210929233540.GF3544071@ziepe.ca>
 <f9a83402-3d66-7437-ca47-77bac4108424@deltatee.com>
 <20210930003652.GH3544071@ziepe.ca> <20211001134856.GN3544071@ziepe.ca>
 <4fdd337b-fa35-a909-5eee-823bfd1e9dc4@deltatee.com>
 <20211001174511.GQ3544071@ziepe.ca>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <95ada0ac-08cc-5b77-8675-b955b1b6d488@deltatee.com>
Date: Fri, 1 Oct 2021 14:13:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211001174511.GQ3544071@ziepe.ca>
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



On 2021-10-01 11:45 a.m., Jason Gunthorpe wrote:
>> Before the invalidation, an active flag is cleared to ensure no new
>> mappings can be created while the unmap is proceeding.
>> unmap_mapping_range() should sequence itself with the TLB flush and
> 
> AFIAK unmap_mapping_range() kicks off the TLB flush and then
> returns. It doesn't always wait for the flush to fully finish. Ie some
> cases use RCU to lock the page table against GUP fast and so the
> put_page() doesn't happen until the call_rcu completes - after a grace
> period. The unmap_mapping_range() does not wait for grace periods.

Admittedly, the tlb flush code isn't the easiest code to understand.
But, yes it seems at least on some arches the pages are freed by
call_rcu(). But can't this be fixed easily by adding a synchronize_rcu()
call after calling unmap_mapping_range()? Certainly after a
synchronize_rcu(), the TLB has been flushed and it is safe to free those
pages.

>> P2PDMA follows this pattern, except pages are not mapped linearly and
>> are returned to the genalloc when their refcount falls to 1. This only
>> happens after a VMA is closed which should imply the PTEs have already
>> been unlinked from the pages. 
> 
> And here is the problem, since the genalloc is being used we now care
> that a page should not continue to be accessed by userspace after it
> has be placed back into the genalloc. I suppose fsdax has the same
> basic issue too.

Ok, similar question. Then if we call synchronize_rcu() in vm_close(),
before the put_page() calls which return the pages to the genalloc,
would that not guarantee the TLBs have been appropriately flushed?


>> Not to say that all this couldn't use a big conceptual cleanup. A
>> similar question exists with the single find_special_page() user
>> (xen/gntdev) and it's definitely not clear what the differences are
>> between the find_special_page() and vmf_insert_mixed() techniques and
>> when one should be used over the other. Or could they both be merged to
>> use the same technique?
> 
> Oh that gntdev stuff is just nonsense. IIRC is trying to delegate
> control over a PTE entry itself to the hypervisor.
> 
> 		/*
> 		 * gntdev takes the address of the PTE in find_grant_ptes() and
> 		 * passes it to the hypervisor in gntdev_map_grant_pages(). The
> 		 * purpose of the notifier is to prevent the hypervisor pointer
> 		 * to the PTE from going stale.
> 		 *
> 		 * Since this vma's mappings can't be touched without the
> 		 * mmap_lock, and we are holding it now, there is no need for
> 		 * the notifier_range locking pattern.
> 
> I vaugely recall it stuffs in a normal page then has the hypervisor
> overwrite the PTE. When it comes time to free the PTE it recovers the
> normal page via the 'find_special_page' hack and frees it. Somehow the
> hypervisor is also using the normal page for something.
> 
> It is all very strange and one shouldn't think about it :|

Found this from an old commit message which seems to be a better
explanation, though I still don't fully understand it:

   In a Xen PV guest, the PTEs contain MFNs so get_user_pages() (for
   example) must do an MFN to PFN (M2P) lookup before it can get the
   page.  For foreign pages (those owned by another guest) the M2P
   lookup returns the PFN as seen by the foreign guest (which would be
   completely the wrong page for the local guest).

   This cannot be fixed up improving the M2P lookup since one MFN may be
   mapped onto two or more pages so getting the right page is impossible
   given just the MFN.

Yes, all very strange.

Logan
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
