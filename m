Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBA1B425
	for <iommu@lists.linux.dev>; Thu, 19 Jan 2023 19:09:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61705C433EF;
	Thu, 19 Jan 2023 19:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1674155361;
	bh=L96CiyxDqJQ1R3tSGxtY8MIZKLSX74xqYGN6oYu3uJw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pvwiCEhA4FKeukST+Pm8eh/01rTbHQ19Mcd3hpODmzZ2H76O6lZZ0qzsXVMkTK8Pd
	 WffM7EFzIMPUtEQkB8IiS2MyzPDU0r/y9Qcb393Bix5vyGEhd0jAZW4x+MqVSaiJuu
	 WmN0Zakt4hsyNtLCebhnns02keHskm3gYg9H+vodk+aEn8tckO713zN7j24IB+Aujy
	 c2RPAQCfTLBO/+Yhjk5ixriW5u8XKzfgpymWu1p84qQcM5oVS565p5rMZSzNTP+CTK
	 zaXCoTtjKlm1Vtq9ETIPeg6A9vrWiXHVpaunCNEhj06Ul5NrmCZ7ipg3eOzmG/2xSc
	 MGWT3q9pDLc9A==
From: Will Deacon <will@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	phone-devel@vger.kernel.org
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Konrad Dybcio <konrad.dybcio@somainline.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
	Martin Botka <martin.botka@somainline.org>,
	Thierry Reding <treding@nvidia.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	Lux Aliaga <they@mint.lgbt>,
	Jami Kettunen <jami.kettunen@somainline.org>,
	devicetree@vger.kernel.org,
	Douglas Anderson <dianders@chromium.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Melody Olvera <quic_molvera@quicinc.com>,
	Andy Gross <agross@kernel.org>,
	Bhupesh Sharma <bhupesh.sharma@linaro.org>,
	iommu@lists.linux.dev,
	~postmarketos/upstreaming@lists.sr.ht,
	Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH v5 0/4] arm64: dts: qcom: sm6125: Enable APPS SMMU
Date: Thu, 19 Jan 2023 19:08:40 +0000
Message-Id: <167415032929.2381501.12211116927490999924.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221222193254.126925-1-marijn.suijten@somainline.org>
References: <20221222193254.126925-1-marijn.suijten@somainline.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 22 Dec 2022 20:32:50 +0100, Marijn Suijten wrote:
> Add APPS SMMU to SM6125 dtsi and use it in SDHCI/USB nodes.
> 
> Changes since v4:
> 
> - Use hexadecimal 0x0 for iommu mask;
> - Add sm6125 to the dt-bindings list without clocks, now depending on:
>   https://lore.kernel.org/linux-arm-kernel/20221222092355.74586-1-krzysztof.kozlowski@linaro.org/
> 
> [...]

Applied first patch to will (for-joerg/arm-smmu/bindings), thanks!

[1/4] dt-bindings: arm-smmu: Document smmu-500 binding for SM6125
      https://git.kernel.org/will/c/c940c8787929

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
