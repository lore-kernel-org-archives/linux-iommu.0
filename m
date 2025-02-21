Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE0D1FBEA3;
	Fri, 21 Feb 2025 11:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740136048; cv=none; b=BVE0CMqbuyjwe4PTeBYa3ukUjnMQ2Y5CtvhToIu7bs2vfOb7CIp8RXkwCg6IzaVtEOoWCByHlaVrwNhZy9hXxPK5Jw7zm9tBvht5w0M4qxlOtEnVcqjtB1ZQkS+kq2y+GVokTKZ5YoDl52moedyZ4Si+LE2ZiS2qCiLK+M3MMPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740136048; c=relaxed/simple;
	bh=OrLEWszAt2g2+uaXn+6b7I4pNNFvvjaXQB2Xr3LTA2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iYfa5T9L6RKsiO47ou+3bT8b3s3/cpJ2qO3XdRM3mZklZDUEqHIdmDB8l4GBwDF2i9VD0DyAiWQzlObmX6ty2X4atHZj0Rb5xNMbhN5eB9VZbV2ZYFJEwfic+4ZhhKKDO0nyRD1JLasMxwb9xRTAr/Z3k70Jl7r2fHE9+HMIju4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=2M5E8KCT; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="2M5E8KCT"
Received: from 8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id D0A7843239;
	Fri, 21 Feb 2025 12:07:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1740136045;
	bh=OrLEWszAt2g2+uaXn+6b7I4pNNFvvjaXQB2Xr3LTA2k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2M5E8KCTzPNGrxqs18aAYCoIl9eUVImV5UHpfOg207LBMzwJYHq1CoQ+EYEvq/9rO
	 dpQSRoMk/9zo7qNj8B4FNOZQJNsqmeHj9AWt43J7ZExMLvvPAEQxoKyGzs+K8z9DEx
	 Ir+VvoMd8L3YLXlACO0Y9QrbmM1CDMUDLzjcp10d18ABnhXJNaqwbabuCruA4iuBJS
	 X//lPVrj7j8NvfhEOAHJZ367reL5bJfnWXqK19e1vAuErHMMZbkOtyelvTSbJFdyk1
	 R/Lpd8AvFuDFWxE1g5kxqJ/tXLRBTFoyLqVlGDNlaciO+07SKvzk3FD8T1TTmdDCa7
	 F/IjpeYoedklA==
Date: Fri, 21 Feb 2025 12:07:23 +0100
From: Joerg Roedel <joro@8bytes.org>
To: fnkl.kernel@gmail.com
Cc: Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Hector Martin <marcan@marcan.st>, Rob Herring <robh@kernel.org>,
	Janne Grunau <j@jannau.net>, Joerg Roedel <jroedel@suse.de>,
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Asahi Lina <lina@asahilina.net>
Subject: Re: [PATCH] iommu/io-pgtable-dart: Only set subpage protection
 disable for DART 1
Message-ID: <Z7hea_LY7u_7_jTw@8bytes.org>
References: <20250219-dart2-no-sp-disable-v1-1-9f324cfa4e70@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219-dart2-no-sp-disable-v1-1-9f324cfa4e70@gmail.com>

On Wed, Feb 19, 2025 at 10:13:53AM +0100, Sasha Finkelstein via B4 Relay wrote:
> From: Asahi Lina <lina@asahilina.net>
> 
> Subpage protection can't be disabled on t6000-style darts,
> as such the disable flag no longer applies, and probably
> even affects something else.
> 
> Fixes: dc09fe1c5edd ("iommu/io-pgtable-dart: Add DART PTE support for t6000")
> Signed-off-by: Asahi Lina <lina@asahilina.net>
> Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
> ---
>  drivers/iommu/io-pgtable-dart.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.
