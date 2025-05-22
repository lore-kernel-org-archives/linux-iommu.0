Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A47E221D9B
	for <iommu@lists.linux.dev>; Thu, 22 May 2025 07:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747898011; cv=none; b=CRluxNH9ZwMKzcLkRZRtMJABe6zZakhsge6eismBeNC02cRpZxhgfVw52f/UfNddF4d7ti2wZ0h5BvZ8tT9UMSti8gXCr4hXfNRPeESDQiagj4F+zbX4D0FpO8fZQj32C7hYCZ4rXWNIYKLf3JxLtiKZ+zLuRcmEQlS2yGC9pIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747898011; c=relaxed/simple;
	bh=lHuXjtnGIwA8Zzr3bT7RPQh03xIe4TvMRJ0gk9Qtcas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=THSAAD1mAL8RttzriDFgp2IfzojCTxU6bBG6fcgNGmVrlRjMPTicBZEw5gr2xuXABnyJ+yckixNQH+Ma0a+D2k5iYK2oYpsDVNAJvJoUtTtwunWzslm+r+O34NZ8hkX1wJCua3NZx193ctdSdUBXuzv8dYZW5k+L24yvMfkRIgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=T6dWlTr2; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="T6dWlTr2"
Received: from 8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id E68E84B84B;
	Thu, 22 May 2025 09:13:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1747898008;
	bh=lHuXjtnGIwA8Zzr3bT7RPQh03xIe4TvMRJ0gk9Qtcas=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T6dWlTr2XT2GmGeCMyAcctcy1RpNQOI6pU+GjH0UCm9p0MJHc8NtF6tV1+D4/Q6Li
	 R9ClH9GUmx7loyp1mMfjWd45Rrroit0lBeMnsR2tp98VEZpFbm7BWuiMCp9CnOj6a6
	 RKAzvKkO0IFcoAB0kzGsyUhy4xyK4S+m2BGkuLSEgGNsauhZVyzBrjXz9/qv4S9CBd
	 j6m72ZsK8uvVz9nIxbxt/ZTTnVQ+I2Kt2pHHmc4wQv9kFrGiQ7Up8+oqsZY8XF+8ZO
	 Pl3TPP/1+QzvHlrxLyzFIXqqRDkLi5gI3jiZXeZyiloawz/nwhrJHThIZxEgKm5xOB
	 7uQj+O145Q5Vw==
Date: Thu, 22 May 2025 09:13:26 +0200
From: Joerg Roedel <joro@8bytes.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: yong.wu@mediatek.com, will@kernel.org, robin.murphy@arm.com,
	matthias.bgg@gmail.com, iommu@lists.linux.dev,
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kernel@collabora.com,
	robh@kernel.org
Subject: Re: [PATCH] iommu/mediatek: Fix compatible typo for
 mediatek,mt6893-iommu-mm
Message-ID: <aC7OlsGLaFvl6n95@8bytes.org>
References: <20250521151548.185910-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250521151548.185910-1-angelogioacchino.delregno@collabora.com>

Applied, thanks.
