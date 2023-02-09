Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4080627
	for <iommu@lists.linux.dev>; Thu,  9 Feb 2023 04:22:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A777AC433A4;
	Thu,  9 Feb 2023 04:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1675916524;
	bh=6a8IHCccFNXAqRbdKPys5PCrGXhM//ox9j3YLmVPDYY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lbFOz4zaaTcQ19ymnxXHyCOL2Kx6Md/2lqVLvfsCZy2Y49Mdy2REkslp2kf57ZnJ+
	 qY+Ej7GN+1O+l+DhggGB20on1OgfTy4senOqv1+egENUEWASMRYjiMuYt0tDsnc/TG
	 d3E+8tjeE8q1Stl0XOpwhSetg8keMws7DDOPUyAYmZi3zptb3pHh8Blo8KAz5OwdSu
	 NSHYxYVPh3ZU+D52EP5weulVuLpwCnjsE1hBaeOqNytE7b41gT64BUewuOmwEGqgKI
	 JWbLF3DTaZKmaYrDSU0oBMa5UE9OzvftqrH1jYM0girzhUiarxzI3FgOyPD3Mrn90O
	 FKOnjUk9VATMQ==
From: Bjorn Andersson <andersson@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	robh+dt@kernel.org,
	joro@8bytes.org,
	krzysztof.kozlowski+dt@linaro.org,
	will@kernel.org
Cc: konrad.dybcio@linaro.org,
	devicetree@vger.kernel.org,
	dmitry.baryshkov@linaro.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: (subset) [PATCH 0/3] Fix SMMU on SDX55 and SDX65
Date: Wed,  8 Feb 2023 20:23:20 -0800
Message-Id: <167591660366.1230100.12722515257767815828.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230123131931.263024-1-manivannan.sadhasivam@linaro.org>
References: <20230123131931.263024-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 23 Jan 2023 18:49:28 +0530, Manivannan Sadhasivam wrote:
> Both SDX55 and SDX65 SoCs are using the Qcom version of the ARM SMMU-500
> IP. Even though the SoC specfic compatibles were being used in devicetree,
> the compatibles were not added to the arm-smmu-qcom driver. So they end up
> using the generic ARM SMMU-500 driver instead.
> 
> Spotting this discrepancy, the recent arm,smmu bindings change moved these
> SoCs under the non-qcom implementation of the SMMU.
> 
> [...]

Applied, thanks!

[2/3] ARM: dts: qcom: sdx55: Add Qcom SMMU-500 as the fallback for IOMMU node
      commit: af4ab377543853b690cc85b4c46cf976ab560dc2
[3/3] ARM: dts: qcom: sdx65: Add Qcom SMMU-500 as the fallback for IOMMU node
      commit: 157178a7912e00a0aa0371dc9041952c1a21d112

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
