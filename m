Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472FA19CC1E
	for <iommu@lists.linux.dev>; Thu, 12 Sep 2024 10:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726136544; cv=none; b=m+lZOL5+cr+J+m9eCaEJTJ4qJbHUfjyt2eDBPla5R14smJpT8Y1E32AV4Xnnx4u4QuA/vZdSnIDxRgkkuPDIG6P5blJdNmMC3IDlHF1lATLv1NKw++8KdvOZOOT1qzpPHG9OEhq7eHEUY6Q9zxtfeIz2of/6XR2JXvYtcsYVcUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726136544; c=relaxed/simple;
	bh=GqGNl2cvaxnSSGV3vv4hFetX6g9Rbsqk/j353xdYtt8=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=PNYM8bzRt2iGJZ0JjKRjSRdpaEFiWt+1w2W+CPIFPQoNrge/ODSQ1nSzpgu345KypRGRrrCFKW1BwEVYqHJXP3vJKTHE7pI1efCmuxYyiG7btAacb5mv/EehVSXeSohjdSwILAiOmfBmoOYzaeB1jTyIHX3FVAZcOGGX/tjpclU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=XX6T7/4Y; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="XX6T7/4Y"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240912102220euoutp01c4f042bca969610d2db4af477126a17d~0eAm6ZoWM0910209102euoutp01C
	for <iommu@lists.linux.dev>; Thu, 12 Sep 2024 10:22:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240912102220euoutp01c4f042bca969610d2db4af477126a17d~0eAm6ZoWM0910209102euoutp01C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1726136540;
	bh=Upb81ayzgBYd/XD/Nl0eMEAkU3/9VteA/VsZ8XSOugo=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=XX6T7/4YbyhxqPNDGv/IOPI7AvXFBlJt76/PrzMJktfcbP1kSqSDkQXx822DaacgN
	 0CvYpV/e8qN3KYhGEW9frh/BZAfGHvQs1XVrSeVafe9tOiwc+NB+VZYTD1hRDC8asj
	 7sRGAGHzds3lNbUw6ifnM4Fkq86qGzHCdbalJksY=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240912102220eucas1p2131b3412b6d9c827b5a64a695cba6ee8~0eAmnj8ZZ1878718787eucas1p24;
	Thu, 12 Sep 2024 10:22:20 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 7F.06.09875.BD0C2E66; Thu, 12
	Sep 2024 11:22:19 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240912102219eucas1p2b310a28fa8aaf4f953ca61b344ced642~0eAl-Ecip2081820818eucas1p27;
	Thu, 12 Sep 2024 10:22:19 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240912102219eusmtrp2b21701c32f27f908523475b9ddb80d27~0eAl_YpEP2158521585eusmtrp2k;
	Thu, 12 Sep 2024 10:22:19 +0000 (GMT)
X-AuditID: cbfec7f4-131ff70000002693-4a-66e2c0dbe1b8
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 1B.1D.19096.BD0C2E66; Thu, 12
	Sep 2024 11:22:19 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240912102219eusmtip15415699d16f9c4397a38c0b5cbe796f8~0eAls4HJ11997919979eusmtip1t;
	Thu, 12 Sep 2024 10:22:19 +0000 (GMT)
Received: from localhost (106.110.32.44) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Thu, 12 Sep 2024 11:22:18 +0100
Date: Thu, 12 Sep 2024 12:22:14 +0200
From: Joel Granados <j.granados@samsung.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
CC: David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Jason
	Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, Klaus Jensen
	<its@irrelevant.dk>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
Subject: Re: [PATCH 5/6] iommu: init pasid array while doing domain_replace
 and iopf is active
