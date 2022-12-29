Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C541FAF
	for <iommu@lists.linux.dev>; Thu, 29 Dec 2022 17:24:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAD65C433EF;
	Thu, 29 Dec 2022 17:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1672334642;
	bh=XHmLp9yZDI+BKgWJ96JFpf1Pfxo9Zv/tr9yi9QJuKX0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mcK3XdXbBpV36VckC+R/1ONh/uy9uKkTBKyERB85jj+dKbOf+YjepFPvWAkAXrI1I
	 zOAAhEp6/a2toL52Lywi+Dq1l9zy+hVidY9zLxEyWuQ1/P4ZSMwzdRBGl/tKLZZwfA
	 XfjRsCWQVUnDIGDPeyYqbmH9Tc7l+GXh0U/pAbtXs3uroqE1XN93ZmQilfJEPUU/S+
	 98oaDSSyOwAAbLEq3Yexn8GanJxR2zU5eUAZsLTKeLJrwVBVNQjnK4K+JPRLp0yR8J
	 b5HxwzS65RlgWkMZk9E7Mbw1fLJPOvg94N3GvbV8w9UwgSICNuHnq1nw+3Iru7Zaog
	 iZo6ulTDdBXNw==
From: Bjorn Andersson <andersson@kernel.org>
To: joro@8bytes.org,
	phone-devel@vger.kernel.org,
	Marijn Suijten <marijn.suijten@somainline.org>,
	will@kernel.org
Cc: linux-arm-msm@vger.kernel.org,
	konrad.dybcio@somainline.org,
	martin.botka@somainline.org,
	krzysztof.kozlowski+dt@linaro.org,
	~postmarketos/upstreaming@lists.sr.ht,
	angelogioacchino.delregno@somainline.org,
	bhupesh.sharma@linaro.org,
	dmitry.baryshkov@linaro.org,
	quic_molvera@quicinc.com,
	linux-arm-kernel@lists.infradead.org,
	Douglas Anderson <dianders@chromium.org>,
	linux-kernel@vger.kernel.org,
	jami.kettunen@somainline.org,
	robh+dt@kernel.org,
	treding@nvidia.com,
	agross@kernel.org,
	they@mint.lgbt,
	konrad.dybcio@linaro.org,
	robin.murphy@arm.com,
	devicetree@vger.kernel.org,
	iommu@lists.linux.dev
Subject: Re: (subset) [PATCH v5 0/4] arm64: dts: qcom: sm6125: Enable APPS SMMU
Date: Thu, 29 Dec 2022 11:23:39 -0600
Message-Id: <167233461773.1099840.14120754082491956847.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
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

Applied, thanks!

[2/4] arm64: dts: qcom: sm6125: Configure APPS SMMU
      commit: 8ddb4bc3d3b52e0a560a18e4d739c83f56efe7c9
[3/4] arm64: dts: qcom: sm6125: Add apps_smmu with streamID to SDHCI 1/2 nodes
      commit: 60f6c86fb4fd16bd86aa1b16bc51ef4ac0e20d4e
[4/4] arm64: dts: qcom: sm6125: Add IOMMU context to DWC3
      commit: ac54563c27528ab9461899de7d99ee4e3858b858

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
