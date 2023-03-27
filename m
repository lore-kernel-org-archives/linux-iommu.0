Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9006610E4
	for <iommu@lists.linux.dev>; Mon, 27 Mar 2023 12:52:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7408FC433D2;
	Mon, 27 Mar 2023 12:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1679921531;
	bh=E9MTle2DExPoRvRu4kx7q+nspG7X7Jy/oLcqbqz9/kg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RbwzttHUJSCxLwFkz0diR3YsEPAF5NLC6x5O57TYVcMNbJ2bNrL91Hu8IQkY1yBpy
	 aEExXPiY/AsTw2u2WXmBPhxlIr7WIiEvlTy0xC72XHO/eMgXe5RkCd+ovFpqrmbnbM
	 bf+EYfdsao8tdglX2DbnFAv5K/5klM6xJHKcaaB+tI7BM9+dv7CsTiJhX17p5NrMnY
	 wG6D54R0FRm76hIDJjNVMgmL2t4cbYGv6z2Ffug53BddqksPvn+dOSit/mCRf2uVKo
	 qbt6FPaXsPQr4vf2ixjuR289LsJTvOrVNqklak+DdLTtFZsuOWHEiQe51iCAsvb8rb
	 fWS8pYdHfHrUw==
From: Will Deacon <will@kernel.org>
To: Rob Herring <robh+dt@kernel.org>,
	Andy Gross <agross@kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	devicetree@vger.kernel.org,
	Marijn Suijten <marijn.suijten@somainline.org>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	iommu@lists.linux.dev
Subject: Re: [PATCH 0/2] SM6115 GPU SMMU
Date: Mon, 27 Mar 2023 13:51:59 +0100
Message-Id: <167991702239.1302151.4477761847847607127.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
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

Applied bindings change to will (for-joerg/arm-smmu/bindings), thanks!

[1/2] dt-bindings: arm-smmu: Document SM61[12]5 GPU SMMU
      https://git.kernel.org/will/c/3ad6585509dc

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
