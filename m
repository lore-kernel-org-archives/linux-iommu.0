Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCD9B425
	for <iommu@lists.linux.dev>; Thu, 19 Jan 2023 19:09:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8751C433D2;
	Thu, 19 Jan 2023 19:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1674155343;
	bh=zKK7KA/JQfolidaNtbY3feQpRtZLn9EFEEG6Eysigx0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o0I5Bt196X0bbtQoLHGnPFN6S849QBRpf6xqTp4xIMmLBv5XrnlXSi/KhIoiiwljH
	 WdtspNBxzEu6AyRkL89qd+8GHku0BJje1eGnKW3wwW7YpnqUMnbIjsAjcKLim1H2Bi
	 h5I9h52+XockiPFF7bXhc6TsMX/gjBw2YWff1XeHtvoWuWjShjmGg00TzBNjHzzyD5
	 ds6y5gbgzOiMS0jQjrOb0ccTQgLk6OWD6Xlsem8ySZzlJRCtjjdOoDRMTFerTNp9Xr
	 4chM+RQzVhM/ynYu/0w8qvcmj6kfJVdqxcVyMvk57H/C/bAuXyhKylYCiMo34Ykes4
	 F//FIdYVvb9eg==
From: Will Deacon <will@kernel.org>
To: andersson@kernel.org,
	krzysztof.kozlowski@linaro.org,
	linux-arm-msm@vger.kernel.org,
	agross@kernel.org,
	Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	marijn.suijten@somainline.org,
	Rob Herring <robh+dt@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	devicetree@vger.kernel.org,
	iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 1/2] dt-bindings: arm-smmu: Add sm8150-smmu-500 to the list of Adreno smmus
Date: Thu, 19 Jan 2023 19:08:35 +0000
Message-Id: <167414923855.2378053.16960006661915632479.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221213002626.260267-1-konrad.dybcio@linaro.org>
References: <20221213002626.260267-1-konrad.dybcio@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 13 Dec 2022 01:26:25 +0100, Konrad Dybcio wrote:
> From: Marijn Suijten <marijn.suijten@somainline.org>
> 
> sm8150 has an smmu-500 specifically for Adreno, where the GPU is allowed
> to switch pagetables.  Document the allowed 3-compatibles for this,
> similar to sc7280 and sm8250.
> 
> 
> [...]

Applied to will (for-joerg/arm-smmu/bindings), thanks!

[1/2] dt-bindings: arm-smmu: Add sm8150-smmu-500 to the list of Adreno smmus
      https://git.kernel.org/will/c/58499c0fd22c

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