Message-ID: <20240912102214.gvgj5jmuzbcpr7aa@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f4ea2a66-49ac-41ae-94c4-2832f08303f1@linux.intel.com>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se1BMcRTH53fv3bu3Hbtz25jOhCjvkJhwqUlN/rjjD48RBjO06pbYit0S
	ZsxUnptHWozaVRqVjR7S9rArZaMQbWaUUB6T/SMpYtcrWbruevz3+Z5zvucxcyhcXivyouIS
	kjhVgkLpS0qImuZv1tldN3tiAvabGMaYVU0yWZdO4cyQg2EaLJ9FTE72XcRo9BVipmigWsw8
	Mp8jGcugTcQc6J4fKmFtljyMLc0rRayx2I8tqHuDsdZrbWK28rKGZPPurWJ7jTmItVd6s9X2
	LmKlZIMkOJpTxu3iVHNCIiVbM2s/iHbUSHcbNb14KuqRZCA3CuhAePx9gMxAEkpOFyN43/PK
	JRwI2k3dSBB2BGf6zOiP5c27IjHPctqAoLZ51N+iuvznuCCMCGxZTSMOiiLoKaAzTOcNJD0L
	2vq7cZ5H09MgPe3G73E4fRWDXOet3wkPOhJyfjzAeJbSoWCtMbrYHe7l2Aie8ZFG+dc/knx/
	nB4LBifFh93ocMg1V2PCoj7wqeAFIfA+aKl6hvGzgNa7QYX+oyuxFIpLD5MCe0DfnSqxwOPg
	p+m8y3AKQYNzUCyIEgQX0z65RgTBgXabyxEGJ+xHMX4joGXwZMBdWFQG2pqzuBCWwpFDcqF6
	KpS86CdOokm6/07T/Xea7t9p+Qi/jDy5ZHV8LKeel8Cl+KsV8erkhFj/qMT4SjTyW/eddxzX
	kKHvg38jwijUiIDCfUdLtWRPjFwardizl1MlblYlKzl1IxpLEb6e0inREzg5HatI4rZz3A5O
	9SeLUW5eqdj8otTkJiYs0ZxeFhsQHIa5010lxzZFDO1+Ln/1sDVEFhgzfjy5B+paqyxmZXug
	2j68rXmmZ8z3C+ULJj5qe6DStGSUn3y7WVth6tRPlRJXS16X9XsPyi6FFL51ar0ybw92rI26
	TUwovLnx9IKdfpm95aufSr4GFCrxixO/Le94lzKkihq2BIsSrx+MS3mtu5XE9O6SrdKEz6lH
	revk1sl36+cGvbyhrTykJYoGOuuvlDWInM3iiDHenDU0K2p4y+qOFcziyLTs4zPWhFJei5YY
	tjg61z3be3xFsL4lvaouzSNwWUAS6WNSfF44RIzyWB8073D4kYM+ubWLHcSVJvgyyZdQb1XM
	9cNVasUvQYcDW8oDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEIsWRmVeSWpSXmKPExsVy+t/xu7q3DzxKM/i0i8di88StbBYTV05m
	tvj1xcJi/8FvrBYzZ5xgtOicvYHdYunbrewWl3fNYbM4+OEJq0XLHVMHLo8nB+cxeayZt4bR
	Y/MKLY/Fe14yeZzbcZ7dY9OqTjaPeScDPV5snsno8XmTnMfWz7dZArii9GyK8ktLUhUy8otL
	bJWiDS2M9AwtLfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DL6t39kLdjGW7G58wVzA+Mj
	ri5GTg4JAROJl++WsoPYQgJLGSVar8hDxGUkNn65ygphC0v8udbFBlHzkVHiVw9fFyMXkL2Z
	UWLR3b1ACQ4OFgFViVnLNUBq2AR0JM6/ucMMYosIqEs0NYKUcHEwC2xkkrhxrokJJCEskCAx
	8+8ZMJtXwEHi3LbNTBBDPzFJTH53FCohKHFy5hMWEJsZaOqC3Z/AljELSEss/8cBEuYUcJaY
	u2srE8ShihJfF99jgbBrJT7/fcY4gVF4FpJJs5BMmoUwaQEj8ypGkdTS4tz03GIjveLE3OLS
	vHS95PzcTYzAyN127OeWHYwrX33UO8TIxMF4iFGCg1lJhHcS26M0Id6UxMqq1KL8+KLSnNTi
	Q4ymwKCYyCwlmpwPTB15JfGGZgamhiZmlgamlmbGSuK8bFfOpwkJpCeWpGanphakFsH0MXFw
	SjUwTfwnZPr8caRu8rwvaps8rx9ePb+V9dT2fIXdSUXhUz22Cuvev3h7w+OljwLSptuzCct6
	ed/xDU2PYTg6PVH73h3Gcs/Zcz8+sZcQ+lIasyrzxKvl1X8XTzmQ57Y3Pcehe/3lYwp6W9pn
	/703zT7TzL3yt6l3fXKig4S9u9J18f6fFubPpi4+2Fr9/6TTyeWPPqXPX9eySOiWXs8zic6H
	Lm8jJocmWKQrp27jyCwIzqzYLfj+TvK8U8E///VuWJa/yN6j6FUvd8qiqElPT5nZfjm4XIV3
	Tk1uedTeDX8yFj43aDkfXiXFFFsTETUpI/jmWqOviU+DfvpLnXdVcdguP5F3JyvTTtMDuxgP
	bnPZo8RSnJFoqMVcVJwIAAF3sL5lAwAA
