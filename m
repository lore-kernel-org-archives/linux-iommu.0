Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBED28C0B
	for <iommu@lists.linux.dev>; Sat, 15 Jun 2024 03:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718421869; cv=none; b=YjmaP4QWvDjjqWp/JinHYNI1EylY7wbR8AfLxvWNNVY7fGCJy5xZHR6oHbFYKd2BtYzl8TfmskY7d059RF7yAcwfT3OMUZb9++vJMl8gEccukZ6X0Ae/NQuBn7i00Utqn1TcTn97NECSy20VJt8eIMydxwWD9SkLZR02okDedgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718421869; c=relaxed/simple;
	bh=ZhDyvZjrKNUgqfOnQHg80XwyNyd57tVs1xZ403nIE54=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qrlz8+qEKfpsbOR4Mlq7txW3xED07jdk7VDsXMBAo3lA3UO6WD0XhlYvmH0GwXuAUdcRMNwnDYMAP0Ddk+6u4RQXtbkhy4UJFdorOnuMJNHlgPi/W73yMuDw3S/18+cpnq/RhUX2C3sUuBkoPio0dzcFrCkUAO5gPFUpbopqNaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V0JoYiM1; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V0JoYiM1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718421868; x=1749957868;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZhDyvZjrKNUgqfOnQHg80XwyNyd57tVs1xZ403nIE54=;
  b=V0JoYiM1OhG70lcuK646x4a089n1k4laMB4dpPU8YMy/TKhOSt2kdMZT
   Q+jkDvtK/p5RfSpknn4iqsOOanN9sw0XxZXxEQet1bvvSMZyWk/VRFhwp
   n+Rrp3UcCL50mHQVhqiqVu6hxsRk+gInPbQPVljjaNGvcj9u+gU/vv7Ye
   PbWmazOz1MQyjZxM4Qa6aloWIknih13ExbIplEJ36jC+tC3Xa4ISLzQl5
   iHGxjTXbN8yjEiQ0oOLvPd1gC/OZkjW3x7rFXO8jarlsuGa6fboBJ/f1G
   UPh3Gj9zysgkSgRWDQpJ81+dTLeYWNzqa+ISNgUssvXyBR5ocsv2nAZro
   Q==;
X-CSE-ConnectionGUID: O3A8lEAvQBa/6kwsjKJg9Q==
X-CSE-MsgGUID: GJMdZxsDQTaGjzjf3154Dw==
X-IronPort-AV: E=McAfee;i="6700,10204,11103"; a="19184013"
X-IronPort-AV: E=Sophos;i="6.08,239,1712646000"; 
   d="scan'208";a="19184013"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 20:24:27 -0700
X-CSE-ConnectionGUID: 92QNrtsCSg2Uvzp7bb7Aqg==
X-CSE-MsgGUID: Wykncz7CSsKgxePnXrnqEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,239,1712646000"; 
   d="scan'208";a="78167097"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa001.jf.intel.com with ESMTP; 14 Jun 2024 20:24:23 -0700
Message-ID: <fb252e35-46e1-48ba-b236-a3296922ffdb@linux.intel.com>
Date: Sat, 15 Jun 2024 11:22:02 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com
Subject: Re: [RFC PATCH v2 08/10] iommu/riscv: support nested iommu for
 flushing cache
To: Zong Li <zong.li@sifive.com>, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, tjeznach@rivosinc.com, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, jgg@ziepe.ca,
 kevin.tian@intel.com, linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 linux-riscv@lists.infradead.org
References: <20240614142156.29420-1-zong.li@sifive.com>
 <20240614142156.29420-9-zong.li@sifive.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240614142156.29420-9-zong.li@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/14/24 10:21 PM, Zong Li wrote:
> This patch implements cache_invalidate_user operation for the userspace
> to flush the hardware caches for a nested domain through iommufd.

$ grep "This patch" Documentation/process/submitting-patches.rst

Same to other commit messages.

Best regards,
baolu
