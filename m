Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F3F37C
	for <iommu@lists.linux.dev>; Tue,  8 Aug 2023 14:52:04 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230808145202euoutp01818a4bb4a702b47a05a58e860b5800d6~5cAnd8Yeb0551505515euoutp01H
	for <iommu@lists.linux.dev>; Tue,  8 Aug 2023 14:52:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230808145202euoutp01818a4bb4a702b47a05a58e860b5800d6~5cAnd8Yeb0551505515euoutp01H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1691506322;
	bh=6yBkkT9G8GwSC4sc50BVUcZTTbI49C82cIjyOjo/aWI=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=t56ISOnM2yJDM5BLpDGVu5BZS81FQTpTLMDcqG3Ei3sGrRV+BjUkYl3zU1lxdERYN
	 hqJBoytU7REEKtMuawB7ad3x/eB3b6MBX83Z7j47ohNJUNHMHI1iAU09B1N2gvCvm/
	 3yR6Es2JuiNnSmdbA9iObUXWdV/Y2d4Sj2/D1G/0=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20230808145200eucas1p25e8cd98549f23ec7963b280acd5e04d9~5cAk73qmm0596505965eucas1p2J;
	Tue,  8 Aug 2023 14:52:00 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 37.AA.37758.F8652D46; Tue,  8
	Aug 2023 15:51:59 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20230808145159eucas1p10db482dbefd4c50353e69e370c7267af~5cAkhPxKq2474824748eucas1p10;
	Tue,  8 Aug 2023 14:51:59 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20230808145159eusmtrp12284cdc94c49bb858bd9e9c134047bcb~5cAkgg7662855728557eusmtrp1E;
	Tue,  8 Aug 2023 14:51:59 +0000 (GMT)
X-AuditID: cbfec7f5-815ff7000002937e-0d-64d2568fe202
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id A0.84.10549.F8652D46; Tue,  8
	Aug 2023 15:51:59 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20230808145158eusmtip2bd76611f2dd584fbf569f86ac0400ca7~5cAjW-cj_2102721027eusmtip2I;
	Tue,  8 Aug 2023 14:51:58 +0000 (GMT)
Message-ID: <9a31fc21-b5d2-8f2f-0274-9ed43fcfcfbe@samsung.com>
Date: Tue, 8 Aug 2023 16:51:57 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0)
	Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v2 00/10] Refine the locking for dev->iommu_group
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>, Joerg Roedel <joro@8bytes.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>, David Woodhouse
	<dwmw2@infradead.org>, Heiko Stuebner <heiko@sntech.de>,
	iommu@lists.linux.dev, Jernej Skrabec <jernej.skrabec@gmail.com>,
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
	linux-sunxi@lists.linux.dev, Orson Zhai <orsonzhai@gmail.com>, Robin Murphy
	<robin.murphy@arm.com>, Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai
	<wens@csie.org>, Will Deacon <will@kernel.org>, Chunyan Zhang
	<zhang.lyra@gmail.com>, Alex Williamson <alex.williamson@redhat.com>, Lu
	Baolu <baolu.lu@linux.intel.com>
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <ZNJRf4Xp8rY1+iT4@nvidia.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnk+LIzCtJLcpLzFFi42LZduzned3+sEspBu+XmVp8+9/DZvF/7zFG
	i80Tt7JZTFw5mdni/6PXrBa/vlhYPJ+/jtHiyr89jBadszewW2x6fI3V4tOD/8wWU/btYrOY
	/mE2o8XBD09YLZ4/6mSz+HnoPJPFjLbLrBYtd0wtlj/Yxe4g7PHk4DwmjzXz1jB6zG64yOKx
	4dFqVo+ds+6ye2xeoeWxaVUnm8fOh5Ye804GemxeUu/xYvNMRo/e5ndsHu/3XWXzePV1LqPH
	9mvzmAP4o7hsUlJzMstSi/TtErgy7r9/yVZwjKvi8o8FbA2M+zm6GDk5JARMJE496mbuYuTi
	EBJYwSgxfdYCFgjnC6PE3hmbmSCcz4wSW1fvYINpWd/2DKpqOaPEq7e72SGcj4wSF08+YQGp
	4hWwk7h56Ao7iM0ioCIx89kPNoi4oMTJmRA1ogKpEjtuT2AFsYUFXCXuzdwNVsMsIC5x68l8
	JhBbBKj3xIkzYAuYBWaySqz80ssMkmATMJToetsF1MDBwSmgJfHvtyREr7zE9rdzwB6SEPjF
	KbG99RQ7xNkuEs8ampghbGGJV8e3QMVlJE5P7mGBaGhnlFjw+z4ThDOBUaLh+S1GiCpriTvn
	foFtYxbQlFi/Sx/ElBBwlDi+tAzC5JO48VYQ4gY+iUnbpjNDhHklOtqEIGaoScw6vg5u68EL
	l5gnMCrNQgqVWUi+n4Xkm1kIaxcwsqxiFE8tLc5NTy02zkst1ytOzC0uzUvXS87P3cQITKun
	/x3/uoNxxauPeocYmTgYDzFKcDArifDaBl9KEeJNSaysSi3Kjy8qzUktPsQozcGiJM6rbXsy
	WUggPbEkNTs1tSC1CCbLxMEp1cCkeMa9N6PCsVrv05zlzk9316cUTvn6v56n21z8vp+iyZ8t
	gnG57AfX3ry/MOaB74Qp+5zyl3Kb5m/6xHLMNs38qt+0xQYaT/Y0XY9IUD/zaNXTvw8WRO6o
	bH9jsXa3QumGpyorl8T/nObw5OzMiINVPneMPpXt9r7Hw/frT57P9COHfqjpPXXyflOkvXhe
	0knr634zmaKWHS+tkTl7N2KFq1n1wymKbHWFZ6L18i9q/5cOSmizkO+qeiNbsH3dTpm8/0cL
	pNdHsd/o2/CdY7LGNAvGt7cu3i1QYWY7HvFK4veNmhjZJL+txyO2zDPP0Nt+1Cjsqd+XxKQr
	RUm5jJP4p+fqb9U2uz9bp3G9iGiBEktxRqKhFnNRcSIALCs/choEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFKsWRmVeSWpSXmKPExsVy+t/xe7r9YZdSDN6sk7H49r+HzeL/3mOM
	FpsnbmWzmLhyMrPF/0evWS1+fbGweD5/HaPFlX97GC06Z29gt9j0+BqrxacH/5ktpuzbxWYx
	/cNsRouDH56wWjx/1Mlm8fPQeSaLGW2XWS1a7phaLH+wi91B2OPJwXlMHmvmrWH0mN1wkcVj
	w6PVrB47Z91l99i8Qstj06pONo+dDy095p0M9Ni8pN7jxeaZjB69ze/YPN7vu8rm8errXEaP
	7dfmMQfwR+nZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY6hkam8daGZkq6dvZpKTmZJalFunb
	Jehl3H//kq3gGFfF5R8L2BoY93N0MXJySAiYSKxve8bSxcjFISSwlFFi//8+RoiEjMTJaQ2s
	ELawxJ9rXWwQRe8ZJV7u2geW4BWwk7h56Ao7iM0ioCIx89kPNoi4oMTJmU9YQGxRgVSJXw27
	wOqFBVwl7s3cDVbDLCAucevJfCYQWwSo98SJM+wgC5gFZrNKTFi+hQliWwOLxIerT8FOYhMw
	lOh6C3IGBwengJbEv9+SEIPMJLq2djFC2PIS29/OYZ7AKDQLyR2zkOybhaRlFpKWBYwsqxhF
	UkuLc9Nziw31ihNzi0vz0vWS83M3MQITybZjPzfvYJz36qPeIUYmDsZDjBIczEoivLbBl1KE
	eFMSK6tSi/Lji0pzUosPMZoCA2Mis5Rocj4wleWVxBuaGZgamphZGphamhkrifN6FnQkCgmk
	J5akZqemFqQWwfQxcXBKNTCtN/BjfjLt9cN9s9d1RJZzXvlZoZH1qDwtS07/RmXtunMvRK8l
	NvOobnH13fZpa6t6rImlaJWhi2Hd6lXmG30aHX//Wv3tkGna2+A/+zfy7FCx1nl7fCX37f+n
	JOt2vp6pv6Xdej7XozZzmUiHxPn33HNX/9k3284qutDE9Tyj0LH5ZpfF+ac3TDzcvaljo7T/
	nS8McQ+YfmnwceiyFZ8Qi7tt8yPM/69tVOXKz8cPd20R+CFmbhcYYrwh5agf37rJy5sfh3UJ
	SW1ZlddfI313fYzKS/6ymq0nrqydfm6ftKDic/3leUwaIe8P6E9dL/zKdoWW5CuznQeXzPr+
	5ZHKxB7bWzs8t9jvs5q26MAcJZbijERDLeai4kQAtgmfVK0DAAA=
