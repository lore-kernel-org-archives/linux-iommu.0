Received: from mta0.migadu.com (out-203.mta0.migadu.com [91.218.175.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4769439F75
	for <iommu@lists.linux.dev>; Thu, 15 Oct 2026 10:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792060259; cv=none; b=tkhDxLiC3oxcibbKOWgsZKWFFO8KlYCWMhO6USZKqofLvxFDAa0rJNtFWaimMvAcmh0o1Ego5tswGZWWJWQ1MFbMwV76f8m89cZOtsvYSQLox6DKtm6N5ZmOuuKQPxxqNDDzgtgBOQpwrZpTGz7kl4dneb58V//9CtaPtafnWc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792060259; c=relaxed/simple;
	bh=KL50O/iWsTHmbo6NadhTpGohH+0IwIFZqJc3pja8taE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=DlIvn4fOH3euMt1bj1uyJwmfofP9cfIKs+Iz/NauhIBquUXadxRqYGQQFXl+DPo+lCmlGm/9uOgxOOTXqv8Wl2HpwsZzFBaJGnxMi4eDPgrMy8ibUYM9B62gvAnhmHmVt4e3Zq05oQL26lvPBBiS8O1IyonuLmwoqLn8iF805wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LQtHygRS; arc=none smtp.client-ip=91.218.175.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LQtHygRS"
X-Envelope-To: iommu@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=KL50O/iWsTHmbo6NadhTpGohH+0IwIFZqJc3pja8taE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792060255; v=1; x=1792665055;
 b=LQtHygRSVbiX/tqocinrRwPZYKTkWTJ6aD/vJe6ehxQdft2TFWZSueOOBh6MnqHfRQGag1DN
 W6GoQGbL6WXpUxmnNbYEgm10kkLtPeTQ4nbjdTfxoQXIc0kL5xKvlgpMOo1S7uXDL3p4L/zGCtn
 8rddGaTkUafnq9OoGKhpzv2M=
X-Envelope-To: iommu@lists.linux.dev
Received: by mta11.migadu.com with ESMTPS id dd78c0c2979e365e;
	Thu, 15 Oct 2026 10:30:55 +0000
X-Mizu-Trace-ID: dd78c0c2979e365e
X-Migadu-Flow: FLOW_OUT
Message-ID: <f4f48392-4181-456e-b3d7-907a30b13825@linux.dev>
Date: Thu, 15 Oct 2026 11:30:49 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [PATCH] Revert "nvme-pci: clamp max_hw_sectors
 based on DMA optimized limitation"
From: John Garry <john.garry@linux.dev>
To: Christoph Hellwig <hch@lst.de>, Adrian Huang12 <ahuang12@lenovo.com>
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
Content-Language: en-US
In-Reply-To: <8894307f-1042-497c-9c16-3fc1312486fb@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/12/26 15:39, John Garry wrote:
> On 10/12/26 13:17, Christoph Hellwig wrote:
>> On Mon, Oct 12, 2026 at 09:42:04AM +0100, John Garry wrote:
>>> And now we seem to have a conflict, as Christoph wants block size > IOVA
>>> rcache limit but you find it may cause this soft lockup.
>>>
>>>> 2. Another NVME with mdts=5 (maximum data transfer size = 128KB)
>>>>     2.1 The issue does not reproduce regardless of the 'bs' 
>>>> configuration
>>>> 3. The condition '128 KB' is identified because the IOMMU scalable 
>>>> IOVA mechanism supports a maximum transfer size of 128 KB.
>>>> 4. IOMMU pass-through mode does not trigger the issue with the 
>>>> 'mdts=10' nvme disk.
>>>> 5. The issue only appears with high-core-count servers
>>>>     5.1 Reproduced servers: 448-core server and 384-core server
>>>>     5.2 Non-reproduced server: 128-core server
>>>
>>> How long does it take for the lockup to trigger? Pretty quickly, I 
>>> guess.
>>>
>>> Does changing the number of CPUs affect throughput (before the 
>>> lockup)? Are
>>> you using just a single disk?
>>
>> If the iova cache locks up under a perfectly normal workloads it
>> is broken. 
> 
> 
>> We really need to fix the code there.
> 
> Sure, but it would help to first fully understand the conditions to fix it.

BTW, @Adrian, it would be good to run your test with the IOMMU in strict 
mode as well, just to give an idea if there is a problem there as well.
