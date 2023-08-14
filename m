Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE70187C
	for <iommu@lists.linux.dev>; Mon, 14 Aug 2023 03:25:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61E32C433D9;
	Mon, 14 Aug 2023 03:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691983509;
	bh=gydjJyUCO/5hN3ZK6M7GS4n9Rqgo6EY8zQTaNi5iMRA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Lpk8jvFjXD9GDqAOfWP63nus5HXu8IUdnL26enLEdQlVcNxw18mn6RJt8a3MjlFdx
	 yxM5SrWe9G5cGmFcr02YhnO6pTF+nOsNjNY+sLot73CPAQ7zyuAfcRpovYQehkeY6O
	 X4Yo/J2TT/pdg2m+cQVM3OKytqwt33rJ6AJMP3C89pjBuJM0w/+CushykAopJHygnL
	 Wis0/FJtNKAm0xS23MZbvnw2ecKB4+Zcawr09rN7ZXa62y2VfXfLdpyCWnK+bHpgCW
	 31aNocKb6ArgoAtBk+N2TFRzIh/atnwagHD6FWu2s8zOYKW2t7617u0xKlgE0htJnE
	 isO5n9pXqANKQ==
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
Date: Sun, 13 Aug 2023 20:27:38 -0700
Message-ID: <169198364310.2443702.11310037157299492335.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
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
      commit: a6f1e8623836bb6ce64c347d110ecb6259ae73c4
[4/6] clk: qcom: mmcc-msm8998: Don't check halt bit on some branch clks
      (no commit info)

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
