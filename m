Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780B4261B8D
	for <iommu@lists.linux.dev>; Wed, 18 Mar 2026 03:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773804287; cv=none; b=aDs/P3GdAYTQETp5B030Gq479fV1w4V+UzzEQqhAZCVJHQYGZPClimQEY1U9v4OssUPovtv6uyXwDCCTWyGlGU2t4/YYqXpI5zcjYNty32qHkKnWtTNRg0X+nCgLapGczRgWXAEccKhM3g4k49LwBSzcdVmZlDSo8dAb5c8UGLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773804287; c=relaxed/simple;
	bh=m+ir1o9xz9qrAK3zBYDZuicL4xj+gCWXQksiKo9UWc4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tenHvISKD0hp/MM7KUC9PeUM2mNwy5RMIjGg9jmURsYfh3Nfclil+g3kLOYSBR0I6VM/Iz3k12Y2vLHDcmf4qyytfDF7iMYUtsxGZGZV+IilGOuHg0ALIGuWx9aY7H8iwk+pmAEurO3cW3nEyj3Uz+xIEuAWOsRPmDSw5C2lIow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ah0mo4CN; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ah0mo4CN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773804285; x=1805340285;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=m+ir1o9xz9qrAK3zBYDZuicL4xj+gCWXQksiKo9UWc4=;
  b=ah0mo4CNp8uCW7+qMsYPewCh6DINklzt7Yd9dz34wwWpI1kdX2OczWpx
   lKISL2eONNOGcF2u8I3XR1DW4KuNzDoeo2sjurUABajgYuakUt99Nvc2k
   kG6CaswJErmdFbzVXAJ5TafrR2piclBlGEY7CexWZCg40mOm9AF2Kp9Zz
   R5isE+40yhOJIAVRoxvvrbNpctMVQ8sMBJcawybW8ENAaKVNiOYExUTGQ
   BtzC8is+0X65VheiTT5FDA2vb8fFMob80qjnmBy5rKBJnYoIhD/N4fzNZ
   3M4h/5cY3qJCPlv5gjrUaHmxf+Zh6+JbNSO4piouZpOY85XD5mMPLIOgA
   A==;
X-CSE-ConnectionGUID: xT/43qXRS3aDzZpps7UqLw==
X-CSE-MsgGUID: nQ/l61onTNuKo0J0TpjPYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="85166869"
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="85166869"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 20:24:44 -0700
X-CSE-ConnectionGUID: Ocs5k/ueRjGaHsc9m6+VRg==
X-CSE-MsgGUID: 2c8DAotBQTek6tPjtkpFUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="222447529"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 20:24:42 -0700
Message-ID: <c5bdf6fe-71d1-4d01-bd0b-21b1908c007e@linux.intel.com>
Date: Wed, 18 Mar 2026 11:23:39 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] iommu: Lift and generalize the STE/CD update code
 from SMMUv3
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Dmytro Maluka <dmaluka@chromium.org>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260309060648.276762-1-baolu.lu@linux.intel.com>
 <20260309060648.276762-2-baolu.lu@linux.intel.com>
 <aa9W4ZKYWHr9-UNy@google.com> <aa9fQchZJER8QvY0@google.com>
 <61267acf-e42e-4d1e-9942-e241ccffa606@linux.intel.com>
 <abgscpN59bvXBeS8@google.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <abgscpN59bvXBeS8@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/17/26 00:35, Samiullah Khawaja wrote:
