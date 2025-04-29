Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01FC27702E
	for <iommu@lists.linux.dev>; Tue, 29 Apr 2025 07:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745911179; cv=none; b=pTJ2FOWxrsg9t2/WturqnyAYld6Hu6zArQsGYL7nPQSVJY3w3ugUTlQTJvqjmi2ZHunkt9lp7dNP0Wt34yGPss71zzTUjk06GyDtNntE2HFn3s5gB5BwfreYHbdS8gyIJAFlIuzBocjijshClcHCfv42KX/DSa4dRYKACgcyKFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745911179; c=relaxed/simple;
	bh=SAHCBDqNy6TGIiso+JyQ7s/5TRfR/sINY5mPMtICcBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KEEUFcBSaJCGC7l6gbwhtdgrPpElgIAEgJDhuxe4w1LcWAv37ll3yEClA/pCx7r+uSe4ie2XGQk4MPJjR70kmU4k+HW6xDfsatwIQYlRcDnr5W1r/mBYLpVZQaakHjRlS5pgfdtmXkmk+liMFBZ3H2Ls5nQqtpcnooVL0DfGISs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=RAU+z16i; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="RAU+z16i"
Received: from 8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 6FC5A4984C;
	Tue, 29 Apr 2025 09:19:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1745911176;
	bh=SAHCBDqNy6TGIiso+JyQ7s/5TRfR/sINY5mPMtICcBs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RAU+z16iXwywI8TGOQsk32M7p3Gfc92zxC2WRlGKloWG7+MDZiYeVNdH5dR7KYbeR
	 F2KV99ePFzh/4taISU/Nqnw6mT2lm10/qygFp9Zo5zan5QGddcoA94eEaLmMFIJx3X
	 ntXi/NIOipXJgaHm/3D7oWEwFnOxa1LxSIo9FRKZ5vHI8PhhxSAYvKTmSZv1r+/WqM
	 z6+Gi9W1XO7PyCsrvGEGOnGrJ2Ay2AQ09AB9sZ66fJ1cQ8W7q1IRMVQwQaup+hqpA8
	 Tg29+9drMTSK5VTid1qZoswToM0aRLtcT6kcoZtF4xg80dLFw7oCHv9g7L29bjbfcP
	 68EWEH8avQQOw==
Date: Tue, 29 Apr 2025 09:19:35 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Rob Herring <robh@kernel.org>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	yong.wu@mediatek.com, will@kernel.org, robin.murphy@arm.com,
	krzk+dt@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com,
	iommu@lists.linux.dev, linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v1 0/2] MediaTek Dimensity 1200 - Add IOMMU support
Message-ID: <aBB9h9CDPa6Ww4td@8bytes.org>
References: <20250410144008.475888-1-angelogioacchino.delregno@collabora.com>
 <aAETI0hrOiQZDKh2@8bytes.org>
 <20250428160227.GA1322286-robh@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250428160227.GA1322286-robh@kernel.org>

Hi Rob,

On Mon, Apr 28, 2025 at 11:02:27AM -0500, Rob Herring wrote:
> It looks like you missed the binding change for this.

Both patches from this series are in the tree now. Is something from
another series needed? In any case, if fixes are needed, please send
them on-top of this patch-set.

Regards,

	Joerg
