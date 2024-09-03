Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72AC1CA690
	for <iommu@lists.linux.dev>; Tue,  3 Sep 2024 13:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725369629; cv=none; b=UoJJqKeAFrBlOoQaDUQ/va55qSgovdSWb0MVHKEKOrVJesyfXwSUgOzAjXP0TQcephyb/1EtFtHeq4jn7xbpCe8jLZbBz1KBQaA4hlQChWVAagKcxPcUGDCBjdCGu4FJEozAo6/zHWG0zKYSiAqxCPC3IXbUdWnJeIRm/CFmUXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725369629; c=relaxed/simple;
	bh=cLdJ/Bo1M/oU70Oco1Bx/Spn8T+t4KNsJgX5z4vwuYU=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=jAmTOdgDi27hqkbiXSKHOlkB48x1Pf9mjyEjUHLL0dryig9iJms5nFLtKYb6JeZukyUVK1ueFWHIUCX1k5qM8+AdY7mfK740IqbSN7tf7TMH+6qfDVtM4KCGvEBiCary7FULgow+RTII2FIhsbQwvrmlXq+p0UJK9JShtpee478=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=GQiLXW81; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="GQiLXW81"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240903132024euoutp02c3e8b72ce1b3bd3fff86ec5c6bc555f1~xvohPexqM1922619226euoutp02W
	for <iommu@lists.linux.dev>; Tue,  3 Sep 2024 13:20:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240903132024euoutp02c3e8b72ce1b3bd3fff86ec5c6bc555f1~xvohPexqM1922619226euoutp02W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1725369624;
	bh=b3eUhjP/q8xVDSgFAb1R6wktjZ+nfbbg5bdYLi1f8sI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=GQiLXW81lmBjNNRUG7JYlQEY+8BwYpkr0bMHalPWVu75jGJ8EeP5mZnf2XHdJUCcq
	 lLvOZzAsV7hP1aFEEBUfY27YqhQCkZ1hDC8xTPfAzGV2j1Iur5jxzyOx4RyorusWDS
	 thIOnc6it+9lLjyAHpn6Qj6ea6Cl9jl2f8bH/P3U=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240903132024eucas1p13619797f8ffa587ec8fd1e8fde35164b~xvog3ZWDl0865208652eucas1p1i;
	Tue,  3 Sep 2024 13:20:24 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 95.76.09624.81D07D66; Tue,  3
	Sep 2024 14:20:24 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240903132023eucas1p16128f5b09073a01bddff6b4b7bd03ce4~xvogJov8E3189331893eucas1p1o;
	Tue,  3 Sep 2024 13:20:23 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240903132023eusmtrp2630d3411cc9d723ced18a4f4f434ad36~xvogI6Zi93039330393eusmtrp2g;
	Tue,  3 Sep 2024 13:20:23 +0000 (GMT)
X-AuditID: cbfec7f2-bfbff70000002598-92-66d70d184bdf
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 0E.F8.19096.71D07D66; Tue,  3
	Sep 2024 14:20:23 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240903132023eusmtip23725f57a1af6343a1273a5c5c262e453~xvof6KI0g0590805908eusmtip2I;
	Tue,  3 Sep 2024 13:20:23 +0000 (GMT)
