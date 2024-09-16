Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852E4482EF
	for <iommu@lists.linux.dev>; Mon, 16 Sep 2024 09:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726478672; cv=none; b=aL2N9BvzAiCSFnU35iveMsi4G/PuRqaVQyu5Gp5vliH3FfNMx3aA+zFJ7Cu7svsgZzXIYRJU3tL5AV3QD3uheiI23LTwDg4z+ZH+sA1s/uHG2ZtE9XwlV8HFrkEJs2WcGe13IfnPvfvUrBXdRe7uGR1C/qXni1oaEmrzh+Ug3RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726478672; c=relaxed/simple;
	bh=0tNkUVTgrLLAnl0jcRp96qRk0GeqKBpcWQgFcYgXF/M=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=CEOqR0IKLzty4U+97/K+5m/apCNg9wTfb/+aKu81PssTZVJ0r+zeemnvyrgNcGHMCq/jbKWA5U9+SIjWqKEE2Mj0hnqVVneGOVtSBQ1tVAkYP8YSM2oc/nmZe6FFRNxk623I9eag3u9z7tOCPxUBG1ePUgmp1A0LKRB8f/DKPrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=VGFr6wO8; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="VGFr6wO8"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240916092427euoutp023f44d5817a961c4c81d89a50aac20e47~1rzN42qnq0162401624euoutp026
	for <iommu@lists.linux.dev>; Mon, 16 Sep 2024 09:24:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240916092427euoutp023f44d5817a961c4c81d89a50aac20e47~1rzN42qnq0162401624euoutp026
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1726478667;
	bh=OqqmSEF2kg4JP4GvymfmY3lMlafexn4Xau9x4CD2fjk=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=VGFr6wO8kTE5PI93+DokxvPKuNOHlHT2xejeAjrMP2i/KuErzOI5XV0gm+1C7YLah
	 OhzC0GdJg9pKPKn5etmMfgmMN9naiSnsDkR9lQ4TV//bj7F/kruxY1SN+I7/U2ovYO
	 IXxQXzhoqbX0x63t5gjU3RXLgv1Y09rCadzClHg8=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240916092427eucas1p2c9c2de28823deafc35ced11d3cfd1bfe~1rzNhH2Qx1439714397eucas1p2u;
	Mon, 16 Sep 2024 09:24:27 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 1A.52.09624.B49F7E66; Mon, 16
	Sep 2024 10:24:27 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240916092426eucas1p14459d30965e9768af83f6e8b6fe94823~1rzNCZc-r1481814818eucas1p1r;
	Mon, 16 Sep 2024 09:24:26 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240916092426eusmtrp1f15879ad2710060cb2b41114e23fde33~1rzNBm1A-0459904599eusmtrp11;
	Mon, 16 Sep 2024 09:24:26 +0000 (GMT)
X-AuditID: cbfec7f2-c11ff70000002598-00-66e7f94be059
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 14.28.19096.A49F7E66; Mon, 16
	Sep 2024 10:24:26 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240916092426eusmtip2fe40b06f3d085cbf74b69437559d5db7~1rzMsacU-1983819838eusmtip2b;
	Mon, 16 Sep 2024 09:24:26 +0000 (GMT)
Received: from localhost (106.110.32.44) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Mon, 16 Sep 2024 10:24:24 +0100
Date: Mon, 16 Sep 2024 11:24:22 +0200
From: Joel Granados <j.granados@samsung.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
CC: David Woodhouse <dwmw2@infradead.org>, Lu Baolu
	<baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon
	<will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe
	<jgg@ziepe.ca>, Klaus Jensen <its@irrelevant.dk>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: Re: [PATCH v2 1/5] iommu/vt-d: Separate page request queue from SVM
