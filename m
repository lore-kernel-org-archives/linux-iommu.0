Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795224333;
	b=J2XNTwCcVjR/TivLRwiPlSV+GFhwtsD12izUkA8Bgvlk7WvH07B+5wpPN+xenoargXQK
	 evHPgDLouovghw+I2t10Hiphb9EWht3KkKKWKeg82KVP294wgD/ZgyNYdJJJplWqdth2+
	 0O/k/dhvyuFa6rqTgqWFl64BzLJDQtVbF7eRHHA1L8hnRS7wBiNSHLnYQVOpqTY1ULvOS
	 sM+mdaN1UHK+Qxqv4LTpG6lMwbxPs9dDqhexZG1NxHakHTHdZVKmy+6VLkJpaEHM924tD
	 NARD3rm9QXz2ve1DGWkY0wzeppLRKnEGboSruz/rOjD7wcxPMfiZx0UnZHgCSMnS7rg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795224333;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Cc:Subject:To:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=B8VJ2Nn+BeKTwN2F0axxPKnkJevyTxJZhk+CPgOfGEw=;
	b=E2+S2IvT/yDhmst5drjVv/FyXdKXJwgZ9TtzwzRj8+yuY301hXSAhvAf8Nq3z1yiZN1J
	 fPOILM2Sbxi4lgpRqkkhxvwaFbtLhMtsuOUNdot/FwXwIkRq0gPEk6ArLxEkegbe8Brlj
	 ndLxxcqNQyvVw4XagOiup3oKUMr8NMaGOlPROXPgIulw4ma5PVj/9IPIkKyEj2KIvu1aQ
	 817YRmu6lPlt6juGT6BNH+lf9waJDOwHM4yNOuxUZlaGx2SzqMMOA0ritbicZTzrR5GdH
	 SN73H+Amh0FJrBAdXeHLfGE2qFhk5F6gl2FFXC6PuuBCJPYfkretEql8dw8/gj6Xj+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AwGEzEm+;
	arc=none smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C087606A6AD
	for <iommu@lists.linux.dev>; Sat, 21 Nov 2026 01:25:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C087606A6AD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AwGEzEm+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795224332; x=1826760332;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FvpkTaIHU9i037/zFilJHbff7pvvBSTYJ4ihraAKAws=;
  b=AwGEzEm+jo9Ekfq7fAu/8cJ+yvAjGR+4+rEPE+rspQJm3eY0AtjPyjFu
   XZ0cErCnQuspnTqUQSK1lo6hWxqRhF1gz+S9VzysdCyDM1TPenwW/6Ska
   XWGCLLXzIl2RGh8KFGhozAWg4Kzl21EqBTKVAbcGvadoz6Mkvkx43Cgsb
   2fEf5Cr+Lyut+zWGxbGrhfKwf/4yEHuJ0Up5DX2fh8mivG6cW4xQo3alU
   ShAZ1Pu/gpsNjuHQ22KR1CrqqvjXKi4zr8WTAxu+tqBaexEY9+O7igCSO
   5PN4PnRjFN7OW7WAe32Dn5SKyVMvDLaU20AvntKQjvNe1Ha2ptNiNIceI
   A==;
X-CSE-ConnectionGUID: Oe/aJbpiTGmBa2yhgpVi3A==
X-CSE-MsgGUID: aGgh6pLET4Sftd/haXJADw==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4003119"
X-IronPort-AV: E=Sophos;i="6.27,224,1787036400"; 
   d="scan'208";a="4003119"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 17:25:32 -0800
X-CSE-ConnectionGUID: 7RhBwOP9TniUkM1Lrw3/Yg==
X-CSE-MsgGUID: Q2O1AeA8SN+P5kTf60KQaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,224,1787036400"; 
   d="scan'208";a="11120287"
Received: from unknown (HELO [10.124.249.52]) ([10.124.249.52])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 17:25:30 -0800
Message-ID: <aceb9e9f-7ba3-48e2-8945-95179f22581d@linux.intel.com>
Date: Sat, 21 Nov 2026 09:25:28 +0800
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] iommu/io-pgfault: reject partial faults after device
 removal
To: Qihang <q.h.hack.winter@gmail.com>
References: <20261117015409.25492-1-q.h.hack.winter@gmail.com>
 <56be2b4e-aefb-413b-8f72-0bea1f9e96db@linux.intel.com>
 <CAH78GvuUtU=zhe-Qbn9k73D3U5n1Ye1=8wtQqR7vCEpDzgNUJg@mail.gmail.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <CAH78GvuUtU=zhe-Qbn9k73D3U5n1Ye1=8wtQqR7vCEpDzgNUJg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/20/2026 5:26 PM, Qihang wrote:
