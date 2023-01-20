Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027B417D7;
	Fri, 20 Jan 2023 09:18:12 +0000 (UTC)
Received: from 8bytes.org (p200300c27714bc0086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:7714:bc00:86ad:4f9d:2505:dd0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id DF8062626D1;
	Fri, 20 Jan 2023 10:18:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1674206286;
	bh=0Jggag92EktR6/A5U6dVytzRh4SjEmFN+pZTvEn3QwE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0XYypUJNJga6pEulJFmkZ03itRN0tzmcvhtN1jqw8rJQX7n8/zEhjsNHE9ASxwIGh
	 egzpfc9TIlyf99mfTLEsN6BP0eIz9KHUcD3hrlqIghum0bC4Y9q2PvTygLcD71RpYP
	 NL+KIO1CfE8HXbGqVLjWYygmEm+GC0LHJyawOdP9a84o/Ub+WvvGYVqCsC0nw7Wy9o
	 mwNCruhoUo7oWsZmPb81ywRPToh3iawGC36U5B29FHgmXp/ARfSeuro3wcyumy8/hO
	 O42YzReF2LFY1RCtx6yKEzo1b7uLjusBf+/EV1Wku1xRWJ77v2w23NJuyH8QH0vV3I
	 9iIsyjrCT+tQg==
Date: Fri, 20 Jan 2023 10:18:04 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Samuel Holland <samuel@sholland.org>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Maxime Ripard <mripard@kernel.org>
Subject: Re: [PATCH v2 6/6] riscv: dts: allwinner: d1: Add the IOMMU node
Message-ID: <Y8pcTPHjqXuWXmsR@8bytes.org>
References: <20230103010903.11181-1-samuel@sholland.org>
 <20230103010903.11181-7-samuel@sholland.org>
 <Y8F6NxYpJELbvogC@8bytes.org>
 <9a36551c-225c-137c-9376-ad7306c7f3d0@sholland.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a36551c-225c-137c-9376-ad7306c7f3d0@sholland.org>

On Sat, Jan 14, 2023 at 11:17:06AM -0600, Samuel Holland wrote:
> The D1/D1s/T113 devicetree is added by this series[1], which will be
> merged through the sunxi -> soc tree. That patch is included to show how
> the new compatible string is used, and that the driver changes have been
> tested. You can ignore it when merging the binding/driver changes. The
> rest of the series should apply cleanly to v6.2-rc3.

Thanks for clarifying. Patches 1-5 are now applied.
