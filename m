Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C4B1BD4F9
	for <iommu@lists.linux.dev>; Fri, 13 Sep 2024 08:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726214539; cv=none; b=Rx1d2vaFt9BCDysk1sI59mON/hHQB9V2h6S0V2x7SlnXxsRh0DHWZl2ZL6fGLNpuGnT1z8JdTGAt4CYE75utzM0L1bNWU73c8x7FFpcVeXZ9zJR3cecYodVk2QXtPOlS0NqqGSkGJWHwICNMK7h5M+MkppCNfJA0/SOxaPPacI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726214539; c=relaxed/simple;
	bh=GLAwdBVmQBM3uMerZKEaJAKisf0sMNblah/YnB60sqw=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=nLMib9c/Gn2rKgt1jzT6j2bNF9/2be83xUEC/Dqb2SOK2dNHQ9PviKaD9huK1nbL9BEY5niRHHvpvfCMkjF5IG7aLwo6fBW+pC9b959ESU1OsjGffGEGqinbvjqZjYXkLRPzJtmriCVeJRLI2ZrU5gRmfcPRuLJPk3ym9m3kwzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=YItY9byr; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="YItY9byr"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240913080214euoutp02eaef79de64fb0f80bc09939c23987c38~0vvkULhIY1860418604euoutp02R
	for <iommu@lists.linux.dev>; Fri, 13 Sep 2024 08:02:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240913080214euoutp02eaef79de64fb0f80bc09939c23987c38~0vvkULhIY1860418604euoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1726214534;
	bh=wqIKLmipUzFEumj/aGaOE3PtlZoHysJtCW/soSc1VS8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=YItY9byrKpMcF8iFUkMNVGgqZ0J0mmJHDHx+Mhw4117qHL096bhQ/dd1VoUYE0sjF
	 EYHtw/zYkbDshhPSXL7R1zFZKCX7C+a3oI8PEgeHFYhSUWUx0POdoduaGarhQjcYCc
	 IZTXH+CFDk9O2di1v9MdUQdPq1DN4ynMV7gSu7po=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240913080213eucas1p288639b80944329559046c3f25f51ab8b~0vvkAF80K2938329383eucas1p2Q;
	Fri, 13 Sep 2024 08:02:13 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id AC.75.09624.581F3E66; Fri, 13
	Sep 2024 09:02:13 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240913080213eucas1p297c283929ad0cbd0a1718ba86e3ba0a9~0vvjeoJZ_0773807738eucas1p2L;
	Fri, 13 Sep 2024 08:02:13 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240913080213eusmtrp295538d8696a226ff6b8b67f7a41a0cf1~0vvjdrSa43231132311eusmtrp2Q;
	Fri, 13 Sep 2024 08:02:13 +0000 (GMT)
X-AuditID: cbfec7f2-bfbff70000002598-15-66e3f185dfc4
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 93.82.19096.581F3E66; Fri, 13
	Sep 2024 09:02:13 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240913080212eusmtip22e6eb2b86bd3b4e7c72f80fc28e30434~0vvjHaXv_1052710527eusmtip2l;
	Fri, 13 Sep 2024 08:02:12 +0000 (GMT)
Received: from localhost (106.110.32.44) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Fri, 13 Sep 2024 09:02:11 +0100
Date: Fri, 13 Sep 2024 10:02:08 +0200
From: Joel Granados <j.granados@samsung.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
CC: David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Jason
	Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, Klaus Jensen
	<its@irrelevant.dk>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
Subject: Re: [PATCH 5/6] iommu: init pasid array while doing domain_replace
 and iopf is active
