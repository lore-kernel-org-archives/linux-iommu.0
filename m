Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C3312CD81
	for <iommu@lists.linux.dev>; Fri, 16 Feb 2024 14:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708093122; cv=none; b=hi3dZlqnw6IsJZ75RUpxf3fwb7SzzquWUKMwtxFo417+dlKYMj6bGJ0ITrnbiQ35RAG87tQR/C2+YruTFS+dRWakuAErMOLr0LJ7M4aANq1a3JGt/qKOVRxWrhrU8RVdtXd1U7Km8LmP2inGvruggyTBRReo7AJl0ExWdlERwM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708093122; c=relaxed/simple;
	bh=SZZOeJbM9IqCNRzXyb/vtXg4j78a3vQTIUylqLxTqTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DdUj946KeAg8zVUINpwFZrU0CnCgF57VU9Qnf7xlWJRUogKtNzLsFPMbfUNq9CbPXoooIVuRJj2+y9PYuXKTYT3q9i2PCYkmWagDf1QVMOA/aaP7FaNytbJDnVcgskxfiUnln202p43cPosUIzDjgzRHovU+w50QlJInhOkvkIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=Bn2HfMIH; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="Bn2HfMIH"
Received: from 8bytes.org (p4ffe0c3c.dip0.t-ipconnect.de [79.254.12.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 2F8731C462F;
	Fri, 16 Feb 2024 15:18:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1708093120;
	bh=SZZOeJbM9IqCNRzXyb/vtXg4j78a3vQTIUylqLxTqTE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bn2HfMIHDvH9l7V2fAjwpcG0c0/NmPWKIJH52PiBhofcHz6e8hQkwUtugapU8ixfY
	 nw1ZuEJanOj9/S2F+ygKSJmWhnMUU5vpY6iaIQKy5d4z3KtgYfybLAQHIXlLnXbecG
	 pdPSOZGYcFyNvyJ9pOQgyeqr1cZpPe0hdE1MZfV5VDKM0oSChLnSlbo8z7ClQiVjvB
	 KxZqriHWB9+QO3em1KHwl9W4qG96QuAMSckuNhohjqeofGvIR9ZnefA0HH+U4lXzed
	 fBy1Q+i5J6tZGSFiwmhr3rnb42eUik86OjtG7GZI/FTHiPnz6+dfDSWS8f0HTnrQPb
	 2aF35QAc5aPvQ==
Date: Fri, 16 Feb 2024 15:18:39 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Erick Archer <erick.archer@gmx.com>
Cc: Yong Wu <yong.wu@mediatek.com>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Kees Cook <keescook@chromium.org>, iommu@lists.linux.dev,
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] iommu/mtk_iommu: Use devm_kcalloc() instead of
 devm_kzalloc()
Message-ID: <Zc9uv4smFRfzf_mY@8bytes.org>
References: <20240211182250.12656-1-erick.archer@gmx.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240211182250.12656-1-erick.archer@gmx.com>

On Sun, Feb 11, 2024 at 07:22:50PM +0100, Erick Archer wrote:
> Link: https://github.com/KSPP/linux/issues/162 [1]
> Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [2]
> Signed-off-by: Erick Archer <erick.archer@gmx.com>
> ---
>  drivers/iommu/mtk_iommu.c    | 2 +-
>  drivers/iommu/mtk_iommu_v1.c | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)

Applied, thanks.
