Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461DB4C78
	for <iommu@lists.linux.dev>; Mon, 14 Nov 2022 14:21:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6FDCC4314B;
	Mon, 14 Nov 2022 14:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1668435669;
	bh=cCgr4l61itGawFxdRxllrVCXC16nmBiEm2SG8SHIWFw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qSoeGjCbIXhd8/b+yZ+GKamfZaFl3PMQIdG9uoC6nAEEA9Dnda/2836cIhpI/cCJ/
	 SgmEfXr4Zf1lEk+to1EhaXC1JgFOLIMfzhMfh11lSgWM3Mo4CHsgAxCpGCxtWsjGy3
	 80NNc7+cgscQLvHQXAuBZhSABsBiMXYalMDlMS6pRib+udvk8E5VHu5S+1QbFUZUPT
	 DMUXbWOnW9teP+QQE+gz12DeNJY6amTcyDf+TWe0vTSEd2kk7YivaP8DcFq+8+S9dJ
	 eXFl+oVeThDXvhXFzLpZnWCKRpq8mpmLzga4C/HUP1JQJnPvbfoX+8Uam/jQqg0qBm
	 pFRhANNMgOuXw==
From: Will Deacon <will@kernel.org>
To: Rob Herring <robh+dt@kernel.org>,
	Melody Olvera <quic_molvera@quicinc.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Joerg Roedel <joro@8bytes.org>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v3 0/2] Add smmu support for QDU1000/QRU1000 SoCs
Date: Mon, 14 Nov 2022 14:20:56 +0000
Message-Id: <166843314664.2454145.14229818075089029138.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221026190534.4004945-1-quic_molvera@quicinc.com>
References: <20221026190534.4004945-1-quic_molvera@quicinc.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 26 Oct 2022 12:05:32 -0700, Melody Olvera wrote:
> This patchset adds smmu bindings and driver support for the QDU1000
> and QRU1000 SoCs.
> 
> The Qualcomm Technologies, Inc. Distributed Unit 1000 and Radio Unit
> 1000 are new SoCs meant for enabling Open RAN solutions. See more at
> https://www.qualcomm.com/content/dam/qcomm-martech/dm-assets/documents/qualcomm_5g_ran_platforms_product_brief.pdf
> 
> [...]

Applied to arm64 (for-joerg/arm-smmu/bindings), thanks!

[1/2] dt-bindings: arm-smmu: Add compatible bindings for QDU1000 and QRU1000
      https://git.kernel.org/arm64/c/6313f4b5a438
[2/2] drivers: arm-smmu-impl: Add QDU1000 and QRU1000 iommu implementation
      https://git.kernel.org/arm64/c/7b52f53ce191

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
