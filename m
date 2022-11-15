Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E33333C7
	for <iommu@lists.linux.dev>; Tue, 15 Nov 2022 11:20:28 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9CB7A13D5;
	Tue, 15 Nov 2022 03:20:33 -0800 (PST)
Received: from [10.57.70.90] (unknown [10.57.70.90])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8016E3F73B;
	Tue, 15 Nov 2022 03:20:26 -0800 (PST)
Message-ID: <9031b28f-0431-22eb-5dd3-01ae0589b940@arm.com>
Date: Tue, 15 Nov 2022 11:20:22 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: The arm smmu driver for Linux does not support debugfs
Content-Language: en-GB
To: "leo-hou@hotmail.com" <leo-hou@hotmail.com>, iommu
 <iommu@lists.linux.dev>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 virtualization <virtualization@lists.linux-foundation.org>
Cc: will <will@kernel.org>
References: <202211141141302410923@hotmail.com>
 <MA0PR01MB5784354703A7B446A6D85CADF6049@MA0PR01MB5784.INDPRD01.PROD.OUTLOOK.COM>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <MA0PR01MB5784354703A7B446A6D85CADF6049@MA0PR01MB5784.INDPRD01.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2022-11-15 02:28, leo-hou@hotmail.com wrote:
> 
> 
> Hi,
> 
>       Why doesn't the arm smmu driver for Linux support debugfs ?

Because nobody's ever written any debugfs code for it.

> Are there any historical reasons?

Only that so far nobody's needed to.

TBH, arm-smmu is actually quite straightforward, and none of the 
internal driver state is really all that interesting (other than the 
special private Adreno stuff, but we leave it up to Rob to implement 
whatever he needs there). Given the kernel config, module parameters, 
and the features logged at probe, you can already infer how it will set 
up context banks etc. for regular IOMMU API work; there won't be any 
surprises. At this point there shouldn't be any need to debug the driver 
itself, it's mature and stable. For debugging *users* of the driver, 
I've only dealt with the DMA layer, where a combination of the IOMMU API 
tracepoints, CONFIG_DMA_API_DEBUG, and my own hacks to iommu-dma have 
always proved sufficient to get enough insight into what's being mapped 
where.

I think a couple of people have previously raised the idea of 
implementing some kind of debugfs dumping for io-pgtable, but nothing's 
ever come of it. As above, it often turns out that you can find the 
information you need from other existing sources, thus the effort of 
implementing and maintaining a load of special-purpose debug code can be 
saved. In particular it would not be worth having driver-specific code 
that only helps debug generic IOMMU API usage - that would be much 
better implemented at the generic IOMMU API level.

Thanks,
Robin.
