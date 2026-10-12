Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669F7346777
	for <iommu@lists.linux.dev>; Mon, 12 Oct 2026 13:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791811697; cv=none; b=lkjX9Voezfs4sPn3O1tFBWKnsyljuOKFRGh9bllMCbxApu6778UiZjsYIyJ4voDIENhSCLM+sCnrd/QpqMywSfAB8ikJdsVNfPutIEMCphbvFSWISSJYyP1hdrBhVmEQKKrvkZm37Lq1ZFMush4QHSOIIAMgK3Zt4AUniE5gWuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791811697; c=relaxed/simple;
	bh=qtj9QPvxdaek1ie58tXDrS0v4YKkGwAE+g3oWgU0JC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SuDoKYiFOm0ueb1ZbuSPSqxH3bUh5twnf69a09fZfYS7tYGsBxUbQ9W8A3555WB8HuByotYMDfzHeYoMDx7QaNxBoTSgKzvYHHWTYrvf8vZbBoOOh1v/23MuPYwhcFtGwhi+vgNSfd7OfztgnWRHAcebaxACmzOkso+EdAR6zHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=PG+UdpA0; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="PG+UdpA0"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-91054f537ccso23401466d6.1
        for <iommu@lists.linux.dev>; Mon, 12 Oct 2026 06:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1791811694; x=1792416494; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jJd/wX/j900G5XTB7UARaKvliXjJOtwZKQBz13LNSNw=;
        b=PG+UdpA0RibTYJ8lHM2X+fS0ZaDwo8n3vs5GO7TumzqzHFGUC6ek7rUlp2zfaWH3c5
         mTaOkwHkIsNeO+MraqSvgdLYzAWDW6i4xSsR64avPwZSRh3eN0UQiMLIlhOzID7b2L9M
         PECibxP+Smm3IhVA7dqIArjZ7bp8YdYXuDVl8FPPu+Do/9odGIZUUk5AbDIj3dJ0E40n
         0ShHHhFR/2WF2L1MweLMlmrjqBw74Zw+JsRj88EWTgEFlX2CMaI9ljRsiWOgMmyJtHiu
         tHEqMdHskBz9U+MoWo79X6q3bLopV/0uF6XJDRvIJRnl6PB52GzxZjU7iJ3/5VNBL+wW
         ybaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791811694; x=1792416494;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jJd/wX/j900G5XTB7UARaKvliXjJOtwZKQBz13LNSNw=;
        b=O5Nfa/h4sVffPCffRo+WmYE5e3INncwgwV+CATt18valajksm3reld/2Mdkbvbk0CT
         7zs9jAYEByfxl1mrpI4TlQn+92BbCl/LDdhE4r4x5N3yxpl462ZHc86NhaNoGJKB7ZOr
         0Gm0DCsZnsOj1/ML9NFvHFnondk4kNzjkQ8YvGuswT5u5GVMKSIwP1ddw16XJW9CaGYs
         uoDAsfA/VsXlVC6XI6aQno6qd4rmr7RLVosZswuuGFHZO22qtYv5RHkd/ey6ZoD90Y1T
         +Kc53HXzvV37VNDQLp57kFL+F/P2Xz/E+yRImpV0DYc6oPEuyL1ABI0scdOhSDzo6y/8
         WcRQ==
X-Forwarded-Encrypted: i=1; AKwUvBx0zfS8KkOejzhEEVrONtF4x0Q/IlXibrGleCRVeoDy3Mgs/oicdWlvg9mfmH5PHNhHNuv5Sw==@lists.linux.dev
X-Gm-Message-State: AFq9FYLRFU1Macw3pvxkLN2Hh2iYOg1sb1vZWvegqqtoapnkncnsBh8x
	T+M1IFkF98N7JCh+yfQPn72FWYtjWVr/bhiZXp7uP2aLJuT64AsFH7vi8XIOPBTgRcY=
X-Gm-Gg: AYBFou2L33rF5+B5fP6Ai0fF1yfmZ3QhNJhWt7K9cMsaW+NA40pIe1MEO5ouhc6te3I
	H9nLfHlbj0M845nCR3Ibabf7wdh06UFmLRhqkvVKEzEblAQ9ZdSj7scqWQLkE9jl8DN9Oyx6/mq
	aNYvnkP4dD2fv7l9q9RN8IaMV6wQLej1QPZISWPr4fJBMlxJASlqfISml0oiNZ3Rm2Agsy96QeX
	xpz29Pzvsm7v3xHWkAknxMa+RhPyWtxJb1LZIklShe1RgjrhRMUInns8cfsP7Kos2pjUtMSbfFl
	MmXqKsrxiaT5tcGyjdQAEmtQ5bxzgFZA7jDGAYuhMtKVggUyn0u/+i570zDG0i2ivtP172pB5fI
	mdg2kYnlh9rSi8y8vIrqU5cmWjZkj4G60zWaWFR2MrEtunvB9Ri2aMIYGY81f37NIjIIeIBldsr
	F/wKLBfMyEd2N5KO2hhVAcC0UXZTC2K8ueY0Q8CEmeusPrApUiP8OjQCzd4sUs2rbC6TIl8UeMe
	AVT44+qkUba3Kv0O62hVC8GEd7ENiJSY2zhUat+g+69hnyqcEdLqbPE
