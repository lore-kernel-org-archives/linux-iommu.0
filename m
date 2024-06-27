Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3204314B95B
	for <iommu@lists.linux.dev>; Thu, 27 Jun 2024 11:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719487666; cv=none; b=gz06YwYzU3yswK80ySgRfxXYtbM0cZcG9gz7ERAAerlcJi/EOh4RgZdlg6IM6Y6h7NfcoWlM2B24hkjygB89oypDEL5eEWdZwNjLNaFGt5gupllDfneFbL5PPdF4o6RZnwZCDHZxbaGX3qSyVpG5AHeiViTPpvPIs4gvv9ZXoKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719487666; c=relaxed/simple;
	bh=0HoB/1HZCOFaM/FV8xXHyPVn8lWDiQRugRGfyLSyjTA=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=UR62jGxb9sB7eTKqEUzcFcKYLdNvrdMcojzlHcdjMbd+aF58ETR3NRVi6pzWAz2iVsA3uRE+71aq5gsTTdmK24M5YePcASABKAtOlCAzMD4l6UtwDuxokGHsK60mCqm9IhxL96kq8wQxH1SAaftgco9vce4+CcGuNdLO+26n1AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=iS69jOBe; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="iS69jOBe"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240627112736euoutp015d7927c54b16c5d4e6df615a66460778~c2Om9Apc-1816418164euoutp01U
	for <iommu@lists.linux.dev>; Thu, 27 Jun 2024 11:27:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240627112736euoutp015d7927c54b16c5d4e6df615a66460778~c2Om9Apc-1816418164euoutp01U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1719487656;
	bh=u88LBBG3mbwMObYO4cXTwVKPjC5PKpg2/vkya7BYuM8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=iS69jOBeUnEb8oajX/mw5nqOQN+Ji65peR2szephYUHKR1gFqRi+4X9YGLPQ0qV2w
	 2DoY/iRMUotI1Q+v2XV6eOcwjpbxt6Tgnzgh1tXhRKFTP7/GO6fURkLDrpew1r2JHM
	 sne+lF/AjCBGhi6RiiOcV7kKZKm+D38XZDARYYso=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240627112735eucas1p243d681d5c93d17caab830202cdc51856~c2OmrKpnF0664406644eucas1p2D;
	Thu, 27 Jun 2024 11:27:35 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id A2.20.09620.7AC4D766; Thu, 27
	Jun 2024 12:27:35 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240627112735eucas1p19932d1193a24f7b440a55ca4b1a35753~c2OmNNbzf1568215682eucas1p1h;
	Thu, 27 Jun 2024 11:27:35 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240627112735eusmtrp10bd67c91fe4114869cbcbc7c41488696~c2OmMm45W2865228652eusmtrp1b;
	Thu, 27 Jun 2024 11:27:35 +0000 (GMT)
X-AuditID: cbfec7f5-d1bff70000002594-3a-667d4ca76bd2
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id E3.A6.08810.7AC4D766; Thu, 27
	Jun 2024 12:27:35 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240627112735eusmtip2728d94d795a242af793816b6be546941~c2Ol9hvbN2812428124eusmtip2Q;
	Thu, 27 Jun 2024 11:27:35 +0000 (GMT)
Received: from localhost (106.210.248.245) by CAMSVWEXC01.scsc.local
	(2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Thu, 27 Jun 2024 12:27:34 +0100
Date: Thu, 27 Jun 2024 13:27:29 +0200
From: Joel Granados <j.granados@samsung.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
CC: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin
	Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, Jason
	Gunthorpe <jgg@ziepe.ca>, Jacek Lawrynowicz
	<jacek.lawrynowicz@linux.intel.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] iommu/vt-d: Fix missed device TLB cache tag
