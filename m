Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A64645014
	for <iommu@lists.linux.dev>; Thu, 29 Aug 2024 06:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724912273; cv=none; b=tvChX5kiigvZXCp50nmYFROxTflRjb+l7QKxU//TULUbTSKJON7zP/OH4yvsSm3LZoLQf/zOwudUKQjsw7sTGqGO4M2+j8skIWD3PoTuhMXEJIkBkLj/jRo+qF4jj+mqozk++z1OqFwjCeRW60dT3qvQfsW6G++QUDtJYSR1oCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724912273; c=relaxed/simple;
	bh=6RzSrv3nyFuhiKzG5BP3qCVTA/Grb69zizAwthqsJEs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GtFrHvaVpM0RizhpRS8D5yFXtgWO8WgMySrbZDdwnz/8Nhk5G0CvgZzxIafa9gT8hW/O2qWlHoD1FCxXcxx4n3bvTwqaMnVr3suIwlGyxXQQuMYi9lYdyP+ClOTiZDpduBYcjqbSp1D6AKHMZmPUSXYRAuzv7GPsqTqIwKaPBJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=L3Z4eUpr; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="L3Z4eUpr"
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47T6HV1q054780;
	Thu, 29 Aug 2024 01:17:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724912251;
	bh=fnhuBR25tOtm6jBNJ0bOgimcMKg7qyAIojAku3kruEc=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=L3Z4eUprXD7YUdSkcNFy8hxBfzjN8NrY3Q1WgAWllUfzCMM9638lihZyWduviwW77
	 046oaK3cPf3Cr1AKUQTK3sn/3+yzMC4i71mrXtbxeCnEm4WB+PRESR/NTWZKEfbOzX
	 sGROUxxO4C6Din3SBKlVCwiZ9ICqD8g8f9FWDuus=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47T6HVnO052987
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 29 Aug 2024 01:17:31 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 29
 Aug 2024 01:17:31 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 29 Aug 2024 01:17:31 -0500
Received: from [172.24.227.151] (uda0510294.dhcp.ti.com [172.24.227.151])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47T6HQa9007117;
	Thu, 29 Aug 2024 01:17:27 -0500
Message-ID: <99c874f1-3d85-43b2-a3a0-40e1e0c25696@ti.com>
Date: Thu, 29 Aug 2024 11:47:25 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] remoteproc: Use iommu_paging_domain_alloc()
To: Mathieu Poirier <mathieu.poirier@linaro.org>,
        Lu Baolu
	<baolu.lu@linux.intel.com>, <andersson@kernel.org>,
        <afd@ti.com>, <nm@ti.com>, <hnagalla@ti.com>
CC: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin
 Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Kevin Tian
	<kevin.tian@intel.com>, <linux-remoteproc@vger.kernel.org>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        Jason Gunthorpe
	<jgg@nvidia.com>
References: <20240812072811.9737-1-baolu.lu@linux.intel.com>
 <ZsdktJEqR9BOgivK@p14s>
Content-Language: en-US
From: Beleswar Prasad Padhi <b-padhi@ti.com>
In-Reply-To: <ZsdktJEqR9BOgivK@p14s>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi All,

On 22/08/24 21:47, Mathieu Poirier wrote:
> Hi Baolu,
>
> Sorry for the late reply, this slipped through the cracks.
>
> On Mon, Aug 12, 2024 at 03:28:11PM +0800, Lu Baolu wrote:
> > An iommu domain is allocated in rproc_enable_iommu() and is attached to
> > rproc->dev.parent in the same function.
> > 
> > Use iommu_paging_domain_alloc() to make it explicit.
> > 
> > Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> > Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> > Link: https://lore.kernel.org/r/20240610085555.88197-13-baolu.lu@linux.intel.com
> > ---
> >  drivers/remoteproc/remoteproc_core.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> > index f276956f2c5c..eb66f78ec8b7 100644
> > --- a/drivers/remoteproc/remoteproc_core.c
> > +++ b/drivers/remoteproc/remoteproc_core.c
> > @@ -109,10 +109,10 @@ static int rproc_enable_iommu(struct rproc *rproc)
> >  		return 0;
> >  	}
> >  
> > -	domain = iommu_domain_alloc(dev->bus);
> > -	if (!domain) {
> > +	domain = iommu_paging_domain_alloc(dev);
>
> I'm a little hesitant here.  Function iommu_domain_alloc() passes NULL two the
> second argument of __iommu_domain_alloc() while iommu_paging_domain_alloc()
> provides a 'dev'.  I don't have any HW to test on and I am not familiar enough
> with the IOMMU subsystem to confidently more forward.
>
> I am asking the Qualcomm (Bjorn and friends) and TI crew (Beleswar, Andrew,
> Nishanth and Hari) to test this patch on their IOMMU devices and get back to me
> with a "Tested-by".


Just a heads-up. Currently, I am seeing boot failures while booting 
remotecores in TI's IOMMU devices with mainline kernel. Working on the 
the fix, once it is done, will apply the above patch and test it ASAP.

Thanks,
Beleswar

>
> Thanks,
> Mathieu
>
> > +	if (IS_ERR(domain)) {
> >  		dev_err(dev, "can't alloc iommu domain\n");
> > -		return -ENOMEM;
> > +		return PTR_ERR(domain);
> >  	}
> >  
> >  	iommu_set_fault_handler(domain, rproc_iommu_fault, rproc);
> > -- 
> > 2.34.1
> > 
>
