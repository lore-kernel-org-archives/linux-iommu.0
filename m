Received: from mta0.migadu.com (out-212.mta0.migadu.com [91.218.175.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF1046D56A
	for <iommu@lists.linux.dev>; Mon, 12 Oct 2026 08:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791794532; cv=none; b=Jd8RCOH27ntsVfkM4fwFpa66kqkuTHP0vPnlIX+Kpm9owcjlqGz7+acrjp43JchPvPV/oFNHCGUvmhhEubNDobbiS/wlhiJKeqtS4CX+DPZtTJHZQkYWLMTef/Q88t4tk0Jb1znx6KaHZHRiZ/onMvgwJzjyrnSbroBSDv5jdVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791794532; c=relaxed/simple;
	bh=o2e972utFFQk0BpQcOPt5dGwhiilIlCaD4fH59gbqmg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UkYy62KRls2PWTAQYrOxhBHXcP/90/Vru3z5tuX1QChVZPD+5qyD6tGnyfIKO1i1AGk5VB65/RnhPxuGDvXG7VCbtsdwJDeO7UmIaweoIaM7lssea/EgGVZkRQHHiv/HEKLsvK9dDsKMphryKxst72xZRDBvu2+rzAA7M9ANmkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CIs9CNJG; arc=none smtp.client-ip=91.218.175.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CIs9CNJG"
X-Envelope-To: iommu@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=o2e972utFFQk0BpQcOPt5dGwhiilIlCaD4fH59gbqmg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791794526; v=1; x=1792399326;
 b=CIs9CNJGQUGiqAI2ZqXcFp8GQCPZ14aJt/EoAX5tXeuGWVTkftOkULl+0xKe7rQSNXNkBrXK
 bMO5IB857jP5OZTX8m6H4Sk4YA/bW8a4a+0Kp4R9dZRxpl/FPFfYHLJ/Ehfjue76fo5BmPhNczF
 PFSlp2ouwbjyf3+1xxkr8xW4=
X-Envelope-To: iommu@lists.linux.dev
Received: by mta12.migadu.com with ESMTPS id a325368366ef22a3;
	Mon, 12 Oct 2026 08:42:06 +0000
X-Mizu-Trace-ID: a325368366ef22a3
X-Migadu-Flow: FLOW_OUT
Message-ID: <2007f03b-2c76-4c36-a0bd-0ce99d1a01a2@linux.dev>
Date: Mon, 12 Oct 2026 09:42:04 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [PATCH] Revert "nvme-pci: clamp max_hw_sectors
 based on DMA optimized limitation"
To: Adrian Huang12 <ahuang12@lenovo.com>, Christoph Hellwig <hch@lst.de>
Cc: "kbusch@kernel.org" <kbusch@kernel.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Jiwei JW10 Sun <sunjw10@lenovo.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>
References: <20261006120248.147654-1-hch@lst.de>
 <8cf8a8ea-c9c9-434b-aec6-e361280a88a4@linux.dev>
 <20261008123724.GA22096@lst.de>
 <TPZP295MB0013C6E51C73799E49B8EFF4B3922@TPZP295MB0013.TWNP295.PROD.OUTLOOK.COM>
Content-Language: en-US
From: John Garry <john.garry@linux.dev>
In-Reply-To: <TPZP295MB0013C6E51C73799E49B8EFF4B3922@TPZP295MB0013.TWNP295.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/9/26 10:11, Adrian Huang12 wrote:
>> -----Original Message-----
>> From: Christoph Hellwig <hch@lst.de>
>> Sent: Thursday, October 8, 2026 8:37 PM
>> To: John Garry <john.garry@linux.dev>
>> Cc: Christoph Hellwig <hch@lst.de>; kbusch@kernel.org; Adrian Huang12
>> <ahuang12@lenovo.com>; sagi@grimberg.me; linux-nvme@lists.infradead.org;
>> Jiwei JW10 Sun <sunjw10@lenovo.com>; iommu@lists.linux.dev
>> Subject: [External] Re: [PATCH] Revert "nvme-pci: clamp max_hw_sectors
>> based on DMA optimized limitation"
>>
>> On Thu, Oct 08, 2026 at 08:36:54AM +0100, John Garry wrote:
>>> On 10/6/26 13:02, Christoph Hellwig wrote:
>>>> This turns down to cause up to 15% performance regressions on
>>>> standard large transfer workloads.  Revert it and hope the IOVA
>>>> allocator can eventually be fixed to remove the need for the original
>> workaround.
>>>>
>>>> This reverts commit 3710e2b056cb92ad816e4d79fa54a6a5b6ad8cbd.
>>>>
>>>
>>> What was the block size and conditions for the original issue? The
>>> commit just mentions that mdts=10 and we get a 4096KB max HW sectors.
>>
>> Good question.  The original submitter and reporter are on Cc.
> 
> 1. The block size depends on the configuration of the fio parameter 'bs'. See below for details.
> 2. Conditions for the original issue: The issue is triggered if the IO size > 128KB.
> 
> [Detail]
> 1. A NVME with mdts=10 (maximum data transfer size = 4096 KB)
>    1.1 fio with bs=128k or below => Passed
>    1.2 fio with bs > 128k => Failed


That block size limit is an important detail missing from 
3710e2b056cb92ad816e4d79fa54a6a5b6ad8cbd commit message.

And now we seem to have a conflict, as Christoph wants block size > IOVA 
rcache limit but you find it may cause this soft lockup.

> 2. Another NVME with mdts=5 (maximum data transfer size = 128KB)
>    2.1 The issue does not reproduce regardless of the 'bs' configuration
> 3. The condition '128 KB' is identified because the IOMMU scalable IOVA mechanism supports a maximum transfer size of 128 KB.
> 4. IOMMU pass-through mode does not trigger the issue with the 'mdts=10' nvme disk.
> 5. The issue only appears with high-core-count servers
>    5.1 Reproduced servers: 448-core server and 384-core server
>    5.2 Non-reproduced server: 128-core server

How long does it take for the lockup to trigger? Pretty quickly, I guess.

Does changing the number of CPUs affect throughput (before the lockup)? 
Are you using just a single disk?

> 
> BTW, with this reverted patch, I'm setting up the test environment to check whether the issue does not appear with a newer kernel that includes the updated IOMMU subsystem. I'll share the results by the end of next week.
> 

thanks

