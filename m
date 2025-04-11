Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DBEF1EFF93
	for <iommu@lists.linux.dev>; Fri, 11 Apr 2025 10:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744367932; cv=none; b=IfZozAyn5zk2YMr/e2UpCJT2RSofVHznAqWSjMBxkFqx9B3f9Jm+d7+QdXC0ee7iODM4JqAINdle/8IXqENi6nyx69FfSDMIL+q664YUVzPOQ6fYkm4dQuqV4oK6tl7BPu1hR+gbkqYeAidyUhkaylvDSbPqntGmg4fcYL3xXk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744367932; c=relaxed/simple;
	bh=xJvAKjiJHJHSQO2CoKVV4iRVjWsPCO6VX+gjfPZQS60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rg/5sMhRmLLznNSWK9p4ssshtFSwH1hqHHPMI0qjWwsZx6tGKLsVwEfgzwUTnsgBYj4yIvgV/uVJ3Vd4i9+q7fMHgsbz4TuKzuFhAGpmvXqF/ebZOw88MRvDgDR2uAL8bBdF4A2d1MQlYZP5sfMWYDv+SXUagWXJFubyau1EUmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=CQOBRZ5e; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="CQOBRZ5e"
Received: from 8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 091A247AD4;
	Fri, 11 Apr 2025 12:38:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1744367923;
	bh=xJvAKjiJHJHSQO2CoKVV4iRVjWsPCO6VX+gjfPZQS60=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CQOBRZ5eq3e8EAOgPPhvG7ELGqdngO/0tFOjnIwglJKyis8fTGXXknWC9xOJt2GTI
	 owpnE2ts3qi+XWoTFiq0pY4wKq4nj4yMq80clPFNHVIkZv2qKXeF+P7SJHkr2iwBjP
	 zRNGVBpbEmERVURJi0uHZ6/+bvpjb5bl1WcO0OGVkjlu5HfSUbUzI+uar+J175Pa+j
	 /rqgNdfpm1CyiYyW99rcwuz/w9AbnDqoDMp3RIXhLmOTSOtJBbZXfMwDoaYr397W5C
	 3gzjkLvDaBlzrOzUPvDaUC+dmF/Gh2a+7i619+9RUuuAGmTiwWu/vTEmiRxp8OrLdw
	 of1D/4pnwl5BA==
Date: Fri, 11 Apr 2025 12:38:41 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Jerry Snitselaar <jsnitsel@redhat.com>
Subject: Re: [PATCH] iommu/exynos: Fix suspend/resume with IDENTITY domain
Message-ID: <Z_jxMcyMsQRJ5WOr@8bytes.org>
References: <CGME20250401202808eucas1p2d2db882c5b7e39bca39e0cf8d7696ca5@eucas1p2.samsung.com>
 <20250401202731.2810474-1-m.szyprowski@samsung.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401202731.2810474-1-m.szyprowski@samsung.com>

On Tue, Apr 01, 2025 at 10:27:31PM +0200, Marek Szyprowski wrote:
> Fixes: b3d14960e629 ("iommu/exynos: Implement an IDENTITY domain")
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
> This fixes random issues observed on various ARM 32bit Exynos SoC based
> boards, like Odroid-XU3.

Applied, thanks.
