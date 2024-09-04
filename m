Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F375A1547E0
	for <iommu@lists.linux.dev>; Wed,  4 Sep 2024 10:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725444322; cv=none; b=j2hnBpDeH399LSL7EONqiXT8jcoQ6XzRqKUkuBxfEd04QTPfSszaSdlxumWJbh8xTyiKnpJWEPwHX3LysymYuS1XDt7VpiR/PJOWRTIRNblNYAvXdNRn+ZfeA4I7QqlLwXUijAjB/83PRtfikefa8ufem0tFZK+kuRn7FUiUIb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725444322; c=relaxed/simple;
	bh=AONNU4qb9oiFPGSw9fpfGy0jr4gbBJfkSgZJ8vVzOxw=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=eDuX7mYuNy1An+DXkw+fRRVPJn0Cq8YeZVsiaEX7utUtQD5Bdp9ZTStKIULFhpsmw1bsARd7kli+t40CZhsMEHK4xWqSrexth85Jr3Rt7uHPdEmKoKGQHs9iibjayn+7mxw2dX6vFo9MbUq6ewkiwAnDD4r31h416sRB8XUd1lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=G4o+wR5a; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="G4o+wR5a"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240904100518euoutp02453fa3ff55afac405eeec6dc7e223698~yAncwYfdR1297412974euoutp02w
	for <iommu@lists.linux.dev>; Wed,  4 Sep 2024 10:05:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240904100518euoutp02453fa3ff55afac405eeec6dc7e223698~yAncwYfdR1297412974euoutp02w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1725444318;
	bh=YPUgnqz7LL9XdDgsRpg8rhlUBrIzuDzbzJ48Egoi0w8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=G4o+wR5aGwLhae7QjKcpVSzh8LflCPCA+2XzDD1+TEGsDLJDDfKvlVDStmqG3Hqol
	 dWmBoOyyFlS4ijTRv7wZjITXSz8uRX0/xOeqjPLdV3mwJWAbP8vD7hyDA1rXxR5ApY
	 8Ei9BG3icTezz8Sh+xjnSHqF8/Qb4xm96CTC4xHM=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240904100517eucas1p2b8a8411572ce57ec9d023fbaa3d6069d~yAnccTdD21206612066eucas1p24;
	Wed,  4 Sep 2024 10:05:17 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id A7.D6.09875.DD038D66; Wed,  4
	Sep 2024 11:05:17 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240904100517eucas1p19e878377b0d393607150e7ac0e9a9d4b~yAnb1shjE2106921069eucas1p1B;
	Wed,  4 Sep 2024 10:05:17 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240904100517eusmtrp1f6c7d16c091ef3f2bfb5ded3351c8d37~yAnb0uaL02008320083eusmtrp1I;
	Wed,  4 Sep 2024 10:05:17 +0000 (GMT)
X-AuditID: cbfec7f4-11bff70000002693-fd-66d830dd78f8
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id D3.EA.14621.DD038D66; Wed,  4
	Sep 2024 11:05:17 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240904100516eusmtip1baa7740dc219f528d9d5b87ee53afb20~yAnboFi560150501505eusmtip1R;
	Wed,  4 Sep 2024 10:05:16 +0000 (GMT)
Received: from localhost (106.210.248.110) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Wed, 4 Sep 2024 11:05:10 +0100
Date: Wed, 4 Sep 2024 12:05:07 +0200
From: Joel Granados <j.granados@samsung.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
CC: Jason Gunthorpe <jgg@ziepe.ca>, Klaus Jensen <its@irrelevant.dk>, "David
 Woodhouse" <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>, Will
	Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Kevin Tian
	<kevin.tian@intel.com>, Minwoo Im <minwoo.im@samsung.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>, Klaus Jensen
	<k.jensen@samsung.com>
Subject: Re: [PATCH RFC PREVIEW 0/6] iommu: enable user space iopfs in
 non-nested and non-svm cases
