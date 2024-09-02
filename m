Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17163184524
	for <iommu@lists.linux.dev>; Mon,  2 Sep 2024 10:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725274116; cv=none; b=JctcLvqU4k/YQdpO5Sey0W39YugjyOVwurD90+kuF1OZEN0ehSZoNGmkyiy1vCUtyqCY95zh1Em2rZA/fuTXMPKwo22oaNykojIgySZ5D/uBMD7Ts7/1jo/BX5qXvbNEbePejUZEHoJTshzC5Fc2hDvj/IFQDSAQFi+DQ8/oz7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725274116; c=relaxed/simple;
	bh=wBMmabmhsclZBTWPbrD8VzJgKA3DNc/qDaswq8PIxBA=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=lSAgfIlrB/6m629w+o1voct5cwz8A3tHsN3ZZ+3BsfFNpemrjuqEFHQYmq0m62aJUQ6mzVAuaGIy2KmL5ufPuBIlQUzelw5B6RL30ZHivjsAWuXB0h802cfwrvTuHJ7E8T+IOOb3Rp9jz3MBL7VFfTLmSAeCvA9BqZoXmDX8lXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=sACv236D; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="sACv236D"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240902104830euoutp021f60e91260ab0c7d122139b5bc0943f2~xZ6mHpCNm1293812938euoutp02a
	for <iommu@lists.linux.dev>; Mon,  2 Sep 2024 10:48:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240902104830euoutp021f60e91260ab0c7d122139b5bc0943f2~xZ6mHpCNm1293812938euoutp02a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1725274110;
	bh=aKSFkh8fFKGmYMjs80YEBxpT7s8/oWIigPrpaxNiW0I=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=sACv236DNU7J40TJiaICX9VRgjdBftL51HwztIGbkIXhigsvRBqN1liVrjSN4n2AQ
	 h6yP/MBXSCmRYAxv2rNYbFPPS2lKTaWGqn6+iOseifx5BFfBAuZwKgNC4PeC1vUFIV
	 BWF1OPlKMtWdgQcEiYgQtMvOD+cV+cg92hdSDCRk=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240902104829eucas1p2650a770677de0b6c5507035d3be35a60~xZ6l3xBoW0418604186eucas1p2k;
	Mon,  2 Sep 2024 10:48:29 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 72.63.09620.DF795D66; Mon,  2
	Sep 2024 11:48:29 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240902104829eucas1p13e50a1c7f51ff3e53506fdf1e8dd2a42~xZ6lO-h9a0091000910eucas1p1x;
	Mon,  2 Sep 2024 10:48:29 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240902104829eusmtrp15d472fc77413ee37c989c13da3a04bae~xZ6lOLRDJ0715407154eusmtrp1M;
	Mon,  2 Sep 2024 10:48:29 +0000 (GMT)
X-AuditID: cbfec7f5-d1bff70000002594-05-66d597fdb6ad
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id AC.C6.14621.CF795D66; Mon,  2
	Sep 2024 11:48:28 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240902104828eusmtip2d942b5773e490cab3332f300375f8771~xZ6k2fd980147701477eusmtip2E;
	Mon,  2 Sep 2024 10:48:28 +0000 (GMT)
Received: from localhost (106.110.32.44) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Mon, 2 Sep 2024 11:48:24 +0100
Date: Mon, 2 Sep 2024 12:48:19 +0200
From: Joel Granados <j.granados@samsung.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: Klaus Jensen <its@irrelevant.dk>, David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Kevin Tian
	<kevin.tian@intel.com>, Minwoo Im <minwoo.im@samsung.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>, Klaus Jensen
	<k.jensen@samsung.com>
Subject: Re: [PATCH RFC PREVIEW 0/6] iommu: enable user space iopfs in
 non-nested and non-svm cases
