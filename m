Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495573603D3
	for <iommu@lists.linux.dev>; Wed, 29 Jul 2026 03:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785294094; cv=none; b=afLW96qRUmrr79ALmJygPC58GmfrztXhHVBW5u8MdZkwqs4/ANgHw3vmFzn3qhUvWWSGfaYwn2ouRJhL5FaZUFhQZcFyZFLqlHhpwwVErNFG8ZLhAAyFk+TyEEt2CO4FzrNYWisOouvM64tDul7fhahux1T2h60HOvtyb3XmLC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785294094; c=relaxed/simple;
	bh=nkpkIL6JkM4q0AcVSMwNxUHqVdGp2NHpIdWrL/wahv0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vn+OVMn6eselbNHHIEtebPgA4qOboiuLd04d3hYVXvrp9/p7jTn4jDkIC+cRq3k+csfVJWAAIZGZHQCR7tJ/g1MTyYtyQvMoojhe2zVgfe+ZPAcypXxZOMpWTXULKkIDZ9gsHZ3OrScehDJiGva+bmm3xUNJU5ZpmzpSpQ1tkhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T2EMWwLS; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T2EMWwLS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785294093; x=1816830093;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nkpkIL6JkM4q0AcVSMwNxUHqVdGp2NHpIdWrL/wahv0=;
  b=T2EMWwLSAlLnJerA5UK1xeaGwp9K+3bMKpj8kaR+ZYuYlurfjOWk54H3
   eFFHVx0XUyWF/o/QKZ58uHttgpHlY/GLC1Wjsr9J601pLSITQ5kV100g/
   3zquMAD76RycecdXUK9YrNYZNA67fHYYsEEoPIXJG4bp65Rgm4+072obY
   mwBVaOfIkvjVcAr3obopGvN8EizDNlT8ewaoPFiJMXZKvCuboSqMz/ws/
   CvgnNRztjr6UbQwYyVZyslWgmZtf6UsbdtMUOaEkQNSVl6uyDnuDfzOUj
   A7Lbx1HyXl7RO/PqDJlP2HVvdYvkaYYamwn6QkvLviRUs5C/n+rKx5iiV
   g==;
X-CSE-ConnectionGUID: OPi+ZwjdScyRBzxIvsaIvg==
X-CSE-MsgGUID: cP+/ikmdTKCIz9hg5om78Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="103298201"
X-IronPort-AV: E=Sophos;i="6.25,191,1779174000"; 
   d="scan'208";a="103298201"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2026 20:01:32 -0700
X-CSE-ConnectionGUID: IstZblx9Q9ux2cm2AJa48g==
X-CSE-MsgGUID: cVpSEioOSX+ywf6Bpg1zmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,191,1779174000"; 
   d="scan'208";a="259947327"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2026 20:01:29 -0700
Message-ID: <52bff3eb-675c-4b63-a791-5a4e843d787e@linux.intel.com>
Date: Wed, 29 Jul 2026 10:59:35 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] iommu/sva: Set handle->dev before the SVA handle is
 visible
To: Shuai Xue <xueshuai@linux.alibaba.com>, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, jgg@ziepe.ca, kevin.tian@intel.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 oliver.yang@linux.alibaba.com, zhuo.song@linux.alibaba.com
References: <cover.1785050951.git.xueshuai@linux.alibaba.com>
 <c22e9af74d113b110348b995879baf2fd4734fe7.1785050951.git.xueshuai@linux.alibaba.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <c22e9af74d113b110348b995879baf2fd4734fe7.1785050951.git.xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/26/26 15:43, Shuai Xue wrote:
> iommu_attach_device_pasid() installs the new SVA attach handle in the
> group PASID lookup before iommu_sva_bind_device() returns. A concurrent
> bind can therefore find and reuse the same handle after iommu_sva_lock is
> dropped.
> 
> handle->dev was initialized after dropping iommu_sva_lock. This leaves a
> window where a racing bind can return a handle whose dev pointer is still
> NULL. A subsequent iommu_sva_unbind_device() can then dereference it via
> handle->dev->iommu_group.
> 
> Initialize handle->dev before releasing iommu_sva_lock so any visible SVA
> handle is fully initialized.
> 
> Fixes: be51b1d6bbff ("iommu/sva: Refactoring iommu_sva_bind/unbind_device()")
> Cc:stable@vger.kernel.org
> Assisted-by:Qoder:Qwen-3.8-MAX-Preview
> Signed-off-by: Shuai Xue<xueshuai@linux.alibaba.com>
> ---
>   drivers/iommu/iommu-sva.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
