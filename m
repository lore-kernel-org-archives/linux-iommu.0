Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7E12904
	for <iommu@lists.linux.dev>; Thu, 11 Aug 2022 07:05:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93B09C433C1;
	Thu, 11 Aug 2022 07:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1660201556;
	bh=vgb3/iTI5YEipl1kcOFAk88wMPI+HRjfXvkzfOk4dAY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RMT4dl/aSPCmwBksC4KD8yM9CKqtexuoW8BAjVm5/qyIXmACTc126EsybA4SAAkqR
	 VSbhbb/lS6dq6M5pLbOGzsIwflmiNBkKTxgQhzBrtxh3N5eVL0RR3Py1KGTaABU8LJ
	 UxTzfX9FmjRjGr0os1hsW2k+KS4Yr+0YVwJKZqUOuu3nng7g0r5FV7uFnryne4IAMT
	 9hSL+EGYbKqm5OdsnShfASP9NJ/8sVoOcJVkX0neg8Dt1/PzM85iWBeBZxMGlwXk+k
	 kYQ0WSSeXhoy8CWIk191DG3jUlbQxOf2nvrqwCOg7TlsfJ5Nmqgj9LjLlyOIYwNJsD
	 hQ0q2RF4GUmmA==
Date: Thu, 11 Aug 2022 08:05:48 +0100
From: Lee Jones <lee@kernel.org>
To: Tinghan Shen <tinghan.shen@mediatek.com>
Cc: Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	MandyJH Liu <mandyjh.liu@mediatek.com>, iommu@lists.linux.dev,
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v6 06/20] dt-bindings: power: mediatek: Add bindings for
 MediaTek SCPSYS
Message-ID: <YvSqTC0aV61sXbd3@google.com>
References: <20220811025813.21492-1-tinghan.shen@mediatek.com>
 <20220811025813.21492-7-tinghan.shen@mediatek.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220811025813.21492-7-tinghan.shen@mediatek.com>

On Thu, 11 Aug 2022, Tinghan Shen wrote:

> The System Control Processor System (SCPSYS) has several power
> management related tasks in the system. Add the bindings for it.
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/mfd/mediatek,mt8195-scpsys.yaml  | 67 +++++++++++++++++++
>  .../power/mediatek,power-controller.yaml      |  2 +-
>  2 files changed, 68 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/mfd/mediatek,mt8195-scpsys.yaml

Applied, thanks.

-- 
Lee Jones [李琼斯]
