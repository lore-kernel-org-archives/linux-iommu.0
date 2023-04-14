Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7B6630
	for <iommu@lists.linux.dev>; Fri, 14 Apr 2023 03:33:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F07CC433D2;
	Fri, 14 Apr 2023 03:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1681443207;
	bh=tJgDJuJY4A4modu0Rbf3HmOHnlGYZ+08MPv5hItppvs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HBc89w3C1U1Iq/3XzZFuDpBoQv8Vh6WnfoHgmcbOD4G8zVROhNHc9aWCCzwqbm30k
	 CYveW63XGePyFmqhqU60qyFV7ygk9y6fBvswF0P9Z7lH0bbA8FTnvpityHGR5rip4g
	 8ZXdXs4axcaJfxSYUbdprKJQDNgiZze1VkPlNi2BECQ4GldJ8zGf5ZeykTaziDvUjL
	 ugR9teNWGyvCh8oFBPDMHFH/XUyfiOpae1mTKQYmxxaf4Ctm7hubGsmVVtVbmCWCqd
	 LkCVqD4d4zrs0+6tfscjK3sqC7IcVlkRsh8oibXBSBdq3nBF0SwRLbtkl8wPKR4eSR
	 oFLC9guoJCHYA==
From: Bjorn Andersson <andersson@kernel.org>
To: Will Deacon <will@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andy Gross <agross@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Michael Turquette <mturquette@baylibre.com>
Cc: iommu@lists.linux.dev,
	linux-arm-msm@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v3 0/7] arm64: dts: qcom: sa8775p: add more IOMMUs
Date: Thu, 13 Apr 2023 20:37:02 -0700
Message-Id: <168144342195.2459486.2984526266369267613.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230411125910.401075-1-brgl@bgdev.pl>
References: <20230411125910.401075-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 11 Apr 2023 14:59:03 +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Add the GPU and PCIe IOMMUs for sa8775p platforms as well as the required
> GPU clock controller driver.
> 
> NOTE: I didn't pick up Krzysztof's tag for patch 4/7 as the patch changed
> significantly.
> 
> [...]

Applied, thanks!

[1/7] dt-bindings: clock: qcom: describe the GPUCC clock for SA8775P
      commit: daa9e76d17570cdd2dbec28244e60e2cb0eafb36
[2/7] clk: qcom: add the GPUCC driver for sa8775p
      commit: 0afa16afc36d0e462c7f815b0131d2e9013849ac

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
