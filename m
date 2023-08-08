Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDDA1097B
	for <iommu@lists.linux.dev>; Tue,  8 Aug 2023 13:09:57 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230808130033euoutp022342d6a85a5ee5dd0b899d56ee829f35~5afR4Q9VP0728507285euoutp02a
	for <iommu@lists.linux.dev>; Tue,  8 Aug 2023 13:00:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230808130033euoutp022342d6a85a5ee5dd0b899d56ee829f35~5afR4Q9VP0728507285euoutp02a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1691499633;
	bh=oqhCqrszph4k9DDqxvhkk/JXqjWX+Un/bQV5mgsVh44=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=CjfAPH7g4c1ifVeKyx6C/t5cYZf5Qj2FurKB2ghFaEZbwTPIJt6NUEpIHVof/uGk7
	 ep94FupbEKSu0+5mTnUdXLp1DMCOlivMsM/1f2zk9q7Za2x+vg2EQHGfD6rc5/zA9D
	 IsAQrBILU6Dj/6g9LdhmfYr/r6i2vCZpDT5jKJXQ=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20230808130033eucas1p20aaa168211a8e88610b70d6bbeed65b2~5afRlfqiQ1362113621eucas1p2T;
	Tue,  8 Aug 2023 13:00:33 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 55.01.37758.17C32D46; Tue,  8
	Aug 2023 14:00:33 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20230808130032eucas1p1b0f2d07f110f9913b30019b12e1d2841~5afRJbbrD0400304003eucas1p1h;
	Tue,  8 Aug 2023 13:00:32 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20230808130032eusmtrp2e43a45b06bf8a2d2c65314ee23de87ab~5afRIlcsv1945619456eusmtrp2d;
	Tue,  8 Aug 2023 13:00:32 +0000 (GMT)
X-AuditID: cbfec7f5-815ff7000002937e-7f-64d23c71dfda
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 9A.CF.14344.07C32D46; Tue,  8
	Aug 2023 14:00:32 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20230808130031eusmtip1c1b75b1c727aa9181524b4e5b9ee65a6~5afP7fmQA2432624326eusmtip1P;
	Tue,  8 Aug 2023 13:00:31 +0000 (GMT)
