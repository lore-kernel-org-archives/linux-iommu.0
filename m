Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1076B35202E
	for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 18:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783966264; cv=none; b=k+VT6HreBmjoH5wWaIzmmUv5dcqjxH7XcZyA2INbanqt0Pszi0tQ0ThyGmQFB4qTOjw1wLZYhBWQir1z5Qf32nIzU98IkK2qeHYOjnoX425Ygwb+/Xx2AiE/cZXobFMjHJ9TjPAuhIVOGy4KvNxpxdVJ6efRjal5r+NbO7wyVC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783966264; c=relaxed/simple;
	bh=YUh8//1CawO0lxzXPLb9x+Xef1uhNSh6FnuTiN+bISs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nOfq66tjXD2N22ZHCPKPFCO25jxldY2f8YgUFBm023ZM0rg64Zl/BNx71EtjQhW/TCG/1A7slrqDuGAjmutDsfipcrqtRW3T9juQYkMLXnQyNaq3jWVs8Yo7L4Ej+gsJRnkGokUs1DKMel/lKT2PwMU5ciLPYHSgmLhEfubkLv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=n6/FWQ0w; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="n6/FWQ0w"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8f29ec73064so28772846d6.1
        for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 11:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783966261; x=1784571061; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=r3LqUwIJYp9NQ4diqGbAZyVDrYnzRQFmiULYhYdIqPw=;
        b=n6/FWQ0wnierPOkvMhyNNZTldoqpZAG3Arq3OOs1866F1dmlBGONXD3k1tfLokROCG
         5AEhSN0HyBgLM64A3sw3rkllCGmvv9VUtOGkRmypbnHqg0cebaQ/H3/QyA9Z8TSWiBNg
         YPYd5dxkF6ArruBfRWMOr26/wCAUegxEXIP+CDatRIQxOptOIW6fQNeOXj7qbey5+6wk
         eea6Uk45c6p6YmMsh24uLKMVAp9ZDW7dPtCj4zl46IA6kY+e2MHDkKvt6GZgCGVAQfo1
         H5nU3Dq4fcJKup8A21bDoDcgneD4TX7WlWGHZVvQzwCug4CsgFj65hfB8KMBuwJCi4r2
         haxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783966261; x=1784571061;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r3LqUwIJYp9NQ4diqGbAZyVDrYnzRQFmiULYhYdIqPw=;
        b=CJhmDQJpCnUUJeFcxBZE7mm55biJFbqpWm/jFsnVuluDvOKWIoNTNaIzyRtaO43OUt
         ahOd2Hs8eXiFhPefFFk/PHzowP7FKlzuvF5JJnMZ4nqkAZpb8xZ30SymNXnNzRFh72AD
         T/ud1JT9+pxUrjXNKSyn6uBxnMgIQrcn6ECKcI8tt96E8ZVbvnJK+bm/MNL3sUmUeMQc
         KR7RcxZ3Y57DzdM9Bzn8gNZFG/usUFbmOmXOKYc90EzjR1AS6HpWNZ36Uuil4Q4tjs7P
         E/VXBKwN+epQgyozxRujq0zp+8q5Imo/AijsfpdMnCr56f6AitHU/m/AWl8QE7pKIVco
         62vg==
X-Gm-Message-State: AOJu0YzX7NkVFceXJjVLPNyMRs5PmKp8/nOc9fZr26G/d8u2pfH31YkO
	vQ2es+Kfoomk46Om/za1FR64f8YgtcwL1V0vA6RKAjC+cWLVASytkR1ONzQbLH1Hey0=
X-Gm-Gg: AfdE7ckTAllneTCT6ZOFy60aT/jCa3AZABLRUzjz5T34ZMX5/W7AQBRf2qu8bzeiopk
	9CR3zD1GPzyYpdLp0qmKxd4typi91ewtzRU7lKOOM66tiS/Px4YnFAgKR/qBDlShzzawgDMXWCm
	H4zN4WoqrH5aWF7fqj09/92CvsHaubTikc11YLbpCL8aeT5mNkfs2S9rlf5kocQ5CVhcps1hwe6
	AA4NONquz4AdKz3LKavNhn/RX7hgYMPhd/X3p2FXXcMseeARIObLa2+A/Z/MM3fG2eYyzVdORvE
	ob1PaUQ8zhbdG5xUajdAuDMz+vkZakb09/9T7Tr9wlOxpjmtgaal1fPiW3/MSt39RDMBJoygeyp
	PaZFgLCt/O8mrYVl4hUQ9ct/grRwGLkYUNm6V7wZdmANEr4ABuSZKd+wZBbkk
X-Received: by 2002:a05:6214:601a:b0:8f6:8677:7ea5 with SMTP id 6a1803df08f44-90402c68ee8mr99154096d6.37.1783966260999;
        Mon, 13 Jul 2026 11:11:00 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd5bbac2asm135284216d6.21.2026.07.13.11.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 11:11:00 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wjL7L-0000000DyOu-42Rk;
	Mon, 13 Jul 2026 15:10:59 -0300
Date: Mon, 13 Jul 2026 15:10:59 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org,
	Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v7 04/22] dma: free atomic pool pages by physical address
Message-ID: <20260713181059.GL3133966@ziepe.ca>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <20260701054926.825925-5-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701054926.825925-5-aneesh.kumar@kernel.org>

On Wed, Jul 01, 2026 at 11:19:08AM +0530, Aneesh Kumar K.V (Arm) wrote:
> dma_direct_alloc_pages() may satisfy atomic allocations from the coherent
> atomic pools. The pool allocation is keyed by the virtual address stored in
> the gen_pool, but the pages API returns only the backing struct page.
> 
> On architectures with CONFIG_DMA_DIRECT_REMAP, atomic pool chunks are added
> to the gen_pool using their remapped virtual address.
> dma_direct_free_pages() reconstructs a linear-map address with
> page_address(page) and passes that to dma_free_from_pool(). That address
> does not match the gen_pool virtual range, so the pool lookup can fail and
> the code can fall through to freeing a pool-owned page through the normal
> page allocator path.
> 
> Add a page-based pool free helper that looks up the owning pool chunk by
> physical address, translates it back to the gen_pool virtual address, and
> frees that address to the pool. Use it from dma_direct_free_pages() while
> keeping the existing virtual-address helper for coherent allocation frees.
> 
> Tested-by: Michael Kelley <mhklinux@outlook.com>
> Tested-by: Mostafa Saleh <smostafa@google.com>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>  include/linux/dma-map-ops.h |  1 +
>  kernel/dma/direct.c         |  4 +--
>  kernel/dma/pool.c           | 54 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 57 insertions(+), 2 deletions(-)

This seems pretty suboptimal?

If !CONFIG_DMA_DIRECT_REMAP then page_to_virt() was used to compute
the genpool's addr so dma_free_from_pool_page() can use the same
logic, which is how things must be working at all today

The CONFIG_DMA_DIRECT_REMAP scenario does look broken, so I'm
surprised there isn't a Fixes line on this commit? I don't have an
opinion on the search, but since alloc_pages() is used there is 8
bytes in the struct page that could be used to store the remapped
vaddr to avoid the search if someday someone wants to improve
this. Maybe a small comment hinting that direction would be a nice
addition.

Jason
