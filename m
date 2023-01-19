Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385D0B425
	for <iommu@lists.linux.dev>; Thu, 19 Jan 2023 19:08:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 752DEC433D2;
	Thu, 19 Jan 2023 19:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1674155330;
	bh=csZcG+ScIVG6UPUV+Hi+YtZInifN2wfE/Ns/56FIT4Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CTY4p19uzvt/txyeIqvO5f3rXsnARUYeZuOVNsbTZGjimLiucFLAjm6Bu44bA7pzK
	 C6ryYikOOCPaaCOC7xCDMS0XLzRYQ3RLdcuu13FoORygLW4uFE4a57LgsM+ZnoJawk
	 65t1XP+qngvNyK9zjMbHc5V8KCqBIzRqumjdJjLezpzNyYCfJFu2BcoPWrptXZY9AJ
	 QS1P30dkoGYw9f82EEAan+hGz7soox/YAv6GgLhCt2Yfb591BUiBXAR9EC+R7IAtOY
	 Li+OzR7adVaZB5uIXrf2sowadJ6tg4jZ6RTNY7xweV2zFjafMKXqLHW8S9ki2CX1U1
	 dMckZgSWAL+6g==
From: Will Deacon <will@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Rob Herring <robh+dt@kernel.org>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: arm-smmu: document the smmu on Qualcomm SA8775P
Date: Thu, 19 Jan 2023 19:08:31 +0000
Message-Id: <167415018728.2381246.2762108440390961472.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230112154554.442808-1-brgl@bgdev.pl>
References: <20230112154554.442808-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 12 Jan 2023 16:45:54 +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Document the qcom,smmu-500 SMMU on SA8775P platforms.
> 
> 

Applied to will (for-joerg/arm-smmu/bindings), thanks!

[1/1] dt-bindings: arm-smmu: document the smmu on Qualcomm SA8775P
      https://git.kernel.org/will/c/7caf324fac0b

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
