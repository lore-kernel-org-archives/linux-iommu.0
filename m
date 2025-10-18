Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA483BB5A
	for <iommu@lists.linux.dev>; Sat, 18 Oct 2025 08:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760777224; cv=none; b=oBaikFfB7FN2aE6PjU4ecoVH6jIjlCRyk0Wv+ow28VUs5GgffBY5+LhdfuBNUgmI3G3qx4fBp+VDVU/rkyUbLIlzFxM8QB7503ocmnEOjxexD5YbI9euFEPfPoworOS1ZG+Fl0Wi8fRP0ivhJIiJ8xx8vTUmLMp1P9N9vI3jUic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760777224; c=relaxed/simple;
	bh=fw6L8ACEjG8b3uUVswZemuK0fXowd7Gbu+ZmHZX7/ew=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LLCpWyP59eSTQnWBy6ZDhMVjXNr8owwcHLy9AZ27Nl3aKMTbB1iqnzxxKGfPw8zP79OUFmqIac99oA5yuln0VJncn6K/lBoLmtZj/kmxkNj9JuwwlPXwLWp/H6wJqpR4wDOMaoorIi7QuN52tQ5CXSko1zrWDjrLKhY1EzSPnAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=AD5XR7Nm; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="AD5XR7Nm"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=PtXeoyMbEb3nG99AFaMa2rNFJ1WX4VazwCqad42ukB8=;
	b=AD5XR7NmSD71grdrmY7EqMR7hVnfBjEGjLO/Sn5nWEGBbnS3ZCsHvokz8iNNa8zYKy9/+j/PE
	hk2ALKCefi0mTib91JeeloNYzPxN4DEKO+rPT4UbOzKZ55lxbTgqqDcU4DZd4sJNyvnYb9/uqHf
	jlx3exQ0zEZsGJKliLGJLh0=
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4cpZzq0xH6zLlVc;
	Sat, 18 Oct 2025 16:46:31 +0800 (CST)
Received: from kwepemj200003.china.huawei.com (unknown [7.202.194.15])
	by mail.maildlp.com (Postfix) with ESMTPS id 3EC951A016C;
	Sat, 18 Oct 2025 16:46:53 +0800 (CST)
Received: from [10.67.120.170] (10.67.120.170) by
 kwepemj200003.china.huawei.com (7.202.194.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 18 Oct 2025 16:46:52 +0800
Message-ID: <9ce597a0-9df4-4c92-913b-ca75fc028972@huawei.com>
Date: Sat, 18 Oct 2025 16:46:52 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/4] iommu: Add IOMMU_DEBUG_PAGEALLOC sanitizer
To: Mostafa Saleh <smostafa@google.com>, <linux-mm@kvack.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>
CC: <corbet@lwn.net>, <joro@8bytes.org>, <will@kernel.org>,
	<robin.murphy@arm.com>, <akpm@linux-foundation.org>, <vbabka@suse.cz>,
	<surenb@google.com>, <mhocko@suse.com>, <jackmanb@google.com>,
	<hannes@cmpxchg.org>, <ziy@nvidia.com>, <david@redhat.com>,
	<lorenzo.stoakes@oracle.com>, <Liam.Howlett@oracle.com>, <rppt@kernel.org>
References: <20251003173229.1533640-1-smostafa@google.com>
From: Qinxin Xia <xiaqinxin@huawei.com>
In-Reply-To: <20251003173229.1533640-1-smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemj200003.china.huawei.com (7.202.194.15)



