Received: from relay03.th.seeweb.it (relay03.th.seeweb.it [5.144.164.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86A517106E
	for <iommu@lists.linux.dev>; Tue, 30 Apr 2024 13:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.144.164.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714482023; cv=none; b=S5D8quZbknmDrb/OX39qHXcxFw4NXrwUsJmePc3v5SLrfIpRqooO+0NZKgG+7pL81aa6aUv+o8ARHC8AQkXwgHaLMaYMl5PNO3548h+xc6+IAXGNiq2fzaR9yGiybqmvWLCGPuu1o9SxoUTX17si9W4BHfATG4nNXXCRV6/UGck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714482023; c=relaxed/simple;
	bh=bdpn50SxD09dSxa7z+OSnvabNF1NiWYXLMiyWh/ZrSc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Er/KMxSGXXwudWkhssR2YRAULGIrhVbg6Bv4NAjLpIy781ouBOY+eT2tGYfKuS+9wUgG5HmwRH1g3Lg2bHKHttww6o5xcg8jFjkhPipKKcInBKQakfzY9wLVhrohSfAQUdtBGZqtlz2NF8xpD3BICNlvdnBcpUzcQQjGB2pL6bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=somainline.org; spf=pass smtp.mailfrom=somainline.org; arc=none smtp.client-ip=5.144.164.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=somainline.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=somainline.org
Received: from [192.168.114.15] (078088045141.garwolin.vectranet.pl [78.88.45.141])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 958A920189;
	Tue, 30 Apr 2024 14:51:29 +0200 (CEST)
Message-ID: <4a4482a0-4408-4d86-9f61-6589ab78686b@somainline.org>
Date: Tue, 30 Apr 2024 14:51:28 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: Properly clean up iommu-dma remnants
To: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org
Cc: will@kernel.org, catalin.marinas@arm.com,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
References: <d4cc20cbb0c45175e98dd76bf187e2ad6421296d.1714472573.git.robin.murphy@arm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <d4cc20cbb0c45175e98dd76bf187e2ad6421296d.1714472573.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 30.04.2024 12:22 PM, Robin Murphy wrote:
> Thanks to the somewhat asymmetrical nature, while removing
> iommu_setup_dma_ops() from the arch_setup_dma_ops() flow, I managed to
> forget that arm64's teardown path was also specific to iommu-dma. Clean
> that up to match, otherwise probe deferral will lead to the arch code
> erroneously removing DMA ops set elsewhere.
> 
> Reported-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Link: https://lore.kernel.org/linux-iommu/Zi_LV28TR-P-PzXi@eriador.lumag.spb.ru/
> Fixes: b67483b3c44e ("iommu/dma: Centralise iommu_setup_dma_ops()")
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---

Tested-by: Konrad Dybcio <konrad.dybcio@linaro.org> # QC SM8550 QRD
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
