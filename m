Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6215515665E
	for <iommu@lists.linux.dev>; Wed, 11 Sep 2024 08:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726044142; cv=none; b=O+iujYt8+MjwcngcdP2W0gSkqB7rusto2RGMQEFTivxZbLrLkGCCb7c10ib2d5CN8SfGeaYGE/aliFSRW48+N4aSimSPeUMLmArj60Bj4d97aaRcRW3bmgVlPzu7xYoQuplgPnXkf6Q7R80a4C86Hkz9QhxH+KkaBGQwJzA7jys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726044142; c=relaxed/simple;
	bh=lWcvgcpXFfD0LiIyh8fiFShe2yixbkA4oXcwss+L+/E=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=b34Np7AIRrqJfkYzYXy3ZkA8yyHoYN5RcadKN9RKIghj6lFfrprkJXc4Zq1Z3lVfUVRKtluoFKve1nHmbpClFXLx8duE+BeN0ne9OnGbVZE3G5ub8vn9kRW/2XWiXzIrlmHLLtgChBi6KyXEb9UmCqPMa2qQ4kTdQgJGZIfSG/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=S/iNXc68; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="S/iNXc68"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240911084212euoutp01eff4ccac253ec8edf0966f88da5fdc08~0I-5w9XyS0190601906euoutp01J
	for <iommu@lists.linux.dev>; Wed, 11 Sep 2024 08:42:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240911084212euoutp01eff4ccac253ec8edf0966f88da5fdc08~0I-5w9XyS0190601906euoutp01J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1726044132;
	bh=P8Y2JKzGo93bR6n3j3ntff8Z9u6c14CWqudvn1yYg6k=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=S/iNXc68JzxgrCX9MF/rIVFknSkEJkY2m0z8QKQF098zFWVE0mvJ5/fHiBgqxvXY6
	 3EcuNRtAinpSN1ZNMTZZRsSiH82kkG+Cjt+KjaWYqD/lqn2XQ0Dx0Gys2qhydDuG2F
	 VJVTG6YCyYJe83Pr/AVn/WvBqgHvJx6IAUO1YoEs=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240911084212eucas1p15da32c0dbca8825d345f3cacd2733744~0I-5dsufc0782707827eucas1p1j;
	Wed, 11 Sep 2024 08:42:12 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id A2.01.09875.4E751E66; Wed, 11
	Sep 2024 09:42:12 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240911084212eucas1p2266e0807bc628806014a4aff9500f7d2~0I-47QIdw1367013670eucas1p2f;
	Wed, 11 Sep 2024 08:42:12 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240911084212eusmtrp1c32ee2fc4ffde3ebe5359c17697bdba4~0I-46uoDL2353523535eusmtrp1D;
	Wed, 11 Sep 2024 08:42:12 +0000 (GMT)
X-AuditID: cbfec7f4-131ff70000002693-55-66e157e49777
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 56.E9.19096.3E751E66; Wed, 11
	Sep 2024 09:42:11 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240911084211eusmtip165d828774c4052fbd66f73bee6a28a16~0I-4sCS8j1189711897eusmtip1_;
	Wed, 11 Sep 2024 08:42:11 +0000 (GMT)
Received: from localhost (106.110.32.44) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Wed, 11 Sep 2024 09:42:10 +0100
Date: Wed, 11 Sep 2024 09:40:59 +0200
From: Joel Granados <j.granados@samsung.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: David Woodhouse <dwmw2@infradead.org>, Lu Baolu
	<baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon
	<will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Kevin Tian
	<kevin.tian@intel.com>, Klaus Jensen <its@irrelevant.dk>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
