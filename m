Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F1B21A447
	for <iommu@lists.linux.dev>; Mon,  5 Oct 2026 04:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791176339; cv=none; b=f67v97tb3vazjCa6W5Hj9lqOmyDftMh9op2WYHGvSVC3dQInfrfKseQLpO+l2tqhrc5Lnm6997ZCTBva5s3ElFYLWxPUynMYynK2E0MCaFNU0nKi7lkRoCKFPUt+I48T1SRhiJQmyQwcc2Ha2eoNsooX+Y+7XAL5i7tuJdwC/Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791176339; c=relaxed/simple;
	bh=OWeLqewt6cDtSzZMGAcsd1VNoKJM2XpzzuMOzXs1SEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nwr9uXieSKC3ABkRFaju94zFK4uNaKnVEY6lK3V+RzHLzMsAwTUF9dfhVVbt3L8kXDxlhbGLHcnDISol9MWY1VDo/RtdlnnpZMVL/9RITHxK5r1V3bdxzoExGFpGVkNCmFRQ55PMaBKnrKIB3seiic6/fZLiEaHRxH7Grvfnsms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u88IKhij; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u88IKhij"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2e2e4ef20beso59595ad.0
        for <iommu@lists.linux.dev>; Sun, 04 Oct 2026 21:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791176338; x=1791781138; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wh1AxkS8SWKuWWWh7pZFQjWGZF9aNJY94i0CrRQCRF8=;
        b=u88IKhijnmu3YeklL54jLEeDDDpjAGV+Y+nbr+xu05d0G1NLO25hbWgJ3dSRiKeGeK
         lCv1mkLYmSmNxXxO4ky/kxFq8ZVR4aK1FC62SoWEw/fNbqX4j/B+KqbcTpYksgZV9G2o
         FKwmjF4/uIldzhlxuqcWqE05wTbh0rdz5XW9l2nOQskUDqIFTkw98NoDELjoaS8myND3
         5lFysnLM+Cqdwm7hw/1cu9LMNZJpJivJAbffK0wlXlPGOz+CtCI2GFQD8/sukwUK9xL+
         mj064Fba5RO0lGd8kLq9Lpb3TnlpX4PM7m3tLsVD6RSDpfYOZ6BwjrrgDtSKSu0ol9DG
         GH7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791176338; x=1791781138;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wh1AxkS8SWKuWWWh7pZFQjWGZF9aNJY94i0CrRQCRF8=;
        b=qXLATbCuulw8c3gnRCDqBDDtPg/XxjT6ezpAVjbAk/xgv0aLo7oP1ok1UUBzqOz/+w
         yppx6gJt9P+pYAN3Du3jwo6RFk/bGGYYk4vaeGzWHK68xBVX4OXEC0Y11iiP2YwkDS1g
         J6qGRpC5pgT1hUW6pdBg+AfSyaqocK71aFqH8Jgg4q4xTJ37laRFoZ8xDx5Dfj5PMjFb
         eTUWYFce6H6hVs8HGH7UmcMDUPfK8f7sG/AcfKy3q4X4a9wBQ69gUI/JQ9c416OHpcYD
         /cSyyYXNESusjsyVmt09OuTVP2ob4fxW3CcFN/o/dkjRGqOYZhPToHct5lUM9hnJ8RJ+
         6eJg==
X-Forwarded-Encrypted: i=1; AKwUvBwAarRmeB3FtjEfrQXaMtJ/hdXBkkF8UbvaeY3XHLW0iCmmb6yiReAkJ7rgkf8q9fVV3CR38w==@lists.linux.dev
X-Gm-Message-State: AFq9FYJm/soB70mjy85YUpPEwomlISoUfdfeeVQxjGn9iRN6Q/XQ9G5W
	XYzN3/FkrWUpG/yYoZ3e6PdblHY5DpNp9xq3m1XNxQ/EGyuiZjnntmIQvxXgSbeZJQ==
