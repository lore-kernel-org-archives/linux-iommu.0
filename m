Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD5B125D8
	for <iommu@lists.linux.dev>; Tue,  8 Aug 2023 14:02:45 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230808140243euoutp01708897368c3eda3bc42d1ca94e8bd3e3~5bVjXNXRv1691316913euoutp01E
	for <iommu@lists.linux.dev>; Tue,  8 Aug 2023 14:02:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230808140243euoutp01708897368c3eda3bc42d1ca94e8bd3e3~5bVjXNXRv1691316913euoutp01E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1691503363;
	bh=R6c8tltZ0FO59uKXwgmONFbNQg0cDEH9mkfGy4aZvWQ=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=lOng1TJll/w2N8L8xrB5v1+2uJ/gY+DigODOQtBOEvyh31l8rbSfVATSLLoQnfhmx
	 sFZ807S+qJwX7e5dyxYjuXHb/bfzkOg++hvM/QSslF9yyChatYo+uum404X7oSmjHs
	 x8JuR1IGS94K9zq7xQEhIKBIC1UibCVrFkBmgJmA=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20230808140242eucas1p18de32ec65225255ab2783ef10c292afd~5bVi-qM4J0300603006eucas1p1p;
	Tue,  8 Aug 2023 14:02:42 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 1F.7F.37758.20B42D46; Tue,  8
	Aug 2023 15:02:42 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20230808140242eucas1p20b35b3e887dff951ec9024d58a141f22~5bVicFzZy1553915539eucas1p2C;
	Tue,  8 Aug 2023 14:02:42 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20230808140242eusmtrp2da747abb85da603d36eae2356329fbdd~5bVibV38z2196421964eusmtrp2S;
	Tue,  8 Aug 2023 14:02:42 +0000 (GMT)
X-AuditID: cbfec7f5-7ffff7000002937e-cf-64d24b024587
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id BE.0C.10549.20B42D46; Tue,  8
	Aug 2023 15:02:42 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20230808140241eusmtip1a7329f247b774864cd7788300319f6b8~5bVhQxu6Z2434324343eusmtip16;
	Tue,  8 Aug 2023 14:02:41 +0000 (GMT)
Message-ID: <bc5d6aa8-e8ca-c896-2f39-af074d55e436@samsung.com>
Date: Tue, 8 Aug 2023 16:02:40 +0200
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
In-Reply-To: <ZNJCRhGGxS+63Dnr@nvidia.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sf0wTZxj2u7tej0rxLJB+YS5uhWzKIo6p8xMc+6XzUNl0ixkxZrajt0IG
	RVvwBzMZGcIoHYpTgV6xECMR0FADwgRBpSFUBMYGA0HcRCwrAxTLCgmF2Xm9/eC/532f9/me
	533zUbgsmwyhkrRprE6rSlaQEqK+ba57DbajR/26eXAdmvV+RyJvcxtAtafqSHSq8jSOvCMT
	IuRxI+QsrQbol2dNABnMV8So5lG/CE0Pe3F05kYjiYqemgFqeeoQIeeIgURztm4MFef0itDx
	+xvQxeFG8TuBjKPFgjGXLZcBY878mWCujFwSMQ3cr2KmtiKcqakykEzDw02MpX03U3vha2as
	1gSY/KwnJDN1o49kxmfOAeaHfgu+a9leyWY1m5x0iNWtjVFKEl2TWfiB+YAjc/PbM4HLPw9Q
	FKTXQxsPJZSMrgDQeHpKLBRuAJ0ld4FQ/AnggKUMywN+PkVTh4EUiIsAcsYOEU/IaBeAvV0H
	eSylY+AlcyHJY4IOgzdzi0mhvxy2mxwEj4NpFl4bKvBpA+mt8DfTdd8MTsvhPUepzyzoufb2
	7U5fJJw2iWClOx/nCZKOhHmP83wCPzoccjkTQBCvhFl1ZpwXQHraD47Z3IQQewusbzaJBBwI
	x+1XxQJeAb0NvBsv+BbAsvkH/xQFAGY67wFhKhre/9FD8ifD6dXQ2rhWuN670F5+SIABcODx
	ciFDAPy+vggX2lKYmyMT3ngFcvbq/1xbfurBC4CCW3QWbtH63KJtuP9tywBRBeRsuj5Fw+rX
	adnDEXpVij5dq4lISE2pAc9/ascz+8w1UDHuirABjAI2AClcESS1OLrVMqladTSD1aXu16Un
	s3obeIEiFHLpa2+1J8hojSqN/ZJlD7C6f1mM8gvJxDSewnbJCefWWPlUEnf2j8EPK06unhmM
	PDw5PSTf/7K23BiVX+k2+3eV5s6+OfSNznrkvbePrkq75X+yeJ8hu1GsPZ7bmm1VZrjiH0Wv
	OXFnSVwRsTJk9tyCf0DY5k+OrfoiZiwW6951fcl8rKkrrnyiNHp698LnnSkKZwKhJu6abn5Q
	/7GsJcqoD/b2LVW2bhTFP3BuV+av8HYaIsPOT3aNng2tijr2YmjQRz2hD1M3jep33on/3fz+
	WLbTcjCjeR+G9jrXBy8s3TZojfDMwD3aV/uUo5+BNzx9MTvtLwF1df9fsg3xA7q6wh0mxrgx
	8UmJioorSdO0WZu+uvXp8JnWLb0KQp+oigzHdXrV31LeCC0YBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFKsWRmVeSWpSXmKPExsVy+t/xu7pM3pdSDF6tErT49r+HzeL/3mOM
	FpsnbmWzmLhyMrPF/0evWS1+fbGweD5/HaPFlX97GC06Z29gt9j0+BqrxacH/5ktpuzbxWYx
	/cNsRouDH56wWjx/1Mlm8fPQeSaLGW2XWS1a7phaLH+wi91B2OPJwXlMHmvmrWH0mN1wkcVj
	w6PVrB47Z91l99i8Qstj06pONo+dDy095p0M9Ni8pN7jxeaZjB69ze/YPN7vu8rm8errXEaP
	7dfmMQfwR+nZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY6hkam8daGZkq6dvZpKTmZJalFunb
	JehlfHzTzFzwm6/i52+vBsaPPF2MnBwSAiYSe053snUxcnEICSxllPhztZ8ZIiEjcXJaAyuE
	LSzx51oXVNF7Rompc8+zgSR4BewkVs+eBmazCKhI7O+YARUXlDg58wkLiC0qkCrxq2EX2CBh
	AVeJezN3g9UwC4hL3HoynwnEFgHqPXHiDDvIAmaB2awSE5ZvYYLYtppZ4srvdnaQKjYBQ4mu
	t11g3ZwCWhKz2l4zQkwyk+ja2gVly0s0b53NPIFRaBaSQ2YhWTgLScssJC0LGFlWMYqklhbn
	pucWG+oVJ+YWl+al6yXn525iBCaSbcd+bt7BOO/VR71DjEwcjIcYJTiYlUR45z05nyLEm5JY
	WZValB9fVJqTWnyI0RQYGhOZpUST84GpLK8k3tDMwNTQxMzSwNTSzFhJnNezoCNRSCA9sSQ1
	OzW1ILUIpo+Jg1OqgalR7ouT27Pd65XiTGe6eHhcnB44wSBwDuO8LpG5y8zCbALqvMzKG6W1
	ubcs4q+bP/m21LcA9mPn7n55f7kn0aI0LPz0SVlu5+7r2bm7GbPf9Wgu/VZt1lsXdHzXE464
	Xt7r2wXWr/7Qofy5+mDYV07t/G23zrs1PxP+X/fwzmchVj6P/9JfBXJleByL1s5N4e83To7Y
	dVL9lNbZlGchiX1bTyeqJXxQZ3DfOJfvQ+tkW9HKddeSOktYn5zuPrPE2T3Xwupe+aWtOpua
	pxSYvP1b9fOLeVZitoFqDvek5Qkz3/+5uW3i9ldb+rbqqd+r0rG6JR88z6Vea8KS6w9dJ3Ae
	eDUxpMwoiOPp5IKZHkosxRmJhlrMRcWJAJvYRYatAwAA
