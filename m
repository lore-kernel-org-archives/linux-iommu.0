Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6963F3DDAF4
	for <iommu@lists.linux.dev>; Tue, 25 Aug 2026 08:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787645821; cv=none; b=Jn2tyuJcyL2LgV+sRLslOZMqa5G4ISaFcLC6MhN/tegs5Xewd2pR96JLk63or724oERcDyQ88tUxuWj3ziSUT4SYGiQaTHsAYFx+qIRdI2rtvUKS0LAeI82ZJZhvfC+VRwPu/JfSlRjyQ9egHzBUyTlM6qgCBxM7WvsnTEeQ7CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787645821; c=relaxed/simple;
	bh=TZnoghcej84GWSpXGrnc12ZKCdEf3FyhvFsi2YQtPm4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=THHFkCj9R1ntw9jap6gaKXnffSMnKzq7MaIZQkxnCwg5C+MYs0g83nfCIceGWxbA+IvGzG7BGYaXhvMcQHpPIZhjqA6ZVeYThGNi/SPjCcNe6pUaBCksj4Xs/LPNJwhzgMi6GwbyLxNZ8pyTf542JgqVbYLSsFXFJHn9Nagbyk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=cag1I/HW; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="cag1I/HW"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260825081656euoutp024a48082f0b66f3009c6de81fa1114646~O-mYDS-4q2684926849euoutp02b
	for <iommu@lists.linux.dev>; Tue, 25 Aug 2026 08:16:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260825081656euoutp024a48082f0b66f3009c6de81fa1114646~O-mYDS-4q2684926849euoutp02b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1787645816;
	bh=dPEEjswSDO/gFHKbIJmQiHOXlTLMfTr0a94c/bav9hw=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=cag1I/HWyHb/HG0Pa8d+qG8w+OqFFuO1UiH9PUeqtiKj3qOOXjaxKDAaD4Zo/yUIA
	 MxJGx9eSHJMsMDezAD26PvO/OJmJfvRVOX1VoOs4MK/LwbJU419qBc+IGeXoB1fmnA
	 FJ0zqBOEEOrJ88GRzqCrWN7Dqn6aWtPw2n3bKS0M=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260825081655eucas1p29f0cc0d9604e2dff85a94172a801988f~O-mXZ_S6o2874228742eucas1p2V;
	Tue, 25 Aug 2026 08:16:55 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260825081654eusmtip18c8296a5e03cc9251dcd1fa1ead918ff~O-mWzOWYz3027330273eusmtip1g;
	Tue, 25 Aug 2026 08:16:54 +0000 (GMT)
Message-ID: <eb0618b6-f2bc-4ed7-9178-e66ccee4962d@samsung.com>
Date: Tue, 25 Aug 2026 10:16:54 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 0/4] IOMMU driver improvements for modern Exynos SysMMUs
To: markuss.broks@gmail.com, "Joerg Roedel (AMD)" <joro@8bytes.org>, Will
	Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Krzysztof
	Kozlowski <krzk@kernel.org>, Peter Griffin <peter.griffin@linaro.org>, Alim
	Akhtar <alim.akhtar@samsung.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20260820-exynos-iommu-fixes-v1-0-6bbcd673bb15@gmail.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260825081655eucas1p29f0cc0d9604e2dff85a94172a801988f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260820191213eucas1p10a8b83c2c6ab0505f80a0b469c7ae487
X-EPHeader: CA
X-CMS-RootMailID: 20260820191213eucas1p10a8b83c2c6ab0505f80a0b469c7ae487
References: <CGME20260820191213eucas1p10a8b83c2c6ab0505f80a0b469c7ae487@eucas1p1.samsung.com>
	<20260820-exynos-iommu-fixes-v1-0-6bbcd673bb15@gmail.com>

On 20.08.2026 21:12, Markuss Broks via B4 Relay wrote:
> Newer SysMMU v7+ instances can lack BLOCK mode: CAPA1 bit 15 reports
> that the CTRL_BLOCK function is not implemented, and MMU_STATUS never
> reports a blocked state. The SysMMUs on Exynos 8835 are such
> instances.
>
> The driver currently assumes blocking always works, with two
> consequences on such hardware:
>
> The enable path writes CTRL_BLOCK first, which there acts as a plain 
> enable and starts translation before the page table base is programmed.
>
> Worse, both TLB invalidation paths gate the invalidation writes on
> sysmmu_block() succeeding, which it never does - so every unmap silently
> skips the invalidation. A stale TLB entry is a valid entry pointing
> at a freed page, so nothing ever faults: the device reads back garbage
> and its writebacks corrupt whatever the kernel has since reused those pages for.
>  
> This was tracked down on Exynos 8835 with the MFC, where the
> first decoder session of a boot worked and later sessions produced
> garbage along with random kernel memory corruption.
> Patches 1-3 add detection of the capability bit and adapt the enable
> sequence and the invalidation paths, matching the vendor driver's
> handling of these parts. Patch 4 is an independent debugging
> improvement: decode the v7 fault transaction info word (AxID/AxLEN),
> which identifies the issuing port when a master containing several
> DMA engines faults.
>
> Tested on the Samsung Galaxy Tab S9 FE (Exynos 8835/Exynos 1380).
>
> Signed-off-by: Markuss Broks <markuss.broks@gmail.com>

For the whole patchset:

Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>

> ---
> Markuss Broks (4):
>       iommu/exynos: detect SysMMUs without BLOCK mode
>       iommu/exynos: fix the enable sequence for no-block SysMMUs
>       iommu/exynos: fix TLB invalidation for no-block SysMMUs
>       iommu/exynos: decode the v7 fault transaction info
>
>  drivers/iommu/exynos-iommu.c | 37 +++++++++++++++++++++++++++++++++----
>  1 file changed, 33 insertions(+), 4 deletions(-)
> ---
> base-commit: 415606a7be939835db9b0d6b711887586646346d
> change-id: 20260820-exynos-iommu-fixes-e0e4d8f0fc06
>
> Best regards,
> --  
> Markuss Broks <markuss.broks@gmail.com>
>
>
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

