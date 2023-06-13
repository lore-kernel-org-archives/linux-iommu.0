Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB82E1361
	for <iommu@lists.linux.dev>; Tue, 13 Jun 2023 23:45:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23650C433C9;
	Tue, 13 Jun 2023 23:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686699944;
	bh=B4SCq0iczA9nvDpM+xGfWptMw9Oi7D28BNYtK11OW0g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p2g4ddkHfQmMSHrhzk3565U5nnjXV5BZktWsZIZywd3oaOAgpm7OA2tkJ3Iqy0OmG
	 VLCrK2KIUIlM4hbUVPDMM2EOuJRE1U7fRMfKXG+cZbxGU+hAzX5r6OsIpQIAPNBCc0
	 QbZLgoyiLbzfzWScDy9jaNYKKjxg2LxMzcQj9fnmw5xKX1dzzHGl/ws7kwYs/7Lb/k
	 CnFSE5s1iL8cAjfsthEB/kZOBPRBB03llteMpSFmAhJbJBayW3auAlLm8aD0wGdLyh
	 x3XOWqW5FNjmXZAC2aDNbVjO+lNWlu8SXq4rsZF72lBKA90DkRS7jABzvXXxzAi73p
	 wwKiJpbfu18QA==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Rob Herring <robh+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andy Gross <agross@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Marijn Suijten <marijn.suijten@somainline.org>,
	iommu@lists.linux.dev
Subject: Re: (subset) [PATCH 0/2] SM6375 GPU SMMU
Date: Tue, 13 Jun 2023 16:48:47 -0700
Message-Id: <168670013502.1400697.11946020572385370506.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230531-topic-sm6375_gpusmmu-v1-0-860943894c71@linaro.org>
References: <20230531-topic-sm6375_gpusmmu-v1-0-860943894c71@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 31 May 2023 17:04:22 +0200, Konrad Dybcio wrote:
> This series hooks up the GPU SMMU, as well as GPUCC as its direct
> dependency.
> 
> The thing sadly can't seem to be able to do PPPT, not even on downstream..
> 
> Depends on (bindings and functionality-wise):
> https://lore.kernel.org/linux-arm-msm/20230529-topic-sm6375gpuccpd-v1-0-8d57c41a6066@linaro.org/
> 
> [...]

Applied, thanks!

[2/2] arm64: dts: qcom: sm6375: Add GPUCC and Adreno SMMU
      commit: 852865530a21d139196106543cdf3e76c389659b

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
