Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EDB19CC31
	for <iommu@lists.linux.dev>; Wed, 20 Nov 2024 10:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732099305; cv=none; b=VBtkUdMz7uBps1oZH8lohh+zxEcvy9MEqB8LsPzWjoJSbfacrcW2lzQYvuAtQyR/oQJE5n9vMuADtzTH8ExkS3uFsTFhMR9XJ/QxrhXyt5jlHN3DYe7s9HsC7A8ibHax7ZXZ7hOgMBGMKRoTfh402dOSmIUNXddXdr03gIHaRE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732099305; c=relaxed/simple;
	bh=w/GDApbwqwaDqP3WllF1rW2Ut9mvC6/4C5pW19Mcqdg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=evUVIoI3Nl4gDfBj1MP074bBZrZhdxICuEhv6asd2kCtLeYndLaQD67eiQRqPy/FARm2p8Di4CBl7lf9dNks95gvd2P58dEQ0cMZEIwjBJwum2A9/cphXl2BVXsQMwach9bHd3p8DUgRQwJiDR5YX+OBvcdl8z0FYUu8voPzqe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XtdCR66mCz10WBf;
	Wed, 20 Nov 2024 18:39:31 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id BD1D1140360;
	Wed, 20 Nov 2024 18:41:33 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 20 Nov 2024 18:41:33 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <liuyonglong@huawei.com>, <fanghaiqing@huawei.com>,
	<zhangkun09@huawei.com>, Yunsheng Lin <linyunsheng@huawei.com>, Alexander
 Lobakin <aleksander.lobakin@intel.com>, Robin Murphy <robin.murphy@arm.com>,
	Alexander Duyck <alexander.duyck@gmail.com>, Andrew Morton
	<akpm@linux-foundation.org>, IOMMU <iommu@lists.linux.dev>, MM
	<linux-mm@kvack.org>
Subject: [PATCH RFC v4 0/3] fix two bugs related to page_pool
Date: Wed, 20 Nov 2024 18:34:52 +0800
Message-ID: <20241120103456.396577-1-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemf200006.china.huawei.com (7.185.36.61)

Patch 1 fix a possible time window problem for page_pool.
Patch 2 fix the kernel crash problem at iommu_get_dma_domain reported
in [1] using scanning.
Patch 3 avoid calling dma sync API after driver has already unbound.

From the below performance data, there seems to be no noticeable
performance impact.

Before this patchset:
root@(none)$ taskset -c 0 insmod bench_page_pool_simple.ko
[  165.357058] bench_page_pool_simple: Loaded
[  165.438159] time_bench: Type:for_loop Per elem: 0 cycles(tsc) 0.769 ns (step:0) - (measurement period time:0.076973110 sec time_interval:76973110) - (invoke count:100000000 tsc_interval:7697296)
[  167.423811] time_bench: Type:atomic_inc Per elem: 1 cycles(tsc) 19.683 ns (step:0) - (measurement period time:1.968369340 sec time_interval:1968369340) - (invoke count:100000000 tsc_interval:196836926)
[  167.591773] time_bench: Type:lock Per elem: 1 cycles(tsc) 15.006 ns (step:0) - (measurement period time:0.150069980 sec time_interval:150069980) - (invoke count:10000000 tsc_interval:15006991)
[  168.265447] time_bench: Type:rcu Per elem: 0 cycles(tsc) 6.565 ns (step:0) - (measurement period time:0.656564890 sec time_interval:656564890) - (invoke count:100000000 tsc_interval:65656477)
[  168.282469] bench_page_pool_simple: time_bench_page_pool01_fast_path(): Cannot use page_pool fast-path
[  168.572734] time_bench: Type:no-softirq-page_pool01 Per elem: 2 cycles(tsc) 28.097 ns (step:0) - (measurement period time:0.280971960 sec time_interval:280971960) - (invoke count:10000000 tsc_interval:28097187)
[  168.591404] bench_page_pool_simple: time_bench_page_pool02_ptr_ring(): Cannot use page_pool fast-path
[  169.178662] time_bench: Type:no-softirq-page_pool02 Per elem: 5 cycles(tsc) 57.805 ns (step:0) - (measurement period time:0.578052550 sec time_interval:578052550) - (invoke count:10000000 tsc_interval:57805246)
[  169.197331] bench_page_pool_simple: time_bench_page_pool03_slow(): Cannot use page_pool fast-path
[  171.033303] time_bench: Type:no-softirq-page_pool03 Per elem: 18 cycles(tsc) 182.711 ns (step:0) - (measurement period time:1.827113580 sec time_interval:1827113580) - (invoke count:10000000 tsc_interval:182711348)
[  171.052324] bench_page_pool_simple: pp_tasklet_handler(): in_serving_softirq fast-path
[  171.060227] bench_page_pool_simple: time_bench_page_pool01_fast_path(): in_serving_softirq fast-path
[  171.350242] time_bench: Type:tasklet_page_pool01_fast_path Per elem: 2 cycles(tsc) 28.089 ns (step:0) - (measurement period time:0.280896430 sec time_interval:280896430) - (invoke count:10000000 tsc_interval:28089636)
[  171.369517] bench_page_pool_simple: time_bench_page_pool02_ptr_ring(): in_serving_softirq fast-path
[  171.903169] time_bench: Type:tasklet_page_pool02_ptr_ring Per elem: 5 cycles(tsc) 52.461 ns (step:0) - (measurement period time:0.524619700 sec time_interval:524619700) - (invoke count:10000000 tsc_interval:52461966)
[  171.922357] bench_page_pool_simple: time_bench_page_pool03_slow(): in_serving_softirq fast-path
[  173.851219] time_bench: Type:tasklet_page_pool03_slow Per elem: 19 cycles(tsc) 192.017 ns (step:0) - (measurement period time:1.920178560 sec time_interval:1920178560) - (invoke count:10000000 tsc_interval:192017848)

