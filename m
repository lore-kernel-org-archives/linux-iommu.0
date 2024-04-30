Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24ED317592
	for <iommu@lists.linux.dev>; Tue, 30 Apr 2024 11:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714476171; cv=none; b=DyT351y37SNaGeJ5M0uVQTI67TBnFoh/whP+va7VJqlYnZt0H4Ti3BjJ7CDpeZ9FOmsvnB4KHOXT6E4oKvY8dVDwEpaKYTnA8joqGWtfSvxau7nRogpcdG9CchoawAf5anQCRVhxSLa9dWRG0XXwCNeoMSlLgNjCrkt4c0wqpWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714476171; c=relaxed/simple;
	bh=ryZYQg8ZXpIvAXHOQnWRXIsCu5nVd68sMhv0YfmvMG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aaw3XwBQtDrqzKoT8KMQX3Hs/Suj1TNBVq5qq5vVLaRb68LmHKV8+C2zDAb15Wt1O66fISCOfeFDdgy0vZr7flrHL/Yhn4rx4DuzXbN34VaOonHARhpaq+EPj2H4HkEYMyyg7r70EylECCNjBhSlhVNVGXXaL6HBm7Sdehj7Be4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8F41C4AF1B;
	Tue, 30 Apr 2024 11:22:49 +0000 (UTC)
Date: Tue, 30 Apr 2024 12:22:47 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, will@kernel.org, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH] arm64: Properly clean up iommu-dma remnants
Message-ID: <ZjDUhzuRPWJNI_P7@arm.com>
References: <d4cc20cbb0c45175e98dd76bf187e2ad6421296d.1714472573.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4cc20cbb0c45175e98dd76bf187e2ad6421296d.1714472573.git.robin.murphy@arm.com>

On Tue, Apr 30, 2024 at 11:22:53AM +0100, Robin Murphy wrote:
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

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
