Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77EFE44B66E
	for <iommu@lists.linux.dev>; Mon, 20 Jul 2026 17:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784569491; cv=none; b=bCpUjQnKChGoLBIYa+6A7rDXJ7mreYSNhpO4Ti7lAFiPTGVRZRCZOm7sqVOvb5C4OM8Am1+logEgU8+zYYAn1JrKcrEksV9qXBHH6qiPocXAJf+oXjBMKu2hghsFmpy0J2z2vT7xZAlf0x9nW8cD84pDUcW5pDdqnmb7LEZUzTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784569491; c=relaxed/simple;
	bh=eQwLG50FQTlGIaxFUWOZqCCOrmund6wJNcAiP3xOaXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pGlgH8adXoKYyeQaSgi8UZw/BWdYi7YqYG269TDbKFEF5ONUNFcPmUWhnE+yjVB/Wbp1AEqA3rV+InDZoYJhnnxM3p7oY/foBwbPrB6tx2cIt14FNoNiVAQAGLvGilm5xmc/cDRRBw4UMbJi34N4SKgi7rmxkWl4W7jVctSTx3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=L6oWXhYE; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="L6oWXhYE"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-51c21495722so73980121cf.3
        for <iommu@lists.linux.dev>; Mon, 20 Jul 2026 10:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1784569485; x=1785174285; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Fh0Ky+WC8JAb92VghcxhTRFBn6Go7CAcxa18f3039ho=;
        b=L6oWXhYEF36n0bRKPvz5emMmp9SD+Uhh8E0/vFw//BazCUTnEpGGWCp4OqxRSF4VD9
         THT+52xJwG8ehYSnJmhrtmoEFbc1mGyw/btYRxbg2idy1CfC8/o/D2LVCAAV6K+GvqNa
         ZO4D/s/BjOJw588c3gzwLho3/ERPNyGCe1+LuzjUhelnwFw9X243f1QDWQRb+oV0KCD4
         Bjep26TH1mTs1D74HCXPtp16gKhnqbcq3rTgDd/fYtzvsjooKxnXtbT+WmVrCFKAAFwu
         Ch4KjKmORvbssoRoZT1oQe1FumzKOm1a6LiHq+y5SGA1qubAe/+nRXDAwe8c6AszXy1L
         87Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784569485; x=1785174285;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Fh0Ky+WC8JAb92VghcxhTRFBn6Go7CAcxa18f3039ho=;
        b=N1KgbBGuZDyQ6FqXqAgnIgbU3/GdhJiZTBrbGnX1fbU4v3MLM2JRBad60zJdkpD6hL
         C9XbLPFmLULsHG/5xpH3SWkh/E7Mfuz2tz+YEdj7alApUyXcDyG3EBmyWJ5/qVX09TSV
         pDppct2hhM3jQDh/3MhNJh+t1kIrDY79TQOmT2tfLxd/K0U4yzy9BBL/2/6hIHF0kjdI
         dr0051G7LU7afGUbffCN0zASSg7OnXRuqEhr9sKcBVrUYWoYVk6w/ta1LSaAGNTt3/Uz
         fKf9WtTR3BZ4KaUGPK6gG1TU9/d3vLB6hDH1loebH/jETRynpOwdMwxamzMr7xA3+LZ4
         onng==
X-Forwarded-Encrypted: i=1; AHgh+RqDyrCaV0eTTW6Nt1RGWQn4tYPxeXMlnge9mYtnGWhg4sRsNr4SGxcUcZAOwpO5sqHUg5KHDg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxgHgPQvmLNBcqhKH4gHuNNXiz9VHkKT/UAANWl45fY8cnGxzLu
	gB2obPVUBekWKe9fG6GaO7Ibhb852/PjvMn2gjX3o/FCkA/nYyOu//vvw+cNw14/kOk=
X-Gm-Gg: AfdE7cnyK/Z+dvSZXxOgC6XYBwh2M0366vyj+qFp1ZTxTAomjwyPj8Xgo2kqxuqLq4c
	m31RjGHoC5cxvhtyfJd7utlo8Q2WrYNDnRbT/AOHbItPCV7WVww4yXjh53imFnqdTBu1uU9i99K
	m78AALfR+NSKMLZhi/NJlUmB9NtyqHGJB+HsR9zACxngZkRfXOmePZU4jcga8HM7gZyk3EwA0SA
	rCenr6zKjEKKa5u8KlDbgWlSlOel3TSuFLQiU+14AxKl7G401at3szRntAmJ327CBapYz6I9iW9
	M2pHLMupS47byPg9ymDIY933rtatXi77dkcV5EFpVHVtv7t/vO6XPokxGhRDSWQzMnAczwFIhWZ
	OU+yCHOfcCBFZWlGy1D9Sxs/6ZDFcBmRgwVxE/MsexVpoJnrFSNjJvDy9r3SvD2E7yVqPiyWSSQ
	tWkeFoxunvHXe3vT5M79+8b9od3I+DZT2kS1ARF1jQ0uBQjgMGpn2JCm5uGA==
X-Received: by 2002:a05:622a:1107:b0:51b:fddc:1de8 with SMTP id d75a77b69052e-5213e67e2c1mr141645811cf.65.1784569485065;
        Mon, 20 Jul 2026 10:44:45 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5214cda7dbfsm77462971cf.9.2026.07.20.10.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 10:44:44 -0700 (PDT)
Date: Mon, 20 Jul 2026 13:44:39 -0400
From: Gregory Price <gourry@gourry.net>
To: Brendan Jackman <jackmanb@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Byungchul Park <byungchul@sk.com>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Alistair Popple <apopple@nvidia.com>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, Baoquan He <baoquan.he@linux.dev>, 
	Barry Song <baohua@kernel.org>, Youngjun Park <youngjun.park@lge.com>, 
	"Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Huacai Chen <chenhuacai@kernel.org>, 
	WANG Xuerui <kernel@xen0n.name>, Thomas Gleixner <tglx@kernel.org>, Chuck Lever <cel@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	iommu@lists.linux.dev, loongarch@lists.linux.dev, linux-nfs@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH 3/3] mm: move __folio_alloc() to page_alloc.h
Message-ID: <al5eCOfvXR3OZjVi@gourry-fedora-PF4VCD3F>
References: <20260716-folio-alloc-cleanups-v1-0-5363b8e92d33@google.com>
 <20260716-folio-alloc-cleanups-v1-3-5363b8e92d33@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260716-folio-alloc-cleanups-v1-3-5363b8e92d33@google.com>

On Thu, Jul 16, 2026 at 02:30:12PM +0000, Brendan Jackman wrote:
> This is no longer used outside of mm so reduce the scope.
> 
> Ulterior motive for the move to mm/: A later patch will add an
> alloc_flags arg here.
> 

I have a similar commit that is coming in on my next private node rfc,
i'll reference this, but i wanted to make sure i hit a solid mm-new base
so sashiko picks it up and people can actually apply it.

> Signed-off-by: Brendan Jackman <jackmanb@google.com>

Reviewed-by:Gregory Price <gourry@gourry.net>

