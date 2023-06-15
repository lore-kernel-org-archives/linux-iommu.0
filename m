Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B63C525B
	for <iommu@lists.linux.dev>; Thu, 15 Jun 2023 09:05:05 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 390011FB;
	Thu, 15 Jun 2023 02:05:38 -0700 (PDT)
Received: from [10.57.85.251] (unknown [10.57.85.251])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C18CA3F71E;
	Thu, 15 Jun 2023 02:04:52 -0700 (PDT)
Message-ID: <198a73b0-d7c0-57d6-5ef9-4e9dddb6365b@arm.com>
Date: Thu, 15 Jun 2023 10:04:47 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4] iommu: Optimise PCI SAC address trick
Content-Language: en-GB
To: John Garry <john.g.garry@oracle.com>, Jakub Kicinski <kuba@kernel.org>,
 Joerg Roedel <joro@8bytes.org>
Cc: will@kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>
References: <b8502b115b915d2a3fabde367e099e39106686c8.1681392791.git.robin.murphy@arm.com>
 <ZDk83vpIarQ9jWa7@8bytes.org> <20230613105850.30172085@kernel.org>
 <4f9184c5-e6a2-08da-f44a-3000b6cdfe35@oracle.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <4f9184c5-e6a2-08da-f44a-3000b6cdfe35@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023-06-15 08:49, John Garry wrote:
> On 13/06/2023 18:58, Jakub Kicinski wrote:
>> On Fri, 14 Apr 2023 13:45:34 +0200 Joerg Roedel wrote:
>>> Thanks for working on this, I think this is good to go. But given the
>>> issues we had with last attempt I'd like to have this in linux-next for
>>> a few weeks before sending it upstream. Therefore I will defer this
>>> patch and merge it early in the next cycle.
>> Is this patch queued up? I don't see it in linux-next and we keep
>> hitting this issue in production. After a few NIC reconfigurations
>> IOMMU starts consuming 90+% of CPU time.
>>
> 
> Since we're at rc6 time and a cautious approach was wanted to merge this 
> change, I doubt that this will be merged for this cycle. That's quite 
> unfortunate.
> 
> Please note what I mentioned earlier about using dma_opt_mapping_size(). 
> This API is used by some block storage drivers to avoid your same 
> problem, by clamping max_sectors_kb at this size - see sysfs-block Doc 
> for info there. Maybe it can be used similarly for network drivers.

It's not the same problem - in this case the mappings are already small 
enough to use the rcaches, and it seems more to do with the total number 
of unusable cached IOVAs being enough to keep the 32-bit space 
almost-but-not-quite full most of the time, defeating the 
max32_alloc_size optimisation whenever the caches run out of the right 
size entries.

The manual workaround for now would be to boot with "iommu.forcedac=1" 
and hope that no other devices break because of it.

Thanks,
Robin.
