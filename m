Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE671FA0
	for <iommu@lists.linux.dev>; Tue, 18 Apr 2023 09:15:43 +0000 (UTC)
Received: from [IPV6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2] (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 67C256603238;
	Tue, 18 Apr 2023 10:15:35 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1681809336;
	bh=zC/TAZzf2xurSfg4uBALXf9z3Fp/VkEw/HUUOGxXljA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Rj9nfVYH09a08kuz3NjQRkdFtge85SZjVxv/6WYw7KTuMe6mfabhLhi1yl7QzLnSi
	 xYiPA+lEP+bEezO6kq1bvKm3GySUVuYyJIhvkv5JelUBvLMb/07zcKs5gjmPufstis
	 0u0fW5wFE1Xm9eKHZ5j1xlgu14PrR7scMaWLQUMEIGFLQQvA2DBkOOV5uCPVz6zc2E
	 xfNe3jsPLLQPmsCEl2Gmvf4HA7PdA0x0mfmvxaGypF1pk/WHF9/8ZhrCgfAghgwwhk
	 xep4Pia4E2FiK2GKCc0HPbu8jR8ojGftLlJz3+32DKq08IfOFq5SzzvzFsYz3oXNAG
	 UALOGzOpxgklA==
Message-ID: <a3bb307a-8deb-a038-56e7-ded2abb87255@collabora.com>
Date: Tue, 18 Apr 2023 11:15:32 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v11 7/7] MAINTAINERS: iommu/mediatek: Update the header
 file name
To: Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: Robin Murphy <robin.murphy@arm.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 iommu@lists.linux.dev, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, mingyuan.ma@mediatek.com,
 yf.wang@mediatek.com, jianjiao.zeng@mediatek.com, chengci.xu@mediatek.com
References: <20230418083514.4379-1-yong.wu@mediatek.com>
 <20230418083514.4379-8-yong.wu@mediatek.com>
Content-Language: en-US
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230418083514.4379-8-yong.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 18/04/23 10:35, Yong Wu ha scritto:
> We add the prefix "mediatek," for the lastest ports header file name,
> For example, include/dt-bindings/memory/mediatek,mt8188-memory-port.h.
> Add a new entry for this.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


