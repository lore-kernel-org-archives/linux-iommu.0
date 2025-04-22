Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D4B15E5AE
	for <iommu@lists.linux.dev>; Tue, 22 Apr 2025 13:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745327244; cv=none; b=Iei1njszkblhzxAhkRpiEFFzLtrHmTln21RAejxaFh3G59xt4xMWP9ELoGdfDYvGwuKJsLAVXAvr4xHe4gkNTj2tD2dfCO2IAcT93/MQyVbux36O9NIbzo2gMIme9qNaLmR5iB9I4NLLlYQHZXyhQgTqi3pZEywx3dF1Gd3Q33M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745327244; c=relaxed/simple;
	bh=VJLmeSsNMWeaEcNgoelTjPuKnngXXE04eXQju+IoPfg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=nxFejM89t4ugph4NQzuQXQ36C/JQCwFoW3B9Ez38joc4+0jUKfdGLhsF99Rho6UfAOPKetsINpPUAYbvai4nZILp9DxJb2z1SpRopZgP3nmUyRUKiOebXnmMFSHt0QxPxD6Fgj9FBDhA5nnt9SQa18nRjAGsn0+MrMnA4gj6XGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ry7Q8P9u; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ry7Q8P9u"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250422130717euoutp02b1218ddf59c3ee7631bf612df0acd324~4peAfSSFD0444904449euoutp02Q
	for <iommu@lists.linux.dev>; Tue, 22 Apr 2025 13:07:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250422130717euoutp02b1218ddf59c3ee7631bf612df0acd324~4peAfSSFD0444904449euoutp02Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1745327237;
	bh=AuWAwp8U5uPdEuLlgxPJObFhrefnFWBR29ZngOtNJuQ=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=ry7Q8P9uVeSBLw4s6+u26QvTqo2ohz/o+HTDzAlHfaLli3XnCpbE1/hemyj237CPa
	 64LswiQ4LRQTSsp7HU8tLHdSNCjJPbNq6gZs/V1MbNswHS1HiNvkkAdK36Eas+Hl8J
	 fgQwSUGjyV8OrsWhqlWTUVCbkshwaRK+5FQjgDkE=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20250422130717eucas1p1d4027fbe4564ab67e51e96f4d7eee159~4peASykxC0443904439eucas1p1g;
	Tue, 22 Apr 2025 13:07:17 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 8A.F2.00837.58497086; Tue, 22
	Apr 2025 14:07:17 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250422130717eucas1p12763a0448b53d9e5a1aedc03c1e050e2~4peABL3Cg0443904439eucas1p1d;
	Tue, 22 Apr 2025 13:07:17 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250422130717eusmtrp1abc677115067bf49d2bc650860989243~4peAApxkj2063120631eusmtrp1s;
	Tue, 22 Apr 2025 13:07:17 +0000 (GMT)
X-AuditID: cbfec7f2-341fe70000000345-65-680794858225
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id D2.5F.19654.48497086; Tue, 22
	Apr 2025 14:07:17 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250422130716eusmtip28397aa51a919f2c8859875e5f03ad93c~4pd-fNp1y1578815788eusmtip2I;
	Tue, 22 Apr 2025 13:07:16 +0000 (GMT)
Message-ID: <d8a87888-a629-4da1-b19f-522838dd59ef@samsung.com>
Date: Tue, 22 Apr 2025 15:07:16 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kernel/dma/mapping.c: Fix warning reported for missing
 prototype
