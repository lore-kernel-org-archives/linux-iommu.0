Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A393B0AC2
	for <iommu@lists.linux.dev>; Thu, 23 Apr 2026 18:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776969827; cv=none; b=oiSjd9cmckYC/mNq8rQZQqU/eDHY6wHUs/ta6ZKc53r2gePzRbRMQ1uzWiuqPXZkgBwKAmml9CHsdHYi/6v6mTvCcjCQKl/2gPtZK67pNdY+ZFQJUOa9Ur48LF5jMpqaEiPOsT/dpAWtSabiYJOz/FiDMlT0515jPt5jwJ3THI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776969827; c=relaxed/simple;
	bh=0Lc2Z4djP+OFSIRCIs7YQs/PaAF5gbi+2NFb1IXfdPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OJ084y4Xa3dFMwjq3n1RbGnOsGyjSZlc0smD8IFCXeNGdnwLWkeK+em6gyGUiFGBJS1Z8cXpu/MFo8bK7klbTyn8QC1/fR6RvcRjY1YDrbAzgCl7bzhxs8CzUO2iKfysetkrPl8SK5NZ9maus9rUO46r0QPUmD7e54VaAiY0jWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gXCWyxqi; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gXCWyxqi"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2b46da8c48eso152695ad.1
        for <iommu@lists.linux.dev>; Thu, 23 Apr 2026 11:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776969825; x=1777574625; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0Lc2Z4djP+OFSIRCIs7YQs/PaAF5gbi+2NFb1IXfdPM=;
        b=gXCWyxqikyvHOiqO50W9DDUxiZWerqT7bbKsEz+D6Zrj1x9K3+AzzsXUUCLKL8uat5
         8EPtx5yzB6ApQKW73E7O9AKAskLHwEA8PfuuquAJktzpIiKlQqpYOcbhhycOfxRyOYeP
         qD1RhLWuWc4JJt+mOjIyPNABkgTd6ij0Ooqcf4JhveXg3okCg5AHAmwjXKkGVq5hcpqh
         rcvHOmDC1t0mhp6XoBxn9n8dwV3BIHL6e2zArX/NlgyGg39OJx+i9kAHo2fhU6mGdoUw
         V0VrkyX3SnUg5wc+JQr/MYtiLKaucHg1mT/ArdI0MiULNIVPK6cFywZuklEVu+5GkmXD
         YpDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776969825; x=1777574625;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Lc2Z4djP+OFSIRCIs7YQs/PaAF5gbi+2NFb1IXfdPM=;
        b=NNsf/4fvULbjCl59M4tls90dBzGgqSQdJYFPZN6PtbpwPlldR6+DeyqNbEdD1fRo0I
         DLbP60WbPYeU5F4/i4LVfBtEkNEQ9e43B2Y2cPnv+y7Ucg+N1Az5GqWZQHe/QAe49ucH
         ZixO5hkxG4CISVFvsuYhHdTTS4KnQyz7p7RHnOS0i4Yl2t1aFJIUffCVEKOZGC2SniSX
         4eib8Sj+9fenkkXz5IHhcXsx6cQP2mmLRKJMCxKs6/w3rutMY7J1suq9uetzNp4ZJHO9
         NVQB6XqI8qSbnqe5G3W7E0bdaD4+VtDbWvOGjDObfAy1ift1iVwkHJCr2P0wkGHXTe4D
         5YOA==
X-Forwarded-Encrypted: i=1; AFNElJ8biPNQiqO6upv/xCUEMUO9GQH7UfTKIDOxjikfzWrzDxFS7T6Ufl4WMDFcyongKTOYGqr81Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx5h7uDtdCd6AHW++D6Y56setZUCdTwchGGj8h06PYIDiTEnO2H
	y48rTNZBVU3Ctzap7f6iXRWfusYGAkUj4sHZ20rJq4PYFP6vgXEdABIRydkKD81ybQ==
