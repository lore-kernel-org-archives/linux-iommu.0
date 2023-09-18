Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A99B38F8E
	for <iommu@lists.linux.dev>; Mon, 18 Sep 2023 11:05:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9A3CC433C9;
	Mon, 18 Sep 2023 11:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695035155;
	bh=yLpITHOqBwaXWsLZuL6tIec5rcjO1kx3VfSTyZ+Wmug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UbqQQeUK0N3zM7tT8mb96q8JlwyOfxFaKI88Ga27R3zqfJnVTSVyiImG4/CUCHHbV
	 8lnSkNrzDSy0E5cgyA4oeCbvgant+dedJeLYbHt/TRkqcuj+BzFrxkT4D4lD9l+Uwy
	 xowWnIAhun/JkNPcgV6SadtHXFQyyn0qACD0FIylUoe6hmNr3CF49GmewHEMjvrLY6
	 cFhfXoLxNYJSo9FyxLRtQyEBryze45XBZhQxng9MJOY8O9SrVkP09xwHaCjrFLNFio
	 TwlnzXy5Q4CmOd+XGP2GlQWIi1w3rXKnwl4RL9G0aJboKgS9LDm9a3io/S15Tj5MCU
	 2o9iFTaC+2qug==
From: Will Deacon <will@kernel.org>
To: joro@8bytes.org,
	Robin Murphy <robin.murphy@arm.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	Rui Zhu <zhurui3@huawei.com>,
	eahariha@linux.microsoft.com
Subject: Re: [PATCH] iommu/arm-smmu-v3: Avoid constructing invalid range commands
Date: Mon, 18 Sep 2023 12:05:22 +0100
Message-Id: <169502858467.264332.7820981729907746151.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <b99cfe71af2bd93a8a2930f20967fb2a4f7748dd.1694432734.git.robin.murphy@arm.com>
References: <b99cfe71af2bd93a8a2930f20967fb2a4f7748dd.1694432734.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 11 Sep 2023 12:57:04 +0100, Robin Murphy wrote:
> Although io-pgtable's non-leaf invalidations are always for full tables,
> I missed that SVA also uses non-leaf invalidations, while being at the
> mercy of whatever range the MMU notifier throws at it. This means it
> definitely wants the previous TTL fix as well, since it also doesn't
> know exactly which leaf level(s) may need invalidating, but it can also
> give us less-aligned ranges wherein certain corners may lead to building
> an invalid command where TTL, Num and Scale are all 0. It should be fine
> to handle this by over-invalidating an extra page, since falling back to
> a non-range command opens up a whole can of errata-flavoured worms.
> 
> [...]

Applied to will (for-joerg/arm-smmu/fixes), thanks!

[1/1] iommu/arm-smmu-v3: Avoid constructing invalid range commands
      https://git.kernel.org/will/c/eb6c97647be2

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
