Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E450DEED1
	for <iommu@lists.linux.dev>; Tue,  8 Aug 2023 12:32:58 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230808123251euoutp0197aff98d9b11f66166973e362e021a96~5aHFp3gC40917709177euoutp01b
	for <iommu@lists.linux.dev>; Tue,  8 Aug 2023 12:32:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230808123251euoutp0197aff98d9b11f66166973e362e021a96~5aHFp3gC40917709177euoutp01b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1691497971;
	bh=G2T2PxEZVtl0HYU0BLOU47EoirmQYkZe7nqmhzQk30o=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=fYZpxOfU3tAqcmN8GJoGVop5zhiowy8B/dZy5oiQYQFJ/BuDUSGCytTrtGjPWiyJh
	 Hi0oGcQmAYAMvrriQx+HkvQ75OA6N+kMFWACkhwq57cb5oH4EId24K/6rwSUGn4Hnk
	 ueFph9ynf0BZmh7T6ho6GG4d9jcxN54ywN07vPYo=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20230808123251eucas1p1cce861653703172c7ff65fc948cfdaf8~5aHFWeISC0841408414eucas1p1J;
	Tue,  8 Aug 2023 12:32:51 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 9C.0D.42423.2F532D46; Tue,  8
	Aug 2023 13:32:50 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20230808123250eucas1p19d12a9ae0e530c123ba625189f593b36~5aHE8Svhx0841408414eucas1p1G;
	Tue,  8 Aug 2023 12:32:50 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20230808123250eusmtrp138b7952bca70dd8efc4569e6fe2f7200~5aHE7iOw11004010040eusmtrp1d;
	Tue,  8 Aug 2023 12:32:50 +0000 (GMT)
X-AuditID: cbfec7f2-a3bff7000002a5b7-8f-64d235f216ec
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 38.9B.10549.2F532D46; Tue,  8
	Aug 2023 13:32:50 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20230808123249eusmtip2d92c0df6cf46696ef25aba4b0275b42b~5aHDzSmAy2806028060eusmtip2t;
	Tue,  8 Aug 2023 12:32:49 +0000 (GMT)
Message-ID: <7483d18e-d06f-53eb-92af-beed50674ab0@samsung.com>
Date: Tue, 8 Aug 2023 14:32:48 +0200
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
To: Chen-Yu Tsai <wenst@chromium.org>, Joerg Roedel <joro@8bytes.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Baolin Wang
	<baolin.wang@linux.alibaba.com>, David Woodhouse <dwmw2@infradead.org>,
	Heiko Stuebner <heiko@sntech.de>, iommu@lists.linux.dev, Jernej Skrabec
	<jernej.skrabec@gmail.com>, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev, Orson Zhai
	<orsonzhai@gmail.com>, Robin Murphy <robin.murphy@arm.com>, Samuel Holland
	<samuel@sholland.org>, Chen-Yu Tsai <wens@csie.org>, Will Deacon
	<will@kernel.org>, Chunyan Zhang <zhang.lyra@gmail.com>, Alex Williamson
	<alex.williamson@redhat.com>, Lu Baolu <baolu.lu@linux.intel.com>
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <CAGXv+5E-f9AteAYkmXYzVDZFSA_royc7-bS5LcrzzuHDnXccwA@mail.gmail.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0zTVxTHd/t79MGKPwukN8WE2RinGHmoxLvoyAQkP51GSIyaOcc6+xOJ
	pbqWdrqZrZEFBkKCAmG0Ukim4SFipYK8ZBS31oYgKtQM6TbXFSFdAHlqa7Br+eHGf5/zPefc
	7zknl4eJ8kgJL0uZw6iUMoWUFOCtVu/A5pmEx/K47trtaMFfRCL/XStA5kstJLpUX4ohv+sf
	AvnmEBqrbgJo6E0XQAUGExc1//2EQDPP/Bgq6+4gUcULA0CWF24CjbkKSOTtHeCgH/MGCfS9
	MwHVPuvgfhRGuy1GDt1obAS0QfcIp02u6wTdrv+dS5vrounmhgKSbv/rA9poT6fNV7+jx82V
	gC7OnSTpqW4HSXvmqwB954kRS1v1iWCnnFFkaRlVbOLngpMXHpg5Z6yhZxdGTLgO9IcUAj4P
	UtvgfcMtIsgiqg7A+31xhUAQ4DkAF7scOBvMAjhtqQZvO3KtHsAmagG8Yr+6HEwDODmeTwar
	hFQiHPDOcYOMU+vgz7aflvXV0F7pxoMcQTGwbaRkyTuM2g3/qOxcqsEoMXzqruYEOTygv7x4
	ZVlfwGFn0Y4gk1Q8LJwoXNL5VDqsd3twtiYK5rYYsOBAkPLxYY+vG2fHToFlxlGC5TDosd3m
	srwG9pUW4WxDPoA1r//ksEEJgLqxp8tL74DOB76AHS9gsRHe7IgNIqR2Qds1LYuh8LeJ1ewM
	ofByawXGykL4Q56IfWM91Nua/nO1PHyMlQCpfsVV9Cu216/YRv+/bQ3AG4CY0aizMxl1vJL5
	KkYty1ZrlJkxx09nN4PAV+17Y5tpA1We6ZhewOGBXgB5mDRcaHQPyEVCuezc14zqdIZKo2DU
	vSCSh0vFwk0f2o+LqExZDnOKYc4wqrdZDo8v0XEO94+/PJHnWXXwfdOx17N34IV9yYp7ibo4
	7XppUueXEzVtw3Xx7Z3EoqAxnKha2+r4diHVm7xx5JB+/znlx/7PLDuH0kFB227CdUisPeD4
	ImTYOqn4dYMW9iQcfCejzD06K/rlPb7EKVEeUbdcqy72R24YvhkZK9fsPbWnWJB/d3Cvc6sh
	lc4hFrdW+ZJezUdt27V9Zr7YSGSkhvVHlm9y7St9NbY5QmVKkfWQ0a3zEd8cPVZ5z2lXH3E8
	b3i+h7emvqVWJUnWNI1OSUqnoh4WXRafMODnz5KfxtzaMjR9+0b5+YuqkP0N3rqjwvK114fT
	sioGKbqfTno3q6ssLaUpQ4qrT8riozGVWvYvQcRy9RkEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNKsWRmVeSWpSXmKPExsVy+t/xe7qfTC+lGJzcLW/x7X8Pm8X/vccY
	LTZP3MpmMXHlZGaL/49es1r8+mJh8Xz+OkaLK//2MFp0zt7AbrHp8TVWi08P/jNbTNm3i81i
	+ofZjBYHPzxhtXj+qJPN4ueh80wWM9ous1q03DG1WP5gF7uDsMeTg/OYPNbMW8PoMbvhIovH
	hkerWT12zrrL7rF5hZbHplWdbB47H1p6zDsZ6LF5Sb3Hi80zGT16m9+xebzfd5XN49XXuYwe
	26/NYw7gj9KzKcovLUlVyMgvLrFVija0MNIztLTQMzKx1DM0No+1MjJV0rezSUnNySxLLdK3
	S9DLaDq3mangGF/Ft9sbWBoYz3J3MXJySAiYSDQfe8XYxcjFISSwlFFidvcOFoiEjMTJaQ2s
	ELawxJ9rXWwQRe8ZJX4uaGYGSfAK2Emc//mFHcRmEVCR2H98MRtEXFDi5MwnYINEBVIlfjXs
	AhskLOAqcW/mbrAaZgFxiVtP5jOB2CJA8e/dc8AWMAv8YpE4s/QXM8S2tYwSE29eBetmEzCU
	6HrbBdbNKRAosfLJKxaISWYSXVu7GCFseYnmrbOZJzAKzUJyyCwkC2chaZmFpGUBI8sqRpHU
	0uLc9NxiQ73ixNzi0rx0veT83E2MwFSy7djPzTsY5736qHeIkYmD8RCjBAezkgjvvCfnU4R4
	UxIrq1KL8uOLSnNSiw8xmgJDYyKzlGhyPjCZ5ZXEG5oZmBqamFkamFqaGSuJ83oWdCQKCaQn
	lqRmp6YWpBbB9DFxcEo1MK2t29x7MJj1VnDAZLMLS9P9Nv92/JuqrHH5zw/+lVePb/oXbvuZ
	J09Z8bqhp01m8a0fWzibT23/eCggKmbZ3HOK0ce3T2p/sj7rkucRpk3v8kvbFB5p6gcW9No2
	O7JuLpfat97o4ZE/rX/7X5zqPyullz5px4+7LEsWp+tPvWnu6v2tdlPstdN/hPxr9Brk54TX
	6vgXHbv47oPhtidGUrv+rH1qP0lt5c1fsz0KuW7NPb6hPTFo+rIfx74vklH8tMNV7zLjtyqB
	vNI6lc2rz8+ZUWuuZbX1v8GWV0pnw3L8bgS+b3pfZVvC8LCKr6mg933frpvmV3/w7/Eqv/D7
	ZvRc+3+B3cdPRlqw/wwVXJyjxFKckWioxVxUnAgAXSaLNa4DAAA=
