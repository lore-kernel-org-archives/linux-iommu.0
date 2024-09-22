Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55D861FCF
	for <iommu@lists.linux.dev>; Sun, 22 Sep 2024 11:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727004460; cv=none; b=rJm20DWUEuhctK+RVXPArHFQT9wd7D/iV81uLP37GUh/We+NnMUH2d18Fxzgg4OSTJHxqAjdkENmPzEZC4TG6YqkzlAbeC5QgPQUvZO7AuwgOFI0d56fFEWha/0j1dMZxVIl25Hp0uIpmvtiWUypZnTdAxfQqEULASKmvc36uXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727004460; c=relaxed/simple;
	bh=Ubr4xKaup2BgtEQmSwvzn5S3OcK/SRHS8d9QmBMPRyo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=dErhqqprQo+ubkf6TOwiNs6ulcuNGGI9ZZAwhKBP6cnjuTt+yshjpWK4a/DTCb0Wo0Q/8jY02ul8z83Qj3ILj3ZZCBPh+vYVTZSrQqHylaXqryNkxgl2i4eBzmtmNsCVGlDAYSFwfzqbrLfsIWPXwGrASTeGuZZ4/EP4swe8lhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=jB74Jf8M; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jB74Jf8M"
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 48MBRFGa103698;
	Sun, 22 Sep 2024 06:27:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1727004435;
	bh=XnxBUT2Dw6S9B2FDDYplj2ilPkQZxh4zWUn9GXdLhak=;
	h=Date:Subject:From:To:CC:References:In-Reply-To;
	b=jB74Jf8MwZLGqfp7x/iKwk5hLDDyZBFVTGWWBYgYfMr095Y9tZbYUDOh2jqrexcHf
	 eTgnpxQY+TwTGX6BAwCvFbq6s9QwC58YGBwUtxXnjJPYmoJQtkbUT7mmT5T+u2b5Hp
	 7GNUZptp0pnK5wz6AvwA2KhsUTSE9FTiDQnZsPiQ=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 48MBRFLX015637
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 22 Sep 2024 06:27:15 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 22
 Sep 2024 06:27:15 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 22 Sep 2024 06:27:15 -0500
Received: from [10.249.130.82] ([10.249.130.82])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48MBR8F3009533;
	Sun, 22 Sep 2024 06:27:09 -0500
Message-ID: <0dbde87b-593f-4b14-8929-b78e189549ad@ti.com>
Date: Sun, 22 Sep 2024 16:57:07 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] remoteproc: Use iommu_paging_domain_alloc()
From: Beleswar Prasad Padhi <b-padhi@ti.com>
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
 <ZsdktJEqR9BOgivK@p14s> <99c874f1-3d85-43b2-a3a0-40e1e0c25696@ti.com>
Content-Language: en-US
In-Reply-To: <99c874f1-3d85-43b2-a3a0-40e1e0c25696@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea


On 29-08-2024 11:47, Beleswar Prasad Padhi wrote:
> Hi All,
>
> On 22/08/24 21:47, Mathieu Poirier wrote:
>> Hi Baolu,
>>
>> Sorry for the late reply, this slipped through the cracks.
>>
>> On Mon, Aug 12, 2024 at 03:28:11PM +0800, Lu Baolu wrote:
>> > An iommu domain is allocated in rproc_enable_iommu() and is 
>> attached to
>> > rproc->dev.parent in the same function.
>> > > Use iommu_paging_domain_alloc() to make it explicit.
>> > > Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> > Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
>> > Link: 
>> https://lore.kernel.org/r/20240610085555.88197-13-baolu.lu@linux.intel.com
>> > ---
>> >  drivers/remoteproc/remoteproc_core.c | 6 +++---
>> >  1 file changed, 3 insertions(+), 3 deletions(-)
>> > > diff --git a/drivers/remoteproc/remoteproc_core.c 
>> b/drivers/remoteproc/remoteproc_core.c
>> > index f276956f2c5c..eb66f78ec8b7 100644
>> > --- a/drivers/remoteproc/remoteproc_core.c
>> > +++ b/drivers/remoteproc/remoteproc_core.c
>> > @@ -109,10 +109,10 @@ static int rproc_enable_iommu(struct rproc 
>> *rproc)
>> >          return 0;
>> >      }
>> >  > -    domain = iommu_domain_alloc(dev->bus);
>> > -    if (!domain) {
>> > +    domain = iommu_paging_domain_alloc(dev);
>>
>> I'm a little hesitant here.  Function iommu_domain_alloc() passes 
>> NULL two the
>> second argument of __iommu_domain_alloc() while 
>> iommu_paging_domain_alloc()
>> provides a 'dev'.  I don't have any HW to test on and I am not 
>> familiar enough
>> with the IOMMU subsystem to confidently more forward.
>>
>> I am asking the Qualcomm (Bjorn and friends) and TI crew (Beleswar, 
>> Andrew,
>> Nishanth and Hari) to test this patch on their IOMMU devices and get 
>> back to me
>> with a "Tested-by".
>
>
> Just a heads-up. Currently, I am seeing boot failures while booting 
> remotecores in TI's IOMMU devices with mainline kernel. Working on the 
> the fix, once it is done, will apply the above patch and test it ASAP.


Since commit 17de3f5fdd35, the IOMMU framework has changed how it 
handles callback ops, moving away from using bus->iommu_ops. The 
omap-iommu driver has not yet been updated to align with these framework 
changes. Therefore, omap-iommu, and hence, omap-remoteproc have been 
broken since 17de3f5fdd35.

This patch is a step in the right direction for adapting the 
remoteproc_core framework to the newer IOMMU framework by looking for 
iommu_ops attached to the dev structure instead of dev->bus. Due to time 
constraints, I was unable to update the omap-iommu driver to accommodate 
these changes, so, I could not test this patch. However, logically, this 
patch LGTM. So,

Acked-by: Beleswar Padhi <b-padhi@ti.com>

Thanks,
Beleswar

>
> Thanks,
> Beleswar
>
>>
>> Thanks,
>> Mathieu
>>
>> > +    if (IS_ERR(domain)) {
>> >          dev_err(dev, "can't alloc iommu domain\n");
>> > -        return -ENOMEM;
>> > +        return PTR_ERR(domain);
>> >      }
>> >  >      iommu_set_fault_handler(domain, rproc_iommu_fault, rproc);
>> > -- > 2.34.1
>> >