Message-ID: <20240627112729.rcadq6ey6bp6dios@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240620062940.201786-1-baolu.lu@linux.intel.com>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJKsWRmVeSWpSXmKPExsWy7djP87rLfWrTDF6u1LfYPHErm8WvLxYW
	U879ZbWYOeMEo0Xn7A3sFkvfbmW3uLxrDpvFwQ9PWC1a7pg6cHo8OTiPyWPNvDWMHov3vGTy
	2LSqk81j3slAjxebZzJ6fN4k57H1822WAI4oLpuU1JzMstQifbsEroyNn06yFXSIVvycvoy5
	gfG/QBcjJ4eEgInEzfff2boYuTiEBFYwSqw41swE4XxhlOi/9YoZwvnMKPFgy2XWLkYOsJZL
	3/wg4ssZJY7cvcUKV/T67X5GCGcro8TW3TMYQZawCKhKrPnaywpiswnoSJx/c4cZZJKIgLrE
	sy8BIPXMAguZJL69OMAEUiMs4C5xYc59ZhCbV8BBYvvjx+wQtqDEyZlPWEBsZqA5C3Z/YgOZ
	wywgLbH8HwdImFPAXmLpyiPsEL8pS0z//pMJwq6VWHvsDDvILgmBdk6JhWf+skEkXCR63j5m
	hLCFJV4d3wLVLCNxenIPC0TDZEaJ/f8+QHWvZpRY1vgVaqy1RMuVJ1AdjhJrVl9kgoQRn8SN
	t4IQh/JJTNo2nRkizCvR0SYEUa0msfreG5YJjMqzkLw2C8lrsxBeW8DIvIpRPLW0ODc9tdg4
	L7Vcrzgxt7g0L10vOT93EyMwNZ3+d/zrDsYVrz7qHWJk4mA8xCjBwawkwhtaUpUmxJuSWFmV
	WpQfX1Sak1p8iFGag0VJnFc1RT5VSCA9sSQ1OzW1ILUIJsvEwSnVwJSUtOLopQsvO3iMdWwy
	9t7vvNqw0q1veUXPSvWFvO83SHl5O4YpuQnNSHe/uDk8ytV3Tb5r0Ybdh/w+W8syHdjOtujU
	zm4mrWvvLBa2um44LD+9yFbm4vtEt8Vcc5WdEp/Pf1TSHPJyWcpi/bOndp6dGWH2aMtFM/EN
	TK3PJgm/PeX0Y5va020v3H/esY+6VlYw1VXZ69kUlmdXP/yb8ZEv9LUQL0fmlX0coVvbHl3r
	WLxj23vHsJ6jLdPkTXz6XhYxG+cu9J/wfI61y5ZbezN3eItx352ed/5aQIruVz+R8j/vVHNX
	sRb3WyUn7dm4KP9W2aJEzypXKRve6rifc+a/S3b3TVj6VSztrr25hbASS3FGoqEWc1FxIgAI
	JRJevAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMIsWRmVeSWpSXmKPExsVy+t/xe7rLfWrTDCYc4bXYPHErm8WvLxYW
	U879ZbWYOeMEo0Xn7A3sFkvfbmW3uLxrDpvFwQ9PWC1a7pg6cHo8OTiPyWPNvDWMHov3vGTy
	2LSqk81j3slAjxebZzJ6fN4k57H1822WAI4oPZui/NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9
	Q2PzWCsjUyV9O5uU1JzMstQifbsEvYyNn06yFXSIVvycvoy5gfG/QBcjB4eEgInEpW9+XYxc
	HEICSxkl9t5bwNjFyAkUl5HY+OUqK4QtLPHnWhcbRNFHRom7U1ugnK2MEtt+bWAGqWIRUJVY
	87UXrINNQEfi/Js7zCAbRATUJZ59CQAJMwssZJJ4P9cWxBYWcJe4MOc+WCuvgIPE9seP2UFs
	IQE7icnTmlgg4oISJ2c+YYHo1ZFYsPsTG8hIZgFpieX/OEDCnAL2EktXHmGHuFNZYvr3n0wQ
	dq3Eq/u7GScwCs9CMmkWkkmzECYtYGRexSiSWlqcm55bbKhXnJhbXJqXrpecn7uJERib2479
	3LyDcd6rj3qHGJk4GA8xSnAwK4nwhpZUpQnxpiRWVqUW5ccXleakFh9iNAUGxERmKdHkfGBy
	yCuJNzQzMDU0MbM0MLU0M1YS5/Us6EgUEkhPLEnNTk0tSC2C6WPi4JRqYOKXjFiXdTP1XOcf
	qYO2FpytoTN6zMQiRQQ8mw8HKlwMXmyxqMlrepC/zKLGpvRPGRn/v+mIGWytOPpnfpwna0X9
	5/DukG8bxFJXlP4Kv8b4i1tk3c6XCgu6XvYcimOS+rn/lFHXladH1MOffJRd1eao0VnE+nb7
	P6FVi0oC7e/LT3/3PU5Ky3Ixt0gJc1miCmNlhml49dQTuxP9Jtt6h6Vyr8lf1HGNuXb1xTCx
	2E0dmpzMKjZCfBcW5Ms2OjLMutDkMC3olM6x92pvp1w0+/dxY4TVx9ybmldZlnvc6PqxL/fq
	9wOzhLR/rbb3LlwkeWrtAqnntq1yE88/ll7/4+JKxfleDhtdb7g+WfV2phJLcUaioRZzUXEi
	AHF5p8ZWAwAA
