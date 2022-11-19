Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46831368
	for <iommu@lists.linux.dev>; Sat, 19 Nov 2022 09:34:11 +0000 (UTC)
Received: from 8bytes.org (p200300c27724780086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:7724:7800:86ad:4f9d:2505:dd0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 380592A00C5;
	Sat, 19 Nov 2022 10:34:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1668850450;
	bh=Vg/lY3KoFK3Ajbf1n+XXYfDpHTNf4XHoWuksuqy20sA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rg0QK1gXNhrI7umH2KEvc6O4+c2auws18j9/rZP1LvrQkdREB98QlGNKH0oVteMEG
	 DerygnmoePWTDoMm9zNqDWdXmBHzofek5Yv7x76jlrukWjd+PwCtBTxQSPr3xG8JP7
	 BHSTEX/wi7guZpaZuGFRkNlwBderDEd4CM0D8prKcW2+tNNht6YnuNbIYvqSu8Awtr
	 nGVAkZWbX0YkDaU+J1eIFdL7RMt2eue6z+8xbBwOGGBrfZOFWnhLe1aGR7WGAro8u4
	 PzQM3nB3Gu9z6UDPB1U0c+9/kRmmkNm/6nIOYvcplAJNOORdOFgvjGNvC5xrTzis2S
	 au2mhvtaoDKiQ==
Date: Sat, 19 Nov 2022 10:34:09 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: iommu@lists.linux.dev, linux-samsung-soc@vger.kernel.org,
	Will Deacon <will@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Sam Protsenko <semen.protsenko@linaro.org>
Subject: Re: [PATCH v2] iommu/exynos: Fix driver initialization sequence
Message-ID: <Y3ijEe/VbAQuL4QA@8bytes.org>
References: <CGME20221110154412eucas1p26182a3d691584b577ddced9a1287df60@eucas1p2.samsung.com>
 <20221110154407.26531-1-m.szyprowski@samsung.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221110154407.26531-1-m.szyprowski@samsung.com>

On Thu, Nov 10, 2022 at 04:44:07PM +0100, Marek Szyprowski wrote:
> Registering a SYSMMU platform driver might directly trigger initializing
> IOMMU domains and performing the initial mappings. Also the IOMMU core
> might use the IOMMU hardware once it has been registered with
> iommu_device_register() function. Ensure that all driver resources are
> allocated and initialized before the driver advertise its presence to the
> platform bus and the IOMMU subsystem.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/iommu/exynos-iommu.c | 26 ++++++++++++--------------
>  1 file changed, 12 insertions(+), 14 deletions(-)

Removed v1 and applied this instead, thanks.