Message-ID: <20240902104819.a2jto6l3tv2h5wvq@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240826135955.GI3468552@ziepe.ca>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA01SWUwTURTNm5m2Q6V1GBCeYCTWhYhSMGgco3ED46gxSqKEGBOoMEBZtS0u
	GBEtghAM1sYFqAgBtdRGsJuKiraJgBAEt4hVNEo1SiguUEUjqMO4/Z1z7zn33vPycJQ08wJx
	eZaKUWTJMiR8IWZr+doVNnryUXJE8+s5lFlj5VOaei1KfRumqJv2zzyq/FQboIorGwXUWbdV
	QD1o0vEp+wcXjyp4tmC5kHbZqxDaWGUEtFkfStdef4fQd690CWiToZhPV92Jod+aywE9ZJpK
	W4eeYhuFW4RLkpgM+U5GEb40QZh64GsDuv1E4G5109x84PQrATgOifnQYlGVACFOEnoAtW1G
	wJFhAHX5Lb/JEIC1tlZBCfAad9R0aHgsJonzAFobNv8VFTsHeBwxAaju7hlXYcQMWPe0B2Mx
	n5gLuwaeoSz2IySwuUkjYA0oUYDCa241n234Egysq29E2ANFxHJYVhXOlkWED7xT7hqfg/6a
	U33tE5+VoEQQPD+Gs9CLiICFP+TcndOgp/Y5xuF9sN3iRNhNkKj0gp6HvYBrRMN3p0d4HPaF
	/a2W3yGnwA5tKcYZtADeHPsg4MgFAM8d8CCcajEseOgScA+5ArqexHFQDHvcPtyZYnjMdhLl
	yiJ4uJDkjLPghecD2FEwveK/YBX/Bav4F6waoAYQwOQoM1MYZWQWs0uqlGUqc7JSpInZmSbw
	6191jLV6rgB9/0epAyA4cACIoxI/0dnr95JJUZJsTy6jyI5X5GQwSgcIwjFJgGhmUjBDEiky
	FZPOMNsZxZ8ugnsF5iPW9sG1UZ2ryxLJ4GW2taftvabCfXnmrXFI5UQkLUT1wltFBYgp/ZrR
	xDJXWmSuK01xY33lxRNHbwNn3+jHaPHEGm+tMSQ87LtA7utcuNtDfpscPmnLjv3xtk452Xcr
	qX/FpVd1lmAkb+SxUB1bE1/0fqE2YTDvfl91w3FCvao0JPrVmpaETnF9zY90X8diQ1wzsu5N
	nMldv85+cLD5S9DOwzqdvG/Yu+6g4fjVzdFthf0+G2JKezVFuqhQkzQogbpt2PQypmHO3tXu
	F9oJ2e+l52bFFjla3/jzUkMiD7Vlrh9Z9Fnvr5RZuis8MWOrnIcS1d25W3ccMUZpt11eeWa2
	BFOmyuaFogql7CecGhiWxgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsVy+t/xe7p/p19NM+iVttg8cSubxcSVk5kt
	fn2xsNh/8BurxcwZJxgtOmdvYLdY+nYru8XlXXPYLA5+eMJq0XLH1IHL48nBeUwea+atYfTY
	vELLY/Gel0we53acZ/fYtKqTzWPeyUCPF5tnMnp83iTnsfXzbZYArig9m6L80pJUhYz84hJb
	pWhDCyM9Q0sLPSMTSz1DY/NYKyNTJX07m5TUnMyy1CJ9uwS9jMaf65kLpklVNO/SaWC8JdLF
	yMkhIWAisfD0RNYuRi4OIYGljBJ7Nkxkg0jISGz8cpUVwhaW+HOtiw2i6COjxOGP+5ghnE2M
	Ei0vl7ODVLEIqEgsuX2DBcRmE9CROP/mDjOILSKgJLFv10R2kAZmgRZmid1vm8FWCAukSixZ
	uYGpi5GDg1fAQaJ/nj7E0N2MEpO7WhhBangFBCVOznwCNpQZaOiC3Z/YQOqZBaQllv/jADE5
	BQwk2v5nQhyqKPF18T0WCLtW4vPfZ4wTGIVnIRk0C8mgWQiDFjAyr2IUSS0tzk3PLTbUK07M
	LS7NS9dLzs/dxAiM223Hfm7ewTjv1Ue9Q4xMHIyHGCU4mJVEeJfuuZgmxJuSWFmVWpQfX1Sa
	k1p8iNEUGBITmaVEk/OBiSOvJN7QzMDU0MTM0sDU0sxYSZzX7fL5NCGB9MSS1OzU1ILUIpg+
	Jg5OqQYmQTt9zqmztN5zW/XGpUjd0QouU6o1KWfcfFQl1pH/CKflnxS+tMn6/t5bmFQ/Ror8
	lZEPmZM3e/4S5aubF764nBUpdjKjca3U6WhnV5V6Fbu8vjQXw8ti3h+W3/sfpfH9/2eOQPuJ
	/xZxM+buTRb5HpxeP/nKmVtl6c2dV3JqpN3DJj7OUVzln+W3SIHbv7tmeVKb68+QNB+uH7Fl
	SiqXZzhf/6uw5rrnlwfsomEud67wbmowiee4fj6K4TdD3cXpkYZmx0PKZ+ozXrhQtCXSX/rT
	w59xRVf2G2iUPPi4v+DIlHp5u22rU5IfGP+23nORR/tkwT1BG82Yvd0CmwzPHpMS9pQ58q+0
	NLt3pRJLcUaioRZzUXEiANxdCi1kAwAA
