Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E833C1D
	for <iommu@lists.linux.dev>; Tue, 15 Aug 2023 11:11:39 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6401A1063;
	Tue, 15 Aug 2023 04:12:21 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 379853F762;
	Tue, 15 Aug 2023 04:11:38 -0700 (PDT)
Message-ID: <b9bda816-612c-b646-63e7-54cb3fedf1f4@arm.com>
Date: Tue, 15 Aug 2023 12:11:33 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 0/2] iommu/iova: Make the rcache depot properly flexible
Content-Language: en-GB
To: John Garry <john.g.garry@oracle.com>, joro@8bytes.org
Cc: will@kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 zhangzekun11@huawei.com
References: <cover.1692033783.git.robin.murphy@arm.com>
 <80fb865a-eb45-e783-277d-0d2e044c28f5@oracle.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <80fb865a-eb45-e783-277d-0d2e044c28f5@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/08/2023 11:24 am, John Garry wrote:
> On 14/08/2023 18:53, Robin Murphy wrote:
>> Hi all,
>>
> 
> Hi Robin,
> 
>> Prompted by [1], which reminded me I started this a while ago, I've now
>> finished off my own attempt at sorting out the horrid lack of rcache
>> scalability. It's become quite clear that given the vast range of system
>> sizes and workloads there is no right size for a fixed depot array, so I
>> reckon we're better off not having one at all.
>>
>> Note that the reclaim threshold and rate are chosen fairly arbitrarily -
> 
> This threshold is the number of online CPUs, right?

Yes, that's nominally half of the current fixed size (based on all the 
performance figures from the original series seemingly coming from a 
16-thread machine, but seemed like a fair compromise. I am of course 
keen to see how real-world testing actually pans out.

>> it's enough of a challenge to get my 4-core dev board with spinning disk
>> and gigabit ethernet to push anything into a depot at all :)
>>
> 
> I have to admit that I was hoping to also see a more aggressive reclaim 
> strategy, where we also trim the per-CPU rcaches when not in use. 
> Leizhen proposed something like this a long time ago.

Don't think I haven't been having various elaborate ideas for making it 
cleverer with multiple thresholds and self-tuning, however I have 
managed to restrain myself ;)

At this point I'm just looking to confirm whether the fundamental 
concepts are sound, and at least no worse than the current behaviour 
(hence keeping it split into 2 distinct patches for the sake of review 
and debugging). If it proves solid then we can absolutely come back and 
go to town on enhancements later.

Cheers,
Robin.
