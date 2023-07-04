Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9F4568A
	for <iommu@lists.linux.dev>; Tue,  4 Jul 2023 12:19:49 +0000 (UTC)
Received: from [IPV6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2] (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id D60666606F8B;
	Tue,  4 Jul 2023 13:19:41 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1688473182;
	bh=1oWRHgWywTxFreiAWM2GmCCYIbq74sCQZlxzaMR2F5I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Pz6J+Pt/H8MEotnjUi90buA0wjG8N0JnRe8nNdu00gtpfh4wQR606INVxJl8k1OG+
	 kXksYP8/Rglq/gdt1ImqusTeOTGUn7Ax54m9TfiCOJeR3qoIdv1MzX95TTc+WS+QN8
	 NesEJvaDJAJZI/FmOXTbjlQZw+SS5SkR9gUAWhI2CIJal75IG+YPFrRVE8pf2x8b4E
	 GMZ5+v4Qoa7gtH5xMIcMMaM1KeuJZ7FUkqDIrCuehvPwUrJAPZKsF53K5VcdynxQwh
	 vTjONOyUvbqnIPRqcwl4XheGwwtSV1uuNTMe32gpHis5nWVankxqQtC7HkC0aWP1Fj
	 rI7TqeCnRZ+Pg==
Message-ID: <633be7a7-0bb8-1575-535e-2f96302198bd@collabora.com>
Date: Tue, 4 Jul 2023 14:19:39 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] iommu/mediatek: Remove a unnecessary checking for larbid
Content-Language: en-US
To: Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 iommu@lists.linux.dev, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230704115634.7727-1-yong.wu@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230704115634.7727-1-yong.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 04/07/23 13:56, Yong Wu ha scritto:
> Fix a coverity issue:
> 
>>> assignment: Assigning: larbid = (fwspec->ids[0] >> 5) & 0x1fU.
> 	larbid = MTK_M4U_TO_LARB(fwspec->ids[0]);
>>> between: At condition larbid >= 32U, the value of larbid must be between
>>> 0 and 31.
>>> dead_error_condition: The condition larbid >= 32U cannot be true.
> 	if (larbid >= MTK_LARB_NR_MAX)
>>> CID 11306470 (#1 of 1): Logically dead code (DEADCODE)
>>> dead_error_line: Execution cannot reach this statement:
>>> return ERR_PTR(-22L);
>          	return ERR_PTR(-EINVAL);
> 
> The checking "if (larbid >= MTK_LARB_NR_MAX)" is unnecessary.
> 

I agree with the coverity tool in that after the transformation (going through
the definition of MTK_M4U_TO_LARB) the check is pointless, but I think that the
right fix here is to check for validity of fwspec->ids[0] instead of simply
removing validation.

Having no validation after mtk_iommu_probe_device() is fine, but that's
because we assume that *this* function performs all validation steps.

Regards,
Angelo

> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
> Rebase on v6.4-rc1.
> ---
>   drivers/iommu/mtk_iommu.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index aecc7d154f28..67caa90b481b 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -838,9 +838,6 @@ static struct iommu_device *mtk_iommu_probe_device(struct device *dev)
>   	 * All the ports in each a device should be in the same larbs.
>   	 */
>   	larbid = MTK_M4U_TO_LARB(fwspec->ids[0]);
> -	if (larbid >= MTK_LARB_NR_MAX)
> -		return ERR_PTR(-EINVAL);
> -
>   	for (i = 1; i < fwspec->num_ids; i++) {
>   		larbidx = MTK_M4U_TO_LARB(fwspec->ids[i]);
>   		if (larbid != larbidx) {


