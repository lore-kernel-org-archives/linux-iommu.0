Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BC43B6C06
	for <iommu@lists.linux.dev>; Tue, 24 Mar 2026 06:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774333420; cv=none; b=giPnJsF8vyeeXizN+19M6w40ss0n+y62j12f42psBUjF15esazbUeSUR4Pi50wYWy6OafxSw+NT0v11g2IZ+/yMiBCR3N56z49+Mrb4ftfqx7dVZyG0Wo3kS+HyOWjgGrDwB9Tp9f0B9MTnB5uhqIx5OztMVTbJcQJHSe0wyDpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774333420; c=relaxed/simple;
	bh=kkYiEvbAyjBNjEuNlNTchuaU0ZJK1/i8Vy9qKh/YcTE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iuXybrlGpaiGEnM3MPTW3r2gzmylIewdvtAxuScBoTT7/dJVOyxX4CfXGrQkevUL04RmLtkWgaONNAdTB+WDVASetplbRsV7ApE9vtfepe+H1XftJQxE5aNqI2xrjbS7vt4UD03SYpmY4OuYa/RwRDgWCYTHPJtLeEeYpZe78I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nSBpftoi; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nSBpftoi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774333417; x=1805869417;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kkYiEvbAyjBNjEuNlNTchuaU0ZJK1/i8Vy9qKh/YcTE=;
  b=nSBpftoi8GRzHEZeZBEAxnODyZZ6zVGriyPDLeJliPfY2zC6u9i4PaMw
   tGKFPS9y/wFp9xLuUXgR8b3u2CTQ1HQrBOIBDTi6QhS5RfDRcL5/+cbJb
   +BPfjATa2i+GOhZigq2+ZUCb0iOkfYAUmOPqiwAjv/20x3tInrEWHEPVQ
   bOL2VvH55B1DBOOsM7GVklbxYJK3aY5tJVrD+ELdeAtFGqEmQyxIbgGnC
   DYqOK9kyWXzVYNn9V76/qQPZMzH2qGXuoZsKquEBuVXe8aVJmXAUJ2eSz
   SPthGWwjQ+P3fkubn2SDhYjPFliV6mtxFvRNIyfxeBKI/p7eUznBup3tw
   Q==;
X-CSE-ConnectionGUID: o1SKrYb8Sde5vDnApP8SyA==
X-CSE-MsgGUID: C2NJpEyaTHmJH42uG4WWDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="92921355"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="92921355"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 23:23:36 -0700
X-CSE-ConnectionGUID: cOpvrN1VQhOjEG4A6IrtJQ==
X-CSE-MsgGUID: hGoMWCZTS8eeu2kH4ZVMyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="229196151"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 23:23:33 -0700
Message-ID: <83d78265-5977-42c2-a9e1-a2bc6f9342a6@linux.intel.com>
Date: Tue, 24 Mar 2026 14:22:21 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] iommu/vt-d: Add entry_sync support for PASID entry
 updates
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
 Dmytro Maluka <dmaluka@chromium.org>, Samiullah Khawaja
 <skhawaja@google.com>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260309060648.276762-1-baolu.lu@linux.intel.com>
 <20260309060648.276762-3-baolu.lu@linux.intel.com>
 <20260309134116.GE3717316@nvidia.com>
 <4fbe6dcf-1105-4efc-b755-81a5bfb74090@linux.intel.com>
 <20260312114438.GG1448102@nvidia.com>
 <5c7503bd-e9e8-41b8-b275-3317912cc83c@linux.intel.com>
 <20260323130700.GE7340@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260323130700.GE7340@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/23/26 21:07, Jason Gunthorpe wrote:
> On Sun, Mar 15, 2026 at 04:11:36PM +0800, Baolu Lu wrote:
>>>>> ATC invalidations should always be done after the PASID entry is
>>>>> written. During a hitless update both translations are unpredictably
>>>>> combined, this is unavoidable and OK.
>>>>
>>>> The VT-d spec (Sections 6.5.2.5 and 6.5.2.6) explicitly mandates that an
>>>> IOTLB invalidation must precede the Device-TLB invalidation. If we only
>>>> do the device-TLB invalidation in the sync callback, we risk the device
>>>> re-fetching a stale translation from the IOMMU's internal IOTLB.
>>>
>>> It is a little weird that is says that, that is worth checking into.
>>>
>>> The other text is clear that the IOTLB is cached by DID,PASID only, so
>>> if the new PASID entry has a DID,PASID which is already coherent in
>>> the IOTLB it should not need any IOTLB flushing.
>>>
>>> ie flushing the PASID table should immediately change any ATC fetches
>>> from using DID,old_PASID to DID,new_PASID.
>>>
>>> If there is some issue where the PASID flush doesn't fence everything
>>> (ie an ATC fetch of DID,old_PASID can be passed by an ATC invalidation)
>>> then you may need IOTLB invalidations not to manage coherence but to
>>> manage ordering. That is an important detail if true.
>>
>> On Intel hardware, the PASID-cache and IOTLB are not inclusive. A PASID-
>> cache invalidation forces a re-fetch of the pasid entry, but it does not
>> automatically purge downstream IOTLB entries.
> 
> It doesn't matter, the updated PASID entry will point to a new DID and
> the IOTLB (new DID,PASID) entry will be valid in the IOTLB.
> 
> We don't need to flush the IOTLB, we just need to ensure that all
> lookups done with (old DID,PASID) are completed before sending any
> invalidation.

Yes, you are right.

> 
>> The spec-mandated IOTLB flush serves as a synchronization barrier to
>> ensure that in-flight translation requests are drained and the
>> internal IOMMU state is consistent before the invalidation request
>> is sent over PCIe to the device's ATC.
> 
> A fencing requirement does make sense, but does it have to be done by
> flushing the entire DID,PASID? It is ugly to have to drop the IOTLB
> just because a context entry changed.

I believe the full [old_DID, PASID] invalidation is a functional
necessity rather than just a fencing requirement. Even though the new
PASID entry points to a new_DID, leaving stale translations tagged with
[old_DID, PASID] in the IOTLB is problematic.

However, I agree that IOTLB and Device-TLB invalidation should not be
part of the entry_sync for a PASID entry; instead, it belongs in the
domain replacement logic.

> Can you do a 4k IOVA 0 invalidation and get the same fence?
> 
> Jason

Thanks,
baolu
