Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC3A28E8
	for <iommu@lists.linux.dev>; Fri, 26 Aug 2022 08:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661504333; x=1693040333;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qd4FqNTu52qrVx/MtAe2JAV2sDMVlYfag3oD7tG2ki4=;
  b=kKQBnsMlS5JeqwmcyMsYcGMbe2Sx4NGAxG8aHnyAzmpq5I64fc9fSK0P
   D0Hei736JHAirk09pHA/NlGUlbCxkd208A/7LRb4rGKLfT89v4bbS0OY6
   34Gb2f2gcRLf1S7Ueph+dFiiXRgBo8vvb7kK6C+7WZYE8SbkFfg5BGydW
   mIyUY6EZ1ZmSlpldzH/q7aEi6JqxHCHWy8RCJ+BZ6rCGHI/cOC7SWFG1p
   3UUdSAcE2NOC3p/P5NEq+PUKm940zdqAFfqzLzFiR3zh45iP3ip3jt2dV
   L2YLPScdNaKLJnTq/h0hMzhTkQIMoxt9iD1jR8zDWPA/q9Ofdo7gTddvJ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10450"; a="380755002"
X-IronPort-AV: E=Sophos;i="5.93,264,1654585200"; 
   d="scan'208";a="380755002"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 01:58:52 -0700
X-IronPort-AV: E=Sophos;i="5.93,264,1654585200"; 
   d="scan'208";a="671383823"
Received: from zhaohaif-mobl1.ccr.corp.intel.com (HELO [10.254.212.242]) ([10.254.212.242])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 01:58:50 -0700
Message-ID: <a2479500-479a-22ef-3bd2-90606a26a35e@linux.intel.com>
Date: Fri, 26 Aug 2022 16:58:48 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [External] Re: [PATCH v2] iommu/iova: Optimize alloc_iova with
 rbtree_augmented
To: Peng Zhang <zhangpeng.00@bytedance.com>, joro@8bytes.org, will@kernel.org
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, robin.murphy@arm.com
References: <20220824095139.66477-1-zhangpeng.00@bytedance.com>
 <06c215c6-cbae-d6b9-312c-6535e51a3128@linux.intel.com>
 <486fcde8-e9f5-e40c-db5d-fd3ade59b267@bytedance.com>
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
In-Reply-To: <486fcde8-e9f5-e40c-db5d-fd3ade59b267@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Peng,

