Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3675723393C
	for <iommu@lists.linux.dev>; Tue, 11 Aug 2026 12:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786453064; cv=none; b=eGbgWiyppETMBcdQQCT4JLZ3ETMgwr2NFG+j5seHwQq+YfaM2BuC4HX4SkjAPZeYidfnDyihYGMkQHKxDTO9eHaUhVO+6yy6gVC2khk5wdXR8oiTjWbGn6534HAwTMnTkE9QS9rsL/5d/K+xxXuA/FZM7skq2DjnowS632HHUao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786453064; c=relaxed/simple;
	bh=S8n/qZMR4SjsKjo73KVrf9Wu77ZJ5J5WTtrZrAifRNg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XEHhXHRad57hufk6x98TDzODIN8ITbXD0S+6w8gdrQGJqlGFCcYxNITFCyecoD7q+hSSppVlndUtM8qpcTXvRzu8lZn9ls4fbWotMRAevKYdBcnO3O2FF8GalXrxWgjbEeXnUfp4PgOmA3TziYCcrGaGVcj0MuX3XpQ2QhVJduE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=rO00+f+g; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="rO00+f+g"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 82D261516;
	Tue, 11 Aug 2026 05:57:37 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3EDE23F86F;
	Tue, 11 Aug 2026 05:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786453061; bh=S8n/qZMR4SjsKjo73KVrf9Wu77ZJ5J5WTtrZrAifRNg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rO00+f+gNzn0aFZo++rCU9ZFWPE43krT6X3AtOIEZmvatZKwPF1HULo7TWdhwoVie
	 ZtLRUiy3diVokk06c9qI8s8w9lgcCUhN0OULv6I3zjuP6bMKNVaYA6h0LqFG2yoHv2
	 85bcGhC8wRvdSADnF96yF2xdN9Uve7N8r3guiyvs=
Message-ID: <6f650cc2-b4fd-4305-b4d7-847ef935449a@arm.com>
Date: Tue, 11 Aug 2026 13:57:38 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [iommu?] KASAN: slab-use-after-free Read in free_iova
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: syzbot <syzbot+90c2d711b5218d10ce61@syzkaller.appspotmail.com>,
 baolu.lu@linux.intel.com, dwmw2@infradead.org, iommu@lists.linux.dev,
 joro@8bytes.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com, will@kernel.org
References: <6a7910da.9c11d2ce.289b96.00da.GAE@google.com>
 <68eebaf3-2427-48c0-93d3-87455ff266fb@arm.com>
 <20260810173230.GQ200537@ziepe.ca>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260810173230.GQ200537@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/08/2026 6:32 pm, Jason Gunthorpe wrote:
> On Mon, Aug 10, 2026 at 11:50:28AM +0100, Robin Murphy wrote:
>>> Freed by task 5327:
>>>    kasan_save_stack mm/kasan/common.c:57 [inline]
>>>    kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
>>>    kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:584
>>>    poison_slab_object mm/kasan/common.c:253 [inline]
>>>    __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:285
>>>    kasan_slab_free include/linux/kasan.h:235 [inline]
>>>    slab_free_hook mm/slub.c:2677 [inline]
>>>    slab_free mm/slub.c:6377 [inline]
>>>    kmem_cache_free+0x182/0x650 mm/slub.c:6504
>>>    free_iova_mem drivers/iommu/iova.c:237 [inline]
>>>    put_iova_domain+0xcc/0x100 drivers/iommu/iova.c:454
>>
>> ...except that right in between here we've called iommu_dma_free_fq() which
>> would have already invoked timer_delete_sync() and freed the queue itself.
>> Wut?
> 
> I've been feeding syzkaller riddles to the best AI I can get and it is
> surprisingly good.. So, for this it guesses:
> 
> ---
> timer_delete_sync() does stop already scheduled work, but it does not
> prevent a future mod_timer() from re-scheduling the now-deleted timer.
> 
> The probable sequence is:
> 
> 1. A DMA unmap queues an IOVA and sets fq_timer_on = 1 at dma-iommu.c
>     (line 243), but has not yet executed mod_timer().
> 
> 2. Concurrent PCI removal frees the device's default IOMMU
>     domain.
> 
> 3. iommu_dma_free_fq() calls timer_delete_sync() at dma-iommu.c (line
>     274). Because the timer is not pending at that instant, it returns.
> 
> 4. Teardown frees the flush queue and all IOVA-tree nodes through
>     put_iova_domain() (line 446).
> 
> 5. The unmap path resumes and executes mod_timer(), rearming a timer
>     embedded in the soon-to-be-freed DMA cookie.

But where would that unmap be? We're in a notifier near the end of 
device_del() here - the device is already very very dead, so anyone 
still using it for DMA doesn't simply have some subtle race. It 
seemingly couldn't even be in the device's driver, since pci_stop_dev() 
has also already unbound that, so it would presumably have to be an even 
more egregious subsystem-level UAF...

As I say though, the fact that it always appears to be an IOVA from 
reserve_iova() on the flush queue would seem to be the smoking gun 
pointing to this being well outside the scope of normal operation 
anyway. From one of the logs it seems that 00:01.0 belongs to lpc_ich, 
which is an MFD driver, so given the fact that it's an on-board chipset 
device, plus the tricks MFD plays to hang platform devices and their 
drivers off a PCI device, I could well imagine it has never expected to 
deal with removal very well, so I'm definitely leaning more toward some 
prior state corruption triggering this...

Cheers,
Robin.

> 6. fq_flush_timeout() later runs and calls free_iova_fast(). It
>     traverses the already-destroyed IOVA rbtree, producing the reported
>     UAF in private_find_iova() (line 275).
> ---
> 
> Which seems plausible to me.. So it is a bug in a driver allowing a
> dma API operation to be outstanding after it has been removed?
> 
> syzkaller console showed it did trigger a remove of a PCI function:
> 
> open("./sys/bus/pci/devices/0000:00:01.0/remove", O_WRONLY)
> write(fd, "1", 1)
> 
> But I couldn't guess what device that was, if someone from syzkaller
> land can clarify what they have plugged in there it might help.
> 
> The AI guessed on a GCE VM it was a display adaptor, but I don't see
> how it could know that.
> 
> It would be a nice improvement to the CONFIG DMA DEBUGGING to keep
> track of the driver bound state and blow up directly on all these
> forbidden combinations.
> 
> Jason

