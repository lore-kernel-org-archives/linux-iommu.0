Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BEF1183066
	for <iommu@lists.linux.dev>; Wed, 26 Jun 2024 13:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719409394; cv=none; b=n7kD48gDsHOit561VEks0NNXKbRTLMxoH+zAwtznUqmqb5KE20ALwVnECyDayDCdFXmsmKBORRQfkOpzQn1N1rBlysTg7pLyPZZPs/np8/OhRatH6GRMYrnobHVjw2OGqKQRpR56jpmB0fd15bNDeCD/biBFnptzEUFftI4Q6ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719409394; c=relaxed/simple;
	bh=0xeMt1QS8pxWIRl0DKfsdNz0h5THwnRPo+wjOwGflxY=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=jyqev2QJXnnlERUeTM9YBgGCRwOCJwQnF52Wdi2sfxNpaRkR7ceoGCrC/fokVAbGnOnQCohceeHHHq99SXZ5PeXgWqitzYxV6cTkrUJxAn1S59PoT5kBTJ+1orL8GwASRG0NAlitQpLZ/ta8z/6uT6wE6oh1Z7bUGTEGZrkaI3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Q1qRqmvJ; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Q1qRqmvJ"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240626134308euoutp015c18dbb53d36b2646efff4964090d278~ckbqkXmAZ0485204852euoutp01R
	for <iommu@lists.linux.dev>; Wed, 26 Jun 2024 13:43:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240626134308euoutp015c18dbb53d36b2646efff4964090d278~ckbqkXmAZ0485204852euoutp01R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1719409388;
	bh=/yUABgL+x+gdFXA755hwqvKNyM2Jmx1pG2JW3TQlbMI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=Q1qRqmvJnivbtO6wQ273TV1p/2Ol36gaVd9qGMfwZbhj56879vHlv0lnXYXb4gxG3
	 AzvezftdljaN/Q3769eTiQI3lrJq+2er64g35OvIne9TBk/3Hpn8o7XwIgwLg0zCrC
	 fQ40fHA64y4DOfxLM7/OahFBYo3Yrvm6bkqfh9tk=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240626134308eucas1p2ff99c2f6ded1ab18af290c158ebe6f46~ckbqbrgzS1568615686eucas1p2U;
	Wed, 26 Jun 2024 13:43:08 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 7F.B0.09875.CEA1C766; Wed, 26
	Jun 2024 14:43:08 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240626134308eucas1p1b9e36aeac3aac63006be3d26734582ec~ckbqFiGXH2850528505eucas1p1Y;
	Wed, 26 Jun 2024 13:43:08 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240626134308eusmtrp13be4bc287570c5c93bb182ee0afa87f2~ckbqFIN_R2095720957eusmtrp1k;
	Wed, 26 Jun 2024 13:43:08 +0000 (GMT)
X-AuditID: cbfec7f4-131ff70000002693-7a-667c1aec0050
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id C5.10.09010.BEA1C766; Wed, 26
	Jun 2024 14:43:07 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240626134307eusmtip1027f7fd4c6cb87876b50c984a9ca6fe2~ckbpwrkXx0546105461eusmtip1O;
	Wed, 26 Jun 2024 13:43:07 +0000 (GMT)