After this patchset:
root@(none)$ taskset -c 0 insmod bench_page_pool_simple.ko
[  394.337302] bench_page_pool_simple: Loaded
[  394.418402] time_bench: Type:for_loop Per elem: 0 cycles(tsc) 0.769 ns (step:0) - (measurement period time:0.076976830 sec time_interval:76976830) - (invoke count:100000000 tsc_interval:7697673)
[  396.168990] time_bench: Type:atomic_inc Per elem: 1 cycles(tsc) 17.333 ns (step:0) - (measurement period time:1.733304770 sec time_interval:1733304770) - (invoke count:100000000 tsc_interval:173330470)
[  396.336932] time_bench: Type:lock Per elem: 1 cycles(tsc) 15.005 ns (step:0) - (measurement period time:0.150052930 sec time_interval:150052930) - (invoke count:10000000 tsc_interval:15005288)
[  397.008173] time_bench: Type:rcu Per elem: 0 cycles(tsc) 6.541 ns (step:0) - (measurement period time:0.654135460 sec time_interval:654135460) - (invoke count:100000000 tsc_interval:65413540)
[  397.025193] bench_page_pool_simple: time_bench_page_pool01_fast_path(): Cannot use page_pool fast-path
[  397.295761] time_bench: Type:no-softirq-page_pool01 Per elem: 2 cycles(tsc) 26.127 ns (step:0) - (measurement period time:0.261275610 sec time_interval:261275610) - (invoke count:10000000 tsc_interval:26127555)
[  397.314429] bench_page_pool_simple: time_bench_page_pool02_ptr_ring(): Cannot use page_pool fast-path
[  397.852216] time_bench: Type:no-softirq-page_pool02 Per elem: 5 cycles(tsc) 52.858 ns (step:0) - (measurement period time:0.528581530 sec time_interval:528581530) - (invoke count:10000000 tsc_interval:52858146)
[  397.870887] bench_page_pool_simple: time_bench_page_pool03_slow(): Cannot use page_pool fast-path
[  399.701260] time_bench: Type:no-softirq-page_pool03 Per elem: 18 cycles(tsc) 182.151 ns (step:0) - (measurement period time:1.821514450 sec time_interval:1821514450) - (invoke count:10000000 tsc_interval:182151437)
[  399.720282] bench_page_pool_simple: pp_tasklet_handler(): in_serving_softirq fast-path
[  399.728186] bench_page_pool_simple: time_bench_page_pool01_fast_path(): in_serving_softirq fast-path
[  399.998947] time_bench: Type:tasklet_page_pool01_fast_path Per elem: 2 cycles(tsc) 26.164 ns (step:0) - (measurement period time:0.261642940 sec time_interval:261642940) - (invoke count:10000000 tsc_interval:26164289)
[  400.018223] bench_page_pool_simple: time_bench_page_pool02_ptr_ring(): in_serving_softirq fast-path
[  400.621035] time_bench: Type:tasklet_page_pool02_ptr_ring Per elem: 5 cycles(tsc) 59.377 ns (step:0) - (measurement period time:0.593779950 sec time_interval:593779950) - (invoke count:10000000 tsc_interval:59377988)
[  400.640223] bench_page_pool_simple: time_bench_page_pool03_slow(): in_serving_softirq fast-path
[  402.524760] time_bench: Type:tasklet_page_pool03_slow Per elem: 18 cycles(tsc) 187.585 ns (step:0) - (measurement period time:1.875853550 sec time_interval:1875853550) - (invoke count:10000000 tsc_interval:187585349)

1. https://lore.kernel.org/lkml/8067f204-1380-4d37-8ffd-007fc6f26738@kernel.org/T/

CC: Alexander Lobakin <aleksander.lobakin@intel.com>
CC: Robin Murphy <robin.murphy@arm.com>
CC: Alexander Duyck <alexander.duyck@gmail.com>
CC: Andrew Morton <akpm@linux-foundation.org>
CC: IOMMU <iommu@lists.linux.dev>
CC: MM <linux-mm@kvack.org>

Change log:
V4:
  1. use scanning to do the unmapping
  2. spilt dma sync skipping into separate patch

V3:
  1. Target net-next tree instead of net tree.
  2. Narrow the rcu lock as the discussion in v2.
  3. Check the ummapping cnt against the inflight cnt.

V2:
  1. Add a item_full stat.
  2. Use container_of() for page_pool_to_pp().

Yunsheng Lin (3):
  page_pool: fix timing for checking and disabling napi_local
  page_pool: fix IOMMU crash when driver has already unbound
  page_pool: skip dma sync operation for inflight pages

 include/net/page_pool/types.h |   6 +-
 net/core/page_pool.c          | 135 ++++++++++++++++++++++++++++------
 2 files changed, 119 insertions(+), 22 deletions(-)

-- 
2.33.0

