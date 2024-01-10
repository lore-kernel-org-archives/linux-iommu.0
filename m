Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7252D482C4
	for <iommu@lists.linux.dev>; Wed, 10 Jan 2024 12:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 093B92F4;
	Wed, 10 Jan 2024 04:49:05 -0800 (PST)
Received: from [10.57.77.141] (unknown [10.57.77.141])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9B1643F64C;
	Wed, 10 Jan 2024 04:48:16 -0800 (PST)
Message-ID: <ab22c439-e7da-49b5-b20b-856daf376c02@arm.com>
Date: Wed, 10 Jan 2024 12:48:06 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] iommu/iova: Make the rcache depot properly
 flexible
To: Ido Schimmel <idosch@idosch.org>
Cc: joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, zhangzekun11@huawei.com,
 john.g.garry@oracle.com, dheerajkumar.srivastava@amd.com,
 jsnitsel@redhat.com, Catalin Marinas <catalin.marinas@arm.com>
References: <cover.1694535580.git.robin.murphy@arm.com>
 <ZY1osaGLyT-sdKE8@shredder> <c9cf02b5-7add-46ea-8db1-46fdce191c1c@arm.com>
 <ZZ2AqZT4dD-s01q9@shredder>
Content-Language: en-GB
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <ZZ2AqZT4dD-s01q9@shredder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-01-09 5:21 pm, Ido Schimmel wrote:
> Hi Robin,
> 
> Thanks for the reply.
> 
> On Mon, Jan 08, 2024 at 05:35:26PM +0000, Robin Murphy wrote:
>> Hmm, we've got what looks to be a set of magazines forming a plausible depot
>> list (or at least the tail end of one):
>>
>> ffff8881411f9000 -> ffff8881261c1000
>>
>> ffff8881261c1000 -> ffff88812be26400
>>
>> ffff88812be26400 -> ffff8188392ec000
>>
>> ffff8188392ec000 -> ffff8881a5301000
>>
>> ffff8881a5301000 -> NULL
>>
>> which I guess has somehow become detached from its rcache->depot without
>> being freed properly? However I'm struggling to see any conceivable way that
>> could happen which wouldn't already be more severely broken in other ways as
>> well (i.e. either general memory corruption or someone somehow still trying
>> to use the IOVA domain while it's being torn down).
> 
> The machine is running a debug kernel that among other things has KASAN
> enabled, but there are no traces in the kernel log so there is no memory
> corruption that I'm aware of.
> 
>> Out of curiosity, does reverting just patch #2 alone make a difference?
> 
> Will try and let you know.
> 
>> And is your workload doing anything "interesting" in relation to IOVA
>> domain lifetimes, like creating and destroying SR-IOV virtual
>> functions, changing IOMMU domain types via sysfs, or using that
>> horrible vdpa thing, or are you seeing this purely from regular driver
>> DMA API usage?
> 
> The machine is running networking related tests, but it is not using
> SR-IOV, VMs or VDPA so there shouldn't be anything "interesting" as far
> as IOMMU is concerned.
> 
> The two networking drivers on the machine are "igb" for the management
> port and "mlxsw" for the data ports (the machine is a physical switch).
> I believe the DMA API usage in the latter is quite basic and I don't
> recall any DMA related problems with this driver since it was first
> accepted upstream in 2015.

Thanks for the clarifications, that seems to rule out all the most 
confusingly impossible scenarios, at least.

The best explanation I've managed to come up with is a false-positive 
race dependent on the order in which kmemleak scans the relevant 
objects. Say we have the list as depot -> A -> B -> C; the rcache object 
is scanned and sees the pointer to magazine A, but then A is popped 
*before* kmemleak scans it, such that when it is then scanned, its 
"next" pointer has already been wiped, thus kmemleak never observes any 
reference to B, so it appears that B and (transitively) C are "leaked". 
If that is the case, then I'd expect it should be reproducible with 
patch #1 alone (although patch #2 might make it slightly more likely if 
the work ever does result in additional pops happening), but I'd expect 
the leaked objects to be transient and not persist forever through 
repeated scans (what I don't know is whether kmemleak automatically 
un-leaks an object if it subsequently finds a new reference, or if it 
needs manually clearing in between scans). I'm not sure if there's a 
nice way to make that any better... unless maybe it might make sense to 
call kmemleak_not_leak(mag->next) in iova_depot_pop() before that 
reference disappears?

Thanks,
Robin.
