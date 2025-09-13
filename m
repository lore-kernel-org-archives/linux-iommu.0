Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27B72E6CC4;
	Sat, 13 Sep 2025 06:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757743674; cv=none; b=HnpVlVYWoXeZIzOieVUvPfavsSMFfhb734ibyVUB4KsYneTxID5AhKJKGEXeroLzpvSutJdv0asDzjTJQ9au6XX7Top1hNWWSSmDhZ8Mhk8tgmc94Hp4VG8x5KK3DT2BeynhP8QFhPE9Ufw+pwRbUEyKIej4YfgBwqSTLJ0V4yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757743674; c=relaxed/simple;
	bh=IZAmRIn12H1ws1EBpMtxCKjZ7v/W9gcCO1MklaSOXk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gZrc8KMF+sxPQEmUBkIxBrTj5d8b6xG5oBewt1BuZoJAzcBJ4HnGl+xNNxhEMuJZSERfoSkML3Sd0OHIPQHlFS8jCRg0MB4CmawsQDASqQoAZlUKhZecqLDoSpm4+PWOeyvWoRO5/LSCgxNBIt7V3qwBf27U4E3CbNURkMjDpMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=2Astz+p3; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="2Astz+p3"
Received: from 8bytes.org (p54921b16.dip0.t-ipconnect.de [84.146.27.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id A91B850666;
	Sat, 13 Sep 2025 08:07:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1757743671;
	bh=IZAmRIn12H1ws1EBpMtxCKjZ7v/W9gcCO1MklaSOXk8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2Astz+p3RJR5KWmv0+YIQv3aDHwwsttywLL9GmMaJmELgV6Ua4ppoge0lyMlauI06
	 OrsHNKcE6Czahdah0QlI2S9GQgZjBY9UkTBoOfxHs48DrTyO5IRErDYOG5VSbnmas1
	 oL3BBCFsQCxBKicaZy6xqVADh4+qtCmAtBDzIkmNIIhEq3+fQ40z7bllYay5DLGPZw
	 hGwvAh9DVH/qjUyi808k9tjXeLqZRb68L/uh3Q0CnQapykQ1cRISJoTG/xMzChVh/k
	 1CLf1xeMzBywCjdW9wmN+vBtHliv6Q+sOBPenMIvFNjO6R/IalDxps56lfJbIRlwRR
	 tq0aTJHFiCPuw==
Date: Sat, 13 Sep 2025 08:07:50 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Janne Grunau <j@jannau.net>
Cc: Sven Peter <sven@kernel.org>, Neal Gompa <neal@gompa.dev>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Hector Martin <marcan@marcan.st>, Joerg Roedel <joerg.roedel@amd.com>, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH] iommu/io-pgtable-dart: Fix off by one error in table
 index check
Message-ID: <xae5ifnkyfh3idpuvjqxd2ui4lz2ptstozwiitl3xec2aroz4r@beni7t6fudbi>
References: <20250909-iommu-dart-tbl-check-fix-v1-1-c800a0375660@jannau.net>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909-iommu-dart-tbl-check-fix-v1-1-c800a0375660@jannau.net>

On Tue, Sep 09, 2025 at 01:54:43PM +0200, Janne Grunau wrote:
>  drivers/iommu/io-pgtable-dart.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.
