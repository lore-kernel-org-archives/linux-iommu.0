Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2ED7A
	for <iommu@lists.linux.dev>; Fri, 15 Jul 2022 08:31:24 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
	id 204041F88; Fri, 15 Jul 2022 10:31:22 +0200 (CEST)
Date: Fri, 15 Jul 2022 10:31:21 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Janghyuck Kim <janghyuck.kim@samsung.com>,
	Cho KyongHo <pullip.cho@samsung.com>,
	Daniel Mentz <danielmentz@google.com>,
	David Virag <virag.david003@gmail.com>,
	Sumit Semwal <sumit.semwal@linaro.org>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/6] iommu/exynos: Add basic support for SysMMU v7
Message-ID: <YtEl2YivyW4iLO//@8bytes.org>
References: <20220714165550.8884-1-semen.protsenko@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220714165550.8884-1-semen.protsenko@linaro.org>

On Thu, Jul 14, 2022 at 07:55:44PM +0300, Sam Protsenko wrote:
> Sam Protsenko (6):
>   iommu/exynos: Reuse SysMMU constants for page size and order
>   iommu/exynos: Handle failed IOMMU device registration properly
>   iommu/exynos: Set correct dma mask for SysMMU v5+
>   iommu/exynos: Abstract non-common registers on different variants
>   iommu/exynos: Add SysMMU v7 register set
>   iommu/exynos: Enable default VM instance on SysMMU v7

Applied, thanks.
