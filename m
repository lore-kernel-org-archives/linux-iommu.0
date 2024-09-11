Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580CA170A14
	for <iommu@lists.linux.dev>; Wed, 11 Sep 2024 09:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726048585; cv=none; b=WhIS1ZBlPiVKJ5CsVUiU9Q6awHO0/czw0nUOODLXQ05BPBaiDs1Wl8ig8KrNEnh6qLI3ERVaSUiZhk4O+9IF15AAParncE6uCtFZEcZlJpwEj5Qbh3ae62S2WZh5/u+i4ZsWWjEUaBRSDGqMuT0gt502mYlLU+9ab9h6qxr6tcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726048585; c=relaxed/simple;
	bh=qjEpByA7Sb0I/5DTU4GOC+I5E8r9O5cBqNNoqQO8JqU=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=ZiF6e5UIluOLK7rgOnF8kelbX0LP7RLKNXoENZ2mvSrnH7QhoW7A/m3Mp9/7d1hqE2xeGmshgaznA99nm6bO/iRCNzZU5rMF8YXlivNx9Y3sYDvDG3PbIHzQi/v87Cd8UueS2IQB9ruhksZ1JGNwjb5vgrsqhRCEjofox+Wu3Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=EhHpxbGB; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="EhHpxbGB"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240911095621euoutp0212d986a686339019a314db398dcf8501~0KAo1TqmC0976009760euoutp02C
	for <iommu@lists.linux.dev>; Wed, 11 Sep 2024 09:56:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240911095621euoutp0212d986a686339019a314db398dcf8501~0KAo1TqmC0976009760euoutp02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1726048581;
	bh=7gSIKq38cGh5HnYUHVL1uTkp91XiKw9BT2R8CsE4/L8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=EhHpxbGB29x92ZOyVQDei972Y6vaX4nMmt6Z5I6r5X8ECjzXoCOEuovg4NtJ/s0iW
	 aSXOiOiIAt6t1G55BpbDZs69Zgjogkayxo4sMmBs94MY2T1MXE2XUkBArJSmMJU17i
	 v/8c4sO6e8CHeJViAJlZwXUoB80J2Tebc+jg9RGw=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240911095617eucas1p2caef7baa4ab55c035db99a4ba2299373~0KAlZNYJ50282402824eucas1p2m;
	Wed, 11 Sep 2024 09:56:17 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 26.22.09875.14961E66; Wed, 11
	Sep 2024 10:56:17 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240911095617eucas1p15694fa081b821731195ab83be0d5059a~0KAk4vakW3099330993eucas1p18;
	Wed, 11 Sep 2024 09:56:17 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240911095617eusmtrp28d2c72ca41aec85374693fd2f11c47fb~0KAk38gCq1237312373eusmtrp2K;
	Wed, 11 Sep 2024 09:56:17 +0000 (GMT)
X-AuditID: cbfec7f4-11bff70000002693-1b-66e169412d0c
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 16.87.19096.14961E66; Wed, 11
	Sep 2024 10:56:17 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240911095616eusmtip1b6f37cb2b00a5589c731aec12f50d28f~0KAkkfCrV2760627606eusmtip1G;
	Wed, 11 Sep 2024 09:56:16 +0000 (GMT)
Received: from localhost (106.110.32.44) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Wed, 11 Sep 2024 10:56:16 +0100
Date: Wed, 11 Sep 2024 11:55:44 +0200
From: Joel Granados <j.granados@samsung.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
CC: David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Jason
	Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, Klaus Jensen
	<its@irrelevant.dk>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
Subject: Re: [PATCH 5/6] iommu: init pasid array while doing domain_replace
 and iopf is active
