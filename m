Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2009A101C9;
	Mon,  7 Aug 2023 12:28:37 +0000 (UTC)
Received: from 8bytes.org (pd9fe94eb.dip0.t-ipconnect.de [217.254.148.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id D568B2802C0;
	Mon,  7 Aug 2023 14:28:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1691411317;
	bh=Zf7mBjtKumP8S/ql7gFmyW5785yudzSFvZ6h4B2GBmw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N+Fusk53UgSQxfDMm5/1mvjjk+EoXfNDGrX1RWXalVYnCZciXaflypYS/1a4YXRIa
	 no0MzYQ8/XTsXFbV2XYR6EaxLl18vnGCGvESY6Oh6lR7TavG9w86qELIfDwd/IQ5l8
	 z65tqvKzGMTnZD+9GJJHeCh7Omq1kWiaA4DKtBRZabkx1D0nF1z0zHNyxBSHwqQIHV
	 W70SfT42fM51+n2Du+dCIoONYmnPl3uWnMt3q0vBk1IToz4HS//OjI3UtMU2hTKRZ/
	 OPIlfxpmyQea7QuM152P/UrnYUNEd1qW5qG4f+lD0M+CHzjbzSSEI4Q4QFjSTVV2XM
	 6k6WT0KizjpVA==
Date: Mon, 7 Aug 2023 14:28:35 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Min-Hua Chen <minhuadotchen@gmail.com>
Cc: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iommu/apple-dart: mark apple_dart_pm_ops static
Message-ID: <ZNDjc0XdP9MnNyxr@8bytes.org>
References: <20230720232155.3923-1-minhuadotchen@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720232155.3923-1-minhuadotchen@gmail.com>

On Fri, Jul 21, 2023 at 07:21:54AM +0800, Min-Hua Chen wrote:
> Signed-off-by: Min-Hua Chen <minhuadotchen@gmail.com>
> Acked-by: Sven Peter <sven@svenpeter.dev>

Applied, thanks.
