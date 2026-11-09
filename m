Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794227704;
	b=WL/UIiwNvv9gvBi50BbJXWEV0netsH+LqiFToQ4d7Wei9p+Ftevq8GHAPUYztU4HkXke
	 HHhve/W6UChJar8lhyXrqOwTvGnrZmDe/kiJfSHBIvPJ8NJyJryo8bL+xsUjey9/AeB0m
	 RjERbSLUPlGYsjl4OoIzEd4bETbMEbMEtx0sJEY5juPlcTQutTAqsy6sH3mtRFmzrKr3/
	 aAkc+q5I+emW/aK6R3tAhha6ilLnRP2sOQKz50wxH60djHG65K5yPDItqg8iKpEmG5naZ
	 YwTvoKbBon4fI3cKND79trkHxi0YupaTR6VrLmXzYqRzR+/Ki9DfT1fCv3sDe0WchnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794227704;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=WvzMdwDlo09mKx56WkMYCYECEOAz6fHhPR97cKN4r+Y=;
	b=dFthV2cFjZHuFeUk8+wNaMG99BQjAXFTCHfazTXaKBlxcFmRwNrhJmpnmMKtxl+0Akly
	 EDJK2Dr+3KoFuoIPeryCYmCFhJBQaTFDYlHhLXC5ht9k7x/Kv13J+LRcjQD7XIogS8Gr0
	 TKn9PtlBX5GRn1YwptKnczZ4+54wczxwZjFfMV7gDXdLqrDOzIBw/EnF1Jkd4QCUjW9Qd
	 iRmaOfGCzgEgwgrA+WLfa06xHlFZVi+iSW6VlSL90gA7bNvPjENGiN5HxzDcfN46b3Sa8
	 Ui3hn53wPrIRfPIJgrAaMOqniopYmf6kjUj8lSb4vWnd7vwP9KQ7IqHrINYo/aWLfOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=FJYb7VWz;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451F96082BF8
	for <iommu@lists.linux.dev>; Mon,  9 Nov 2026 12:35:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 451F96082BF8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=FJYb7VWz
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4b6266b5bc4so26215e9.1
        for <iommu@lists.linux.dev>; Mon, 09 Nov 2026 04:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794227702; x=1794832502; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WvzMdwDlo09mKx56WkMYCYECEOAz6fHhPR97cKN4r+Y=;
        b=FJYb7VWzAohER26wy+nuwFrYs7UbMYXPO6PEW6qReizcjUfMSd8kF7K4u7oaVBCaj0
         erZuB9wuO2frBuG7fnA31h5lvJKIkAwIDWXojKf/uthURZ52rLrxTSbKQ2mc8yHg+c7L
         T5ku+l5eGf3OiRyIdwdw3zlhdDrNEfpy5h/ztKiN9y6K4RuBd+c6lHSAD8H7tl+WF9Tz
         0T9ld0cVhlXnzwoDTOizR1WSpPYTjFB/puX8QszRWcsAw3XJCCjIHdK3dQtPE2tSlQkT
         oDn+Hd7vxYNed+hhMMc03FDYy4PbmLbL9M6HSzgF3SRoDRQ+tPaZvaqNy/Yj/aB3u2ve
         cc0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794227702; x=1794832502;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=WvzMdwDlo09mKx56WkMYCYECEOAz6fHhPR97cKN4r+Y=;
        b=Zsm6xyviUFoNoppQaaoWNW11LoVqbEyG1u02DbtiTMOBjAxnjS1vxfe4V5Hn/Or091
         WP0QnDMyXXt7pROm0aYMWfVzZ2p02+U+FJEssoH462EIlLnT6zPjQVuhKjrMej0WPGPS
         +UPv5o9K2E4DVMPr4whEMBufEPiuJBT1rHfcInGYDWrRkyXYEwktFUxbDGlPPHxLVOUX
         HV/ohPlvozPez9PxuuozC58mVGGgcunTLA4jBQyERpgpHqFMSt4OUHSWEADtGX5lbLTN
         8jjpy+CTkeH1d6TzdCnHuQhWJiPXxIh1cADBHheuEX5vGfjiTXfE5aNJeS+dbmsOHqEP
         fIfA==
X-Forwarded-Encrypted: i=1; AL+hErF3KSOOXbCq6YEFjf5ILJlb6QSfaKvFJrURQyYGqnPF8Cqbuwn5pKrpKxK33r0NtSotrJYG9A==@lists.linux.dev
X-Gm-Message-State: APuU4Z99IfjqfXmiQbYfx6sW9lbC0aNVeEB1I9EjKDGiRCc9bu1UouNc
	GGpyw3uB9BRsloc39schKO51H6485IfNj3g/OugE0QAoZiVsl80EurRd/5TfYv/7Z6ryUIjnL75
	/HeSxsA==
