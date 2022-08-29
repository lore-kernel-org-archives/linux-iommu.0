Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E706100
	for <iommu@lists.linux.dev>; Mon, 29 Aug 2022 23:46:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E13DC433D6;
	Mon, 29 Aug 2022 23:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1661816777;
	bh=+VvePBFLp/LWmK5hX6RIjAP6zHRRsMudqWZ6EI8ufAk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BEUFplEohMizRY5cMmxOHX5fEqyEQp1OOmKmxtPpmCx/tDNAJRtzpsc3cnZ6Zz9nt
	 NFeXcVoAOSpjyB3BN4Tn669fMPUe7CRfsrTq0EJglgoSO8V1UJce1rc5QTl2d0YEik
	 1cxbbMZ1dm16q+rZzR7k+izR1LqEi5aTHvPx3E7Tu8fFfAgv7xOEVCBYPHFgLG4yPC
	 xlI66+r26noL8Wo9denx0EXkWNsVPwfg1gNf5O8cv/lmzktFdH9lccrcTwX9ipbRoA
	 LMa3PIaOd+stnvWxcLv8shrEP3l31Wu1lBl2AalOkd70k0dWRxnFgVL6M2dMwlhkSq
	 cY7NJzt/xL3jw==
From: Bjorn Andersson <andersson@kernel.org>
To: a39.skl@gmail.com
Cc: linux-pm@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	vkoul@kernel.org,
	linux-arm-msm@vger.kernel.org,
	will@kernel.org,
	~postmarketos/upstreaming@lists.sr.ht,
	iommu@lists.linux.dev,
	konrad.dybcio@somainline.org,
	devicetree@vger.kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	agross@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	robdclark@chromium.org,
	loic.poulain@linaro.org,
	rafael@kernel.org,
	dmaengine@vger.kernel.org,
	bhupesh.sharma@linaro.org,
	phone-devel@vger.kernel.org,
	robin.murphy@arm.com,
	Viresh Kumar <viresh.kumar@linaro.org>,
	ulf.hansson@linaro.org,
	emma@anholt.net,
	robh+dt@kernel.org,
	joro@8bytes.org,
	linux-kernel@vger.kernel.org,
	quic_saipraka@quicinc.com
Subject: Re: (subset) [PATCH 0/7] Compatibles for SM6115
Date: Mon, 29 Aug 2022 18:45:38 -0500
Message-Id: <166181675976.322065.5888575144597732401.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220815100952.23795-1-a39.skl@gmail.com>
References: <20220815100952.23795-1-a39.skl@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 15 Aug 2022 12:09:38 +0200, Adam Skladowski wrote:
> This patch series add bunch of compatibles in preparation
> for sending device tree patches for Snapdragon 662 SoC
> 
> Adam Skladowski (7):
>   dt-bindings: dmaengine: qcom: gpi: add compatible for SM6115
>   dmaengine: qcom: gpi: Add SM6115 support
>   dt-bindings: mmc: sdhci-msm: Document the SM6115 compatible
>   cpufreq: Add SM6115 to cpufreq-dt-platdev blocklist
>   dt-bindings: arm-smmu: Add compatible for Qualcomm SM6115
>   iommu/arm-smmu-qcom: Add SM6115 support
>   dt-bindings: firmware: document Qualcomm SM6115 SCM
> 
> [...]

Applied, thanks!

[7/7] dt-bindings: firmware: document Qualcomm SM6115 SCM
      commit: f2567b732b0aa2160228a956e0c2007feaeb4b64

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