Subject: Re: [PATCH 3/6] iommu: kconfig: Move IOMMU_IOPF into INTEL_IOMMU
Message-ID: <20240911074059.f3i22vso6g6payrj@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZtxFAxM6QQBYVSJp@ziepe.ca>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBKsWRmVeSWpSXmKPExsWy7djPc7pPwh+mGbTeULDYPHErm8XElZOZ
	LX59sbDYf/Abq8XMGScYLTpnb2C3WPp2K7vF5V1z2CwOfnjCatFyx9SBy+PJwXlMHmvmrWH0
	2LxCy2PxnpdMHud2nGf32LSqk81j3slAjxebZzJ6fN4k57H1822WAK4oLpuU1JzMstQifbsE
	rowXm9cwFWxnqfjV8J2pgXEjcxcjJ4eEgInE9SnzWbsYuTiEBFYwSrx6tIIZwvnCKPH7xyOw
	KiGBz4wSG55awnTcvbuJCaJoOaPEkqUzoNqBihav+MsI4WxmlHj+pZUVpIVFQFXiybI1LCA2
	m4COxPk3d8DGiggoSezbNZEdpIFZYAeTRN/sSWwgCWEBT4mHbd/AbF4BB4n/qzugbEGJkzOf
	gA1iBhq0YPcnoDgHkC0tsfwfB0iYU0BD4tmkN0wQpypKfF18jwXCrpU4teUW2NkSArM5Jb7u
	WAyVcJFYeHgnlC0s8er4FnYIW0bi9OQeFoiGyYwS+/99YIdwVjNKLGv8CrXCWqLlyhOoDkeJ
	b0/esYJcJCHAJ3HjrSDEoXwSk7ZNZ4YI80p0tAlBVKtJrL73hmUCo/IsJK/NQvLaLITXFjAy
	r2IUTy0tzk1PLTbKSy3XK07MLS7NS9dLzs/dxAhMXKf/Hf+yg3H5q496hxiZOBgPMUpwMCuJ
	8Pbb3UsT4k1JrKxKLcqPLyrNSS0+xCjNwaIkzquaIp8qJJCeWJKanZpakFoEk2Xi4JRqYFJN
	3jDh4suDVtZHHTjmVtgLbLz5nTe/LsUoxoyNzzno8f0SA+2TcdNlBPlOiF+6zjmvVNPPf7N7
	ZOqxh4al0/mav981LK43yChTPVdZIvaXm//rb+l3S49onN63f93eLXMNHz2UOm8UNN1u+hHX
	lkSbR8VinTbT7ovazI+5Y/NUQHziodPHOpzf9rjey1ssEfZIucBRVXxRRMad36t8fO2Mbp+X
	3dDQVneyrkDyivovV5uur38Wx/I71Ph/Mb6oUcK67/rn1Mk5pxeKiFkv43YI/J8rZJ9jWl+2
	8MZl8aXbq4U0XSzlxbJ+aGlM3H3t+p3akhkqZ7xCdN2ShcpK59XuyT/RVfhcLfXKP+svSizF
	GYmGWsxFxYkAfKDh6MsDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCIsWRmVeSWpSXmKPExsVy+t/xu7qPwx+mGfzZa2axeeJWNouJKycz
	W/z6YmGx/+A3VouZM04wWnTO3sBusfTtVnaLy7vmsFkc/PCE1aLljqkDl8eTg/OYPNbMW8Po
	sXmFlsfiPS+ZPM7tOM/usWlVJ5vHvJOBHi82z2T0+LxJzmPr59ssAVxRejZF+aUlqQoZ+cUl
	tkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehkvNq9hKtjOUvGr4TtTA+NG
	5i5GTg4JAROJu3c3MXUxcnEICSxllFg4eQ8rREJGYuOXq1C2sMSfa11sILaQwEdGiQebVCAa
	NjNK3G7YwgKSYBFQlXiybA2YzSagI3H+zR2wDSICShL7dk1kB2lgFtjBJNE3exLYJGEBT4mH
	bd/AbF4BB4n/qzvYIKY+Z5S4enktI0RCUOLkzCdgU5mBpi7Y/QmoiAPIlpZY/o8DJMwpoCHx
	bNIbJohLFSW+Lr7HAmHXSnz++4xxAqPwLCSTZiGZNAth0gJG5lWMIqmlxbnpucVGesWJucWl
	eel6yfm5mxiB0bvt2M8tOxhXvvqod4iRiYPxEKMEB7OSCG+/3b00Id6UxMqq1KL8+KLSnNTi
	Q4ymwLCYyCwlmpwPTB95JfGGZgamhiZmlgamlmbGSuK8bFfOpwkJpCeWpGanphakFsH0MXFw
	SjUwhQhez1KtLHzh5VE77/LZq7I1bBqWUxeu8ZxtUT230ai5K+/Rssa5QZ17ZY9/O9JTfXm1
	bBHv5FrvCeuYmlfd33mdY3pw0MTTR6wXONvUZk+8cYrVgUf67zm90xNX7ef2WBkySfzo/m36
	e89c/yK/oK++dFf54k2H10vHWtRdfFYgEtooPcH8tE79zbIW0cSouxJ1Ory/SqSWMi06zqV7
	xETiamJM21FRg51Ppu8svu4vaHDtequjVefa9p9cvCe5Twhfb/65yCjo3YNqX/0ttw6+F4m4
	p9U/4Y9TkR3/LuN7BdKrxYNqp139UBB373XkZZ39r7Q/ym1KcdJlYb4qdnpDQXGJvtPKpdcP
	mTkdVGIpzkg01GIuKk4EANvlLl1nAwAA
X-CMS-MailID: 20240911084212eucas1p2266e0807bc628806014a4aff9500f7d2
X-Msg-Generator: CA
X-RootMTR: 20240907122025eucas1p26776e1be9713e21ecd4ee612e470d5ba
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240907122025eucas1p26776e1be9713e21ecd4ee612e470d5ba
References: <20240904-jag-iopfv8-v1-0-e3549920adf3@samsung.com>
	<20240904-jag-iopfv8-v1-3-e3549920adf3@samsung.com>
	<CGME20240907122025eucas1p26776e1be9713e21ecd4ee612e470d5ba@eucas1p2.samsung.com>
	<ZtxFAxM6QQBYVSJp@ziepe.ca>

On Sat, Sep 07, 2024 at 09:20:19AM -0300, Jason Gunthorpe wrote:
> On Wed, Sep 04, 2024 at 03:17:14PM +0200, Joel Granados via B4 Relay wrote:
> > @@ -51,7 +52,6 @@ config INTEL_IOMMU_SVM
> >  	depends on X86_64
> >  	select MMU_NOTIFIER
> >  	select IOMMU_SVA
> > -	select IOMMU_IOPF
> 
> Does patch 1 still compile if INTEL_IOMMU_SVM=n?
It does for me. With and without INTEL_IOMMU_SVM. Is there a config that
is not compiling for you? You can send that you to me and I can give it
a try, to see if I get the same issue.

Best

-- 

Joel Granados