X-CMS-MailID: 20230808140242eucas1p20b35b3e887dff951ec9024d58a141f22
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

Hi Jason,

On 08.08.2023 15:25, Jason Gunthorpe wrote:
> On Tue, Aug 08, 2023 at 03:08:30PM +0200, Marek Szyprowski wrote:
>>> Any of the drivers that use platform device as the iommu_device will
>>> have a problem, please try:
>>>
>>> https://lore.kernel.org/linux-iommu/ZNIz%2FNVLb6WqqvQx@nvidia.com/
>> I've checked and it doesn't help in my case. I will soon check why.
> Oh, I botched it. Forgot that the iommu_device->dev is the sysfs
> handle not the HW device. Maybe this:

This fixed the early lockup, but then system hangs again a bit later. It 
looks that this device lock in __iommu_probe_device() is really 
problematic, because __iommu_probe_device() is then called during the 
iommu 'client device' probe on the probed device. Here is a complete 
call stack:

  unwind_backtrace from show_stack+0x10/0x14
  show_stack from dump_stack_lvl+0x58/0x70
  dump_stack_lvl from __iommu_probe_device+0x3d8/0x4b8
  __iommu_probe_device from iommu_probe_device+0x10/0x40
  iommu_probe_device from of_iommu_configure+0xf8/0x1c8
  of_iommu_configure from of_dma_configure_id+0x188/0x450
  of_dma_configure_id from platform_dma_configure+0x24/0x60
  platform_dma_configure from really_probe+0xac/0x3d4
  really_probe from __driver_probe_device+0xa0/0x1e8
  __driver_probe_device from driver_probe_device+0x30/0xd0
  driver_probe_device from __driver_attach+0x10c/0x190
  __driver_attach from bus_for_each_dev+0x60/0xb4
  bus_for_each_dev from bus_add_driver+0xe0/0x208
  bus_add_driver from driver_register+0x7c/0x118
  driver_register from exynos_drm_init+0xe0/0x14c
  exynos_drm_init from do_one_initcall+0x6c/0x318
  do_one_initcall from kernel_init_freeable+0x1c4/0x214
  kernel_init_freeable from kernel_init+0x18/0x12c
  kernel_init from ret_from_fork+0x14/0x2c

Any ideas?

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