X-Received: by 2002:a05:620a:601b:b0:93e:6a4b:3ea6 with SMTP id af79cd13be357-93ebd1de502mr1556980385a.24.1791811693967;
        Mon, 12 Oct 2026 06:28:13 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93eb986c0e9sm869347185a.20.2026.10.12.06.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 06:28:11 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xGG4Y-00000006Hq6-1xVE;
	Mon, 12 Oct 2026 10:28:10 -0300
Date: Mon, 12 Oct 2026 10:28:10 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Daniel Drake <ddrake@baylibre.com>,
	Matthew Wilcox <willy@infradead.org>
Cc: robin.murphy@arm.com, iommu@lists.linux.dev
Subject: Re: [RFC] Subpage allocations for IOMMU tables
Message-ID: <20261012132810.GE14213@ziepe.ca>
References: <20261012091823.114480-1-ddrake@baylibre.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012091823.114480-1-ddrake@baylibre.com>

On Mon, Oct 12, 2026 at 11:18:23AM +0200, Daniel Drake wrote:
> Hi Jason & co,
> 
> I have been experimenting for how we might support allocations smaller
> than PAGE_SIZE from iommu_alloc_pages_sz(). Are there any existing
> ideas or plans for how this could be done?
> 
> This would be particularly beneficial for ARM platforms where the
> tendency of using 16KB or 64KB system page sizes is growing, but the
> IOMMU is fixed at 4KB page size, leading to wasted memory.

Oh? People built SMMUs without the 16k option? That's sad news.  In
the systems I have the SMMUv3 supports 64k/16k so there is no waste..

> One possible/draft approach is below. When a small allocation is
> requested, a per-node per-size folio is created. A section of this is
> used to satisfy the allocation, and the folio is added to a pool so that
> it can be used to satisfy later allocations too.
>
> The main challenge is handling the iommu_pages_list used for freeing
> allocations. In the whole-page case, this is nicely handled by using the
> list_head in in struct ioptdesc. But now we may have up to 16
> allocations per page, where each one can be placed on a different list.
> 
> So, in this approach, I have made iommu_pages_list manage both a list
> of regular full-page ioptdesc allocations, and also a list of subpage
> allocations that live within these subpage folios. The subpage
> list heads are stored in a dynamically allocated struct
> iommu_subpage_meta.
> 
> I don't love the approach but it at least seems to be working and I
> figured it would be good to get some opinions before I go further.

Yeah, you've hit on the main issues. Throw in the coming RCU HEAD
issue too and you get more problems. The iommu_pages_list abstraction
was intended to give some flexbility to solve this.

The idea Matthew was aiming toward was to allocate a dedicated struct
for each folio that could have the right sized stuff. You can have an
array of list heads, for example. Then you are not limited to
overlaying on struct folio.

He once even talked about making this into some kind of generic sub
page allocator with metadata, which seems quite interesting.

In this mode the core mm would provide the pooling and the subsystem
could request XX bytes memory + YY bytes metadata with some way to
convert from a memory pointer to the metadata pointer and back again.

There is also the exciting stuff power does with it's sub page
allocator, not sure that is a great example though.

Another option might be to involve generic_pt somehow and have it
populate the tree with the full folio. At least this way the memory is
not "lost" but it may not be used optimally. I doubt many people need
a 16x level 3 page for example

Another thought might be to use (pre) allocated memory to hold the
free list during unmap and then flush if we run out of memory. This
eliminates the linked list which seems helpful. Not sure what kind of
performance we'd get though.

> Other options:
>  - Replace the list_head with a pointer to the virt address of the next
>    page in the list. We can detect whether we're working with a full
>    page or subpage based on virt address, which means we only need one
>    pointer in iommu_pages_list.

So long as a linked list is used you need 4x the pointers, which seems
to be the main problem.

>  - Bump allocator with per-CPU pools of partial subpage folios, along
>    the lines of the networking subsystem's page_frag_cache. A little
>    simpler than the approach here, but we'd have to evict and abandon
>    filling the folio if the next request is for a different NUMA node,
>    and handle CPU hotplug.

Free side can't gurantee it will only free the same per-CPU pages, so
you are still back to needing 4x pointers.

>  - Allocate the subpage-tracking data in the unmap path? Falling back to
>    immediate flush and free if allocation fails, along the lines of
>    tlb_remove_table(). Would need more thought.
>  - Implement generation-based deferred freeing in iommu core,
>    eliminating the need for iommu_pages_list?

What would this look like?

There is also the 32 bit ARM option which avoided using a free list
so it doesn't need folio memory. This allows it to use a normal
kmemcache.

free list is fundamental to the design of generic_pt, but if more
people than just arm32 need this it would be reasonable to implement a
generic_pt_nolist variation. Driver can select which version it
wants. Maybe this is implemented as some combination of immediate
flushing and a small free array allocation from a cache?

Jason
