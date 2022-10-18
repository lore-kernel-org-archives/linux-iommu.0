Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8421857
	for <iommu@lists.linux.dev>; Tue, 18 Oct 2022 03:07:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44ACFC43147;
	Tue, 18 Oct 2022 03:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1666062445;
	bh=RuQ0qyzLyCZ8UbmT38wc6p1T9N+BAk8sE8gaFRQ32Kc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jg4K+bucB7CfGN/2s5IRFsjY8sGjKSIrodw1Eu1qMJ4Tj1LG5tdmw4a+jTDexUHyl
	 0D7J/eG7EqUlhsSevd/1Tp3KL2S7W7d2D2Xat40z8uPClCsyGOAxn1S6231Yb0lsWM
	 CGS3ChCcjqUJbjtH6846pLoVhE1bGKmmR4r+qzwH5cYA7PwBlB/vy0MG7PNZTtgcQX
	 DZ3nU5Lf7Go0/IaFJ57VI7zr00kwDFr6AfeOnEgKaAOPoIuJiNItWoVZS5jh3mGIST
	 NjKaESoc1INArVF6LrDyNgYCiWOmxfRnkm5B6MxUw54jiIXLzaxvine1lkIfmbvEsy
	 ePcF3WsxuXnVg==
From: Bjorn Andersson <andersson@kernel.org>
To: luca@z3ntu.xyz,
	linux-arm-msm@vger.kernel.org
Cc: robin.murphy@arm.com,
	~postmarketos/upstreaming@lists.sr.ht,
	phone-devel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: (subset) [PATCH v4 0/3] MDSS support for MSM8953
Date: Mon, 17 Oct 2022 22:05:57 -0500
Message-Id: <166606235863.3553294.17596125386082772765.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221016161554.673006-1-luca@z3ntu.xyz>
References: <20221016161554.673006-1-luca@z3ntu.xyz>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sun, 16 Oct 2022 18:15:50 +0200, Luca Weiss wrote:
> This series adds the APPS IOMMU and the MDSS block for display that is
> found on msm8953 SoCs.
> 
> Luca Weiss (1):
>   dt-bindings: qcom-iommu: Add Qualcomm MSM8953 compatible
> 
> Vladimir Lypak (2):
>   arm64: dts: qcom: msm8953: add APPS IOMMU
>   arm64: dts: qcom: msm8953: add MDSS
> 
> [...]

Applied, thanks!

[2/3] arm64: dts: qcom: msm8953: add APPS IOMMU
      commit: c0b9575a36069f52f09fbe9b8f7a9db940cb952c
[3/3] arm64: dts: qcom: msm8953: add MDSS
      commit: cf6c35d1bc89e0942c379f841e1d9095fc66d642

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