Message-ID: <20240911095544.4ad3u6jxgsdsymhj@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c2e765a8-d935-42db-bd22-c12e7960f2f0@linux.intel.com>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGKsWRmVeSWpSXmKPExsWy7djP87qOmQ/TDLZ/1bTYPHErm8XElZOZ
	LX59sbDYf/Abq8XMGScYLTpnb2C3WPp2K7vF5V1z2CwOfnjCatFyx9SBy+PJwXlMHmvmrWH0
	2LxCy2PxnpdMHud2nGf32LSqk81j3slAjxebZzJ6fN4k57H1822WAK4oLpuU1JzMstQifbsE
	roybW66xFUzkrNh3bwJTA+NW9i5GTg4JAROJEwsOMHYxcnEICaxglGjuPcYMkhAS+MIocfMo
	E0TiM6PE/h/zGGE63hzuhupYzijRvuMoM1zVkQvvWCDaNzNKLDzrDGKzCKhKbLi6hgnEZhPQ
	kTj/5g7YChEBdYmmxr1sIM3MAhuZJOb+OwyWEBZIkJj59wxQAwcHr4CDxNU/YSBhXgFBiZMz
	n4DNZwaas2D3JzaQEmYBaYnl/zhAwpwCzhJ/pzcyQxyqKPF18T0WCLtW4tSWW2DfSAjM55T4
	3rCHDSLhIrH55xMmCFtY4tXxLdBwkZH4v3M+VMNkoPf/fWCHcFYzSixr/ArVYS3RcuUJVIej
	RN/nbrCjJQT4JG68FYQ4lE9i0rbpzBBhXomONiGIajWJ1ffesExgVJ6F5LVZSF6bhfDaAkbm
	VYziqaXFuempxUZ5qeV6xYm5xaV56XrJ+bmbGIFJ6/S/4192MC5/9VHvECMTB+MhRgkOZiUR
	3n67e2lCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeVVT5FOFBNITS1KzU1MLUotgskwcnFINTAr7
	hKez+d3v5Jv4p1fl2pKvS77NNvlTvPBNSYyRu7fhPNmLDNH8ArXrruk2FHvXrH7fKv+Fxf3P
	R+k/vs6pUae3P/vAGVRv+OU6k6ntv5+Hbt3hWcwhni1XvJBb/Kpml8b6v22rXzjabfjws7ZZ
	U0OoUbf4SdKUjfFJP4MFRQx1/L0jV05rcL9o3+1zqy9eLVVhwpnoZpXoXhFPzYNmJ83q5etX
	TuPiX5vBPklt5kEjudLmZumtk8x3ycQunhQeUjjtYn7LDuPLx8zmuWWe4X6w26P731HVjhOW
	U+TXBouaK20R5MxUdNDOZRE3P/Xy4tedLp+klj9y7+l+/yJz/vySxaJf/i92Fbyw4+JTJZbi
	jERDLeai4kQAJpFIyMkDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMIsWRmVeSWpSXmKPExsVy+t/xu7qOmQ/TDO5cZbPYPHErm8XElZOZ
	LX59sbDYf/Abq8XMGScYLTpnb2C3WPp2K7vF5V1z2CwOfnjCatFyx9SBy+PJwXlMHmvmrWH0
	2LxCy2PxnpdMHud2nGf32LSqk81j3slAjxebZzJ6fN4k57H1822WAK4oPZui/NKSVIWM/OIS
	W6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9O5uU1JzMstQifbsEvYybW66xFUzkrNh3bwJTA+NW
	9i5GTg4JAROJN4e7GbsYuTiEBJYySry8sIUVIiEjsfHLVShbWOLPtS42iKKPjBKP1k9kA0kI
	CWxmlPi8ShHEZhFQldhwdQ0TiM0moCNx/s0dZhBbREBdoqlxL1gzs8BGJokb55rAioQFEiRm
	/j0DZHNw8Ao4SFz9EwaxoIlJon3NexaQGl4BQYmTM5+A2cxAQxfs/sQGUs8sIC2x/B8HSJhT
	wFni7/RGZohDFSW+Lr7HAmHXSnz++4xxAqPwLCSTZiGZNAth0gJG5lWMIqmlxbnpucVGesWJ
	ucWleel6yfm5mxiBsbvt2M8tOxhXvvqod4iRiYPxEKMEB7OSCG+/3b00Id6UxMqq1KL8+KLS
	nNTiQ4ymwKCYyCwlmpwPTB55JfGGZgamhiZmlgamlmbGSuK8bFfOpwkJpCeWpGanphakFsH0
	MXFwSjUwhU4QfWresJYhudPm/UppTg/pDQbrjxTa/fkdLe3e1vakIfxJmNq8/JQ2fTv/9s/X
	jm9hC2Sc6nkmP//mBKek4wxrgkJ8v3SpSTxdG7ZCZ4dz0fkt6XFyn/UDE7pfHtBWO+a484wc
	r3qobM7060dfLLtdaN3e9GzLo4dPzO5/bem7yhPzy/Cq4NW/5/7keTB5eqv3796T8jfiNQtb
	7k1Z3iVrVa64nMyqbotyr3nQ/6Uh4eDp1m0/5VyWZmR6JeQKT3jPJvKh7wO/v65S25LiGac+
	snPE3f1VwNQkMd/b1T52w6PHE+QMAhboVj098MjLuy7d48eX1yujfF9csdW13aTemBl05pXv
	mtCHwY+UWIozEg21mIuKEwEDWx2AZgMAAA==
X-CMS-MailID: 20240911095617eucas1p15694fa081b821731195ab83be0d5059a
X-Msg-Generator: CA
X-RootMTR: 20240905033408eucas1p2ad508d4f3377f4daa38f28bf6c3d1118
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240905033408eucas1p2ad508d4f3377f4daa38f28bf6c3d1118
References: <20240904-jag-iopfv8-v1-0-e3549920adf3@samsung.com>
	<20240904-jag-iopfv8-v1-5-e3549920adf3@samsung.com>
	<CGME20240905033408eucas1p2ad508d4f3377f4daa38f28bf6c3d1118@eucas1p2.samsung.com>
	<c2e765a8-d935-42db-bd22-c12e7960f2f0@linux.intel.com>

On Thu, Sep 05, 2024 at 11:30:05AM +0800, Baolu Lu wrote:
> On 9/4/24 9:17 PM, Joel Granados via B4 Relay wrote:
> > From: Joel Granados<j.granados@samsung.com>
> > 
> > iommu_report_device_fault expects a pasid array to have an
> > iommu_attach_handle when a fault is detected.
> 
> The iommu_attach_handle is expected only when an iopf-capable domain is
> attached to the device or PASID. The iommu_report_device_fault() treats
> it as a fault when a fault occurs, but no iopf-capable domain is
> attached.
I don't follow. The way that I read it: if the pasid_array x-array does
not have an iommu_attach_handle indexed by either fault->prm.pasid or
IOMMU_NO_PASID, it will follow the err_bad_iopf and return -EINVAL
(please correct me if I'm wrong). So the iommu_attach_handle is *always*
expected.

Would it be more clear for it to be:
"""
The iommu_report_device_fault function expects the pasid_array x-array
to have an iommu_attach_handle indexed by a PASID. Add one indexed with
IOMMU_NO_PASID when the replacing HWPT has a valid iommufd fault object.
Remove it when we release ownership of the group.
"""

best

-- 

Joel Granados
