Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3875479C5
	for <iommu@lists.linux.dev>; Tue, 28 Mar 2023 13:37:10 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230328132943euoutp015836dd00875d24e12046cdbe381ab629~QmFxb9qRy1164311643euoutp01c
	for <iommu@lists.linux.dev>; Tue, 28 Mar 2023 13:29:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230328132943euoutp015836dd00875d24e12046cdbe381ab629~QmFxb9qRy1164311643euoutp01c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1680010183;
	bh=X8eOpd3ceegZLqXQwWr+J6qiMBfSK+M39WBdBRfzrpA=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=igknp/uy1XL4JsTQ8e68zHo4eT5yQNgLIuPOIa05SOxU2BDEHiYtyq73pb6ulJXxJ
	 rUEPpnowfWIK2alm26kKNUPARlbiZatxnAWYovuGcLSmfelw7owf8/w9jePbiQp5Te
	 EUq1We865MWpxYohrCSM/rUps+xZruQYZQaza50I=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20230328132943eucas1p1c55709c443357d067f15f8c8353f1220~QmFxBdk5z2053120531eucas1p10;
	Tue, 28 Mar 2023 13:29:43 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 9E.8F.09966.6CBE2246; Tue, 28
	Mar 2023 14:29:42 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20230328132942eucas1p2ac6c07e4af7aed71fdcc94045796fbf6~QmFwwX7Cm2697326973eucas1p2u;
	Tue, 28 Mar 2023 13:29:42 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20230328132942eusmtrp122308ea47dc13896ff25e3f751909fe9~QmFwv2w3D2139221392eusmtrp1G;
	Tue, 28 Mar 2023 13:29:42 +0000 (GMT)
X-AuditID: cbfec7f4-d4fff700000026ee-c6-6422ebc601fa
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id C8.EE.08862.6CBE2246; Tue, 28
	Mar 2023 14:29:42 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20230328132942eusmtip2046826e13c6cd8c94c4ffd7af69df5d9~QmFwQXmjd0526605266eusmtip2g;
	Tue, 28 Mar 2023 13:29:42 +0000 (GMT)
Message-ID: <457de6e2-3b24-efe4-ea44-693770840289@samsung.com>
Date: Tue, 28 Mar 2023 15:29:41 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0)
	Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH v2] iommu/exynos: Fix set_platform_dma_ops() callback