To: Balbir Singh <balbirs@nvidia.com>, iommu@lists.linux.dev
Cc: robin.murphy@arm.com, Christoph Hellwig <hch@lst.de>, kernel test robot
	<lkp@intel.com>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20250422114034.3535515-1-balbirs@nvidia.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sd0wTcRTH/d1d2ytaOArS5wI5R4KJBeJqhBgwiE3UuGIcxFHwbBGKpgUc
	cRSRYQVcoFBkV5FCnCyRaKiBampAcWFDUsVGsaQColHrLofKf583vnnf9/JIXJjLmUjGJiQy
	qgRZPM11I+rbvnbMTsvlKYLS9CKJvsiES6qqWzGJ86NEYk/t4UpaBmycMI60prgGSSua32HS
	3hsFSHrrhYYrzU59z13F2eQWup2Jj01mVIGLtrkp2otv47u/E3tf5DkJDTpDaBFJAjUX7naK
	tMiNFFKXELT96ENs8BFB3akcjA2GELQaizlaxB9WXH39nMcWKhFUleWMSAYRGJ8/JVxdAmoR
	mMvzcRcT1AyosaaM5D3hfoFtmMdTfmC15PNc7EWtB8OtFORibyoUMoaqhrU4tRkMpyyIZRFY
	bCWYi7lUMGgdWq6L+dRC6PrxmMf2+EGD4zzuMgTUAxJ0fXcx1nYEVL/MHGEvsJtqeSxPBvOZ
	LIIVZCAo/WbF2OAkAs1bdjRQIdDd7uS6ToZTAXClKZBNh0NFf9bIJd2hy+HJmnCH0/XncDYt
	gMx0Ids9E3Smy//GtjzsxE8iWjfqLLpRa+pGraP7P7cUEQYkYpLUSjmjDk5g9ojVMqU6KUEu
	jtmlvI7+PI75p+lDIyqyD4qNCCOREQGJ094CZyRPIRRsl+3bz6h2bVUlxTNqI5pEErRIUH4n
	TS6k5LJEJo5hdjOqv1WM5E/UYDG1Hhf36TwOjslcNmd+XfgFfYc3beMznkFRtHIJ43Nnbwi3
	+0iLoHnq0qJnewq7FmyY3XU2omStNcnnS9NqRBD1K1I7gzS+9O3YnXUfXg+Ip9tPSIiFgv2H
	ls/vtaQQF5pNT8JnKrOR0pA1TeXloaeberTXzIrzBt9n6b0KosG8OLKWXzkle1z/K7t1p/M4
	1hFl+RxW3RY8L/r6jn5HjH6se9TR8bKQ+gPLGs1jy1SDoWQcB5frAg80HHub6Z83w/DGy1E2
	aRwS0m3lueIJ/p/uuW9u/574a2PYy5t+QasLH0XrP63cUsu0Jq9T5vACunsPl3p0HNz6pXLA
	lqxfs4Em1ApZ8CxcpZb9Bmq6veKnAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOIsWRmVeSWpSXmKPExsVy+t/xe7qtU9gzDM5/ZrRYMvc4s8XK1UeZ
	LH59sbB41fyIzeLghyesDqwea+atYfRYvOclk8eLzTMZPXbfbGDz6G1+xxbAGqVnU5RfWpKq
	kJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9nk5Kak1mWWqRvl6CXcW7ePuaCPywVN6f+
	YmlgnMzSxcjJISFgIrHh8XX2LkYuDiGBpYwSR869ZYJIyEicnNbACmELS/y51sUGUfSeUeLL
	ionMIAleATuJ04tmgNksAqoSa+43skDEBSVOznwCZosKyEvcvzWDHcQWFgiXWLW7kRHEFhGw
	kWj/vBKsl1kgVqL/1kdGiAW9jBLrlp5gg0iIS9x6Mh/sIjYBQ4mut11gcU4BK4kbfy+zQ9SY
	SXRt7WKEsOUltr+dwzyBUWgWkjtmIRk1C0nLLCQtCxhZVjGKpJYW56bnFhvpFSfmFpfmpesl
	5+duYgTG2LZjP7fsYFz56qPeIUYmDsZDjBIczEoivL/c2DOEeFMSK6tSi/Lji0pzUosPMZoC
	A2Mis5Rocj4wyvNK4g3NDEwNTcwsDUwtzYyVxHnZrpxPExJITyxJzU5NLUgtgulj4uCUamCy
	2cHxtuPqK4mNbZJ3zn0VLn3Hd6zoOK/K7gnda8Kf/z9xjyEt4pRftX5K0mGxtB3n7F49OsPt
	X3Ep5tx6T8mZyhd0L794VXZ9yg8/SdPoyPx93dVN9hru1qKuux/ui5OX2Xowf32Q28JPmw+9
	s/rHorhqZU1D3UbJ103Pkn5NKJmfF5eopHq2OLP3lN8WLsXNNirHd+nlNbx1D7c0XNUTeDz9
	q96Bey4qvmWMq4Wc3ucX6gcdbbvaZsFw7EnTN2t2qYtVml+u1J/wdQjcsK66LTDHZ/7Hlv5E
	FfNJPxUOzGPZelgo8+2HU391wnO0rpVsyCmfnDH/Deu/Cz1H1+yMaZvcMjttb+Pe01fVpkgr
	sRRnJBpqMRcVJwIAXihgOjoDAAA=
X-CMS-MailID: 20250422130717eucas1p12763a0448b53d9e5a1aedc03c1e050e2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250422114059eucas1p1b079010943dc23589a9b8c8da68d5946
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20250422114059eucas1p1b079010943dc23589a9b8c8da68d5946
References: <CGME20250422114059eucas1p1b079010943dc23589a9b8c8da68d5946@eucas1p1.samsung.com>
	<20250422114034.3535515-1-balbirs@nvidia.com>

On 22.04.2025 13:40, Balbir Singh wrote:
> lkp reported a warning about missing prototype for a recent patch.
>
> The kernel-doc style comments are out of sync, move them to the right
> function.
>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Christoph Hellwig <hch@lst.de>
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202504190615.g9fANxHw-lkp@intel.com/
>
> Signed-off-by: Balbir Singh <balbirs@nvidia.com>

Thanks, applied to dma-mapping-fixes branch with reformatted subject.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

