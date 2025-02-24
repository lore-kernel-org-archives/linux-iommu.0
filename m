Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D83B2566CA
	for <iommu@lists.linux.dev>; Mon, 24 Feb 2025 09:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740391148; cv=none; b=YVLu2Lucd4CbHes4jwS4yY1wHoP2BV1D9VpHX9zpYqxA0wgT+CqmhL/KDUTBrQ2k2kCT0kH4zqOkKzQF6aIuBoBJBUAhh6y/Z76dMi9lQTCq4pr5Y0lgPMDeaWeZQEvCfs13H7FZtQ0lhF74zUrveT96OlFKCf3y814y0CdGe9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740391148; c=relaxed/simple;
	bh=O6osCXMkR+k5uk/QSyOuPdRTQUC9ZmT13/Ik/89AMIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GszwXLCiaaapxc8p6WoaPfYAESCrHHlX0Jv2LQoMDM1+SaKBJepn2fBFR7Jhc0TOZbqM7lNElr50Xoj03uJqTq0KU+0PBS+AUWhLLIoliaR5uGqCU/hUT4/tduMbhxPiESQxcujwPiTU4wZb88g++B6POzjgQEPshrle3RRCa80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uVp0ts2F; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uVp0ts2F"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5461a485aa2so3871840e87.2
        for <iommu@lists.linux.dev>; Mon, 24 Feb 2025 01:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740391145; x=1740995945; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=O6osCXMkR+k5uk/QSyOuPdRTQUC9ZmT13/Ik/89AMIM=;
        b=uVp0ts2FUJuiToPf4Oy3kHm6Rp8zCDP5se4Odwbg+kdBgY1Xpdiwbe3xBagBdn298b
         SFYLXJUieWVe1KSxHT4WLtFWCt9l0v50amqOyUKdEsbD0fbzq3w3tfx4G4PP/Y1gulpz
         2Uzv1auUfufbht3LIC/NuUASVG34iMUFzKGtbLigLTHBozudLh7HeKmYV1m6tGMgLd/T
         2EO8zc+9mgE0tHUDbeV81aaHefE7iPiLrQXUvl4DPFA6GoFxQGbekFq8jKCtLI0eera9
         xc0V3tcsq40G+MEuKHDaHcGXJrJM9NRd/UiOiOMsXtESLACJI8RJvXTrkKH/zihVnHvI
         zipQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740391145; x=1740995945;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O6osCXMkR+k5uk/QSyOuPdRTQUC9ZmT13/Ik/89AMIM=;
        b=NoE/+UmQ+H8xYwUwArFJBD1NVnonLhiUETRrHUFEFwh4PWkj41EIwb3NuTtE1YN2wF
         G7x74Vc0QbPzMbrz3Owa0rO34sfFFPU9NkvEk6LvK1Tq2PJNvfEj/GVqFvh1+cmKB0SQ
         Z35K9xHFWjUkGRPkonLFCeAP7RGzsq7mSRut12Bc8AyMm9mt71Cg2ocXhhP01M6ER4Fg
         6cYMKisHyzxIywuH40E6BOLb3D9yErPHBEAcY5fZJnSU4QF1lwOLt2nV7tIktudZwLdz
         JZbZtib6/b/FLuRU3Lxqphdo2AZqPLs6iqq2Sj6d1NFZoF7iolJdfytfGQ4woXrEXyvR
         Godg==
X-Forwarded-Encrypted: i=1; AJvYcCXGpAU4SJLzTYk2k5CpdPg1vB53DtqTAHPjUrPaLnmJKcOxOnT6JAq/Lu66iyOUkJUqGkvHbg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxdeIPVypZW7hf7f9iz2tDylSPQffcmv7pPxVBe2bduQEiUnXpQ
	PUbo2pDHolGTg49fjcK9q9ByEwdXetADwnaW0b3cSoEPyuI8mzPYGxgdSJ7UGrl4f7rAo0QMgme
	yHEdDs1gEMzO3FofZ1jPcPmWQeSl+2vRBZM530w==
X-Gm-Gg: ASbGnculO3PdLqSU+9ezam7CSW4NTLn+xLZBgsklsZrrFrvx0MowYftMfdgcFhfT20e
	tczoCm9HAhYnfN1saIyNNX6i8GqKN1sBzteKdPuD0nDDNXCBZlYDKYYzygTuKYRQjoMc70Iae7E
	hU7M7qd9E=
X-Google-Smtp-Source: AGHT+IFopZlwkhYWY/RNr3zDptTVV6+70BUBCoxks79yWFjaOvVN8kY2ZRjnanDMYkS+tHav+OogpdOyTADvZGRmHWU=
X-Received: by 2002:a05:6512:1307:b0:545:2a7f:8f79 with SMTP id
 2adb3069b0e04-54838ef04b8mr5854049e87.16.1740391144587; Mon, 24 Feb 2025
 01:59:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250224051627.2956304-1-baolu.lu@linux.intel.com>
In-Reply-To: <20250224051627.2956304-1-baolu.lu@linux.intel.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Mon, 24 Feb 2025 17:58:53 +0800
X-Gm-Features: AWEUYZkMSn4vPFEG-tzi12j8lxJKJk5iXrx5HLKwOufSb-G1VhIWg-Jk6pa97bc
Message-ID: <CABQgh9G7Hv-qboRApRrVQF=Zpu5ZKaEf0zrv1=c=zv=LPB-O0g@mail.gmail.com>
Subject: Re: [PATCH v2 00/12] iommu: Remove IOMMU_DEV_FEAT_SVA/_IOPF
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>, 
	Fenghua Yu <fenghuay@nvidia.com>, Zhou Wang <wangzhou1@hisilicon.com>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 24 Feb 2025 at 13:16, Lu Baolu <baolu.lu@linux.intel.com> wrote:
>
> The new method for driver fault reporting support relies on the domain
> to specify a iopf_handler. The driver should detect this and setup the
> HW when fault capable domains are attached.
>
> Move SMMUv3 to use this method and have VT-D validate support during
> attach so that all three fault capable drivers have a no-op FEAT_SVA and
> _IOPF. Then remove them.
>
> This was initiated by Jason. I'm following up to remove FEAT_IOPF and
> further clean up.
>
> The whole series is also available at github:
> https://github.com/LuBaolu/intel-iommu/commits/iommu_no_feat-v2
>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>
Thanks Baolu

Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