Received: from localhost (106.110.32.44) by CAMSVWEXC01.scsc.local
	(2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Wed, 26 Jun 2024 14:43:06 +0100
Date: Wed, 26 Jun 2024 15:43:01 +0200
From: Joel Granados <j.granados@samsung.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
CC: David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iommu/intel: Enable pci capabilities before assigning
 cache tags
Message-ID: <20240626134301.y3es4r4go5736mi6@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <33c93a17-b888-47a8-be54-8fb0f7fee0ec@linux.intel.com>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBKsWRmVeSWpSXmKPExsWy7djPc7pvpGrSDN4dFLXYPHErm8XElZOZ
	LX59sbDonL2B3eLyrjlsFgc/PGG1aLlj6sDu8eTgPCaPNfPWMHpsXqHlsWlVJ5vHvJOBHi82
	z2T0+LxJLoA9issmJTUnsyy1SN8ugSvj1cf37AVnuCsWdLk2MG7k7GLk5JAQMJH4fPMtaxcj
	F4eQwApGiZNbFjNCOF8YJaYv+sUC4XxmlLh/uYkVpmXS0XNQieWMEht+/2eCqzr6ZQbUsM2M
	Ep1z28FaWARUJb686WIEsdkEdCTOv7nDDGKLCKhLNDXuZQNpYBY4xSjxv28NG0hCWCBc4t6T
	3ewgNq+Ag8TV78uhbEGJkzOfsIDYzECDFuz+BFTPAWRLSyz/xwES5hRwlti/8QDUqYoSXxff
	Y4GwayXWHjvDDmG/4ZDY9TAUwnaRuPX1CFSNsMSr41ugamQkTk/uAXtTQmAyo8T+fx/YIZzV
	jBLLGr8yQVRZS7RcecIOcoSEgKPEhbO6ECafxI23ghBn8klM2jadGSLMK9HRJgTRqCax+t4b
	lgmMyrOQPDYLyWOzEB5bwMi8ilE8tbQ4Nz212CgvtVyvODG3uDQvXS85P3cTIzDxnP53/MsO
	xuWvPuodYmTiYDzEKMHBrCTCG1pSlSbEm5JYWZValB9fVJqTWnyIUZqDRUmcVzVFPlVIID2x
	JDU7NbUgtQgmy8TBKdXAlJBcd54hYvXWLAtev56mU/2tjD/McgyuRr7Q2G7bnHfQ6oj179nT
	f525arVC582Okv9l6zhEPi97lD7Z5cP3FTsqFhXrxrZUqzsrqBYYLszduWf1y+0rMsRVl61/
	Kth/dPLaU1LCQtMeKfSFxZb6nXL8+dV7zUK1/iubF7xQWTDr6+qEO4wnLPmTLLnSrhx7Gz71
	WFJLvRc/y5RZAmZ7IkW/TpRjNnm27/K1zhNllw1+BHy6YK+qrxRrsKxsdv3nU14SykpmwpF5
	7l/Z7A7lXdUo+pJcnD6793R+xl/1V3/esiksL1W4XfvZe9+PvwIfcwLe1p5/3L89ZJOFldu/
	toj9WzRZs+0aLX3EF176osRSnJFoqMVcVJwIAF5XOKGrAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGIsWRmVeSWpSXmKPExsVy+t/xu7qvpWrSDD6us7TYPHErm8XElZOZ
	LX59sbDonL2B3eLyrjlsFgc/PGG1aLlj6sDu8eTgPCaPNfPWMHpsXqHlsWlVJ5vHvJOBHi82
	z2T0+LxJLoA9Ss+mKL+0JFUhI7+4xFYp2tDCSM/Q0kLPyMRSz9DYPNbKyFRJ384mJTUnsyy1
	SN8uQS/j1cf37AVnuCsWdLk2MG7k7GLk5JAQMJGYdPQcSxcjF4eQwFJGidZTG9kgEjISG79c
	ZYWwhSX+XOtigyj6yChx/f1cZghnM6PE0QNnGEGqWARUJb686QKz2QR0JM6/ucMMYosIqEs0
	Ne4F62YWOMUo8b9vDdgKYYFwiXtPdrOD2LwCDhJXvy9nh5h6nVHi+IfVbBAJQYmTM5+wgNjM
	QFMX7P4EFOcAsqUllv/jAAlzCjhL7N94AOpURYmvi++xQNi1Eq/u72acwCg8C8mkWUgmzUKY
	tICReRWjSGppcW56brGRXnFibnFpXrpecn7uJkZgBG479nPLDsaVrz7qHWJk4mA8xCjBwawk
	whtaUpUmxJuSWFmVWpQfX1Sak1p8iNEUGBYTmaVEk/OBKSCvJN7QzMDU0MTM0sDU0sxYSZzX
	s6AjUUggPbEkNTs1tSC1CKaPiYNTqoGp0jjOJ0jCK26a0ZW6Mycme3qGb/bgaDlxYK+QVsa2
	V7e11Fozi3s+lMd4fgx5vuC3zVr5jQEO7xZLrtv7h+1WkcyLq0+cJdr8tVd3rZ943aWwfOvT
	+oV2LDeWv7z29rtl+Ru1hcUFLdHZT1cvFS69OEd6qoTEEs5Nd9tnWIjds160V5Br4sQmp8W6
	dcVJfOmbcydMusfau+uv/IZ31WZBM9nn/FBuulb9eDXnJ4MUzdcLDvlO/7KuriWgzvBSsG1W
	3voM2a6937/seyk+1bw611LpzbTgGdJBm8oS7T++YaoXZTYv/3XshvAJ39mRCcbN1r3Z+vee
	PLV4WS/CKr3gmfgLkbVV/ptd5ePXvpmkxFKckWioxVxUnAgAXzNkbkkDAAA=
X-CMS-MailID: 20240626134308eucas1p1b9e36aeac3aac63006be3d26734582ec
X-Msg-Generator: CA
X-RootMTR: 20240626011143eucas1p11de7bd84765b20cf746a3146d75a04c8
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240626011143eucas1p11de7bd84765b20cf746a3146d75a04c8
References: <20240625-jag-ats_cache_tag_fix-v1-1-67f956e3fa93@samsung.com>
	<CGME20240626011143eucas1p11de7bd84765b20cf746a3146d75a04c8@eucas1p1.samsung.com>
	<33c93a17-b888-47a8-be54-8fb0f7fee0ec@linux.intel.com>

On Wed, Jun 26, 2024 at 09:09:04AM +0800, Baolu Lu wrote:
> On 6/25/24 9:49 PM, Joel Granados via B4 Relay wrote:
> > From: Joel Granados<j.granados@samsung.com>
> > 
> > Enable the pci capabilities by calling iommu_enable_pci_caps before we
> > assign a cache tag. The cache_tag_assign_domain call in
> > dmar_domain_attach_device uses the device_domain_info->ats_enabled
> > element to decide on the cache_tag_type value. Therefore ats_enabled
> > needs to be evaluated before the call to the tag cache assignment.
> > 
> > Signed-off-by: Joel Granados<j.granados@samsung.com>
> > ---
> > The "what" and "why" are included in the commit message.
> > 
> > Tried to place cache_tag_assign_domain before the early return in
> > "if(dev_is_real_dma_subdevice(dev))". This means that the call to
> > iommu_enable_pci_caps landed before the setup functions [1] which is not
> > an issue as they seem to be orthogonal (I would like to be proven wrong
> > here).
> > 
> > An alternative to this patch would be to use a different way of checking
> > if the device is ATS enabled in __cache_tag_assign_domain.
> > 
> > Comments greatly appreciated
> 
> Thank you very much for the patch. But we already have a similar patch
> which has been picked by Joerg for 6.10-rc.
> 
> https://lore.kernel.org/linux-iommu/20240620062940.201786-1-baolu.lu@linux.intel.com/
Completely missed this. I'll give it a try tomorrow and report back.

Best

-- 

Joel Granados
