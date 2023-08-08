Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7AE1118B
	for <iommu@lists.linux.dev>; Tue,  8 Aug 2023 13:08:35 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230808130833euoutp01626f2c420105b9184245aeb1ca826cc1~5amQssWHt2061220612euoutp01B
	for <iommu@lists.linux.dev>; Tue,  8 Aug 2023 13:08:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230808130833euoutp01626f2c420105b9184245aeb1ca826cc1~5amQssWHt2061220612euoutp01B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1691500113;
	bh=+y/qt4HK5xdtRnacVh6aBBBKtUVBJA/3594jbkBRLjI=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=XqXzBL+H0nNEwGhA8nIbX2IJaJ5ZviKy8O4IvhPRsqtABua7KV5hBRUSB86sDqvqA
	 OzKM8U5mIKLZJjQP/T2Fpcw2UMDSXoZDe+hE+UIM6KmyBnVibZcDUAibYjEcd153aZ
	 J+RnvJM9h0OWRgVohoJkeul8fr7a8VvXFReC0WU8=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20230808130832eucas1p2b8ef2df5509731d6e148498fcff05079~5amQFBX_x1961819618eucas1p2U;
	Tue,  8 Aug 2023 13:08:32 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 44.03.37758.05E32D46; Tue,  8
	Aug 2023 14:08:32 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20230808130832eucas1p20d46ed1c49a271e16b24baf3bd985372~5amPobM8O1961819618eucas1p2Q;
	Tue,  8 Aug 2023 13:08:32 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20230808130832eusmtrp153f423b207cd1258468b68351484c440~5amPnoNzx3194031940eusmtrp1v;
	Tue,  8 Aug 2023 13:08:32 +0000 (GMT)
X-AuditID: cbfec7f5-7ffff7000002937e-7d-64d23e503698
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id C5.41.14344.05E32D46; Tue,  8
	Aug 2023 14:08:32 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20230808130831eusmtip153eba0215b08b89df3ce0bf6b61402d3~5amOaxpv_2255922559eusmtip1x;
	Tue,  8 Aug 2023 13:08:31 +0000 (GMT)
Message-ID: <4d56203e-b602-07ee-ab74-2825c110c36d@samsung.com>
Date: Tue, 8 Aug 2023 15:08:30 +0200
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
In-Reply-To: <ZNI8W0hTXraSi/Ne@nvidia.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0xTVxjAc3pvb1uSskth4cgIm51jiA4kuOQwHbJEl+ucgSVbzDQRq72D
	brSaVkA3hwUmj6IJ9RHWFkqNgsCYEqry8lGK0mKxjIfIGBPFTqSkSBWYvOflzo3/ft93zu97
	nBw+JjpGBPFlioO0UiFJERM++NXW6Y4PEmK7pOtOlkaiqcXjBFq83gqQWXuFQNrKUxhaHBrl
	opkJhIZLLwLUs3ANoHxDDQ/VPu7loucPFzF0+kYjgYrGDQA1j7u4aHgon0DT1g4O+jmnm4t+
	GvgQXXjYyIvzp1zNRg5VbawGlEHdiVM1Q79wqQb9nzzKXBFO1VblE1TDoxjK2PYFZT5/lHpq
	1gHqRPYYQT27cY+g3JMlgKrrNWIJb+z02SilU2RptDIydo9PckH5FOfAvN8hy0gmUIM6Xw0Q
	8CG5HnqePMEYFpEVAM6/pDTA5xVPAPg05wHOBi8AfNlr4bw2xs4P8ljjAoB2N2QveQGsn/Is
	lRKSsTC7uJirAXw+Tq6C9vFENu0H23QunOE3SRrW/1HIZdif3AIf6JoIhjEyEPa7Spd6BTCq
	vZ3H1MdIHRdWTpxYqk+QUVDj0SwJAjIcTnrLASu/DbOvGDBGgOSUAD4a/Ytgp94M5+8YAMv+
	0G27zGM5GDpOHcdZIRdA0+wghw0KAVQP9/9rbIADzhmCWQcjV8NLjZEMQvITaCtLY9EX9nn8
	2Bl84cmrRRibFsK8HBFbIxTqbRf/69r8WxdWCMT6Zc+iX7a+ftk2+v/bmgBeBQLpVJU8iVZF
	K+j0CJVErkpVJEXs2y+vBa9+qmPBNlkPKtzeCCvg8IEVQD4mDhAaXR1SkVAqOfw9rdyfqExN
	oVVW8BYfFwcK13zctk9EJkkO0t/R9AFa+fqUwxcEqTmSgtoIc8HtIFOY+o7nmyPvl9+slDi0
	XSH2F0PWooD1lmpHS9a3h3qaM6ML04NXy3+Nj9nemSjTBx+pn9jqDA0B0dNbSvt+NKIV7dPv
	9qyQzu6++zhszvuc2OTotO8dKHuWcPR+etZH1ttFwpXygPn+sry0DZU/yOZMrXFWi1EWdnMs
	1FCHDm8tOUecUZicLbvd6+5l7Tj7+477tl0lTXOfSp0120ec10S3FGZLQVxKYl5IRtXOzO6V
	wxszBMENuTOXvvT9elNL8mfihqiY0yPv/d3UWhN/a0Q06P1qz+W7xdtaRnNjUXea/+e6Y+/g
	Mm1H29pdUrg3Pm5zxoJ2FmtHa/rEuCpZEhWOKVWSfwDnkT1TGAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFKsWRmVeSWpSXmKPExsVy+t/xu7oBdpdSDO585LH49r+HzeL/3mOM
	FpsnbmWzmLhyMrPF/0evWS1+fbGweD5/HaPFlX97GC06Z29gt9j0+BqrxacH/5ktpuzbxWYx
	/cNsRouDH56wWjx/1Mlm8fPQeSaLGW2XWS1a7phaLH+wi91B2OPJwXlMHmvmrWH0mN1wkcVj
	w6PVrB47Z91l99i8Qstj06pONo+dDy095p0M9Ni8pN7jxeaZjB69ze/YPN7vu8rm8errXEaP
	7dfmMQfwR+nZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY6hkam8daGZkq6dvZpKTmZJalFunb
	JehldC/7xlTwV7DiwMtGxgbG7XxdjJwcEgImEu+W3GfvYuTiEBJYyijRsucHM0RCRuLktAZW
	CFtY4s+1LjaIoveMElvbpjOCJHgF7CSa58wBKuLgYBFQkTjxIR4iLChxcuYTFhBbVCBV4lfD
	LrA5wgKuEvdm7mYDsZkFxCVuPZnPBGKLgLSeOAN2BLPAbFaJCcu3MEEsu8YkcXn3fbBuNgFD
	ia63XWDdnAJaEl8/LmOEmGQm0bW1C8qWl2jeOpt5AqPQLCSHzEKycBaSlllIWhYwsqxiFEkt
	Lc5Nzy020itOzC0uzUvXS87P3cQITCTbjv3csoNx5auPeocYmTgYDzFKcDArifDOe3I+RYg3
	JbGyKrUoP76oNCe1+BCjKTAwJjJLiSbnA1NZXkm8oZmBqaGJmaWBqaWZsZI4r2dBR6KQQHpi
	SWp2ampBahFMHxMHp1QD02rxoO1M+/pldO9qLuLzOKtxaxN3g9uiPDcrIZZdYo21MxzOCZ+L
	evFH4vcOg3RRJp4ZOZ9/bVwvpTXt8EFm9k7Dn/7yaWk3pwgtPSb+yjPAv/FgwE/pC94ddn2z
	DLIPqDS9263Fd2RzUYvNBgXuFRsnvG3+/PCEy+FFv2RSBFZJTLPm3Kd58tUXRhF9I1dl0fPb
	q1dxlEmUXH3p2tEslfk+dV0u1/q0q2/e27luudFYrDV3gmGO7mTrHaZr8vKvO59R3f7//vvY
	ledS0h+6Vh7eY+j3KbnSu9T6gKbnK7VNdzfGPzvLtMu4YN6uryscgpVXJ32b39Zscqy28X62
	QMgX8xK2mi++c/KOnlu8WYmlOCPRUIu5qDgRAIXY7BytAwAA
