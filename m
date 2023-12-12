Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78AE7B3CC;
	Tue, 12 Dec 2023 17:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sz7J+vz6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19992C43397;
	Tue, 12 Dec 2023 17:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702401691;
	bh=sSxIwv9uKyJ/rIqLLqJ7vYztgpbdcDuftbN+NtSi6mE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Sz7J+vz6px2kl/is1dj9InR8F/YBJ+KgTJGGmsdAI7LOZhZRF1Me2Ruxof2xfvEaH
	 ArPuC4+niMfP0keucraLSyGDYm6GdKzinkmCC1kgrBR4BoMa/HnrQWhEniRc2DJLk0
	 ZDqbUYFW2SbANM0J0zGyG6GPEsjFwdnJpUDmxb2YRBFaYFKXF9qfAEIacylu9lbpw5
	 ramdUTUWcyiEm7T4+m0q2LnIBldGDfQunCmw51ETRL9MwZ7HFPDS0eQjI5c15ARlfI
	 JqHx8QZxo+ReFnWREgmzMPyAb8NMvN/0p5CbHco9Lj5YnjxiJyIou8Oj1OyfhsrgJM
	 TLiDA2UXhV88w==
From: Will Deacon <will@kernel.org>
To: linux-arm-kernel@lists.infradead.org,
	Rob Herring <robh+dt@kernel.org>,
	iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Robin Murphy <robin.murphy@arm.com>,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH] dt-bindings: iommu: arm,smmu: document clocks for the SM8350 GPU SMMU
Date: Tue, 12 Dec 2023 17:20:56 +0000
Message-Id: <170238274439.3091090.6038983968830615339.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20231112184522.3759-1-krzysztof.kozlowski@linaro.org>
References: <20231112184522.3759-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sun, 12 Nov 2023 19:45:22 +0100, Krzysztof Kozlowski wrote:
> Document the clocks for Qualcomm SM8350 Adreno GPU SMMU, already used in
> DTS:
> 
>   sm8350-hdk.dtb: iommu@3da0000: clock-names: False schema does not allow ['bus', 'iface', 'ahb', 'hlos1_vote_gpu_smmu', 'cx_gmu', 'hub_cx_int', 'hub_aon']
> 
> 

Applied to will (for-joerg/arm-smmu/bindings), thanks!

[1/1] dt-bindings: iommu: arm,smmu: document clocks for the SM8350 GPU SMMU
      https://git.kernel.org/will/c/54dae6d5d3f0

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
