Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7063AFCE6;
	Tue, 13 Oct 2026 10:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791888138; cv=none; b=ufEfuDjQf+wAjJHG04I+f4sRl+6R4uJF5Ih7BlHlRdjbcwDRDJ7/CkrwnEJCgda8n3NmT6baAzGHCiwrtUTnvTCmFd6kymOKVrcVWyp/qFneVfFDACBtA68v81eIYeU3lZOr5YFjH8uwfBLSP1NR/Igmlied2n4yggIIE7YBt9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791888138; c=relaxed/simple;
	bh=W9IOmZd6NCBQxQe8yp/0nFe31/tEy/JGEmdFhfz3Zx0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yhq9SLTs0K8baeyNt/RVdBgLyeGe8YFeHSrsnbJXGXqokSudPU0s12TXAFaHUUGuVbhrdPTzkuMygjksv3ugjfeyvcOEw0iXOQ4s6Q5aHbQTpV3UXyaJpadH0TqOjiYSQt10XFRMTRCPQJRhhxWN+RfghnkndrpOKHjTQ9RLnBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=p4vMjRtm; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="p4vMjRtm"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 53FBA169C;
	Tue, 13 Oct 2026 03:42:13 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C226D3F7B4;
	Tue, 13 Oct 2026 03:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1791888136; bh=W9IOmZd6NCBQxQe8yp/0nFe31/tEy/JGEmdFhfz3Zx0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=p4vMjRtm+hGJY8UPjqMDOtxJKflXmrP2vqY/17xouBvpxZsfR430vOeHQp+g4HZHp
	 i7cTDvCFclitDTgkIqF0/Rs5AUZgo0y+FddOHuWp92YB0Xjt5EVyzFCvtHFSv8ObTr
	 iK08tMyzkAMpaUd65pUDChJk7GDyTxVjCmLAWF0c=
Message-ID: <4fda41ed-741b-4c5f-ae83-e3ea5a447441@arm.com>
Date: Tue, 13 Oct 2026 11:42:09 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC: DMA_PMD 00/22] DMA_PMD: PMD_SIZE-backed IO buffer pools
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 Luigi Rizzo <lrizzo@google.com>
Cc: Luigi Rizzo <rizzo.unipi@gmail.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Vlastimil Babka <vbabka@kernel.org>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Danilo Krummrich
 <dakr@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima
 <kuniyu@google.com>, Joshua Washington <joshwash@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>, iommu@lists.linux.dev,
 netdev@vger.kernel.org, linux-mm@kvack.org, driver-core@lists.linux.dev,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261003212241.3432303-1-lrizzo@google.com>
 <0cc1cac1-a500-489b-9c1b-b49598b5550b@kernel.org>
 <CAMOZA0JaiKsRgDdjHkL_N+MshhcyLSv+cT9SzEbNsC_sumHvOw@mail.gmail.com>
 <b31efcd5-149c-4edf-81a2-1744d363c390@kernel.org>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <b31efcd5-149c-4edf-81a2-1744d363c390@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/10/2026 8:43 pm, David Hildenbrand (Arm) wrote:
> On 10/12/26 16:45, Luigi Rizzo wrote:
>> On Mon, Oct 12, 2026 at 3:51 PM David Hildenbrand (Arm)
>> <david@kernel.org> wrote:
>>>
>>> On 10/3/26 23:22, Luigi Rizzo wrote:
>>>> Here is a subsystem called DMA_PMD on which I would like feedback on
>>>> architecture, possible enhancements, or kernel components that could be
>>>> reused to avoid duplication.
>>>
>>> Here is a feedback to a subsystem called DMA_PMD ;)
>>>
>>> Why is basing this on PMDs (and embedding it in the name) the right approach?
>>>
>>> On architctures with large PMDs (512 MiB on arm64 with 64k), would we really
>>> want to use 512 MiB pages, or rather something smaller (e.g., 2 MiB) that might
>>> possibly also have TLB benefits (cont-pte)?
>>
>> I had to call it something... an earlier prototype used the name IOMMU_2M,
>> but I didn't want to suggest that the design was limited to 2M (it is not).
>>
>> Aside from the name, the _current_ prototype restricts to 2M allocations,
>> exactly because too large units are expensive and wasteful.
>>
>> In the code, decoupling the allocation size from the PMD size is trivial.
> 
> Yeah, we should do that.
> 
> We should probably just find a way to describe that this is a POOL that focuses
> on physical contiguity in some configured granularity.
And since it's intended for DMA we could call it dma_pool and oh look it 
already exists...

Sure the current implementation is capped at PAGE_SIZE for allocation 
(and thus mapping too), but I don't see why that couldn't just be made 
more flexible.

Thanks,
Robin.
