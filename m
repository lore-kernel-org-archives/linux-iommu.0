Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627F97B3D8;
	Tue, 12 Dec 2023 17:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xs4mIMfP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29598C433C7;
	Tue, 12 Dec 2023 17:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702401697;
	bh=sBE0NWnO5VIuoycB+dlcp2FMbiCfoxuzt1biDA8rV2g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xs4mIMfPlfpcJpaVVlbOh3BzKo+oA57GZ5WRH+fpRwklV7Jr4/2qwR6yY78+GjCp6
	 i+aqgILPqIatSrF8TDMvNF4H2Lagv8erEOfcJJsL1stt/sU/rNPuFqi8BWkxhHZ5WI
	 XWjET2xuTc/raygkYaFxKTr7LCqLGAtFM9OnWHH8MD4A2cnlwodny6OhMc67RFaRc1
	 QLFBMm+n4HCjMTDvsyYfsAiG40oNgdD8BxQNt1PI9Lpav4+XYz9NN2qDCKoim/EWrd
	 dOcxSDtkSs/kbHkPC9ihtXluIKkjnnBWapRK8MkhJta3VM58tuFPiqFhJk7O3sFS0l
	 qcgtVXFgvEorg==
From: Will Deacon <will@kernel.org>
To: Joerg Roedel <joro@8bytes.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Robin Murphy <robin.murphy@arm.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: iommu: arm,smmu: document the SM8650 System MMU
Date: Tue, 12 Dec 2023 17:20:58 +0000
Message-Id: <170238294290.3094261.9750012382616477796.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20231128-topic-sm8650-upstream-bindings-smmu-v2-1-d3fbcaf1ea92@linaro.org>
References: <20231128-topic-sm8650-upstream-bindings-smmu-v2-1-d3fbcaf1ea92@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 28 Nov 2023 09:41:23 +0100, Neil Armstrong wrote:
> Document the System MMU on the SM8650 Platform.
> 
> 

Applied to will (for-joerg/arm-smmu/bindings), thanks!

[1/1] dt-bindings: iommu: arm,smmu: document the SM8650 System MMU
      https://git.kernel.org/will/c/61683b47df44

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
