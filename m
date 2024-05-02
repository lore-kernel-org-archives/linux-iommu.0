Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD6910A24
	for <iommu@lists.linux.dev>; Thu,  2 May 2024 02:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714615670; cv=none; b=btOv0smTYcco17hkBdEsZYK0wNssAUI/h1cghzTC2V5038Sb+Ahzdyt1J0RCsX1XQGYS5Vk12+irRZ6ktKP03QnZWkVnKrfYReSLMdVb8boPGpm9CN8xIYSg/sfPp6myHAFqxnzGB3iei0JTuY9flsBY8tlCj/1EU0AC1xulhgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714615670; c=relaxed/simple;
	bh=QF8d4nyVCR6eb4ifi8sajRySGMaCZfYzZt/syNMLUxQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LFNlTZ5RWV2SY+QIUTiMHOTrWWhOQvvVgYxBvBrhYIAHsXlxRzXXEiPEw4FrP+e3dCWU0IzlaSme9+Aw1Yj2fGEW4KplGPL+/TTtv2jIXZKiDbcb7ye4MR5zZt2zjjQW1m7ILb2HE+jTN/+d1TmyIoru6TUAIbaa40D/vCcQZbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D9AehjT5; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D9AehjT5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714615668; x=1746151668;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QF8d4nyVCR6eb4ifi8sajRySGMaCZfYzZt/syNMLUxQ=;
  b=D9AehjT5rXZMA0gJsoEHc65aRblGsAGsWMrCJu6+iAxBYpX7qfTW5WUx
   oeF4TQUBW6WsqQNW6UiuAbPg0RILdWV2S0PlkAGZvJpmkKtxTYvyAzyGq
   T0SvoYt/lquzf50cdBxiGEOqy2VfQKlcnO3klYRwUEAvZ0Qf7yeizvgg9
   EwUpvvd3if53fK1Zp7vSIzct7PixTjfmvurwiPaeh3xOYcM0SlrgREsdq
   qUilLoPkP2fcbZAYCcdF3Dp9Q6IfXMHcUxB3KtV4xa1JgOpAl2Mdl9KcY
   adC4iccXuieaD6WkcwSzfj2/V0QtSd4uZKLDZjID9Epbnnh+Cm/KpjD+r
   g==;
X-CSE-ConnectionGUID: Ma4HYKMISXSlyDEG8DqzuQ==
X-CSE-MsgGUID: a6K5GvKURWuDYc36Xza1cw==
X-IronPort-AV: E=McAfee;i="6600,9927,11061"; a="10299067"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="10299067"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2024 19:07:48 -0700
X-CSE-ConnectionGUID: fX9D8ukwTxa/swG0AAI1Yw==
X-CSE-MsgGUID: Hh+UrfrCTWu4AZjS27jUFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="26942419"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by fmviesa009.fm.intel.com with ESMTP; 01 May 2024 19:07:43 -0700
Message-ID: <ce55d297-ea61-470f-b979-69fcfa743f8e@linux.intel.com>
Date: Thu, 2 May 2024 10:06:12 +0800
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
Subject: Re: [PATCH v3 5/7] iommu/riscv: Device directory management.
To: Tomasz Jeznach <tjeznach@rivosinc.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Paul Walmsley <paul.walmsley@sifive.com>
References: <cover.1714494653.git.tjeznach@rivosinc.com>
 <ce3b82a20db0b776685269674ce9b7a926d5680d.1714494653.git.tjeznach@rivosinc.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <ce3b82a20db0b776685269674ce9b7a926d5680d.1714494653.git.tjeznach@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/1/24 4:01 AM, Tomasz Jeznach wrote:
> Introduce device context allocation and device directory tree
> management including capabilities discovery sequence, as described
> in Chapter 2.1 of the RISC-V IOMMU Architecture Specification.
> 
> Device directory mode will be auto detected using DDTP WARL property,
> using highest mode supported by the driver and hardware. If none
> supported can be configured, driver will fall back to global pass-through.
> 
> First level DDTP page can be located in I/O (detected using DDTP WARL)
> and system memory.
> 
> Only simple identity and release (blocking) protection domains are
> supported by this implementation.
> 
> Co-developed-by: Nick Kossifidis<mick@ics.forth.gr>
> Signed-off-by: Nick Kossifidis<mick@ics.forth.gr>
> Signed-off-by: Tomasz Jeznach<tjeznach@rivosinc.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
