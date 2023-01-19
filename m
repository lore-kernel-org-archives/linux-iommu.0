Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E95B425
	for <iommu@lists.linux.dev>; Thu, 19 Jan 2023 19:09:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80551C433F0;
	Thu, 19 Jan 2023 19:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1674155346;
	bh=+M/1V/XI3Z/7I8h/XMEybF5oiEZFJBqMzVW/lIZbPCE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K1LRk/apkBgH6bAkmnAlio+JzWftk3bMMTwM/QHXzP4/vPEkOLDlGmuiZWQwpgvsr
	 mck/VCYYQrDFJ67jBZj/auYAvpfwN3emZp2KteQL7LDXX2D1vYOPuz9Hr/pHBXZN3C
	 Pl4tsjVNgxsdnsLHR+VtiylmYTNnE3u/9ufgLMjFhdWJdtu1zeDOYNuwFNw7yUR1AH
	 AwRn42RBKwoMcMWADE8Kn5X0kS2CbG9mpHptC66MjXB2jE2JnUuZjoffOZam0uULXc
	 zCvVBVHsBWXX4A5drblzFTpZFK2tqSIfP50y6KceT3/9mNbFrxjA5l9Na5PVk7fyTt
	 27NfIRfwLypxw==
From: Will Deacon <will@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	andersson@kernel.org,
	krzysztof.kozlowski@linaro.org,
	linux-arm-msm@vger.kernel.org,
	agross@kernel.org
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
	linux-arm-kernel@lists.infradead.org,
	Emma Anholt <emma@anholt.net>,
	Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	Rob Clark <robdclark@chromium.org>,
	linux-kernel@vger.kernel.org,
	marijn.suijten@somainline.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v2] iommu/arm-smmu-qcom: Add SM8150 DPU compatible
Date: Thu, 19 Jan 2023 19:08:36 +0000
Message-Id: <167415048722.2382047.16776557336419561764.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221212121054.193059-1-konrad.dybcio@linaro.org>
References: <20221212121054.193059-1-konrad.dybcio@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 12 Dec 2022 13:10:53 +0100, Konrad Dybcio wrote:
> From: Marijn Suijten <marijn.suijten@somainline.org>
> 
> Add the SM8150 DPU compatible to clients compatible list, as it also
> needs the workarounds.
> 
> 

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/1] iommu/arm-smmu-qcom: Add SM8150 DPU compatible
      https://git.kernel.org/will/c/4fef70ad65f6

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
