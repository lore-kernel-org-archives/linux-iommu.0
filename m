Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D0840BCB8
	for <iommu@lists.linux.dev>; Thu, 24 Sep 2026 11:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790248709; cv=none; b=f4AhCpBVsTBzSS0BB7Zy6nHZsO1P/D3MFQUEpfeN4JxZ2vrHBorrnUf/dMR5UdlLyHpT8hBweN9uCRlXAEdD9774OcWHKB//SPFb56OwCegVZC6ebAOd9UBcUXn32o8nIsAm52cgQAa3P4XltHgeolcqcUPRWMCAGvDQLvgpDt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790248709; c=relaxed/simple;
	bh=ZMMAM39BWNk7yMnZdN2azby1KqpgjDTo4lFsVmtZV58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aBCNIwm/ARbVG1DpWa8X4pn5QNKyjbO2xhX3dF2dn+bDqON26P47WRP11iGEdO09FmqOaU+9GRw9xUU+VtBUBFwhUlpvWjSuIwwGAkWthfJVIXb3QVb//AA0RbILD3K97kPHzXIbu8a7oA3RnDmfxXM+FDjvm7QUuri8XdtzJWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p200300f6af404a00e4ccc4fdbbd66590.dip0.t-ipconnect.de [IPv6:2003:f6:af40:4a00:e4cc:c4fd:bbd6:6590])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id B33E11C7465;
	Thu, 24 Sep 2026 13:18:25 +0200 (CEST)
Date: Thu, 24 Sep 2026 13:18:24 +0200
From: "Joerg Roedel (AMD)" <joro@8bytes.org>
To: markuss.broks@gmail.com
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Peter Griffin <peter.griffin@linaro.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] IOMMU driver improvements for modern Exynos SysMMUs
Message-ID: <arUG8gG8Fx3es8Hj@8bytes.org>
References: <20260820-exynos-iommu-fixes-v1-0-6bbcd673bb15@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260820-exynos-iommu-fixes-v1-0-6bbcd673bb15@gmail.com>

On Thu, Aug 20, 2026 at 10:12:04PM +0300, Markuss Broks via B4 Relay wrote:
> Markuss Broks (4):
>       iommu/exynos: detect SysMMUs without BLOCK mode
>       iommu/exynos: fix the enable sequence for no-block SysMMUs
>       iommu/exynos: fix TLB invalidation for no-block SysMMUs
>       iommu/exynos: decode the v7 fault transaction info

Applied, thanks.
