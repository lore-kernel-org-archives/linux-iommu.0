Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2744C466B57;
	Wed, 21 Jan 2026 07:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768980780; cv=none; b=sBXEeRgKbplridY7F7xHV0KpwmNzkXw0kOlH0hdIEk397qPHIL2YlCeiFQoodTgJkhnIwciiy3Zpvs3RxMmeZ4kxd48fTUomu5cslzcM27yxD1A8L5cOlTRl20MvUDnUv0O4WUZ8qOMIysspjiGIINab2JG+12mUxjvrERejPN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768980780; c=relaxed/simple;
	bh=KocdujL+epywWSUPAqXXiAES3jtX3NCdmQVHto50vZY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WtSYTTEyX65zA4hWT+MFRYCHt9IcbU9mSWwQ0fWKL+PYPOE0wrV3RrSEg4PIOyrjSkTOqOjSyvCAcfk4t+upzHYekmxt7z8+GNWAKlWfKODFoOyBDWwHAfwBxhAuToHYgZenQKRFHF9EB1pg/3dTIJZYOmNULgdy0tYkjeiJSyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=STSPX8t3; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="STSPX8t3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768980773; x=1800516773;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KocdujL+epywWSUPAqXXiAES3jtX3NCdmQVHto50vZY=;
  b=STSPX8t3P6ggVCUURQvouz6iJmAEUcyPECOr8NKbAF8/yNsFeThaY8yn
   0087oc3HyLP4E4ycg3qYiJdpHhHPsfGfQZpDOjJt56363euueB0frEDjk
   a8017aUKi/2O49tUcSTCwkfbD4QDoX7MSUXEzpyadP72ZJVQ5OMLf81i7
   ZPVUOdobdrPwadG1vSZSvD7MsuMmg/wGjNnCZc1v4rc78KPRwe7vzbSA5
   R+qq/8WYts3NEAVut351LPz6pWydWizbo1l3mnwlIHp4YzSOCM3TUaiqA
   xzo0kofsIEwSJ9bAwT9RYBPOXxCKdgDgynPLTEKbz3d5A2MZt/h7Upb7w
   w==;
X-CSE-ConnectionGUID: oWAB5dmkTbKVnsrzGrADWA==
X-CSE-MsgGUID: TAl1CxG7SLy/3yRhMDs52g==
X-IronPort-AV: E=McAfee;i="6800,10657,11677"; a="87615490"
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="87615490"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 23:32:50 -0800
X-CSE-ConnectionGUID: cc8N6P4jTiiViNi17R1B7A==
X-CSE-MsgGUID: jWepoUefS7Ca/BNWogF4ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="205513188"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 23:32:48 -0800
Message-ID: <da9eddb1-305a-491a-9e00-e30ec20dbef3@linux.intel.com>
Date: Wed, 21 Jan 2026 15:32:42 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: IOMMU regression in linux-6.18.y
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Mario Limonciello <superm1@kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>,
 regressions <regressions@lists.linux.dev>, stable@vger.kernel.org,
 iommu@lists.linux.dev, "Hegde, Vasant" <Vasant.Hegde@amd.com>,
 "Hou, Lizhi" <lizhi.hou@amd.com>
References: <870872aa-28e9-412a-bac6-8020bf560e4f@amd.com>
 <c51ed4bf-ec2a-45f1-a077-8e2236076827@kernel.org>
 <3fccd233-c5cf-4252-98ea-61f240f82695@linux.intel.com>
 <2026012112-phantom-music-f6e8@gregkh>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <2026012112-phantom-music-f6e8@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/21/26 15:26, Greg KH wrote:
> On Wed, Jan 21, 2026 at 03:14:42PM +0800, Baolu Lu wrote:
>> On 1/21/26 13:26, Mario Limonciello wrote:
>>>
>>>
>>> On 1/20/26 8:08 PM, Mario Limonciello wrote:
>>>> Hi,
>>>>
>>>> Recently I found out that amdxdna stopped working in linux-6.18.4.
>>>> This is because of this commit in linux-6.18.y:
>>>>
>>>> commit c341dee80b5d ("iommu: disable SVA when CONFIG_X86 is set")
>>>>
>>>> That was originally backported from upstream:
>>>>
>>>> commit 72f98ef9a4be ("iommu: disable SVA when CONFIG_X86 is set")
>>>>
>>>> ---
>>>>
>>>> SVA support is a requirement for amdxdna.
>>>>
>>>> The series that this commit came from was part of a larger 8 patch
>>>> series, but this was the only commit that was CC'ed to stable.
>>>>
>>>> As a result this is not broken in 6.19-rc, but it is broken in
>>>> linux-6.18.y (and presumably any older stable kernels still around
>>>> that picked it up).
>>>>
>>>> So there are two options I see:
>>>>
>>>> 1) Revert c341dee80b5d in linux-6.18.y (and any other stable kernel
>>>> that picked it up but has amdxdna)
>>>>
>>>> 2) Bring the entire 8 patch series to linux-6.18.y.
>>>>
>>>> This is the entire series (I didn't look up the hashes from
>>>> mainline, but they should have all landed):
>>>> https://lore.kernel.org/linux-iommu/20251022082635.2462433-1-
>>>> baolu.lu@linux.intel.com/
>>>>
>>>> What should we do?
>>>>
>>>
>>> If the decision is to take the remaining commits to 6.18.y to fix this I
>>> did confirm they cleanly cherry pick and build.  Here are the hashes.
>>>
>>> commit 27bfafac65d8 ("mm: add a ptdesc flag to mark kernel page tables")
>>> commit 977870522af3 ("mm: actually mark kernel page table pages")
>>> commit 412d000346ea ("x86/mm: use 'ptdesc' when freeing PMD pages")
>>> commit 018942956723 ("mm: introduce pure page table freeing function")
>>> commit bf9e4e30f353 ("x86/mm: use pagetable_free()")
>>> commit 5ba2f0a15564 ("mm: introduce deferred freeing for kernel page
>>> tables")
>>> commit e37d5a2d60a3 ("iommu/sva: invalidate stale IOTLB entries for
>>> kernel address space")
>>>
>>
>> Yes. These patches fix a security issue in iommu/sva on x86 and restore
>> the SVA functionality.
> 
> So all should be backported?  If so, great, but why were they not tagged
> as such?

Yes, they should be backported. I am sorry; we should have tagged them
at the time we upstreamed them.

> 
> thanks,
> 
> greg k-h
> 

Thanks,
baolu
