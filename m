Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39231FBB
	for <iommu@lists.linux.dev>; Mon, 27 Mar 2023 12:52:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0930FC4339E;
	Mon, 27 Mar 2023 12:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1679921540;
	bh=TiNqf98ADycgBI6z6Xc+TjvbRRtxYsDak8spskoXiFA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PItEEgeDQzes6BzFSC3cdJg/LxgE3V7YFyrWEVTjlMvLeXyhNvWPeU/63fWvAi06k
	 W0K665kYq1tSsqXxGUATcn+cMuof9v51JWJeaUXWMg192xYQYorNdPzhNWiXQBDat4
	 SjqeonVwYc07L5USz83O0hxA2GydRChm5F9tj2+ZSrNdeR9pHTVoghxJyXrWz34amY
	 U/eTIWIdYPCW0JanDUmmZCSbJIsNzHkflMAEM1/jgpwzSivBepvCrcbchWJs4Ffukb
	 qVlCkx7P7dT9s5Klytf5Rpu0brogyw50cx0JHLEXwlGPjJEXGYghHmVNW9qz1YSFr+
	 Vby1W/rmSDANQ==
From: Will Deacon <will@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Joerg Roedel <joro@8bytes.org>,
	neil.armstrong@linaro.org,
	Robin Murphy <robin.murphy@arm.com>,
	Rob Herring <robh+dt@kernel.org>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	Abel Vesa <abel.vesa@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: arm-smmu: Add compatible for SM8550 SoC
Date: Mon, 27 Mar 2023 13:52:02 +0100
Message-Id: <167991649885.1301297.18067853856975635652.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230207-topic-sm8550-upstream-smmu-bindings-v3-1-cb15a7123cfe@linaro.org>
References: <20230207-topic-sm8550-upstream-smmu-bindings-v3-1-cb15a7123cfe@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 08 Feb 2023 10:13:58 +0100, neil.armstrong@linaro.org wrote:
> From: Abel Vesa <abel.vesa@linaro.org>
> 
> Add the SoC specific compatible for SM8550 implementing
> arm,mmu-500.
> 
> 

Applied to will (for-joerg/arm-smmu/bindings), thanks!

[1/1] dt-bindings: arm-smmu: Add compatible for SM8550 SoC
      https://git.kernel.org/will/c/7f061c19f652

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