X-CMS-MailID: 20230808145159eucas1p10db482dbefd4c50353e69e370c7267af
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230808123250eucas1p19d12a9ae0e530c123ba625189f593b36
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230808123250eucas1p19d12a9ae0e530c123ba625189f593b36
References: <0-v2-b0417f84403e+11f-iommu_group_locking_jgg@nvidia.com>
	<ZNDpfCoeFxA56ZlU@8bytes.org>
	<CAGXv+5E-f9AteAYkmXYzVDZFSA_royc7-bS5LcrzzuHDnXccwA@mail.gmail.com>
	<CGME20230808123250eucas1p19d12a9ae0e530c123ba625189f593b36@eucas1p1.samsung.com>
	<7483d18e-d06f-53eb-92af-beed50674ab0@samsung.com>
	<ZNI8W0hTXraSi/Ne@nvidia.com>
	<4d56203e-b602-07ee-ab74-2825c110c36d@samsung.com>
	<ZNJCRhGGxS+63Dnr@nvidia.com>
	<bc5d6aa8-e8ca-c896-2f39-af074d55e436@samsung.com>
	<ZNJRf4Xp8rY1+iT4@nvidia.com>

Hi Jason,

On 08.08.2023 16:30, Jason Gunthorpe wrote:
> On Tue, Aug 08, 2023 at 04:02:40PM +0200, Marek Szyprowski wrote:
>> On 08.08.2023 15:25, Jason Gunthorpe wrote:
>>> On Tue, Aug 08, 2023 at 03:08:30PM +0200, Marek Szyprowski wrote:
>>>>> Any of the drivers that use platform device as the iommu_device will
>>>>> have a problem, please try:
>>>>>
>>>>> https://lore.kernel.org/linux-iommu/ZNIz%2FNVLb6WqqvQx@nvidia.com/
>>>> I've checked and it doesn't help in my case. I will soon check why.
>>> Oh, I botched it. Forgot that the iommu_device->dev is the sysfs
>>> handle not the HW device. Maybe this:
>> This fixed the early lockup, but then system hangs again a bit later. It
>> looks that this device lock in __iommu_probe_device() is really
>> problematic,
> Yes, I expected we'd hit something like this - I checked alot of call
> paths but missed these two. The self-probe is sneaky, but here the
> device_lock is held way up the call chain, I just missed it.
>
> The fix is to just annotate that we already hold the lock when calling
> iommu_probe_device(), since we know in those cases that we must be
> holding it:

Great, this fixed the issue. Feel free to add:

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

 > ...

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

