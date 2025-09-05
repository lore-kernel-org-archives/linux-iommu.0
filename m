Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B68343D8D
	for <iommu@lists.linux.dev>; Fri,  5 Sep 2025 12:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757076149; cv=none; b=YCBgFeJXEeP0ILF04PYAHzxMCAtZ+mQcSWCQn3kMNvZiOPLeAO85uGbs/OyDd7Lh0FeY5857qpaRLELZ9GN07YydiiOEILrAeaEx57VcByE+0E4/2y9jUhmPyrtkw4o3H1wMCakGFruWi8I+gSOAZQFre2lx7flKC6g4NbQteUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757076149; c=relaxed/simple;
	bh=+rbhCuPaIK4kFW2LQu3JgFwOqrKrtKGEDe6S3X2GWAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gEARcX1sBt1rM/bp6+eMJVTH1V0FWu/DoNmTlQr9nhjKnczADr9JNu2YbSg851HiPOV6svboqPt6CTSJX7Ey1s9dR2h+llY1bQYIDD8E6UYxTTrTCDFA3Pg0vJqFcJAIsNMDuYNZTv3Bp5aGZ73Y4/FZQVRu/VnqNnlr3RBsK9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=WDuZ/8jM; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="WDuZ/8jM"
Received: from 8bytes.org (p54921b16.dip0.t-ipconnect.de [84.146.27.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 3A4DF54B6D;
	Fri,  5 Sep 2025 14:42:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1757076146;
	bh=+rbhCuPaIK4kFW2LQu3JgFwOqrKrtKGEDe6S3X2GWAA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WDuZ/8jM/PznFTQFnbaTun4O8nHyU2C3ByGtM8ihMhTznUmRl0D6ZWWbz/UH2dP/8
	 Soy88l1BPKOBJ2ydmPXUP/vfW2Zg7pIuO0LIbug2WZf2ZYItOQcRmQw09YeeXVJCbW
	 TVzz3/wS/kFSgj6Kjnv5D0Pl8U1dM3GKGh9JtGXCx9GOCB4lPxxQSX4qz09qq4F5jD
	 Z/rWtjtpdhDHum8i4zs9U1swnuvdPwcl1KmJ8hBXmF+r08W0MLVqma96auD3kQhB4Y
	 zP0VkidO9dQo7zdHXrdXEwLfmNBY3Ac/b9IXcGuYIluXEzhDEAPbecxODxZUSpxZvd
	 QJY7lhnEWCa8A==
Date: Fri, 5 Sep 2025 14:42:25 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Zhen Ni <zhen.ni@easystack.cn>
Cc: suravee.suthikulpanit@amd.com, will@kernel.org, robin.murphy@arm.com,
	iommu@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH] iommu/amd: Fix ivrs_base memleak in
 early_amd_iommu_init()
Message-ID: <aLrase4rA1Thk4Jy@8bytes.org>
References: <20250822024915.673427-1-zhen.ni@easystack.cn>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822024915.673427-1-zhen.ni@easystack.cn>

On Fri, Aug 22, 2025 at 10:49:15AM +0800, Zhen Ni wrote:
> Fix a permanent ACPI table memory leak in early_amd_iommu_init() when
> CMPXCHG16B feature is not supported
> 
> Fixes: 82582f85ed22 ("iommu/amd: Disable AMD IOMMU if CMPXCHG16B feature is not supported")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhen Ni <zhen.ni@easystack.cn>
> ---
>  drivers/iommu/amd/init.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied for -rc, thanks.
