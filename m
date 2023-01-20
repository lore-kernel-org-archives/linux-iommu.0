Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC808BD3D;
	Fri, 20 Jan 2023 09:36:22 +0000 (UTC)
Received: from 8bytes.org (p200300c27714bc0086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:7714:bc00:86ad:4f9d:2505:dd0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id A827D262AAF;
	Fri, 20 Jan 2023 10:36:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1674207381;
	bh=E27B5P92vamwc0WgGeMPoDYf0t5y2F4XmTYYeL00rZY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=7wgFBMnyfil5Ub6uuA3bZ1Cb6XNhWuaz4uatZCFKatC8jTWgGw68EmRMKxrCn7vBP
	 9Es1c2D7sA4pg+Rza5dsGnDW6Y97UgWLWwOF+OBdK1k1CkKu9HhdsCPdRY8a3sHtCg
	 Q1t3w7lRYtJ340kn9XB8/nI1q0mz7D/I9AXXhlTNIvNtnlaq6Ot5RycICBRaYRLZ7a
	 Uqkyfknre+kYfNgRTd7uDVtIeLGFohhYzAywWzBdHVauvD6s8UMgvWPjPlBOlquBtX
	 frT5CwJ1RGsEkMc8LVXhuj+NLmHPwCOwu8MdSOlu04XbbDebn2bRewVqfFV7FnikOa
	 hdp1iXe66ESwQ==
Date: Fri, 20 Jan 2023 10:36:20 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Hector Martin <marcan@marcan.st>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Janne Grunau <j@jannau.net>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	devicetree@vger.kernel.org, iommu@lists.linux.dev,
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] iommu: dart: Apple t8110 DART support
Message-ID: <Y8pglA0vvtZmKKnx@8bytes.org>
References: <20230113105029.26654-1-marcan@marcan.st>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113105029.26654-1-marcan@marcan.st>

On Fri, Jan 13, 2023 at 07:50:23PM +0900, Hector Martin wrote:
> Hector Martin (7):
>   dt-bindings: iommu: dart: add t8110 compatible
>   iommu: dart: Add suspend/resume support
>   iommu: dart: Support >64 stream IDs
>   iommu: dart: Support a variable number of TTBRs per stream
>   iommu: dart: Fix DART_PARAMS1/2 bit define names
>   iommu: dart: Support different variants with different registers
>   iommu: dart: Add t8110 DART support
> 
>  .../devicetree/bindings/iommu/apple,dart.yaml |   1 +
>  drivers/iommu/apple-dart.c                    | 557 ++++++++++++++----
>  2 files changed, 448 insertions(+), 110 deletions(-)

Applied, thanks Hector.
