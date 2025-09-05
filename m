Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 972B1342CB7
	for <iommu@lists.linux.dev>; Fri,  5 Sep 2025 12:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757077130; cv=none; b=ODsE/1s4wxzzVCZyQuBLV8iSp6yfJn/iFzPRcaKc5Q/uJlF4bSyZ8DCJd0P3KOEsKajFA/4rnO43yGiCLbP69ofYkBlntLdHN2OMN7ZqR0udmpCXLaQsvlUoRo/LylG8ME+tiTdRorshHNGwak5N4kIK2t8xkfjXIC58GlhyQE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757077130; c=relaxed/simple;
	bh=RcmxVQgj4OeABmLrsIQO0VZ8BVIj60bpYWvgPtZ0tiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jEUbPgPxo97LCAJSAsQyOwemQ+x1xj+WIczs56xl+PDvKF6bfPGHYGLT9uR7b7pZPMI+bw5WYME3oMYZerek6QJ6wduTrcwtFtBgupoYc4PEfqcn1/q8qMrTne43YUEUz7U4KJOt+hmRNPeKlODksVezs9FW0pHBb1zaWxYbJ1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=vV5P3vG4; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="vV5P3vG4"
Received: from 8bytes.org (p54921b16.dip0.t-ipconnect.de [84.146.27.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 5A0FC548D8;
	Fri,  5 Sep 2025 14:58:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1757077126;
	bh=RcmxVQgj4OeABmLrsIQO0VZ8BVIj60bpYWvgPtZ0tiM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vV5P3vG4CShLJrt4R2J2VYP/o+TfVjftSb8Q5b0ntfouY/yjcc3OIqaxAtyqgm3km
	 K/GiO32Jz4aTedEaIB9HeuM+4WNygK0iTnJqecTY0VYMV45yz8CdZIFSmqkdpMiWJB
	 8gFWSNouWiLVNuQdYDSqHkWQ2pwwXgbgyv4KkM63VNYUBGJt5/O2jfa9OFxLMQevRm
	 DFpOvJe9ky++mlEvU56hUAf/052xCiQSfTV7ltJNTrIgulbGMqjbR5827r43a9MkV9
	 Z3akb8Gvy67w5Algo3/sAx5TfhuWVtdkwK0hWs+XXY/y8Zamtq2zu5SyDs4ukb0CCD
	 G/R0f4ojojmew==
Date: Fri, 5 Sep 2025 14:58:45 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Qianfeng Rong <rongqianfeng@vivo.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/omap: Use int type to store negative error codes
Message-ID: <aLrehYcpQcmmuKPR@8bytes.org>
References: <20250829140219.121783-1-rongqianfeng@vivo.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829140219.121783-1-rongqianfeng@vivo.com>

On Fri, Aug 29, 2025 at 10:02:19PM +0800, Qianfeng Rong wrote:
> Change the 'ret' variable from u32 to int to store negative error codes
> or zero;
> 
> Storing the negative error codes in unsigned type, doesn't cause an issue
> at runtime but it's ugly. Additionally, assigning negative error codes to
> unsigned type may trigger a GCC warning when the -Wsign-conversion flag
> is enabled.
> 
> No effect on runtime.
> 
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
> ---
>  drivers/iommu/omap-iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.
