Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AA334CEF;
	Thu, 12 Oct 2023 18:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t8U9Amey"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CEABC433C9;
	Thu, 12 Oct 2023 18:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697134018;
	bh=KLUJiGh+PtGr6yps+0qMhhD6AUnKOsTwaaE1RyLnjUY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t8U9AmeyCoq2mE0SMmvtRMg3TzuoYXEqprdqIK1WFLAOSHESSIZviNoNEz8p0WeF2
	 A+5l9WnpDRSQfj7aH1H/5JxFeoryXNle8+kOrxHYWyXaoWoHYtZEiNiFvPh9fq8kjE
	 sERgqDlsj13EJ0BemBu3CwWOOOmrAr+g9MPmWdPfVcEChkQr3ERmXIdgl9OvqC+3iR
	 vLHzCpVF2Jf/aXkb6DVCZnFJ4CI2SgFCrxHiTRFkViQ7nFKA6mJyMfiP4zp8ICx9uJ
	 vGBAesTBW6OgcWBdwb2AcjhDQQeD1uwSRJ9YIuwBTPaHoxD7ufWiM9oONkR6p872s9
	 VsT79XjIswnAg==
From: Will Deacon <will@kernel.org>
To: robh+dt@kernel.org,
	mani@kernel.org,
	a39.skl@gmail.com,
	joro@8bytes.org,
	dmitry.baryshkov@linaro.org,
	Danila Tikhonov <danila@jiaxyga.com>,
	robdclark@chromium.org,
	conor+dt@kernel.org,
	konrad.dybcio@linaro.org,
	krzysztof.kozlowski+dt@linaro.org,
	quic_bjorande@quicinc.com,
	quic_saipraka@quicinc.com,
	robin.murphy@arm.com
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/2] Add SMMUv2 support for SM7150
Date: Thu, 12 Oct 2023 19:06:44 +0100
Message-Id: <169711495895.626691.8175613673906299981.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230913184526.20016-1-danila@jiaxyga.com>
References: <20230913184526.20016-1-danila@jiaxyga.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 13 Sep 2023 21:45:23 +0300, Danila Tikhonov wrote:
> This series adds SMMUv2 support for Qualcomm SM7150 SoC.
> 
> Danila Tikhonov (2):
>   dt-bindings: arm-smmu: Add SM7150 GPU SMMUv2
>   iommu/arm-smmu-qcom: Add SM7150 SMMUv2
> 
> Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 2 ++
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c            | 1 +
>  2 files changed, 3 insertions(+)
> 
> [...]

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/2] dt-bindings: arm-smmu: Add SM7150 GPU SMMUv2
      (no commit info)
[2/2] iommu/arm-smmu-qcom: Add SM7150 SMMUv2
      https://git.kernel.org/will/c/70c613602b55

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
