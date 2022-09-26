Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7AE47B;
	Mon, 26 Sep 2022 11:50:21 +0000 (UTC)
Received: from 8bytes.org (p549ad5ad.dip0.t-ipconnect.de [84.154.213.173])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 43A8740790;
	Mon, 26 Sep 2022 13:50:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1664193020;
	bh=r73YqNLvS8xHDKysKOJqND3w7M8xnHB11lZ7x7MZsy0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AMQwYRjNqHisYDOdEKxfFWu/gkexU4GnmoMnLqLBILbna6Za7HO7Ji5SOe5sYmDNk
	 xNaq5Mex9DFyC0BhmJrOzf31cVPZlnG4NGaretAaYcmrZgckXf2OQ9saU4FeP02qKp
	 2DsUCBDKCjEWD5DCi2c1Nj9m2ZlfYLodUYNIlpGTKdiggpljJMedyQahQH7+7G/nT6
	 WYjzN5NFA8omNpppCh3FGvZhjkkwRdUlZ99GJ9o7Omip2kr8Xb+3pG9bbDkNOxj1Ov
	 pWeK8kjaEfnnOkab1YQTYkB3hmfFfT/WHQfcFjNx2wPWBn2G+71Egld2yEQXIBWBg7
	 iQ7InYik2HAQA==
Date: Mon, 26 Sep 2022 13:50:19 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Janne Grunau <j@jannau.net>
Cc: iommu@lists.linux.dev, Konrad Dybcio <konrad.dybcio@somainline.org>,
	asahi@lists.linux.dev, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Hector Martin <marcan@marcan.st>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Mark Kettenis <mark.kettenis@xs4all.nl>,
	Rob Herring <robh+dt@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Sven Peter <sven@svenpeter.dev>, Will Deacon <will@kernel.org>,
	devicetree@vger.kernel.org, iommu@lists.linux-foundation.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/5] iommu: M1 Pro/Max DART support
Message-ID: <YzGR+y1YFc0Kw1Rd@8bytes.org>
References: <20220916094152.87137-1-j@jannau.net>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220916094152.87137-1-j@jannau.net>

On Fri, Sep 16, 2022 at 11:41:47AM +0200, Janne Grunau wrote:
> Janne Grunau (1):
>   iommu/io-pgtable: Move Apple DART support to its own file
> 
> Sven Peter (4):
>   dt-bindings: iommu: dart: add t6000 compatible
>   iommu/io-pgtable: Add DART subpage protection support
>   iommu/io-pgtable-dart: Add DART PTE support for t6000
>   iommu: dart: Support t6000 variant

Applied patches 2-5 for v6.1, thanks everyone.
