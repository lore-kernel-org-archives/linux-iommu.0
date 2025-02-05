Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D4371FF1DB
	for <iommu@lists.linux.dev>; Wed,  5 Feb 2025 18:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738781610; cv=none; b=WmsG69zhYKjxHV4TiZnR9rx/Jhcugi+3+LKxVeCGYi8iYk+RLc3u5uHeXyjZk811SAQvK1IpJGDBfCRxYRBE9GS9dd4KT6++NtAEpcUJZcdhQQjJjIuOcPSMpL/UQLelZduEgXxGHXSCN9SsTQPwnL3Lscrl3I6AYcZhg+c838s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738781610; c=relaxed/simple;
	bh=YI+XXeFpYm0aYXJj/XaJuizksSALY8idolNJiTmoPbw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t3rSYXgTeiAJsH68HUwCmFnogAOKGpXOMa7iw8T3eYCOHV0iU7pXeitKoD2nPB5qNPtrKtId1mLvQNotYEYfsAcd5A5gk5jgaXLF93uRfatneJ2BPClVzNEqQwBYEsLTXhZ7bPpQWI7dHgo5mTEGYo+/GB15W7URkPJhg3l+idE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C0B501063;
	Wed,  5 Feb 2025 10:53:50 -0800 (PST)
Received: from [10.57.35.21] (unknown [10.57.35.21])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6D82B3F5A1;
	Wed,  5 Feb 2025 10:53:25 -0800 (PST)
Message-ID: <ce6d471a-a863-45ca-8a35-66dbbabe47c1@arm.com>
Date: Wed, 5 Feb 2025 18:53:23 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: iommu: flood of ahci 0000:e6:00.0: AMD-Vi: Event logged
 [IO_PAGE_FAULT domain=0x0055 address=0xa14a4000 flags=0x0070]
To: Corentin Labbe <clabbe.montjoie@gmail.com>
Cc: joro@8bytes.org, suravee.suthikulpanit@amd.com, will@kernel.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 Vasant Hegde <vasant.hegde@amd.com>
References: <Z6CGzUSV7llweytQ@Red>
 <42a8ca6f-a881-4b4c-9ddb-bf3f2bc6f539@arm.com> <Z6NpZcbE6fiIkSGh@Red>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <Z6NpZcbE6fiIkSGh@Red>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025-02-05 1:36 pm, Corentin Labbe wrote:
> Le Mon, Feb 03, 2025 at 01:01:45PM +0000, Robin Murphy a écrit :
>> On 2025-02-03 9:05 am, Corentin Labbe wrote:
>>> Hello
>>>
>>> I have a supermicro server which is flooded of kernel message:
>>> ahci 0000:e6:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0055 address=0xa14a4000 flags=0x0070]
>>>
>>> The server works perfectly anyway.
>>> It happens with official ubuntu kernel vmlinuz-6.8.0-51-generic.
>>> I tried also a custom 6.12.6, same problem.
>>>
>>> I tried to update bios, no change.
>>> I tried iommu=soft, no change.
>>>
>>> I dont know what to do next.
>>>
>>> Regards
>>>
>>
>>> IOMMU group 83 e6:00.0 SATA controller [0106]: Marvell Technology Group Ltd. 88SE9230 PCIe 2.0 x2 4-port SATA 6 Gb/s RAID Controller [1b4b:9230] (rev 11)
>>
>> Wow, a Marvell SATA controller doing something other than the usual
>> phantom function quirk, that's a nice change :D
>>
>> I'd guess that firmware has left it running for something like legacy
>> IDE emulation (if that's still a thing?) or its own soft-RAID driver,
>> but neglected to declare an IVMD entry to described the reserved memory
>> region(s) it's using for that. A smoking gun would be if 0xa14a4000
>> matches some firmware-reserved PA in the system memory map. In that
>> case, if you're lucky you might have some firmware/BIOS option to
>> disable fancy behaviour and leave it in plain AHCI mode. Otherwise,
>> booting with "iommu.passthrough=1" (or the even bigger hammer of
>> "amd_iommu=off") should at least allow you to ignore the issue.
>>
> 
> Hello
> 
> Thanks for your help
> 
> There was no AHCI option in the BIOS (appart hotplug enable).
> 
> Adding iommu.passthrough=1 lead to absence of thoses messages.
> 
> Unfortunatly, my example is not correct, the address is mostly random:
> dmesg |grep IO_PAGE_FAULT | grep -o 'address=0x[0-9a-f]*' | sort | uniq -c | wc -l
> 9297
> 
> dmesg |grep IO_PAGE_FAULT | grep -o 'address=0x[0-9a-f]*' | sort | uniq -c | head
>        2 address=0x1101f000
>        2 address=0x1101f004
>        3 address=0x1102f000
>        1 address=0x1102f004
>        2 address=0x1102f008
>        2 address=0x1102f010
>        2 address=0x11043000
>        2 address=0x11043004
>        1 address=0x11047000
>        1 address=0x11047004
> 
> dmesg |grep IO_PAGE_FAULT | grep -o 'address=0x[0-9a-f]*' | sort | uniq -c | tail
>        2 address=0xfffffffffe751004
>        2 address=0xfffffffffe7e6000
>        2 address=0xfffffffffe7e6004
>        4 address=0xfffffffffe823000
>        3 address=0xfffffffffe823004
>        2 address=0xfffffffffe830000
>        2 address=0xfffffffffe830004
>        3 address=0xfffffffffe833000
>        1 address=0xfffffffffe833004
>        1 address=0xfffffffffe833008

OK, these look like iommu-dma addresses, and the fact that they're up 
into the full 64-bit space implies that the 32-bit ones are most likely 
also kernel DMA burning through the whole 32-bit IOVA space rather than 
inadvertent physical address (and possibly the SATA driver is leaking 
DMA mappings as it keeps getting errors and retrying?). Indeed it seems 
the firmware stuff probably was a red herring.

I guess that then points to a question of whether it's maybe just the 
SATA driver going wonky and trying to make the device write to a 
DMA_TO_DEVICE mapping, or something going awry at the IOMMU to divert 
the device accesses to a different address space from the one iommu-dma 
believes it's using...

> But the domain/flags are always the same
> 
> Full dmesg (without IOMMU messages) https://uk01.z.antigena.com/l/VspdfbZQLwA2gZviRaGoPfE2bAxamMd9VFWOj4n78OuhpCoBo5HcXgWgXfTVvyxW1R3W9GTx4RbHm1MGyqBINkuTrnW31h9eTfLTUvXfcYh-IaTwmSc5kZo_-iU9-qQLbKsIjA9LNxyfbAA2AKGOSws6K4vuOrR6i-DL5DiQW1gHCrhhBMgE0Y7RK2m9
> 
> The server is doing qemu GPU passthough via VFIO.
> I believe (aka I need to re-verify) that message start whatever qemu starts or not.

Oh, it's certainly not impossible that that getting VFIO involved may 
tickle some bug or misconfiguration wherein the wrong device ends up 
inadvertently attached to the wrong domain. I don't know the ins and 
outs of debugging with the AMD driver, though, so I think this is the 
point where I have to leave this one to Vasant :)

Thanks,
Robin.
