Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D94144D68C;
	Wed, 21 Jan 2026 07:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768979699; cv=none; b=cHJt6l87fS8YWyWGHgbD1HPQi57UTmhwbHBnRvfq2eGY5QIUoAD9HKdCaCCqjbhZVMsIe0CU8RVsxZIbnSsf+nOacSF8OnJUPF60hliqKsN3H7JLZXb8wyEnyZ58Gbch/04znCubh6GPf10OkXAYoY8/rPr1ZXgS9OG75uQOh8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768979699; c=relaxed/simple;
	bh=MXPljD5fEgppiCAcWTE+QV4bH88CzPOxUrW5uDUo0fQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZQ9VcH9qVyeBv2QU6L/ivMY/5S3z/dZpS5HRGNp9TLDj3WIdSvs/H8WTuE5mVwQuaMP3PqSnLfmOTl6KZEc3n5Huz6zaZwa3+fanHAMYqQ4mkGzHCckNzjuNqrFZoseOybgLBAb0IFlqDQMdXSM/udT7mKoSbyTpnZFgA5DzvoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=agU4nZS6; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="agU4nZS6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768979694; x=1800515694;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MXPljD5fEgppiCAcWTE+QV4bH88CzPOxUrW5uDUo0fQ=;
  b=agU4nZS64l1qiEQmLyKqYHxz+IXlJFZatCRiCVPHPprU3fK4sgOhRDJd
   sTvzLS8TYlQTrqAyHrvCWmJz6+WqEALYUqAuuU/vY4a4Sg2RHhT6Fbucd
   zqF7WoL90uLvgTRYCSXujz2t4pY6460UASm6Iqs0lCNk1XCYq4PTg5LDu
   7cNWI3DKyc/TrkDCNmgnUzZxerS/9xxGHzpSsfSF2wP7WXrEkZ5QS2kha
   EMEKL30PLL+2E/B6CLh6VqXv/2vC9HSNCbAVJW2JWsG7ffNoHRdEllgTJ
   y5prcafI2ovrnwL2BoMmDljVSSioI5Y1dkKQLjpBOQxNXGlYIBnShx4VK
   A==;
X-CSE-ConnectionGUID: kbRJF8ApQUGXmRT+CWrl2g==
X-CSE-MsgGUID: 2NrX0PS0TGWrXlH/X7gmcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11677"; a="92869393"
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="92869393"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 23:14:50 -0800
X-CSE-ConnectionGUID: Hf5YgZrfQ7a9nSf4Yr5/AA==
X-CSE-MsgGUID: 7iACQ/imSfGRENC7kimbYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="211227627"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 23:14:48 -0800
Message-ID: <3fccd233-c5cf-4252-98ea-61f240f82695@linux.intel.com>
Date: Wed, 21 Jan 2026 15:14:42 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: IOMMU regression in linux-6.18.y
To: Mario Limonciello <superm1@kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>,
 regressions <regressions@lists.linux.dev>, stable@vger.kernel.org
Cc: iommu@lists.linux.dev, "Hegde, Vasant" <Vasant.Hegde@amd.com>,
 "Hou, Lizhi" <lizhi.hou@amd.com>
References: <870872aa-28e9-412a-bac6-8020bf560e4f@amd.com>
 <c51ed4bf-ec2a-45f1-a077-8e2236076827@kernel.org>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <c51ed4bf-ec2a-45f1-a077-8e2236076827@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/21/26 13:26, Mario Limonciello wrote:
> 
> 
> On 1/20/26 8:08 PM, Mario Limonciello wrote:
>> Hi,
>>
>> Recently I found out that amdxdna stopped working in linux-6.18.4.  
>> This is because of this commit in linux-6.18.y:
>>
>> commit c341dee80b5d ("iommu: disable SVA when CONFIG_X86 is set")
>>
>> That was originally backported from upstream:
>>
>> commit 72f98ef9a4be ("iommu: disable SVA when CONFIG_X86 is set")
>>
>> ---
>>
>> SVA support is a requirement for amdxdna.
>>
>> The series that this commit came from was part of a larger 8 patch 
>> series, but this was the only commit that was CC'ed to stable.
>>
>> As a result this is not broken in 6.19-rc, but it is broken in 
>> linux-6.18.y (and presumably any older stable kernels still around 
>> that picked it up).
>>
>> So there are two options I see:
>>
>> 1) Revert c341dee80b5d in linux-6.18.y (and any other stable kernel 
>> that picked it up but has amdxdna)
>>
>> 2) Bring the entire 8 patch series to linux-6.18.y.
>>
>> This is the entire series (I didn't look up the hashes from mainline, 
>> but they should have all landed):
>> https://lore.kernel.org/linux-iommu/20251022082635.2462433-1- 
>> baolu.lu@linux.intel.com/
>>
>> What should we do?
>>
> 
> If the decision is to take the remaining commits to 6.18.y to fix this I 
> did confirm they cleanly cherry pick and build.  Here are the hashes.
> 
> commit 27bfafac65d8 ("mm: add a ptdesc flag to mark kernel page tables")
> commit 977870522af3 ("mm: actually mark kernel page table pages")
> commit 412d000346ea ("x86/mm: use 'ptdesc' when freeing PMD pages")
> commit 018942956723 ("mm: introduce pure page table freeing function")
> commit bf9e4e30f353 ("x86/mm: use pagetable_free()")
> commit 5ba2f0a15564 ("mm: introduce deferred freeing for kernel page 
> tables")
> commit e37d5a2d60a3 ("iommu/sva: invalidate stale IOTLB entries for 
> kernel address space")
> 

Yes. These patches fix a security issue in iommu/sva on x86 and restore
the SVA functionality.

Thanks,
baolu
