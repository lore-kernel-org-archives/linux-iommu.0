Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CB48C02
	for <iommu@lists.linux.dev>; Mon,  5 Jun 2023 16:35:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA573C433D2;
	Mon,  5 Jun 2023 16:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685982923;
	bh=9MUmkLDtIToYd9V8NeIlMZ2u6glZyMADhdjMo7PXa/k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o9p3vloDHX1j/zkqijJx5n840xvdqcWa9nb+UxkHX546s1eNB8WZghVr2JfQ2SloE
	 ujooE/1fhezPJyZu1STyVIFo/5sbR/WPZI6b1rv5603nKQoCWSg3whzirKvfVr7M15
	 NOlafbciQ5cnRJagU4e+z42JXsySpUWkrq8KY78uyVnyvZ2mbBIZyW3ikuZWZq8/AO
	 CPLZ2EmC2hqbatV0VBRWs0klxIG/FVryjtAnUQ7cisrRznAazL9VL8TdGYhDDLpvoi
	 +m4nzW33PsGMJ5k5Myr6/969o+SN5t0CovZEZWq+5wA9Y8d/SDRrOdgYOQ9UB4DzSL
	 BuIoSeXoUnNJg==
From: Will Deacon <will@kernel.org>
To: Joerg Roedel <joro@8bytes.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Andy Gross <agross@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	Marijn Suijten <marijn.suijten@somainline.org>,
	iommu@lists.linux.dev
Subject: Re: [PATCH 0/2] SM6375 GPU SMMU
Date: Mon,  5 Jun 2023 17:35:04 +0100
Message-Id: <168597965563.30054.140440008485884265.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
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

Applied bindings patch to will (for-joerg/arm-smmu/bindings), thanks!

[1/2] dt-bindings: arm-smmu: Add SM6375 GPU SMMU
      https://git.kernel.org/will/c/44984d56e059

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
