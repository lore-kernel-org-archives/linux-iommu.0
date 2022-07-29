Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080413D76
	for <iommu@lists.linux.dev>; Fri, 29 Jul 2022 08:15:43 +0000 (UTC)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 183C166015BD;
	Fri, 29 Jul 2022 09:06:47 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1659082008;
	bh=30poyXZDYHoOi7yo8Mx/13fpvXrbxzbgyPizx79sv7E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BArT00uCFpADlywHesn6+GFQVFZfyRmo+/xYXjJjqNsp07rspLkFAwQXNxQC39o8Q
	 m5bDCELgsZrlBQsuXFpovQz4i/YR4jAJX/uj6nmr1ri5/X8GiHQe6Qi9i57v/g7c3F
	 F1kosTbo5sEzshJe6MeV2wbxA1ez0XNQvHmeDcLcHZZ4r97dRMljMfXGEkBX3nbKVi
	 RwRfF6N66RCaPqoPb96VNcQ1odqqIyJCk6/KilsgLn9mPX6McAcd2JDUoYUAFQjiOu
	 j4v3ioD7yvS+YqtZ7a1REy1rQmv9pNmFgPNTZAPXMcQQQUr/tIMpghO2dOUyzDltuL
	 dBJrRdaPqZTPA==
Message-ID: <41c74c43-296d-1c27-450d-c108674451b4@collabora.com>
Date: Fri, 29 Jul 2022 10:06:44 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 04/20] dt-bindings: power: mediatek: Support naming
 power controller node with unit address
Content-Language: en-US
To: Tinghan Shen <tinghan.shen@mediatek.com>, Yong Wu <yong.wu@mediatek.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Lee Jones <lee@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 MandyJH Liu <mandyjh.liu@mediatek.com>
Cc: iommu@lists.linux.dev, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220729063208.16799-1-tinghan.shen@mediatek.com>
 <20220729063208.16799-5-tinghan.shen@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220729063208.16799-5-tinghan.shen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 29/07/22 08:31, Tinghan Shen ha scritto:
> Support naming power controller node with unit address, also compatible
> with node names without unit address.
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
