Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF133D399;
	Wed, 20 Sep 2023 17:10:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46DCAC433CC;
	Wed, 20 Sep 2023 17:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695229814;
	bh=K5WcaoeJv2tdAiYCqf61it4DKUXI7DqZS6x3h8zOk0w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G8/B2EjB+oEufWRJ87Xj42cxUp4SDiIDu/k5rp/B9eXd7kPtY1r2HkGbmEfA2mc0X
	 IFsCJEjyGrIeOp6YyEan05LwhrZVD1Uq7lyN/PELCCUu5ebtzfXaZo0VJiNDezMBj9
	 HvVn/6KyxQoFLMZFSYxZhJsjjfBckH6Gmn8BJAvwuRYkhjWGLZThSCjGOVa5F7dXAv
	 RH7qasRhWiOkENFhzU/EcIHYP2s/oQdCmKrQo0pkUamR3UhqvMYOEfCOYh9qH3AhKM
	 fqq7ankDh60H0C7dsF3ZV5NW8XZ2s2x4xCqQ4GOJPR3XkQnvaMBTDeQ0/6XyS1LrzB
	 4m93yth8AiI6A==
From: Bjorn Andersson <andersson@kernel.org>
To: Andy Gross <agross@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
	Imran Khan <kimran@codeaurora.org>,
	Rajendra Nayak <quic_rjendra@quicinc.com>,
	Joonwoo Park <joonwoop@codeaurora.org>,
	Jeffrey Hugo <quic_jhugo@quicinc.com>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Jami Kettunen <jami.kettunen@somainline.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: (subset) [PATCH v3 0/6] MMCC MSM8998 fixes
Date: Wed, 20 Sep 2023 10:14:01 -0700
Message-ID: <169523004959.2665018.814335598226765516.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
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

Applied, thanks!

[3/6] clk: qcom: gcc-msm8998: Don't check halt bit on some branch clks
      (no commit info)
[4/6] clk: qcom: mmcc-msm8998: Don't check halt bit on some branch clks
      commit: 9906c4140897bbdbff7bb71c6ae67903cb9954ce
[5/6] clk: qcom: mmcc-msm8998: Fix the SMMU GDSC
      commit: 1fc62c8347397faf4e18249e88ecd4470c0a5357

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
