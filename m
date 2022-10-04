Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F357B
	for <iommu@lists.linux.dev>; Tue,  4 Oct 2022 12:00:31 +0000 (UTC)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 135B666022A5;
	Tue,  4 Oct 2022 13:00:29 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1664884829;
	bh=hwEkVOk0X19wQSHQyqvhxpH6Vu8Q0/uLhGNdi1t1cak=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZroDbJrtHtyngKMsLyHHm+HjShAVMQqhP5Pe6s9Qd+Ep7K2yZEinLLif5oGlYO9el
	 YlNzZLDLnEilpi5wJs3lBQ32zzUKikXpuqD/0Eyy5lVxZpEGlaXwCfmGgSr0c56ccn
	 h195gH50EUIN7mnc/nCi1CqQmPXNX52F5smf2WDe3lJNks+qBd7xk9yDqDHLQOFfWX
	 OcSfxnO0VVvih5QaQl4tL63/nfeldzMDG5T2bFTrVw8KWi/XSYsM+rtXnBrZv++ave
	 +Jcim0pEPSi2zZJDjwCVEbGhU5MdMsVwcdxTMMsi9aQYP8hpsVaR344ZeH+Sq0yC/D
	 N4FtoXbs7uxBQ==
Message-ID: <d8a16caf-103b-55ea-c0a3-71013b7fba7f@collabora.com>
Date: Tue, 4 Oct 2022 14:00:26 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2 3/3] iommu/mediatek: add support for MT8365 SoC
Content-Language: en-US
To: Alexandre Mergnat <amergnat@baylibre.com>,
 Rob Herring <robh+dt@kernel.org>, Yong Wu <yong.wu@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, Will Deacon <will@kernel.org>,
 Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, Fabien Parent <fparent@baylibre.com>,
 Markus Schneider-Pargmann <msp@baylibre.com>,
 Amjad Ouled-Ameur <aouledameur@baylibre.com>, devicetree@vger.kernel.org,
 iommu@lists.linux.dev
References: <20221001-iommu-support-v2-0-dbfef2eeebc9@baylibre.com>
 <20221001-iommu-support-v2-3-dbfef2eeebc9@baylibre.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221001-iommu-support-v2-3-dbfef2eeebc9@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 04/10/22 12:01, Alexandre Mergnat ha scritto:
> From: Fabien Parent <fparent@baylibre.com>
> 
> Add IOMMU support for MT8365 SoC.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> Reviewed-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
> Tested-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


