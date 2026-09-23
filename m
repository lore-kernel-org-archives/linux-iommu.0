Received: from mail-oi2-f43.google.com (mail-oi2-f43.google.com [74.125.231.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3BD3E9C11
	for <iommu@lists.linux.dev>; Wed, 23 Sep 2026 17:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790184218; cv=none; b=YDfGNgt6B/1CG1VanDnEq8NQBfnMhnIx53OIoqCSduLeJI2+f9dEV9+WV6ZLm9yfszZKQJXyWPh+y+rUa9gxUJlr5qbwct9uwHghrecyUKpPawxb9ANNbL5qmtHlqjEamHKxW5wntuOnGI41kO+UHGBmwabo2yo0g284Bhz0ZE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790184218; c=relaxed/simple;
	bh=t2TgzO8nwUEwjRZhrCgeKf9S8CRIcvO43oc+9yu4/Wg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tbT8BO0eZbqbr3/TWBEX9aucTLlU3mLcppNCpqVphMD5yWH/PnGRt9PHv8m1sZuFeLtpETIp0qfCkR6alYQdKSqPrjZY4H0IKpQVkWnzw0cRbZELYQcjGEyBesANhvHuxAI9ZhfoVH6+E6xRPdBoAFv1f5DuRhaRaVeCvV4FlMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=hE2dl1v6; arc=none smtp.client-ip=74.125.231.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="hE2dl1v6"
Received: by mail-oi2-f43.google.com with SMTP id 46e09a7af769-7f4f0d1779dso1184333a34.2
        for <iommu@lists.linux.dev>; Wed, 23 Sep 2026 10:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1790184215; x=1790789015; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1FwE1NfmDw+YKo1XdhlQDW5TQG+slKv16o9ht1shLNo=;
        b=hE2dl1v64sBW4hN+w8ToHUQxd5ZFslsFvBlrjLpxrLWlLFxKBcIkZZ43WHFAIrmmQ7
         tv8y44em2oit2qQbX25Eny4uQ3kzMrj1sqm3NW4n/yBgSmxcqSSN/ixRDCGFVXtCuxPN
         4ptr+op5ywXvFUiZWDWP0UMD4E992f2UaGa2lI+dUe66XuRWTNSJPuhieAy7xOQad9+3
         61odtALkX3HNkDi89e2TCk6dSepJLZIM0wRAlQMwIRKWD6MuLx39X3iAZO2ip2goxkRN
         4dP/8Dwv00RcGgKMGiN00q/xZ5tHddTr+eJL7+U1lNx8O9/hYytSIxZVIJiq6Q8+xWCV
         r7KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790184215; x=1790789015;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1FwE1NfmDw+YKo1XdhlQDW5TQG+slKv16o9ht1shLNo=;
        b=euYpyPCRwQ1ibISX/OhuIMYnCXB5kRIp1cbd0MLhIKwtpdO92MRl02XslW4DFlVN07
         xgzwkhpT8JXzwvp8uklYiN0JYwLTNHev2E18OoqHEWs4mve5+T6GwubedSbumPV626KP
         EBRP7hiccm+N2H78JupfXIBIg9ZhdYNdKjiPs2iJAcO8gn+r5jloaRcrosLmdcHqZzV0
         UKKxEopmJSiS9XcCHg/DNFzVNgRKvHMcDo92YLl2YZD8PjN2h8JktPvlLkyDI8dUJt+y
         iG8LmHjqobxx0UNE/fS4ss+CKRe2x54PbZl2AYGz9B9pcIeXL6KR7+eAoCC1eeCshe6i
         zPkg==
X-Forwarded-Encrypted: i=1; AKwUvBwJJj2AYTSc4NFiV1sdOkUj+z7M5LgSUd22ABVhz6Xu7+eDGflOZ4fWix8fyjnUjng5agaz/g==@lists.linux.dev
X-Gm-Message-State: AFuF++nGnGd7+VV6zMOALQ5mwBut0dKGg5Hti/hexJ2w2a72wgj6s7Zv
	vUsbeLf4EHVijJ0e2JeadZxtNq5qkSgGXFdT5hrzLyoJgvYTOyRVBkXvM1ASnwHCxmw=
X-Gm-Gg: AYBFou2RZkjSlFPXVhYK11FW9pxBetNwloP+MZj6z6BUM3w6DX4YA1Hld9/rP1aIlsS
	PdIn0n+e8XnEAcl+oCYfWzHDz7TCozayBUXkuHEesXi0VH1Ko7E3m2w92KH8sdTbYEOf4MLunlB
	F4f7WUlEZ1xWWpKcYc+xt0FpuYu5tjPiaqJfN57NqYtiPTZZf0HWJ1syV0Mih7Ml/L9BUoKQFIO
	2bphfB+zmg4AdGQ1IFynwyMNICl40Qsz/QpOwaYmfYoYWc1rks3EGtT96iPqROWJ4dn3MQ6UPZp
	pXg34JCS+fS1yPFEDa2bTx2fCean/5HdRZ98cUGyX0bSRmWLvJU5hi3RngD/hEkIU6jKognEbkt
	f2ol+QMqEDpCsrpPLr0ZiUR260hxxQX8qdFHr5idcfxSwZlkRv4RsdeASYqv1BVsygsq8vLu362
	q6rDNNg0n3Y2AD6p20E3Ye5sRGRJgrf50qfvrBd0ALfNe0
X-Received: by 2002:a05:6808:1313:b0:4b5:5bfd:518f with SMTP id 5614622812f47-4d5b85af4d4mr3232472b6e.21.1790184214658;
        Wed, 23 Sep 2026 10:23:34 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4d5c522604asm2686648b6e.15.2026.09.23.10.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 10:23:34 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1x9Qgv-0000000E9nH-0xvE;
	Wed, 23 Sep 2026 14:23:33 -0300
Date: Wed, 23 Sep 2026 14:23:33 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Kameron Carr <kameroncarr@linux.microsoft.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, mhklinux@outlook.com,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-coco@lists.linux.dev, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, Andrew Morton <akpm@linux-foundation.org>,
	christian.koenig@amd.com, Joerg Roedel <joro@8bytes.org>,
	Marc Zyngier <maz@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Steven Price <steven.price@arm.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Thomas Gleixner <tglx@kernel.org>, Will Deacon <will@kernel.org>,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	linux-media@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v7 02/13] mm: Add an allocator for CoCo shared memory
Message-ID: <20260923172333.GM1540250@ziepe.ca>
References: <20260921144847.501151-3-aneesh.kumar@kernel.org>
 <arKsFofudnTYpXj1@arm.com>
 <yq5aik3w344o.fsf@kernel.org>
 <arOfD6syXOgQhZYA@arm.com>
 <yq5a5wzw2ree.fsf@kernel.org>
 <arOspFxWZ1DjgcAr@arm.com>
 <20260923130611.GF1540250@ziepe.ca>
 <yq5atsng10b2.fsf@kernel.org>
 <20260923152124.GG1540250@ziepe.ca>
 <5cbe0bde-47d8-41ca-b244-bc0329d0d066@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5cbe0bde-47d8-41ca-b244-bc0329d0d066@linux.microsoft.com>

On Wed, Sep 23, 2026 at 09:28:54AM -0700, Kameron Carr wrote:
> On 9/23/2026 8:21 AM, Jason Gunthorpe wrote:
> > On Wed, Sep 23, 2026 at 08:28:57PM +0530, Aneesh Kumar K.V wrote:
> > 
> >> I'm also considering requiring the address passed to cc_make_shared() to
> >> be in the linear map. This is currently required by both TDX and CCA,
> >> while AMD SNP appears to support vmalloc addresses. The only user of
> >> that vmalloc support is Hyper-V VMBus GPADL setup
> >> (vmbus_establish_gpadl()). How should the generic CoCo shared-memory
> >> allocator handle this?
> > 
> > vmbus_establish_gpadl() is the the same wrong abstraction as the arch
> > code. Get rid of it and use vmbus_establish_gpadl_caller_decrypted():
> > 
> > 		pdata->recv_buf = vzalloc(RECV_BUFFER_SIZE);
> > 		if (!pdata->recv_buf) {
> > 			ret = -ENOMEM;
> > 			goto fail_free_ring;
> > 		}
> > 
> > 		ret = vmbus_establish_gpadl(channel, pdata->recv_buf,
> > 					    RECV_BUFFER_SIZE, &pdata->recv_gpadl);
> > 
> > 
> > So you made an allocator that returns folios, now you just need to
> > use that allocator to implement a kvzalloc wrapper. ARM can call vmap
> > on decrypted memory with pgprot_decrypted(), right?
> > 
> > Or maybe this can use vmbus_alloc_buffer(), it already does it.
> 
> Michael Kelley recently proposed [1] moving all ring buffer allocations
> to use vmbus_alloc_buffer(). If we move forward with this, it should
> remove the dependency on vmalloc support.

Even better vmbus_alloc_buffer() can use the new allocator API
directly so it doesn't need to open code the set_memory_decrypted arch
call.

Lets do it!

Jaon