在 2022/8/25 16:10, Peng Zhang 写道:
>
> Hi,
>
> Here is a real example. The version of kernel is 5.4.56.
> Occurs when a lot of iova are not released for a long time.
>
> [Wed May 25 05:27:59 2022] watchdog: BUG: soft lockup - CPU#58 stuck 
> for 23s! [ksoftirqd/58:302]
> [Wed May 25 05:27:59 2022] Call Trace:
> [Wed May 25 05:27:59 2022]  alloc_iova+0xf2/0x140
> [Wed May 25 05:27:59 2022]  alloc_iova_fast+0x56/0x251
The rcache doesn't work at all , the worst case.
> [Wed May 25 05:27:59 2022]  dma_ops_alloc_iova.isra.27+0x4b/0x70
> [Wed May 25 05:27:59 2022]  __map_single.isra.28+0x4a/0x1d0
> [Wed May 25 05:27:59 2022]  mlx5e_sq_xmit+0x98d/0x12b0 [mlx5_core]
> [Wed May 25 05:27:59 2022]  ? packet_rcv+0x43/0x460
> [Wed May 25 05:27:59 2022]  ? dev_hard_start_xmit+0x90/0x1e0
> [Wed May 25 05:27:59 2022]  ? sch_direct_xmit+0x111/0x320
> [Wed May 25 05:27:59 2022]  ? __qdisc_run+0x143/0x540
> [Wed May 25 05:27:59 2022]  ? __dev_queue_xmit+0x6c3/0x8e0
> [Wed May 25 05:27:59 2022]  ? ip_finish_output2+0x2d5/0x580
> [Wed May 25 05:27:59 2022]  ? __ip_finish_output+0xe9/0x1b0
> [Wed May 25 05:27:59 2022]  ? ip_output+0x6c/0xe0
> [Wed May 25 05:27:59 2022]  ? __ip_finish_output+0x1b0/0x1b0
> [Wed May 25 05:27:59 2022]  ? __ip_queue_xmit+0x15d/0x420
> [Wed May 25 05:27:59 2022]  ? __tcp_transmit_skb+0x405/0x600
> [Wed May 25 05:27:59 2022]  ? tcp_delack_timer_handler+0xb7/0x1b0
> [Wed May 25 05:27:59 2022]  ? tcp_delack_timer+0x8b/0xa0
> [Wed May 25 05:27:59 2022]  ? tcp_delack_timer_handler+0x1b0/0x1b0
> [Wed May 25 05:27:59 2022]  ? call_timer_fn+0x2b/0x120
> [Wed May 25 05:27:59 2022]  ? run_timer_softirq+0x1a6/0x420
> [Wed May 25 05:27:59 2022]  ? update_load_avg+0x7e/0x640
> [Wed May 25 05:27:59 2022]  ? update_curr+0xe1/0x1d0
> [Wed May 25 05:27:59 2022]  ? __switch_to+0x7a/0x3e0
> [Wed May 25 05:27:59 2022]  ? __do_softirq+0xda/0x2da
> [Wed May 25 05:27:59 2022]  ? sort_range+0x20/0x20
> [Wed May 25 05:27:59 2022]  ? run_ksoftirqd+0x26/0x40
> [Wed May 25 05:27:59 2022]  ? smpboot_thread_fn+0xb8/0x150
> [Wed May 25 05:27:59 2022]  ? kthread+0x110/0x130
> [Wed May 25 05:27:59 2022]  ? kthread_park+0x80/0x80
> [Wed May 25 05:27:59 2022]  ? ret_from_fork+0x1f/0x30
>
> I did some more tests.
>
> The test is single threaded.
> Granule is 4k, limit is 2^20.
>
> When the 1/4 address space is occupied by iova,
> Repeat the following two steps：
>
> 1. Randomly releases an iova.
> 2. Allocate an iova of size 1 within the allocation limit of 2^20.
>
> Before improvement:
>> Tracing 1 functions for "alloc_iova"... Hit Ctrl-C to end.
>> ^C
>>      nsecs               : count     distribution
>>          0 -> 1          : 0 |                                        |
>>          2 -> 3          : 0 |                                        |
>>          4 -> 7          : 0 |                                        |
>>          8 -> 15         : 0 |                                        |
>>         16 -> 31         : 0 |                                        |
>>         32 -> 63         : 0 |                                        |
>>         64 -> 127        : 0 |                                        |
>>        128 -> 255        : 0 |                                        |
>>        256 -> 511        : 352 
>> |                                        |
>>        512 -> 1023       : 258078 
>> |****************************************|
>>       1024 -> 2047       : 3612 
>> |                                        |
>>       2048 -> 4095       : 426 
>> |                                        |
>>       4096 -> 8191       : 183 
>> |                                        |
>>       8192 -> 16383      : 6 |                                        |
>>      16384 -> 32767      : 5 |                                        |
>>      32768 -> 65535      : 9 |                                        |
>>      65536 -> 131071     : 18 |                                        |
>>     131072 -> 262143     : 28 |                                        |
>>     262144 -> 524287     : 74 |                                        |
>>     524288 -> 1048575    : 109 
>> |                                        |
>>    1048576 -> 2097151    : 170 
>> |                                        |
>>    2097152 -> 4194303    : 100 
>> |                                        |
>>    4194304 -> 8388607    : 1 |                                        |
>>
>> avg = 3110 nsecs, total: 818614399 nsecs, count: 263171
>>
>> Tracing 1 functions for "remove_iova"... Hit Ctrl-C to end.
>> ^C
>>      nsecs               : count     distribution
>>          0 -> 1          : 0 |                                        |
>>          2 -> 3          : 0 |                                        |
>>          4 -> 7          : 0 |                                        |
>>          8 -> 15         : 0 |                                        |
>>         16 -> 31         : 0 |                                        |
>>         32 -> 63         : 0 |                                        |
>>         64 -> 127        : 0 |                                        |
>>        128 -> 255        : 0 |                                        |
>>        256 -> 511        : 250651 
>> |****************************************|
>>        512 -> 1023       : 12405 
>> |*                                       |
>>       1024 -> 2047       : 111 
>> |                                        |
>>       2048 -> 4095       : 1 |                                        |
>>
>> avg = 433 nsecs, total: 114136319 nsecs, count: 263168
>
> With improvement:
>> Tracing 1 functions for "alloc_iova"... Hit Ctrl-C to end.
>> ^C
>>      nsecs               : count     distribution
>>          0 -> 1          : 0 |                                        |
>>          2 -> 3          : 0 |                                        |
>>          4 -> 7          : 0 |                                        |
>>          8 -> 15         : 0 |                                        |
>>         16 -> 31         : 0 |                                        |
>>         32 -> 63         : 0 |                                        |
>>         64 -> 127        : 0 |                                        |
>>        128 -> 255        : 0 |                                        |
>>        256 -> 511        : 0 |                                        |
>>        512 -> 1023       : 258975 
>> |****************************************|
>>       1024 -> 2047       : 3618 
>> |                                        |
>>       2048 -> 4095       : 497 
>> |                                        |
>>       4096 -> 8191       : 74 |                                        |
>>       8192 -> 16383      : 4 |                                        |
>>      16384 -> 32767      : 1 |                                        |
>>
>> avg = 637 nsecs, total: 167854061 nsecs, count: 263169
>>
>> Tracing 1 functions for "remove_iova"... Hit Ctrl-C to end.
>> ^C
>>      nsecs               : count     distribution
>>          0 -> 1          : 0 |                                        |
>>          2 -> 3          : 0 |                                        |
>>          4 -> 7          : 0 |                                        |
>>          8 -> 15         : 0 |                                        |
>>         16 -> 31         : 0 |                                        |
>>         32 -> 63         : 0 |                                        |
>>         64 -> 127        : 0 |                                        |
>>        128 -> 255        : 0 |                                        |
>>        256 -> 511        : 221560 
>> |****************************************|
>>        512 -> 1023       : 41427 
>> |*******                                 |
>>       1024 -> 2047       : 179 
>> |                                        |
>>       2048 -> 4095       : 2 |                                        |
>>
>> avg = 477 nsecs, total: 125540399 nsecs, count: 263168

Though only 3-4 drivers use alloc_iova() directly, in my understanding

your test has simulated the worst case, rcache doesn't work at all,

"alloc_iova" +“remove_iova” number looks great for worst case.


Reviewed-by: Ethan Zhao <haifeng.zhao@linux.intel.com>



>
>> s/distbution/distribution ?
> Sorry, it's a typo.
>
> I don't have a test program for "alloc_iova_fast + free_iova_fast"
> right now.
>
> Thanks,
>
> Peng

-- 
"firm, enduring, strong, and long-lived"

