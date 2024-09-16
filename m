Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8001145A07
	for <iommu@lists.linux.dev>; Mon, 16 Sep 2024 08:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726476699; cv=none; b=Rf+F7fgb7T50Xh7v41M/wvR9zP4Zks4zUirD6vm0aeQPF0O+h/49XL74T6JgzaCEMWwWDUbf72m8HvDfbPy3DtjeXiSCYFQKxjUlPGKVtLeWzzYRmvxlq8mnC8okSKBbGsDZx1KWDkuLBTGay7sTGgncykTrj//z20s1nKwqc4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726476699; c=relaxed/simple;
	bh=sIi6lGnRDmnpWsFor1oMST/ypdc8o4B5UfnJGrhMCEA=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=TKBeVqOS1X0pt/Ci/h8Z4cjgp8hc9+HJxAP+ynAOXbkU1mDEfXz4U5SRvBjO2m7wK4nhopuCSOgUf0SjLCUi+e2JkYCOrIiEdMx/qMgARXaR9I7O1qp6T+USGL9Y1xSCU37vFigl5y1geXEW9+5/yvlUG/TERdfr/7waxgbO/io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Y5XCUWus; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Y5XCUWus"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240916085129euoutp01fdcaf1fd376cd0ac0b4762ee2f61d42b~1rWbcoMbS1256612566euoutp01D
	for <iommu@lists.linux.dev>; Mon, 16 Sep 2024 08:51:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240916085129euoutp01fdcaf1fd376cd0ac0b4762ee2f61d42b~1rWbcoMbS1256612566euoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1726476689;
	bh=00zyv8CQAfu2svO5KB8AB1uhDRFJkT8EwN1UnOCwONY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=Y5XCUWusG+eMa/zKSvNH1oQ904PEahK3o99SgsVLK4KXV8hexryzMmI7EcaJFKAm5
	 Q1YMh3uOqZvbNkZgnHhb96WKv5nGSGml+Rt/oTluJsgzRwyUwnDs3XIw2rV5amFOOq
	 sPG0MBLEYpYqAQhWUajopUvSVuBexQn0n2HFxxPk=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240916085129eucas1p1bbfe0f5e1670d7e87510212b07bb5c6e~1rWbInLq72956929569eucas1p1Z;
	Mon, 16 Sep 2024 08:51:29 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 2D.0A.09624.191F7E66; Mon, 16
	Sep 2024 09:51:29 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240916085128eucas1p1ac5a0605409839e99064198547ab1eb3~1rWanEuGe0804508045eucas1p1f;
	Mon, 16 Sep 2024 08:51:28 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240916085128eusmtrp12725bf46fa341d77854fdc1e0b7b65f3~1rWamOqL51596415964eusmtrp1j;
	Mon, 16 Sep 2024 08:51:28 +0000 (GMT)
X-AuditID: cbfec7f2-c11ff70000002598-d3-66e7f191dfaa
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 59.51.19096.091F7E66; Mon, 16
	Sep 2024 09:51:28 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240916085128eusmtip11f7e18116a28e61705840777542ff39e~1rWaW3Tr93124331243eusmtip1d;
	Mon, 16 Sep 2024 08:51:28 +0000 (GMT)
Received: from localhost (106.110.32.44) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Mon, 16 Sep 2024 09:51:26 +0100
Date: Mon, 16 Sep 2024 10:50:54 +0200
From: Joel Granados <j.granados@samsung.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
CC: David Woodhouse <dwmw2@infradead.org>, Lu Baolu
	<baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon
	<will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe
	<jgg@ziepe.ca>, Klaus Jensen <its@irrelevant.dk>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, Klaus Jensen
	<k.jensen@samsung.com>
Subject: Re: [PATCH v2 0/5] iommu: Enable user space IOPFs in non-PASID and
 non-svm cases
