Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BA25250
	for <iommu@lists.linux.dev>; Mon, 10 Apr 2023 20:01:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FDEAC433EF;
	Mon, 10 Apr 2023 20:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1681156918;
	bh=zS9bDGyb5KIyUvMyO4cCULhWJVvcjPYxsjkGaR6IpEA=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=aYYG3s/jYQ4jWxNHds6LtrGf9w8J5k4Vvqa12JyzNH40pMUSkoaD7G6vefRxEYh4i
	 7bXHtbod1W1TP+7Oxmg0von2A6CG43wfOLJvyvMenv2nqXIfby8jvwzHCsF+AnV916
	 mfnxPdX5F6wgMuUhvT41V3aphNJJAw5AD7pX0Hw/eFHIYbmzw1Z3fFiWisyobkxT59
	 UYY9uFsJo//wBAIQAxE/eC3vEXA+mI/CdjjPjXQjI5hgBMyMUr2zJrcS0FOC1LJCX8
	 puAjBrqUsbTZVyHPB8IBW4SFKyoypkoPuUXx2XwpcJk+aB87gQs9mFfQpCj+AhseKM
	 BOJTvcw2zdPDA==
Message-ID: <d39d2f42e04cf97046d23f0823558e73.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230406200723.552644-2-brgl@bgdev.pl>
References: <20230406200723.552644-1-brgl@bgdev.pl> <20230406200723.552644-2-brgl@bgdev.pl>
Subject: Re: [PATCH v2 1/7] dt-bindings: clock: qcom: describe the GPUCC clock for SA8775P
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Andy Gross <agross@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Bartosz Golaszewski <brgl@bgdev.pl>, Bjorn Andersson <andersson@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Joerg Roedel <joro@8bytes.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>
Date: Mon, 10 Apr 2023 13:01:56 -0700
User-Agent: alot/0.10

Quoting Bartosz Golaszewski (2023-04-06 13:07:17)
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>=20
> Add the compatible for the Qualcomm Graphics Clock control module present
> on sa8775p platforms. It matches the generic QCom GPUCC description. Add
> device-specific DT bindings defines as well.
>=20
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