X-CMS-MailID: 20240627112735eucas1p19932d1193a24f7b440a55ca4b1a35753
X-Msg-Generator: CA
X-RootMTR: 20240627112735eucas1p19932d1193a24f7b440a55ca4b1a35753
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240627112735eucas1p19932d1193a24f7b440a55ca4b1a35753
References: <20240620062940.201786-1-baolu.lu@linux.intel.com>
	<CGME20240627112735eucas1p19932d1193a24f7b440a55ca4b1a35753@eucas1p1.samsung.com>

On Thu, Jun 20, 2024 at 02:29:40PM +0800, Lu Baolu wrote:
> When a domain is attached to a device, the required cache tags are
> assigned to the domain so that the related caches can be flushed
> whenever it is needed. The device TLB cache tag is created based
> on whether the ats_enabled field of the device's iommu data is set.
> This creates an ordered dependency between cache tag assignment and
> ATS enabling.
> 
> The device TLB cache tag would not be created if device's ATS is
> enabled after the cache tag assignment. This causes devices with PCI
> ATS support to malfunction.
> 
> The ATS control is exclusively owned by the iommu driver. Hence, move
> cache_tag_assign_domain() after PCI ATS enabling to make sure that the
> device TLB cache tag is created for the domain.
> 
> Fixes: 3b1d9e2b2d68 ("iommu/vt-d: Add cache tag assignment interface")
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/iommu.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> Change log:
> v2:
> - Reverting the order instead of adding unnecessary run-time overhead.
> 
> v1:
> - https://lore.kernel.org/linux-iommu/20240619015345.182773-1-baolu.lu@linux.intel.com/
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 2e9811bf2a4e..fd11a080380c 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -2114,12 +2114,6 @@ static int dmar_domain_attach_device(struct dmar_domain *domain,
>  	if (ret)
>  		return ret;
>  
> -	ret = cache_tag_assign_domain(domain, dev, IOMMU_NO_PASID);
> -	if (ret) {
> -		domain_detach_iommu(domain, iommu);
> -		return ret;
> -	}
> -
>  	info->domain = domain;
>  	spin_lock_irqsave(&domain->lock, flags);
>  	list_add(&info->link, &domain->devices);
> @@ -2137,15 +2131,21 @@ static int dmar_domain_attach_device(struct dmar_domain *domain,
>  	else
>  		ret = intel_pasid_setup_second_level(iommu, domain, dev, IOMMU_NO_PASID);
>  
> -	if (ret) {
> -		device_block_translation(dev);
> -		return ret;
> -	}
> +	if (ret)
> +		goto out_block_translation;
>  
>  	if (sm_supported(info->iommu) || !domain_type_is_si(info->domain))
>  		iommu_enable_pci_caps(info);
>  
> +	ret = cache_tag_assign_domain(domain, dev, IOMMU_NO_PASID);
> +	if (ret)
> +		goto out_block_translation;
> +
>  	return 0;
> +
> +out_block_translation:
> +	device_block_translation(dev);
> +	return ret;
>  }
>  
>  /**
> -- 
> 2.34.1
> 

Even though this has already been applied, its good to know that it
works :)

Tested-by: Joel Granados <j.granados@samsung.com>

-- 

Joel Granados
