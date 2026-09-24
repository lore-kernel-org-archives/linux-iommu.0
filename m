Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5213AC0C8
	for <iommu@lists.linux.dev>; Thu, 24 Sep 2026 09:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790242827; cv=none; b=dYBdbLlqV0LyDcN7F5hBgLdvrUS8TfDFP8R8Q/m1ZKzAmSjp0oBpT6l7EzfKe2OyUPZKh2oD4/2Xd4QBoIkNeOKyDoVXefsybjWoSd8a2vj9YD/YHSN7nfacZWhetw41Xbowk4sZNQv81fnhBeNqfF79A/Z5QTg6HfWXz5zz5hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790242827; c=relaxed/simple;
	bh=ytV70JGtueyA9wVEFGvsbYuPa11Ur11sihpGQa0sFKs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gg99Kc4P6/tdRJrv6CpSYMrTIntnwx6Cr34qX5ApZAXfo0Ot9NMj5ZhYUEWishoF9P307ll6Njiuqfe7XjmmGG1E3WiziobpWyRl5aLXyfr50Fcj2S27zWD+xKgbe4JoJkCIeLJ/lv7INmhD/+VCr5mHigpZ/LxVdr+1B50AQNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=PulG5RP9; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="PulG5RP9"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0324F1477;
	Thu, 24 Sep 2026 02:40:18 -0700 (PDT)
Received: from [10.2.212.8] (e134344.arm.com [10.2.212.8])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9D96F3F86F;
	Thu, 24 Sep 2026 02:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790242821; bh=ytV70JGtueyA9wVEFGvsbYuPa11Ur11sihpGQa0sFKs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PulG5RP9pNTf+khs8603GELGSzUZxwkXLCow3DrOvxJjyciAOFENLHzscInC/KF1N
	 diLHF2hdmJLbl/4+YTR+/vWWWkwVpRTEg4briEAA12H0Sofy5lkYEzj2jzZllg9uGh
	 +d68h9dMmwTbLBOM2QhRIYl0oQtDJYa2rZrtuGN0=
Message-ID: <6b39d774-461b-437a-8449-768092af2726@arm.com>
Date: Thu, 24 Sep 2026 10:40:16 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Resctrl and I/O
To: James Morse <james.morse@arm.com>, "Luck, Tony" <tony.luck@intel.com>,
 alex@ghiti.fr, aou@eecs.berkeley.edu, babu.moger@amd.com,
 baolin.wang@linux.alibaba.com, corbet@lwn.net, cuiyunhui@bytedance.com,
 Dave.Martin@arm.com, fustini@kernel.org, jgg@ziepe.ca, joro@8bytes.org,
 kevin.tian@intel.com, palmer@dabbelt.com, pjw@kernel.org,
 reinette.chatre@intel.com, robin.murphy@arm.com, shuah@kernel.org,
 tomasz.jeznach@linux.dev, wangzhou1@hisilicon.com, will@kernel.org,
 xiaqinxin@huawei.com, yuanzhu@bytedance.com, zengheng4@huawei.com,
 zhangzhanpeng.jasper@bytedance.com
Cc: x86@kernel.org, iommu@lists.linux.dev, linuxarm@huawei.com,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <arKx__kOPe4B5gDW@agluck-desk3>
 <8557363f-c051-4267-9fbc-f4cbb13ac35e@arm.com>
Content-Language: en-US
From: Ben Horgan <ben.horgan@arm.com>
In-Reply-To: <8557363f-c051-4267-9fbc-f4cbb13ac35e@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi James,

On 23/09/2026 18:13, James Morse wrote:
> Hi Tony,
> 
> On 22/09/2026 17:51, Luck, Tony wrote:
>> Patches for ARM[1] and RISC-V[2] are both at RFC status.
>>
>> They appear to be based on similar h/w capabilities where architecture
>> specific tags can be added to transactions from I/O devices by the IOMMU
>> servicing the device. Device enumeration is handled outside of the resctrl
>> file system.

[...]

>>
>> Fitting this into resctrl
>> -------------------------
>>
>> RISC-V description of "architecture specific device tokens" sounds great.
>> I'll have to find some ares of /sys to provide the mapping of tokens to
>> "device groups".
>> There's no association with IOMMUs, so this will be some
>> other path in /sys. Perhaps under /sys/firmware/acpi since the data comes
>> from ACPI IRDT table.
> 
> What about using the device behind the IOMMU instead? Presumably the kernel
> could allocate ids that don't clash with those in the IRDT, and use those
> for the IOMMU.
> 
> 
>> Need an info file to tell users the format and source for device tokens.
> 
> I'd prefer we have one consistent way of doing this across architectures.
> Especially if we're going to add something new to sysfs.
> 
> 
> The sysfs path probably covers all bases - but I wouldn't want to parse that
> in the kernel.
> 
> 
>> I'd like to avoid limiting resctrl monitoring of CPU activity due to the small
>> number of I/O RMIDs. Perhaps don't include a "devices" file or mon_data/{i/o
>> events} files in resctrl group directories when rdtgroup::mon::rmid >=
>> num_io_rmids? But that feels clumsy.
> 
> I had a half baked idea on how to do this. (which Ben has poked some holes in)
> 
> Assigning a device to a ctrl/mon group needs to be able to fail. We can use this
> to re-allocate the RMID into the range the new device can use. The CPU tasks can
> be repainted to use the new value - but the obvious problem is the old data in
> the caches that uses the old RMID.
> As no new traffic will be generated for that RMID, it might be possible to keep
> it associated with the ctrl/mon group (which would now have two RMID) to keep the
> user-space view of the counters correct until the old RMID falls below the
> reallocation threshold, and it can be free'd.

One limitation, "hole", is that it relies on assigning your devices early. If you've used all your
rmids and then want to assign a device then that will only succeed for a subset of the monitor
groups but you don't know which ones. Then you are left with trying until you see what works,
peering into the debug interface or just remounting.

Thanks,

Ben

> 
> It's worse if we ever needed/wanted to do this with CLOSID. Two CAT bitmaps
> can be configured the same - but MBA doesn't alias in the same way. Tasks would
> be able to burst higher than the configured limit - but the size is limited by
> the size of the caches. And if no new traffic can be generated with the old
> CLOSID/RMID, then the effect can't be made to last forever.
> 
> 
> For a totally wild suggestion (that I don't think works here) - I had
> mooted having a second mount of resctrl for islands of the SoC where the
> properties are different. I don't think it works in this case as the IO-RMID
> presumably gets seen by some other monitors later.
> 
> 
>> Domains are based on I/O L3 cache instances. So a new rdt_resource with
>> new line in the schemata file for IOL3 cache masks per domain. In the
>> future when there are I/O MBA controls, new line(s) for those too.
> 
> 
> Thanks,
> 
> James
> 
> 
> [4] https://support.arm.com/documentation/ihi0069/hb/?lang=en search for "MPAM" in the pdf.
> 
>>
>> [1] https://lore.kernel.org/linux-iommu/20260901140802.1215508-1-xiaqinxin@huawei.com/
>> [2] https://lore.kernel.org/lkml/20260714130657.46963-1-zhangzhanpeng.jasper@bytedance.com/
>> [3] Linked from the bottom of https://www.intel.com/sdm under "Related Specifications", or
>> direct link: https://cdrdv2.intel.com/v1/dl/getContent/789566?erpm_id=1158389_ts1790091453223
> 

