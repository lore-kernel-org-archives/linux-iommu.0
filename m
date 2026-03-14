Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF776199FAB
	for <iommu@lists.linux.dev>; Sat, 14 Mar 2026 08:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773476068; cv=none; b=Nuey8Eaq/9aXj+mpVJkbqCfsuMmuy/1GRE+e6XsArsMFFMeQUkVZZcbgCB+tQAOLfh1MWcUmfYRj9y9qbW4DUZcUlPKJLnmUgEC+STeRJbeL6gQk/8ylx6WEu2YRoz0pC3GaZ7Kjo25v59dR/VbWe+k7LFtJyToAWFiyxM+2mRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773476068; c=relaxed/simple;
	bh=bkACFxCnyA3TiRsRl11sCYUVzArZmVxLfTs9emZ+JVM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HiHuHaowYf/OXzeh6HRAoQQHhKj8mxhSYbKbs+03nAHqFnos90nvK+tC/pI+iOPZDOgTR/toLmL5nlSfrF4mibBJnqJoj+m4TmxVxingnU5lF96O0JzFG7haJexjOLIZ9/iRvbchYCZ9cD40+pHi1Ebpt449NCh9DIPYoSYJdRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jAGastI6; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jAGastI6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773476066; x=1805012066;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bkACFxCnyA3TiRsRl11sCYUVzArZmVxLfTs9emZ+JVM=;
  b=jAGastI6DBR+4Gcx9Z6e1ox15i733RzdMAhGFIi3pzzHO+xmg3BD3OFh
   8u79KIEQi4Ytfn8ZSvZ1N4PrdtMAw9EOK9sdmBVVi4GSuBMVmisIeunrz
   J+2vPPAFbFr3yFCR/wWaRl6e6d/HXx0D5/a2Doe/JD+Rh+8/2hkLEfDQ0
   pOzinwXAY31z+OsuEII9YfjsOKLBuD6NZwtyFoEj+cV9niME6QE+KU009
   YmIqh0uLV4JKcVTLW5u39IbL5XGNM/Oh3KjF9xjq9MXPb3f8lZsKjH0sB
   o45ybiWa2dxyViwYftwSK8RenUfJlfGLiiPnIoUj9PlQdKHg1ymDF+lhJ
   Q==;
X-CSE-ConnectionGUID: 5CE0Z2OSSUyckJlZS99K6A==
X-CSE-MsgGUID: 45IoepmJRwOSS2J/J9Ff+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11728"; a="85276298"
X-IronPort-AV: E=Sophos;i="6.23,119,1770624000"; 
   d="scan'208";a="85276298"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2026 01:14:25 -0700
X-CSE-ConnectionGUID: jVfd6YOuSBSINNtaDpTysw==
X-CSE-MsgGUID: UV320DjoTZONkNLEhNl5ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,119,1770624000"; 
   d="scan'208";a="225851994"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2026 01:14:23 -0700
