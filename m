Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7688C17D345
	for <iommu@lists.linux.dev>; Tue, 13 Aug 2024 08:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723539266; cv=none; b=GkT/1AwRA+3P+J31eKwA9bCSNcYWwCfHd+3x2vG5dDlxFNPeFFlSQLzdtTgtI16i54MLOcZqseXRq/zH66k0zJybu/QvJe8VCEMUH6hK9O64QdEp5ndNfr7LAAQmV1Juh5PtzWCNQSgE49UkL4g9s+O43G1UGaHNdSAXywOeflY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723539266; c=relaxed/simple;
	bh=t9aWOiMm1M33jne9m0z4C1coYRIC28sw855e4mBAgkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=leJnN23xGbFgBGVhGgl64j2Wp87oZfGcuUFAkoIYqmDIVy6WKvKoAX6T3UmFkPoaoK5RNKwEuc1Y6twEhOJBYC4yOIZXj238mezblVbp/9Kplzof02CYOlBkQ7mPDLXjAe7h+ADCLtovQNt9yyxY6+rbmyY2c2UaBevuY9+7wUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=IbQYqljO; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="IbQYqljO"
Received: from 8bytes.org (pd9fe9dd8.dip0.t-ipconnect.de [217.254.157.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 4EA3E2A50EF;
	Tue, 13 Aug 2024 10:54:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1723539263;
	bh=t9aWOiMm1M33jne9m0z4C1coYRIC28sw855e4mBAgkg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IbQYqljOnMMeSZpJ8g1vJ8b+VAQOyyumaH0ARBY1/iqaTc/ha1F03eD1BOoqweZNb
	 +H0CvWrXvDzYM0Nwpx6FntWfpaIKVq796miFMqyyzTB2qAQbBAwb+aji/rIw4u4QIm
	 E0vrgCN95JMUsef4/TrXKZtihQgFq5pT58/TP/Dv2IM9Z1+tNlQBgMbSEBuhc+qxWV
	 qwfa9pmdWqi8a/k2XQzN4JOpHVYs7hifwt3SARooaPRLjUGCp8bTGeKz/kxO3HpXc/
	 W2CmHuSVNiuDNIAqoSoA1siGplxJZw0jvUGY0HCmJxU8FJkOeStFFMvLyLaMwWw3fv
	 YqoylyTuAWSFQ==
Date: Tue, 13 Aug 2024 10:54:21 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: will@kernel.org, robin.murphy@arm.com, jgg@ziepe.ca,
	baolu.lu@linux.intel.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] iommu: Remove unused declaration
 iommu_sva_unbind_gpasid()
Message-ID: <ZrsfPf2XvAZhzIXb@8bytes.org>
References: <20240808140619.2498535-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808140619.2498535-1-yuehaibing@huawei.com>

On Thu, Aug 08, 2024 at 10:06:19PM +0800, Yue Haibing wrote:
> Commit 0c9f17877891 ("iommu: Remove guest pasid related interfaces and definitions")
> removed the implementation but leave declaration.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  include/linux/iommu.h | 2 --
>  1 file changed, 2 deletions(-)

Applied, thanks.
