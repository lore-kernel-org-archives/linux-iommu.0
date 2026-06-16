Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DAB3955EE
	for <iommu@lists.linux.dev>; Tue, 16 Jun 2026 21:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781646027; cv=none; b=PS4PmdPDCPqc7GDmnDFQNVE+D5RocTovoUuFqKsKtEr84/192KMr6AhTsmGMipCdJmcCf6j6j0FQJFpqt7BDBlEGBhoQVRc84LO0Q73zph55B2BQ6rSBxMg/gmrkRzRP2kKXKogQWF6PrsWPRePEVJ/wdTUNfJlRYqY8cWwuDIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781646027; c=relaxed/simple;
	bh=cf38p7/480zhJLlTa5tSMMqpYgTmy8ye4F4mLRnk9e8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VBy77JFBW3D5PMUGL5n7KM4ETI9w7/6Vwtvfjcbtg3/IWzSXBpC8ttwTnhLE/ow4d3EpD04ShM7gTzuIP7TQgGi863LC+qlfkCyDqLXBfgWimRMpIJmIJwo4ZMhh0lUZC9uuiy/7iEYaZfhMqfswLV0QFos+ddXQzuV6jbd0IyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PmJN1T3w; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PmJN1T3w"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2c69fa0b1f8so21955ad.0
        for <iommu@lists.linux.dev>; Tue, 16 Jun 2026 14:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781646026; x=1782250826; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NTvGNCNlXhAU22YZdcNpEpd5dGKKVfzL8A+xoJlmFiY=;
        b=PmJN1T3wQuju2dVT0o2n6wADLzOzBaSeTc0F468G6wtqLucxbQVJbzdu+6jCWmO3HT
         0z/eBsREQ6/rPC/YmDF90TRXEO7T8LuZVeYXYAsB8uYkMCxCwiS1c715UMtrbt2uhoFZ
         D/6sMzoh0hK/1wGIEttpgUKJNwdSTOXeOv2QyuqbyaBiXdxNRvW1lHbDhkpJQHUNiFRq
         /jJFkglKsPxJ8fB6wLW4YhD0dgTuCpx0QOWFIrRU9vokDuwtbHJcLwbf5zRZLtdPTH0m
         4eUNqYs2BIPUv/2fVDMYzwtIJiqGxVQ5uB9WxSgg8DuXMmvrlpkf7R5GY91952nTjDIA
         3yEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781646026; x=1782250826;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NTvGNCNlXhAU22YZdcNpEpd5dGKKVfzL8A+xoJlmFiY=;
        b=aFv+IjOPmz1XeNtW/DER0BupEC2+Xg1FCvB5kC/soNnDoiNJOgIhUAAuFH425+xUaD
         giAqKo0Kga4u+dsgBqKISl8P+Agg1aTYoXPnvNYLLLYnR97MgSGW71JmfoI46FC/9NTp
         Af0jiBzaTl/h0vkp1QBkKvkXpAmZC/w7zA7UITRcBmdTWGlYup+lD0HBa5EZhP5wZQ0F
         N/lAxanAXpG+p21WH6Br+r7XzaSCo/rCO7uQPOWi5fWk0YnnioJz1h/e1aJ7haYcMK/5
         hqAoFJob9NC6gwp6LlIRbx/aBVbC2nPOSQbHGcBj9kZrfWus6vcYvz/NVdpZHzymYGh3
         N+sQ==
X-Forwarded-Encrypted: i=1; AFNElJ9YqqhXj8NvRpewbmg7zwm56SneSw5euX18lpOioApqsEbSPWlTkzFGFZv+v1qmYyMR2H45Gw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwtXWCWVZZww2x2R1E9ejCgBZ8IavfClkt7JdQ+yo8HOUnAa/uf
	0t6DwChHXLR/macsaYqpEXdHbAiXSjBziCnQSnR0giG6Ms+MkCb5h4V+4tzyIREaWw==
X-Gm-Gg: AfdE7cl2rZ3w7A4FU32SVpg18xZWE8Zt8H5bjV9+C8l/uMDGoci1Ts5MAppO3Qxb9VY
	beOaCCAtX/rQUFesCjN1jrbf2LtFIr2mb7HtBanyAuX/yp/S9Ks9U0a0ZtzhlVDA5Zg4O8lbQ/9
	dTIX23CMfeZyyesubSVBkjtQEOJ6iCzK4VtU7gyEQ3RVnb0aGv8lHEs4xcmi/ynNA7fCriIJQ8I
	HXU3UfBm13sHCAhe29xcDz4Qlg6fidxAhlqZ9FG1nxS5dwKwthVH7jOln26yTR40b7GrMzEeO5M
	ioFfq38GlESDxK43HhTDEc0x0DJfr+88KT+AbrB5c4t5HHOmQbV9qIjR77WpnKbLMpAia6VfO2k
	zCkC/3vsE+A1K/+Glh31D2ZvCNPbD0mk7efrfSMeuyRaLr/YqjdFUhjmyFNfvYPtFmz3myUvxfr
	eG5vx1gnFM1UDmMLtrXRF/GQPKi3GurOvg/5ym7HVU7Q8UbdTYWLXoo3xTlOY3
X-Received: by 2002:a17:902:da82:b0:2bd:7bec:f0e6 with SMTP id d9443c01a7336-2c6bd35a632mr428915ad.1.1781646025596;
        Tue, 16 Jun 2026 14:40:25 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c42f1f0f31sm139126615ad.2.2026.06.16.14.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 14:40:25 -0700 (PDT)
Date: Tue, 16 Jun 2026 21:40:18 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Alex Williamson <alex@shazbot.org>, Joerg Roedel <joro@8bytes.org>,
	Mostafa Saleh <smostafa@google.com>,
	David Matlack <dmatlack@google.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
	Baolu Lu <baolu.lu@linux.intel.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>, skhawaja@google.com,
	pasha.tatashin@soleen.com, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v9 4/6] iommufd: Add an ioctl to query PA from IOVA for
 noiommu mode
Message-ID: <ajHCwqHUcWl2dqCF@google.com>
References: <20260611172658.3421138-1-jacob.pan@linux.microsoft.com>
 <20260611172658.3421138-5-jacob.pan@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611172658.3421138-5-jacob.pan@linux.microsoft.com>

On Thu, Jun 11, 2026 at 10:26:56AM -0700, Jacob Pan wrote:
> To support no-IOMMU mode where userspace drivers perform unsafe DMA
> using physical addresses, introduce a new API to retrieve the
> physical address of a user-allocated DMA buffer that has been mapped to
> an IOVA via IOMMU_IOAS_MAP. The mapping is backed by SW-only I/O page
> tables maintained by the GENERIC_PT framework.
> 
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Co-developed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
