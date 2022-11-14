Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768704C78
	for <iommu@lists.linux.dev>; Mon, 14 Nov 2022 14:21:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11D1EC43470;
	Mon, 14 Nov 2022 14:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1668435664;
	bh=V1BNY7UIADyWHVs3HzCQ76oze1s73lFOwOpF0l/m0+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hEnqaPP0clO/WXBeBVERbKedz+e5OFsRqR9WSsGcIdYOfJUKs6bIlHhjLgjYFaDNM
	 tf5nwpF23QQD9dBfcCQfLdFdvPZK8RYl7XarVMKLsm1KDZG5yCLGWevHMuUV4mu5M8
	 bOMg3GCf1WufxAWfy6gAP1n4+oGSQMQTqLrHV+Oex+Y5BOx26UbyeoA2eH5Xvu7G0a
	 7P973J32q6oOJDGAOR76jkc0kDI05OEfBKgacb7iTvxnHlyN0qZExD9IGvTJ1JJdbJ
	 74lrT1RSqnC4O8ob3pNbIlvKJzR9d7lH+9gp4Q7LKsVlLhRhsEte7LZwGX29OuYL4G
	 EWBAsG9hGUjyw==
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Richard Acayan <mailingradian@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v5 0/1] iommu: SMMU for SDM670
Date: Mon, 14 Nov 2022 14:20:54 +0000
Message-Id: <166843520961.2455954.5690901880353961653.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221111003606.126795-1-mailingradian@gmail.com>
References: <20221111003606.126795-1-mailingradian@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 10 Nov 2022 19:36:05 -0500, Richard Acayan wrote:
> Changes since v4:
>  - version bump to fix double v3 (0-1/1)
> 
> Changes since v3:
>  - drop driver patch (2/2)
> 
> Changes since v2:
>  - rewrite driver patch (2/2)
>  - rebase on (1/2):
>    https://lore.kernel.org/linux-iommu/20221102184420.534094-1-dmitry.baryshkov@linaro.org/
>  - reset review process (1-2/2)
> 
> [...]

Applied to arm64 (for-joerg/arm-smmu/bindings), thanks!

[1/1] dt-bindings: iommu: arm-smmu: add sdm670 compatible
      https://git.kernel.org/arm64/c/8d3a9ec6ae28

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