> Hi Baolu,
> 
> Thanks. I agree that the driver must drain pending faults before
> calling iopf_queue_remove_device(). My selftest removed the mock
> driver's serialization, so it doesn't establish that fault reporting
> can overlap removal in an unmodified driver. I'm withdrawing this
> series and won't resend it.
> 
> I still have two questions about where the drivers establish that guarantee.
> 
> On VT-d, blocking_domain_attach_dev() calls
> iopf_for_domain_remove(old, dev) before device_block_translation(dev).
> When that drops the last IOPF reference, it calls
> iopf_queue_remove_device(). On an SM-capable IOMMU, for a device that
> isn't a real DMA subdevice, the only PRQ drain on this path is reached
> through device_block_translation() → intel_pasid_tear_down_entry() →
> intel_iommu_drain_pasid_prq(). By then iopf_refcount is zero, so the
> drain returns early.
> 
> In the same file, identity_domain_attach_dev() calls
> device_block_translation(dev) first and releases the old domain's IOPF
> reference afterwards. The comment there explains that putting the
> device in the blocking state leaves the IOPF reference count
> unchanged. Should blocking_domain_attach_dev() use the same order? If
> the current order is intentional, what ensures that pending PRQ
> reports for this device have drained before the last reference is
> dropped?

Good catch. This is a bug in the vt-d driver. I already have a patch
that changes the order in blocking_domain_attach_dev(). I will submit it
for discussion after the necessary assessment.

> On AMD, detach_device() calls iopf_queue_flush_dev() immediately
> before amd_iommu_iopf_remove_device(). The flush helper waits for
> queued work and documents that the caller must have flushed the
> low-level queue first. The PPR interrupt thread calls
> iommu_report_device_fault() directly, so waiting for queued work alone
> doesn't establish that the thread has finished reporting faults for
> this device. What in the detach path ensures that PPR reporting for
> this device has quiesced before the device is removed from the IOPF
> queue?
> 
> I may be missing a step in both cases. A pointer would be enough.
> 
> Thanks,
> Qihang
> 
> On Fri, Nov 20, 2026 at 3:56 PM Baolu Lu <baolu.lu@linux.intel.com> wrote:
>>
>> On 11/17/2026 9:54 AM, Qihang wrote:
>>> iopf_queue_remove_device() kfree()s the entries on
>>> fault_param->partial without unlinking them, leaving the list head
>>> pointing into freed memory.  Since a74c077b9021 the fault parameter is
>>> refcounted and can outlive the drain, a report that took its reference
>>> earlier can still list_add() through those pointers.  Unlinking
>>> instead turns that into a leak: the late node lands on a parameter
>>> that is no longer on queue->devices, whose final put does not free
>>> partial faults.
>>>
>>> This needs a device removed from its iopf queue while a non-last
>>> (partial) request is in flight, with the caller not blocking new reports
>>> for the duration.
>>>
>>> Patch 1 unlinks each partial before freeing it, matching
>>> iopf_queue_discard_partial().
>>>
>>> Patch 2 adds fault_param->removing, set and tested under
>>> fault_param->lock: a late partial is either drained, or rejected and
>>> freed by report_partial_fault() (-ENODEV).  It covers partial-list
>>> admission only; callers must still quiesce reports for the remaining
>>> lifetimes.
>>>
>>> Both patches are scoped to fault_param->partial, not the group path,
>>> the attach handle, or paths that never call iopf_queue_remove_device().
>>>
>>> Verified on v7.4-rc3 with KASAN + DEBUG_LIST and the iommufd mock
>>> driver, its caller-side IOPF serialization deliberately removed and
>>> test-only delays added; this shows the mechanism, not production
>>> reachability.  The runs cover queue-before-removal,
>>> removal-before-insertion, concurrent late reporters and re-enable.
>>> Each round queues one partial before the removal and then races the
>>> late reporters against the drain, so a clean run ends with every node
>>> accounted for: 1800 = 900 + 900 and 3600 = 900 + 2700 (allocated =
>>> drained + rejected), counted at a final removal with no reporter in
>>> flight.  Nothing was left on fault_param->partial and KASAN stayed
>>> quiet.
>>>
>>> With patch 1 reverted, the report is:
>>>
>>>     BUG: KASAN: slab-use-after-free in __list_add_valid_or_report
>>>     Freed by task 1: kfree <- iopf_queue_remove_device
>>>     56 bytes inside a freed 64-byte region (struct iopf_fault, list.prev)
>>>
>>> With patch 1 only, the same reproducer runs 1460 rounds without a KASAN
>>> report and leaks one late node per round, which patch 2 addresses.
>>>
>>> Reachability on an unmodified production kernel, and any security
>>> impact, remain unconfirmed: the test shows memory corruption and a
>>> KASAN panic on the modified mock driver, not a user-triggerable bug on
>>> a stock kernel.
>>>
>>> An AI coding assistant helped find this defect and build the
>>> reproducer and instrumentation, which are available on request along
>>> with the KASAN logs.
>>
>> +Jason
>>
>> The issues addressed by both patches are false positives. They rely on a
>> fault being reported for a device after iopf_queue_remove_device() has
>> been called for that device. The iommu driver must not allow that.
>> Pending i/o page faults must be drained before the device is removed
>> from its iommu's io page fault queue.
>>
>> Thanks,
>> baolu

Thanks,
baolu
