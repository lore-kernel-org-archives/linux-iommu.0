Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1E3802;
	Wed,  2 Oct 2024 01:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727833881; cv=none; b=mmu9eUHmwZr66bGwTmyEqD8bksGGjjamo7iFxzv6So+gPtia3lAovgoqQF1QsgM27/9usMcxvZKK4pCyvQj9wi4NXOGJlL4ymxQUbN663m80N3dlOUT7GzdF/u8hvwTFlH2k/UL/Pn8hhEEG+0U9F9VPHho2JD6t8r+RA/9bwmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727833881; c=relaxed/simple;
	bh=5zXX1GxmTVudwxxhQ5BxxstLJNAqQANcQJXzqffqHKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HlvhIPXMyW8z0rF2fF6yjEn+OB7Q0SyQWHMrMmKtRwQ/wdtY3rRe1h3Kp/uhSpnFtCGPqWN85z8wUvgS7/JpjAZ04LzTEaMB71phc30bF42LW/S4/WF2C8BVAjHSIncPqWm0NZ2EnOH8cGx4jsiSSoVVYBxzIOL/no2Dx8J0+js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fgXrHyln; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fgXrHyln"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B85B4C4CEC6;
	Wed,  2 Oct 2024 01:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727833880;
	bh=5zXX1GxmTVudwxxhQ5BxxstLJNAqQANcQJXzqffqHKE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fgXrHylnk4H2qzVpJwHSQAJfkFOvBS6/r9g91vMACFhmXgP7zU+vLRokgPa6LkNY7
	 bXSPx8cmJOqvFJuEnRBasaHi7xf1cUzHvKZuXLqMObFKbMi57bErYHm23AkzW/+bvC
	 LMfSWF90ZR7Zs5X3u0bjgPH5TXJz91afowjY1jIZNNuhhB1BCvE8PTvmPchffoSzWj
	 v0s8XkiGTGtKJWWadIIU6qQiPLzEUC90VbFCsZU/IBGo9gPegMMuOIlSMzxL81cAM1
	 P93xMA7fWMzVolNuI0scTNJzgDzFw6LefUd2B4uqbUXLizU2lX3AqB+E9pgmgLlvdu
	 GLdNR7bWWsY6g==
Date: Tue, 1 Oct 2024 20:51:20 -0500
From: Rob Herring <robh@kernel.org>
To: Macpaul Lin <macpaul.lin@mediatek.com>
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Yong Wu <yong.wu@mediatek.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Rohit Agarwal <rohiagar@chromium.org>,
	dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	Alexandre Mergnat <amergnat@baylibre.com>,
	Bear Wang <bear.wang@mediatek.com>,
	Pablo Sun <pablo.sun@mediatek.com>, Macpaul Lin <macpaul@gmail.com>,
	Sen Chu <sen.chu@mediatek.com>,
	Chris-qj chen <chris-qj.chen@mediatek.com>,
	MediaTek Chromebook Upstream <Project_Global_Chrome_Upstream_Group@mediatek.com>,
	Chen-Yu Tsai <wenst@chromium.org>,
	Jitao Shi <jitao.shi@mediatek.com>
Subject: Re: [PATCH v4 5/5] dt-bindings: display: mediatek: dpi: correct
 power-domains property
Message-ID: <20241002015120.GA236278-robh@kernel.org>
References: <20240930083854.7267-1-macpaul.lin@mediatek.com>
 <20240930083854.7267-5-macpaul.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930083854.7267-5-macpaul.lin@mediatek.com>

On Mon, Sep 30, 2024 at 04:38:54PM +0800, Macpaul Lin wrote:
> The MediaTek DPI module is typically associated with one of the
> following multimedia power domains:
>  - POWER_DOMAIN_DISPLAY
>  - POWER_DOMAIN_VDOSYS
>  - POWER_DOMAIN_MM
> The specific power domain used varies depending on the SoC design.
> 
> These power domains are shared by multiple devices within the SoC.
> In most cases, these power domains are enabled by other devices.
> As a result, the DPI module of legacy SoCs often functions correctly
> even without explicit configuration.
> 
> It is recommended to explicitly add the appropriate power domain
> property to the DPI node in the device tree. Hence drop the
> compatible checking for specific SoCs.
> 
> Fixes: 5474d49b2f79 ("dt-bindings: display: mediatek: dpi: Add power domains")
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> Signed-off-by: Pablo Sun <pablo.sun@mediatek.com>
> ---
>  .../display/mediatek/mediatek,dpi.yaml        | 24 ++++++++-----------
>  1 file changed, 10 insertions(+), 14 deletions(-)

You missed Krzysztof's R-by tag.
