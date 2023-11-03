Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4FB1CF91
	for <iommu@lists.linux.dev>; Fri,  3 Nov 2023 20:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="OKDh8aDX"
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 89C841953CF;
	Fri,  3 Nov 2023 21:50:54 +0100 (CET)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
	t=1699044654; bh=ovF2UxeFKGVoKgOj3oQMqaLMJ/vL6MISuASAGJ+7cOo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OKDh8aDXW5UlBWkhlrSF+eWWUCy4nesCqv1sSWA8SKz3LtzRyonOKo29z948jxFn8
	 IP0OAsvNwuKaro8+qHqn3sTG3glqpExjeHguIxFqapE/hWSGLaPHOThV5ofhLMM0N4
	 ZD4zVycNv0+4kwjtBNZmagUDOJJHW23CCP+axUGAz5o8UxXHXTcCyuukm0Fz51SMtI
	 pvyIjLrJn+VAqScqSvK6YCeZIkP0+YStxsNx/lanF4fG2gGB7t+0IAFt3pXSJU86+v
	 db4SKPxpo1B9rsrQpHgQMeMk08n9RVtjGPdgHGlERFIC+X5JS4KT1fq0w0xs1so5K3
	 mFANpzOhAXKtw==
Date: Fri, 3 Nov 2023 21:50:53 +0100
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>, Christoph Hellwig
 <hch@lst.de>, Bjorn Helgaas <bhelgaas@google.com>, Marek Szyprowski
 <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Petr
 Tesarik <petr.tesarik1@huawei-partners.com>, Ross Lagerwall
 <ross.lagerwall@citrix.com>, linux-pci <linux-pci@vger.kernel.org>,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, Matthew Rosato
 <mjrosato@linux.ibm.com>
Subject: Re: Memory corruption with CONFIG_SWIOTLB_DYNAMIC=y
Message-ID: <20231103214831.26d29f4d@meshulam.tesarici.cz>
In-Reply-To: <20231103171447.02759771.pasic@linux.ibm.com>
References: <104a8c8fedffd1ff8a2890983e2ec1c26bff6810.camel@linux.ibm.com>
	<20231103171447.02759771.pasic@linux.ibm.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 3 Nov 2023 17:14:47 +0100
Halil Pasic <pasic@linux.ibm.com> wrote:

>[...]
> In our case min_align_mask == 0 and a) is thus not applicable, because b) and
> c) we end up with iotlb_align_mask = 0x800. And because orig_add & 0x800 ==
> 0x800 but pool->start & 0x800 == 0 and the slot at index i is skipped over. The
> slot 0 is skipped over because it is page aligned, when !!((1UL << PAGE_SHIFT)
> & orig_addr) 

Wait. These mask values can quickly become confusing. Do you mean
iotlb_align_mask == 0xfff?

> Let us note that with the current implementation the min_align_size mask, that
> is mechanism a) also controls the tlb_addr within the first slot so that:
> tlb_addr & min_align_mask == orig_addr & min_align_mask. In that sense a) is
> very unlike b) and c).

It is silently assumed that PAGE_SIZE >= IO_TLB_SIZE, so if the buffer
is page-aligned, the lower bits of the alignment inside the io tlb slot
must be zero.

If the same assumption is made about alloc_align_mask, it should be
documented, but it is not.

>[...]
> In our opinion the first step towards getting this right is to figure out what
> the different kinds of alignments are really supposed to mean. For each of the
> mechanisms we need to understand and document, whether making sure that the
> bounce buffer does not stretch over more of certain units of memory (like,
> pages, iova granule size, whatever), or is it about preserving offset within a
> certain unit of memory, and if yes to what extent (the least significant n-bits
> of the orig_addr dictated by the respective mask, or something different).


Seconded. I have also been struggling with the various alignment
constraints. I have even written (but not yet submitted) a patch to
calculate the combined alignment mask in swiotlb_tbl_map_single() and
pass it down to all other functions, just to make it clear what
alignment mask is used.

My understanding is that buffer alignment may be required by:

1. hardware which cannot handle an unaligned base address (presumably
   because the chip performs a simple OR operation to get the addresses
   of individual fields);

2. isolation of untrusted devices, where no two bounce buffers should
   end up in the same iova granule;

3. allocation size; I could not find an explanation, so this might be
   merely an attempt at reducing SWIOTLB internal fragmentation.

I hope other people on the Cc list can shed more light on the intended
behaviour.

Petr T
