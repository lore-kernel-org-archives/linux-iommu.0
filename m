Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60BEA1DED63
	for <iommu@lists.linux.dev>; Fri, 27 Jun 2025 07:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751008946; cv=none; b=h7A70Nxf88ymzzDOpZysYpCbZ/hBDZhu6N5ZBW1RhPnAKr5VvY5WoCKn5uBQF/qgy19GTJNO5L4wrnAhvXzgryUcD2Hy5t/IoQQzYrXzOMCKX/7WtGEpj4uoNr+5mnmQ3QzyjyX4foRaPgPG1lRhw30PQAgqhR7xdfTxwQILeWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751008946; c=relaxed/simple;
	bh=Dk/pBSmbJ17G6vO11eCrfBy5crU9pUYl5+E7dDjzLlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nqNjvzklDMPP0VzWpWSE2Ll+vE0jaUw78Hhh511Txzt7UTQ1NwV9aecMM+uciW75QJ2QZCgHIg6X3yHdH0z/O4JEK2HM6obgVYa/qWO37m8QrGaxjtuLFKOBV7h+GuGGv9e6aP1zq/DCRfk7yE8qSDkKjPUY8G0QRLcAWbo4vCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=W90/rGBo; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="W90/rGBo"
Received: from 8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 53E654EF8A;
	Fri, 27 Jun 2025 09:22:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1751008943;
	bh=Dk/pBSmbJ17G6vO11eCrfBy5crU9pUYl5+E7dDjzLlY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W90/rGBohRzRVv6HgAAOv7PSVTsfEuTP3aUn5CDsuQmDT9XlTMO+0gR7jIt0qcOLH
	 fkmIndB80JUhTMxMGfy+d1/kyocyju5bZT8qEjBljyb0u9vPzJG4D+7RnsQz3zE3JV
	 b2wkrrhZGz2vgvXJ1siyMPBFgrA3rt+yCiLp6JTvNmd6/QnMFjW4t9FOgkOlaQT3xK
	 hPRXD8cf6rHD+eSRVVZnnQbenZF1hhilsdK0Xlfki1yrDNefaZVf+cQXWYchV0A8hy
	 RXkvZ+UGxAxk71dthG2jEp/vThsIzYGxldIoPKcl+npZucUoE0YYcw2j1zrYs7FHOo
	 0+P4869YykfoA==
Date: Fri, 27 Jun 2025 09:22:22 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Yong Wu <yong.wu@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 0/3] iommu: omap: Simplify few things
Message-ID: <aF5GrmCO7AkkKLaI@8bytes.org>
References: <20250624-syscon-phandle-args-iommu-v3-0-1a36487d69b8@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624-syscon-phandle-args-iommu-v3-0-1a36487d69b8@linaro.org>

On Tue, Jun 24, 2025 at 02:22:29PM +0200, Krzysztof Kozlowski wrote:
> Krzysztof Kozlowski (3):
>       iommu: omap: Drop redundant check if ti,syscon-mmuconfig exists
>       iommu: omap: Use syscon_regmap_lookup_by_phandle_args
>       iommu: mtk_iommu_v1: Simplify by dropping local 'mtk_mapping' variable

Applied patches 1 and 2 to the ti/omap branch, thanks.