X-Gm-Gg: AeBDieuYoDXoCihNXp9ARKeGEj0omCr0J9ICEVGIIT+ZKar7fBBp8rWM6i664vBcpAg
	Y9q7pOGq/2YX26Iigbk5jMXoHx08g+cEthEiWWzw2ugwFh1HQX4tRPmATRhMHqVL7qq4awCpOkv
	eFlQXyj89Z9K7K+IDi8DQsVFf6RHMnpg4Fu5rs1k1QifYRQE6sb8CjQYh2ue2kXIO5XKeGyjA8f
	rSXQ9vbKHtgBkUhod2ZNY82V4bA5zWOz3gA8G58DVNiY1Mz0bB/MNzE0fYANkJhytIv498rTKmm
	KXyhp+R5Ersz75kkXDZZmq3tgD5m4m+o7uz+Oe/Z5alNaTAEPb9S8KCvDq+ewPEG5kQ4hi4jb22
	+RLlbQgaDWEbWhfqIkCp+3OOGxoEEaMolsaQpvMRSjl2mRMjHyiQBfsOopYpYkprWXGUfSDn8aa
	6+8an8OB165PcmXfQ1Bmp+zHeiD1pBjlBrwimuniNJDBsB7mIWAnRJraY4vK+rD1mH00UVbzCLe
	yIRWea3bA8=
X-Received: by 2002:a17:902:ef52:b0:2b0:d1f4:f601 with SMTP id d9443c01a7336-2b603f688efmr1861455ad.15.1776969824338;
        Thu, 23 Apr 2026 11:43:44 -0700 (PDT)
Received: from google.com (195.236.83.34.bc.googleusercontent.com. [34.83.236.195])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3614195a9f0sm20471832a91.9.2026.04.23.11.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 11:43:42 -0700 (PDT)
Date: Thu, 23 Apr 2026 18:43:37 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Will Deacon <will@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, 
	Evangelos Petrongonas <epetron@amazon.de>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, Nicolin Chen <nicolinc@nvidia.com>, 
	Pranjal Shrivastava <praan@google.com>, Lu Baolu <baolu.lu@linux.intel.com>, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	nh-open-source@amazon.com, Zeev Zilberman <zeev@amazon.com>, dmatlack@google.com, 
	pasha.tatashin@soleen.com
Subject: Re: [PATCH] iommu/arm-smmu-v3: Allow disabling Stage 1 translation
Message-ID: <aepfYzkI7NsVGCF0@google.com>
References: <20260420123221.20801-1-epetron@amazon.de>
 <20260420124032.GO2577880@ziepe.ca>
 <20260422064431.GA49867@dev-dsk-epetron-1c-1d4d9719.eu-west-1.amazon.com>
 <20260422162351.GK3611611@ziepe.ca>
 <aenp6FHzx9rtUQkZ@willie-the-truck>
 <aenqxasLJ8yKYqbT@willie-the-truck>
 <20260423142326.GP3611611@ziepe.ca>
 <aepRy7Gp7Ng85Zr7@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aepRy7Gp7Ng85Zr7@willie-the-truck>

On Thu, Apr 23, 2026 at 06:07:23PM +0100, Will Deacon wrote:
>On Thu, Apr 23, 2026 at 11:23:26AM -0300, Jason Gunthorpe wrote:
>> On Thu, Apr 23, 2026 at 10:47:49AM +0100, Will Deacon wrote:
>> > > Does iommu-pages provide a mechanism to map the memory as non-cacheable
>> > > if the SMMU isn't coherent?
>>
>> No, it has to use CMOs today.
>>
>> It looks like all the stuff dma_alloc_coherent does to make a
>> non-cached mapping are pretty arch specific. I don't know if there is
>> a way we could make more general code get a struct page into an
>> uncached KVA and meet all the arch rules?
>>
>> I also think dma_alloc_coherent is far to complex, with pools and
>> more, to support KHO.

Agreed. dma_alloc_* is too complex with pools, CMAs and what not to
support fully in KHO.
>
>I wonder if there's scope for supporting just some subset of it?

We have been experimenting with something like this. We have a usecase
where memory needs to be preserved but we want to avoid invasive changes
in the driver.

If it's not a crazy idea, maybe we can start with a very limited scope
of providing preservation for a subset of allocations done through the
DMA API? I can send out my proof of concept as an RFC after I'm done
with the next revision of my IOMMU persistence series. WDYT?

Sami
