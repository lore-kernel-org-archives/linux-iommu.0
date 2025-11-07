Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF542FFF9A;
	Fri,  7 Nov 2025 19:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762543002; cv=none; b=u9as9Q1EzN+RbP1LAD1102WxnMOv+AianGW/KumOIFS/RkULFI/wxJC8rG7Fpylu0PZXV3lmm/RNxJl6zLpBBH8FTPbe/AyJN8+txK6eXZOF36JWuDUSBG8jtBT699OAwTmQiER25DaByN8Aop/s55SWTgo3JSzTuJdpyHKcOoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762543002; c=relaxed/simple;
	bh=nEkZsft9zds0zKPme2K9MtcDeOBr2q3x/Eeje7et7iI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cahbRlr776BwKTEgf3dNL6Z4LelZMLeMXDkadWy8ixNO3AdMspfP4cmRPLTxQa5nGJpwr4vhnraehPzmH9s6ZK0RjRgdyxrmzJKhgH50C0+vQmQascitcOEL2NSDQd7z9kkz8OuamoedAONWtPp/hFCiM6IL0qt3pCOKPc2hYAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fyBMvXcr; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fyBMvXcr"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=kQk8qhNHeExoeKiNMISlHBwIfA7OPYgr0kEYR2Qaikw=; b=fyBMvXcrSAsSSxbhpRSB3zcRpi
	NWZHyN78xJVj9iBtAeTHGqsON3eELYVVxjSDIyZR+mNEns7qs6KMWeZDryL+etK+067AnYEWqfIDE
	8rJZySFnyUl5an0jK1BnEPytHg4CIiWwyNRDTUjsjgYfsrW5l9m4dYIryduRmeUTxzDtCSsV7UfSm
	oiwg6DWBldT32tFxIe3KfS3Ry9DAXV8AZU+bJ73JyiOfYutsKYIY2AANxZeEQX4lAa5V1msGIoifv
	GB9Fbcbr7rkwRJ5d3MMfOdI6tgEE1wa0520kmVP0ZY+pTT1qg2LMWhFXOMKth+J1qiDdtF5Hqw5vi
	sHlK0QPA==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHRwr-00000000g1k-3uy2;
	Fri, 07 Nov 2025 19:16:37 +0000
Message-ID: <49ff6f64-b664-4628-af2a-1b46e0fd62ad@infradead.org>
Date: Fri, 7 Nov 2025 11:16:36 -0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] genpt documentation fixes
To: Bagas Sanjaya <bagasdotme@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Documentation <linux-doc@vger.kernel.org>,
 Linux IOMMU <iommu@lists.linux.dev>
Cc: Jonathan Corbet <corbet@lwn.net>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
 Samiullah Khawaja <skhawaja@google.com>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 Lu Baolu <baolu.lu@linux.intel.com>
References: <20251107081300.13033-2-bagasdotme@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20251107081300.13033-2-bagasdotme@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/7/25 12:12 AM, Bagas Sanjaya wrote:
> Hi,
> 
> Here are fixes for two htmldocs warnings in generic radix page table
> documentation. The first one is reported in linux-next [1], and the
> second one is also found when making htmldocs locally to reproduce the
> former.
> 
> Enjoy!
> 
> Changes since v1 [2]:
> 
>   - s/to set/to read/ (Randy)

That's not quite what I said (wrote):

> @@ -354,6 +354,7 @@ static inline unsigned int pt_max_sw_bit(struct pt_common *common);
>  /**
>   * pt_test_sw_bit_acquire() - Read a software bit in an item
>   * @pts: Entry to set
> + * @bitnr: Bit to set

| Shouldn't both of these (above) to "to read" instead of "to set"?



No changes to pt_set_sw_bit_release() [which should say "to set" in 2 places].


> 
> [1]: https://lore.kernel.org/linux-next/20251106143925.578e411b@canb.auug.org.au/
> [2]: https://lore.kernel.org/linux-doc/20251106073845.36445-1-bagasdotme@gmail.com/
> 
> Bagas Sanjaya (2):
>   Documentation: genpt: Don't use code block marker before iommu_amdv1.c
>     include listing
>   iommupt: Describe @bitnr parameter
> 
>  Documentation/driver-api/generic_pt.rst | 2 +-
>  drivers/iommu/generic_pt/pt_common.h    | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> 
> base-commit: 75d9ef7cf1e694e5c0fb387be99f04acc7f864a4
-- 
~Randy

