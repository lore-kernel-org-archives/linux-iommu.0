Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C317B3CC;
	Tue, 12 Dec 2023 17:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DcX0iT+q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 508E4C433CA;
	Tue, 12 Dec 2023 17:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702401702;
	bh=95qSBRedvB7M5d2E+Y4LFzyqtZbthes0VM007xjmBkM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DcX0iT+qutSFfhVVjuIVyyQEdkJMjTWaFHICz3BBoVAVwA7iLsdGtQAqkd7XI81GA
	 OEfKpgO+vyAgYGbPLiHRkYvBcT4fsqxFnfE6vsYu3CrlrjOpWrWEPDgDQwK6/GTIcj
	 /QvphctdOmQxXLsMsEg62nz1LuFsR6JMFJn4v8quG69prOXRgq6QhqCHHRJXftterQ
	 HWgLiftxaGOcM02qoYdsoOMlyW1EMVN5LG1m/kK9+7PA1oZTIWpMAIbSRupnDa9OlL
	 U4gRvhwS2urEu+EAjFeO+pcermczBiylwKXahYKwOsuldk3E05Mgr7DNR4o14Bc6ij
	 3xQ3vEq81oc7w==
From: Will Deacon <will@kernel.org>
To: andersson@kernel.org,
	robh+dt@kernel.org,
	conor+dt@kernel.org,
	robin.murphy@arm.com,
	krzysztof.kozlowski+dt@linaro.org,
	konrad.dybcio@linaro.org,
	joro@8bytes.org,
	Sibi Sankar <quic_sibis@quicinc.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	iommu@lists.linux.dev,
	quic_tsoni@quicinc.com,
	quic_rjendra@quicinc.com,
	neil.armstrong@linaro.org,
	devicetree@vger.kernel.org,
	abel.vesa@linaro.org,
	quic_gurus@quicinc.com,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	dmaengine@vger.kernel.org,
	agross@kernel.org,
	vkoul@kernel.org
Subject: Re: [PATCH V3 0/5] dt-bindings: Document gpi/pdc/scm/smmu for X1E80100
Date: Tue, 12 Dec 2023 17:20:59 +0000
Message-Id: <170238310080.3094703.7257298864480960361.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20231124100608.29964-1-quic_sibis@quicinc.com>
References: <20231124100608.29964-1-quic_sibis@quicinc.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 24 Nov 2023 15:36:03 +0530, Sibi Sankar wrote:
> This series documents gpi/pdc/scm/smmu/soc for the Qualcomm X1E80100
> platform, aka Snapdragon X Elite.
> 
> Our v1 post of the patchsets adding support for Snapdragon X Elite SoC had
> the part number sc8380xp which is now updated to the new part number x1e80100
> based on the new branding scheme and refers to the exact same SoC.
> 
> [...]

Applied SMMU binding change to will (for-joerg/arm-smmu/bindings), thanks!

[2/5] dt-bindings: arm-smmu: Add compatible for X1E80100 SoC
      https://git.kernel.org/will/c/fa27b35c9102

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
