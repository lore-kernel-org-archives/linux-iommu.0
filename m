Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E8E1380
	for <iommu@lists.linux.dev>; Tue, 24 Jan 2023 12:10:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35A94C433D2;
	Tue, 24 Jan 2023 12:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1674562225;
	bh=l5P2dcDwl1Ro2L6ilIOJKG9O4Vu68MKthz8L2plR9oc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JGYpkXcWDatP+rjnX/LmQNuidY4UidrMsxoi89jllbg4Ia5fiAucLHzFPrMZicryh
	 enw2AZmOAd2nwcejAz/b0Mq2fkSJACf9HI5QzEeaqfoayK5CArnOVFYxTSzZyDzgu+
	 gALXwLVrjMhs0rB3dhpE88Y//9SaOrMVJAABl0zQ33HAM/nrdeOxqtywGLWyRGHJcE
	 kxhOy8zbj9n+4P4u6tt/89QaEKXeIMMSSWc33Ng6n+AIyaVkpVVWO0VoAjlEgZPHG4
	 +e1C7f/b1NdZV1Gt8OV2iz3Bb8Mc439bnwxO91YkKfppd5yad+mqJWzbbP87gkBJd2
	 e70mQNYYfhP0w==
From: Will Deacon <will@kernel.org>
To: krzysztof.kozlowski+dt@linaro.org,
	andersson@kernel.org,
	joro@8bytes.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	robh+dt@kernel.org
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	dmitry.baryshkov@linaro.org,
	linux-arm-msm@vger.kernel.org,
	konrad.dybcio@linaro.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 0/3] Fix SMMU on SDX55 and SDX65
Date: Tue, 24 Jan 2023 12:10:19 +0000
Message-Id: <167456063714.294556.5041040061000624802.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230123131931.263024-1-manivannan.sadhasivam@linaro.org>
References: <20230123131931.263024-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 23 Jan 2023 18:49:28 +0530, Manivannan Sadhasivam wrote:
> Both SDX55 and SDX65 SoCs are using the Qcom version of the ARM SMMU-500
> IP. Even though the SoC specfic compatibles were being used in devicetree,
> the compatibles were not added to the arm-smmu-qcom driver. So they end up
> using the generic ARM SMMU-500 driver instead.
> 
> Spotting this discrepancy, the recent arm,smmu bindings change moved these
> SoCs under the non-qcom implementation of the SMMU.
> 
> [...]

Applied bindings change to will (for-joerg/arm-smmu/bindings), thanks!

[1/3] dt-bindings: arm-smmu: Fix binding for SDX55 and SDX65
      https://git.kernel.org/will/c/eb9181a3ae60

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
