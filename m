Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0E679DA
	for <iommu@lists.linux.dev>; Fri, 24 Apr 2026 06:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777011926; cv=none; b=OfDpiN1iqblA+fFdzJ1leyrtlhV3i/VY4hpssVtPQ2BjivOfYunJPrzy+K5JkAYv84I2kDZWHqACcQUzlNbCdPHziP7k1Z3xXSYYXijOoMHTwwitCMBql7zKVK6yyHuvd6ceVbkmAv/m72wWhKaUhbox6cVEKNt0Y7s1HyA0gWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777011926; c=relaxed/simple;
	bh=2+QUuwIGC7EVSb7GbLJuvcu4Wmb8s4Ff2kKNJCDuHSw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uLve0H/fuCOsKka0cMRTbqpzr+nIGUAE7VVmlSKZXgAYVmtiZ7vKXXZ5hMUeO3cK22jfekDF5UIE4UVb0FTG0wKrKxFnz3hQseEJ3kIAJEB1J+yVJl3QCzU9YLViPd260V8ofmMI41WmTazjrIdXHGwBWwana6lVrZl7kUSQ4k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PGJigMum; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PGJigMum"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777011925; x=1808547925;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2+QUuwIGC7EVSb7GbLJuvcu4Wmb8s4Ff2kKNJCDuHSw=;
  b=PGJigMumJ8g6LPgbQs38bv1yB8L2hei1dGmKTY6aATakSS5kaOwF9h1t
   KGfCPm45g6jvOcTt7WsdHJVGGgN594mZmXee9B8KiauZqjezs67KinkEs
   KlOnsAW6+BA9KJ9v6rvul5boU86kkt6+9WGid4IFcjhh8sfrJmL2T9sUS
   Qv5tcbcvdPZ203dU3nvTXFZGJzydw1PZBE7/VNO1/2enoZ88qAnfULu5r
   xUrouGcTY13wieE1JDkxG9Z/zICVh3sUqULpbXzd+C7KWJnAo8Ol4344Q
   a768NmiGaT4CQze7RN16UMPNGxO1N5EQQg15/fkHApNvMhroqiSfVY2st
   Q==;
X-CSE-ConnectionGUID: yzPn5fKCThadXb9Z5ewkiw==
X-CSE-MsgGUID: obeqQInWT6qostk2rjejxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11765"; a="77153961"
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="77153961"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 23:25:25 -0700
X-CSE-ConnectionGUID: bgwtxBrAQZW+j+WUEuUJRQ==
X-CSE-MsgGUID: qo7Ii5kiSjmSAgqx6V+TsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="256169998"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 23:25:23 -0700
Message-ID: <5170df16-94f0-4d12-803a-a43bc44aed83@linux.intel.com>
Date: Fri, 24 Apr 2026 14:23:17 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rc v7 5/6] iommu: Fix ATS invalidation timeouts during
 __iommu_remove_group_pasid()
To: Nicolin Chen <nicolinc@nvidia.com>, joro@8bytes.org,
 kevin.tian@intel.com, jgg@nvidia.com
Cc: will@kernel.org, robin.murphy@arm.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, xueshuai@linux.alibaba.com
References: <cover.1776551790.git.nicolinc@nvidia.com>
 <8914b746d0e19b05a26c1fc5d14f170336faa3d2.1776551790.git.nicolinc@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <8914b746d0e19b05a26c1fc5d14f170336faa3d2.1776551790.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/19/26 07:41, Nicolin Chen wrote:
> If a device is blocked, its PASID domains are already detached. Repeating
> iommu_remove_dev_pasid() is unnecessary and might trigger ATS invalidation
> timeouts.
> 
> Skip the iommu_remove_dev_pasid() call upon the blocked flag.
> 
> Fixes: c279e83953d9 ("iommu: Introduce pci_dev_reset_iommu_prepare/done()")
> Cc: stable@vger.kernel.org
> Reported-by: Kevin Tian <kevin.tian@intel.com>
> Closes: https://lore.kernel.org/all/BN9PR11MB5276D60096EBF15C5753C4BB8C202@BN9PR11MB5276.namprd11.prod.outlook.com/
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>   drivers/iommu/iommu.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index ff181db687bbf..30ba18e613faa 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -3554,7 +3554,8 @@ static void __iommu_remove_group_pasid(struct iommu_group *group,
>   	struct group_device *device;
>   
>   	for_each_group_device(group, device) {
> -		if (device->dev->iommu->max_pasids > 0)
> +		/* Device might be already detached for a device recovery */
> +		if (!device->blocked && device->dev->iommu->max_pasids > 0)
>   			iommu_remove_dev_pasid(device->dev, pasid, domain);
>   	}
>   }

If that is the case, why not add the same logic to the set_group_pasid
path? For example:

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 61c12ba78206..42a979ee0ced 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3532,7 +3532,7 @@ static int __iommu_set_group_pasid(struct 
iommu_domain *domain,
         int ret;

         for_each_group_device(group, device) {
-               if (device->dev->iommu->max_pasids > 0) {
+               if (!device->blocked && device->dev->iommu->max_pasids > 
0) {
                         ret = domain->ops->set_dev_pasid(domain, 
device->dev,
                                                          pasid, old);
                         if (ret)

By the way, now that I see the device->dev->iommu->max_pasids > 0 check
in the set_pasid path, I understand why you added the same check to the
remove path in patch 3/6. :-)

Thanks,
baolu