Message-ID: <20240904100507.u3speeqf5ncopjhc@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8ab86203-ce4e-464d-81ea-2425e769d8a1@linux.intel.com>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBKsWRmVeSWpSXmKPExsWy7djP87p3DW6kGZy5pmWxeeJWNouJKycz
	W/z6YmGx/+A3VouZM04wWnTO3sBusfTtVnaLy7vmsFkc/PCE1aLljqkDl8eTg/OYPNbMW8Po
	sXmFlsfiPS+ZPM7tOM/usWlVJ5vHvJOBHi82z2T0+LxJzmPr59ssAVxRXDYpqTmZZalF+nYJ
	XBmr2puYChaKVmz/dJuxgfGrQBcjJ4eEgInEpQ0T2boYuTiEBFYwSqz/84sRwvnCKHFlYQML
	hPOZUWL1z6tMMC3zLx2HSixnlJh07iRC1fE/G9ghnC1ALc8/MIO0sAioSJyZ/YMNxGYT0JE4
	/+YOWFxEQF2iqXEv2HZmgf9MEntO94ElhAVSJZas3AC2j1fAQeLX37fsELagxMmZT1hAbGag
	QQt2fwJq5gCypSWW/+MACXMKOEusmfIR6lRliYPLDrFD2LUSp7bcYgLZJSEwn1PizpOJUAkX
	iSdn5jNC2MISr45vgYrLSJye3MMC0TCZUWL/vw/sEM5qRolljV+hVlhLtFx5wg5yhYSAo8ST
	mxEQJp/EjbeCEHfySUzaNp0ZIswr0dEmBNGoJrH63huWCYzKs5B8NgvJZ7MQPlvAyLyKUTy1
	tDg3PbXYKC+1XK84Mbe4NC9dLzk/dxMjMHGd/nf8yw7G5a8+6h1iZOJgPMQowcGsJML7WuRG
	mhBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFe1RT5VCGB9MSS1OzU1ILUIpgsEwenVAPTjIeR4ofa
	NvJcz1iXVWPpqnFMTFfy8rr6D8IrbofI3VXg7Htx6I9Y2HS2IyJFuclnf6xQ94rz5Lsxe8da
	DZP5L2592WwpYyCvtTmp/AB3gsj21BsfcuzVWp8K81szH9xkJBvVsontzKT7C8M2h6v5Rx9p
	zVj377zxok/2R4zvzOc+zxvzP+t4UrqHyokf0XkyOt+F4vemTDKonLPRQd/+jZlux07Br/Wl
	KmZq1SFp5i8r1Q77PZuceGWCzuOfCyNaXmvm8gp6WTOnbHJdYs6ZeazJ8xy3+7eTZUVKB7Z8
	fazTJyEyQT1s87a//zT9FkmYr1Mx5z/xdIWDblzwxUllm9i/fn/CevxnrUXJh0tKLMUZiYZa
	zEXFiQAK76OpywMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCIsWRmVeSWpSXmKPExsVy+t/xu7p3DW6kGVy9x2qxeeJWNouJKycz
	W/z6YmGx/+A3VouZM04wWnTO3sBusfTtVnaLy7vmsFkc/PCE1aLljqkDl8eTg/OYPNbMW8Po
	sXmFlsfiPS+ZPM7tOM/usWlVJ5vHvJOBHi82z2T0+LxJzmPr59ssAVxRejZF+aUlqQoZ+cUl
	tkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehmr2puYChaKVmz/dJuxgfGr
	QBcjJ4eEgInE/EvHWboYuTiEBJYySryc85kdIiEjsfHLVVYIW1jiz7UuNoiij4wSy/79Y4Rw
	tjBK9D95zghSxSKgInFm9g82EJtNQEfi/Js7zCC2iIC6RFPjXrBuZoH/TBItSxezgCSEBVIl
	lqzcwARi8wo4SPz6+xZstZDAbGaJMz+CIOKCEidnPgGrZwYaumD3J6BBHEC2tMTyfxwgYU4B
	Z4k1Uz4yQVyqLHFw2SGoD2olPv99xjiBUXgWkkmzkEyahTBpASPzKkaR1NLi3PTcYkO94sTc
	4tK8dL3k/NxNjMDo3Xbs5+YdjPNefdQ7xMjEwXiIUYKDWUmE97XIjTQh3pTEyqrUovz4otKc
	1OJDjKbAoJjILCWanA9MH3kl8YZmBqaGJmaWBqaWZsZK4rxul8+nCQmkJ5akZqemFqQWwfQx
	cXBKNTCJXnz3wczfokX80v4l3x6F6W9lz60/uZFfbUHNtpKg/uV+C1u//ufU3lb24vPZ7/p6
	64PrF0/KnbU5RHFrxGnuqQ9DAgsNK1aFsj4+IOBut8xrsbDG1U7vRZfm63s8bHbn9tY7JM4S
	ethNvkLo7dMVmX+Pxq1nfTMpJPrr5nupJS4cT+rValy6w7j9NBsWaMT8iIioCDrAe/qz9vXN
	94VkTy7uvSXx6GW6r6jULdPc4M2zFx6wslJ8/WxnW45YiY4TQxNr5rI4/3t+x3oDd8fNeK9W
	suDoj+2f1Dal+JUemnJsWYjE8tsOi08f/HV7pcL1hy7pPNlZ16o9/unPm3JS6c1W0Zh/avNr
	rc10t3QrsRRnJBpqMRcVJwIAxt0xOmcDAAA=
