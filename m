Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0598B290080
	for <iommu@lists.linux.dev>; Mon, 30 Jun 2025 16:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751300044; cv=none; b=LyvMRNcybXMj/s6qxnqpY9A/iKWA1g3Zp0M0bLvCF8z5KaOZOp81tzdTVLNgB+mQkX7JcS71jC4S1zk/tM3HobQ1un/mR8pyR0B0MiTedTd3N3SSYxVblF3O3X/59u3qiCFz1bWmZizT2dwjXLercJYbmvRXlYvv+na9it82OkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751300044; c=relaxed/simple;
	bh=ejFEDSf8EYAO/rBEEWs62uOnoiP/wYb+ZA25xNO38Sc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=SS5HhhVhkAiit0z9My2A19Xk8hY+R0D6gOoyhq7Ef+HVFLc1fsEa4pyRGJB/kzOEf9vpCHxnocD7JFeLNPrCd4ZcoEoyHNDQM+ujBEGOc8CatWN14NKuoo/ZU3it2NA888b26EYUOXR+13bq1E0j+nsFqir2EHNXo+iUsrnIRi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AbdXMNap; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AbdXMNap"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-407a6c6a6d4so1468183b6e.1
        for <iommu@lists.linux.dev>; Mon, 30 Jun 2025 09:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751300039; x=1751904839; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z4K2GXVJiuaKILQGQTItkLUww/Aie+jD+a1eWqS2IOU=;
        b=AbdXMNapRqUzo/RnaXbUQYBnHna+uB6WgumLwfPMUq/3lLPGOljH2/ULvimKt856cd
         0SHOMoSieogcYpe9xqC1fzsHHH93WX8CAFvEqHY8EkBECrwNUTl6WJ9vOApbGboGajxF
         1jDl/c7thFfByToUSaltUpnVo2kGWDuODqPbmqNcLcQ22cMHz7ZlPrZo/ubwco0+SpAi
         r8kfAnhb040+X9pYlKQe/8ZeumQ/jmye7HkvsSs8qVj/wl/MuFm6FwTwQIb9aCuippQI
         WEaLU9N0U+6gn5A6l8nC0AUbpnc61fKCBhebu+nlz9beNnGOuwNvqKQ03xUosjOvtoxq
         4PTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751300039; x=1751904839;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z4K2GXVJiuaKILQGQTItkLUww/Aie+jD+a1eWqS2IOU=;
        b=mrXoWgBbhyengwB2p8L/ZLLGgQobktKAC4fCky9HlCM/Nv7smBr4TaVh8ATP28q1j+
         cObtLBCmh49YzWP5IrZB/qjF+rtRgBqGhnjoIBTsRUqIZiPgPCg4syj+Xbzw4cNJo/AC
         2AxJTrF7c80z7RDxF4i04Ooy2/iRtV9H9b3kW7eZ4o6tR/NAQbKelMwSqfOdG0PUbsa6
         btLAd2htLbUsqbIlk48/h1cKZ8JwMJfs/nYzVsui8bzN20/RHjhvQUz7xtUBAotmo07c
         DWYYxsCQ00J+1U3dCJ4BqiSeTCLc8h+68sjDkPH9g5nOxKgX3nVA01UgM9u4qOdrRq6E
         P0ag==
X-Forwarded-Encrypted: i=1; AJvYcCUj7ir9KEpdh8ld4jojS7cc8q+R5v4fTxe1AHpF6F5V+zE0kPoBNLTLxGZEn6eENnRWsewSyA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzcEl+nDjfLUrkkoFai0sLiVxkFK1HlNxhNP+GSkOJerbufaSOs
	6vJX7s0aDUSjMHN0mHSnOQl/OdI0tdvi99qB/RW/S+0k4ew78g5Bi6IDiBZN59fiDxY=
X-Gm-Gg: ASbGncsfWSsf1Gl1ShUKbhKsw4SfmqKR+mDC0RiYdBNzyQ9i+n7dK71ucDJrxAXHjzz
	ZyXdWFAEt8ZZSGF15GwJjflHQ61en6xM3pzw8F0XX6SeB/jurZ7xZxNnO3im7jgeCby2G7vdRL+
	QaNyFe1oWqgcGyK6OvT2d5jpx6GZWrWz06YSxYlrWilP8iPeD8BNGEpkzIoRdFEf51qmIOzL+py
	DmNp+gb0/WGJsnV+bi6vKqTdwPCxwSCMVeV57YaDvRqhHGDDkMR8gGZ+3yxlKsXrIJr3eQvg9Lo
	l5FZjAcSa/4LB3tTr8ATiigLhlzFacoaTTker+5EPXcsVD4qqjIotsN7wfH21TXRwBOz
