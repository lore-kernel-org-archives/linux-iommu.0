Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C08E154C0B
	for <iommu@lists.linux.dev>; Wed, 11 Sep 2024 08:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726044138; cv=none; b=Tmw9Ck0H2hhfh5w/nbU509GFYtdwPI1D1u8FLvD8gmXOrxP2LzK194cmMNj3uy1CoJrgsiPPy9nOw/V4gi10FHPNGbFilalQV2Nc3F7w7U+asCsXo1gELfyrKdOdL73k6ezDBAsFRYG8LUmh/WUSftvAXbrEQCmjIIZEx7rf3CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726044138; c=relaxed/simple;
	bh=fup3GnKRyBMiAT4LRhFs5OgSepmfgKmHHL9BAt0JWeE=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=MVkY9g958PN/cSCdoiVh5v3KR8G5HSc3jXRrT162gd4GS0wkttZWNWt3J1lrwPzlgR7Tvtam7MbBosbKHbQbCMWgGKe8n0xv3eZcWfuNGPtqYy1sl6UYXtrETCtfFykaaoaGAWnkIojEtjLB/oa0ogBAygp+wWUOmt8I+2LHo/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=rBf1Yh/e; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="rBf1Yh/e"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240911084209euoutp01e4172f8c4d89e61f6eba6769e27017c4~0I-2Lsh3x3202032020euoutp01C
	for <iommu@lists.linux.dev>; Wed, 11 Sep 2024 08:42:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240911084209euoutp01e4172f8c4d89e61f6eba6769e27017c4~0I-2Lsh3x3202032020euoutp01C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1726044129;
	bh=ggkQNgYbOJHbcRaxVEceS0e8VTxM2WSYALm+99ixdc0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=rBf1Yh/e/Y3fZOed9cwVwxc7QGeWCd1rqEWFTsDau5iKwcW2jAeSq8KZOmpFj7HO+
	 f7Dv7FONjOITsP5C+wZOW2YkZbr33ZCegHJAKlWRBsV/bOXEulVjD7M+rQc5Lw6AN8
	 MRhkt7V+2t+6Qq/Hh6RheAB/HJH1KblgyjOvHkxY=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240911084208eucas1p1d30027de172edfb7a5584c314b60e34a~0I-17Vp7E1487214872eucas1p1C;
	Wed, 11 Sep 2024 08:42:08 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id DF.F0.09875.0E751E66; Wed, 11
	Sep 2024 09:42:08 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240911084208eucas1p2b924fb19b25b4b0ea4fb7a43574b582a~0I-1R_o1E2294722947eucas1p2o;
	Wed, 11 Sep 2024 08:42:08 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240911084208eusmtrp176301cf2ac1c5f9d87d4ae14fa6fe455~0I-1RX1vQ2353523535eusmtrp1_;
	Wed, 11 Sep 2024 08:42:08 +0000 (GMT)
X-AuditID: cbfec7f4-11bff70000002693-4a-66e157e0c19a
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 13.E9.19096.FD751E66; Wed, 11
	Sep 2024 09:42:07 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240911084207eusmtip24c2f257f417c19635112c3cb81617d18~0I-1D8RKc0884508845eusmtip2a;
	Wed, 11 Sep 2024 08:42:07 +0000 (GMT)
Received: from localhost (106.110.32.44) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Wed, 11 Sep 2024 09:42:06 +0100
Date: Wed, 11 Sep 2024 09:28:51 +0200
From: Joel Granados <j.granados@samsung.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
CC: David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Jason
	Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, Klaus Jensen
	<its@irrelevant.dk>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