Message-ID: <61267acf-e42e-4d1e-9942-e241ccffa606@linux.intel.com>
Date: Sat, 14 Mar 2026 16:13:27 +0800
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
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <aa9fQchZJER8QvY0@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/10/26 08:06, Samiullah Khawaja wrote:
> On Mon, Mar 09, 2026 at 11:33:23PM +0000, Samiullah Khawaja wrote:
>> On Mon, Mar 09, 2026 at 02:06:41PM +0800, Lu Baolu wrote:
>>> From: Jason Gunthorpe <jgg@nvidia.com>
>>>
>>> Many IOMMU implementations store data structures in host memory that can
>>> be quite big. The iommu is able to DMA read the host memory using an
>>> atomic quanta, usually 64 or 128 bits, and will read an entry using
>>> multiple quanta reads.
>>>
>>> Updating the host memory datastructure entry while the HW is 
>>> concurrently
>>> DMA'ing it is a little bit involved, but if you want to do this 
>>> hitlessly,
>>> while never making the entry non-valid, then it becomes quite 
>>> complicated.
>>>
>>> entry_sync is a library to handle this task. It works on the notion of
>>> "used bits" which reflect which bits the HW is actually sensitive to and
>>> which bits are ignored by hardware. Many hardware specifications say
>>> things like 'if mode is X then bits ABC are ignored'.
>>>
>>> Using the ignored bits entry_sync can often compute a series of ordered
>>> writes and flushes that will allow the entry to be updated while keeping
>>> it valid. If such an update is not possible then entry will be made
>>> temporarily non-valid.
>>>
>>> A 64 and 128 bit quanta version is provided to support existing iommus.
>>>
>>> Co-developed-by: Lu Baolu <baolu.lu@linux.intel.com>
>>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>>> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
>>> ---
>>> drivers/iommu/Kconfig               |  14 +++
>>> drivers/iommu/Makefile              |   1 +
>>> drivers/iommu/entry_sync.h          |  66 +++++++++++++
>>> drivers/iommu/entry_sync_template.h | 143 ++++++++++++++++++++++++++++
>>> drivers/iommu/entry_sync.c          |  68 +++++++++++++
>>> 5 files changed, 292 insertions(+)
>>> create mode 100644 drivers/iommu/entry_sync.h
>>> create mode 100644 drivers/iommu/entry_sync_template.h
>>> create mode 100644 drivers/iommu/entry_sync.c
>>>
>>> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
>>> index f86262b11416..2650c9fa125b 100644
>>> --- a/drivers/iommu/Kconfig
>>> +++ b/drivers/iommu/Kconfig
>>> @@ -145,6 +145,20 @@ config IOMMU_DEFAULT_PASSTHROUGH
>>>
>>> endchoice
>>>
>>> +config IOMMU_ENTRY_SYNC
>>> +    bool
>>> +    default n
>>> +
>>> +config IOMMU_ENTRY_SYNC64
>>> +    bool
>>> +    select IOMMU_ENTRY_SYNC
>>> +    default n
>>> +
>>> +config IOMMU_ENTRY_SYNC128
>>> +    bool
>>> +    select IOMMU_ENTRY_SYNC
>>> +    default n
>>> +
>>> config OF_IOMMU
>>>     def_bool y
>>>     depends on OF && IOMMU_API
>>> diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
>>> index 0275821f4ef9..bd923995497a 100644
>>> --- a/drivers/iommu/Makefile
>>> +++ b/drivers/iommu/Makefile
>>> @@ -10,6 +10,7 @@ obj-$(CONFIG_IOMMU_API) += iommu-traces.o
>>> obj-$(CONFIG_IOMMU_API) += iommu-sysfs.o
>>> obj-$(CONFIG_IOMMU_DEBUGFS) += iommu-debugfs.o
>>> obj-$(CONFIG_IOMMU_DMA) += dma-iommu.o
>>> +obj-$(CONFIG_IOMMU_ENTRY_SYNC) += entry_sync.o
>>> obj-$(CONFIG_IOMMU_IO_PGTABLE) += io-pgtable.o
>>> obj-$(CONFIG_IOMMU_IO_PGTABLE_ARMV7S) += io-pgtable-arm-v7s.o
>>> obj-$(CONFIG_IOMMU_IO_PGTABLE_LPAE) += io-pgtable-arm.o
>>> diff --git a/drivers/iommu/entry_sync.h b/drivers/iommu/entry_sync.h
>>> new file mode 100644
>>> index 000000000000..004d421c71c0
>>> --- /dev/null
>>> +++ b/drivers/iommu/entry_sync.h
>>> @@ -0,0 +1,66 @@
>>> +/* SPDX-License-Identifier: GPL-2.0-only */
>>> +/*
>>> + * Many IOMMU implementations store data structures in host memory 
>>> that can be
>>> + * quite big. The iommu is able to DMA read the host memory using an 
>>> atomic
>>> + * quanta, usually 64 or 128 bits, and will read an entry using 
>>> multiple quanta
>>> + * reads.
>>> + *
>>> + * Updating the host memory datastructure entry while the HW is 
>>> concurrently
>>> + * DMA'ing it is a little bit involved, but if you want to do this 
>>> hitlessly,
>>> + * while never making the entry non-valid, then it becomes quite 
>>> complicated.
>>> + *
>>> + * entry_sync is a library to handle this task. It works on the 
>>> notion of "used
>>> + * bits" which reflect which bits the HW is actually sensitive to 
>>> and which bits
>>> + * are ignored by hardware. Many hardware specifications say things 
>>> like 'if
>>> + * mode is X then bits ABC are ignored'.
>>> + *
>>> + * Using the ignored bits entry_sync can often compute a series of 
>>> ordered
>>> + * writes and flushes that will allow the entry to be updated while 
>>> keeping it
>>> + * valid. If such an update is not possible then entry will be made 
>>> temporarily
>>> + * non-valid.
>>> + *
>>> + * A 64 and 128 bit quanta version is provided to support existing 
>>> iommus.
>>> + */
>>> +#ifndef IOMMU_ENTRY_SYNC_H
>>> +#define IOMMU_ENTRY_SYNC_H
>>> +
>>> +#include <linux/types.h>
>>> +#include <linux/compiler.h>
>>> +#include <linux/bug.h>
>>> +
>>> +/* Caller allocates a stack array of this length to call 
>>> entry_sync_write() */
>>> +#define ENTRY_SYNC_MEMORY_LEN(writer) ((writer)->num_quantas * 3)
>>> +
>>> +struct entry_sync_writer_ops64;
>>> +struct entry_sync_writer64 {
>>> +    const struct entry_sync_writer_ops64 *ops;
>>> +    size_t num_quantas;
>>> +    size_t vbit_quanta;
>>> +};
>>> +
>>> +struct entry_sync_writer_ops64 {
>>> +    void (*get_used)(const __le64 *entry, __le64 *used);
>>> +    void (*sync)(struct entry_sync_writer64 *writer);
>>> +};
>>> +
>>> +void entry_sync_write64(struct entry_sync_writer64 *writer, __le64 
>>> *entry,
>>> +            const __le64 *target, __le64 *memory,
>>> +            size_t memory_len);
>>> +
>>> +struct entry_sync_writer_ops128;
>>> +struct entry_sync_writer128 {
>>> +    const struct entry_sync_writer_ops128 *ops;
>>> +    size_t num_quantas;
>>> +    size_t vbit_quanta;
>>> +};
>>> +
>>> +struct entry_sync_writer_ops128 {
>>> +    void (*get_used)(const u128 *entry, u128 *used);
>>> +    void (*sync)(struct entry_sync_writer128 *writer);
>>> +};
>>> +
>>> +void entry_sync_write128(struct entry_sync_writer128 *writer, u128 
>>> *entry,
>>> +             const u128 *target, u128 *memory,
>>> +             size_t memory_len);
>>> +
>>> +#endif
>>> diff --git a/drivers/iommu/entry_sync_template.h b/drivers/iommu/ 
>>> entry_sync_template.h
>>> new file mode 100644
>>> index 000000000000..646f518b098e
>>> --- /dev/null
>>> +++ b/drivers/iommu/entry_sync_template.h
>>> @@ -0,0 +1,143 @@
>>> +/* SPDX-License-Identifier: GPL-2.0-only */
>>> +#include "entry_sync.h"
>>> +#include <linux/args.h>
>>> +#include <linux/bitops.h>
>>> +
>>> +#ifndef entry_sync_writer
>>> +#define entry_sync_writer entry_sync_writer64
>>> +#define quanta_t __le64
>>> +#define NS(name) CONCATENATE(name, 64)
>>> +#endif
>>> +
>>> +/*
>>> + * Figure out if we can do a hitless update of entry to become 
>>> target. Returns a
>>> + * bit mask where 1 indicates that a quanta word needs to be set 
>>> disruptively.
>>> + * unused_update is an intermediate value of entry that has unused 
>>> bits set to
>>> + * their new values.
>>> + */
>>> +static u8 NS(entry_quanta_diff)(struct entry_sync_writer *writer,
>>> +                const quanta_t *entry, const quanta_t *target,
>>> +                quanta_t *unused_update, quanta_t *memory)
>>> +{
>>> +    quanta_t *target_used = memory + writer->num_quantas * 1;
>>> +    quanta_t *cur_used = memory + writer->num_quantas * 2;
>>> +    u8 used_qword_diff = 0;
>>> +    unsigned int i;
>>> +
>>> +    writer->ops->get_used(entry, cur_used);
>>> +    writer->ops->get_used(target, target_used);
>>> +
>>> +    for (i = 0; i != writer->num_quantas; i++) {
>>> +        /*
>>> +         * Check that masks are up to date, the make functions are not
>>
>> nit: "the make functions" looks like a typo.

That seems to be a typo. Will clear it in v2.

>>> +         * allowed to set a bit to 1 if the used function doesn't 
>>> say it
>>> +         * is used.
>>> +         */
>>> +        WARN_ON_ONCE(target[i] & ~target_used[i]);
>>> +
>>> +        /* Bits can change because they are not currently being used */
>>> +        unused_update[i] = (entry[i] & cur_used[i]) |
>>> +                   (target[i] & ~cur_used[i]);
>>> +        /*
>>> +         * Each bit indicates that a used bit in a qword needs to be
>>> +         * changed after unused_update is applied.
>>> +         */
>>> +        if ((unused_update[i] & target_used[i]) != target[i])
>>> +            used_qword_diff |= 1 << i;
>>> +    }
>>> +    return used_qword_diff;
>>> +}
>>> +
>>> +/*
>>> + * Update the entry to the target configuration. The transition from 
>>> the current
>>> + * entry to the target entry takes place over multiple steps that 
>>> attempts to
>>> + * make the transition hitless if possible. This function takes care 
>>> not to
>>> + * create a situation where the HW can perceive a corrupted entry. 
>>> HW is only
>>> + * required to have a quanta-bit atomicity with stores from the CPU, 
>>> while
>>> + * entries are many quanta bit values big.
>>> + *
>>> + * The difference between the current value and the target value is 
>>> analyzed to
>>> + * determine which of three updates are required - disruptive, 
>>> hitless or no
>>> + * change.
>>> + *
>>> + * In the most general disruptive case we can make any update in 
>>> three steps:
>>> + *  - Disrupting the entry (V=0)
>>> + *  - Fill now unused quanta words, except qword 0 which contains V
>>> + *  - Make qword 0 have the final value and valid (V=1) with a 
>>> single 64
>>> + *    bit store
>>> + *
>>> + * However this disrupts the HW while it is happening. There are 
>>> several
>>> + * interesting cases where a STE/CD can be updated without 
>>> disturbing the HW
>>> + * because only a small number of bits are changing (S1DSS, CONFIG, 
>>> etc) or
>>> + * because the used bits don't intersect. We can detect this by 
>>> calculating how
>>> + * many 64 bit values need update after adjusting the unused bits 
>>> and skip the
>>> + * V=0 process. This relies on the IGNORED behavior described in the
>>> + * specification.
>>> + */
>>> +void NS(entry_sync_write)(struct entry_sync_writer *writer, quanta_t 
>>> *entry,
>>> +              const quanta_t *target, quanta_t *memory,
>>> +              size_t memory_len)
>>> +{
>>> +    quanta_t *unused_update = memory + writer->num_quantas * 0;
>>> +    u8 used_qword_diff;
>>> +
>>> +    if (WARN_ON(memory_len !=
>>> +            ENTRY_SYNC_MEMORY_LEN(writer) * sizeof(*memory)))
>>> +        return;
>>> +
>>> +    used_qword_diff = NS(entry_quanta_diff)(writer, entry, target,
>>> +                        unused_update, memory);
>>> +    if (hweight8(used_qword_diff) == 1) {
>>> +        /*
>>> +         * Only one quanta needs its used bits to be changed. This is a
>>> +         * hitless update, update all bits the current entry is 
>>> ignoring
>>> +         * to their new values, then update a single "critical quanta"
>>> +         * to change the entry and finally 0 out any bits that are now
>>> +         * unused in the target configuration.
>>> +         */
>>> +        unsigned int critical_qword_index = ffs(used_qword_diff) - 1;
>>> +
>>> +        /*
>>> +         * Skip writing unused bits in the critical quanta since we'll
>>> +         * be writing it in the next step anyways. This can save a sync
>>> +         * when the only change is in that quanta.
>>> +         */
>>> +        unused_update[critical_qword_index] =
>>> +            entry[critical_qword_index];
>>> +        NS(entry_set)(writer, entry, unused_update, 0,
>>> +                  writer->num_quantas);
>>> +        NS(entry_set)(writer, entry, target, critical_qword_index, 1);
>>> +        NS(entry_set)(writer, entry, target, 0, writer->num_quantas);
>>> +    } else if (used_qword_diff) {
>>> +        /*
>>> +         * At least two quantas need their inuse bits to be changed.
>>> +         * This requires a breaking update, zero the V bit, write all
>>> +         * qwords but 0, then set qword 0
>>> +         */
>>> +        unused_update[writer->vbit_quanta] = 0;
>>> +        NS(entry_set)(writer, entry, unused_update, writer- 
>>> >vbit_quanta, 1);
>>> +
>>> +        if (writer->vbit_quanta != 0)
>>> +            NS(entry_set)(writer, entry, target, 0,
>>> +                      writer->vbit_quanta - 1);
>>
>> Looking at the definition of the entry_set below, the last argument is
>> length. So if vbit_quanta 1 then it would write zero len. Shouldn't it
>> be writing quantas before the vbit_quanta?
>>> +        if (writer->vbit_quanta != writer->num_quantas)
> 
> Looking at this again, I think vbit_quanta can never be equal to
> num_quanta as num_quantas is length and vbit_quanta is index?
>>> +            NS(entry_set)(writer, entry, target,
>>> +                      writer->vbit_quanta,
> 
> Staring from vbit_quanta will set the present bit if it is set in the
> target?
>>> +                      writer->num_quantas - 1);
>>
>> Sami here, the last argument should not have "- 1".
> 
> I meant "Same here".

This branch is the disruptive update path. The process is:

1. Clear the Valid bit. The hardware now ignores this entry.
2. Write all the new data for the words before the Valid bit.
3. Write all the new data for the words after the Valid bit.
4. Write the word containing the Valid bit. The entry is now live again
    with all the new data.

Yes. The last argument for entry_set is length, not index. So perhaps I
could update it like this?

diff --git a/drivers/iommu/entry_sync_template.h 
b/drivers/iommu/entry_sync_template.h
index 646f518b098e..423cbb874919 100644
--- a/drivers/iommu/entry_sync_template.h
+++ b/drivers/iommu/entry_sync_template.h
@@ -118,12 +118,11 @@ void NS(entry_sync_write)(struct entry_sync_writer 
*writer, quanta_t *entry,
                 NS(entry_set)(writer, entry, unused_update, 
writer->vbit_quanta, 1);

                 if (writer->vbit_quanta != 0)
-                       NS(entry_set)(writer, entry, target, 0,
-                                     writer->vbit_quanta - 1);
-               if (writer->vbit_quanta != writer->num_quantas)
+                       NS(entry_set)(writer, entry, target, 0, 
writer->vbit_quanta);
+               if (writer->vbit_quanta + 1 < writer->num_quantas)
                         NS(entry_set)(writer, entry, target,
-                                     writer->vbit_quanta,
-                                     writer->num_quantas - 1);
+                                     writer->vbit_quanta + 1,
+                                     writer->num_quantas - 
writer->vbit_quanta - 1);

                 NS(entry_set)(writer, entry, target, 
writer->vbit_quanta, 1);
         } else {

Thanks,
baolu
