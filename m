Received: from mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9577748EC68
	for <iommu@lists.linux.dev>; Mon, 12 Oct 2026 14:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791815986; cv=none; b=UNeJ41KCm7PdTHNjHeuPgh4aDHjNJzemHUKUXepBvFtqiigIcpICaeP46HSm8ZmA/N6D/y/CXIHoiYb6WR78UCxQz2kl9AmWwtswarftb1qAm9WdAgJ+mXmb09ivbSR8fsv4t7BIJyCpUVmrAbVumP/vKncM1REXoKqhn311R6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791815986; c=relaxed/simple;
	bh=CEkn6V5ALhhqhhpxb3OWlxXupE8t6sIgFZ0BVdRWG90=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZfQmVOdxTeYwgl9mpLwoQiquDVwsyozS1hmcBen8vb0kqvfr2mM64oOMbcA++QmIEibHb44R0ALysUTpsPjDs+Ur6t+xGK1ZLFOkfZih24eQ0XFHypANcoJt2Y9ug4iinS14SKeSynWsT04fiMBvYABrVCu32URmejRD7j+6GT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mdCytkoS; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mdCytkoS"
X-Envelope-To: iommu@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=CEkn6V5ALhhqhhpxb3OWlxXupE8t6sIgFZ0BVdRWG90=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791815981; v=1; x=1792420781;
 b=mdCytkoSLrzPBrXSb6TPfgPUphJ/NUPDhEGvUnJTGA/XcBrDJm0n63PNRkBO0F/mT7DKCquG
 6P23U0b7lVFP6pP3ojn+9oIwDXFGeV9g1KgUAC8ewe92sduxyrwgxym0wN1hVWR7zsEOF74aFEs
 QnRiTRqgZRagLLfXqU9/Ya9A=
X-Envelope-To: iommu@lists.linux.dev
Received: by mta12.migadu.com with ESMTPS id c71f62ae9e69f9bb;
	Mon, 12 Oct 2026 14:39:41 +0000
X-Mizu-Trace-ID: c71f62ae9e69f9bb
X-Migadu-Flow: FLOW_OUT
Message-ID: <8894307f-1042-497c-9c16-3fc1312486fb@linux.dev>
Date: Mon, 12 Oct 2026 15:39:36 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [PATCH] Revert "nvme-pci: clamp max_hw_sectors
 based on DMA optimized limitation"
To: Christoph Hellwig <hch@lst.de>
Cc: Adrian Huang12 <ahuang12@lenovo.com>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "sagi@grimberg.me"
 <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Jiwei JW10 Sun <sunjw10@lenovo.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>
References: <20261006120248.147654-1-hch@lst.de>
 <8cf8a8ea-c9c9-434b-aec6-e361280a88a4@linux.dev>
 <20261008123724.GA22096@lst.de>
 <TPZP295MB0013C6E51C73799E49B8EFF4B3922@TPZP295MB0013.TWNP295.PROD.OUTLOOK.COM>
 <2007f03b-2c76-4c36-a0bd-0ce99d1a01a2@linux.dev>
 <20261012121736.GE29954@lst.de>
Content-Language: en-US
From: John Garry <john.garry@linux.dev>
In-Reply-To: <20261012121736.GE29954@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/12/26 13:17, Christoph Hellwig wrote:
> On Mon, Oct 12, 2026 at 09:42:04AM +0100, John Garry wrote:
>> And now we seem to have a conflict, as Christoph wants block size > IOVA
>> rcache limit but you find it may cause this soft lockup.
>>
>>> 2. Another NVME with mdts=5 (maximum data transfer size = 128KB)
>>>     2.1 The issue does not reproduce regardless of the 'bs' configuration
>>> 3. The condition '128 KB' is identified because the IOMMU scalable IOVA mechanism supports a maximum transfer size of 128 KB.
>>> 4. IOMMU pass-through mode does not trigger the issue with the 'mdts=10' nvme disk.
>>> 5. The issue only appears with high-core-count servers
>>>     5.1 Reproduced servers: 448-core server and 384-core server
>>>     5.2 Non-reproduced server: 128-core server
>>
>> How long does it take for the lockup to trigger? Pretty quickly, I guess.
>>
>> Does changing the number of CPUs affect throughput (before the lockup)? Are
>> you using just a single disk?
> 
> If the iova cache locks up under a perfectly normal workloads it
> is broken. 


> We really need to fix the code there.

Sure, but it would help to first fully understand the conditions to fix it.
