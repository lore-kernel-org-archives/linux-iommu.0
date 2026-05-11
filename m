Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C7A39DBD9
	for <iommu@lists.linux.dev>; Mon, 11 May 2026 07:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778485409; cv=none; b=ulKOsVcxetcTakQaKNOOPZsn5cVV/XrnV4w+HEOwC4+fbgFIlvQBhHzdSaADTLriJt1ubpPZago+3A3H/oY0CZD1hbAgmH5+CRGMDSAAP7vSqgD3/9c9I1MHUcit78wHeEL0Tjslf00pgwJZy8ug5N3KtwtS67Zi1E1SdAKeqWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778485409; c=relaxed/simple;
	bh=odfKts3qDqoP0Br1fLiYuHnVDTxk6RSCWBN+PdYTGHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fs8LVuSsSQGT9q0iJpP2Mu6oDi9WTBuG1L9heaeZoGrLhBCi0selTTaFZzPE99BAB3l6le9uBPvfAc6PO0U8NtAmKK8NSzXDRARvXXeVXM/PC2STjuj6QRVvh2hsDV2Cx54cxpxcQn3l/BbTanoDI3R5chm+9kNLELYDqlWAnF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=wKCIRL7O; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="wKCIRL7O"
Received: from 8bytes.org (p200300f6af1d9600f5faa5cebd6c042e.dip0.t-ipconnect.de [IPv6:2003:f6:af1d:9600:f5fa:a5ce:bd6c:42e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id A2BFD1C41F2;
	Mon, 11 May 2026 09:43:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1778485397;
	bh=odfKts3qDqoP0Br1fLiYuHnVDTxk6RSCWBN+PdYTGHQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wKCIRL7Oe2/9I7A9PSVaiO+rigcwerdSz4iYvuYJ4aDbcuMbru3SdwhqWfoyTksmL
	 r12SCf7ip6FlnR9RMGMK1fclmFywfZWlHuR4NmtxNKPq0Egk2DWjnwiYzh+Cc1mtKZ
	 D4ebTU3/tymcJEAuKaTHFSNGTryH1ypnzhyQFdoAXYFXIbfJEaeXj3uIixvBIqLrpu
	 KUkjnLgJJ0Iu3CK+YcJS4gdz6WG7Quwxnn0Pr00wybuFXWdReCUeqk6Zdxnw//kCUt
	 +RwcUiQJ4PzzFcfhWp4gztN2GY59jCxdBFGcycZorzgq14oUPZ9TvYSRMZRN2rwibB
	 0YoXgaWqHPUoQ==
Date: Mon, 11 May 2026 09:43:16 +0200
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Fu Hao <fuhao@open-hieco.net>
Cc: will@kernel.org, suravee.suthikulpanit@amd.com, robin.murphy@arm.com, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [PATCH v2 8/8] iommu/hygon: Add support for Hygon family 18h
 model 4h IOAPIC
Message-ID: <cfb6symarn4wqtuuvwpjfrcaudvpezv7hfe5gim2a57ppwqn2p@wtjnl7tpy2zg>
References: <cover.1775548724.git.fuhao@open-hieco.net>
 <3c1d95e3f53b250c97c60f613ead7e0ec0ea2d87.1775548724.git.fuhao@open-hieco.net>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c1d95e3f53b250c97c60f613ead7e0ec0ea2d87.1775548724.git.fuhao@open-hieco.net>

On Tue, Apr 07, 2026 at 04:25:40PM +0800, Fu Hao wrote:
> The SB IOAPIC is on the device 0xb from Hygon family 18h model 4h.
> 
> Signed-off-by: Fu Hao <fuhao@open-hieco.net>
> ---
>  drivers/iommu/amd/init.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)

Applied, thanks.

