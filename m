Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D20FB1EDA04
	for <iommu@lists.linux.dev>; Fri, 14 Mar 2025 09:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741944970; cv=none; b=NKxY4EXfpxyLoNoD5/yPlbLYT+fSyck6cYi7abcrc78lC9dU2PDwnmSsQp6yBq6GV1JRLNZ1GhWIgIrOYadUHTl5cB2CwV6ICmSUKqMSCysM9PRB6he85C/ly422slkWfxn54vV3zk61F5hQ7yYl/XMIMGwwfKcPPgX6d5wo1l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741944970; c=relaxed/simple;
	bh=vHSUy96CZBRi+d90hGbb74zU2U2xUzR8ZmsASxXtejU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ph6b40XdJcoGlLgO53bUwwjhF3MRVH8WnvJd0n1Cn4dk8DAFUgWX3o6d88Hm4FYFODkkwVj0+QaE18ciNqbkwKY0dNoMvGvWgE6my54wivVFt2ZMjLsGPDueJMe6Ibl85fjasjTNE7f85C3uSH8lpRRypyHc4gst0oNb1debli0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3B6F7113E;
	Fri, 14 Mar 2025 02:36:18 -0700 (PDT)
Received: from [10.57.39.196] (unknown [10.57.39.196])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5F8663F673;
	Fri, 14 Mar 2025 02:36:06 -0700 (PDT)
Message-ID: <f2e3c123-6d58-4560-be4f-b9171c0d9c73@arm.com>
Date: Fri, 14 Mar 2025 09:36:03 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regression on linux-next (next-20250312)
To: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "Kurmi, Suresh Kumar" <suresh.kumar.kurmi@intel.com>,
 "Saarinen, Jani" <jani.saarinen@intel.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <SJ1PR11MB61295DE21A1184AEE0786E25B9D22@SJ1PR11MB6129.namprd11.prod.outlook.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <SJ1PR11MB61295DE21A1184AEE0786E25B9D22@SJ1PR11MB6129.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-03-14 9:17 am, Borah, Chaitanya Kumar wrote:
> Hello Robin,
> 
> Hope you are doing well. I am Chaitanya from the linux graphics team in Intel.
> 
> This mail is regarding a regression we are seeing in our CI runs[1] on linux-next repository.
> 
> Since the version next-20250312 [2], we are seeing the following regression
> 
> `````````````````````````````````````````````````````````````````````````````````
> <4>[    6.246790] reg-dummy reg-dummy: late IOMMU probe at driver bind, something fishy here!
> <4>[    6.246812] WARNING: CPU: 0 PID: 1 at drivers/iommu/iommu.c:449 __iommu_probe_device+0x140/0x570
> <4>[    6.246822] Modules linked in:
> <4>[    6.246830] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.14.0-rc6-next-20250312-next-20250312-g9fbcd7b32bf7+ #1
> <4>[    6.246838] Hardware name: Intel Corporation Arrow Lake Client Platform/MTL-S UDIMM 2DPC EVCRB, BIOS MTLSFWI1.R00.4400.D85.2410100007 10/10/2024
> <4>[    6.246847] RIP: 0010:__iommu_probe_device+0x140/0x570
> `````````````````````````````````````````````````````````````````````````````````
> Details log can be found in [3].
> 
> After bisecting the tree, the following patch [4] seems to be the first "bad" commit
> 
> `````````````````````````````````````````````````````````````````````````````````````````````````````````
> commit bcb81ac6ae3c2ef95b44e7b54c3c9522364a245c
> Author: Robin Murphy mailto:robin.murphy@arm.com
> Date:   Fri Feb 28 15:46:33 2025 +0000
> 
>      iommu: Get DT/ACPI parsing into the proper probe path
> 
> `````````````````````````````````````````````````````````````````````````````````````````````````````````
> 
> We also verified that if we revert the patch the issue is not seen.
> 
> Could you please check why the patch causes this regression and provide a fix if necessary?

Yes, the warnings are false positives, and the fix is already in today's 
-next, see 73d2f10957f5 ("iommu: Don't warn prematurely about dodgy 
probes"). Sorry for the disruption.

Thanks,
Robin.

> 
> Thank you.
> 
> Regards
> 
> Chaitanya
> 
> [1] https://intel-gfx-ci.01.org/tree/linux-next/combined-alt.html?
> [2] https://web.git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=next-20250312
> [3] https://intel-gfx-ci.01.org/tree/linux-next/next-20250312/bat-arls-6/boot0.txt
> [4] https://web.git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=next-20250312&id=bcb81ac6ae3c2ef95b44e7b54c3c9522364a245c
> 

