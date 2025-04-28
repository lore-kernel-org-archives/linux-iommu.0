Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D3D2309A3;
	Mon, 28 Apr 2025 16:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745856150; cv=none; b=JOkdu0bxDIL1AXQ4ZoWjKAiKdQ4RC5H/eNY61R6n6h68PIsPQZPfvLIcS58i7yRTLnetUZGnUZpd8S/OJLuzGfqhgocNmjz8fN70AE0otcU1KH55x3QZZFApddkAj9t9kK+AJr9R2uaolHbpotiIenGlXf7aYyEj1gpnCcEsPsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745856150; c=relaxed/simple;
	bh=+F0aVRE/fg2cXsJEag0GSt3k1+oaEiHh7xyT0ADeQLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aoMYuUKx5CWarWz9kh2SU5oLHwK6ZBmE9rdfvvfpc+CMl8uy+cjeCgonivA2SqnSXVNs6Ohtq3e8cyfy0xSlmQGnQwWd9QqikggJ3LR3iOSwBnhorS8Ih2P5aqbpIZcF9p+RPpYWuWyKl+LYR8/w3paxdqJoTld62A6lsLoMtLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lak2ghek; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lak2ghek"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DE4BC4CEE4;
	Mon, 28 Apr 2025 16:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745856149;
	bh=+F0aVRE/fg2cXsJEag0GSt3k1+oaEiHh7xyT0ADeQLk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lak2ghekf9IwpvNw+4iqdf4xfsEY5Nf4Us9kuj/97WrdrGRHp0J3qTNy3euMa9p+y
	 LJV5omJuB8I35eAT0FHrnfyhcFsn7xk+qoZg1b4ccWIErsCZVbN7B8A8iGPM5llymD
	 RH9GzhZgZAA8fG1hHedgK37evt0yOKKD3GlK/44uU13bPO019zjAEgxwYbKc4Qr5pO
	 4Gbx4cP9YQEKq352qKATJjERjf58sW7HSCCGzQ8E9wYxeCfiLrkTNGsule4ZJva9qS
	 +hXyDH79pbBgjP6nFRrEHsA7mXYwEABGEu2HofPHuSifXHKUnRvB1/vIKytbr6Yp0C
	 FAtQlXV61XXsQ==
Date: Mon, 28 Apr 2025 11:02:27 -0500
From: Rob Herring <robh@kernel.org>
To: Joerg Roedel <joro@8bytes.org>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	yong.wu@mediatek.com, will@kernel.org, robin.murphy@arm.com,
	krzk+dt@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com,
	iommu@lists.linux.dev, linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v1 0/2] MediaTek Dimensity 1200 - Add IOMMU support
Message-ID: <20250428160227.GA1322286-robh@kernel.org>
References: <20250410144008.475888-1-angelogioacchino.delregno@collabora.com>
 <aAETI0hrOiQZDKh2@8bytes.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aAETI0hrOiQZDKh2@8bytes.org>

On Thu, Apr 17, 2025 at 04:41:39PM +0200, Joerg Roedel wrote:
> On Thu, Apr 10, 2025 at 04:40:06PM +0200, AngeloGioacchino Del Regno wrote:
> > In preparation for adding basic support for the OnePlus Nord 2 5G
> > DN2103 smartphone, this series adds support for the IOMMU found in
> > the MediaTek Dimensity 1200 (MT6893) SoC.
> > 
> > AngeloGioacchino Del Regno (2):
> >   dt-bindings: iommu: mediatek: Add binding for MT6893 MM IOMMU
> >   iommu/mediatek: Add support for Dimensity 1200 MT6893 MM IOMMU
> > 
> >  .../bindings/iommu/mediatek,iommu.yaml        |   4 +
> >  drivers/iommu/mtk_iommu.c                     |  37 ++-
> >  .../memory/mediatek,mt6893-memory-port.h      | 288 ++++++++++++++++++
> >  3 files changed, 318 insertions(+), 11 deletions(-)
> >  create mode 100644 include/dt-bindings/memory/mediatek,mt6893-memory-port.h
> 
> Applied, thanks.

It looks like you missed the binding change for this.

Rob