在 2025/10/4 1:32, Mostafa Saleh 写道:
> Overview
> --------
> This patch series introduces a new debugging feature,
> IOMMU_DEBUG_PAGEALLOC, designed to catch DMA use-after-free bugs
> and IOMMU mapping leaks from buggy drivers.
> 
> The kernel has powerful sanitizers like KASAN and DEBUG_PAGEALLOC
> for catching CPU-side memory corruption. However, there is limited
> runtime sanitization for DMA mappings managed by the IOMMU. A buggy
> driver can free a page while it is still mapped for DMA, leading to
> memory corruption or use-after-free vulnerabilities when that page is
> reallocated and used for a different purpose.
> 
> Inspired by DEBUG_PAGEALLOC, this sanitizer tracks IOMMU mappings on a
> per-page basis, as it’s not possible to unmap the pages, because it
> requires to lock and walk all domains on every kernel free, instead we
> rely on page_ext to add an IOMMU-specific mapping reference count for
> each page.
> And on each page allocated/freed from the kernel we simply check the
> count and WARN if it is not zero.
> 
> Concurrency
> -----------
> By design this check is racy where one caller can map pages just after
> the check, which can lead to false negatives.
> In my opinion this is acceptable for sanitizers (for ex KCSAN have
> that property).
> Otherwise we have to implement locks in iommu_map/unmap for all domains
> which is not favourable even for a debug feature.
> The sanitizer only guarantees that the refcount itself doesn’t get
> corrupted using atomics. And there are no false positives.
> 
> CPU vs IOMMU Page Size
> ----------------------
> IOMMUs can use different page sizes and which can be non-homogeneous;
> not even all of them have the same page size.
> 
> To solve this, the refcount is always incremented and decremented in
> units of the smallest page size supported by the IOMMU domain. This
> ensures the accounting remains consistent regardless of the size of
> the map or unmap operation, otherwise double counting can happen.
> 
> Testing & Performance
> ---------------------
> This was tested on Morello with Arm64 + SMMUv3
> Also I booted RockPi-4b with Rockchip IOMMU.
> Did some tests on Qemu including different SMMUv3/CPU page size (arm64).
> 
> I also ran dma_map_benchmark on Morello:
> 
> echo dma_map_benchmark > /sys/bus/pci/devices/0000\:06\:00.0/driver_override
> echo 0000:06:00.0 >  /sys/bus/pci/devices/0000\:06\:00.0/driver/unbind
> echo 0000:06:00.0 > /sys/bus/pci/drivers/dma_map_benchmark/bind
> ./dma_map_bechmark -t $threads -g $nr_pages
> 
> CONFIG refers to "CONFIG_IOMMU_DEBUG_PAGEALLOC"
> cmdline refer to "iommu.debug_pagealloc"
> Numbers are (map latency)/(unmap latency), lower is better.
> 
> 			CONFIG=n    CONFIG=y    CONFIG=y
> 			            cmdline=0   cmdline=1
> 4K - 1 thread		0.1/0.6     0.1/0.6     0.1/0.7
> 4K - 4 threads		0.1/1.0     0.1/1.1     0.1/1.1
> 1M - 1 thread		0.8/21.2    0.8/21.2    5.6/42.5
> 1M - 4 threads		1.1/46.3    1.1/46.1    5.9/45.5
> 
> Thanks,
> Mostafa
> 
> Mostafa Saleh (4):
>    drivers/iommu: Add page_ext for IOMMU_DEBUG_PAGEALLOC
>    drivers/iommu: Add calls for iommu debug
>    drivers/iommu-debug: Track IOMMU pages
>    drivers/iommu-debug: Check state of mapped/unmapped kernel memory
> 
>   .../admin-guide/kernel-parameters.txt         |   6 +
>   drivers/iommu/Kconfig                         |  14 ++
>   drivers/iommu/Makefile                        |   1 +
>   drivers/iommu/iommu-debug.c                   | 160 ++++++++++++++++++
>   drivers/iommu/iommu.c                         |  21 ++-
>   include/linux/iommu-debug.h                   |  24 +++
>   include/linux/mm.h                            |   7 +
>   mm/page_ext.c                                 |   4 +
>   8 files changed, 235 insertions(+), 2 deletions(-)
>   create mode 100644 drivers/iommu/iommu-debug.c
>   create mode 100644 include/linux/iommu-debug.h
> 
Hi,

I have tested the patch on kunpeng 920 and it works as expected.

Tested-by: Qinxin Xia <xiaqinxin@huawei.com>

Thanks,
Qinxin Xia

