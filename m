Return-Path: <SRS0=Xpq5=OT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79914C4332F
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 23:49:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 321916152A
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 23:49:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 321916152A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id EEA104013C;
	Wed, 29 Sep 2021 23:49:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zEcTJrQxlefs; Wed, 29 Sep 2021 23:49:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3FDE140001;
	Wed, 29 Sep 2021 23:49:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 02E82C0011;
	Wed, 29 Sep 2021 23:49:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 315DFC000D
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 23:49:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0C30C40724
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 23:49:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=deltatee.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tKD60HrRmlZV for <iommu@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 23:49:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 684F340720
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 23:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:content-disposition;
 bh=CF1glsl0sDpUoLLLlbcLe5Gc4XdktP0X8AUw9yuV+0g=; b=rvxtjSxpHJKvRAjCfIxwxyzLCo
 dRJ/VOphU+DYr/cLIiwms1Pg/YVQDCtjAHmMCtg4knvS9jKPhUP3W9zeT0sdqnnr19BzDAVDwHcJL
 62apJcXTTKU8FDisFW4B9PimKftGde3SQ3trXz6cjnJ/Evi3tlcLZEqDfaxS6gD5YvgZuTfG7y4pX
 oR1EByfJZsQ+MR2/beWAzNsR3w97B0sy/qeoE6eY3ixGA2UuZc4eGCIy14pEdxW+aVGSSXG81FppK
 Xrz2ZHFGtdpweiT0vhas7k+vEPmBvbSrqdraw89wTlivVK/1sYC95Wf2aWqcT52GNBphDrX7tSAFc
 Jo1/zcsg==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200]
 helo=[192.168.0.10])
 by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <logang@deltatee.com>)
 id 1mVjKW-0008TE-PC; Wed, 29 Sep 2021 17:49:41 -0600
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20210916234100.122368-1-logang@deltatee.com>
 <20210916234100.122368-20-logang@deltatee.com>
 <20210928195518.GV3544071@ziepe.ca>
 <8d386273-c721-c919-9749-fc0a7dc1ed8b@deltatee.com>
 <20210929230543.GB3544071@ziepe.ca>
 <32ce26d7-86e9-f8d5-f0cf-40497946efe9@deltatee.com>
 <20210929233540.GF3544071@ziepe.ca>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <f9a83402-3d66-7437-ca47-77bac4108424@deltatee.com>
Date: Wed, 29 Sep 2021 17:49:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210929233540.GF3544071@ziepe.ca>
Content-Language: en-CA
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: ckulkarnilinux@gmail.com, martin.oliveira@eideticom.com,
 robin.murphy@arm.com, ira.weiny@intel.com, helgaas@kernel.org,
 jianxin.xiong@intel.com, dave.hansen@linux.intel.com, jason@jlekstrand.net,
 dave.b.minturn@intel.com, andrzej.jakowski@intel.com, daniel.vetter@ffwll.ch,
 willy@infradead.org, ddutile@redhat.com, jhubbard@nvidia.com,
 christian.koenig@amd.com, dan.j.williams@intel.com, hch@lst.de,
 sbates@raithlin.com, iommu@lists.linux-foundation.org, linux-mm@kvack.org,
 linux-pci@vger.kernel.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, jgg@ziepe.ca
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v3 19/20] PCI/P2PDMA: introduce pci_mmap_p2pmem()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
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



On 2021-09-29 5:35 p.m., Jason Gunthorpe wrote:
> On Wed, Sep 29, 2021 at 05:27:22PM -0600, Logan Gunthorpe wrote:
> 
>>> finish_fault() should set the pte_devmap - eg by passing the
>>> PFN_DEV|PFN_MAP somehow through the vma->vm_page_prot to mk_pte() or
>>> otherwise signaling do_set_pte() that it should set those PTE bits
>>> when it creates the entry.
>>>
>>> (or there should be a vmf_* helper for this special case, but using
>>> the vmf->page seems righter to me)
>>
>> I'm not opposed to this. Though I'm not sure what's best here.
>>
>>>> If we don't set pte_devmap(), then every single page that GUP
>>>> processes needs to check if it's a ZONE_DEVICE page and also if it's
>>>> a P2PDMA page (thus dereferencing pgmap) in order to satisfy the
>>>> requirements of FOLL_PCI_P2PDMA.
>>>
>>> Definately not suggesting not to set pte_devmap(), only that
>>> VM_MIXEDMAP should not be set on VMAs that only contain struct
>>> pages. That is an abuse of what it is intended for.
>>>
>>> At the very least there should be a big comment above the usage
>>> explaining that this is just working around a limitation in
>>> finish_fault() where it cannot set the PFN_DEV|PFN_MAP bits today.
>>
>> Is it? Documentation on vmf_insert_mixed() and VM_MIXEDMAP is not good
>> and the intention is not clear. I got the impression that mm people
>> wanted those interfaces used for users of pte_devmap().
> 
> I thought VM_MIXEDMAP was quite clear:
> 
> #define VM_MIXEDMAP	0x10000000	/* Can contain "struct page" and pure PFN pages */
> 
> This VMA does not include PFN pages, so it should not be tagged
> VM_MIXEDMAP.
> 
> Aside from enabling the special vmf_ API, it only controls some
> special behavior in vm_normal_page:
> 
>  * VM_MIXEDMAP mappings can likewise contain memory with or without "struct
>  * page" backing, however the difference is that _all_ pages with a struct
>  * page (that is, those where pfn_valid is true) are refcounted and considered
>  * normal pages by the VM. The disadvantage is that pages are refcounted
>  * (which can be slower and simply not an option for some PFNMAP users). The
>  * advantage is that we don't have to follow the strict linearity rule of
>  * PFNMAP mappings in order to support COWable mappings.
> 
> Which again does not describe this case.

Some of this seems out of date. Pretty sure the pages are not refcounted
with vmf_insert_mixed() and vmf_insert_mixed() is currently the only way
to use VM_MIXEDMAP mappings.

>> device-dax uses these interfaces and as far as I can see it also only
>> contains struct pages (or at least  dev_dax_huge_fault() calls
>> pfn_to_page() on every page when VM_FAULT_NOPAGE happens).
> 
> hacky hacky :)
> 
> I think DAX probably did it that way for the same reason you are
> doing it that way - no other choice without changing something

Sure but if you look at other vmf_insert_mixed() (of which there are
few) you see similar patterns. Seems more like it was documented with
one thing in mind but then used in a completely different manner. Which
is why I suggested the documentation was not so good.

Logan
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