X-CMS-MailID: 20240904100517eucas1p19e878377b0d393607150e7ac0e9a9d4b
X-Msg-Generator: CA
X-RootMTR: 20240826140000eucas1p2b422169d0d2c633f64461b2152e9ae97
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240826140000eucas1p2b422169d0d2c633f64461b2152e9ae97
References: <20240826-iopf-for-all-v1-0-59174e6a7528@samsung.com>
	<CGME20240826140000eucas1p2b422169d0d2c633f64461b2152e9ae97@eucas1p2.samsung.com>
	<20240826135955.GI3468552@ziepe.ca>
	<20240902104819.a2jto6l3tv2h5wvq@joelS2.panther.com>
	<d1e1370a-0714-4da8-b645-f56d83ab0159@linux.intel.com>
	<20240903132018.yi2xuyrp7v3npfmt@joelS2.panther.com>
	<8ab86203-ce4e-464d-81ea-2425e769d8a1@linux.intel.com>

On Wed, Sep 04, 2024 at 09:37:35AM +0800, Baolu Lu wrote:
> On 9/3/24 9:20 PM, Joel Granados wrote:
> > On Mon, Sep 02, 2024 at 08:47:21PM +0800, Baolu Lu wrote:
> >> On 2024/9/2 18:48, Joel Granados wrote:
> >>>> I definitely expect PRI to work outside PASID and SVA cases, so this
> >>>> is going in a good direction
> >>> This touches on a detail (at least in Intel's vtd-io spec) that is not
> >>> 100% clear to me. Second paragraph of section "3.4.3 Scalable Mode
> >>> Address Translation" reads:
> >>> "
> >>>     ... Scalable-mode context-entries support both requests-without-PASID
> >>>     and requests-with-PASID. However unlike legacy mode, in scalable-mode,
> >>>     requests-without-PASID obtain a PASID value from the RID_PASID field of
> >>>     the scalable-mode context- entry and are processed similarly to
> >>>     requests-with-PASID.Implementations not supporting RID_PASID capability
> >>>     (ECAP_REG.RPS is 0b), use a PASID value of 0 to perform address
> >>>     translation for requests without PASID.
> >>> "
> >>> This basically means that a default PASID is used even though the
> >>> request is without PASID. Right? Therefore "outside PASID" means with
> >>> the default PASID (at least in Intels case). Right?
> >> Kind of yes.
> >>
> >> The PCI specification defines the concept of PASID and its role in
> >> transaction routing. We refer to PCI transactions with a PASID prefix as
> >> "request-with-PASID" and those without a PASID prefix as "request-
> >> without-PASID." Consequently, I understand 'outside PASID' to mean
> >> transactions that do not have a PASID prefix.
> >>
> >> The VT-d specification describes how the IOMMU hardware handles request-
> >> without-PASID. It uses a reserved PASID for its internal routing and
> >> handling purposes. If RID_PASID is supported (ECAP_REG.RPS=1), software
> >> can select its own reserved PASID. Otherwise, the IOMMU hardware will
> >> use a default value of 0.
> >>
> > Thx for getting back to me. This generates another doubt in my head
> > regarding the published capabilities from the intel IOMMU Hardware:
> > 
> > So ecap_pasid [1] does not have to be set in scalable-mode. Right? This
> > allows hardware supporting scalable-mode to reject transactions with
> > PASID whenever ecap_pasid is*NOT*  set; even though internally things
> > are handled with a PASID. This question is directly related to the two
> > last patches in the set.5/6 and 6/6.
> 
> Yes. And 5/6, 6/6 make sense to me. We should remove the PASID
> restriction from the code once PRI is split from SVA.

Thx for the clarification. I'll make sure to include them in my V1

Best

-- 

Joel Granados
