Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739FA166319
	for <iommu@lists.linux.dev>; Wed, 28 Aug 2024 10:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724840354; cv=none; b=nM30TeJsve8nL0gw0vPn2KmwlK/GUeZuGFdXlVpddrUW9hNJOEmoG9DGpQodqYgRVRWwb43LyYp4rCOtXo36IwoaD+m1Il5PT1zzJTeyJMZyaFjbqI1wM8AwWBgROu6dVLm8ClpEAieMxl75/hg9DeSdJNCCNzSvxWrj1UiDgrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724840354; c=relaxed/simple;
	bh=fJKJVPeExin5GXPVP7io/M062o1kGCoLpEuIKrlZNQk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=WOFmortlv1DXvA8DznXXYA/PEz5F5TRNdAwPfs7R/KRlfT9LPBkCn0Ow/aQ2CgMONaT1YdirpTtX4hSZs2r/ERogNCJvWG7/P1cyNiGxyGVu+vGq0FCuQGYkGZ6b1pErUyDDvKb5ggIV+mNo1BW+6I6mHzYaIyhpAPwi5bQ7bk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Bpmhgowb; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Bpmhgowb"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240828101909euoutp02f1488568846c528775e868971dc0faed~v3SjEaRCX1545115451euoutp02U
	for <iommu@lists.linux.dev>; Wed, 28 Aug 2024 10:19:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240828101909euoutp02f1488568846c528775e868971dc0faed~v3SjEaRCX1545115451euoutp02U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1724840349;
	bh=iMWxhmo4OWsHADiajYzOga7hO54MYydQU3ANmx2xSjo=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=BpmhgowbxJIK2F5SOxfKr528mcqOi5ZT7uW4LMdo/fkdn1xl5pOHjbisJjCF6/xKe
	 Nz7M9Ht3IVzWVy38pNjABv6RZBrPQbh5BRaul5XXidJXHO9GQ3zuuZDygDX/f4jA/b
	 ysYcIu7tvO2ORnlKMToMwaNeUCFcIwu9bsqvp7k4=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240828101909eucas1p285a5d3c82481bf68adef55bdc11b06eb~v3Si2c0DA1208512085eucas1p2g;
	Wed, 28 Aug 2024 10:19:09 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id D5.EC.09624.D99FEC66; Wed, 28
	Aug 2024 11:19:09 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240828101908eucas1p20ee6e263a91d479190f542971f4f8928~v3Sib_aQE1579215792eucas1p2C;
	Wed, 28 Aug 2024 10:19:08 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240828101908eusmtrp2970dbdb831f09724ed2a3d438ae47544~v3SibJYuE0941909419eusmtrp2N;
	Wed, 28 Aug 2024 10:19:08 +0000 (GMT)
X-AuditID: cbfec7f2-bfbff70000002598-6b-66cef99d8175
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id A9.82.09010.C99FEC66; Wed, 28
	Aug 2024 11:19:08 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240828101907eusmtip2375e5b56571be93f2dc85ba199affef7~v3ShbyGgv1263512635eusmtip2A;
	Wed, 28 Aug 2024 10:19:07 +0000 (GMT)