> On Sat, Mar 14, 2026 at 04:13:27PM +0800, Baolu Lu wrote:
>> On 3/10/26 08:06, Samiullah Khawaja wrote:
>>> On Mon, Mar 09, 2026 at 11:33:23PM +0000, Samiullah Khawaja wrote:
>>>> On Mon, Mar 09, 2026 at 02:06:41PM +0800, Lu Baolu wrote:
>>>>> From: Jason Gunthorpe <jgg@nvidia.com>
>>>>>
>>>>> Many IOMMU implementations store data structures in host memory 
>>>>> that can
>>>>> be quite big. The iommu is able to DMA read the host memory using an
>>>>> atomic quanta, usually 64 or 128 bits, and will read an entry using
>>>>> multiple quanta reads.
>>>>>
>>>>> Updating the host memory datastructure entry while the HW is 
>>>>> concurrently
>>>>> DMA'ing it is a little bit involved, but if you want to do this 
>>>>> hitlessly,
>>>>> while never making the entry non-valid, then it becomes quite 
>>>>> complicated.
>>>>>
>>>>> entry_sync is a library to handle this task. It works on the notion of
>>>>> "used bits" which reflect which bits the HW is actually sensitive 
>>>>> to and
>>>>> which bits are ignored by hardware. Many hardware specifications say
>>>>> things like 'if mode is X then bits ABC are ignored'.
>>>>>
>>>>> Using the ignored bits entry_sync can often compute a series of 
>>>>> ordered
>>>>> writes and flushes that will allow the entry to be updated while 
>>>>> keeping
>>>>> it valid. If such an update is not possible then entry will be made
>>>>> temporarily non-valid.
>>>>>
>>>>> A 64 and 128 bit quanta version is provided to support existing 
>>>>> iommus.
>>>>>
>>>>> Co-developed-by: Lu Baolu <baolu.lu@linux.intel.com>
>>>>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>>>>> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
>>>>> ---
>>>>> drivers/iommu/Kconfig               |  14 +++
>>>>> drivers/iommu/Makefile              |   1 +
>>>>> drivers/iommu/entry_sync.h          |  66 +++++++++++++
>>>>> drivers/iommu/entry_sync_template.h | 143 ++++++++++++++++++++++++++++
>>>>> drivers/iommu/entry_sync.c          |  68 +++++++++++++
>>>>> 5 files changed, 292 insertions(+)
>>>>> create mode 100644 drivers/iommu/entry_sync.h
>>>>> create mode 100644 drivers/iommu/entry_sync_template.h
>>>>> create mode 100644 drivers/iommu/entry_sync.c
>>>>>
>>>>> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
>>>>> index f86262b11416..2650c9fa125b 100644
>>>>> --- a/drivers/iommu/Kconfig
>>>>> +++ b/drivers/iommu/Kconfig
>>>>> @@ -145,6 +145,20 @@ config IOMMU_DEFAULT_PASSTHROUGH
>>>>>
>>>>> endchoice
>>>>>
>>>>> +config IOMMU_ENTRY_SYNC
>>>>> +    bool
>>>>> +    default n
>>>>> +
>>>>> +config IOMMU_ENTRY_SYNC64
>>>>> +    bool
>>>>> +    select IOMMU_ENTRY_SYNC
>>>>> +    default n
>>>>> +
>>>>> +config IOMMU_ENTRY_SYNC128
>>>>> +    bool
>>>>> +    select IOMMU_ENTRY_SYNC
>>>>> +    default n
>>>>> +
>>>>> config OF_IOMMU
>>>>>     def_bool y
>>>>>     depends on OF && IOMMU_API
>>>>> diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
>>>>> index 0275821f4ef9..bd923995497a 100644
>>>>> --- a/drivers/iommu/Makefile
>>>>> +++ b/drivers/iommu/Makefile
>>>>> @@ -10,6 +10,7 @@ obj-$(CONFIG_IOMMU_API) += iommu-traces.o
>>>>> obj-$(CONFIG_IOMMU_API) += iommu-sysfs.o
>>>>> obj-$(CONFIG_IOMMU_DEBUGFS) += iommu-debugfs.o
>>>>> obj-$(CONFIG_IOMMU_DMA) += dma-iommu.o
>>>>> +obj-$(CONFIG_IOMMU_ENTRY_SYNC) += entry_sync.o
>>>>> obj-$(CONFIG_IOMMU_IO_PGTABLE) += io-pgtable.o
>>>>> obj-$(CONFIG_IOMMU_IO_PGTABLE_ARMV7S) += io-pgtable-arm-v7s.o
>>>>> obj-$(CONFIG_IOMMU_IO_PGTABLE_LPAE) += io-pgtable-arm.o
>>>>> diff --git a/drivers/iommu/entry_sync.h b/drivers/iommu/entry_sync.h
>>>>> new file mode 100644
>>>>> index 000000000000..004d421c71c0
>>>>> --- /dev/null
>>>>> +++ b/drivers/iommu/entry_sync.h
>>>>> @@ -0,0 +1,66 @@
>>>>> +/* SPDX-License-Identifier: GPL-2.0-only */
>>>>> +/*
>>>>> + * Many IOMMU implementations store data structures in host memory 
>>>>> that can be
>>>>> + * quite big. The iommu is able to DMA read the host memory using 
>>>>> an atomic
>>>>> + * quanta, usually 64 or 128 bits, and will read an entry using 
>>>>> multiple quanta
>>>>> + * reads.
>>>>> + *
>>>>> + * Updating the host memory datastructure entry while the HW is 
>>>>> concurrently
>>>>> + * DMA'ing it is a little bit involved, but if you want to do this 
>>>>> hitlessly,
>>>>> + * while never making the entry non-valid, then it becomes quite 
>>>>> complicated.
>>>>> + *
>>>>> + * entry_sync is a library to handle this task. It works on the 
>>>>> notion of "used
>>>>> + * bits" which reflect which bits the HW is actually sensitive to 
>>>>> and which bits
>>>>> + * are ignored by hardware. Many hardware specifications say 
>>>>> things like 'if
>>>>> + * mode is X then bits ABC are ignored'.
>>>>> + *
>>>>> + * Using the ignored bits entry_sync can often compute a series of 
>>>>> ordered
>>>>> + * writes and flushes that will allow the entry to be updated 
>>>>> while keeping it
>>>>> + * valid. If such an update is not possible then entry will be 
>>>>> made temporarily
>>>>> + * non-valid.
>>>>> + *
>>>>> + * A 64 and 128 bit quanta version is provided to support existing 
>>>>> iommus.
>>>>> + */
>>>>> +#ifndef IOMMU_ENTRY_SYNC_H
>>>>> +#define IOMMU_ENTRY_SYNC_H
>>>>> +
>>>>> +#include <linux/types.h>
>>>>> +#include <linux/compiler.h>
>>>>> +#include <linux/bug.h>
>>>>> +
>>>>> +/* Caller allocates a stack array of this length to call 
>>>>> entry_sync_write() */
>>>>> +#define ENTRY_SYNC_MEMORY_LEN(writer) ((writer)->num_quantas * 3)
>>>>> +
>>>>> +struct entry_sync_writer_ops64;
>>>>> +struct entry_sync_writer64 {
>>>>> +    const struct entry_sync_writer_ops64 *ops;
>>>>> +    size_t num_quantas;
>>>>> +    size_t vbit_quanta;
>>>>> +};
>>>>> +
>>>>> +struct entry_sync_writer_ops64 {
>>>>> +    void (*get_used)(const __le64 *entry, __le64 *used);
>>>>> +    void (*sync)(struct entry_sync_writer64 *writer);
>>>>> +};
>>>>> +
>>>>> +void entry_sync_write64(struct entry_sync_writer64 *writer, __le64 
>>>>> *entry,
>>>>> +            const __le64 *target, __le64 *memory,
>>>>> +            size_t memory_len);
>>>>> +
>>>>> +struct entry_sync_writer_ops128;
>>>>> +struct entry_sync_writer128 {
>>>>> +    const struct entry_sync_writer_ops128 *ops;
>>>>> +    size_t num_quantas;
>>>>> +    size_t vbit_quanta;
>>>>> +};
>>>>> +
>>>>> +struct entry_sync_writer_ops128 {
>>>>> +    void (*get_used)(const u128 *entry, u128 *used);
>>>>> +    void (*sync)(struct entry_sync_writer128 *writer);
>>>>> +};
>>>>> +
>>>>> +void entry_sync_write128(struct entry_sync_writer128 *writer, u128 
>>>>> *entry,
>>>>> +             const u128 *target, u128 *memory,
>>>>> +             size_t memory_len);
>>>>> +
>>>>> +#endif
>>>>> diff --git a/drivers/iommu/entry_sync_template.h b/drivers/iommu/ 
>>>>> entry_sync_template.h
>>>>> new file mode 100644
>>>>> index 000000000000..646f518b098e
>>>>> --- /dev/null
>>>>> +++ b/drivers/iommu/entry_sync_template.h
>>>>> @@ -0,0 +1,143 @@
>>>>> +/* SPDX-License-Identifier: GPL-2.0-only */
>>>>> +#include "entry_sync.h"
>>>>> +#include <linux/args.h>
>>>>> +#include <linux/bitops.h>
>>>>> +
>>>>> +#ifndef entry_sync_writer
>>>>> +#define entry_sync_writer entry_sync_writer64
>>>>> +#define quanta_t __le64
>>>>> +#define NS(name) CONCATENATE(name, 64)
>>>>> +#endif
>>>>> +
>>>>> +/*
>>>>> + * Figure out if we can do a hitless update of entry to become 
>>>>> target. Returns a
>>>>> + * bit mask where 1 indicates that a quanta word needs to be set 
>>>>> disruptively.
>>>>> + * unused_update is an intermediate value of entry that has unused 
>>>>> bits set to
>>>>> + * their new values.
>>>>> + */
>>>>> +static u8 NS(entry_quanta_diff)(struct entry_sync_writer *writer,
>>>>> +                const quanta_t *entry, const quanta_t *target,
>>>>> +                quanta_t *unused_update, quanta_t *memory)
>>>>> +{
>>>>> +    quanta_t *target_used = memory + writer->num_quantas * 1;
>>>>> +    quanta_t *cur_used = memory + writer->num_quantas * 2;
>>>>> +    u8 used_qword_diff = 0;
>>>>> +    unsigned int i;
>>>>> +
>>>>> +    writer->ops->get_used(entry, cur_used);
>>>>> +    writer->ops->get_used(target, target_used);
>>>>> +
>>>>> +    for (i = 0; i != writer->num_quantas; i++) {
>>>>> +        /*
>>>>> +         * Check that masks are up to date, the make functions are 
>>>>> not
>>>>
>>>> nit: "the make functions" looks like a typo.
>>
>> That seems to be a typo. Will clear it in v2.
>>
>>>>> +         * allowed to set a bit to 1 if the used function doesn't 
>>>>> say it
>>>>> +         * is used.
>>>>> +         */
>>>>> +        WARN_ON_ONCE(target[i] & ~target_used[i]);
>>>>> +
>>>>> +        /* Bits can change because they are not currently being 
>>>>> used */
>>>>> +        unused_update[i] = (entry[i] & cur_used[i]) |
>>>>> +                   (target[i] & ~cur_used[i]);
>>>>> +        /*
>>>>> +         * Each bit indicates that a used bit in a qword needs to be
>>>>> +         * changed after unused_update is applied.
>>>>> +         */
>>>>> +        if ((unused_update[i] & target_used[i]) != target[i])
>>>>> +            used_qword_diff |= 1 << i;
>>>>> +    }
>>>>> +    return used_qword_diff;
>>>>> +}
>>>>> +
>>>>> +/*
>>>>> + * Update the entry to the target configuration. The transition 
>>>>> from the current
>>>>> + * entry to the target entry takes place over multiple steps that 
>>>>> attempts to
>>>>> + * make the transition hitless if possible. This function takes 
>>>>> care not to
>>>>> + * create a situation where the HW can perceive a corrupted entry. 
>>>>> HW is only
>>>>> + * required to have a quanta-bit atomicity with stores from the 
>>>>> CPU, while
>>>>> + * entries are many quanta bit values big.
>>>>> + *
>>>>> + * The difference between the current value and the target value 
>>>>> is analyzed to
>>>>> + * determine which of three updates are required - disruptive, 
>>>>> hitless or no
>>>>> + * change.
>>>>> + *
>>>>> + * In the most general disruptive case we can make any update in 
>>>>> three steps:
>>>>> + *  - Disrupting the entry (V=0)
>>>>> + *  - Fill now unused quanta words, except qword 0 which contains V
>>>>> + *  - Make qword 0 have the final value and valid (V=1) with a 
>>>>> single 64
>>>>> + *    bit store
>>>>> + *
>>>>> + * However this disrupts the HW while it is happening. There are 
>>>>> several
>>>>> + * interesting cases where a STE/CD can be updated without 
>>>>> disturbing the HW
>>>>> + * because only a small number of bits are changing (S1DSS, 
>>>>> CONFIG, etc) or
>>>>> + * because the used bits don't intersect. We can detect this by 
>>>>> calculating how
>>>>> + * many 64 bit values need update after adjusting the unused bits 
>>>>> and skip the
>>>>> + * V=0 process. This relies on the IGNORED behavior described in the
>>>>> + * specification.
>>>>> + */
>>>>> +void NS(entry_sync_write)(struct entry_sync_writer *writer, 
>>>>> quanta_t *entry,
>>>>> +              const quanta_t *target, quanta_t *memory,
>>>>> +              size_t memory_len)
>>>>> +{
>>>>> +    quanta_t *unused_update = memory + writer->num_quantas * 0;
>>>>> +    u8 used_qword_diff;
>>>>> +
>>>>> +    if (WARN_ON(memory_len !=
>>>>> +            ENTRY_SYNC_MEMORY_LEN(writer) * sizeof(*memory)))
>>>>> +        return;
>>>>> +
>>>>> +    used_qword_diff = NS(entry_quanta_diff)(writer, entry, target,
>>>>> +                        unused_update, memory);
>>>>> +    if (hweight8(used_qword_diff) == 1) {
>>>>> +        /*
>>>>> +         * Only one quanta needs its used bits to be changed. This 
>>>>> is a
>>>>> +         * hitless update, update all bits the current entry is 
>>>>> ignoring
>>>>> +         * to their new values, then update a single "critical 
>>>>> quanta"
>>>>> +         * to change the entry and finally 0 out any bits that are 
>>>>> now
>>>>> +         * unused in the target configuration.
>>>>> +         */
>>>>> +        unsigned int critical_qword_index = ffs(used_qword_diff) - 1;
>>>>> +
>>>>> +        /*
>>>>> +         * Skip writing unused bits in the critical quanta since 
>>>>> we'll
>>>>> +         * be writing it in the next step anyways. This can save a 
>>>>> sync
>>>>> +         * when the only change is in that quanta.
>>>>> +         */
>>>>> +        unused_update[critical_qword_index] =
>>>>> +            entry[critical_qword_index];
>>>>> +        NS(entry_set)(writer, entry, unused_update, 0,
>>>>> +                  writer->num_quantas);
>>>>> +        NS(entry_set)(writer, entry, target, critical_qword_index, 
>>>>> 1);
>>>>> +        NS(entry_set)(writer, entry, target, 0, writer->num_quantas);
>>>>> +    } else if (used_qword_diff) {
>>>>> +        /*
>>>>> +         * At least two quantas need their inuse bits to be changed.
>>>>> +         * This requires a breaking update, zero the V bit, write all
>>>>> +         * qwords but 0, then set qword 0
>>>>> +         */
>>>>> +        unused_update[writer->vbit_quanta] = 0;
>>>>> +        NS(entry_set)(writer, entry, unused_update, writer-
>>>>>> vbit_quanta, 1);
>>>>> +
>>>>> +        if (writer->vbit_quanta != 0)
>>>>> +            NS(entry_set)(writer, entry, target, 0,
>>>>> +                      writer->vbit_quanta - 1);
>>>>
>>>> Looking at the definition of the entry_set below, the last argument is
>>>> length. So if vbit_quanta 1 then it would write zero len. Shouldn't it
>>>> be writing quantas before the vbit_quanta?
>>>>> +        if (writer->vbit_quanta != writer->num_quantas)
>>>
>>> Looking at this again, I think vbit_quanta can never be equal to
>>> num_quanta as num_quantas is length and vbit_quanta is index?
>>>>> +            NS(entry_set)(writer, entry, target,
>>>>> +                      writer->vbit_quanta,
>>>
>>> Staring from vbit_quanta will set the present bit if it is set in the
>>> target?
>>>>> +                      writer->num_quantas - 1);
>>>>
>>>> Sami here, the last argument should not have "- 1".
>>>
>>> I meant "Same here".
>>
>> This branch is the disruptive update path. The process is:
>>
>> 1. Clear the Valid bit. The hardware now ignores this entry.
>> 2. Write all the new data for the words before the Valid bit.
>> 3. Write all the new data for the words after the Valid bit.
>> 4. Write the word containing the Valid bit. The entry is now live again
>>   with all the new data.
>>
>> Yes. The last argument for entry_set is length, not index. So perhaps I
>> could update it like this?
>>
>> diff --git a/drivers/iommu/entry_sync_template.h b/drivers/iommu/ 
>> entry_sync_template.h
>> index 646f518b098e..423cbb874919 100644
>> --- a/drivers/iommu/entry_sync_template.h
>> +++ b/drivers/iommu/entry_sync_template.h
>> @@ -118,12 +118,11 @@ void NS(entry_sync_write)(struct 
>> entry_sync_writer *writer, quanta_t *entry,
>>                NS(entry_set)(writer, entry, unused_update, writer- 
>> >vbit_quanta, 1);
>>
>>                if (writer->vbit_quanta != 0)
>> -                       NS(entry_set)(writer, entry, target, 0,
>> -                                     writer->vbit_quanta - 1);
>> -               if (writer->vbit_quanta != writer->num_quantas)
>> +                       NS(entry_set)(writer, entry, target, 0, 
>> writer->vbit_quanta);
>> +               if (writer->vbit_quanta + 1 < writer->num_quantas)
>>                        NS(entry_set)(writer, entry, target,
>> -                                     writer->vbit_quanta,
>> -                                     writer->num_quantas - 1);
>> +                                     writer->vbit_quanta + 1,
>> +                                     writer->num_quantas - writer- 
>> >vbit_quanta - 1);
> 
> This looks good.
> 
> nit: I am wondering whether we can change the arguments to the function,
> by modifying the loop in entry_set, to be start and end quanta instead?
> That way the caller doesn't have to do these bound checks? What do you
> think?

I have no strong opinion about this. It appears that Linux kernel memory
set or copy functions follow the (pointer, offset, length) pattern,
moving away from this might cause confusion for other developers.
Anyway, if other guys also like that way, I am fine to adjust it.

Thanks,
baolu
