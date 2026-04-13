Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCFA2D063E;
	Mon, 13 Apr 2026 06:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776062973; cv=none; b=dO9dUwZeLvQ5s3TB1bhU9WYtIrz+vw1jwMqPSQejdobqE0kf32+a8HyXf/yGpNEWmFs4H2Fctbm7DeBjhPscwjwcUQEz2yO582kyzaqBBlic3O5b/bHgOymrDtG+hrvNq9Tcy1lwzB/ZKlMvnDeIfo+A9UhwO7KwSV80dw1gv3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776062973; c=relaxed/simple;
	bh=c6shzak5a0ojomckogLwWc3omCBdCHFvDRUUPSebb7U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gyGBxOjvzZWDsNYSp0IsH8kyHLr5+wEtwEbRt8dMlAfeJ1DTR6GrBzmoi7+nffhODl8QYEfw4ojnoxhw2kWKZ12I+hMpHAuyrB2wWD7fWHHRuX5oTWe6Yb2Esr/tDuTX0Yh6jlKhKtnzK+xKUWobbcqq9WXXQ01cg7l+p0w9p2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IQLqZ6NE; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IQLqZ6NE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776062971; x=1807598971;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=c6shzak5a0ojomckogLwWc3omCBdCHFvDRUUPSebb7U=;
  b=IQLqZ6NECfz52x35wZ8z5hE86a689ZbnAIPFWRqowFtaiVDRDEUxD1y2
   T1FkYdiq+3hGwlYEIJm8x+uYj8aHzMQM+5+EzTrAd+znv9+oWg20acTYZ
   yzOB+IxEVHfqKrPlFL9OpIDoT6YaWWdbcXHiFiXkP2c10TqKiSkx+qo9o
   qxQJH67AGzwFN42NWrfsfWwt/OzSdyah68CGuVnqM3FAsDug97TnXPIca
   dipdw9OF0d8iPhjBjXj6qJUudGLSzzhd6o72cSpOw7NWR2VUtrOnMre3P
   Sj68rF/RKvBTRQn7x7MZ0E18phU9oPir2EHfb9aoLs/20WPlXnw4Itb1y
   w==;
X-CSE-ConnectionGUID: cBgZG3PxQwefmSnlrYNwYw==
X-CSE-MsgGUID: e7xJ4y5cQbq4srPnJnsW5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11757"; a="76876091"
X-IronPort-AV: E=Sophos;i="6.23,176,1770624000"; 
   d="scan'208";a="76876091"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2026 23:49:31 -0700
X-CSE-ConnectionGUID: 4hs9jAHjQwem1RQhfqg5Sw==
X-CSE-MsgGUID: zqV8INj0R56ht60ahSP8MA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,176,1770624000"; 
   d="scan'208";a="229576781"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2026 23:49:29 -0700
Message-ID: <56ce85d5-e0b9-407c-9a86-708111a8a509@linux.intel.com>
Date: Mon, 13 Apr 2026 14:47:42 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] GPU passes into VM improperly after c376a3456d8b or
 a98db518dde2
To: 70sp <70sp@protonmail.com>, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <z7Rkts0EsooZcnCjNfJaK6ursftFU8ubOkH0hcNjzxugEAwGsHLMblOdfoAx-gJzBZ-TMmeUtD7iWBngbFY5UCJCwdSmYqmCVMy-yhbirUk=@protonmail.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <z7Rkts0EsooZcnCjNfJaK6ursftFU8ubOkH0hcNjzxugEAwGsHLMblOdfoAx-gJzBZ-TMmeUtD7iWBngbFY5UCJCwdSmYqmCVMy-yhbirUk=@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/12/26 19:17, 70sp wrote:
> Hello,
> 
> I have been dealing with a regression launching a Windows QEMU/KVM 
> virtual machine with a GPU passed through.
> 
> The issue consists of launching a QEMU/KVM VM, which gets stuck for 
> about 2 minutes on booting with a white screen and then having NVIDIA’s 
> code 43 in Windows.
> 
> I’m certain, that the issue is not caused by anything in Windows or 
> related software in Linux, because I tried reinstalling my whole PC 
> including the Windows VM. I tried to reproduce the bug on an out-of-the- 
> box Arch Linux install and the bug is still present.
> 
> The first bad commit is either a98db518dde246e01ead53617dc0a30d6aaa3752 
> or c376a3456d8bef43ec556a98c0a04c35086c2737. I don’t know for sure which 
> one introduced it, because during bisection I had to skip 
> a98db518dde246e01ead53617dc0a30d6aaa3752 due to it being unable to 
> launch the virtual machine resulting in a different error (didn’t even 
> start booting). In kernels before these commits, the VM works flawlessly.
> 
> I have tested it on latest mainline kernel and the issue is still 
> present. I have been experiencing the issue since kernel 6.13, so I just 
> switched to the 6.12 LTS kernel instead which doesn’t have this issue.
> 
> Configuration of my Linux install and hardware: https://pastebin.com/ 
> rcsyyYiK
> .config: https://pastebin.com/RTQCBduD
> dmesg errors: https://pastebin.com/84jPP81E
> lspci: https://pastebin.com/qi29BSWi
> 
> #regzbot introduced: 
> a98db518dde246e01ead53617dc0a30d6aaa3752..c376a3456d8bef43ec556a98c0a04c35086c2737

Before these commits, if a device was attached to a domain that didn't
perfectly match the hardware's capabilities (such as address width or
coherency), the kernel would dynamically adjust the domain to
accommodate the hardware.

Following these two commits, the driver now applies a "match or fail"
policy. If the domain is incompatible with the device's hardware
capabilities, it returns -EINVAL. This expects the caller to allocate a
new domain dedicated to that specific device and attempt the attachment
again.

Can you please add a message line in paging_domain_compatible() to
verify whether it's a domain compatibility issue?

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 205debd76989..c7e1e0dfa250 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3111,8 +3111,10 @@ int paging_domain_compatible(struct iommu_domain 
*domain, struct device *dev)
                 ret = 
paging_domain_compatible_second_stage(dmar_domain, iommu);
         else if (WARN_ON(true))
                 ret = -EINVAL;
-       if (ret)
+       if (ret) {
+               dev_info(dev, "domain is not compatible with device, ret 
= %d", ret);
                 return ret;
+       }

         if (sm_supported(iommu) && !dev_is_real_dma_subdevice(dev) &&
             context_copied(iommu, info->bus, info->devfn))

Thanks,
baolu
