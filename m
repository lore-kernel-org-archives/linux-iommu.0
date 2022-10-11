Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70852564
	for <iommu@lists.linux.dev>; Tue, 11 Oct 2022 09:56:38 +0000 (UTC)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 7F0C06601A43;
	Tue, 11 Oct 2022 10:56:36 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1665482197;
	bh=Xu2VCk2uAhL/DhGGzHU1QNehUzJBsh9zGNcWOoQ33c8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aFMnE/IbYWGBPqrt4Eps9/ijTU5QsllXA1YwmcefHHWxr5kfmpDR+2QOMGgfmCQAh
	 lMw1pg3OvQcmBKjTypQkHfpwKqrupGlXcKzvA9ooe+gmEQs/5oCCJ82qXqJBTNCkn6
	 njrlP4RwkF+4/KstTcCoQ2LDH0ugN7Le5tqaazV80xeVmdSAE9BWNn85zTnVxBOmzE
	 QIsAD7V1T/LR67uWKmA1DjzFtQLucXteJcHus0C4HicWAxf5Kv8BNbDTe8FeIxXhrV
	 D5icW9IDwfLfU7qsLv5zVsyTSriEN9A9Ni9ixN5HNWXwWFnuO4tgIHoeye5oCXhWQY
	 aNo4rSAgTcdAg==
Message-ID: <5cda96ee-fca5-8b0b-8f38-dcff9a970cf5@collabora.com>
Date: Tue, 11 Oct 2022 11:56:33 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v3 1/3] dt-bindings: iommu: mediatek: add binding
 documentation for MT8365 SoC
Content-Language: en-US
To: Alexandre Mergnat <amergnat@baylibre.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, Joerg Roedel <joro@8bytes.org>,
 Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh+dt@kernel.org>,
 Will Deacon <will@kernel.org>, Yong Wu <yong.wu@mediatek.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Fabien Parent <fparent@baylibre.com>,
 Markus Schneider-Pargmann <msp@baylibre.com>,
 Amjad Ouled-Ameur <aouledameur@baylibre.com>,
 linux-mediatek@lists.infradead.org
References: <20221001-iommu-support-v3-0-c7b3059b0d16@baylibre.com>
 <20221001-iommu-support-v3-1-c7b3059b0d16@baylibre.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221001-iommu-support-v3-1-c7b3059b0d16@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 10/10/22 14:54, Alexandre Mergnat ha scritto:
> From: Fabien Parent <fparent@baylibre.com>
> 
> Add IOMMU binding documentation for the MT8365 SoC.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


