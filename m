Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3117E0E8
	for <iommu@lists.linux.dev>; Mon, 27 Oct 2025 12:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761568870; cv=none; b=QZaK6NsGStTAd5T03Xb7jy4hNmDe93QCEmXMSkPSttel8HoQSlXIFpYQcYmeJbLybLFQqO1TeSX6FvLu3QDQtl4uAp7VW1jctQRnzaooWB3UFJSeRiA+Sg3iQoB8MgIueo7E0ZmSG36kdTVfmlRKpF6eZ/fnmDgsyIw9lmUpbR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761568870; c=relaxed/simple;
	bh=igQFF0LAtPQV99bIr387rWS186dezYa19i/THLPhjSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=deKGHNlTLiDA5URGK2fEP+yE8cqtWvJa1WqFJSikpdmPpbRGfdtC1up71PgmhU1QLES5TqKwHD/PQ2eQNgB68YPCD0wZ2jqND2fra9Tr+GF8BctPd2nmJkgc1/dcfZNkl++FxDLtV5djNf0AlQxRF2fwm7s1lnz1G8vQ+NXfjZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=d4RjCFF5; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="d4RjCFF5"
Received: from 8bytes.org (p549214ac.dip0.t-ipconnect.de [84.146.20.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id B93D659903;
	Mon, 27 Oct 2025 13:41:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1761568866;
	bh=igQFF0LAtPQV99bIr387rWS186dezYa19i/THLPhjSw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d4RjCFF5lA02+c+sEf23kjw/bg91wHHikccPRvpR6HrVOR3MHLBgk8LUTsOYSfAc6
	 V/w0sk0gAu2fqxw65/HR1oWMLwmTDrOU9Ca3O1A7hI8i74ugs7/Sj091vlwq/R1aYa
	 OvoG1S5BArCYlJIYnZ/Jm6D9iTZ5tyfK/HSKwqkIdmtSKgSLMREKZl2IS8jRNyeBtE
	 h1qxTsGj2JJOAfF8Js7G12Z8TIijtiMV5Ggkl678X+Okc47GsHM7npqOmF2bzVUFBM
	 fyVDHQyILVtOMEGFu65TKOzTG8lCiASocuHDlXF1YkpAdgIsnIjoxaIBeEOOjH0uBW
	 kpji/5yNJuYcA==
Date: Mon, 27 Oct 2025 13:41:05 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Zhengnan Chen <zhengnan.chen@mediatek.com>
Cc: Yong Wu <yong.wu@mediatek.com>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, iommu@lists.linux.dev, linux-mediatek@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v2 0/5] MT8189 IOMMU SUPPORT
Message-ID: <xjzigctqrjzbfuneejicj5o6jppxdoous3iwmhhz6tfy62vnaa@zu4zsdlh26hx>
References: <20251015032509.5057-1-zhengnan.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015032509.5057-1-zhengnan.chen@mediatek.com>

On Wed, Oct 15, 2025 at 11:24:16AM +0800, Zhengnan Chen wrote:
> Zhengnan Chen (5):
>   dt-bindings: mediatek: mt8189: Add bindings for MM & APU & INFRA IOMMU
>   iommu/mediatek: Add a flag DL_WITH_MULTI_LARB
>   iommu/mediatek: mt8189: Add APU IOMMUs support
>   iommu/mediatek: mt8189: Add INFRA IOMMUs support
>   iommu/mediatek: mt8189: Add MM IOMMUs support
> 
>  .../bindings/iommu/mediatek,iommu.yaml        |   7 +
>  drivers/iommu/mtk_iommu.c                     | 132 +++++++-
>  .../memory/mediatek,mt8189-memory-port.h      | 283 ++++++++++++++++++
>  3 files changed, 409 insertions(+), 13 deletions(-)
>  create mode 100644 include/dt-bindings/memory/mediatek,mt8189-memory-port.h

Applied, thanks.
