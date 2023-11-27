Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE956182A2;
	Mon, 27 Nov 2023 10:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="4YRrXkYs"
Received: from 8bytes.org (p4ffe1e67.dip0.t-ipconnect.de [79.254.30.103])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 69D241A6E90;
	Mon, 27 Nov 2023 11:18:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1701080290;
	bh=+9XZsv2MkSw2ep1fiHnmE+Po3/h00hYAxkvBiSQeloM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=4YRrXkYsLXB/rmy11VvYsY25P6pCK+6+3Ojbhgxhg6yTy/v6TkybXY0SdX6BCgdRh
	 8rrpUJL6ZIB/CqY1o+pRDED2bhBhRHRJBP23HHKhg558PYeKkEr10gqtbPn+zyqMZM
	 mJL8Bukn/4rgHn/qhAxi57iov5BKqBJ1rLW5sqoaN0psxHPl/gSsdKWIHlAVuCQ0CD
	 4bzApBKojQ0a58dFXER37NOtMLculE+C9Wkzg6DBnE0uJ4HWmIyz2UMJV0Aiii/vnL
	 NFRcD9u1dqhy9SOYz/bIHesVLkxNwvqha3JgvF5GTwb5QTygTnAJM2SNRNLggNfsAz
	 PZ+amGWVqZQaQ==
Date: Mon, 27 Nov 2023 11:18:08 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Sven Peter <sven@svenpeter.dev>
Cc: Hector Martin <marcan@marcan.st>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu: dart: Use readl instead of readl_relaxed for
 consistency
Message-ID: <ZWRs4Cq_X8Bm3btp@8bytes.org>
References: <20231126162009.17934-1-sven@svenpeter.dev>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231126162009.17934-1-sven@svenpeter.dev>

On Sun, Nov 26, 2023 at 05:20:09PM +0100, Sven Peter wrote:
> While the readl_relaxed in apple_dart_suspend is correct the rest of the
> driver uses the non-relaxed variants everywhere and the single
> readl_relaxed is inconsistent and possibly confusing.
> 
> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> ---
>  drivers/iommu/apple-dart.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

In the future, can you please use "iommu/apple-dart:" as the prefix for
you patch subject-lines? That fits better into the overall convention in
the iommu-tree, thanks.

Regards,

	Joerg