Message-ID: <20240913080208.t4tbqskmuyaozhyw@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <71f61d8a-9188-4e67-88ca-e5b48a91e6b5@linux.intel.com>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOKsWRmVeSWpSXmKPExsWy7djPc7qtHx+nGWz4qG2xeeJWNouJKycz
	W/z6YmGx/+A3VouZM04wWnTO3sBusfTtVnaLy7vmsFkc/PCE1aLljqkDl8eTg/OYPNbMW8Po
	sXmFlsfiPS+ZPM7tOM/usWlVJ5vHvJOBHi82z2T0+LxJzmPr59ssAVxRXDYpqTmZZalF+nYJ
	XBl3utoYC9bwVHT1zGNuYHzH2cXIySEhYCLxbvErxi5GLg4hgRWMEpNevmCGcL4wStzc1McO
	UiUk8JlRome6N0zH2v/7oOLLGSX6NhpDNADVtM+4zQrhbGaUWDFvDytIFYuAqsTbuxOYQGw2
	AR2J82/uMIPYIgLqEk2Ne9lAGpgFNjJJzP13GCwhLJAgMfPvGbAGXgEHiam9MxkhbEGJkzOf
	sIDYzECDFuz+BNTMAWRLSyz/xwES5hRwlvg/5w8rxKWKEl8X32OBsGslTm25xQSyS0JgNqdE
	16WrTBAJF4nmr8fYIGxhiVfHt7BD2DIS/3fOh2qYzCix/98HdghnNaPEssavUN3WEi1XnkB1
	OEr0fe5mArlIQoBP4sZbQYhD+SQmbZvODBHmlehoE4KoVpNYfe8NywRG5VlIXpuF5LVZCK8t
	YGRexSieWlqcm55abJiXWq5XnJhbXJqXrpecn7uJEZi2Tv87/mkH49xXH/UOMTJxMB5ilOBg
	VhLhncT2KE2INyWxsiq1KD++qDQntfgQozQHi5I4r2qKfKqQQHpiSWp2ampBahFMlomDU6qB
	qe5g75ENhX0stg7erdqHFFViL/xV6fB57KoxZf2BKXvj90U8nLb1bcek8l3+sk6VLOtcNxbm
	WB6eHnpJKr8+yzOlpbBF/CvrOr2Nwi90eaYt2DfRKO/6Q6mfl340fj3G/irryspvyzuiJgTt
	vF7x6sSf4I83wo5mhBiEagmGZh6aEP5nobPA06j04pM/J5nu/WHfH7ImddKJiMXTCxuV77Qt
	i7ffHz/l8zUx1zU7Pl9XT13L6sO56IXWaw0Rttg7Dt9WZycuY5niIeVrZRZsmeLwsYZDfZpU
	6a4T27dcv7hPriPZ5kh9VnfgjftbHr+wWiUj0HLfRNL5RH+bkVnMU6e9Sz7y3PAuC/Gr2Jld
	o8RSnJFoqMVcVJwIAIzWe9vKAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKIsWRmVeSWpSXmKPExsVy+t/xe7qtHx+nGaxdxGaxeeJWNouJKycz
	W/z6YmGx/+A3VouZM04wWnTO3sBusfTtVnaLy7vmsFkc/PCE1aLljqkDl8eTg/OYPNbMW8Po
	sXmFlsfiPS+ZPM7tOM/usWlVJ5vHvJOBHi82z2T0+LxJzmPr59ssAVxRejZF+aUlqQoZ+cUl
	tkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehl3utoYC9bwVHT1zGNuYHzH
	2cXIySEhYCKx9v8+9i5GLg4hgaWMEmsOLGaDSMhIbPxylRXCFpb4c62LDaLoI6NEy+rDUB2b
	GSUaVu1gAqliEVCVeHt3ApjNJqAjcf7NHWYQW0RAXaKpcS9YN7PARiaJG+eawIqEBRIkZv49
	A2bzCjhITO2dyQgx9RGzxN+ut2wQCUGJkzOfsIDYzEBTF+z+BBTnALKlJZb/4wAJcwo4S/yf
	8wfqVEWJr4vvsUDYtRKf/z5jnMAoPAvJpFlIJs1CmLSAkXkVo0hqaXFuem6xkV5xYm5xaV66
	XnJ+7iZGYPxuO/Zzyw7Gla8+6h1iZOJgPMQowcGsJMI7ie1RmhBvSmJlVWpRfnxRaU5q8SFG
	U2BYTGSWEk3OByaQvJJ4QzMDU0MTM0sDU0szYyVxXrYr59OEBNITS1KzU1MLUotg+pg4OKUa
	mOw/vwq85JrqYj3xuEpfSBxH2h+zJ/V+G27ttWnSmHjln2r+Elv+KW8jM2YlLJrmxmJ5uUx4
	2eU9H5QPHW5iPjuT+ZO84+tEFx0778jcuOv3L7GeF2c4Om/t4bPtMfcO1lh48v33snug/zTu
	zbxLDa0sDxjXJK3Tvbxtcyvz8p4cG/5/PueVlm88FtcbxdlxRdL76V1v/2/vG62+/HIKZ1B5
	+lDsxrw99RMWORk6MM2/U3FJY3HnvMnsdzt1grmieGri7zocmjGt8XX2Ve59OzsP6m6ZsuPM
	ngvR/7ldjqY1Ls1MvbLtk7NladKEn7durjw9ccqmvYbXHtWejfY/KC8sZrr0w4KNdWfdtCYH
	hN9QYinOSDTUYi4qTgQAvL6smmgDAAA=
