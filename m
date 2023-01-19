Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB00B425
	for <iommu@lists.linux.dev>; Thu, 19 Jan 2023 19:09:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AA5AC433F1;
	Thu, 19 Jan 2023 19:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1674155355;
	bh=B6WQVoKviGDo5Lmu/PR7ZIGyspBOx43F6uoNLJC8g2c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LLfeub4rKI7vD91AaKS0pn8I21qqkeaKjwX0QRVRS1tbAkHNcFaTtb2xPyU9WAm7X
	 BV83IzRxLTsVKX4W9u2UI99FeicOcUFaqzzgjKPTU6Wdlx0BSjgpcY7ZkmdCqFoJml
	 OvowNVKJZkep78xI0532l/B4TGGe7NvKVPlet3S0L+hmd1QCu0rqBJP3zGiXhn6cnf
	 GEGofDcQyp1iWMdDegAmCxRd8rM96v121ESi4X5REp660nMaqm6DHfP8c7/eF/BNmS
	 UgdZcoTICI4sLLsFr7OhenHw/34XXPTQ6mCzavcliEE5hMkgpcQOMrcaAqIx5wFXvf
	 d8UzL0oJJgW+A==
From: Will Deacon <will@kernel.org>
To: iommu@lists.linux.dev,
	Luca Weiss <luca@z3ntu.xyz>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	~postmarketos/upstreaming@lists.sr.ht,
	devicetree@vger.kernel.org,
	Joerg Roedel <joro@8bytes.org>,
	phone-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Andy Gross <agross@kernel.org>,
	Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: [PATCH v5] dt-bindings: iommu: qcom: Add Qualcomm MSM8953 compatible
Date: Thu, 19 Jan 2023 19:08:39 +0000
Message-Id: <167414938328.2378422.11457059166338062006.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221105142016.93406-1-luca@z3ntu.xyz>
References: <20221105142016.93406-1-luca@z3ntu.xyz>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sat, 5 Nov 2022 15:20:17 +0100, Luca Weiss wrote:
> Document the compatible used for IOMMU on the msm8953 SoC.
> 
> 

Applied to will (for-joerg/arm-smmu/bindings), thanks!

[1/1] dt-bindings: iommu: qcom: Add Qualcomm MSM8953 compatible
      https://git.kernel.org/will/c/e3fed6861d86

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
