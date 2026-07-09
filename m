Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643213EB0FF
	for <iommu@lists.linux.dev>; Thu,  9 Jul 2026 08:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783584831; cv=none; b=oiJDX6rFd8URvaFUsjdqamrcVXU+cjiEwfIrLbbSB/Xh4J5aUiJECIzYMV+/MZUofeMw0DgIYrHZeq4Vw1eqJhkIfq+72awIlP3UWyRM48WJy/Ny6lNS9cLL+gIp+ziV/IFbofsBrQ9Q2JpOygCZDLo+TzMWcZqCGjyggIFG73Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783584831; c=relaxed/simple;
	bh=mxWbfg2CRFtMMSW4SlKTs2sZO9/dEYLlqT3kbawGOE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oDPMArIhe5wQ5sVEC1jLpPeSAyS6kWpSWSE/luYLotLQccWPLOOAOrcAsmoMmPIE9RqJeVE2GzAlpnxTsruztOCXGPc1rNKNzYI+bS2FUyvoQcQuGymIk38Jpo62hYtCaRFy3wL5KOu4Ow821/IO3DzVrvL36AcTHwVayUJ2edo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p200300f6af4fc500c39e96c98da8598f.dip0.t-ipconnect.de [IPv6:2003:f6:af4f:c500:c39e:96c9:8da8:598f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 1AAEA203552;
	Thu,  9 Jul 2026 10:13:46 +0200 (CEST)
Date: Thu, 9 Jul 2026 10:13:44 +0200
From: "Joerg Roedel (AMD)" <joro@8bytes.org>
To: Akari Tsuyukusa <akkun11.open@gmail.com>
Cc: Yong Wu <yong.wu@mediatek.com>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Miles Chen <miles.chen@mediatek.com>, 
	Joerg Roedel <jroedel@suse.de>, "open list:MEDIATEK IOMMU DRIVER" <iommu@lists.linux.dev>, 
	"moderated list:MEDIATEK IOMMU DRIVER" <linux-mediatek@lists.infradead.org>, 
	"open list:ARM/Mediatek SoC support" <linux-kernel@vger.kernel.org>, 
	"moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] iommu/mediatek-v1: Fix off-by-one in MT2701_LARB_NR_MAX
Message-ID: <ak9YKsvML_WIXNhY@8bytes.org>
References: <20260629145946.312819-1-akkun11.open@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629145946.312819-1-akkun11.open@gmail.com>

On Mon, Jun 29, 2026 at 11:59:44PM +0900, Akari Tsuyukusa wrote:
>  drivers/iommu/mtk_iommu_v1.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.
