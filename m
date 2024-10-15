Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDAB41CF2B6
	for <iommu@lists.linux.dev>; Tue, 15 Oct 2024 08:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728981581; cv=none; b=R6oZdW7lc6PumHgyK/sRCCU1/mSpHBzbDVnby/OPLffYoTfKjmvF2/RpC/xLCIV5XQ4xKJGe3Pokpm759GEHzmZyLoLFK86fwYaOZSEXWUcU7Lo4Hm2PzNtMKwARxpQEJiQFdmWwWpjQ+VgbZH3aO8ZHCGD5Xq3w+DKUO0XmdXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728981581; c=relaxed/simple;
	bh=lLI3uI/Gowpi+UHRNjXB/mZqeEqScoonhF7kBNF7y0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u2vn29W8GexnQUf3OUrjcPAGZIj8+2j0Swh3k9Hu5I0o+MY8ld5u81lTtK8nYfMC663JlnlH/+zdWNyqjAWAbAv1wA3PTcAYUY9U/c1WJ1gswUkMXJZlkzHk37NLJginmshqXFI1Q8CzviM8XE70YJUNU3ExGEIWsQ4kPp2zz1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=hjzVzH+g; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="hjzVzH+g"
Received: from 8bytes.org (p549219d2.dip0.t-ipconnect.de [84.146.25.210])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id D2E2A2A6C15;
	Tue, 15 Oct 2024 10:39:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1728981578;
	bh=lLI3uI/Gowpi+UHRNjXB/mZqeEqScoonhF7kBNF7y0M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hjzVzH+gwTse0ncPShH7BCSKQaLhC7i5x42D+AkhxCZyFskO/7Iadt5ilxt6Mr4NM
	 Nz8QWc37nZRzvvnlB7uWokDHe1ooN+I6N3Ipt1QYV0Mb9zdtmmQsulrOBm9xSUW1Md
	 TuMcjbT00ne4UcqLxgKLpJyjKOR9B/sKTTJP24K9BjOY8kUOp7KWC1R8HQsSCII9B5
	 icXO5TvNJG0lkLwZN7q2AV6h+u7xvH/xe3dyiZ/xSuGHHE0+6bS8uPOIFlHaxriKNO
	 58jQTVHpO7GkI9U3C5wxEdgARTb7NL1sWjDz6E+kk/hDfZyNgtsiSdNEyj5BZxYaba
	 fKrPX8YJ59QTg==
Date: Tue, 15 Oct 2024 10:39:37 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, will@kernel.org, robin.murphy@arm.com,
	suravee.suthikulpanit@amd.com
Subject: Re: [PATCH v2 03/10] iommu/amd: xarray to track
 protection_domain->iommu list
Message-ID: <Zw4qSefDXgUbZoFr@8bytes.org>
References: <20240910065812.6091-1-vasant.hegde@amd.com>
 <20240910065812.6091-4-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910065812.6091-4-vasant.hegde@amd.com>

On Tue, Sep 10, 2024 at 06:58:05AM +0000, Vasant Hegde wrote:
> Use xarray to track IOMMU attached to protection domain instead of
> static array of MAX_IOMMUS.
> 
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu_types.h |  8 ++-
>  drivers/iommu/amd/iommu.c           | 85 ++++++++++++++++++++++-------
>  2 files changed, 72 insertions(+), 21 deletions(-)
 
Reviewed-by: Joerg Roedel <jroedel@suse.de>