X-Gm-Gg: AYBFou3EPXtBuLNG7EKbYB61L4ALYVy9AOjdnCSRokN3wc6baKdTE+ifnKnwol/tIRs
	Y7GCqI6EdCaBg+2Z7lADhjGHCFd+2m6/uBNAKFrMIP1f8xvjYq7+/poGXsMvki9pa4uxti5A2S5
	cf1R/5suf+uTWcyPD+hXOeCVBC+95FBf3d+StLRQKWxJp1jjz3Wfz960Qo0pzK9kd4FP0ygtGwy
	fx8PnEZEiualniTFHko+x6fCb7k+JtBwBzxOchb0USL+XSEYtezNQ8Lgnp4yfSwUcADxDoc8Z1p
	CM6C9U89gc79cCyWvRHKvYXy7LCdQlhDB9c0UmBULnFbDTCihHo6GYW7zgFrYUh2YOpSBpIWyVB
	ZwfFs6wkG4+OT6JQ/CGXha7fJDyDTgfdBOo5HfJPStuuCrCBfISom0EojKauLBsrtYHCOz60nlT
	y1SKVrktbC8fwWctf4kCOJTlCa8P2eyrXO7BpvXGhF0ELqnH/JVO4FT+LLBy9WKh+IrE+M81vXh
	v9Tgqf3k3UOs95KvlneDtQxqmu8Mip1SyNoWL/kNoVIAYR9YN30/CHlYFMTrgjiSvwm+V01e8cC
	nQ863nF+i32qqjo5l0wt3JiQ2/E5Mi6SYZabYlfDRwU5LJkd+He1JZwy6rV+SSPJ67cTXQ==
X-Received: by 2002:a05:600c:528f:b0:4b6:5035:d54a with SMTP id 5b1f17b1804b1-4b8aec15d44mr2319705e9.1.1794227701554;
        Mon, 09 Nov 2026 04:35:01 -0800 (PST)
Received: from google.com (160.193.189.35.bc.googleusercontent.com. [35.189.193.160])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49597186ec5sm10010991f8f.33.2026.11.09.04.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 04:34:59 -0800 (PST)
Date: Mon, 9 Nov 2026 12:34:54 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Daniel Mentz <danielmentz@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Logan Odell <loganodell@google.com>, iommu@lists.linux.dev,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/5] iommupt: Introduce IO page table shrinker
Message-ID: <avG97sxE2NFZFtvE@google.com>
References: <20261001230219.818128-1-praan@google.com>
 <20261002150844.GC3481470@ziepe.ca>
 <asMuigioXmHZmjO2@google.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <asMuigioXmHZmjO2@google.com>

On Mon, Oct 05, 2026 at 04:58:50AM +0000, Pranjal Shrivastava wrote:
> On Fri, Oct 02, 2026 at 12:08:44PM -0300, Jason Gunthorpe wrote:
> > On Thu, Oct 01, 2026 at 11:02:14PM +0000, Pranjal Shrivastava wrote:
> > > Introduce a lockless, deferred reclamation framework for IOMMU page tables
> > > built on the generic_pt library. As VMMs and userspace drivers map and
> > > unmap large, sparse IOVA regions through VFIO and iommufd, page table
> > > directories are often left allocated but completely empty. generic_pt
> > > frees a table when a single unmap covers it entirely, but tables that
> > > empty through a series of partial unmaps stay allocated until the domain
> > > is destroyed. Under memory pressure, this *stranded* memory cannot be
> > > reclaimed and has resulted in OOMs.
> > > 
> > > This series refcounts leaf directories natively in struct ioptdesc and
> > > registers a domain-aware MM shrinker that prunes empty directories under
> > > system memory pressure.
> > 
> > We had talked about doing it this way
> > 
> > But I had proposed a different, and possibly simpler, solution that
> > addresses *just* the iommufd use case.
> > 
> > After unmapping something have iommufd compute the gap in IOVA that
> > contains what was unmapped and then issue a 'clean(gap)' operation to
> > generic_pt.
> > 
> > This is the same operation as unmap, except we know now that the gap
> > has no PTEs so all it does is clean up the table pointers.
> > 
> > This requires no special refcounting or anything difficult beyond
> > some locking in iommufd to hold the gap stable while we clean it.
> > 
> > Would it work for you? It seems substantially simpler, but I never
> > tried to implement it.
> > 
> 
> I was tempted to use the interval trees too, but I started thinking
> about:
> 
> a) Locking: For the gap to stay stable while we clean it, we'd need to
> add some kind of serialization either through iova_rwsem or a dedicated
> gap_lock to prevent a concurrent map to allocate IOVA from that gap. 
> Thus, every unmap pays for clean under the lock. I haven't perf-ed it 
> yet, but I'm not sure whether users/Guests using virtio-iommu, where any 
> guest DMA unmap becomes an unmap on the host, would regress.
> 
> b) Other users of IOMMU API (unmanaged domain) like the type 1 (which
> was the one hurting our systems) and other in-tree drivers that use an
> unmanaged domain and call iommu_map()/iommu_unmap() with their own IOVA
> allocator. One of the goals was to avoid enabling the user-space or
> in-kernel IOVA allocation (ab)users to cause OOMs via IOPT allocation.
> 
> > An alternative version is closer to what you have here, somehow
> > connect iommufd to the shrinker and have it lock and walk the gaps
> > cleaning them on shrink requests?
> > 
> 
> I like this one better than cleaning on every unmap, since it keeps
> the cost off the map/unmap path and only does work under memory
> pressure. Although, it doesn't help type1 or the in-tree iommu_map()
> users.
> 
> Would you consider those users worth covering, or would you rather
> they track their own holes and call clean() themselves? Happy to dig
> into this at the LPC session too.

I believe there is a value in supporting other users beyond IOMMUFD/VFIO
(eg. DMA domains) or even outside of iommupt, I haven't investigated this,
but it's worth looking into either integrating the "iommupt clean(gap)"
idea in the IOVA allocator or more generally rely on refcounting +
shrinker (or other method).
That’s probably a lot of investigation, so I am happy to help if needed in
looking into any approach.

Thanks,
Mostafa

> 
> Thanks,
> Praan