X-CMS-MailID: 20230808130832eucas1p20d46ed1c49a271e16b24baf3bd985372
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

Hi Jason,

On 08.08.2023 15:00, Jason Gunthorpe wrote:
> On Tue, Aug 08, 2023 at 02:32:48PM +0200, Marek Szyprowski wrote:
>> On 08.08.2023 12:31, Chen-Yu Tsai wrote:
>>> On Mon, Aug 7, 2023 at 8:54 PM Joerg Roedel <joro@8bytes.org> wrote:
>>>> On Mon, Jul 31, 2023 at 02:50:23PM -0300, Jason Gunthorpe wrote:
>>>>> Jason Gunthorpe (10):
>>>>>     iommu: Remove useless group refcounting
>>>>>     iommu: Add a lockdep assertion for remaining dev->iommu_group reads
>>>>>     iommu: Add generic_single_device_group()
>>>>>     iommu/sun50i: Convert to generic_single_device_group()
>>>>>     iommu/sprd: Convert to generic_single_device_group()
>>>>>     iommu/rockchip: Convert to generic_single_device_group()
>>>>>     iommu/ipmmu-vmsa: Convert to generic_single_device_group()
>>>>>     iommu/omap: Convert to generic_single_device_group()
>>>>>     iommu: Complete the locking for dev->iommu_group
>>>>>     iommu/intel: Fix missing locking for show_device_domain_translation()
>>>>>
>>>>>    drivers/iommu/intel/debugfs.c  |  34 ++++----
>>>>>    drivers/iommu/iommu.c          | 155 +++++++++++++++++++++------------
>>>>>    drivers/iommu/ipmmu-vmsa.c     |  22 ++---
>>>>>    drivers/iommu/omap-iommu.c     |  30 +------
>>>>>    drivers/iommu/omap-iommu.h     |   2 +-
>>>>>    drivers/iommu/rockchip-iommu.c |  22 +----
>>>>>    drivers/iommu/sprd-iommu.c     |  24 +----
>>>>>    drivers/iommu/sun50i-iommu.c   |  29 ++----
>>>>>    include/linux/iommu.h          |   3 +
>>>>>    9 files changed, 138 insertions(+), 183 deletions(-)
>>>> Applied, thanks for the nice cleanup!
>>> This series seems to cause a hung task during boot on MediaTek platforms.
>>> It hangs with next-20230808. Reverting the 10 commits from this series
>>> makes the system boot up again.
>> I confirm that next-20230808 is broken on ARM 32bit based Exynos boards
>> too. Boards lock up very early during boot. I will try to investigate
>> this soon.
> Any of the drivers that use platform device as the iommu_device will
> have a problem, please try:
>
> https://lore.kernel.org/linux-iommu/ZNIz%2FNVLb6WqqvQx@nvidia.com/

I've checked and it doesn't help in my case. I will soon check why.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

