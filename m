Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6783D7D80
	for <iommu@lists.linux.dev>; Mon,  9 Mar 2026 15:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773071419; cv=none; b=U9b5EbMLMyKBb9UKFVz7Qo9XdPle/2WL0RZvzEWQ4MjlMr6VcEKWwYWwJTczeHEeQtDgD5h2b83+1NwYc1vhQuPXK7xzL5qnjAA1n4rCvOLRZaOyiB8YAi7RrP6ZeRU7T6b4zjO24Q3GXgl4TkS/moe4jcFYIO3wT9goZ820cTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773071419; c=relaxed/simple;
	bh=vz7GtLHU5cL+Tn669J3wF1mbDCNVBgpwpocy1RdYQi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YEtuIkKc/rQWEem8fnfpAJCCA95uvp3IfjM8F6uHMq2vIxniX1WKkCybEZIPzzDId4vgFHWsaWluggsWX577IGjkZKIUd6AMOQUla1WVXW/kagqXMGY16ZfM9/lmYn32GJQcvEYDrrGg/G49M7HTnq97FKupmORy2RQtl+IOFTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=OCVMLqpL; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="OCVMLqpL"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-509064418a8so24605531cf.1
        for <iommu@lists.linux.dev>; Mon, 09 Mar 2026 08:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1773071416; x=1773676216; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=O45tfflm9Orr1MA6lJ9Hem754qbRzwLB13TT5ehymNk=;
        b=OCVMLqpLGBRr7HIrELJVV36qxjbRIlohf/eFuPEm1tjsaxaXKl7jziD42Cg2+ILG+j
         qX81ZiwvBt6tFYKfGQcrnpddX1CdV0U61soVAVPl+UeAN9gBvSIA4TdWWo11C/LF0xHz
         aTHdrkE6jiRn4MqH8XmStVkC6QgWqE8NPCKUzz4QYbHj1/4IXJLKnLTnfTcPBJb+mmgr
         DeKNXw/dCbnoxEAITW43s8xykUGMkyxQGs9EQ9msejiWkOZR+RndzWfjdKqac9qMsY5T
         2A2RpekGmWEUWb50vPiblrgUCj07nQ5SDIhVVRVDUH6XA2I92FMw1dEt4XDtt9R1dbqG
         XBIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773071417; x=1773676217;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O45tfflm9Orr1MA6lJ9Hem754qbRzwLB13TT5ehymNk=;
        b=jqAeRu8UgSJ4MJNe2B5wc36SKHYcwXWSKYpEJndvJE2e0OeQV6+TRU2eQwjsRMh64Z
         pHKlyQLmO04Rr3GWP29rgWYYjc79mg+JuojSvF7rWSjnY0D2ZQLpQL+jcu+n6jxeCCAG
         mZZNfrBMRoGYprSBkuFW7/PUHRHGfkofAysrF7Ugt1UE8lV82Dc2yNk5YZNnGDhd7KX3
         CO4lJow4nB7ILbscCxTrRCyB0fcbe1+N8ZbzotIpKtU3A6h0qWH/MQbwedHCCogznhGF
         UuOaDHsr5pZnxGa4kfmOfcFkfEnxkTHktPxSyDJEKER6XN7wrtn6gLGr+VkcDfq5RNzt
         xmjw==
X-Forwarded-Encrypted: i=1; AJvYcCWRf2kBCNsWDZh9zieBMxcLq+gjsD4BZqfSAluYZU3CY/kJYe41A5n1EFTDmiVrh02sOo/uGQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzwey/yxhfrd+fbsNw/HZZ1Vtz717DWVMOaoQhxd2rvcD9oVnsj
	55W/xkOUTSLZzaOIfWTpKhsxX/Dn4iQr3RKzzKgfZKJ6+ZWcyX1qj12CRWrwouiazKc=
X-Gm-Gg: ATEYQzw4OJSd8YdvgwBEoTV8XB2o2/uKGcIzeOjC1tpMFTIQg3YFKmr8vzXc3zCyEZP
	ekL2HSCKBo0vy/55d7XhnFxJufR4A9fceAydAAK2Tl6qXSUKlF+h0ofG1GVcYefbWfoAQq2FER0
	immDPke3HdxSB/lwy/99kGH7AzUkOmzOk8VJAbx2AXzeemNyGeTDNQaqo0s32ZB+hITzwu5vsFm
	mvhHKYoiEiteRSSkO3e/Ms2q8LG1RmMocVDhoQ6oT2ntemoS8IrKmHr1lTNc/J2Z33U1aKrXQJW
	6zULv1Wy0JdbV3970JcL3H/o3WRVUwauX4v7spiR5W3EZRBxDNlzibOAK84BYdzNKLBiUiDKy+V
	b20DUPSIz6ifSIByp1qgeiHQr+OoTT/8vHsEI+BkFkakLnOTwe79ax8J+IMcPgeTQBgpGcnZzGu
	bTMAURidDIltcdYVXWQCzCZj3J7fNtIH68u5Ia7yzYvjn7VYabIZ5Lz2WJ5C4SOoFcx59CpoYnr
	xLeYbhq