X-CMS-MailID: 20240913080213eucas1p297c283929ad0cbd0a1718ba86e3ba0a9
X-Msg-Generator: CA
X-RootMTR: 20240905033408eucas1p2ad508d4f3377f4daa38f28bf6c3d1118
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240905033408eucas1p2ad508d4f3377f4daa38f28bf6c3d1118
References: <20240904-jag-iopfv8-v1-0-e3549920adf3@samsung.com>
	<20240904-jag-iopfv8-v1-5-e3549920adf3@samsung.com>
	<CGME20240905033408eucas1p2ad508d4f3377f4daa38f28bf6c3d1118@eucas1p2.samsung.com>
	<c2e765a8-d935-42db-bd22-c12e7960f2f0@linux.intel.com>
	<20240911105657.iesajd4d5va3wc5y@joelS2.panther.com>
	<b7a68539-3a3c-4cd9-922b-bfb9db8e7e0b@linux.intel.com>
	<20240912082512.ydzmmlwpvkcukbt2@joelS2.panther.com>
	<71f61d8a-9188-4e67-88ca-e5b48a91e6b5@linux.intel.com>

On Thu, Sep 12, 2024 at 07:22:30PM +0800, Baolu Lu wrote:
> On 2024/9/12 16:25, Joel Granados wrote:
> >   /**
> >    * iommu_attach_group_handle - Attach an IOMMU domain to an IOMMU group
> >    * @domain: IOMMU domain to attach
> > diff --git i/drivers/iommu/iommufd/fault.c w/drivers/iommu/iommufd/fault.c
> > index ea7f1bf64892..51cb70465b87 100644
> > --- i/drivers/iommu/iommufd/fault.c
> > +++ w/drivers/iommu/iommufd/fault.c
> > @@ -189,8 +189,15 @@ static int iommufd_init_pasid_array(struct iommu_domain *domain,
> >   	if (!handle)
> >   		return -ENOMEM;
> >   	handle->idev = idev;
> > +	handle->handle.domain = domain;
> > +
> > +	mutex_lock(&group->mutex);
> > +	ret = xa_insert(&group->pasid_array, IOMMU_NO_PASID, handle, GFP_KERNEL);
> > +	mutex_unlock(&group->mutex);
> > +
> > +	if (ret == -EBUSY)
> > +		ret = 0;
> >   
> > -	ret = iommu_init_pasid_array(domain, group, &handle->handle);
> >   	if (ret)
> >   		kfree(handle);
> 
> This is supposed to be done automatically when an iopf capable domain is
> attached to or replaced with a device. Please refer to
> iommufd_fault_domain_attach_dev() and
> iommufd_fault_domain_replace_dev().
> 
> Is there anything preventing this from happening?
Nope, You are correct. This does indeed happen through
iommufd_fault_domain_replace_dev
  -> __fault_domain_replace_dev
    -> iommu_replace_group_handle.

This was probably left from trying to do this outside the replace path.
Sorry for the noise; will remove it in V2.

Thx for the review

Best

-- 

Joel Granados
