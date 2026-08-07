Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF81331200
	for <iommu@lists.linux.dev>; Fri,  7 Aug 2026 13:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786111098; cv=none; b=SeT1CuY5+NO364aJ0QrIzI+cpubEF8yPL1lWALvqOpjRQOHfy+0OcbrbiVuER6O/s0AV2DjPkG8I592CTO8G3WPaBnuqvJIEeR0F+tASc5JFGZWMOosdBsQq/BAXC8UJK11kbdN3BB80ItCN/ViI4LAdngaPxw8suNF4dVa/1xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786111098; c=relaxed/simple;
	bh=zrBhytxcXDNPG0MMxibBNcHjDvvuQV6t6BI7tYVRQPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hspDoDScLBP6Eql9TzThDpvWL15xTbu/rq7bJSdOO1J21g/Bruo7IFv5hqovIa7femhZHT+MzQuBHx9nvTaAXvUHt3f3cHKMvU54alESPZoooXsFclCEBtH+VOC1fg0CHMWenr52iIOqQkNU9gFkAUmJPLWhZR3QkbLF85SHPDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=RV6Ri2z1; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="RV6Ri2z1"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-92e5b048375so171950985a.1
        for <iommu@lists.linux.dev>; Fri, 07 Aug 2026 06:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1786111092; x=1786715892; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=i2ro1loNwbkACqpDIeM0PdgrbNZfsWDTHY6fPjx3IQg=;
        b=RV6Ri2z1nDWFk/0ToSMTdbWLqWID0I3F7D7EonNClVjgQTE+VpJxEe6CCvoDpRuDK3
         A1JsN5TqC4wOHI1yM75iorj6SRwWkl1+FNfyIV+fiWVvM5rs+pXqj6mPlGz/3ZZ1ikue
         I8BwCywNHkzLLZaKZ4kJk00Hql+n6d5oes6v2EourTZtq0Hr93ybPSYIzK7qMGGzJIRB
         gtCN5U8TvW0FB7f5x90JooINn01fAILKeNGQH8T8gsFVPXpBBjFsAvayExCk00ZMjyt/
         Abc75A+DicCWDAGnTEJ596GufoTUA7ShpNY7ZL+cu+nSOOTqo9Ti4+qpWKh6dvDrmfqS
         2ixg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786111092; x=1786715892;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i2ro1loNwbkACqpDIeM0PdgrbNZfsWDTHY6fPjx3IQg=;
        b=qsE2qKU7aZCrJwTjoMlEosEauHYQ7P1Nb+FHkTjiqBuGybXUr9FSa7KNl+6lOkN31n
         S7bH3ZlDcJLmJj/ar4KM1Zak3zZ0ngR4cwIj4Lv9H9kI6sRGwZyJD1545FCHf+ls3oFe
         A6TmHO+uW7rvgIULN7GWOH0qPOUURrAf5wQ1ZgqqfMCwctm9EDRvpT/OpAb4l7wv3iY5
         cLLrxSen5/eBOm+VTPwetNwS0Ks74YMjiMJpueJBUmlxBvb6lkkp8OSALWiH0FIMNkrn
         eE5uftyeu0YVqgvaQq0NSyTyfXQZlH27CfT9/5lp9yUMZc2rCWLU9p7uRK9atwL1GwqE
         G93g==
X-Forwarded-Encrypted: i=1; AHgh+RoSdZ++XDAR+G7j0/sPz2Bga222Y9fzOe3Ave8p1DVGnQ0+4yRvJ4WFaAHAFjPT0zm+rONShw==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywf69+b4joVdaJJD3WAoyLRcycSNhJrakLk/bCYY0Jv42LbytNl
	WvJ2+reQzh5TibyKSikugx+ouSdopTWjTTLoM4ULgWQo5mnKwjB+4J1sr8Ulomv/b08=
X-Gm-Gg: AR+sD11x9Qh8CKVk2JC9X15udPTWkvckbsfzMDHoV4CF/OYJRCJYi9Ga9WGcdX8/6am
	g0GXkVCKr5+Hr+4KYLx1uuJlOyJavMTU7fpe/TW4YkgQa1WmEnH6m72hy7y3P8Nn4ph05bloMo0
	BJF9gfgcIX1IJrSPwbna907XOQhN6xnQFfWT0tNlEhjlpdGOSJSNTmje+8tn1dcwmyG7QuifmPA
	B5YpOrp/JxXkOmVbB90mXAEvmOp3LUNbLi4PPZXeis0GA7pBtQHL+n4fYjRwLyeybHL55P0kYek
	D0pfaj2ltbK+bT2G+4FujOUBdO2mLw7HbHDD4U9SkPxSJELXC94yIxOA1rVSEfOTnpuz/FdrXyK
	DgvymSgm4bHOYbw3FofCGxQQ4jV3lxMtx8jJbzRdT84dhRXsi9dfuxhChRv01fVDjL86qtbJ0ZK
	F1NMef2dkmVHMWgrZ8S05kilBpM69MBR0qHiQA6w==
X-Received: by 2002:a05:620a:2725:b0:916:14f5:8866 with SMTP id af79cd13be357-936490191c4mr2577886985a.16.1786111092001;
        Fri, 07 Aug 2026 06:58:12 -0700 (PDT)
Received: from ziepe.ca ([142.166.156.215])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9366e2971d0sm152121785a.43.2026.08.07.06.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 06:58:11 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wsL5O-000000012Hc-2aob;
	Fri, 07 Aug 2026 10:58:10 -0300
Date: Fri, 7 Aug 2026 10:58:10 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Will Deacon <will@kernel.org>, Mostafa Saleh <smostafa@google.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Marc Zyngier <maz@kernel.org>, Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org
Subject: Re: [PATCH] arm64: swiotlb: Keep the default size for protected
 guests
Message-ID: <20260807135810.GA200537@ziepe.ca>
References: <20260717180442.110954-18-aneesh.kumar@kernel.org>
 <20260807092612.2202005-1-aneesh.kumar@kernel.org>
 <anXIZSh9lq99VG9X@willie-the-truck>
 <yq5acxvu2ict.fsf@kernel.org>
 <anXbJ2O4DWgPxCeg@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anXbJ2O4DWgPxCeg@willie-the-truck>

On Fri, Aug 07, 2026 at 02:18:31PM +0100, Will Deacon wrote:

> > I was under the impression that there is a possibility of using swiotlb
> > instead of restricted-dma-pool with pKVM.
> 
> Yes, that patch enables swiotlb as a possibility for protected guests
> but with your patch we avoid shrinking the swiotlb buffer even when
> restricted dma pools are being used and that's a waste of memory.

I also thought we switched pkvm to use CC-like swiotlb as part of the
alignment in this rework? Mostafa ?

> > If that is not the case, then we could change:
> > 
> > !cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) &&
> > 
> > to
> > 
> > !is_realm_world() &&
> 
> Perhaps, or you could just pass the swiotlb= option if the defaults don't
> work for you. Can you give more details about the slots exhaustion you're
> seeing under CCA?

We see badness with swiotlb too, it basically doesn't work out of the
box if you have to use it 100% for real devices. It easily runs out
of memory.

Auto tuning to higher levels makes sense to me, but I'd rather the
core code handled adjusting its size to the estimated need, not arch
code.

Jason
