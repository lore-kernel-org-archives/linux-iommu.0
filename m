Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566562206BB
	for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 12:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742472727; cv=none; b=GzfT/84Skmtq126wRuh5OrQRYPyzhDvo1/Wxn7EMUNS4n1JLcDluK+NTQXAL8YZdWaYzknm4CGUxxm70jLxUXEzy5x6Yp7aoKnrcxr0NRnDX2wlTP8CXgRHApaO1w7IzbUW1H49CBuTWaGDMK8p2WbaIAg6EfUR9+xwPmAA91CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742472727; c=relaxed/simple;
	bh=G3JcQ/BlgiQc0S/ReTq/dq8fSXnz9sfijl/eiZ8CcP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cr9UVHOxk7eLKwgvr0wpLrEgi3C9/y8VdGPVcsa36K5WiV0t2kcKPv0hGMKaFzG54fw/25SfbbQIZKvOIiRdAn2FalFIE9p6A0Bxwg5oOmgilnB2fR7wQXKlpAlLfEcL7SbLoS2Hzf1pG4MQvXRZxsS2ivhdFMBqyy8OqcKfA8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=FffAY59i; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="FffAY59i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1742472718;
	bh=G3JcQ/BlgiQc0S/ReTq/dq8fSXnz9sfijl/eiZ8CcP8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FffAY59isVRHorZrbhXD+n65VxxVz63oUb0XIQRTjRlee6CWGE+r42VpQhlM1ylq6
	 /szAIG3T8mtS3pVeLHYE7Y7gOkeW5fzMECbCdvo2EwMhsRucGnIYMh660i0K9VHubV
	 AAbH2F7u57j+nI98KomtsbGkemVqS+DwThJVrMiHNmNd8CI/jhYIG14bBS5g+aotEx
	 wCeKeO7T9n9cM8WzC6+a86Itp7Z3eOnRSfu1iKjs7SA+Uz+pV0cIvANNHs6fqxMUO6
	 ew/rWmHaUgRZDGlXAUEmynRp1ajG4k/sjYtdfhCPEB5Q9S5m1ef4JaCpEbXUFz1nbu
	 kHuS9cYcgEnkA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3F1DD17E0607;
	Thu, 20 Mar 2025 13:11:57 +0100 (CET)
Message-ID: <46e0e1f1-e094-40f9-99f9-22678bb40d39@collabora.com>
Date: Thu, 20 Mar 2025 13:11:56 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] memory: mtk-smi: Add a flag skip_rpm
To: Xueqi Zhang <xueqi.zhang@mediatek.com>, Yong Wu <yong.wu@mediatek.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: Wendy-st Lin <wendy-st.lin@mediatek.com>,
 Project_Global_Chrome_Upstream_Group@mediatek.com,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 iommu@lists.linux.dev
References: <20250320073625.25225-1-xueqi.zhang@mediatek.com>
 <20250320073625.25225-3-xueqi.zhang@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250320073625.25225-3-xueqi.zhang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 20/03/25 08:36, Xueqi Zhang ha scritto:
> MT8196 SMI commons is backed up/restored by RTFF HW.
> It doesn't need SW control the register backup/store
> in the runtime callback.Therefore, add a flag skip_rpm
> to help skip RPM operations for SMI commons.
> 
> Signed-off-by: Xueqi Zhang <xueqi.zhang@mediatek.com>

So the MT8196 SMI common doesn't require any clocks?

That's fine for me, but this looks bloody similar to MT6989's SMI common, which
is SMI GEN3 and not GEN2....

....so, are you sure that you need a `skip_rpm` flag and not new MTK_SMI_GEN3 and
MTK_SMI_GEN3_SUB_COMM types? :-)

Regards,
Angelo

> ---
>   drivers/memory/mtk-smi.c | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
> index a8f5467d6b31..b9affa3c3185 100644
> --- a/drivers/memory/mtk-smi.c
> +++ b/drivers/memory/mtk-smi.c
> @@ -123,6 +123,7 @@ static const char * const mtk_smi_common_clks[] = {"apb", "smi", "gals0", "gals1
>   struct mtk_smi_common_plat {
>   	enum mtk_smi_type	type;
>   	bool			has_gals;
> +	bool			skip_rpm;
>   	u32			bus_sel; /* Balance some larbs to enter mmu0 or mmu1 */
>   
>   	const struct mtk_smi_reg_pair	*init;
> @@ -547,6 +548,9 @@ static int mtk_smi_dts_clk_init(struct device *dev, struct mtk_smi *smi,
>   {
>   	int i, ret;
>   
> +	if (smi->plat->skip_rpm)
> +		return 0;
> +
>   	for (i = 0; i < clk_nr_required; i++)
>   		smi->clks[i].id = clks[i];
>   	ret = devm_clk_bulk_get(dev, clk_nr_required, smi->clks);
> @@ -783,7 +787,7 @@ static int mtk_smi_common_probe(struct platform_device *pdev)
>   	common->dev = dev;
>   	common->plat = of_device_get_match_data(dev);
>   
> -	if (common->plat->has_gals) {
> +	if (!common->plat->skip_rpm && common->plat->has_gals) {
>   		if (common->plat->type == MTK_SMI_GEN2)
>   			clk_required = MTK_SMI_COM_GALS_REQ_CLK_NR;
>   		else if (common->plat->type == MTK_SMI_GEN2_SUB_COMM)
> @@ -814,13 +818,14 @@ static int mtk_smi_common_probe(struct platform_device *pdev)
>   	}
>   
>   	/* link its smi-common if this is smi-sub-common */
> -	if (common->plat->type == MTK_SMI_GEN2_SUB_COMM) {
> +	if (common->plat->type == MTK_SMI_GEN2_SUB_COMM && !common->plat->skip_rpm) {
>   		ret = mtk_smi_device_link_common(dev, &common->smi_common_dev);
>   		if (ret < 0)
>   			return ret;
>   	}
>   
> -	pm_runtime_enable(dev);
> +	if (!common->plat->skip_rpm)
> +		pm_runtime_enable(dev);
>   	platform_set_drvdata(pdev, common);
>   	return 0;
>   }


