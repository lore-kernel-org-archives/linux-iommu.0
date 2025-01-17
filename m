Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA851F754E
	for <iommu@lists.linux.dev>; Fri, 17 Jan 2025 08:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737100887; cv=none; b=lEkByYJYOm14460EtNQeBeNw899hnjArbS92BWF4W7O85I5cYnpD981oUo5b0ntS6YZyb0YIwxGAK2SFRkps3wo5+ocYmK/t2fm2UUCq5TsoZx08J9Z1YMbtVuexRqBGzSB/Q/sgruzAdFogTU+r89Zqw6sWCcjqLUMkj2ogwdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737100887; c=relaxed/simple;
	bh=YniXUGeOea5s0/pHgde64c+kqGE6B07oghaN1d950FE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C9l3ulB4LbJrnBqvO4zwiWpufcwDxNpb2vQddat4JECtMRF4nmyYEVrNV/62cMRvIef30cqN+cpHlP54JZhFWcsVWG0H6lrcm9V5jZawiqh8JbxFqJGwBZmXWSJBkBk/0VzfLsv4LJJ/lk8iLzN3BFG8VzruaAWfE3rtTOLri70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=W3r5Fu9O; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="W3r5Fu9O"
Received: from 8bytes.org (p54921e31.dip0.t-ipconnect.de [84.146.30.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id DFE572E002E;
	Fri, 17 Jan 2025 09:01:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1737100884;
	bh=YniXUGeOea5s0/pHgde64c+kqGE6B07oghaN1d950FE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W3r5Fu9OKGEPvfivVZEcb8f/DZi2mMF12MYvsqFYcM/juUAXw3Y2YS25JF2WFEE6F
	 e5MetfHYzk1jJWs0CTSBtphPsGgg6WXLly0vEomNkBGA9Y8ll46bFwazPpuFT7g0+T
	 /lV9NCAGnL93FGazDxHRiBisggDo/Fq6buYGhP/R6HaNDM9b+rcKHd2vgO3ZrQW1qi
	 PoEzBJEwXIFOKeW7gGQexDOZxqh9AUD102OjODMa6YfkOS68HrgyEV3pQJq8j95186
	 8fmf2s10D+hqI/BLfwQhQM7mYVvFWF1nX8DC2nfM9zKVPAZYn/orbWLRMQvSjWsYNS
	 ktSDE0O44nizw==
Date: Fri, 17 Jan 2025 09:01:22 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Yong Wu <yong.wu@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] iommu: Use str_enable_disable-like helpers
Message-ID: <Z4oOUvs-IicjGs66@8bytes.org>
References: <20250114192642.912331-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250114192642.912331-1-krzysztof.kozlowski@linaro.org>

On Tue, Jan 14, 2025 at 08:26:42PM +0100, Krzysztof Kozlowski wrote:
> Replace ternary (condition ? "enable" : "disable") syntax with helpers
> from string_choices.h because:
> 1. Simple function call with one argument is easier to read.  Ternary
>    operator has three arguments and with wrapping might lead to quite
>    long code.
> 2. Is slightly shorter thus also easier to read.
> 3. It brings uniformity in the text - same string.
> 4. Allows deduping by the linker, which results in a smaller binary
>    file.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 3 ++-
>  drivers/iommu/arm/arm-smmu/arm-smmu.c       | 3 ++-
>  drivers/iommu/mtk_iommu.c                   | 9 +++++----
>  drivers/iommu/mtk_iommu_v1.c                | 3 ++-
>  drivers/iommu/rockchip-iommu.c              | 3 ++-
>  5 files changed, 13 insertions(+), 8 deletions(-)

Applied, thanks.