X-CMS-MailID: 20240902104829eucas1p13e50a1c7f51ff3e53506fdf1e8dd2a42
X-Msg-Generator: CA
X-RootMTR: 20240826140000eucas1p2b422169d0d2c633f64461b2152e9ae97
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240826140000eucas1p2b422169d0d2c633f64461b2152e9ae97
References: <20240826-iopf-for-all-v1-0-59174e6a7528@samsung.com>
	<CGME20240826140000eucas1p2b422169d0d2c633f64461b2152e9ae97@eucas1p2.samsung.com>
	<20240826135955.GI3468552@ziepe.ca>

On Mon, Aug 26, 2024 at 10:59:55AM -0300, Jason Gunthorpe wrote:
> On Mon, Aug 26, 2024 at 01:40:26PM +0200, Klaus Jensen wrote:
> > This is a Request for Comment series that will hopefully generate
> > initial feedback on the use of the iommufd_hwpt_replace_device to
> > execute non-nested and non-svm user space IOPFs. Our main motivation is
> > to enable user-space driver driven device verification with default
> > pasid and without nesting nor SVM.
> > 
> > What?
> >   * Enable IO page fault handling in user space in a non-nested, non-svm
> >     and non-virtualised use case.
> >   * Removing the relation between IOPF and INTEL_IOMMU_SVM by allowing
> >     the user to (de)select the IOPF code through Kconfig.
> >   * Create a new file under iommu/intel (prq.c) that contains all the
> >     page request queue related logic and is not under intel/svm.c.
> >   * Add the IOMMU_HWPT_FAULT_ID_VALID to the valid flags used to create
> >     IOMMU_HWPT_ALLOC allocations.
> >   * Create a default (zero) pasid handle and insert it to the pasid
> >     array within the dev->iommu_group when replacing the old HWPT with
> >     an iopf enabled HWPT.
> > 
> > Why?
> >   The PCI ATS Extended Capability allows peripheral devices to
> >   participate in the caching of translations when operating under an
> >   IOMMU. Further, the ATS Page Request Interface (PRI) Extension allows
> >   devices to handle missing mappings. Currently, PRI is mainly used in
> >   the context of Shared Virtual Addressing, requiring support for the
> >   Process Address Space Identifier (PASID) capability, but other use
> >   cases such as enabling user-space driver driven device verification
> >   and reducing memory pinning exists. This patchest sets out to enable
> >   these use cases.
> 
Sorry for the late reply, Slowly getting through my backlog after PTO

> I definitely expect PRI to work outside PASID and SVA cases, so this
> is going in a good direction
This touches on a detail (at least in Intel's vtd-io spec) that is not
100% clear to me. Second paragraph of section "3.4.3 Scalable Mode
Address Translation" reads:
"
  ... Scalable-mode context-entries support both requests-without-PASID
  and requests-with-PASID. However unlike legacy mode, in scalable-mode,
  requests-without-PASID obtain a PASID value from the RID_PASID field of
  the scalable-mode context- entry and are processed similarly to
  requests-with-PASID.Implementations not supporting RID_PASID capability
  (ECAP_REG.RPS is 0b), use a PASID value of 0 to perform address
  translation for requests without PASID.
"
This basically means that a default PASID is used even though the
request is without PASID. Right? Therefore "outside PASID" means with
the default PASID (at least in Intels case). Right?

> 
> >   Supplementary repositories supporting this patchset:
> >     1. A user space library libvfn [1] which is used for testing and
> >        verification (see examples/iopf.c), and
> 
> That's pretty neat, I've been wanting to see some kind of IOMMU test
> suite based around a capable widely available device. This is the
> closest I've seen..
Yes! This is an obvious application of libvfn. Do you see it as a
something that can be included in tools/selftests/iommu?

Best
-- 

Joel Granados