X-Google-Smtp-Source: AGHT+IFAFlASv7Ojn6bTOl96SOGAN68965wAV7Dt6BYrHwwgQEMEUSNQsxpaQz7AhcjUol0ME8awag==
X-Received: by 2002:a05:6808:4f54:b0:404:764:f7b6 with SMTP id 5614622812f47-40b33c469c7mr12480268b6e.9.1751300038962;
        Mon, 30 Jun 2025 09:13:58 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:fb67:363d:328:e253])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40b32406a58sm1743722b6e.29.2025.06.30.09.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 09:13:58 -0700 (PDT)
Date: Mon, 30 Jun 2025 19:13:57 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	heiko@sntech.de, nicolas.dufresne@collabora.com, jgg@ziepe.ca
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, iommu@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, kernel@collabora.com,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: Re: [PATCH v4 3/5] iommu: Add verisilicon IOMMU driver
Message-ID: <9d247bec-d206-495e-b8d6-23a7c3cc0882@suswa.mountain>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623153931.158765-4-benjamin.gaignard@collabora.com>

Hi Benjamin,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Benjamin-Gaignard/dt-bindings-vendor-prefixes-Add-Verisilicon/20250623-234734
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20250623153931.158765-4-benjamin.gaignard%40collabora.com
patch subject: [PATCH v4 3/5] iommu: Add verisilicon IOMMU driver
config: alpha-randconfig-r073-20250627 (https://download.01.org/0day-ci/archive/20250629/202506290711.T0HOr5wS-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 8.5.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202506290711.T0HOr5wS-lkp@intel.com/

smatch warnings:
drivers/iommu/vsi-iommu.c:657 vsi_iommu_probe() error: uninitialized symbol 'err'.

vim +/err +657 drivers/iommu/vsi-iommu.c

15ea72d5401fb7 Benjamin Gaignard 2025-06-23  639  static int vsi_iommu_probe(struct platform_device *pdev)
15ea72d5401fb7 Benjamin Gaignard 2025-06-23  640  {
15ea72d5401fb7 Benjamin Gaignard 2025-06-23  641  	struct device *dev = &pdev->dev;
15ea72d5401fb7 Benjamin Gaignard 2025-06-23  642  	struct vsi_iommu *iommu;
15ea72d5401fb7 Benjamin Gaignard 2025-06-23  643  	int err;
15ea72d5401fb7 Benjamin Gaignard 2025-06-23  644  
15ea72d5401fb7 Benjamin Gaignard 2025-06-23  645  	iommu = devm_kzalloc(dev, sizeof(*iommu), GFP_KERNEL);
15ea72d5401fb7 Benjamin Gaignard 2025-06-23  646  	if (!iommu)
15ea72d5401fb7 Benjamin Gaignard 2025-06-23  647  		return -ENOMEM;
15ea72d5401fb7 Benjamin Gaignard 2025-06-23  648  
15ea72d5401fb7 Benjamin Gaignard 2025-06-23  649  	iommu->dev = dev;
15ea72d5401fb7 Benjamin Gaignard 2025-06-23  650  
15ea72d5401fb7 Benjamin Gaignard 2025-06-23  651  	iommu->regs = devm_platform_ioremap_resource(pdev, 0);
15ea72d5401fb7 Benjamin Gaignard 2025-06-23  652  	if (IS_ERR(iommu->regs))
15ea72d5401fb7 Benjamin Gaignard 2025-06-23  653  		return -ENOMEM;
15ea72d5401fb7 Benjamin Gaignard 2025-06-23  654  
15ea72d5401fb7 Benjamin Gaignard 2025-06-23  655  	iommu->num_clocks = devm_clk_bulk_get_all(dev, &iommu->clocks);
15ea72d5401fb7 Benjamin Gaignard 2025-06-23  656  	if  (iommu->num_clocks < 0)
15ea72d5401fb7 Benjamin Gaignard 2025-06-23 @657  		return err;

s/err/iommu->num_clocks/

15ea72d5401fb7 Benjamin Gaignard 2025-06-23  658  
15ea72d5401fb7 Benjamin Gaignard 2025-06-23  659  	err = clk_bulk_prepare(iommu->num_clocks, iommu->clocks);
15ea72d5401fb7 Benjamin Gaignard 2025-06-23  660  	if (err)
15ea72d5401fb7 Benjamin Gaignard 2025-06-23  661  		return err;
15ea72d5401fb7 Benjamin Gaignard 2025-06-23  662  
15ea72d5401fb7 Benjamin Gaignard 2025-06-23  663  	iommu->irq = platform_get_irq(pdev, 0);
15ea72d5401fb7 Benjamin Gaignard 2025-06-23  664  	if (iommu->irq < 0)
15ea72d5401fb7 Benjamin Gaignard 2025-06-23  665  		return iommu->irq;

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

