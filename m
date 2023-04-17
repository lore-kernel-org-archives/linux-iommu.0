Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BD0C2EC
	for <iommu@lists.linux.dev>; Mon, 17 Apr 2023 09:00:57 +0000 (UTC)
Received: from [IPV6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2] (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 2D2A9660309E;
	Mon, 17 Apr 2023 10:00:55 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1681722056;
	bh=/YGQ+0hV77ZHCBNDe9AvFb4WIzLMZH7RtXL1XwElmPQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=h958IdabLtJFK6QKhYmlx0JGnJpy1cdDRpG7xDJultoBC/coreeGeNQ5dNrEVZB4I
	 mB0XZqDkmieWmAMmdyryMXVVY1Ubm2Vjc10AA8etFm0tU2pcXTGznD6GhbB7+9Ab2Z
	 XVwTeYlENzhruxT+oAdfXXw2rztjD6jGGtM+voIMZ4l4yGt5/h3yD6BwDlmgAjL4PH
	 1s0tztnkFKfv7NBMgNYMU6+Q5ofPRzEFhiGQscbh0mmeDEE+zvQLC22tDMuy4unzoe
	 H6dAwmfIy5JGJL6oF/LogeZdND6ygNLFeZkQVrWnFwo8h1+AzpqlBIzZh5PjwVt85Y
	 8BiEVIbGH/i0A==
Message-ID: <3716ddbb-1f80-7d1e-a517-2fe35bd4126a@collabora.com>
Date: Mon, 17 Apr 2023 11:00:52 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v10 2/7] iommu/mediatek: Fix two IOMMU share pagetable
 issue
Content-Language: en-US
To: Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: Robin Murphy <robin.murphy@arm.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 iommu@lists.linux.dev, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, mingyuan.ma@mediatek.com,
 yf.wang@mediatek.com, jianjiao.zeng@mediatek.com, chengci.xu@mediatek.com
References: <20230417073606.25729-1-yong.wu@mediatek.com>
 <20230417073606.25729-3-yong.wu@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230417073606.25729-3-yong.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 17/04/23 09:36, Yong Wu ha scritto:
> From: "Chengci.Xu" <chengci.xu@mediatek.com>
> 
> Prepare for mt8188 to fix a two IOMMU HWs share pagetable issue.
> 
> We have two MM IOMMU HWs in mt8188, one is VPP-IOMMU, the other is
> VDO-IOMMU. The 2 MM IOMMU HWs share pagetable don't work in this case:
>   a) VPP-IOMMU probe firstly.
>   b) VDO-IOMMU probe.
>   c) The master for VDO-IOMMU probe (means frstdata is vpp-iommu).
>   d) The master in another domain probe. No matter it is vdo or vpp.
> Then it still create a new pagetable in step d). The problem is
> "frstdata->bank[0]->m4u_dom" was not initialized. Then when d) enter, it
> still create a new one.
> 
> In this patch, we create a new variable "share_dom" for this share
> pgtable case, it should be helpful for readable. and put all the share
> pgtable logic in the mtk_iommu_domain_finalise.
> 
> In mt8195, the master of VPP-IOMMU probes before than VDO-IOMMU
> from its dtsi node sequence, we don't see this issue in it. Prepare for
> mt8188.
> 
> Fixes: 645b87c190c9 ("iommu/mediatek: Fix 2 HW sharing pgtable issue")
> Signed-off-by: Chengci.Xu <chengci.xu@mediatek.com>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