Message-ID: <20240916092422.lasp556wb57em7hz@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BL1PR11MB52713D3D5947C66AE463FA4B8C662@BL1PR11MB5271.namprd11.prod.outlook.com>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBKsWRmVeSWpSXmKPExsWy7djPc7reP5+nGWz9zG+xeeJWNouJKycz
	W/z6YmGx/+A3VouZM04wWnTO3sBusfTtVnaLy7vmsFkc/PCE1aLljqkDl8eTg/OYPNbMW8Po
	sXmFlsfiPS+ZPM7tOM/usWlVJ5vHvJOBHi82z2T0+LxJzmPr59ssAVxRXDYpqTmZZalF+nYJ
	XBnnZr1mKrjCVfGo+Q1LA+Nmji5GTg4JAROJdds6WbsYuTiEBFYwSlybdJsJwvnCKNG9aSJU
	5jOjRO/Fx4wwLUcP3WOGSCxnlNg5+yhC1dGH59lBqoQENjNKrJriBWKzCKhKvD/8mgnEZhPQ
	kTj/5g4ziC0ioCHx4/sMsEnMAu+YJOb1vmQBSQgL+Eh8bzsDZvMKOEhsWHqWDcIWlDg58wlY
	nBlo0ILdn4DiHEC2tMTyf2APcQrESvw5tpYZ4lJFia+L77FA2LUSp7bcAvtNQmA6p8TtzT2s
	EAkXieuPLjNB2MISr45vYYewZSROT+5hgWiYzCix/98HdghnNaPEssavUB3WEi1XnkB1OEr8
	mPqLGeQiCQE+iRtvBSEO5ZOYtG06VJhXoqNNCKJaTWL1vTcsExiVZyF5bRaS12YhvLaAkXkV
	o3hqaXFuemqxYV5quV5xYm5xaV66XnJ+7iZGYOI6/e/4px2Mc1991DvEyMTBeIhRgoNZSYTX
	9vfTNCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8qinyqUIC6YklqdmpqQWpRTBZJg5OqQYm0ZJn
	iyJEf1UyXJ37fxrL1S2mUV+q37lWWz7sPZRyd25j/W/NkOfvup2vbdqxZ/7KP7MO9EzPVbyf
	u6i61jlfUus+u/FslV61rt2W4fanK8UfchU0OSjU2mqc8b67xnf5S/3Vz0Sv/xQyn3z12Suj
	BTzLzDZd2qCZ4u98Nm39bzl9ZoPgOamLP1ZdeqW5Te5vmvNP2W3uN3vnFRau11s0O0ooufvm
	IefdfBq9ZquYmAO+F1zdLB2dpKd6TlIr5Gv9F8Pk1ta0xq/XTB4xajsJhHVMPXVswq+LjU2u
	k+ynxWy5EdHdIJWz4sIDezdh5XreX2HmHBErq768zvV88F076yl7YqpbX1xLdarqaxYlluKM
	REMt5qLiRACfOzYEywMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKIsWRmVeSWpSXmKPExsVy+t/xe7peP5+nGXxu0rfYPHErm8XElZOZ
	LX59sbDYf/Abq8XMGScYLTpnb2C3WPp2K7vF5V1z2CwOfnjCatFyx9SBy+PJwXlMHmvmrWH0
	2LxCy2PxnpdMHud2nGf32LSqk81j3slAjxebZzJ6fN4k57H1822WAK4oPZui/NKSVIWM/OIS
	W6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9O5uU1JzMstQifbsEvYxzs14zFVzhqnjU/IalgXEz
	RxcjJ4eEgInE0UP3mLsYuTiEBJYySsz6vo8NIiEjsfHLVVYIW1jiz7UuNoiij4wSS1atYIdw
	NjNKrNmwBayDRUBV4v3h10wgNpuAjsT5N3eYQWwRAQ2JH99ngK1gFnjHJDGv9yULSEJYwEfi
	e9sZMJtXwEFiw9KzUCvmMEk8aX/GBJEQlDg58wlYETPQ1AW7PwEVcQDZ0hLL/4H9wCkQK/Hn
	2FpmiFMVJb4uvscCYddKfP77jHECo/AsJJNmIZk0C2HSAkbmVYwiqaXFuem5xUZ6xYm5xaV5
	6XrJ+bmbGIHxu+3Yzy07GFe++qh3iJGJg/EQowQHs5IIr+3vp2lCvCmJlVWpRfnxRaU5qcWH
	GE2BYTGRWUo0OR+YQPJK4g3NDEwNTcwsDUwtzYyVxHnZrpxPExJITyxJzU5NLUgtgulj4uCU
	amASV+AwDuQr3m2yz48nRL+yifOH7Q41V3H/V7LxMzmnvb4g/eb+vYtFbld8QqaLW2fM+1fb
	wnjn3hXZWRl15WzVT9SOXPq7ryTlio7B1wSL9Qu6xTcmLdnCsdznUXeq8d7dvmYpvLOSOuR6
	vz36d+fdt6txh9gP2O6+e42VKaXGxSxX/1IUn93u2d+PlZUXt1d4sZWLHater9wTrmJQd3+u
	bKL8x0+7M9a9Wu6aHB0sk2P1Xzsnwq/xieqxo1xFb1jiXl2ZnF+0P6no6ZQFXSUFicpRdrI5
	p7c+1OOLnnw3+fLHV5MtbZVi2WtVTs1fcSiOcdUBj9Ta79K/BSTvmF6Lq1/zbUfK4fu6hwoN
	UpRYijMSDbWYi4oTAZz1sg1oAwAA
