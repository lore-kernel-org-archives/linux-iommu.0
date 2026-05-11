Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C8536F433
	for <iommu@lists.linux.dev>; Mon, 11 May 2026 12:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778503152; cv=none; b=Hd7lHlfoh9nD0O0d2qpflhft/ZRZD6UJUmTbUmmtPLhzP3db+F4CqdP9GtHvQUBs0y1dyWRh3FD70Rin0rarbKUBXda3Oo8tuJTCyPZ9Ii2burh2Erre7tUNs6OOrJSczmULuKCvkfgKOwzsmEyru9XGWB7hSYZVHgGwaWwENb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778503152; c=relaxed/simple;
	bh=QLEE1X1xHeVvZP4CCFZks7mG64iGB9TUiMiSZkQVSaU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ULwgDSfHouhEArVuXYAcJnesQvlSGO/DY9sd4pGu/r7vRrLabASpzz2O3iw7BOQJP+OIl2gFCRxhSdr2tH4Fn1qhb7LcWfHWTRxzi5cZ7D4xPqehXayW8Bd+Itfq9kqMBXOAUA0+aAMpzDg8OrbpFfO/BO9cQddCC4P0f64Xhn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Yr0IcQFY; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Yr0IcQFY"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 047B016F3;
	Mon, 11 May 2026 05:39:05 -0700 (PDT)
Received: from [10.57.68.228] (unknown [10.57.68.228])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AD99F3F836;
	Mon, 11 May 2026 05:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1778503150; bh=QLEE1X1xHeVvZP4CCFZks7mG64iGB9TUiMiSZkQVSaU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Yr0IcQFYT4Du7w6J9c139Pmm1QHTDFOpJ1zDcdnaU+8YGlNfWVc4aWtPtNKgq1yBM
	 PQ0RFPgH/OTcOGhw9vj+p3ok1HleN3E/hMoaNK2qphVtKCE9B9/Z9Rrgznd4N9iVwh
	 WFzRYaNxpuEsM2kucOGKIUqHoRQJs+4n0JCbUhjg=
Message-ID: <30eefd04-1d0f-45d8-b55d-e3e8d41a57ef@arm.com>
Date: Mon, 11 May 2026 13:39:06 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] iommu: Enable per-device SSID space for SVA
To: Jason Gunthorpe <jgg@ziepe.ca>, Joonwon Kang <joonwonkang@google.com>
Cc: Alexander.Grest@microsoft.com, amhetre@nvidia.com,
 baolu.lu@linux.intel.com, iommu@lists.linux.dev, joro@8bytes.org,
 jpb@kernel.org, kees@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, nicolinc@nvidia.com, praan@google.com,
 smostafa@google.com, will@kernel.org, jacob.jun.pan@linux.intel.com,
 easwar.hariharan@linux.microsoft.com, kevin.tian@intel.com
References: <20260424133953.GY3611611@ziepe.ca>
 <20260507095851.3220765-1-joonwonkang@google.com>
 <20260509171013.GF9285@ziepe.ca>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260509171013.GF9285@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-05-09 6:10 pm, Jason Gunthorpe wrote:
> On Thu, May 07, 2026 at 09:58:51AM +0000, Joonwon Kang wrote:
> 
>> By "similar instruction" on ARM, I guess you mean ST64BV0, which fetches
>> the bottom 32 bits data from ACCDATA_EL1. Please let me know if you meant
>> others as it will matter. If ST64BV0 is supported on ARM, however, it
>> would mean that ST64B and ST64BV are also supported already according to
>> the ID_AA64ISAR1_EL1's LS64 field. The latter 2 instructions are just to
>> atomically store whatever user wants to a memory location without
>> referring to ACCDATA_EL1 and all the 3 instructions can be run at EL0. So,
>> the userspace driver would have enough capability to designate arbitrary
>> PASID as it wants via the latter 2 instructions when communicating with
>> multiple devices.
> 
> IDK exactly what ARM did. IIRC on Intel ENQCMD forms a special
> non-posted write TLP and the device can tell the TLP came from ENQCMD
> and so it trusts the encoded PASID. ARM has to have done the same
> thing - allowing anyone to forge the PASID by using a different
> instruction misses the point of the Intel design.

Yes, ACCDATA_EL1 is a privileged register neither writeable nor readable 
by userspace[1], so it should be functionally equivalent from an SVA 
point of view.

> Honestly, I'm not sure why they even implemented it. SMMUv3 can't do
> the translation scheme required to use ENQCMD from a VM anyhow, so it
> is pretty useless.

Not sure what you mean there - indeed you can't do the SIOV thing of 
assigning individual ADIs to _different_ VMs, but there's still no 
reason you couldn't give the whole accelerator device to one VM, and run 
the "full" kernel driver in that VM to hand out ADIs to processes, same 
as for non-virtualised ST64BV0/ENQCMD usage. It's entirely usable, just 
not so "scalable".

Thanks,
Robin.

[1] 
https://developer.arm.com/documentation/ddi0601/2026-03/AArch64-Registers/ACCDATA-EL1--Accelerator-Data

> 
>> We have multiple processes and a single device, those processes want to
>> do SVA with the same device, and only one process will do SVA with the
>> device at a time. Though, the problem occurs even when irrelevant
>> processes allocate the PASIDs from the global PASID space for their own
>> irrelevant purposes.
> 
> The only way to allocate a PASID from the global PASID space is to
> establish another SVA, so you have multiple devices doing SVA?
> 
> Jason

