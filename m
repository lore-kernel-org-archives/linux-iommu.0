Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966FB32C317
	for <iommu@lists.linux.dev>; Thu, 20 Nov 2025 10:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763634953; cv=none; b=VEdELb4+ESj9OddYxEffTsP+ZZ10Wo/MBCsnUA8RiVupQ/II2ozUnqALa3Z2LZxaobuLiR9yzV08wRwM1PCUdmOdliTUXB5r4QdczgQw21ptJIveWPZKC26h93b1N96b0C2NJ/YUb95tHTuAN200DKjcOyxn0N+pb1ZHjhudvxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763634953; c=relaxed/simple;
	bh=7IPdBQHfxWXuPT5xyJ/8ib/OZwAIT5aCIFXEm9UI7HY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y8jACApvCcSax4COuFLLFKlEqeZG6W2vxHsYEZhbSTDmxtWNeVg8q6GVJbC9DdH5Tv1xq1Xt3Nl3w8vBovblLe/ok9SWH7U+GBqVjJ5FIbK2otWFBPYU1Onyr7aFgG0wDNXbBQMVohNi8UG3VPdO7OaCOnQVxM30hKLARDipLXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=4V66bg7I; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="4V66bg7I"
Received: from 8bytes.org (p549214ac.dip0.t-ipconnect.de [84.146.20.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id B62FF5BB50;
	Thu, 20 Nov 2025 11:35:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1763634950;
	bh=7IPdBQHfxWXuPT5xyJ/8ib/OZwAIT5aCIFXEm9UI7HY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=4V66bg7ISVef4fw/QxceKmpPlEFlGCUfB2pk7OGemX4kGHj8Pyv0mRaLPonSrNH/G
	 UIKv2IfrXb2CV1Z7kR/Czadi/uTkXZeBb3mueUeVn4l00+OER8nQR+rJs6bNkoXceg
	 ivrADDJWrG5HvL8VEm12jzh4pOyGtRt4jM+Qdgct6E1i+yYqTFCkvgcqNf5zv064Vi
	 rl8S44ADZrQ8Clb7UwtXd2YXvHa5NrWnopKiXWndQjfSpxEZwJ9T8E9PuZAOHzBIZy
	 I6OKg0i3jmJk66/LQBVmix8cX+tira/JY6EcHfAo8FvSsbIsNBeKVoK/ETyB8OS3I1
	 g11svuD08akow==
Date: Thu, 20 Nov 2025 11:35:49 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Restore previous domain::aperture_end
 calculation
Message-ID: <oyobmkosorfz6lebx2fn2li4tdy43zs5sx6oet7xr3gw7vf7fi@m4iswvpgam6h>
References: <20251120072524.3218282-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251120072524.3218282-1-baolu.lu@linux.intel.com>

On Thu, Nov 20, 2025 at 03:25:24PM +0800, Lu Baolu wrote:
> Fixes: d373449d8e97 ("iommu/vt-d: Use the generic iommu page table")
> Reported-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
> Closes: https://lore.kernel.org/r/4f15cf3b-6fad-4cd8-87e5-6d86c0082673@intel.com
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Suggested-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/iommu.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Applied, thanks.