Content-Language: en-US
To: Joerg Roedel <joro@8bytes.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, iommu@lists.linux.dev,
	linux-samsung-soc@vger.kernel.org, Will Deacon <will@kernel.org>, Robin
	Murphy <robin.murphy@arm.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, Lu
	Baolu <baolu.lu@linux.intel.com>
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <ZCLnfrGdyUEuEfO1@8bytes.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJKsWRmVeSWpSXmKPExsWy7djPc7rHXiulGGw9ZGXxYN42NovNE7ey
	Wfz6YmExc8YJRovO2RvYLfa+3spuMeP8PiaLgx+esFq03DF14PR4cnAek8eaeWsYPTat6mTz
	uHNtD5vHvJOBHi82z2T06NuyitHj8yY5j62fb7MEcEZx2aSk5mSWpRbp2yVwZaxafIO54CZL
	xdsmywbGa8xdjJwcEgImEnPe/mPvYuTiEBJYwSgx9dwdJgjnC6PEtKVfGCGcz4wSC//sZ4Fp
	ab02BaplOaPEg1mToZyPjBLHTv9gA6niFbCTOPTqLlgHi4CqxPSJ71kh4oISJ2c+AYuLCqRI
	TJyxgQnEFhbwlNh5bDU7iM0sIC5x68l8sLiIgJLE9c+trCALmAVWMUkc7PkONohNwFCi620X
	2DJOAS2Jg3unMkM0y0tsfzuHGaRBQqCdU6LjbwdQEQeQ4yJxpqsW4gVhiVfHt7BD2DISpyf3
	sEDVM0os+H2fCcKZwCjR8PwWI0SVtcSdc7/ABjELaEqs36UPEXaUuP3wPTPEfD6JG28FIW7g
	k5i0bTpUmFeio00IolpNYtbxdXBrD164xDyBUWkWUrDMQvL+LCTfzELYu4CRZRWjeGppcW56
	arFRXmq5XnFibnFpXrpecn7uJkZg6jr97/iXHYzLX33UO8TIxMF4iFGCg1lJhPf3NaUUId6U
	xMqq1KL8+KLSnNTiQ4zSHCxK4rzatieThQTSE0tSs1NTC1KLYLJMHJxSDUwVZ5yV/ebPd1r0
	8Ne7ovUmWR86FrVd3uR4bPJnn6TC9668O6Na88UPzC+dsetGhPEu1Z+LZtzYtHz/X0v5B211
	C+bv5FONSEspXyv5YEaegS7HeYc4+xSxXJnsOz296twb45/u18p/9nXl/TB1m0ilzXpWXqsu
	Cd7bLMPJ9MlD74FkWsz6xTFfGRV99GaePsmzs2rL9AdSLhf/s3d8LS6U3KmU5/Ve9MW+yL1l
	FzdP3KnCaTBxX/nlG/oO6aJtNfGT/Fx5yxQEdm6x3HFgarEdz2HXgDVrfIJvJXy8cvHvxs7i
	VI7eMNfvum78nlLvU/KN72i3yFbtZbHV/FffnKVxQifY+cPcRYuVZm2dIKPEUpyRaKjFXFSc
	CADs9eUOzAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRmVeSWpSXmKPExsVy+t/xe7rHXiulGJx6oGnxYN42NovNE7ey
	Wfz6YmExc8YJRovO2RvYLfa+3spuMeP8PiaLgx+esFq03DF14PR4cnAek8eaeWsYPTat6mTz
	uHNtD5vHvJOBHi82z2T06NuyitHj8yY5j62fb7MEcEbp2RTll5akKmTkF5fYKkUbWhjpGVpa
	6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp2yXoZaxafIO54CZLxdsmywbGa8xdjJwcEgImEq3X
	prB3MXJxCAksZZS4dvo2G0RCRuLktAZWCFtY4s+1LjaIoveMEs9nvmABSfAK2EkcenUXzGYR
	UJWYPvE9K0RcUOLkzCdgcVGBFImJSy+DDRUW8JTYeWw1O4jNLCAucevJfCYQW0RASeL651ZW
	kAXMAquYJO5/38wMse0mk8Tj/t+MIFVsAoYSXW+7wCZxCmhJHNw7lRlikplE19YuRghbXmL7
	2znMExiFZiE5ZBaShbOQtMxC0rKAkWUVo0hqaXFuem6xoV5xYm5xaV66XnJ+7iZGYLRuO/Zz
	8w7Gea8+6h1iZOJgPMQowcGsJML7+5pSihBvSmJlVWpRfnxRaU5q8SFGU2BoTGSWEk3OB6aL
	vJJ4QzMDU0MTM0sDU0szYyVxXs+CjkQhgfTEktTs1NSC1CKYPiYOTqkGpu2lF74+Wb6lS01p
	e+nUr84y/BVLL9u99+5l2c+81W2rQUf4mcrwwkebOYSTa5t9vt32VPPxOVCittY0XELBoyNC
	LpNvsc+td3Ieej1He7qfbmf9/24T147n134aJgRsex6ssu3bB4Veq1lvq9h6mjZMLJLdPyf0
	1Ez+FTdsT/ssUjrY8WDN46JXD0xD7h1YfNd0zvvJu5lFym6ZGkh27bddbGRWc3575BfN4K2h
	i3mF9E2c+/etMFllw3X4+FxJ9hN+k8OO+d+eNPny9KbF87men1YRULC83zx7xVEDBaWvQuq1
	BZXTxJQW7Myp9S7Tk69ZcyPdceeJb1aWjp62kZkzLwuZPnW5dYVjynGPViWW4oxEQy3mouJE
	AOakXSxfAwAA
X-CMS-MailID: 20230328132942eucas1p2ac6c07e4af7aed71fdcc94045796fbf6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230315232523eucas1p2565ef5954e3b5b451803c6200c8bce32
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230315232523eucas1p2565ef5954e3b5b451803c6200c8bce32
References: <CGME20230315232523eucas1p2565ef5954e3b5b451803c6200c8bce32@eucas1p2.samsung.com>
	<20230315232514.1046589-1-m.szyprowski@samsung.com>
	<ZBnCD7Xc9WCM55ub@ziepe.ca>
	<da174ce4-b922-21d0-62da-b69798a51371@samsung.com>
	<ZBnef7g7GCxogPNz@ziepe.ca>
	<3ca0c680-d651-a2af-978e-fcb4a2057dd0@samsung.com>
	<ZCLnfrGdyUEuEfO1@8bytes.org>

On 28.03.2023 15:11, Joerg Roedel wrote:
> On Fri, Mar 24, 2023 at 09:59:27PM +0100, Marek Szyprowski wrote:
>> Frankly speaking I would like to have a minimal fix (like my $subject
>> patch) applied to v6.3-rcX ASAP and then apply this identity domain
>> support on top of than for -next (6.4). I've checked and your proposed
>> patch works fine in my case, so You can send it as formal patch.
>>
>> Joerg: is that okay for you?
> Agreed, a minimal fix for 6.3 would be great.

Then this v2 is the minimal fix.


Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

