Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A22528F514;
	Mon, 30 Jun 2025 16:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751301874; cv=pass; b=btMgbMHgGo+JpiaFj/9ZMApLTEyhyxXpvmQNaSen2UknBW43czxBrnNQoElbDYR0F7zIxDkM+1e04kGbvoYDnd9DI88zyawQH06ki4GwnpeHaN88oNkbUFNLC8Bz99/nElPQZR3TA3j6RumOcwXAEzP5WMVZha6hnHnNOkoh9vE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751301874; c=relaxed/simple;
	bh=X+WMHR6KsltwxPV+rL43bY8Z2+VB1DMqHWRlFcMifQA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bL1FihfBNrMn5HnQEEY1xeJNfxGhSjvd1Zzd5z+Oq5PNdHCLuzyD3xabJ3Y/qUoUqFu/ud5IYyPj6uMsnmTUOr3U9vF9NE4kiATZffd+cyXc7gejfHcUVvv4pkNVdevjR5+QID4RJG1ETK24EzKtszC7ayvjjSrb3Mu/eck3RIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=benjamin.gaignard@collabora.com header.b=GrnR8y0h; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=benjamin.gaignard@collabora.com header.b="GrnR8y0h"
ARC-Seal: i=1; a=rsa-sha256; t=1751301858; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ZKG1pUuIE3SbInx6lum+enVMNuGIW0ZN6xW94yLOaTmRBa72DDWfve2rMRITUUjXPs1k+A9aTnMOS4pLz8C2/feqkshU55AShExQXiZDCq1WxS2CSTyxKWqaN3CeMFAt5uPNtr5uMNi3cu8MM8CgYAZlVZSCIb3iHobJPCGSM24=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1751301858; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=PzDU9nqyjpEDS4lSPx+RFrm4zapOV2CV9JDtSEwn19Y=; 
	b=bvCepyT3rZsZlQALMYOAUCFNg4Hx8XFD+GNdKB17X09K6zFoi9thSvnKiwOg6xfczIPB4X8aD8Jd9M1j/ZOch89bir+uvvOjyi20jkhDZ2YdAlznC9qIQOSxSFAhPPbesavDrr0wDYnaVafsfuSMYw4NirgqzGaKL+xT02zaNWI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=benjamin.gaignard@collabora.com;
	dmarc=pass header.from=<benjamin.gaignard@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1751301858;
	s=zohomail; d=collabora.com; i=benjamin.gaignard@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=PzDU9nqyjpEDS4lSPx+RFrm4zapOV2CV9JDtSEwn19Y=;
	b=GrnR8y0hL1DqLSOlikB5obbZISVLcVPNmo97EfbOwJBhnPyKxiV6sWXTqSWjma1E
	mSIGx/s3Xmlj2KciJ3Vjyt115le/iQm06OBpCUz7JDRVymU/X/MqAj6LHYJvggpbOaM
	M0CsArhsYoIvqdEmwflkPHuI3opxO+gvj3Sd6p9Y=
Received: by mx.zohomail.com with SMTPS id 1751301856714404.94728450710375;
	Mon, 30 Jun 2025 09:44:16 -0700 (PDT)
