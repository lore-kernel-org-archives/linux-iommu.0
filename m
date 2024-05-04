Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D03539C
	for <iommu@lists.linux.dev>; Sat,  4 May 2024 02:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714788415; cv=none; b=EGyTGZuGHsyxA33M+uNSAdewzzCUEJhV088vK9diDnAy5GwNDeBfXcKk9mLyOXR3nRaHrBLCXatdDwOESS+anNmMdLV/iaxfBqOSDzvjOISWTq189atfw7I/oUi8q2wvw6QUXMUpJYv8ZbgJtXjUvqiVd81Raz2nDswnttuFN9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714788415; c=relaxed/simple;
	bh=9/HUwWFCApOtzCHm2pdpofQL3S13z9SIlzxOPXrKgLE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uFC75PHgPnAmIqBA8dtc9p0/28TgfZUEzEUSkek+P22sqNiUERqdl5CIPWD7996DiEhvE+EbgMsxYsTpiTIMU/Gw/y0jLeWu8qftRBZe2VzOqfAZ54ANYKSSAt+JwONk5yNc8DAobOewwfzALEjEw/H3+YTocK99IzO0BLfnkrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AL7P9+4f; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AL7P9+4f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714788412; x=1746324412;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9/HUwWFCApOtzCHm2pdpofQL3S13z9SIlzxOPXrKgLE=;
  b=AL7P9+4f0jOzNrZ01eD0aKTI0ZZt/vOGaFexEdJSDNsgF4RoDWWxvgyI
   uoH2MtqVwrHldHYFoSPLFMoSxjtqQ1FPiPPLsDjM6o1AiBDzv9/XIGx7k
   K2lRJIyoCIZW7w2It4/IkCQQ73nFQrlyUOJ8dmkOJlDQJbtx5ZqQ7hlwK
   34Avc3iTUw/yO2u3/9995av1203+HDqscx3HbVFnA4VNKVSaKDRFwGt1f
   WugVkO/Cnp/UrUI8AKKUQoJEGYUrYjhhOUumKgEqv7wp3DgnWkcwfmXMU
   0g0LwLfZk4oNVe1t8YljRi417VwyuFU0MRWyHt3THJ3z+3mAVpqSVhM9G
   A==;
X-CSE-ConnectionGUID: i1DOmm7bQ9ycQjCHF+cfeQ==
X-CSE-MsgGUID: jilpvzgrST2KTnhus+hghg==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="14395695"
X-IronPort-AV: E=Sophos;i="6.07,252,1708416000"; 
   d="scan'208";a="14395695"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 19:06:51 -0700
X-CSE-ConnectionGUID: fbqs6S7CTPSDYfcFMS4Sgg==
X-CSE-MsgGUID: +lc4EfxITNWBw/CbQ7Frqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,252,1708416000"; 
   d="scan'208";a="58818072"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by fmviesa001.fm.intel.com with ESMTP; 03 May 2024 19:06:47 -0700
Message-ID: <b17ca96a-9e0c-43ca-9815-fee5a3661ad4@linux.intel.com>
Date: Sat, 4 May 2024 10:05:14 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Anup Patel <apatel@ventanamicro.com>,
 Sunil V L <sunilvl@ventanamicro.com>, Nick Kossifidis <mick@ics.forth.gr>,
 Sebastien Boeuf <seb@rivosinc.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, devicetree@vger.kernel.org, iommu@lists.linux.dev,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux@rivosinc.com
Subject: Re: [PATCH v4 2/7] iommu/riscv: Add RISC-V IOMMU platform device
 driver
To: Tomasz Jeznach <tjeznach@rivosinc.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Paul Walmsley <paul.walmsley@sifive.com>
References: <cover.1714752293.git.tjeznach@rivosinc.com>
 <68afb8d5e45e82dfc818385e01e9ddaa659007e1.1714752293.git.tjeznach@rivosinc.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <68afb8d5e45e82dfc818385e01e9ddaa659007e1.1714752293.git.tjeznach@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/4/24 12:12 AM, Tomasz Jeznach wrote:
> Introduce platform device driver for implementation of RISC-V IOMMU
> architected hardware.
> 
> Hardware interface definition located in file iommu-bits.h is based on
> ratified RISC-V IOMMU Architecture Specification version 1.0.0.
> 
> This patch implements platform device initialization, early check and
> configuration of the IOMMU interfaces and enables global pass-through
> address translation mode (iommu_mode == BARE), without registering
> hardware instance in the IOMMU subsystem.
> 
> Link:https://github.com/riscv-non-isa/riscv-iommu
> Co-developed-by: Nick Kossifidis<mick@ics.forth.gr>
> Signed-off-by: Nick Kossifidis<mick@ics.forth.gr>
> Co-developed-by: Sebastien Boeuf<seb@rivosinc.com>
> Signed-off-by: Sebastien Boeuf<seb@rivosinc.com>
> Signed-off-by: Tomasz Jeznach<tjeznach@rivosinc.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
