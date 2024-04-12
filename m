Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786DA502B0
	for <iommu@lists.linux.dev>; Fri, 12 Apr 2024 10:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712917002; cv=none; b=ccEbh1zFbvwEGkqmDoPUXb0tACHSDQdQo7L/nIfq//K+6EkjILPyonnzIYuqtKcex8QAcf1ysRk427K6TeJsVdxw4xVtYLBXssq6Kqnm3dHzqSN4sNhE7pDoRAfqXe5NmXT/Nbc/aRy7ZxJFU+i/2bmwCaMeh6U/aOL/tKFyXQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712917002; c=relaxed/simple;
	bh=Fy1L6B53zbn/7W6/wp4ehwODAkzokEdkmuBhbvxtv7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IU0Z1aNthf7jJq7ZGA+SBq1Pu4Sjm3h7SW7CfHNiqphF06CosKf+s0/sY6B7QLgbvKycShFNCEy6NyuR1exFwqLzF6Hn+wy3hOkaNnMGowLGAi0mKBNYqEw1f3/1k9dMSehoo97N/gb/QqAb+DSV4lGCoCq//zALfrUkX0H+EiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=CGR+K/qu; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="CGR+K/qu"
Received: from 8bytes.org (p4ffe0bdf.dip0.t-ipconnect.de [79.254.11.223])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 5E46C282393;
	Fri, 12 Apr 2024 12:16:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1712916999;
	bh=Fy1L6B53zbn/7W6/wp4ehwODAkzokEdkmuBhbvxtv7Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CGR+K/qukoQKqYTo0GbGFUBsRIurJYCqLFbe8YAPHHRI3Va7ujC1YNfNHQzjbeVal
	 ZNNIaRNK1ZQ3yIyYF/Da8OmB/W5EfK0qXUPKoN3xmuVnPjMZxDETHY7P0Pre8BThmr
	 o42prSluzTw/1n8EOSGyi/ryPHKCzXWpZd3G5CEsYGzuC1sSuQK2GjBAnQihcjSykG
	 9L5FmuYX/HjJmTafBXC3fyZeqULAwDpM3uWs/nCquuM3VpYdN9UpZhZBb5dK05gbwj
	 WDkzdVzHpW56AZpuPnUi+D2p+rti0CpL/KxqhsvVVQf/M8GdNK1rG0MrFePBqXpr3x
	 mMdbClwl52j4Q==
Date: Fri, 12 Apr 2024 12:16:38 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, suravee.suthikulpanit@amd.com,
	Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH] iommu/amd: Change log message severity
Message-ID: <ZhkKBrGwlDkR7g7z@8bytes.org>
References: <20240410101643.32309-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410101643.32309-1-vasant.hegde@amd.com>

On Wed, Apr 10, 2024 at 10:16:43AM +0000, Vasant Hegde wrote:
> Use consistent log severity (pr_warn) to log all messages in SNP
> enable path.
> 
> Suggested-by: Tom Lendacky <thomas.lendacky@amd.com>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/init.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.
