Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8B6146A79
	for <iommu@lists.linux.dev>; Thu, 13 Jun 2024 16:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718296706; cv=none; b=dZ4Ni8zUzToXKapq6t6t0d7KlaO0bvbJts+xblth8Zdl8LzJqKMtnBsJ3YE2eRsisEJvZjfDNkfdcAhgZZ4lCverdDxqS/IAcqLgkYq1J1+D+O/JCfW4wOatmoKDTndCvNljQhYNWajwlTjQGzrMdZ32oexEccFodDtPgKnO+Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718296706; c=relaxed/simple;
	bh=aKOhNOdB7ccnzq+ofFI1uzD4Kj+zLwM5PbYdAt6B0RE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X4Ihfi/4PTXfui3XsURYhg4PPbaudfsrc0yoZ6nrtBe2v8Alf8/nf+SPs1p866kN8lo3PYZFKDG2uIB1YYmVoPQP3YMkXn23NV6UbSod4jXQarUahzukT5NqnYkHBT9GuOEOhBshL+sutrbEWCs1G+jdg3CdZM53YMw8+qCGIo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2F821FEC;
	Thu, 13 Jun 2024 09:38:48 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 012363F73B;
	Thu, 13 Jun 2024 09:38:21 -0700 (PDT)
Message-ID: <002b6176-41b3-4888-abb1-978399d108b8@arm.com>
Date: Thu, 13 Jun 2024 17:38:20 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/4] of: reserved_mem: Restruture how the reserved
 memory regions are processed
To: Conor Dooley <conor@kernel.org>,
 Oreoluwa Babatunde <quic_obabatun@quicinc.com>
Cc: Mark Brown <broonie@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 robh@kernel.org, saravanak@google.com, hch@lst.de, m.szyprowski@samsung.com,
 will@kernel.org, catalin.marinas@arm.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, kernel@quicinc.com
References: <20240528223650.619532-1-quic_obabatun@quicinc.com>
 <20240528223650.619532-2-quic_obabatun@quicinc.com>
 <20240610213403.GA1697364@thelio-3990X>
 <Zmd0Zg7oMneJLyHd@finisterre.sirena.org.uk>
 <cc180d94-6890-4e92-8080-ffd6c1269e6e@quicinc.com>
 <20240613-goldfish-unpicked-1bc9f786aaed@spud>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20240613-goldfish-unpicked-1bc9f786aaed@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/06/2024 5:17 pm, Conor Dooley wrote:
> On Thu, Jun 13, 2024 at 09:05:18AM -0700, Oreoluwa Babatunde wrote:
>>
>> On 6/10/2024 2:47 PM, Mark Brown wrote:
>>> On Mon, Jun 10, 2024 at 02:34:03PM -0700, Nathan Chancellor wrote:
>>>> On Tue, May 28, 2024 at 03:36:47PM -0700, Oreoluwa Babatunde wrote:
>>>>> fdt_init_reserved_mem() is also now called from within the
>>>>> unflatten_device_tree() function so that this step happens after the
>>>>> page tables have been setup.
>>>>> Signed-off-by: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
>>>> I am seeing a warning when booting aspeed_g5_defconfig in QEMU that I
>>>> bisected to this change in -next as commit a46cccb0ee2d ("of:
>>>> reserved_mem: Restruture how the reserved memory regions are
>>>> processed").
>>> I'm also seeing issues in -next which I bisected to this commit, on the
>>> original Raspberry Pi the cpufreq driver fails to come up and I see
>>> (potentially separate?) backtraces:
>>>
>>> [    0.100390] ------------[ cut here ]------------
>>> [    0.100476] WARNING: CPU: 0 PID: 1 at mm/memory.c:2835 __apply_to_page_range+0xd4/0x2c8
>>> [    0.100637] Modules linked in:
>>> [    0.100665] CPU: 0 PID: 1 Comm: swapper Not tainted 6.10.0-rc2-next-20240607 #1
>>> [    0.100692] Hardware name: BCM2835
>>> [    0.100705] Call trace:
>>> [    0.100727]  unwind_backtrace from show_stack+0x18/0x1c
>>> [    0.100790]  show_stack from dump_stack_lvl+0x38/0x48
>>> [    0.100833]  dump_stack_lvl from __warn+0x8c/0xf4
>>> [    0.100888]  __warn from warn_slowpath_fmt+0x80/0xbc
>>> [    0.100933]  warn_slowpath_fmt from __apply_to_page_range+0xd4/0x2c8
>>> [    0.100983]  __apply_to_page_range from apply_to_page_range+0x20/0x28
>>> [    0.101027]  apply_to_page_range from __dma_remap+0x58/0x88
>>> [    0.101071]  __dma_remap from __alloc_from_contiguous+0x6c/0xa8
>>> [    0.101106]  __alloc_from_contiguous from atomic_pool_init+0x9c/0x1c4
>>> [    0.101169]  atomic_pool_init from do_one_initcall+0x68/0x158
>>> [    0.101223]  do_one_initcall from kernel_init_freeable+0x1ac/0x1f0
>>> [    0.101267]  kernel_init_freeable from kernel_init+0x1c/0x140
>>> [    0.101309]  kernel_init from ret_from_fork+0x14/0x28
>>> [    0.101344] Exception stack(0xdc80dfb0 to 0xdc80dff8)
>>> [    0.101369] dfa0:                                     00000000 00000000 00000000 00000000
>>> [    0.101393] dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
>>> [    0.101414] dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
>>> [    0.101428] ---[ end trace 0000000000000000 ]---
>>>
>>> Full boot log at:
>>>
>>>     https://lava.sirena.org.uk/scheduler/job/374962
>>>
>>> You can see the report of cpufreq not being loaded in the log.
>>>
>>> NFS boots also fail, apparently due to slowness bringing up a Debian
>>> userspace which may well be due to cpufreq isues:
>> Hi Mark & Nathan,
>>
>> Taking a look at this now and will provide a fix soon if
>> needed.
>>
>> At first glance, it looks like there are a couple of WARN_ON*
>> function calls in __apply_to_page_range(). Please could
>> you run faddr2line and tell me which of the WARN_ON*
>> cases we are hitting?
> 
> That shouldn't be needed, right? The line is in the WARNING: mm/memory.c:2835
> which, in next-20240607, is: if (WARN_ON_ONCE(pmd_leaf(*pmd))).

Indeed, and the overall implication there would seem to be that, because 
the dynamic CMA region wasn't allocated and reserved before we created 
the pagetables, we thus haven't created the pagetables in a shape which 
can accommodate chopping it out again later. Note that on arm64 at 
least, this is liable to be hidden by other options like rodata_full and 
debug_pagealloc - see can_set_direct_map().

Thanks,
Robin.
