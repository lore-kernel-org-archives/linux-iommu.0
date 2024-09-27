Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627C91BAECB;
	Fri, 27 Sep 2024 09:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727429405; cv=none; b=h86IY6fBq0o5lPJ+FhclQgWJc/k1LTI68TZcQp2mFrNRVMkquOlhO2avWYykU1W9KjWZVzN/MNme35h4GhsNFLx2fVKmiuZfL4uYs9fV9/qekavqMVMuh2ViA/uEdrMF7QJzgxC5X+46wD8/jzQTkmSRJuOoZV2JkUNGv3uIhBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727429405; c=relaxed/simple;
	bh=NQf7+QpzoDAuDvR3lojHYXmnOqICjH6ZZUXhwQlwxTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ow9EUSacL76xlgKDxMNSiZf2173+qu97dSJjVFH84O7T6Aa9MWP/CYxyyt+eJII67PDe80xX4E+Gv+rK8gih2XW+sR1W5kctNUXsipx7f/EFA/SKr/BlrzlT9af+l1ntxS0tAJTwvb8ul8Bh3kcdTCaknymLIPwsyGlNFlWkpMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ScjzFJ3i; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ScjzFJ3i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 904ADC4CEC4;
	Fri, 27 Sep 2024 09:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727429405;
	bh=NQf7+QpzoDAuDvR3lojHYXmnOqICjH6ZZUXhwQlwxTQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ScjzFJ3i8WArtva321lPwetZxW1xpR3cHvfebHeDsU9VzhNVBGN7TBm7UI9VqJPvW
	 +EM8SZGWF63RH9k/CZ2RxaZpTiSKSihN6cgRg2p2WgJbzqhwYd51vkeAm+IK/hm7g4
	 833OGNVebFKWaxLoI8E/dQKh9qMnFX1NMxsLiIuWZX8Z4vJ5SHxRJo3hg+WI3Rs57z
	 B6VyDcRXSAdfgGGSUbPQOy/vXpiH1bzsJeRP0ZHNC/Cb+rQilcLKKaYI0QwVjLdDnt
	 aB53+m3ZhKRbrBSZ0BBoaRdKe7Fc3h1362IARTc+9aYNzDbz+m82HKS9+NoTl8k2z/
	 YI7sNC620yfVg==
Date: Fri, 27 Sep 2024 11:30:02 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Macpaul Lin <macpaul.lin@mediatek.com>
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, CK Hu <ck.hu@mediatek.com>, Jitao shi <jitao.shi@mediatek.com>, 
	Tinghan Shen <tinghan.shen@mediatek.com>, Seiya Wang <seiya.wang@mediatek.com>, 
	Ben Lok <ben.lok@mediatek.com>, "Nancy . Lin" <nancy.lin@mediatek.com>, 
	dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	Alexandre Mergnat <amergnat@baylibre.com>, Bear Wang <bear.wang@mediatek.com>, 
	Pablo Sun <pablo.sun@mediatek.com>, Macpaul Lin <macpaul@gmail.com>, Sen Chu <sen.chu@mediatek.com>, 
	Chris-qj chen <chris-qj.chen@mediatek.com>, 
	MediaTek Chromebook Upstream <Project_Global_Chrome_Upstream_Group@mediatek.com>, Chen-Yu Tsai <wenst@chromium.org>
Subject: Re: [PATCH v3 5/5] dt-bindings: display: mediatek: dpi: correct
 power-domains property
Message-ID: <vo5ia2cprt2eff2frximgkjkapyavam65m5gjxpgbht76wacuk@sttamlbk3iu4>
References: <20240927065041.15247-1-macpaul.lin@mediatek.com>
 <20240927065041.15247-5-macpaul.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240927065041.15247-5-macpaul.lin@mediatek.com>

On Fri, Sep 27, 2024 at 02:50:41PM +0800, Macpaul Lin wrote:
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

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof

