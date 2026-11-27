Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795760460;
	b=oy/sL9P7rUqbUXbuQnxm6piQ2m5HqLzRzkPKtDpD5FFqfjn2IeYf3zY90W7HK5NLu2KN
	 Q7QZWRviqs6dTMpc1ii0JzlXZ9LhHXgjCMtxgP/VIVyCos71r/RtINsKTodKSKsnI5Oe0
	 HdX6VZwvK1if6JHelNMxsD6sVT+OTYNPE8TWpi/cShUjcOBIpnCdKjpSClBcSwOvqTUVH
	 bg4L1cJKRvKpHIzjgY7x5Gw3oJRS4dbdRw9aEnWUT27/gFsE78CpA8+1co3gfGh2ApJNx
	 Xy6dj/35pVdhmqe04s1aEAEbnBHm0njPyMLAKDznGS/4nB7zmUA73Xq7zWEahyui0NQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795760460;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:References:Content-Language:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=wRvoJuHizE5kAfOqgbi12VTVO89OpDkB8GyUIe90Dd0=;
	b=IqbSg1rDQ+zD7ELViOojobQDtjVMZ1hCuIQRIn2dRBV1XbBSM7Tr8WV0VpQ6sd/x5Yi9
	 1euSxgtNW2piJvv3/DmMfqCk1HuZb0TOn4qLTWExkRyijr0/Z5xo33jGQoUKqT5BPn7Ae
	 aRh2ZP+klD5YCgiIfBK9UgkAzS2RcfyfkkpDjkMUvSO+PlLmSoFr6eoO3jF2KcaZDS134
	 1n9CWArqIzuN4uZhlDKsVdYNrklBZIchabKxnXkRgMPwOo0B9un0asGFnt0gbFKMWW1Lp
	 dRhinne+KDmgWrplLV5mF45/ovYarYOg8318ZV96XEIKZ8TWVenbYfiPsT8bHwO7lJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hagWw5Vw;
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA99606A32A;
	Fri, 27 Nov 2026 06:20:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7BA99606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hagWw5Vw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795760460; x=1827296460;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=umpBYyow/SOpcQs7PqWAQG0UpXjcYz/uyaroMTYK8YU=;
  b=hagWw5VwCYt8p31Fa3Fkq2Qmd50bT3vevbGLYF1ON6DCar4uDeCq3kqq
   3B9LsKLXrys1X3hXpSh2+xMTXxuyKFF5+MHnZVyPyCK1esJt6qb6qevsZ
   55aNKy64C2kY7wGX48wZzZcEj8xp+sHtbWnGTWWIAVhtioa6hlUUBCoaZ
   oQpfU0vUpir52OLb3ggwVA56YrmOrinfsFiVlEtEN0MRgmvdqJx+E4cKa
   SmeMpZPLbhT/JBkk4Z8R3iHQwRTyqEfSB5dEs1ZiH2Tn4nIaQQfoDosNE
   hc47m59TYL1zbscUAT205jAXUldgk7eKihA0PC1mnIUgf7yYmcmhgXTIf
   Q==;
X-CSE-ConnectionGUID: IxQpNDW7TbWwUMsf9rHHrg==
X-CSE-MsgGUID: LWLVJGrRT1CuILB/vaL21g==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4522363"
X-IronPort-AV: E=Sophos;i="6.27,236,1787036400"; 
   d="scan'208";a="4522363"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2026 22:20:59 -0800
X-CSE-ConnectionGUID: Fyl54NFiRq6FEzowfDvdSQ==
X-CSE-MsgGUID: SqgsGfoZRcKvwuMOTslu6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,236,1787036400"; 
   d="scan'208";a="14097705"
Received: from blu2-desk.sh.intel.com (HELO [10.239.156.26]) ([10.239.156.26])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2026 22:20:57 -0800
Message-ID: <d931a389-c143-4a6a-931c-bc7025bcefb9@linux.intel.com>
Date: Fri, 27 Nov 2026 14:20:55 +0800
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
Subject: Re: [REGRESSION] GPU passes into VM improperly after c376a3456d8b or
 a98db518dde2
To: 70sp <70sp@protonmail.com>, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
 Thorsten Leemhuis <regressions@leemhuis.info>,
 "info@aigeus.net" <info@aigeus.net>
References: <z7Rkts0EsooZcnCjNfJaK6ursftFU8ubOkH0hcNjzxugEAwGsHLMblOdfoAx-gJzBZ-TMmeUtD7iWBngbFY5UCJCwdSmYqmCVMy-yhbirUk=@protonmail.com>
 <56ce85d5-e0b9-407c-9a86-708111a8a509@linux.intel.com>
 <C4BK-Bp_FII0EkxSHQxBS2wO-Age-UxFrp_KfmYzb8cnQ8ZndzBBIPD8S9T86wOifBP0tysQGCFtGQsBsBvG2IzIMw3jb3NF5HGbS3tsawA=@protonmail.com>
 <d6a7f70c-5a8a-4be6-abdd-5b3decbb602a@linux.intel.com>
 <7ec374cb-9a0a-4e30-8410-3a028e46cacd@linux.intel.com>
 <5bVscg7a2_H1PPW3HmVtrYv_Xwtti2hzjD065W4OdwsD9rC2gw7sGVEg-2U596VZn8O2LAEfhWeZklRk63ymqNW9220R6R_jjif7BaWol9o=@protonmail.com>
 <82662a17-f9e2-46dd-9881-792412c1dc50@linux.intel.com>
 <X7nc9tQqVxmuR76GYNJnMRkqUTwNVlXTWpH0wGvJeiAHlcLaibPZHRN037p0359GpdmopB_wI2tF2x6EqZF4oY9J697tcTGYwfYMK96FcUs=@protonmail.com>
 <275dbe0d-0b2d-4ec4-9c8c-9bd7ddf06070@linux.intel.com>
 <QISmXFlpPMgvFUKmdIBDwqn4JHHXt2NZeJzerMLHF_5icLo0lPKVlN0Ig9v8Vb52NmCeSFdyrao4x8KoN1DCXtDlnZS7eRIClC6vZyu-hPU=@protonmail.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <QISmXFlpPMgvFUKmdIBDwqn4JHHXt2NZeJzerMLHF_5icLo0lPKVlN0Ig9v8Vb52NmCeSFdyrao4x8KoN1DCXtDlnZS7eRIClC6vZyu-hPU=@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/24/26 22:48, 70sp wrote:
> Hello,
> 
> I (alongside ChatGPT) found the solution and the root cause of this issue.
> 
> The regression is caused by the code improperly assuming that the CPU supports IOMMU superpages, which it does, but only when the integrated GPU is disabled (speciality of Intel Haswell).
> 
> The regression can either be fixed with a single kernel parameter "intel_iommu=on,sp_off" or by modifying the code.
> 
> The LLM also generated me a patch that worked, but it was just about hardcoding specific CPUs to not use superpages. Doesn't seem like a great solution for this very delicate code. A much better solution would likely be making a patch which checks for superpage compatibility universally.
> 
> I am sending a working patch from a month ago edited by me and the reasoning from ChatGPT (if somebody would find it useful) below.
> 
> the patch:
> ---
>   drivers/iommu/intel/iommu.c | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 5a2e705a2f2e..dd49a4e37653 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -23,6 +23,7 @@
>   #include <linux/syscore_ops.h>
>   #include <linux/tboot.h>
>   #include <uapi/linux/iommufd.h>
> +#include <asm/cpu_device_id.h>
>   
>   #include "iommu.h"
>   #include "../dma-iommu.h"
> @@ -1876,6 +1877,13 @@ static int __init init_dmars(void)
>   	return ret;
>   }
>   
> +static const struct x86_cpu_id haswell_cpu_ids[] __initconst = {
> +	X86_MATCH_VFM(INTEL_HASWELL, NULL),
> +	X86_MATCH_VFM(INTEL_HASWELL_L, NULL),
> +	X86_MATCH_VFM(INTEL_HASWELL_G, NULL),
> +	{}
> +};
> +
>   static void __init init_no_remapping_devices(void)
>   {
>   	struct dmar_drhd_unit *drhd;
> @@ -1907,6 +1915,14 @@ static void __init init_no_remapping_devices(void)
>   		/* This IOMMU has*only* gfx devices. Either bypass it or
>   		   set the gfx_mapped flag, as appropriate */
>   		drhd->gfx_dedicated = 1;
> +
> +        /* Haswell requires superpages to be disabled in the default
> +		   remapping unit too when integrated graphics is enabled. */
> +		if (intel_iommu_superpage && x86_match_cpu(haswell_cpu_ids)) {
> +			intel_iommu_superpage = 0;
> +			pr_info("Disabling superpages on Haswell with integrated graphics\n");
> +		}
> +
>   		if (disable_igfx_iommu)
>   			drhd->ignored = 1;
>   	}

Good catch. Could you please re-post this change as a formal fix patch?

Thanks,
baolu
