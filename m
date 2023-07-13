Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7236E1ED55
	for <iommu@lists.linux.dev>; Thu, 13 Jul 2023 15:40:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 533B0C433C8;
	Thu, 13 Jul 2023 15:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689262858;
	bh=Opj8JDTNUda9NW7e+toCrb8Tsv2eHY+Uit8zdRt6gVw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=neQ5IiAxZldW/eAExMXgoPyPKHNm6aOB1qcn8qvstiRppXiDkgG0tJWL/zfT5b4Yw
	 xKYW3Z9FAFdoR89xx/JZOeHx0EgyfAm7NQmKfhpP0YRMunKobkZMnzok1DAaZ4MbGi
	 7p3X/OcPW4Y07DhfU8dbvMhjCW2mDGC3UAYl6szG2BsX0FvZmlLVAFrEnpS91QlRWU
	 bPRbf6ILJl4eeYMz8vMAmUL6ehlDrZcc1vPTLQr8/2KMUl367KywIQTiKJJbQnp7lt
	 ymcLHCB8Ixr8f0Sh25i1UophHoKMXk8nt3QkZes0Q1TqMpOxhHXWdhOcb0LPBAmojD
	 X+pDWoB7ytTQQ==
Date: Thu, 13 Jul 2023 16:40:48 +0100
From: Lee Jones <lee@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: cros-qcom-dts-watchers@chromium.org, Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Benjamin Li <benl@squareup.com>,
	James Willcox <jwillcox@squareup.com>,
	Joseph Gates <jgates@squareup.com>,
	Stephan Gerhold <stephan@gerhold.net>,
	Zac Crosby <zac@squareup.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Xu Yang <xu.yang_2@nxp.com>, Peng Fan <peng.fan@nxp.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Wesley Cheng <quic_wcheng@quicinc.com>,
	Jun Nie <jun.nie@linaro.org>, Max Chen <mchen@squareup.com>,
	Shawn Guo <shawn.guo@linaro.org>,
	Vivek Gautam <vivek.gautam@codeaurora.org>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vincent Knecht <vincent.knecht@mailoo.org>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Konrad Dybcio <konradybcio@kernel.org>, alsa-devel@alsa-project.org,
	iommu@lists.linux.dev, linux-usb@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Leo Yan <leo.yan@linaro.org>, Rob Herring <robh@kernel.org>,
	Andy Gross <andy.gross@linaro.org>
Subject: Re: [PATCH 06/11] dt-bindings: mfd: qcom,spmi-pmic: Reference pm8916
 wcd analog codec schema
Message-ID: <20230713154048.GD968624@google.com>
References: <20230627-topic-more_bindings-v1-0-6b4b6cd081e5@linaro.org>
 <20230627-topic-more_bindings-v1-6-6b4b6cd081e5@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230627-topic-more_bindings-v1-6-6b4b6cd081e5@linaro.org>

On Tue, 27 Jun 2023, Konrad Dybcio wrote:

> Now that it's been converted to YAML, reference the PM8916 wcd codec
> schema.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
