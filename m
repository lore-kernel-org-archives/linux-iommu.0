Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CD8B425
	for <iommu@lists.linux.dev>; Thu, 19 Jan 2023 19:09:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C1A4C4339B;
	Thu, 19 Jan 2023 19:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1674155352;
	bh=O8EqujrCDWQhmahEnByqQnxnFzoB7MH2mXsWRFN52Mw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OCBzneJO7dRED2v4lv2ZbSHg5WbBGmTFzqM4xK3fgpvoAEqu6ZLdZSbqmLpq9rtl6
	 wq48bNONYaZner6lsQGhqSyCcigU50swBn+xj6Fc88Odnxx7//YqyV39HWspRzFutz
	 TmISZKwnTn4Yd+m9uO3ifc86RAFQvExJBNk6LjBYs4qqnkjhP7LuVp6OdZda8LINL8
	 /EV5YaO5Jq4cgjcic3GOj/OrqX7eF1/xfPra7zdgbAky80nIvQBBNJ47ZtC+q9s3a2
	 P/qXEzv8p1ZLMC6mtVmv1gS+12nmVd2twa5t+ifz48XHz0mM33G5FHz2MFkqpGGSyJ
	 YGpsGmVUEtBtg==
From: Will Deacon <will@kernel.org>
To: linux-arm-kernel@lists.infradead.org,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-kernel@vger.kernel.org,
	Joerg Roedel <joro@8bytes.org>,
	devicetree@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	iommu@lists.linux.dev,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH] dt-bindings: arm-smmu: disallow clocks when not used
Date: Thu, 19 Jan 2023 19:08:38 +0000
Message-Id: <167415014318.2380979.10340725775001244773.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221222092355.74586-1-krzysztof.kozlowski@linaro.org>
References: <20221222092355.74586-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 22 Dec 2022 10:23:55 +0100, Krzysztof Kozlowski wrote:
> Disallow clocks for variants other than:
> 1. SMMUs with platform-specific compatibles which list explicit clocks
>    and clock-names,
> 2. SMMUs using only generic compatibles, e.g. arm,mmu-500, which have a
>    variable clocks on different implementations.
> 
> This requires such variants with platform-specific compatible, to
> explicitly list the clocks or omit them, making the binding more
> constraint.
> 
> [...]

Applied to will (for-joerg/arm-smmu/bindings), thanks!

[1/1] dt-bindings: arm-smmu: disallow clocks when not used
      https://git.kernel.org/will/c/3a3f20bae0ce

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
