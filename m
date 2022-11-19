Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407DD1368
	for <iommu@lists.linux.dev>; Sat, 19 Nov 2022 09:11:57 +0000 (UTC)
Received: from 8bytes.org (p200300c27724780086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:7724:7800:86ad:4f9d:2505:dd0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id C49A62A02E2;
	Sat, 19 Nov 2022 10:11:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1668849116;
	bh=Mnj+XKy1eq+cpp4M1nNQ/BJ5gwNgtt/9NmvCYlk98lM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TkWUk44EuE6Qzf35kclftWpLfCtg5ilCYc4uaPR850QcfeUrf1tp1Xm1Ey8URAcvp
	 KPyU/rgiN1ln6vSNBM325IHlDDXjPBHs0iRmodqDjuzaL0p3qOU0jV6SjJOmUGXy32
	 aZCZXRxrcB3MT4F88H565tRMhKpsaqIv/5Iu9xz2zYZh4FZtMcZJGNcoekVl8hpuD6
	 q+2xw5rkrkBCeqXuPxDrwFq4N3LAGWW/kFPJHKks3Z+8eA6drLrbp/T4p/aQQ/WV6k
	 2f07Coc9oEeoftLXAwMzfR04vHUrJaWJYUqa4xmZkeRSNkDOGSIR6xRVYz9lNp8aSb
	 7XISudJwIVM+w==
Date: Sat, 19 Nov 2022 10:11:54 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Alexandre Mergnat <amergnat@baylibre.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	Yong Wu <yong.wu@mediatek.com>, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, linux-mediatek@lists.infradead.org,
	Amjad Ouled-Ameur <aouledameur@baylibre.com>,
	Markus Schneider-Pargmann <msp@baylibre.com>,
	linux-arm-kernel@lists.infradead.org,
	Fabien Parent <fparent@baylibre.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v6 0/3] iommu/mediatek: Add mt8365 iommu support
Message-ID: <Y3id2iJdLxdr6L5o@8bytes.org>
References: <20221001-iommu-support-v6-0-be4fe8da254b@baylibre.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221001-iommu-support-v6-0-be4fe8da254b@baylibre.com>

On Wed, Nov 02, 2022 at 04:18:06PM +0100, Alexandre Mergnat wrote:
> Fabien Parent (3):
>       dt-bindings: iommu: mediatek: add binding documentation for MT8365 SoC
>       iommu/mediatek: add support for 6-bit encoded port IDs
>       iommu/mediatek: add support for MT8365 SoC

Applied, thanks.