Received: from localhost (106.110.32.44) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Tue, 3 Sep 2024 14:20:21 +0100
Date: Tue, 3 Sep 2024 15:20:18 +0200
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
Message-ID: <20240903132018.yi2xuyrp7v3npfmt@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d1e1370a-0714-4da8-b645-f56d83ab0159@linux.intel.com>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOKsWRmVeSWpSXmKPExsWy7djPc7oSvNfTDN5vlrTYPHErm8XElZOZ
	LX59sbDYf/Abq8XMGScYLTpnb2C3WPp2K7vF5V1z2CwOfnjCatFyx9SBy+PJwXlMHmvmrWH0
	2LxCy2PxnpdMHud2nGf32LSqk81j3slAjxebZzJ6fN4k57H1822WAK4oLpuU1JzMstQifbsE
	row3i3kKzgpVfD37l72B8RtfFyMnh4SAicSHacuYuxi5OIQEVjBK9J2YzgjhfGGU+DrpHCuE
	85lRYtml32wwLRc3fmCDSCxnlPj8/SIjXNXy5l4mCGcTo8TCE5+YQVpYBFQkVrQvYAKx2QR0
	JM6/uQMWFxFQl2hq3As2ilngP5PEntN9YAlhgVSJJSs3gDXwCjhIXDsznQXCFpQ4OfMJmM0M
	NGjB7k9AzRxAtrTE8n8cIGFOAWeJ3Q//skOcqijxdfE9Fgi7VuLUlltgx0kIzOaU2NGxASrh
	IrHwSReULSzx6vgWqGYZif8750M1TGaU2P/vAzuEsxoYGo1fmSCqrCVarjxhB7lCQsBR4snN
	CAiTT+LGW0GIO/kkJm2bzgwR5pXoaBOCaFSTWH3vDcsERuVZSD6bheSzWQifLWBkXsUonlpa
	nJueWmyYl1quV5yYW1yal66XnJ+7iRGYtk7/O/5pB+PcVx/1DjEycTAeYpTgYFYS4Y3deDVN
	iDclsbIqtSg/vqg0J7X4EKM0B4uSOK9qinyqkEB6YklqdmpqQWoRTJaJg1OqgSlss+QM6bt+
	msGbz21jkN7NxvmxSSkr4uQkmRn3qg+YXO+7/XhqwJYVD+UF1JvMbOoDNfeGFZvIHUzgCPkW
	6zV1l6NITFXpo0OnLdauCH/y7u6qdtP2FQJVDO5pC/wf5bLqnDw9WXO51Ob6xkmveucyZkV/
	9r1j8u+d6+meiEctYWKPYn+f+frDfrm7ksXE66rzBIJzcg+wek5sFP5bwnLu2+U5v8O6VIX3
	G/F6KjJuUPplG7L0+AZNy6fyjawR0TonM1P5j2wScdqoLMYWI7N10ZINU0y6+MKOxm/9wP2t
	7sXh2hv20fFKzxRykxYmulfPMypbvPgkyw3enGU/TwbOlAt7ovQl/+TFvc4cCUosxRmJhlrM
	RcWJANlxMSbKAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMIsWRmVeSWpSXmKPExsVy+t/xe7rivNfTDLruqVpsnriVzWLiysnM
	Fr++WFjsP/iN1WLmjBOMFp2zN7BbLH27ld3i8q45bBYHPzxhtWi5Y+rA5fHk4DwmjzXz1jB6
	bF6h5bF4z0smj3M7zrN7bFrVyeYx72Sgx4vNMxk9Pm+S89j6+TZLAFeUnk1RfmlJqkJGfnGJ
	rVK0oYWRnqGlhZ6RiaWeobF5rJWRqZK+nU1Kak5mWWqRvl2CXsabxTwFZ4Uqvp79y97A+I2v
	i5GTQ0LAROLixg9sXYxcHEICSxkljnZdZYJIyEhs/HKVFcIWlvhzrQuq6COjxIeOC4wgCSGB
	TYwS2/cbgNgsAioSK9oXgDWzCehInH9zhxnEFhFQl2hq3AvWzCzwn0miZeliFpCEsECqxJKV
	G8AaeAUcJK6dmc4CsWE1k8SfSxOZIRKCEidnPgFrYAaaumD3J6BJHEC2tMTyfxwgYU4BZ4nd
	D/+yQ1yqKPF18T0WCLtW4vPfZ4wTGIVnIZk0C8mkWQiTFjAyr2IUSS0tzk3PLTbSK07MLS7N
	S9dLzs/dxAiM3W3Hfm7Zwbjy1Ue9Q4xMHIyHGCU4mJVEeGM3Xk0T4k1JrKxKLcqPLyrNSS0+
	xGgKDIuJzFKiyfnA5JFXEm9oZmBqaGJmaWBqaWasJM7LduV8mpBAemJJanZqakFqEUwfEwen
	VANT9fST3iEbvnRt8KgR5bJ1nr7h/LoP3wxOsHq+Plzie363b8gjj7iIG8KrehZVTrq74L3F
	sqpSpyNvbVR7RJy05+Y8bfDSLV4oe3+R5w2FHVdXLf9jVL94hbzoLS/jmfrdByTrpjfliR+d
	KeW4a9F7hl6FjTwzQtfPClbN5/21N1PlkI+vgndQtuiuF7NN+t66KtS1tahur5umFsnLw2/d
	5xx1JuXcieKGI5vbGw6f2cc+uSNJd/HN/2yRlsx1k7p+Tq6d72ntpaIsdcDCcr6hwKVM7fyl
	tUEJ5cvlJNRSfa4svsPPJPFbbYvti02LDBy7jU9obtx1U8PrV+fCkvIMmZTz/1+bP5zFG9K4
	xUKJpTgj0VCLuag4EQCUwhYeZgMAAA==
X-CMS-MailID: 20240903132023eucas1p16128f5b09073a01bddff6b4b7bd03ce4
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

On Mon, Sep 02, 2024 at 08:47:21PM +0800, Baolu Lu wrote:
> On 2024/9/2 18:48, Joel Granados wrote:
> >> I definitely expect PRI to work outside PASID and SVA cases, so this
> >> is going in a good direction
> > This touches on a detail (at least in Intel's vtd-io spec) that is not
> > 100% clear to me. Second paragraph of section "3.4.3 Scalable Mode
> > Address Translation" reads:
> > "
> >    ... Scalable-mode context-entries support both requests-without-PASID
> >    and requests-with-PASID. However unlike legacy mode, in scalable-mode,
> >    requests-without-PASID obtain a PASID value from the RID_PASID field of
> >    the scalable-mode context- entry and are processed similarly to
> >    requests-with-PASID.Implementations not supporting RID_PASID capability
> >    (ECAP_REG.RPS is 0b), use a PASID value of 0 to perform address
> >    translation for requests without PASID.
> > "
> > This basically means that a default PASID is used even though the
> > request is without PASID. Right? Therefore "outside PASID" means with
> > the default PASID (at least in Intels case). Right?
> 
> Kind of yes.
> 
> The PCI specification defines the concept of PASID and its role in
> transaction routing. We refer to PCI transactions with a PASID prefix as
> "request-with-PASID" and those without a PASID prefix as "request-
> without-PASID." Consequently, I understand 'outside PASID' to mean
> transactions that do not have a PASID prefix.
> 
> The VT-d specification describes how the IOMMU hardware handles request-
> without-PASID. It uses a reserved PASID for its internal routing and
> handling purposes. If RID_PASID is supported (ECAP_REG.RPS=1), software
> can select its own reserved PASID. Otherwise, the IOMMU hardware will
> use a default value of 0.
> 
Thx for getting back to me. This generates another doubt in my head
regarding the published capabilities from the intel IOMMU Hardware:

So ecap_pasid [1] does not have to be set in scalable-mode. Right? This
allows hardware supporting scalable-mode to reject transactions with
PASID whenever ecap_pasid is *NOT* set; even though internally things
are handled with a PASID. This question is directly related to the two
last patches in the set.5/6 and 6/6.

Best

[1] I use ecap_pasid like in the kernel `ecap_pasid(e)  (e>>40) & 0x1`

-- 

Joel Granados
