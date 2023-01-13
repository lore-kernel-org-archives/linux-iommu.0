Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053772F2A
	for <iommu@lists.linux.dev>; Fri, 13 Jan 2023 15:31:40 +0000 (UTC)
Received: from 8bytes.org (p549ad69d.dip0.t-ipconnect.de [84.154.214.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 4E268261BE3;
	Fri, 13 Jan 2023 16:31:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1673623899;
	bh=W0eZQ+91SuOKkGncj7gzewhbmwWHOsQ0mNd5zAk/Afg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kd3MvqU4M0jhYsQnXTuWTVSnh8u/ySUWg+9yJInC5Nf3HOGNvLRTmxR/rphYWg4Sf
	 PYoiGuU583mXBOij5+1S2oKSMygZ/8aUhdw84fm70YckG2AD8H2FDMNIZ49oxXjD9D
	 w4tILH5cAYM+tRhz4OZOHveIUSmEKYzGPPx/mA+YGZxmqn+Q3/vekAHvP02rIASyhW
	 QvklPlTBURl0l8H95wV/d3XxGm/4Ocyp9bnQ2a/7SEwQKabkeMEyEbocQabC+eW3dH
	 yy3qLdHjJzKsUgk2R044hZ54dsY0RJRqNqB6RnCH1xm/3ACcxEcHX9VGBeq5qzTIx4
	 i5ISakzVcqpvw==
Date: Fri, 13 Jan 2023 16:31:37 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Matthias Brugger <matthias.bgg@gmail.com>
Cc: "Chengci.Xu" <chengci.xu@mediatek.com>, Yong Wu <yong.wu@mediatek.com>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	iommu@lists.linux.dev, linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v6 0/4] MT8188 IOMMU SUPPORT
Message-ID: <Y8F5WUCr5bzv9SgS@8bytes.org>
References: <20221223101439.494-1-chengci.xu@mediatek.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221223101439.494-1-chengci.xu@mediatek.com>

Matthias,

On Fri, Dec 23, 2022 at 06:14:35PM +0800, Chengci.Xu wrote:
> Chengci.Xu (4):
>   dt-bindings: mediatek: mt8188: Add binding for MM & INFRA IOMMU
>   iommu/mediatek: Adjust mtk_iommu_config flow
>   iommu/mediatek: Add enable IOMMU SMC command for INFRA master
>   iommu/mediatek: Add MT8188 IOMMU Support
> 
>  .../bindings/iommu/mediatek,iommu.yaml        |  12 +-
>  drivers/iommu/mtk_iommu.c                     | 113 +++-
>  .../memory/mediatek,mt8188-memory-port.h      | 482 ++++++++++++++++++
>  include/soc/mediatek/smi.h                    |   1 +
>  4 files changed, 584 insertions(+), 24 deletions(-)
>  create mode 100644 include/dt-bindings/memory/mediatek,mt8188-memory-port.h

Please let me know when this can be merged.