X-Gm-Gg: AYBFou3e1aIhVVbwVBbmkAOzO29tS9awRcTG3t2sRKg+KMj06YKSWXNzAYMxq/dE8ht
	0wxXumEJDN7ORnviYKerrXcLZHbsYQT3TlMa++QgR+Y6WRI0Kd+83C8zqHWSuQtYtLNt2jwmQg4
	um5kn3pFRQCYblTIul2gxsIEnJDFAc4QyzZnfSa8+rFXSqhHmzzKmH8US61wzdLT2PqkXvNNgMY
	YRXyoa9NuzHJoIK6yyKKTb2gtSnJk9Nn2JqmvGqCXGlbrTlBAhvI+3xAaBZ0YIvjEezMVFOKcns
	gLAcm8gS9t8IHUOeXm8G5FHy5Rla6YOu34lGpdbGMUknLd0bhjftZE0z8fiXtioIDTVD2aN4Qr9
	/86L5Qq+G67/mXEsqNMPrQIvdcTQBn7++QMCJioiEPBEhn35mKk3277RlLC37vbbRJ1+ClldLaW
	1BsGwWrzGdKEiEwK92DnIBYVJuL6FPSCGYW/uvHqnopImLPuwNP1YOgXXDH+/fnSZwiWa28+QzQ
	p00lUqRrBgMmemIdNvJ3Id+U6KDZ1eUh3GW
X-Received: by 2002:a17:902:d987:b0:2d7:1cc3:a69c with SMTP id d9443c01a7336-2e5339b60b6mr5288515ad.7.1791176337084;
        Sun, 04 Oct 2026 21:58:57 -0700 (PDT)
Received: from google.com (105.211.142.34.bc.googleusercontent.com. [34.142.211.105])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cce6d901a2asm185534a12.17.2026.10.04.21.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 21:58:56 -0700 (PDT)
Date: Mon, 5 Oct 2026 04:58:50 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Mostafa Saleh <smostafa@google.com>,
	Daniel Mentz <danielmentz@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Logan Odell <loganodell@google.com>, iommu@lists.linux.dev,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/5] iommupt: Introduce IO page table shrinker
Message-ID: <asMuigioXmHZmjO2@google.com>
References: <20261001230219.818128-1-praan@google.com>
 <20261002150844.GC3481470@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002150844.GC3481470@ziepe.ca>

On Fri, Oct 02, 2026 at 12:08:44PM -0300, Jason Gunthorpe wrote:
> On Thu, Oct 01, 2026 at 11:02:14PM +0000, Pranjal Shrivastava wrote:
> > Introduce a lockless, deferred reclamation framework for IOMMU page tables
> > built on the generic_pt library. As VMMs and userspace drivers map and
> > unmap large, sparse IOVA regions through VFIO and iommufd, page table
> > directories are often left allocated but completely empty. generic_pt
> > frees a table when a single unmap covers it entirely, but tables that
> > empty through a series of partial unmaps stay allocated until the domain
> > is destroyed. Under memory pressure, this *stranded* memory cannot be
> > reclaimed and has resulted in OOMs.
> > 
> > This series refcounts leaf directories natively in struct ioptdesc and
> > registers a domain-aware MM shrinker that prunes empty directories under
> > system memory pressure.
> 
> We had talked about doing it this way
> 
> But I had proposed a different, and possibly simpler, solution that
> addresses *just* the iommufd use case.
> 
> After unmapping something have iommufd compute the gap in IOVA that
> contains what was unmapped and then issue a 'clean(gap)' operation to
> generic_pt.
> 
> This is the same operation as unmap, except we know now that the gap
> has no PTEs so all it does is clean up the table pointers.
> 
> This requires no special refcounting or anything difficult beyond
> some locking in iommufd to hold the gap stable while we clean it.
> 
> Would it work for you? It seems substantially simpler, but I never
> tried to implement it.
> 

I was tempted to use the interval trees too, but I started thinking
about:

a) Locking: For the gap to stay stable while we clean it, we'd need to
add some kind of serialization either through iova_rwsem or a dedicated
gap_lock to prevent a concurrent map to allocate IOVA from that gap. 
Thus, every unmap pays for clean under the lock. I haven't perf-ed it 
yet, but I'm not sure whether users/Guests using virtio-iommu, where any 
guest DMA unmap becomes an unmap on the host, would regress.

b) Other users of IOMMU API (unmanaged domain) like the type 1 (which
was the one hurting our systems) and other in-tree drivers that use an
unmanaged domain and call iommu_map()/iommu_unmap() with their own IOVA
allocator. One of the goals was to avoid enabling the user-space or
in-kernel IOVA allocation (ab)users to cause OOMs via IOPT allocation.

> An alternative version is closer to what you have here, somehow
> connect iommufd to the shrinker and have it lock and walk the gaps
> cleaning them on shrink requests?
> 

I like this one better than cleaning on every unmap, since it keeps
the cost off the map/unmap path and only does work under memory
pressure. Although, it doesn't help type1 or the in-tree iommu_map()
users.

Would you consider those users worth covering, or would you rather
they track their own holes and call clean() themselves? Happy to dig
into this at the LPC session too.

Thanks,
Praan