Message-ID: <f59c67fa-9ed1-45e7-bdde-b5397b20d6ad@samsung.com>
Date: Wed, 28 Aug 2024 12:19:06 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: mm: fix DMA zone when dma-ranges is missing
To: Baruch Siach <baruch@tkos.co.il>, Christoph Hellwig <hch@lst.de>, Robin
	Murphy <robin.murphy@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	=?UTF-8?B?UGV0ciBUZXNhxZnDrWs=?= <petr@tesarici.cz>, Ramon Fried
	<ramon@neureality.ai>, Elad Nachman <enachman@marvell.com>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <d8e92b14181fc815773ac4f4bba70b5d48bc390e.1724838684.git.baruch@tkos.co.il>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAKsWRmVeSWpSXmKPExsWy7djP87pzf55LM1i/m8VixbU3LBbvl/Uw
	WjxetI3dYuXqo0wWv75YWGx6fI3VYuGc56wWfS/XsFoc/PCE1aLljqkDl8eaeWsYPTat6mTz
	2Lyk3uPF5pmMHrtvNrB5TF54kdlj1s9/LB57925n9JjbcIspgDOKyyYlNSezLLVI3y6BK+PE
	m/OsBcv4Kp5eu8bYwHiLu4uRk0NCwERiad8J1i5GLg4hgRWMEnvbGtkgnC+MEgdO74PKfGaU
	OL/hKzNMy5I376ESyxklrk55wQiSEBL4yCixcqIPiM0rYCfRM3cCC4jNIqAq0XD5MRtEXFDi
	5MwnYHFRAXmJ+7dmsIPYwgJeElu6ZjKBDBUR2M4oserTUjCHWeAAo8TZ1YfANjALiEvcejKf
	CcRmEzCU6HrbBTaVUyBC4svuqawQNfIS29/OYQZplhCYzinxbXsjE8TdLhIfzkxnhLCFJV4d
	38IOYctI/N85nwmioZ1RYsHv+1DOBEaJhue3oDqsJe6c+wW0jgNohabE+l36IKaEgKNE3zU+
	CJNP4sZbQYgb+CQmbZvODBHmlehoE4KYoSYx6/g6uK0HL1xinsCoNAspXGYh+XIWkm9mIaxd
	wMiyilE8tbQ4Nz212DAvtVyvODG3uDQvXS85P3cTIzCRnf53/NMOxrmvPuodYmTiYDzEKMHB
	rCTCe+L42TQh3pTEyqrUovz4otKc1OJDjNIcLErivKop8qlCAumJJanZqakFqUUwWSYOTqkG
	pgC9029Ugq2m9M5v8jx49w2n4IaQ1/znApeJpM63k3nwu/jbFEYf+ftHvWaFxpyae/vyP1+H
	7gounypdrQNntk/vsPu4b4/BKp4mv06B7QesIn3utPUYzFIQF7aMnrZ0x9nTekc6pr+SflZR
	7Jx9O86npZUhPZl5eoFIs/8ksdkMnim+B8W61tYuWMZ+5GCM6FEtjVrNlQbttzdd8v9TJjS1
	Mqdwp8P5zgqX1tW2Hpz6L+QNNWcsLNngaPmm6Pxfs0+Cxc52VqG9bncVwzuWnplzhUtDKL0x
	6pDNzk5OzoXegSGHVFI1RaTPM7Rxe1jV3br70txQgH2uVoFK7eZfrNEB7Zyz32zp3GoUx6TE
	UpyRaKjFXFScCADJqMmU0wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCIsWRmVeSWpSXmKPExsVy+t/xe7pzfp5LM9hzX91ixbU3LBbvl/Uw
	WjxetI3dYuXqo0wWv75YWGx6fI3VYuGc56wWfS/XsFoc/PCE1aLljqkDl8eaeWsYPTat6mTz
	2Lyk3uPF5pmMHrtvNrB5TF54kdlj1s9/LB57925n9JjbcIspgDNKz6Yov7QkVSEjv7jEVina
	0MJIz9DSQs/IxFLP0Ng81srIVEnfziYlNSezLLVI3y5BL+PEm/OsBcv4Kp5eu8bYwHiLu4uR
	k0NCwERiyZv3rF2MXBxCAksZJQ7MO88GkZCRODmtgRXCFpb4c62LDaLoPaPEtf1PmEESvAJ2
	Ej1zJ7CA2CwCqhINlx+zQcQFJU7OfAIWFxWQl7h/awY7iC0s4CWxpWsmE8ggEYHtjBK9a7+w
	gDjMAgcYJT72rWKEWLGaUaJ/y1awUcwC4hK3nsxnArHZBAwlut52gcU5BSIkvuyeygpRYybR
	tbWLEcKWl9j+dg7zBEahWUgumYVk1CwkLbOQtCxgZFnFKJJaWpybnltspFecmFtcmpeul5yf
	u4kRGL3bjv3csoNx5auPeocYmTgYDzFKcDArifCeOH42TYg3JbGyKrUoP76oNCe1+BCjKTA4
	JjJLiSbnA9NHXkm8oZmBqaGJmaWBqaWZsZI4r2dBR6KQQHpiSWp2ampBahFMHxMHp1QDUw2r
	WMijm3kpp5eJtuxjzLojeGPHmYrZC76vlN2TzHzXIvfrQQ8psfeZIlMFMy4zBh/8s8hyxmbL
	yuopdQzViz+eZmMX7ncMnTHFfUrvwnWhsx4tst95V2SF1JkUPTmeX8zPdi3faKvAvDevt3Xp
	l8liZmv16yS+XJmo2xg9w1Uo/eYzUVVF4UbBq8c61tbc/v7EMvDNhh/eTv/Km1xWZCyOSS3Y
	b8wq+fnl2Umigh2rpSf8Fjss3P76YL+eubHPress6b1Sa2w+G+5cMU3d/OKkJS5fLnFphs45
	H/Bba7q5QUsyp8M+x50bg1ueqB7oe/DlN+sUeeW7PspTj5id2ycpfX3ZrLhW5nVCZxIcdiix
	FGckGmoxFxUnAgCIRX+DZwMAAA==
X-CMS-MailID: 20240828101908eucas1p20ee6e263a91d479190f542971f4f8928
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240828095158eucas1p1e4c0cbd7d74b3e56c067382a229a5ec1
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240828095158eucas1p1e4c0cbd7d74b3e56c067382a229a5ec1
References: <CGME20240828095158eucas1p1e4c0cbd7d74b3e56c067382a229a5ec1@eucas1p1.samsung.com>
	<d8e92b14181fc815773ac4f4bba70b5d48bc390e.1724838684.git.baruch@tkos.co.il>

On 28.08.2024 11:51, Baruch Siach wrote:
> Some platforms, like Rockchip RK3568 based Odroid M1, do not provide DMA
> limits information in device-tree dma-ranges property. Still some device
> drivers set DMA limit that relies on DMA zone at low 4GB memory area.
> Until commit ba0fb44aed47 ("dma-mapping: replace zone_dma_bits by
> zone_dma_limit"), zone_sizes_init() restricted DMA zone to low 32-bit.
>
> Restore DMA zone 32-bit limit when the platform provides no DMA bus
> limit information.
>
> Fixes: ba0fb44aed47 ("dma-mapping: replace zone_dma_bits by zone_dma_limit")
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Link: https://lore.kernel.org/r/53d988b1-bdce-422a-ae4e-158f305ad703@samsung.com
> Suggested-by: Robin Murphy <robin.murphy@arm.com>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
> This should go via the dma-mapping tree that contains the fixed commit.
>
> Marek, can you test on Odroid M1? Thanks.


Works fine!

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>


> v2:
>
>    * Directly check whether platform provides DMA bus limit (Robin)
>
>    * Add Link tag
> ---
>   arch/arm64/mm/init.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index bfb10969cbf0..5710129b8033 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -116,6 +116,9 @@ static void __init arch_reserve_crashkernel(void)
>   
>   static phys_addr_t __init max_zone_phys(phys_addr_t zone_limit)
>   {
> +	if (zone_limit == PHYS_ADDR_MAX)
> +		zone_limit = U32_MAX;
> +
>   	return min(zone_limit, memblock_end_of_DRAM() - 1) + 1;
>   }
>   

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