X-CMS-MailID: 20230808123250eucas1p19d12a9ae0e530c123ba625189f593b36
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

Hi,

On 08.08.2023 12:31, Chen-Yu Tsai wrote:
> Hi,
>
> On Mon, Aug 7, 2023 at 8:54 PM Joerg Roedel <joro@8bytes.org> wrote:
>> On Mon, Jul 31, 2023 at 02:50:23PM -0300, Jason Gunthorpe wrote:
>>> Jason Gunthorpe (10):
>>>    iommu: Remove useless group refcounting
>>>    iommu: Add a lockdep assertion for remaining dev->iommu_group reads
>>>    iommu: Add generic_single_device_group()
>>>    iommu/sun50i: Convert to generic_single_device_group()
>>>    iommu/sprd: Convert to generic_single_device_group()
>>>    iommu/rockchip: Convert to generic_single_device_group()
>>>    iommu/ipmmu-vmsa: Convert to generic_single_device_group()
>>>    iommu/omap: Convert to generic_single_device_group()
>>>    iommu: Complete the locking for dev->iommu_group
>>>    iommu/intel: Fix missing locking for show_device_domain_translation()
>>>
>>>   drivers/iommu/intel/debugfs.c  |  34 ++++----
>>>   drivers/iommu/iommu.c          | 155 +++++++++++++++++++++------------
>>>   drivers/iommu/ipmmu-vmsa.c     |  22 ++---
>>>   drivers/iommu/omap-iommu.c     |  30 +------
>>>   drivers/iommu/omap-iommu.h     |   2 +-
>>>   drivers/iommu/rockchip-iommu.c |  22 +----
>>>   drivers/iommu/sprd-iommu.c     |  24 +----
>>>   drivers/iommu/sun50i-iommu.c   |  29 ++----
>>>   include/linux/iommu.h          |   3 +
>>>   9 files changed, 138 insertions(+), 183 deletions(-)
>> Applied, thanks for the nice cleanup!
> This series seems to cause a hung task during boot on MediaTek platforms.
> It hangs with next-20230808. Reverting the 10 commits from this series
> makes the system boot up again.

I confirm that next-20230808 is broken on ARM 32bit based Exynos boards 
too. Boards lock up very early during boot. I will try to investigate 
this soon.


Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

