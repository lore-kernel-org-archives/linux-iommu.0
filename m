Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FC8749C
	for <iommu@lists.linux.dev>; Thu, 22 Feb 2024 00:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708561317; cv=none; b=S6SHo3ydT2/1w0i5pIeZZ02vTmQTc0twY8BU1eEQccZKc3JyXkVgGrgui3vprtSb7Vdho7eLzSKUF1DOs53eKfCZjP2ORlPTplSRY/x8mouF/V7+bNXQqIJN5ot3RTea2NikQcP1tgBBa9jiQkXJEmSDzu9oaHqCM9hKwJ15Qgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708561317; c=relaxed/simple;
	bh=ULWx7GnGcbkzH+Hk8ucwqEKl61im90Y5FaAmJnZtJAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VKJJO7SddpjYqf7be5D6TL5wBU5XV3lZ/pk2dvYlG/p4T1WUDnJ/PduyS6YJsb728jfOg2Rj4+11T6FiMsOqOf92nz5bcb5nA1a8JHo/UaQ6VxLOL2ZgYHpIgyv1AfjcPcatnhkjL1fQLjzE+3HvIyOoi7zizNeTquOQrR/OeWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=d84pulH1; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="d84pulH1"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-68009cb4669so35256546d6.1
        for <iommu@lists.linux.dev>; Wed, 21 Feb 2024 16:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1708561314; x=1709166114; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9rn4mWdOER6tRcIB1iLpkedD4oyQHhFAy8BqoLay5HA=;
        b=d84pulH1VExJKmqpZJ68MruR2+6LZCZtLsQPZ6VKNdEjur2urx1YSSTSxU/oBsnncH
         QIepOGAXAK2/yZjTSsQIEhSUeC5hT4mWBXc+pcDvFpdwMvtCkox+5JPAVZzwx1Gl1udt
         hDVzphJ4e5uBeIIYXR9D2KOi68Xo4+BTeHIx03UeLoTLwnX0ptKxXYr27x+sxdO6oPMY
         pFIdypVefEQbWZuCRGI1NWX4brF2qBmMGWKctCdQ1d/GKr7GLHBIJ0iWSWVgG2UdrUjN
         TGxotFGDtZ7bQID2yxGCFeWXfZXnTN1cLXUhQ/pQYanXI4YcSq+Z+RhNkgUGN4vKM7Rj
         wzaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708561314; x=1709166114;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9rn4mWdOER6tRcIB1iLpkedD4oyQHhFAy8BqoLay5HA=;
        b=F7NpNnZ1ByyjeC/VGKyazdjhE0K/25nURnjMQUjHFCdy0hmGCMuw0A0/PrzEGlGEtF
         i9feA7gxiVDMgYZ6lWdCe7XHnCgOVFS10hCXRmsjtLeHCO4bE8wBNfx5VaSgdJjkGEwF
         U2fGswoczKm7+WSh3wczJjiYrlNf26nSiLdCiOZIB0jS3EalgA90aKyVdYYrGTA8/rpd
         ZkvqBgxjHeuokdXQx1VIZFU7r9+yKIXxnKgSmJAkt551j1dT1SWVnrb+6CZqfUYCkxxd
         LA7z4tsFqlz9mK1P1rph57zkURCajPybeABksdmFo9QGyOsYSSfqBQchgz8V9hE7S9x7
         61Zg==
X-Forwarded-Encrypted: i=1; AJvYcCWwNyWcAmDYyvo7oVsDH4dvUdL224U5KRDYq4T8lrDwUBa5u+O22unaYkbwnaM0+ehbEqgIKmhjFx2rti/ExoAvgqjHx6A=
X-Gm-Message-State: AOJu0YyXQwxz4Ez7TfDPZwel4u3KFwEKMJ2bGHac2QdSwMO48VMCnGD+
	qt5q+A8y+4KXdfyvuGhc4KIBr47+3djgqdynMoUrn+M6MB03PnwAO7vjjqsCquM=
X-Google-Smtp-Source: AGHT+IGSJoZu17XCLPx2AJSIv4qmgm+x+WexJaUrwx1qRLzsVh+X4k/87Gsnxjx0m8GySXbzSbUfyw==
X-Received: by 2002:ad4:5ce3:0:b0:68f:8d7c:73cd with SMTP id iv3-20020ad45ce3000000b0068f8d7c73cdmr10367841qvb.8.1708561314072;
        Wed, 21 Feb 2024 16:21:54 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id lb25-20020a056214319900b0068f9bb1a247sm1871280qvb.19.2024.02.21.16.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 16:21:53 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rcwqW-00DQWC-Tn;
	Wed, 21 Feb 2024 20:21:52 -0400
