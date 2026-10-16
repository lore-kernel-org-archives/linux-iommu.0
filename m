Received: from mta1.migadu.com (out-50.mta1.migadu.com [95.215.58.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC6C2AD35
	for <iommu@lists.linux.dev>; Fri, 16 Oct 2026 16:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792166495; cv=none; b=Qj0uHy+PM5Vw3/BW7OfnTwo6iBn6B9qtn0yI8hQpbgkaztV6isp71AGROBkJGy1xmErGijI0Ajps0qtXM8j4gl9+ZWcBerYfSnxldXs5SDPS0xnlYGarFEh6uKa153BQHpT5fuJr+bCBuS8r/urVtOZUrxNUJ9wqjoOvFEJB8ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792166495; c=relaxed/simple;
	bh=ZsvsadtNTSKurgrLVhIy+7Gyty9WwPaKr8CAvH5Yd/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bwcdEnWfULSM0Hyvgjo2hGqFHWDThwaWW+AJRpI6IuPMz6j8H99oI6G4jJodlHmtj5XU9gmhdiGrRxbxGjU/wjtre8Z6jIASEWEIKDyYE3YZaxJDa+qFu3zphUtydqc46/1xjDDvoT3tEbvFLM16y/m9AA0c+6biiQBhPW6+KpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nPs8E+pz; arc=none smtp.client-ip=95.215.58.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nPs8E+pz"
X-Envelope-To: iommu@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=ZsvsadtNTSKurgrLVhIy+7Gyty9WwPaKr8CAvH5Yd/s=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792166492; v=1; x=1792771292;
 b=nPs8E+pzunlH8wpjzWSo8v4UDZp6Ktcnr8Ue0ApWcng4HE7ojymhlsds/3uSDmD9x5yK9lHi
 iviqy/o2Trx3WJn7uhlsNi7bm/xQx1l4yhUR6sOeZFzMsiOyBYr3l6FTS9f63lv5u/LaZXTTLne
 WOPzXi5WtOXrbO8l+xCEWsFY=
X-Envelope-To: iommu@lists.linux.dev
Received: by mta12.migadu.com with ESMTPS id 7f3b935a2176b901;
	Fri, 16 Oct 2026 16:01:32 +0000
X-Mizu-Trace-ID: 7f3b935a2176b901
X-Migadu-Flow: FLOW_OUT
Message-ID: <7925e32b-3c5b-4b9e-84f8-2cd306fbe124@linux.dev>
Date: Fri, 16 Oct 2026 17:01:26 +0100
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
 <2007f03b-2c76-4c36-a0bd-0ce99d1a01a2@linux.dev>
 <20261012121736.GE29954@lst.de>
 <8894307f-1042-497c-9c16-3fc1312486fb@linux.dev>
 <f4f48392-4181-456e-b3d7-907a30b13825@linux.dev>
 <TPZP295MB001311997DE1101F69FB0F91B39B2@TPZP295MB0013.TWNP295.PROD.OUTLOOK.COM>
Content-Language: en-US
From: John Garry <john.garry@linux.dev>
In-Reply-To: <TPZP295MB001311997DE1101F69FB0F91B39B2@TPZP295MB0013.TWNP295.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/16/26 15:07, Adrian Huang12 wrote:
>> BTW, @Adrian, it would be good to run your test with the IOMMU in strict
>> mode as well, just to give an idea if there is a problem there as well.
> Sorry for the delayed update. The original test system used three years ago
> is no longer available, so I needed additional time to assemble two new
> test systems.
> 
> == Test Environment ==
>    1. 448-core AMD server (2-socket) with an NVMe device (mdts=10)
>    2. 960-core Intel server (8-socket) with an NVMe device (mdts=10)
>    3. The issue can be reproduced with a single NVMe device (mdts=10)
>    4. IOMMU lazy mode is enabled. We did not test strict mode three years
>      ago (and now). @John, let me know if you need me to run the
>      strict mode test.

Not necessarily, unless you want to. strict mode generally shows a more 
severe performance degradation in terms of throughput, but strict mode 
would not be relevant to IOVA FQ timeouts which you were seeing.

>    5. stress-ng and fio used for reproduction
>    6. A 100-run test was performed for each tested kernel
> 
> == Summary ==
>    1. Since the original patch was merged in v6.4-rc3, I used v6.3 as the
>      baseline to verify whether the issue could be reproduced on these
>      two systems. The issue was successfully reproduced on both platforms.
>    2. On v6.7 and later kernels, after reverting commit 3710e2b056cb, the
>      issue no longer occurs.
>    3. Detailed test information and logs can be found in [1].
> 
> == Detailed Results (Both Systems) ==
>    * v7.3.0-rc7 + revert 3710e2b056cb: Passed
>    * v6.12 + revert 3710e2b056cb: Passed
>    * v6.8 + revert 3710e2b056cb: Passed
>    * v6.7 + revert 3710e2b056cb: Passed
>    * v6.6 + revert 3710e2b056cb: Failed
>    * v6.5 + revert 3710e2b056cb: Failed
>    * Vanilla 6.3: Failed
> 
> Based on these results, I believe it is safe to apply the revert. Please feel
> free to add:

thanks for testing

> 
> Tested-by: Adrian Huang<ahuang12@lenovo.com>
> 
> Also, my apologies for introducing the performance regression. The results
> show that changes in the IOMMU subsystem introduced around v6.7
> significantly improved scalability, 

Nothing sticks out to me which could affect this. The iova rcache code 
changed in terms of removing the fixed depot size upper limit in v6.7, 
but this should not affect you (as your data block size exceeds that of 
the rcache limit). Having said that, you mention that stress-ng is being 
used also, and I don't know the profile of the storage data size used there.

> although I have not yet investigated
> which specific commit resolved the underlying issue.
> 
> [1] Detailed test info:https://hackmd.io/@lQBEPrYxRoOVV2MatUYusg/B14XRbZ1nGx

