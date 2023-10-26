Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA74B623;
	Thu, 26 Oct 2023 07:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="tapF8GD3"
Received: from 8bytes.org (p4ffe149c.dip0.t-ipconnect.de [79.254.20.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 566D31A663A;
	Thu, 26 Oct 2023 09:49:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1698306576;
	bh=i7ZjTaBmY1sC5SUeWRmnofKfHXCddva3S4eBDSTodEI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tapF8GD3HQ4Wed+B8GY/o/P+rrAMU17bExhQfh5suz7bCpESnVowO8oj8tfRZLkY5
	 QY6bUj36IjXcP15wP+t+yDnAVIgUHyKNSQxO/+jw8Krv/k3+x13d1Y27P6OSuip7Ki
	 QiGbrf54L3YpZyNtzS0qHccWTQ5vKmdgBKV9mCqJCeEk1FKDxnDdXQe2BARVDzlYl3
	 likKrGSVp2safmT1DtwkR1HF6vkRD/g/bE0FSsiFmvxbOGsCwVca5ABLsBNLOLlTiJ
	 iq7tQrQ8xvNUPwFfiRS3VaneSJXyAyQsOkpn/UDih1ZEYR/XwwXZy5hwjE/MTVxkpR
	 kaehl2RRKF1ow==
Date: Thu, 26 Oct 2023 09:49:35 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>, asahi@lists.linux.dev,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux.dev,
	Kevin Tian <kevin.tian@intel.com>,
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	Hector Martin <marcan@marcan.st>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Sven Peter <sven@svenpeter.dev>, Will Deacon <will@kernel.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Janne Grunau <j@jannau.net>
Subject: Re: [PATCH v2 0/9] iommu: Convert dart & iommufd to the new
 domain_alloc_paging()
Message-ID: <ZToaD1tuNJ7tra-g@8bytes.org>
References: <0-v2-bff223cf6409+282-dart_paging_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0-v2-bff223cf6409+282-dart_paging_jgg@nvidia.com>

On Wed, Sep 27, 2023 at 08:47:30PM -0300, Jason Gunthorpe wrote:
> Jason Gunthorpe (9):
>   iommu: Move IOMMU_DOMAIN_BLOCKED global statics to ops->blocked_domain
>   iommu/vt-d: Update the definition of the blocking domain
>   iommu/vt-d: Use ops->blocked_domain
>   iommufd: Convert to alloc_domain_paging()

Applied these 4, the dart patches need reviewed-by/tested-by/acked-by
from one of the Dart maintainers.

Regards,

	Joerg
