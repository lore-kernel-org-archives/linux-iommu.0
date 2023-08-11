Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8688DA46
	for <iommu@lists.linux.dev>; Fri, 11 Aug 2023 11:45:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 642CAC433C7;
	Fri, 11 Aug 2023 11:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691754317;
	bh=UW0hV6I6tsk7xP4sIHoTq3TIb8NWElED9yus/Ag5psY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J9e/oH0fSZSuJXnUf67G9HS9B7snpdr8eoUrOxr1p9HpM0zMQCUJk2Ij/XUpPW9cN
	 e0uISWE10kz+q193lQdMSJVaghhpsDok7Wm6yL5EcGqsjkLwOVfJDA3ajhVdUnYmt5
	 412ByaU0btlPI/0M+Yq8pSYF0pgdEcXeuN7bzPDZQLy2Lxq4VysTHL7vCG1CjlC8E6
	 QbwHX5kU7O83CEenJdsZqnpoxqEnOihXwWWqPDOGljjVVgoFNTIVWwFVTUZEesidGJ
	 FK5MSk9xl7e39FX5r0D5Jpmq546J87MgAW2qAI3MTJyOGPJqvNYB8cX5FNX6Of0M7j
	 hO/oxHsshlw4w==
From: Will Deacon <will@kernel.org>
To: Andy Gross <agross@kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Rajendra Nayak <quic_rjendra@quicinc.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Joonwoo Park <joonwoop@codeaurora.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Imran Khan <kimran@codeaurora.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jeffrey Hugo <quic_jhugo@quicinc.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	iommu@lists.linux.dev,
	Jami Kettunen <jami.kettunen@somainline.org>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v3 0/6] MMCC MSM8998 fixes
Date: Fri, 11 Aug 2023 12:44:55 +0100
Message-Id: <169175360735.3925957.9255014355088010270.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230531-topic-8998_mmssclk-v3-0-ba1b1fd9ee75@linaro.org>
References: <20230531-topic-8998_mmssclk-v3-0-ba1b1fd9ee75@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 09 Aug 2023 21:20:23 +0200, Konrad Dybcio wrote:
> 8998 has a couple of issues related to its clock controllers. This series
> attemps to fix some of them.
> 
> The DT patch should go in first for bisectability, otherwise
> clk/pd_ignore_unused will need to be used, as the SMMU GDSC is no longer
> considered always-on.
> 
> [...]

Applied bindings patch to will (for-joerg/arm-smmu/bindings), thanks!

[6/6] dt-bindings: arm-smmu: Fix MSM8998 clocks description
      https://git.kernel.org/will/c/b606e2e8eded

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