Subject: Re: [PATCH 1/6] iommu/vt-d: Separate page request queue from SVM
Message-ID: <20240911072851.bwxmmmaq7meqdo3k@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ef543342-561d-420d-a7a1-7d155e89ad79@linux.intel.com>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBKsWRmVeSWpSXmKPExsWy7djP87oPwh+mGbRd07DYPHErm8XElZOZ
	LX59sbDYf/Abq8XMGScYLTpnb2C3WPp2K7vF5V1z2CwOfnjCatFyx9SBy+PJwXlMHmvmrWH0
	2LxCy2PxnpdMHud2nGf32LSqk81j3slAjxebZzJ6fN4k57H1822WAK4oLpuU1JzMstQifbsE
	rowvQJMKZrFUvPi9kL2BcT1zFyMnh4SAicSVO9PYuhi5OIQEVjBK9L8+CeV8YZR4s2U6lPOZ
	UeLwpL1MMC0P5/YzQySWM0pMWvmcCa6qa8oyqMxmRomlsxewgrSwCKhKHHg7HaydTUBH4vyb
	O2DbRQTUJZoa94LtYBbYyCQx999hsISwgKfE8b9X2EFsXgEHiZuz17FB2IISJ2c+YQGxmYEG
	Ldj9CSjOAWRLSyz/xwES5hRwluhcvhXqVEWJr4vvsUDYtRKnttyCik/nlJh8JQ3CdpF4tPM/
	NDSEJV4d38IOYctInJ7cwwJym4TAZEaJ/f8+sEM4qxklljV+hZpkLdFy5QlUh6NEyzqQDRxA
	Np/EjbeCEHfySUzaNp0ZIswr0dEmBFGtJrH63huWCYzKs5B8NgvJZ7MQPlvAyLyKUTy1tDg3
	PbXYKC+1XK84Mbe4NC9dLzk/dxMjMHGd/nf8yw7G5a8+6h1iZOJgPMQowcGsJMLbb3cvTYg3
	JbGyKrUoP76oNCe1+BCjNAeLkjivaop8qpBAemJJanZqakFqEUyWiYNTqoFJbdLhVR/nPZXb
	utQpz6vmbYLuwxD1E6sj5m5fz+DwSItB9JzX1oW9T77HfZuWMuelUlL+zCdC8d/0D806y3+z
	PPJsE++p2D2LvJs2SjeprBEtvG4/v+eOa/0S97bJtd+F9x74W2qUW6T2bYLZsvUFX9f0bz79
	3K9jIqOE5Rbbg37Kum/DP91Z4Gz4d3f2N5X05CCmI2sVvVrE2afdFFm5/uWSHzKdB7czfIw4
	3rf+93mpiV6XWO6ysHxcmTHty5bbOcsVnpt83nesoWX6H73yfZnTYwVkt7xadbnM+uLTXS9+
	8h+dpR28e/WCxH+SW1r/f03juMfH9X6vMM+nkiZ3TuXymZXfHq/VZDT+vnSq8xYlluKMREMt
	5qLiRADIT/bGywMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCIsWRmVeSWpSXmKPExsVy+t/xe7r3wx+mGazZZW2xeeJWNouJKycz
	W/z6YmGx/+A3VouZM04wWnTO3sBusfTtVnaLy7vmsFkc/PCE1aLljqkDl8eTg/OYPNbMW8Po
	sXmFlsfiPS+ZPM7tOM/usWlVJ5vHvJOBHi82z2T0+LxJzmPr59ssAVxRejZF+aUlqQoZ+cUl
	tkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehlfgLYVzGKpePF7IXsD43rm
	LkZODgkBE4mHc/vBbCGBpYwSq5orIOIyEhu/XGWFsIUl/lzrYuti5AKq+cgocePcRhYIZzOj
	xIFJR1lAqlgEVCUOvJ3OBGKzCehInH9zB2yqiIC6RFPjXrBuZoGNTEDdTWBFwgKeEsf/XmEH
	sXkFHCRuzl4HtaKJSWJq219WiISgxMmZT8A2MANNXbD7E1ARB5AtLbH8HwdImFPAWaJz+VYm
	iFMVJb4uvscCYddKfP77jHECo/AsJJNmIZk0C2HSAkbmVYwiqaXFuem5xUZ6xYm5xaV56XrJ
	+bmbGIHRu+3Yzy07GFe++qh3iJGJg/EQowQHs5IIb7/dvTQh3pTEyqrUovz4otKc1OJDjKbA
	sJjILCWanA9MH3kl8YZmBqaGJmaWBqaWZsZK4rxsV86nCQmkJ5akZqemFqQWwfQxcXBKNTDl
	vzn+k3PqP5+ZOflryjpfL90/3ygiR/fgHQ77mjsX/q3UtHgWvj/79Vzxc8qL736YV1hiFTzn
	+Karill3bTWnP2yLX6LGvGWftX9K2rm4jboZ8SF2sQ9tX51N3H5Y5Vzie80XPzmPvv+2ratj
	mfqN+dItBecSbzlvevKnf98fppk/TX27V86fa7Pi8s3k/HvS32ZuFP673VSAS69o/vbWfSbV
	Za5e65t0U0QTtHp7/ApERf1mnZrcWmTo1fxJ4FPBleDTExPe+ZQqC8f97NhwffO+swdmxXG5
	PJ/+69D66ykPNutOY18tuuqk87uIHzJnfszfcXvBAdZ+NqNXLc0m+UeWF7RndArOFjiwxepO
	gxJLcUaioRZzUXEiAKytGlZnAwAA
X-CMS-MailID: 20240911084208eucas1p2b924fb19b25b4b0ea4fb7a43574b582a
X-Msg-Generator: CA
X-RootMTR: 20240905032243eucas1p26088993e46d6e009768b661eb028dd40
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240905032243eucas1p26088993e46d6e009768b661eb028dd40
References: <20240904-jag-iopfv8-v1-0-e3549920adf3@samsung.com>
	<20240904-jag-iopfv8-v1-1-e3549920adf3@samsung.com>
	<CGME20240905032243eucas1p26088993e46d6e009768b661eb028dd40@eucas1p2.samsung.com>
	<ef543342-561d-420d-a7a1-7d155e89ad79@linux.intel.com>

On Thu, Sep 05, 2024 at 11:18:39AM +0800, Baolu Lu wrote:
> On 9/4/24 9:17 PM, Joel Granados via B4 Relay wrote:
> > From: Joel Granados<j.granados@samsung.com>
> > 
> > IO page faults are no longer dependent on CONFIG_INTEL_IOMMU_SVM. Move
> > all Page Request Queue (PRQ) functions that handle prq events to a new
> > file in drivers/iommu/intel/prq.c. The page_req_des struct is made
> > available in drivers/iommu/intel/iommu.h.
> 
> Above last sentence needs to be updated.
oops. missed that. thx.

-- 

Joel Granados
