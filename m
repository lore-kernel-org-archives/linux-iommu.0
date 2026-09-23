Received: from mail-vs2-f27.google.com (mail-vs2-f27.google.com [74.125.227.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCE155198A
	for <iommu@lists.linux.dev>; Wed, 23 Sep 2026 15:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790176888; cv=none; b=Ec7B5PaUKaHtNlEQFC7cPh00JRJ/sUk+2+Jj0wY5pPpo74uW2eTStMoIg9uLboOkDmNSlppiSKObmS+aznSxaC9eDgsiWBDgeA98jhzoaI8j+CB6IPtdyNU8+MjM/18+r8p2kRlerH98gPa18w98oo2Yy6HqkJh4ubUbONQ8yjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790176888; c=relaxed/simple;
	bh=FuSi1oPqqK51hcEmla4NiGsVvsoifIYHIz4OYEHBKSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=blKFQYIYla29v+eNZCvLKasLk5CyQf4WEIcKw/jKU57vY+TRMowqnIrZe962n8aOgx1YVLJGnfKgZtpe2b5wLsgkhlz4XMgbik34+CJV2KsVSRvQiVVTQFXjx922MfEHluvAcF6v94LTxBI/rgTKpMc0DE09oruH4S+Nn1PvucE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=WazqBqdf; arc=none smtp.client-ip=74.125.227.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="WazqBqdf"
Received: by mail-vs2-f27.google.com with SMTP id 71dfb90a1353d-5c963d7503fso436416e0c.0
        for <iommu@lists.linux.dev>; Wed, 23 Sep 2026 08:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1790176885; x=1790781685; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SIwOLjI09a3UXj303jplkjBLREygxuyiG19PHUNbQ2o=;
        b=WazqBqdfOjk/1vFgMamnuTKMuLarB00T9YyDHGvpIbBBwMP/Wbp1cXAv3BO1k+E7kZ
         Ulz24RMyIhhlQx/hSj3wlqm7ZasPr3QR1AmfZITe6n6c7OBn3iw3PlA34KOLvHFyXXzQ
         76rlPDPOj6wDfYqEHypYpo+GsTxAnoBg5vGBIusxYNGAU/Wy13Up7LuJX5vaZ6+k9mPT
         BooQfKpwkY4PDn03NRvcCbSsAcPSrGa0gx+NueKR/bsLXn4UYj4bpPo2ifWjhfxRKnPS
         nMPVy7kNJs4/4LBoouR6Q9x0AMQ/9yRYBDrQEzNVombg+xJlF8EjlynRtBDPAVnZZRbi
         xxpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790176885; x=1790781685;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SIwOLjI09a3UXj303jplkjBLREygxuyiG19PHUNbQ2o=;
        b=TIOD5X5fsTjKHbP5RVSa/e93oinmNGNcX4IHZTq/X0QfSH53shslz3wFQmfXcl90+v
         3OC7VsvujjZPty5mDIm6n5qqcqXlQ86MsEseNC/4eb1xLHjZCHR6Ge1hn86LGyaxYiQx
         KMW1tqR9qD43Q5UewbDhfXS+2HCRNxsQyJNqXjYV6t5Ew3JZPfAkL2uVAh8RuHa4ga2j
         3BD7+/cOeFdglmrJwvRwvKvRNHtMggpbgb8ZvhIjwCHcebQ8ID101gfnV0EzHT+jGo62
         y9XVg9jF9GdJWH7vpykz3+c/auXeHS2G7NIldONIug8HltuNmMOLpv07koo8PrzdBPNp
         d8DA==
X-Forwarded-Encrypted: i=1; AKwUvBw5Ivc1a02wk/Jxek96mbakbcfxz8wHNglYRL0IxN0umySOduUxfbIIDDmAZyTh4xyNH85t8w==@lists.linux.dev
X-Gm-Message-State: AFuF++lFr3XFbWCPm6n+43WhZoppD+spMXM/GxFIWKAR9Pj/wGVfWnUe
	1u0+2ihlDsgOHsY4gOTTXTsVuWdogLf/hSWpEcj15vn3U23ZDF1NV1J0JVhelyDZoCE=
X-Gm-Gg: AYBFou3YZ9j9VKqtzzxYYKGhRwdbFYOSlrkLTq1OL8cn7/i45HzxuSIYnyXkIIh38Qv
	qNwkMUpp2z7gUMLP2B35EKfnXzzwjzNzRlUFElF7XfY8Zkg6vHLU4l8v/hmtfOL/wMx+sDvea3R
	SeRSDnQAyKm3W3mPC1LwH6h31M/JD+de/A8EnIHE/C23dzzLsKDfhxcYXvFVfqVbEduwJ1qxxny
	6GW5g3/Hp5d9vViStHB1cfyWZVVm3LwSIFeT68wwR7yXYXVMydTdSa6KAsZ7LI3fdy3YviyXwVm
	lC70Np3G4iAIG2BXy1811+ElJKCQwI0pPXu06jGDuIclc3EfWQfrLVi7R4fEdqukDdKeoO2E75N
	nToHjN7HyNnC14TGJ8KXYlBm29h+h2w2uhQh1iNaU5SmBgLJMwtIKG1EfID8ZCcqOAb8DNu7ZFQ
	cwjB7i/hLdtSdmRCsxpSGyz18/leMg/6uWsBEbicHKIYwV
X-Received: by 2002:a05:6122:4896:b0:5c9:a60d:22cc with SMTP id 71dfb90a1353d-5c9f16b9729mr3999503e0c.21.1790176885467;
        Wed, 23 Sep 2026 08:21:25 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c277636e4sm181224485a.41.2026.09.23.08.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 08:21:25 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1x9Omi-0000000DrJM-1RIj;
	Wed, 23 Sep 2026 12:21:24 -0300
Date: Wed, 23 Sep 2026 12:21:24 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, linux-coco@lists.linux.dev,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	Andrew Morton <akpm@linux-foundation.org>, christian.koenig@amd.com,
	Joerg Roedel <joro@8bytes.org>, Marc Zyngier <maz@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Steven Price <steven.price@arm.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Thomas Gleixner <tglx@kernel.org>, Will Deacon <will@kernel.org>,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	linux-media@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v7 02/13] mm: Add an allocator for CoCo shared memory
Message-ID: <20260923152124.GG1540250@ziepe.ca>
References: <20260921144847.501151-1-aneesh.kumar@kernel.org>
 <20260921144847.501151-3-aneesh.kumar@kernel.org>
 <arKsFofudnTYpXj1@arm.com>
 <yq5aik3w344o.fsf@kernel.org>
 <arOfD6syXOgQhZYA@arm.com>
 <yq5a5wzw2ree.fsf@kernel.org>
 <arOspFxWZ1DjgcAr@arm.com>
 <20260923130611.GF1540250@ziepe.ca>
 <yq5atsng10b2.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5atsng10b2.fsf@kernel.org>

On Wed, Sep 23, 2026 at 08:28:57PM +0530, Aneesh Kumar K.V wrote:

> I'm also considering requiring the address passed to cc_make_shared() to
> be in the linear map. This is currently required by both TDX and CCA,
> while AMD SNP appears to support vmalloc addresses. The only user of
> that vmalloc support is Hyper-V VMBus GPADL setup
> (vmbus_establish_gpadl()). How should the generic CoCo shared-memory
> allocator handle this?

vmbus_establish_gpadl() is the the same wrong abstraction as the arch
code. Get rid of it and use vmbus_establish_gpadl_caller_decrypted():

		pdata->recv_buf = vzalloc(RECV_BUFFER_SIZE);
		if (!pdata->recv_buf) {
			ret = -ENOMEM;
			goto fail_free_ring;
		}

		ret = vmbus_establish_gpadl(channel, pdata->recv_buf,
					    RECV_BUFFER_SIZE, &pdata->recv_gpadl);


So you made an allocator that returns folios, now you just need to
use that allocator to implement a kvzalloc wrapper. ARM can call vmap
on decrypted memory with pgprot_decrypted(), right?

Or maybe this can use vmbus_alloc_buffer(), it already does it.

Jason
