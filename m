Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9B81C1F0C
	for <iommu@lists.linux.dev>; Thu, 13 Mar 2025 09:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741859503; cv=none; b=q54wr66JANvHuBpvki2NN8dHFKquoJisw/8Dm5iBkf9Jc6kpIJTpOhiieqDxBk/Lh339auK2Fr0Lc1QbzMYYLmyaYoVU5FO2+sXPtnN/rp72JI0+hni/uHmVj/1CN2XFT7bBxzZp829eOO6RaIyGwEMQKh50/wmV27itL3lrvww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741859503; c=relaxed/simple;
	bh=QgYfWBbjniwPDhzWoyGsOU37LL+wBsYx4FA84RaPSfo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KOE8eDzjOomxuULGF8leqahwVHnND13CTr11wRiqd5z2ygLV01T8bXqJ/UudY07h/PSBDt3SIJ0bCp/D2oXc26vl9zVRiC5+RlR+EQE6PgBmA0uyCL2U3MuGRABtCtXKztpqpZnufOKSm+/J/N/oNhtwvj+7H5HEWLjWwyovIvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zq3Y1DDN; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zq3Y1DDN"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-30bd11bfec6so8196311fa.0
        for <iommu@lists.linux.dev>; Thu, 13 Mar 2025 02:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741859500; x=1742464300; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QgYfWBbjniwPDhzWoyGsOU37LL+wBsYx4FA84RaPSfo=;
        b=zq3Y1DDN35KcdRCwgGOOB2xJIzy4TjAoyoqy03xejGbUkiePkafidgbF6CpJEK7EYW
         eLuV5Zbdm7nkCb9dPKutwSzutQ7wLOHJTrtxqsRRla2+HzByyEfwMFP1J0OfYtwK53d1
         JuFd3N13Llb0DaQLBpZDxhGtQl629HZwlMhYZE9sYhuoYHSM/fJ/pTJco3kR2mf4ukOo
         JI4UvS0Ox0H0S0/yAZ+RZ3SF2Y1wCf/tNbI87v8/aQ0TvAZ+ZUJBnaCb9438ofZdQDsE
         sFNSehfZYq3veFq/9uVoA008a3gIdY0ATfzikpN3HyoYDlFe7Hr6INEflte/ftR7JDuo
         vMog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741859500; x=1742464300;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QgYfWBbjniwPDhzWoyGsOU37LL+wBsYx4FA84RaPSfo=;
        b=eO1iZxcpqy2+vMgnlry3Smsq2OgZ8SgPzOXtGl10FBkiWkb0dzmPe2UZIjLF6QofbZ
         uULAZpfWXG/h8eYh7IjeohkQNwPf+JKAVBHxADF66sTqXuV/MZ8cHbUqDwRaE4Q1wvYb
         lnJJ4f6xEwR4Oop4bTaFjQISQb6wqAr27pB3G5E9D/7XOjGzN/xJvKhjm8f2bhf91kmJ
         bhCuSKvGmJVQBXxCam+TadS1++M6up/nT050jtk/EtmVUsgti4ifHU/PdPtzSA/rTBM4
         07AKdYDBuc/0UnvAud9EAOg0ugBg029WARWzqM7mEnGHsnfdDgqIgDXBLtw21SH/80Kj
         dPLA==
X-Forwarded-Encrypted: i=1; AJvYcCVHgwdcBnsUs8MxVvEjeX6Jhut3AD8ZMhRaOVKIExsO3jOS5wGkc65Aqa7n7xaojVqYj7HQBA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxADiuafnSzT4o/OcoPaqnoncFOX5UHHmXLmclyBDke2qzYnCgR
	/hFxrKf5sHd7sLrsIZHwExPtzvlbRjcBEmujAq/6jujMyLvnk6xvd6izNbJdoFPQx41G8daeNA9
	qfHY+eU8nY4eAFDscRJyo1+7ZE5hIIRy34bKS/Q==
X-Gm-Gg: ASbGncvgjPpQM8wFsz4G3ujK3elh70t+IJWfs6enApIiY17pDCI7l5MQ2OD/r/UhDQU
	Dkn1imBMMaP9EAmsuq4qGNqA8crEhJKMOZfkJ1gc+u7iYHpo3MDcy4ZeSV4axDKKvNHUv+LWceI
	Bpb2+7Pn1vF5nShSXVlKPFqjMO0Xa0Sjs=
X-Google-Smtp-Source: AGHT+IG3yO5UKX7BvX8TOnQpocO31aqeIzqAIGkMVMg/xWmE6h9YKu7EryZASHPYLGHFC2RM9d53W/G30tx+Snpz0hA=
X-Received: by 2002:a19:f810:0:b0:549:91bc:67a9 with SMTP id
 2adb3069b0e04-549abaacaaamr3300696e87.9.1741859499720; Thu, 13 Mar 2025
 02:51:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250313051953.4064532-1-baolu.lu@linux.intel.com>
In-Reply-To: <20250313051953.4064532-1-baolu.lu@linux.intel.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Thu, 13 Mar 2025 17:51:28 +0800
X-Gm-Features: AQ5f1Jqrdmo7VWV6PyLD1e4rhSBwqyKwJOXS2K4j0MErxoy_ssJnjuYFCbVU2qM
Message-ID: <CABQgh9HKaDyDQXGB5ZEGg5q4a9ak_8OB9XQ+TpUNcZd_ZMeCAQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/8] iommu: Remove IOMMU_DEV_FEAT_SVA/_IOPF
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>, 
	Fenghua Yu <fenghuay@nvidia.com>, Zhou Wang <wangzhou1@hisilicon.com>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

Hi, Baolu

On Thu, 13 Mar 2025 at 13:19, Lu Baolu <baolu.lu@linux.intel.com> wrote:
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
> https://github.com/LuBaolu/intel-iommu/commits/iommu_no_feat-v4

I got an issue on this branch.

Linux 6.14-rc4 + iommu_no_feat-v2
drivers/pci/quirks.c
quirk_huawei_pcie_sva will set dma-can-stall first
arm_smmu_probe_device will check dma-can-stall and set stall_enabled
accordingly.

This branch
arm_smmu_probe_device happens first, when dma-can-stall = 0, so
stall_enabled =0.
Then drivers/pci/quirks.c: quirk_xxx happens

Still in checking.

And this branch does not need these two patches, right?
c7b1397bef3c iommu/arm-smmu-v3: Implement arm_smmu_get_msi_mapping_domain
5cd34634a73e iommu/dma: Support MSIs through nested domains

Thanks
