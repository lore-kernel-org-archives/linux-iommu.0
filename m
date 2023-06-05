Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390481F93A
	for <iommu@lists.linux.dev>; Mon,  5 Jun 2023 15:39:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6800C433D2;
	Mon,  5 Jun 2023 15:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685979574;
	bh=sk/6csv09QzAZsCVw89hyVmoT6X4fAwVBTUDtzlCaqc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B3DS1aPN52xZLBz/61LYSKi/INp49YsP1ayDLaFROtPa2oVFCe98LResBzCGIcvCq
	 x1IGxfu1UZStAEQwhxHjbGpHP1yTcrIndNn5I+fGppeDXX/FAb+3tboq9R5ZSHAsSk
	 gByf9Z38mGx5ZghQSUExsPgj1SW3ifD6bNK2T9WytR0UQUO9M9ZdAlyHPQat0hNB0z
	 w/zPUi87EKKJL7ydAD4+SB1oYcUBDEMyf2BZYEcWnW4WVUihrGcRzGi7NmX1exhaFB
	 Sjbskk+Wyz86C07AoXzIpqeqQpJtw+XmOHjVJX5RP7kg2maE/HvJVqIACi9FqeKsTZ
	 NtWQUN/yJqyyQ==
Date: Mon, 5 Jun 2023 16:39:29 +0100
From: Will Deacon <will@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [RESEND PATCH] dt-bindings: iommu: arm,smmu: enable clocks for
 sa8775p Adreno SMMU
Message-ID: <20230605153928.GB21796@willie-the-truck>
References: <20230530144931.188900-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530144931.188900-1-brgl@bgdev.pl>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, May 30, 2023 at 04:49:31PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> The GPU SMMU will require the clocks property to be set so put the
> relevant compatible into the adreno if-then block.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> Resending with all IOMMU maintainers in CC.

I've picked up the earlier version (which is the same patch). There was
a trivial conflict with a similar change allowing clocks for the
'qcom,sc8280xp-smmu-500' device, so please check when I push out the
updated branch.

Will