Date: Wed, 21 Feb 2024 20:21:52 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Will Deacon <will@kernel.org>, akpm@linux-foundation.org,
	alim.akhtar@samsung.com, alyssa@rosenzweig.io,
	asahi@lists.linux.dev, baolu.lu@linux.intel.com,
	bhelgaas@google.com, cgroups@vger.kernel.org, corbet@lwn.net,
	david@redhat.com, dwmw2@infradead.org, hannes@cmpxchg.org,
	heiko@sntech.de, iommu@lists.linux.dev, jernej.skrabec@gmail.com,
	jonathanh@nvidia.com, joro@8bytes.org,
	krzysztof.kozlowski@linaro.org, linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-rockchip@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-sunxi@lists.linux.dev,
	linux-tegra@vger.kernel.org, lizefan.x@bytedance.com,
	marcan@marcan.st, mhiramat@kernel.org, m.szyprowski@samsung.com,
	paulmck@kernel.org, rdunlap@infradead.org, robin.murphy@arm.com,
	samuel@sholland.org, suravee.suthikulpanit@amd.com,
	sven@svenpeter.dev, thierry.reding@gmail.com, tj@kernel.org,
	tomas.mudrunka@gmail.com, vdumpa@nvidia.com, wens@csie.org,
	yu-cheng.yu@intel.com, rientjes@google.com
Subject: Re: [PATCH v3 10/10] iommu: account IOMMU allocated memory
Message-ID: <20240222002152.GG13491@ziepe.ca>
References: <20231226200205.562565-1-pasha.tatashin@soleen.com>
 <20231226200205.562565-11-pasha.tatashin@soleen.com>
 <20240213131210.GA28926@willie-the-truck>
 <CA+CK2bB4Z+z8tocO79AdsAy+gmN_4aVHgFUsm_gYLUJ2zV1A6A@mail.gmail.com>
 <20240216175752.GB2374@willie-the-truck>
 <CA+CK2bDURTkZFo9uE9Bgfrz-NwgXqo4SAzLOW6Jb35M+eqUEaA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+CK2bDURTkZFo9uE9Bgfrz-NwgXqo4SAzLOW6Jb35M+eqUEaA@mail.gmail.com>

On Fri, Feb 16, 2024 at 02:48:00PM -0500, Pasha Tatashin wrote:
> On Fri, Feb 16, 2024 at 12:58 PM Will Deacon <will@kernel.org> wrote:
> >
> > On Tue, Feb 13, 2024 at 10:44:53AM -0500, Pasha Tatashin wrote:
> > > > >  SecPageTables
> > > > > -              Memory consumed by secondary page tables, this currently
> > > > > -              currently includes KVM mmu allocations on x86 and arm64.
> > > > > +              Memory consumed by secondary page tables, this currently includes
> > > > > +              KVM mmu and IOMMU allocations on x86 and arm64.
> > >
> > > Hi Will,
> > >
> > > > While I can see the value in this for IOMMU mappings managed by VFIO,
> > > > doesn't this end up conflating that with the normal case of DMA domains?
> > > > For systems that e.g. rely on an IOMMU for functional host DMA, it seems
> > > > wrong to subject that to accounting constraints.
> > >
> > > The accounting constraints are only applicable when GFP_KERNEL_ACCOUNT
> > > is passed to the iommu mapping functions. We do that from the vfio,
> > > iommufd, and vhost. Without this flag, the memory useage is reported
> > > in /proc/meminfo as part of  SecPageTables field, but not constrained
> > > in cgroup.
> >
> > Thanks, Pasha, that explanation makes sense. I still find it bizarre to
> > include IOMMU allocations from the DMA API in SecPageTables though, and
> > I worry that it will confuse people who are using that metric as a way
> > to get a feeling for how much memory is being used by KVM's secondary
> > page-tables. As an extreme example, having a non-zero SecPageTables count
> > without KVM even compiled in is pretty bizarre.
> 
> I agree; I also prefer a new field in /proc/meminfo named
> 'IOMMUPageTables'. This is what I proposed at LPC, but I was asked to
> reuse the existing 'SecPageTables' field instead. The rationale was
> that 'secondary' implies not only KVM page tables, but any other
> non-regular page tables.

Right, SeanC mentioned that the purpose of SecPageTables was to
capture all non-mm page table radix allocations.

> I would appreciate the opinion of IOMMU maintainers on this: is it
> preferable to bundle the information with 'SecPageTables' or maintain
> a separate field?

I think you should keep them together. I don't think we should be
introducing new counters, in general.

Detailed memory profile should come from some kind of more dynamic and
universal scheme. Hopefully that other giant thread about profiling
will reach some conclusion.

Jason