Message-ID: <3f4f33fc-ea0b-f992-35bb-1907d2b6ded5@samsung.com>
Date: Tue, 8 Aug 2023 15:00:30 +0200
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
From: Marek Szyprowski <m.szyprowski@samsung.com>
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
In-Reply-To: <7483d18e-d06f-53eb-92af-beed50674ab0@samsung.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sf0xTVxjNfe/19bWz+CwoNwy30UwRpyDR4W1ksk3d3hJNXMZcIn+MIi8t
	WUFoAX+Pig7kjWVUTSottMQ4RMacgiBQIVIF0kFgIhgUVKzdql2YaKusVOkoDzf+O+d8537f
	d75cCpd+R0ZQGVm5rCZLoZaRYqKpy9e3OidxIH0Nx4WjF4FSEgXaugBq0DeSSH/uBI4Cjr8E
	aMqLkMtyHqDB6SsAlZguCFH9w1sC9GwsgKOT7a0kMkyYAOqYcAqQy1FCIp+tH0Onim4K0NHR
	99HZsVbhh6GMs8OMMXXmOsCYdDcI5oLjZwHTYrwrZBpqVjL1tSUk0/JAzpjtnzMNZwqYRw3l
	gPnhyN8k86R9iGTczysBc/mWGd++cKc4MZ1VZ+SzmriNqWKVY/w0mX0xau/tlitAB55EckBE
	QXod7D7nwYJYStcA6JjcxwHxDPYCWGGrBDzxANjuLwKvXxjG/ARfOAugv6gQ48lTALnH/lmX
	hN4Iq9v+EHKAogj6Xfhn4XJeXgTt5U4iiBfTLGweKRMEcSi9Bd4rt5JBjNPh8I7TMrsSScdD
	bpyb1cNmPJPfV8x5XhDQWrohiEV0EvQU+4S8/jY80mjCg/tAeloEJ4eDA6gZshn2eNbzAUKh
	u/uSkMeRMNBiwXh/MYBV/vtzpAxAnevOXOQNcLRvigw2wukY+GtrHC9/BHtrH5J8/xA4PL6I
	3yEEHm8y4LwsgceKpLx7OTR2n/9vbMfvA3gZkBnnXcU4L71xXhrj/3OrAFELwtk8baaS1a7N
	YvfEahWZ2rwsZeyu3Zn1YOan9kx3P28GNe6nsTaAUcAGIIXLwiRmZ3+6VJKu2Lef1ez+WpOn
	ZrU28CZFyMIl731g3yWllYpc9huWzWY1r6sYJYrQYceG9m839Bx+ubff+7j62pfFyZg/O3aZ
	Vf0TZz2IGx6wvavGEk4j8cFVInDSIyQ/WXJA4KubyD+VmlL/zyPLishrvXkm8VR1UkKc/Iut
	m3/0pkUUdBRWf5WxXiqKPyp3F1hHU5Q7lUNpauvgkqSK4dTFy9bZIjb55WjLL4PbVPkpbTE1
	yas/U9g/Di1/Y8HSqJzMhE364zFdN5RvDfhMpZ2qiaW43ly5R2+2uP1Vh6JXrO3MXqB8Z9je
	lyjKWbjDU0geuG9UXXQ1sSOBkShV4qTrpnhrGBG9Ro1yvZdUVqwz5vL15Kug77fDn95t1029
	+jatV9vanBRCy6Mbm3dYVTJCq1LEr8Q1WsW/6zHNBhgEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJKsWRmVeSWpSXmKPExsVy+t/xu7oFNpdSDFq/GVl8+9/DZvF/7zFG
	i80Tt7JZTFw5mdni/6PXrBa/vlhYPJ+/jtHiyr89jBadszewW2x6fI3V4tOD/8wWU/btYrOY
	/mE2o8XBD09YLZ4/6mSz+HnoPJPFjLbLrBYtd0wtlj/Yxe4g7PHk4DwmjzXz1jB6zG64yOKx
	4dFqVo+ds+6ye2xeoeWxaVUnm8fOh5Ye804GemxeUu/xYvNMRo/e5ndsHu/3XWXzePV1LqPH
	9mvzmAP4o/RsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOtjEyV9O1sUlJzMstSi/Tt
	EvQyHr1dxFawUbHi5s49jA2M72W6GDk5JARMJKY/+M3SxcjFISSwlFFi2+0ZjBAJGYmT0xpY
	IWxhiT/XuthAbCGB94wSa197gdi8AnYSy/Y+Ze9i5OBgEVCReNakBhEWlDg58wkLiC0qkCrx
	q2EX2BhhAVeJezN3g41hFhCXuPVkPhOIzSZgKNH1FmK8CFDN9+45bCD3MAv8YpE4s/QXM8Rx
	jxglZq1ZxwxSxSlgL/G5/Sc7xCQzia6tXYwQtrxE89bZzBMYhWYhOWQWkoWzkLTMQtKygJFl
	FaNIamlxbnpusZFecWJucWleul5yfu4mRmAa2Xbs55YdjCtffdQ7xMjEwXiIUYKDWUmEd96T
	8ylCvCmJlVWpRfnxRaU5qcWHGE2BgTGRWUo0OR+YyPJK4g3NDEwNTcwsDUwtzYyVxHk9CzoS
	hQTSE0tSs1NTC1KLYPqYODilGph8wt93NHyJCfaa4LOhqnWjC9/cqoVlR1dVXLoSmHNwWujm
	c39Od55clxH9cK3477WXWa7VuXQfZbiyb/Lpv8H/I7tWpC++f/3fhAB+g4su2+OV3X5b8U0N
	ufdUW+h6vrFyupycXZqD75pVt4QuOnQpzNpw5s0iyduvPeMedG1j3Si7pypnf0Hv9TvfS/QD
	4x7szN/+5SRbsDe/9qd6o5VaV3byLXnjJ35r2p7n4VOUeny3z/721q1WoNviZBjHBdOPrxgY
	vkVZ9yybNltMM7/ZzrKtUfKz4JbctpvHdz3V1p9+VfbyHL7gmb2aXV22E7r3tC597JPY3WnS
	cb3pQtappI8JzyPOh9wtq3Y1fOapxFKckWioxVxUnAgAughJpqwDAAA=
X-CMS-MailID: 20230808130032eucas1p1b0f2d07f110f9913b30019b12e1d2841
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230808130032eucas1p1b0f2d07f110f9913b30019b12e1d2841
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230808130032eucas1p1b0f2d07f110f9913b30019b12e1d2841
References: <0-v2-b0417f84403e+11f-iommu_group_locking_jgg@nvidia.com>
	<ZNDpfCoeFxA56ZlU@8bytes.org>
	<CAGXv+5E-f9AteAYkmXYzVDZFSA_royc7-bS5LcrzzuHDnXccwA@mail.gmail.com>
	<7483d18e-d06f-53eb-92af-beed50674ab0@samsung.com>
	<CGME20230808130032eucas1p1b0f2d07f110f9913b30019b12e1d2841@eucas1p1.samsung.com>

Hi All,