Message-ID: <05a7c67f-d1fa-4ad4-a794-cc081cd04abc@collabora.com>
Date: Mon, 30 Jun 2025 18:44:12 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/5] iommu: Add verisilicon IOMMU driver
To: Dan Carpenter <dan.carpenter@linaro.org>, oe-kbuild@lists.linux.dev,
 joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de,
 nicolas.dufresne@collabora.com, jgg@ziepe.ca
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 kernel@collabora.com
References: <9d247bec-d206-495e-b8d6-23a7c3cc0882@suswa.mountain>
Content-Language: en-US
From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <9d247bec-d206-495e-b8d6-23a7c3cc0882@suswa.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Le 30/06/2025 à 18:13, Dan Carpenter a écrit :
> Hi Benjamin,
>
> kernel test robot noticed the following build warnings:
>
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Benjamin-Gaignard/dt-bindings-vendor-prefixes-Add-Verisilicon/20250623-234734
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
> patch link:    https://lore.kernel.org/r/20250623153931.158765-4-benjamin.gaignard%40collabora.com
> patch subject: [PATCH v4 3/5] iommu: Add verisilicon IOMMU driver
> config: alpha-randconfig-r073-20250627 (https://download.01.org/0day-ci/archive/20250629/202506290711.T0HOr5wS-lkp@intel.com/config)
> compiler: alpha-linux-gcc (GCC) 8.5.0
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> | Closes: https://lore.kernel.org/r/202506290711.T0HOr5wS-lkp@intel.com/
>
> smatch warnings:
> drivers/iommu/vsi-iommu.c:657 vsi_iommu_probe() error: uninitialized symbol 'err'.
>
> vim +/err +657 drivers/iommu/vsi-iommu.c
>
> 15ea72d5401fb7 Benjamin Gaignard 2025-06-23  639  static int vsi_iommu_probe(struct platform_device *pdev)
> 15ea72d5401fb7 Benjamin Gaignard 2025-06-23  640  {
> 15ea72d5401fb7 Benjamin Gaignard 2025-06-23  641  	struct device *dev = &pdev->dev;
> 15ea72d5401fb7 Benjamin Gaignard 2025-06-23  642  	struct vsi_iommu *iommu;
> 15ea72d5401fb7 Benjamin Gaignard 2025-06-23  643  	int err;
> 15ea72d5401fb7 Benjamin Gaignard 2025-06-23  644
> 15ea72d5401fb7 Benjamin Gaignard 2025-06-23  645  	iommu = devm_kzalloc(dev, sizeof(*iommu), GFP_KERNEL);
> 15ea72d5401fb7 Benjamin Gaignard 2025-06-23  646  	if (!iommu)
> 15ea72d5401fb7 Benjamin Gaignard 2025-06-23  647  		return -ENOMEM;
> 15ea72d5401fb7 Benjamin Gaignard 2025-06-23  648
> 15ea72d5401fb7 Benjamin Gaignard 2025-06-23  649  	iommu->dev = dev;
> 15ea72d5401fb7 Benjamin Gaignard 2025-06-23  650
> 15ea72d5401fb7 Benjamin Gaignard 2025-06-23  651  	iommu->regs = devm_platform_ioremap_resource(pdev, 0);
> 15ea72d5401fb7 Benjamin Gaignard 2025-06-23  652  	if (IS_ERR(iommu->regs))
> 15ea72d5401fb7 Benjamin Gaignard 2025-06-23  653  		return -ENOMEM;
> 15ea72d5401fb7 Benjamin Gaignard 2025-06-23  654
> 15ea72d5401fb7 Benjamin Gaignard 2025-06-23  655  	iommu->num_clocks = devm_clk_bulk_get_all(dev, &iommu->clocks);
> 15ea72d5401fb7 Benjamin Gaignard 2025-06-23  656  	if  (iommu->num_clocks < 0)
> 15ea72d5401fb7 Benjamin Gaignard 2025-06-23 @657  		return err;
>
> s/err/iommu->num_clocks/

I will fix that in next version but I will wait for more
comments/review before send it.

Regards,
Benjamin

>
> 15ea72d5401fb7 Benjamin Gaignard 2025-06-23  658
> 15ea72d5401fb7 Benjamin Gaignard 2025-06-23  659  	err = clk_bulk_prepare(iommu->num_clocks, iommu->clocks);
> 15ea72d5401fb7 Benjamin Gaignard 2025-06-23  660  	if (err)
> 15ea72d5401fb7 Benjamin Gaignard 2025-06-23  661  		return err;
> 15ea72d5401fb7 Benjamin Gaignard 2025-06-23  662
> 15ea72d5401fb7 Benjamin Gaignard 2025-06-23  663  	iommu->irq = platform_get_irq(pdev, 0);
> 15ea72d5401fb7 Benjamin Gaignard 2025-06-23  664  	if (iommu->irq < 0)
> 15ea72d5401fb7 Benjamin Gaignard 2025-06-23  665  		return iommu->irq;
>
