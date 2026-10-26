Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793003611;
	b=Eff3zjWkjP+f1Zt0GzgOay9VAtThXAdwhUNEC89S04yfDd/qGcRXmJ3B3HpiaVMIqCJN
	 T3VyXFsYnQEXplKD0075juPKg6weerxfOn4bEAOEsH4XMlucCpcHI93fQ5Mw+bKetixJA
	 p+J56+ziWb68onddPmXDqwfxd1QSk9Ye+brD89MIOGlOFC+4CR5pHZ9wXSQpXhzMetodK
	 fDXYu0d3YBxH0rduuhKLFOJEZjzVRBdqA3mfp2ZaEgz95Cot8SQbcahug/OZSe94XLPfg
	 +zHb81gLz/U3fjOG5CBZTHBBlLzoCpP8zgD+zP9vUGPzoHTrGImJACz9NZH1xDlkFEQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793003611;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=XQ7CboCxab8pAsYWIP610kHz8Zg6lfgejBrE8HM31Zs=;
	b=KLsuB13gkb0+w4fIqPT3lTsLuYpECRpH0P8+5x1QlzhbSRkPUkxeXQEIFUyY3UJim1RM
	 11adfzk+Oa9zgnenagVqXcUI46hqHy9am/KJxxiinBWurLWMRM2zgTzXcqyi+XgO6fcPz
	 twzgoO9xbbB6nmkvMGmbmqENGABfSCW2FW1bWY2Cr4RAeYee8IL09QvWFzMuHuPL+02oY
	 KzvuWIEnq8qNuHvQLq/tMiGNr6+uwKTs4UNLqotmgtFDsVl9lH/726uu6KYQv12HRpotX
	 Gr1WHt0bAV+GffqlGMYG+X7JtHzNCX1ur/b2SMbM+/JIXtMsmSyKE9aEwH2QLceRxeQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=benjamin.gaignard@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=CsMkd8IX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.11
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com [165.173.180.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEF7606A31A
	for <iommu@lists.linux.dev>; Mon, 26 Oct 2026 08:33:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6AEF7606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=collabora.com header.i=benjamin.gaignard@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=CsMkd8IX
ARC-Seal: i=1; a=rsa-sha256; t=1793003602; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=IyrdESao9nTm9S0mfJqN5UgzSBIswn+wSMU9ZZ22Q0MCNpnvKA1GCw4NjTELztHi5jct1t8KQYPdbrfqT7Grdju61jcpasqqoxdZcB1bqWf7PZXrILHYvduId2KUqirblXuRLukz9NXqPbJXykyIAwTsM2wMcKblDe1GROqcNpM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1793003602; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=XQ7CboCxab8pAsYWIP610kHz8Zg6lfgejBrE8HM31Zs=; 
	b=g2s802jJqB4dgWVaMoTWXyePntRv1Y51QiKg5bG+AjcOgk1EjY/BIB6D31ODKYBcZeTXihay+swd4yvBiMUMN9gAW9oPNjFatrsmcUD/L39cpIQsawULXJJZVUnxRy7LS0oZ7uLzR+uGwzUAMBGcZv+0AhiYd/CpNg6Y3WzDUGc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=benjamin.gaignard@collabora.com;
	dmarc=pass header.from=<benjamin.gaignard@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1793003602;
	s=zohomail; d=collabora.com; i=benjamin.gaignard@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=XQ7CboCxab8pAsYWIP610kHz8Zg6lfgejBrE8HM31Zs=;
	b=CsMkd8IXQTL323i3GjAip5yo+MRxELZ3R+0qUEUgkUWj/7u8mNXphT/AxF/injhq
	/gQ48iHLZf6qCACGC5HB7b73Aa8Y1SOijcExb9+HPfNheGvhDVIqxLehbSMjjLAOYFT
	83yA43kuzYLrbgl+t9ZbmNHw2a3njQvH35wGOpjk=
Received: by smtp.zohomail.com with SMTPS id 1793003597851708.4815720368576;
	Mon, 26 Oct 2026 01:33:17 -0700 (PDT)
Message-ID: <50f5f070-49cc-4a1b-a100-5cf918fed54f@collabora.com>
Date: Mon, 26 Oct 2026 09:33:14 +0100
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/vsi: keep the runtime PM callbacks without PM_SLEEP
To: Daniel Golle <daniel@makrotopia.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joerg.roedel@amd.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <e8114502dc91f5fb709509291fdd85e27545dfb6.1792716048.git.daniel@makrotopia.org>
Content-Language: en-US
From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <e8114502dc91f5fb709509291fdd85e27545dfb6.1792716048.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Le 25/10/2026 à 14:27, Daniel Golle a écrit :
> The runtime PM operations are handed to the driver core through
> pm_sleep_ptr(), which is NULL unless CONFIG_PM_SLEEP is set.
>
> Without system sleep support the IOMMU has no runtime PM callbacks at
> all: its clocks are never enabled by the driver, the page table is not
> restored when the power domain comes back, and iommu->enable stays set
> while genpd powers the domain off.
> The TLB flush issued from vsi_iommu_map() then writes to the unpowered
> IOMMU, and the first buffer allocation of the RK3588 AV1 decoder ends
> in an asynchronous SError.
>
> Use pm_ptr(), which keeps the operations whenever CONFIG_PM is set.
>
> Fixes: 917ace84b770 ("iommu: Add verisilicon IOMMU driver")

Thanks for the patch.

Reviewed-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>

> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>   drivers/iommu/vsi-iommu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/vsi-iommu.c b/drivers/iommu/vsi-iommu.c
> index 5dac20b143a55..1b447c0693936 100644
> --- a/drivers/iommu/vsi-iommu.c
> +++ b/drivers/iommu/vsi-iommu.c
> @@ -780,7 +780,7 @@ static struct platform_driver rockchip_vsi_iommu_driver = {
>   	.driver = {
>   		   .name = "vsi_iommu",
>   		   .of_match_table = vsi_iommu_dt_ids,
> -		   .pm = pm_sleep_ptr(&vsi_iommu_pm_ops),
> +		   .pm = pm_ptr(&vsi_iommu_pm_ops),
>   		   .suppress_bind_attrs = true,
>   	},
>   };
>
> base-commit: bd1ecbb61afefc6a8b876ccbc31e9228b44e9eab