On 08.08.2023 14:32, Marek Szyprowski wrote:
> On 08.08.2023 12:31, Chen-Yu Tsai wrote:
>> On Mon, Aug 7, 2023 at 8:54 PM Joerg Roedel <joro@8bytes.org> wrote:
>>> On Mon, Jul 31, 2023 at 02:50:23PM -0300, Jason Gunthorpe wrote:
>>>> Jason Gunthorpe (10):
>>>>    iommu: Remove useless group refcounting
>>>>    iommu: Add a lockdep assertion for remaining dev->iommu_group reads
>>>>    iommu: Add generic_single_device_group()
>>>>    iommu/sun50i: Convert to generic_single_device_group()
>>>>    iommu/sprd: Convert to generic_single_device_group()
>>>>    iommu/rockchip: Convert to generic_single_device_group()
>>>>    iommu/ipmmu-vmsa: Convert to generic_single_device_group()
>>>>    iommu/omap: Convert to generic_single_device_group()
>>>>    iommu: Complete the locking for dev->iommu_group
>>>>    iommu/intel: Fix missing locking for 
>>>> show_device_domain_translation()
>>>>
>>>>   drivers/iommu/intel/debugfs.c  |  34 ++++----
>>>>   drivers/iommu/iommu.c          | 155 
>>>> +++++++++++++++++++++------------
>>>>   drivers/iommu/ipmmu-vmsa.c     |  22 ++---
>>>>   drivers/iommu/omap-iommu.c     |  30 +------
>>>>   drivers/iommu/omap-iommu.h     |   2 +-
>>>>   drivers/iommu/rockchip-iommu.c |  22 +----
>>>>   drivers/iommu/sprd-iommu.c     |  24 +----
>>>>   drivers/iommu/sun50i-iommu.c   |  29 ++----
>>>>   include/linux/iommu.h          |   3 +
>>>>   9 files changed, 138 insertions(+), 183 deletions(-)
>>> Applied, thanks for the nice cleanup!
>> This series seems to cause a hung task during boot on MediaTek 
>> platforms.
>> It hangs with next-20230808. Reverting the 10 commits from this series
>> makes the system boot up again.
>
> I confirm that next-20230808 is broken on ARM 32bit based Exynos 
> boards too. Boards lock up very early during boot. I will try to 
> investigate this soon.

Hmm this turned to be Exynos IOMMU specific, but the issue is probably 
somehow generic.

The deadlock happens early in __iommu_probe_device() on 
device_lock(dev). Here is a stack dump of that call:

CPU: 1 PID: 1 Comm: swapper/0 Not tainted 6.5.0-rc5-next-20230808-dirty 
#7013
Hardware name: Samsung Exynos (Flattened Device Tree)
  unwind_backtrace from show_stack+0x10/0x14
  show_stack from dump_stack_lvl+0x58/0x70
  dump_stack_lvl from __iommu_probe_device+0x3d8/0x4ac
  __iommu_probe_device from probe_iommu_group+0x8/0x14
  probe_iommu_group from bus_for_each_dev+0x60/0xb4
  bus_for_each_dev from bus_iommu_probe+0x34/0x118
  bus_iommu_probe from iommu_device_register+0x98/0x100
  iommu_device_register from exynos_sysmmu_probe+0x238/0x3c0
  exynos_sysmmu_probe from platform_probe+0x80/0xc0
  platform_probe from really_probe+0x154/0x3d4
  really_probe from __driver_probe_device+0xa0/0x1e8
  __driver_probe_device from driver_probe_device+0x30/0xd0
  driver_probe_device from __device_attach_driver+0xbc/0x11c
  __device_attach_driver from bus_for_each_drv+0x74/0xc0
  bus_for_each_drv from __device_attach+0xec/0x1b4
  __device_attach from bus_probe_device+0x8c/0x90
  bus_probe_device from device_add+0x5b8/0x78c
  device_add from of_platform_device_create_pdata+0x94/0xcc
  of_platform_device_create_pdata from of_platform_bus_create+0x1ac/0x4d8
  of_platform_bus_create from of_platform_bus_create+0x214/0x4d8
  of_platform_bus_create from of_platform_populate+0x80/0x114
  of_platform_populate from of_platform_default_populate_init+0xcc/0xe4
  of_platform_default_populate_init from do_one_initcall+0x6c/0x318
  do_one_initcall from kernel_init_freeable+0x1c4/0x214
  kernel_init_freeable from kernel_init+0x18/0x12c
  kernel_init from ret_from_fork+0x14/0x2c

The problem here is that exynos_sysmmu_probe() is by design called under 
device_lock, then it calls iommu_device_register(), which in turn 
triggers calling __iommu_probe_device() on all platform devices in the 
system, while the still probed sysmmu device is one of them.

Frankly speaking I have no idea how to defer calling 
iommu_device_register() to avoid this deadlock. Any ideas?

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