X-CMS-MailID: 20240916092426eucas1p14459d30965e9768af83f6e8b6fe94823
X-Msg-Generator: CA
X-RootMTR: 20240914005236eucas1p2e1490741a98121e9e74d042aa76aa4d7
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240914005236eucas1p2e1490741a98121e9e74d042aa76aa4d7
References: <20240913-jag-iopfv8-v2-0-dea01c2343bc@samsung.com>
	<20240913-jag-iopfv8-v2-1-dea01c2343bc@samsung.com>
	<CGME20240914005236eucas1p2e1490741a98121e9e74d042aa76aa4d7@eucas1p2.samsung.com>
	<BL1PR11MB52713D3D5947C66AE463FA4B8C662@BL1PR11MB5271.namprd11.prod.outlook.com>

On Sat, Sep 14, 2024 at 12:52:22AM +0000, Tian, Kevin wrote:
> > From: Joel Granados via B4 Relay
> > <devnull+j.granados.samsung.com@kernel.org>
> > 
> > From: Joel Granados <j.granados@samsung.com>
> > 
> > IO page faults are no longer dependent on CONFIG_INTEL_IOMMU_SVM.
> > Move
> > all Page Request Queue (PRQ) functions that handle prq events to a new
> > file in drivers/iommu/intel/prq.c. The page_req_des struct is now
> > declared in drivers/iommu/intel/prq.c.
> > 
> > No functional changes are intended. This is a preparation patch to
> > enable the use of IO page faults outside the SVM/PASID use cases.
> 
> Do we want to guard it under a new config option e.g.
> CONFIG_INTEL_IOMMU_IOPF? it's unnecessary to allocate resources
> for the majority usages which don't require IOPF.
> 
> Baolu?
> 
> > -#ifdef CONFIG_INTEL_IOMMU_SVM
> >  	if (pasid_supported(iommu)) {
> >  		if (ecap_prs(iommu->ecap))
> > -			intel_svm_finish_prq(iommu);
> > +			intel_finish_prq(iommu);
> >  	}
> > -#endif
> 
> either intel_iommu_finish_prq() or intel_prq_finish().

Thx; I see the pattern now! The first (Adding "_iommu_" to the name)
makes more sense to me as I see some intel_iommu_* function further down
in the iommu.h file.

> 
> same for other helpers.

Will change for the next version

Best

-- 

Joel Granados
