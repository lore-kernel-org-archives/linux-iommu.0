Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30940624
	for <iommu@lists.linux.dev>; Wed,  5 Apr 2023 04:06:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7475C433A1;
	Wed,  5 Apr 2023 04:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1680667583;
	bh=xQz5FUAqPtU7Gi+8YERsPtQ7TpRXvvT10tjwRfRBWhc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VDHBRU2Xq8kaVz06JCDF4T2JNfPel/p7M1n6RMwGoeV5Ib+rMpukXvtQA0DqVZjJk
	 Q2cHXQdOIej1kWoR0gCDwuLt77fqT9CrfNDy0T1RaL2EIT/KOji5krl5T5CbxwHevh
	 SwZdq4obBayonSIYGK3JseEJdGvW6zTc49S485fB8ozCljYZu/zGcaQh1g0O1UPok9
	 qxJ7H7fr1paCuGkpmX8MNs13zBaOz/2oA8austoh9t0o0AvCdf6gtVidQag1gVdXt5
	 732iflXLHKWK0RENKfqIkqyzSisC1zHh3Lh3l7CWf1CYR11zA0iUuPabQFZ6fWzI0y
	 U4e4q9KxQNZAg==
From: Bjorn Andersson <andersson@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Andy Gross <agross@kernel.org>,
	Will Deacon <will@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	Marijn Suijten <marijn.suijten@somainline.org>,
	linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH 0/2] SM6115 GPU SMMU
Date: Tue,  4 Apr 2023 21:08:55 -0700
Message-Id: <168066774413.443656.6963775649318838978.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230315-topic-kamorta_adrsmmu-v1-0-d1c0dea90bd9@linaro.org>
References: <20230315-topic-kamorta_adrsmmu-v1-0-d1c0dea90bd9@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 15 Mar 2023 11:52:07 +0100, Konrad Dybcio wrote:
> Bring in bindings and the dt part for SM6115 GPU SMMU
> 
> Depends on:
> https://lore.kernel.org/linux-arm-msm/20230313-topic-gpu_smmu_bindings-v3-0-66ab655fbfd5@linaro.org/
> 
> [2/2] only addresses 6115, 6125 will be sent separately after some dt cleanups there
> 
> [...]

Applied, thanks!

[2/2] arm64: dts: qcom: sm6115: Add GPUCC and Adreno SMMU
      commit: fc7c39d61cf8cd03e197ac492241fa5a007dd2c0

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
