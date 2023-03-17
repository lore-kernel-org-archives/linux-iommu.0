Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9BA810
	for <iommu@lists.linux.dev>; Fri, 17 Mar 2023 09:34:11 +0000 (UTC)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 39E39660309E;
	Fri, 17 Mar 2023 09:34:03 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1679045644;
	bh=1yPL1wgWfhKqd3K689q3KbObv9DTbPB134duvaI4fJU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FrsJg9aiznLOzH2cHpyWLfhbcT5t/We9O9cErP11nrMTVJs0W4iVqtccOKpt9eRPq
	 UyoMH2zkqbyx1nOmRv+ELsYz+ZPMTnhXAg331YeyQXLsrUwpdsnVags9JpgGET5jwH
	 P13gZdO7+lKLoBU4qkapRJoOex4NdqIejG5embgk7boN/kT+tnrH6pqbvFYsQ53laL
	 K8V5wb5SUrugbD+Oy5e+tzbTR2QDbn6g3aoaV5oePw1L+oqug4WMRbCg0iQ0vX66xO
	 b9WDOw26jv3wXcVkALD98n7niKP1jTErcTPljcO4plH7L5nWXm3nWoSJGkLDrl2xG8
	 0hB1/RwxJC6hA==
Message-ID: <47cac7a6-c069-64a2-7979-b879b075058f@collabora.com>
Date: Fri, 17 Mar 2023 10:34:00 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v9 2/7] iommu/mediatek: Fix two IOMMU share pagetable
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
References: <20230317085541.20447-1-yong.wu@mediatek.com>
 <20230317085541.20447-3-yong.wu@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230317085541.20447-3-yong.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 17/03/23 09:55, Yong Wu ha scritto:
> From: "Chengci.Xu" <chengci.xu@mediatek.com>
> 
> Prepare for mt8188 to fix a two IOMMU HWs share pagetable issue.
> 
> We have two MM IOMMU HWs in mt8188, one is VPP-IOMMU, another is VDO-IOMMU.
> The 2 MM IOMMU HWs share pagetable don't work in this case:
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
> Signed-off-by: Chengci.Xu <chengci.xu@mediatek.com>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

I'm not sure whether this is *not* a fix... if a specific platform wasn't
affected, this may still be a logic mistake... to be cautious, I would
still add a Fixes tag to this one.

Otherwise, I would reword the commit title and remove the "Fix" word, so
that it would look something like...

iommu/mediatek: Prepare for pagetables domain sharing

I'm sorry for noticing that only at v9, but the previous versions had a bit
more stuff to address and couldn't really focus on analyzing this one.

If there's anything I've misunderstood about this patch, please feel free
to explain.

Regards,
Angelo