X-Received: by 2002:a05:622a:30a:b0:503:4251:6597 with SMTP id d75a77b69052e-508f46f8abdmr155244531cf.29.1773071416552;
        Mon, 09 Mar 2026 08:50:16 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a57a4ec29sm837376d6.19.2026.03.09.08.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 08:50:15 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vzcs3-0000000GsMM-18A4;
	Mon, 09 Mar 2026 12:50:15 -0300
Date: Mon, 9 Mar 2026 12:50:15 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Peter Gonda <pgonda@google.com>
Cc: Jiri Pirko <jiri@resnulli.us>, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, iommu@lists.linux.dev,
	linux-media@vger.kernel.org, sumit.semwal@linaro.org,
	benjamin.gaignard@collabora.com, Brian.Starkey@arm.com,
	jstultz@google.com, tjmercier@google.com, christian.koenig@amd.com,
	m.szyprowski@samsung.com, robin.murphy@arm.com, leon@kernel.org,
	sean.anderson@linux.dev, ptesarik@suse.com, catalin.marinas@arm.com,
	aneesh.kumar@kernel.org, suzuki.poulose@arm.com,
	steven.price@arm.com, thomas.lendacky@amd.com, john.allen@amd.com,
	ashish.kalra@amd.com, suravee.suthikulpanit@amd.com,
	linux-coco@lists.linux.dev
Subject: Re: [PATCH net-next v3 2/2] dma-buf: heaps: system: add
 system_cc_decrypted heap for explicitly decrypted memory
Message-ID: <20260309155015.GP1687929@ziepe.ca>
References: <20260305123641.164164-1-jiri@resnulli.us>
 <20260305123641.164164-3-jiri@resnulli.us>
 <CAMkAt6o_yZ5T-3TRwymjYQZEq-Q_z=DAA3vc61h81X9sQr_CXA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMkAt6o_yZ5T-3TRwymjYQZEq-Q_z=DAA3vc61h81X9sQr_CXA@mail.gmail.com>

On Mon, Mar 09, 2026 at 09:39:44AM -0600, Peter Gonda wrote:
> Great feature to have thanks Jiri! A couple naive questions.
> 
> On Thu, Mar 5, 2026 at 5:38 AM Jiri Pirko <jiri@resnulli.us> wrote:
> >
> > From: Jiri Pirko <jiri@nvidia.com>
> >
> > Add a new "system_cc_decrypted" dma-buf heap to allow userspace to
> > allocate decrypted (shared) memory for confidential computing (CoCo)
> > VMs.
> >
> > On CoCo VMs, guest memory is encrypted by default. The hardware uses an
> > encryption bit in page table entries (C-bit on AMD SEV, "shared" bit on
> > Intel TDX) to control whether a given memory access is encrypted or
> > decrypted. The kernel's direct map is set up with encryption enabled,
> > so pages returned by alloc_pages() are encrypted in the direct map
> > by default. To make this memory usable for devices that do not support
> > DMA to encrypted memory (no TDISP support), it has to be explicitly
> > decrypted. A couple of things are needed to properly handle
> > decrypted memory for the dma-buf use case:
> >
> > - set_memory_decrypted() on the direct map after allocation:
> >   Besides clearing the encryption bit in the direct map PTEs, this
> >   also notifies the hypervisor about the page state change. On free,
> >   the inverse set_memory_encrypted() must be called before returning
> >   pages to the allocator. If re-encryption fails, pages
> >   are intentionally leaked to prevent decrypted memory from being
> >   reused as private.
> >
> > - pgprot_decrypted() for userspace and kernel virtual mappings:
> >   Any new mapping of the decrypted pages, be it to userspace via
> >   mmap or to kernel vmalloc space via vmap, creates PTEs independent
> >   of the direct map. These must also have the encryption bit cleared,
> >   otherwise accesses through them would see encrypted (garbage) data.
> 
> So this only works on new mappings? What if there are existing
> mappings to the memory that will be converted to shared?

The set_memory_decrypted() is called during system_heap_allocate(), it
is not possible to change dynamically between encrypted/decrypted.

Once the heap is created every PTE is always created with the correct
pgprot.

Jason