Message-ID: <20240916085054.gpan37ds7ea45pgh@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BL1PR11MB5271994848066586A098327F8C662@BL1PR11MB5271.namprd11.prod.outlook.com>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGKsWRmVeSWpSXmKPExsWy7djP87oTPz5PM7i8hNli88StbBYTV05m
	tvj1xcJi/8FvrBYzZ5xgtOicvYHdYunbrewWl3fNYbM4+OEJq0XLHVMHLo8nB+cxeayZt4bR
	Y/MKLY/Fe14yeZzbcZ7dY9OqTjaPeScDPV5snsno8XmTnMfWz7dZAriiuGxSUnMyy1KL9O0S
	uDLar/5mK1jEVzGlMa6BcTp3FyMnh4SAicSXIxfYQWwhgRWMEpsmeXYxcgHZXxglZrzZwAzh
	fGaUeNn9lgmm42vba2aIjuWMEns3VcIVfVt7nh3C2cwosf3AQxaQKhYBVYlfS96CdbAJ6Eic
	f3MHzBYR0JD48X0G2ApmganMEg+OvGAESQgLREs0/7oGVsQr4CAx5+wcKFtQ4uTMJ2BDmYEG
	Ldj9ia2LkQPIlpZY/o8DJMwpECtx4+JEqEsVJb4uvscCYddKnNpyiwlkl4TAbE6JiW+eMUIk
	XCSeHNrBDGELS7w6voUdwpaROD25hwWiYTKjxP5/H9ghnNWMEssav0KtsJZoufIEqsNRYtXB
	lUwgF0kI8EnceCsIcSifxKRt05khwrwSHW1CENVqEqvvvWGZwKg8C8lrs5C8NgvhtQWMzKsY
	xVNLi3PTU4sN81LL9YoTc4tL89L1kvNzNzECk9bpf8c/7WCc++qj3iFGJg7GQ4wSHMxKIry2
	v5+mCfGmJFZWpRblxxeV5qQWH2KU5mBREudVTZFPFRJITyxJzU5NLUgtgskycXBKNTBFBRoy
	X9p9001fvJPzl2Ljm8onHKFvlh29bVazzuqT6excQ25HnaTlcdxLs0/fkLxdNiH/a4BwmOLL
	cqt/6/4cvX5/ZWlLI5/R9tMGRnv6X5ToMiwqUFAx+5fYwhX4U7s8TIlzc41UV4FU56pvpo/Y
	BAv02bJVXyxKEa1It7j23HKZQIvCv2mRiVq9F39fat82aadjcO++ZXpf+Bfo55tx6Pn8LTJg
	N1wi8erTZbM7VocznhlkPe42zazOMxLK/7DLN01h/dcwf/d77dGFQunKsVMceoQkwh0n6W5h
	UJ4vO6Mv3Thc3sKP95vfFM6Xba9fOhk9v+E1PX/h8mOnZpVMWnwl+cL8ypiF4dwGSizFGYmG
	WsxFxYkAVclkvskDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMIsWRmVeSWpSXmKPExsVy+t/xu7oTPj5PMzi2Wcpi88StbBYTV05m
	tvj1xcJi/8FvrBYzZ5xgtOicvYHdYunbrewWl3fNYbM4+OEJq0XLHVMHLo8nB+cxeayZt4bR
	Y/MKLY/Fe14yeZzbcZ7dY9OqTjaPeScDPV5snsno8XmTnMfWz7dZArii9GyK8ktLUhUy8otL
	bJWiDS2M9AwtLfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DLar/5mK1jEVzGlMa6BcTp3
	FyMnh4SAicTXttfMXYxcHEICSxklWn+uYIRIyEhs/HKVFcIWlvhzrYsNougjo8T1l9OgnM2M
	EreeH2EDqWIRUJX4teQtM4jNJqAjcf7NHTBbREBD4sf3GWArmAWmMks8OPICbIWwQLRE869r
	YEW8Ag4Sc87OAbOFBJ4xStyeEgwRF5Q4OfMJC4jNDDR0we5PQMs4gGxpieX/OEDCnAKxEjcu
	TmSCuFRR4uvieywQdq3E57/PGCcwCs9CMmkWkkmzECYtYGRexSiSWlqcm55bbKRXnJhbXJqX
	rpecn7uJERi724793LKDceWrj3qHGJk4GA8xSnAwK4nw2v5+mibEm5JYWZValB9fVJqTWnyI
	0RQYFBOZpUST84HJI68k3tDMwNTQxMzSwNTSzFhJnJftyvk0IYH0xJLU7NTUgtQimD4mDk6p
	BiaLJyE5/8t7f/JUrTNfpbP/ucmpqZcUY7vvLlp384jIJgUVo96IxXZCW37MuKG4QcfwgueE
	OcfYQiWYHiYdWHloyss7MsIctW9+Mral5Rnu6D42z9Gz2TYv3u+bwdTVBUxOG0MnfTeZ8W9/
	3a6GYsOLy2rPmuxZyn3on+msWKni1mzNqMsG56NPX55Tfn7W2ym9n61FPTr2Tf7c6Oi0ym+/
	dNO8tZt3vfudK6izYt0ejW3NkXv6TNZu2vM6ylAl4taXPLNJnzz/nD/K+X4H74rYz9xGPzIf
	We7UeuN5OKvtkUBpmMYagyVax9c+M1AUXnQ+xGlrn+oeo2+CH+osFxaKdtpNmSDApGuYpJXC
	9jBciaU4I9FQi7moOBEA30/pHmYDAAA=
