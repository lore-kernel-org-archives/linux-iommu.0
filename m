Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07262CA5
	for <iommu@lists.linux.dev>; Tue,  7 Mar 2023 09:53:39 +0000 (UTC)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 367666602FE5;
	Tue,  7 Mar 2023 09:53:37 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1678182818;
	bh=vOeT3Ma4VCBuwsG6yxTjz0hhW4n6wBQ0pRmiNCigU4Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VcID3wSgiRgGRYsYRldHpyMmkM9q9Iwj7PmDLnNVemLF8K/Q0FQ7c0oOHsxU4K/Hn
	 RE99gklE/DYhCxYx8uHMbbk7HhYWiV6Rqdul73r+xhWoiBucpULpGYxBiLONCuryJq
	 Czj7vMF0sG1gY43EUld5eFbC/CWuj0Yk50H/Hs+ebTiL0AHr6cnQigCJRzqidyC+gL
	 9gpTjtnMciNE2iMejiwJLMhvdlgy+gNxCgW29vcua+X9dAbj4pOcDAGDug2rRzvm07
	 jp72R1UTHATxpR7OQE/gntZ8TYjZipCQCuJzHsH90L8aiCfmvwegMKhsbqnZm4zOu0
	 U7EKfFtV9gOZA==
Message-ID: <33587fba-566e-38f9-1f27-868133a854f0@collabora.com>
Date: Tue, 7 Mar 2023 10:53:34 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v8 2/7] iommu/mediatek: Set dma_mask for PGTABLE_PA_35_EN
Content-Language: en-US
To: Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: Robin Murphy <robin.murphy@arm.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 iommu@lists.linux.dev, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, mingyuan.ma@mediatek.com,
 yf.wang@mediatek.com, jianjiao.zeng@mediatek.com, chengci.xu@mediatek.com,
 youlin.pei@mediatek.com
References: <20230307080555.14399-1-yong.wu@mediatek.com>
 <20230307080555.14399-3-yong.wu@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230307080555.14399-3-yong.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 07/03/23 09:05, Yong Wu ha scritto:
> When we enable PGTABLE_PA_35_EN, the PA for pgtable may be 35bits.
> Thus add dma_mask for it.
> 
> Fixes: 301c3ca12576 ("iommu/mediatek: Allow page table PA up to 35bit")
> Signed-off-by: Chengci.Xu <chengci.xu@mediatek.com>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

I would send this patch separately from the MT8188 series, as that's purely a
(quite important) fix that is not specific to the introduction of MT8188, even
though that SoC needs that fix.

Regardless of that,

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


