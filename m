Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA77B64D
	for <iommu@lists.linux.dev>; Fri, 27 Oct 2023 07:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="Y1KIJPTA"
Received: from 8bytes.org (p4ffe149c.dip0.t-ipconnect.de [79.254.20.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id AED201A55A7;
	Fri, 27 Oct 2023 09:12:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1698390725;
	bh=fnEddc84wKlKs4bN2NS+++YG0UQjdLnpekj2LzCOah0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y1KIJPTAM1c60H1OtbNcgkyZJ5Yccbtkfyy/5i9+AXNxTQzSzShENsCCiuWbAtqkj
	 1Gk8LA3o9+wt3pzqsGZA48EuwdN6BYHOApYfmrFB9t0Jj9QX9o0i2vUjx64Fjh6fuJ
	 W34BXp/JZUURZAeICk22PKjbd+swrakeH6tNdBlGxu48C40BXblqevpvho3O4i6o7P
	 rfx2Bi+OXTJL0pledqlpNdj/X6lV8xkfYQvO/t+VP/XWJK+lOpVHbI95RDFjE8tnPF
	 /zHpHdpaBnnw8s8IZqo8Cv/KD8DIcUgBMjhXq2yO21pGzv8GlNwMTryrmGgvA8vBeR
	 6WXJnVz+2plww==
Date: Fri, 27 Oct 2023 09:12:04 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Tina Zhang <tina.zhang@intel.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Michael Shavit <mshavit@google.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v10 1/6] iommu: Change kconfig around IOMMU_SVA
Message-ID: <ZTtixEgSkBI-TRro@8bytes.org>
References: <20231027000525.1278806-1-tina.zhang@intel.com>
 <20231027000525.1278806-2-tina.zhang@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027000525.1278806-2-tina.zhang@intel.com>

Hi Tina,

On Fri, Oct 27, 2023 at 08:05:20AM +0800, Tina Zhang wrote:
> From: Jason Gunthorpe <jgg@nvidia.com>
> 
> Linus suggested that the kconfig here is confusing:

While this patch looks decent to me, you forgot to Cc Linus on it. In
general, given that it touches a couple of core files, I'd like to wait
for some more people to have a look at it and not rushing anything in.
> 
> https://lore.kernel.org/all/CAHk-=wgUiAtiszwseM1p2fCJ+sC4XWQ+YN4TanFhUgvUqjr9Xw@mail.gmail.com/
> 
> Let's break it into three kconfigs controlling distinct things:
> 
>  - CONFIG_IOMMU_MM_DATA controls if the mm_struct has the additional
>    fields for the IOMMU. Currently only PASID, but later patches store
>    a struct iommu_mm_data *
> 
>  - CONFIG_ARCH_HAS_CPU_PASID controls if the arch needs the scheduling bit
>    for keeping track of the ENQCMD instruction. x86 will select this if
>    IOMMU_SVA is enabled
> 
>  - IOMMU_SVA controls if the IOMMU core compiles in the SVA support code
>    for iommu driver use and the IOMMU exported API
> 
> This way ARM will not enable CONFIG_ARCH_HAS_CPU_PASID
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

If you send it, you also need to add your Signed-off-by.

Regards,

	Joerg
