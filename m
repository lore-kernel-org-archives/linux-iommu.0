Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0B827F01C
	for <iommu@lists.linux.dev>; Wed, 18 Jun 2025 14:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750255577; cv=none; b=m1W6ODZ/f6STaJpO5guN7GskU/kMSax75XYFnKmhGMgLZuwrLN6IJMhclZYdyZS1HNZwKKMnqad8vOOiq3yztQNMT2G7rbzVVnxd7k+/UUpcUu6ytdUZc3KqIxoelCvYekcGOgf0xHg3JkQ9j7L/RDn0d42JOuxIFOse7aWvOxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750255577; c=relaxed/simple;
	bh=F+z3MjGV4TaCyb77dWy2XEtcmuTfBFweoyGTmfosw2k=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=T0Xcvy4o2xU7Ec3ieKIZ/rIrynujulePiC3fHAkRp0XIXmBfCcUfTvnGzhNBYeTJONQ/Lr9TiLHPhub+3J+cxMgcurzidbuitVVHH62zmHTxVVsmJE39JY546Y9/QFcN2lWyG2luyY/zQ/hp3Odp/lj0PzGtrVvnLmdkSEVAQnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=RbLS+nEL; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="RbLS+nEL"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 5C180256DF;
	Wed, 18 Jun 2025 16:06:14 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id arg8hl3w8vFY; Wed, 18 Jun 2025 16:06:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1750255573; bh=F+z3MjGV4TaCyb77dWy2XEtcmuTfBFweoyGTmfosw2k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=RbLS+nELQwq7MsUtGmmRxWu4zbFot/+uRZZvrKaZLQ2Ez/1Gb9qDwHVa0JeTCahLF
	 o5Febd3cxIBcuMPLbfuK4nFyHvLCUwmz3t1Kv1FMMzuP2LNyblLKtQATP4cbGjnnDZ
	 FJpBk9XORLf8RjbSESf8+PAsDlsrUoU/2PmmZ2+2z1ePDEcgbNl5VPsG9FQQQagyfF
	 GHJxnlOMEg4vnk0Y6dPBGNjkK94ewGVXCTt+F0bBZJYdnmw0pG3OHpNDImRdjSl6lE
	 q7822OQ7EXXZC0kOadB3uWjYJcWUC3jR1LCm/jDapcRclTrbvKvnVPsBPlmh3ALApG
	 ojLQGnYGVPDsg==
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Wed, 18 Jun 2025 14:06:13 +0000
From: Kaustabh Chakraborty <kauschluss@disroot.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>, Joerg Roedel
 <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
 <robin.murphy@arm.com>, Inki Dae <inki.dae@samsung.com>, Seung-Woo Kim
 <sw0312.kim@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>
Cc: iommu@lists.linux.dev, dri-devel@lists.freedesktop.org
Subject: Re: Help: Samsung Exynos 7870 DECON SYSMMU panic
In-Reply-To: <544ad69cba52a9b87447e3ac1c7fa8c3@disroot.org>
References: <544ad69cba52a9b87447e3ac1c7fa8c3@disroot.org>
Message-ID: <919fce023f7b8137dc69d0d55ed7edde@disroot.org>
X-Sender: kauschluss@disroot.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

On 2025-06-18 14:02, Kaustabh Chakraborty wrote:
> Since bcb81ac6ae3c (iommu: Get DT/ACPI parsing into the proper probe 
> path),
> The Samsung Exynos 7870 DECON device (with patches [1], [2], and [3]) 
> seems
> to not work anymore. Upon closer inspection, I observe that there is an
> IOMMU crash.
> 
> [...]
> 
> -		dev->bus->dma_configure(dev);
> +		if (!strcmp(dev_name(dev), "14830000.decon"))
s/!//