X-CMS-MailID: 20240912102219eucas1p2b310a28fa8aaf4f953ca61b344ced642
X-Msg-Generator: CA
X-RootMTR: 20240905033408eucas1p2ad508d4f3377f4daa38f28bf6c3d1118
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240905033408eucas1p2ad508d4f3377f4daa38f28bf6c3d1118
References: <20240904-jag-iopfv8-v1-0-e3549920adf3@samsung.com>
	<20240904-jag-iopfv8-v1-5-e3549920adf3@samsung.com>
	<CGME20240905033408eucas1p2ad508d4f3377f4daa38f28bf6c3d1118@eucas1p2.samsung.com>
	<c2e765a8-d935-42db-bd22-c12e7960f2f0@linux.intel.com>
	<20240911095544.4ad3u6jxgsdsymhj@joelS2.panther.com>
	<f4ea2a66-49ac-41ae-94c4-2832f08303f1@linux.intel.com>

On Thu, Sep 12, 2024 at 12:17:35PM +0800, Baolu Lu wrote:
> On 9/11/24 5:55 PM, Joel Granados wrote:
> > On Thu, Sep 05, 2024 at 11:30:05AM +0800, Baolu Lu wrote:
> >> On 9/4/24 9:17 PM, Joel Granados via B4 Relay wrote:
> >>> From: Joel Granados<j.granados@samsung.com>
> >>>
> >>> iommu_report_device_fault expects a pasid array to have an
> >>> iommu_attach_handle when a fault is detected.
> >> The iommu_attach_handle is expected only when an iopf-capable domain is
> >> attached to the device or PASID. The iommu_report_device_fault() treats
> >> it as a fault when a fault occurs, but no iopf-capable domain is
> >> attached.
> > I don't follow. The way that I read it: if the pasid_array x-array does
> > not have an iommu_attach_handle indexed by either fault->prm.pasid or
> > IOMMU_NO_PASID, it will follow the err_bad_iopf and return -EINVAL
> > (please correct me if I'm wrong). So the iommu_attach_handle is*always*
> > expected.
> > 
> > Would it be more clear for it to be:
> > """
> > The iommu_report_device_fault function expects the pasid_array x-array
> > to have an iommu_attach_handle indexed by a PASID. Add one indexed with
> > IOMMU_NO_PASID when the replacing HWPT has a valid iommufd fault object.
> > Remove it when we release ownership of the group.
> 
> Can you please explain why iommu core needs to remove the attach handle
> when the ownership of the group is changed?

It does not. Probably left from a previous version of the patch. Sorry
for the noise. I have reamoved the xa_erase from
__iommu_release_dma_ownership. Will send a V2 once we finish discussing
the rest of your comments.

Best and thankyou for your feedback

-- 

Joel Granados
