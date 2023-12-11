Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7824208DF;
	Mon, 11 Dec 2023 14:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="0+AhFQH1"
Received: from 8bytes.org (p4ffe1e67.dip0.t-ipconnect.de [79.254.30.103])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 5ED261A367B;
	Mon, 11 Dec 2023 15:42:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1702305755;
	bh=wKD1DsQaiTgywzlVHLaJwdfwwxmFpo+Zt21eDIlz2CI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0+AhFQH1wPogqKg67e1JEaiJg745C9js2v9TdhpvbOkZXYxEBm79UkKR52gD7YDXf
	 1td4YdH0NLUoESa1Iq2c9r9SNFfDJI1ie5bu7/bxwdFR/xkjnZrr2ogsmX8T/t9wpW
	 NWzn3t6edKbTjoLetjerEy6Z6MP5wheSH4QuG1bVJWmags8+LYpHM7f+TVy7t6dBIu
	 9Sey2qUVC3jy0gg0tHWh60Htv5UfvCu1CXCreAfiwlxPl068PHv8HVJkMg+o8QpzR5
	 CBuHMlsQjApEFC9ejcrjZuooP24zMeNa6A+3xtNL5BtyTXA7Aw16QrOYFl1dQJQOIB
	 niDT8zIVptMnw==
Date: Mon, 11 Dec 2023 15:42:34 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] iommu/apple-dart: Fix spelling mistake "grups" ->
 "groups"
Message-ID: <ZXcf2nB9enlctvTF@8bytes.org>
References: <20231209231240.4056082-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231209231240.4056082-1-colin.i.king@gmail.com>

On Sat, Dec 09, 2023 at 11:12:40PM +0000, Colin Ian King wrote:
> There is a spelling mistake in a dev_err message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/iommu/apple-dart.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

