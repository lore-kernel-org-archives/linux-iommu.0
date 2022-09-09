Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9657E0
	for <iommu@lists.linux.dev>; Fri,  9 Sep 2022 07:49:12 +0000 (UTC)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 1DEFD6601F9B;
	Fri,  9 Sep 2022 08:49:10 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1662709750;
	bh=jMGgQw3flSvEElU0iAiEiuXLD9yc+tyfB4ZbbObfSCs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lqahKRi5D2fcH1XTZOcLLNJxVA8+jnjRiNNWbq05YAqMDCWlMh/37KaueNTxEGT4C
	 1EAgD+7qpYuDQ7YzSNU2+gJs8K99DRBEkjmGXVNskV4EY/a1GAG19u7rq5yFGkaFQW
	 QCfMGJTHb9HIns0wO91BQuJUSVwb/IRmpE5unXPatduVx02qRwHjaUtWE8102MkblG
	 0okIN5+AzfY4R73Rhd09pOpmit01q3JNSP7mYlHwcLD4OVfqg+NbT3iqSVZvajBRqu
	 phh6LGYrHF7cAd1OhPp/XAhkSxmfYAwM4TpfOB3owWbBbQmymBUVaMZOtmtFI546Pt
	 cQmCEMkaW+F2w==
Message-ID: <5032e29d-dfa0-e071-b3c2-845136443b0e@collabora.com>
Date: Fri, 9 Sep 2022 09:49:07 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2] dt-bindings: iommu: mediatek: mt8195: Fix max
 interrupts
Content-Language: en-US
To: matthias.bgg@kernel.org, Yong Wu <yong.wu@mediatek.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: devicetree@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel@lists.infradead.org, Matthias Brugger <mbrugger@suse.com>
References: <20220908141529.1478-1-matthias.bgg@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220908141529.1478-1-matthias.bgg@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 08/09/22 16:15, matthias.bgg@kernel.org ha scritto:
> From: Matthias Brugger <mbrugger@suse.com>
> 
> The mt8195-iommu-infra has five banks and one interrupt for each.
> Reflect that in the binding.
> 
> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