X-CMS-MailID: 20240916085128eucas1p1ac5a0605409839e99064198547ab1eb3
X-Msg-Generator: CA
X-RootMTR: 20240914004847eucas1p23af12d7ea9f70f0de6a9a900072bdad8
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240914004847eucas1p23af12d7ea9f70f0de6a9a900072bdad8
References: <20240913-jag-iopfv8-v2-0-dea01c2343bc@samsung.com>
	<CGME20240914004847eucas1p23af12d7ea9f70f0de6a9a900072bdad8@eucas1p2.samsung.com>
	<BL1PR11MB5271994848066586A098327F8C662@BL1PR11MB5271.namprd11.prod.outlook.com>

On Sat, Sep 14, 2024 at 12:48:31AM +0000, Tian, Kevin wrote:
> > From: Joel Granados via B4 Relay
> > <devnull+j.granados.samsung.com@kernel.org>
> > 
> > This series makes use of iommufd_hwpt_replace_device to execute
> > non-pasid/non-svm user space IOPFs. Our main motivation is to enable
> > user-space driver driven device verification without SVM/PASID.
> 
> can you elaborate why IOPFs are necessary to help verify such usage?

In retrospect "enable" might not be the best word to use here. We are not
"enabling" user-space driver driven device verification as it is already
enabled; you could already poke a device from user space. But the whole poke
space was not available, you could not test IOPF without having an SVM/PASID
capable IOMMU. Therefore a better wording would be "Our main motivation is to
expand or facilitate user-space driver driven device verification by enabling
IOPF without SMV/PASID".

Does this address your concern?

> 
> > 
> > What?
> >   * Enable IO page fault handling in user space for a non-pasid, non-svm
> >     and non-virtualised use case.
> >   * Move IOMMU_IOPF configuration from INTEL_IOMMU_SVM into
> > INTEL_IOMMU.
> >   * Move all page request queue related logic to a new (prq.c) file.
> >   * Remove PASID checks from PRQ event handling as well as PRQ
> >     initialization.
> >   * Allow execution of IOMMU_HWPT_ALLOC with a valid fault id
> >     (IOMMU_HWPT_FAULT_ID_VALID)
> >   * Insert a zero handle into the PASID array in dev->iommu_group when
> >     replacing the old HWPT with an IOPF enabled HWPT.
> 
> the last bullet is stale now.
oops. Missed that one; will correct in next version 

> 
> btw a selftest is expected too.
I'll figure this out for the next version.

Thx for the review

Best
-- 

Joel Granados
