Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97BE2C181
	for <iommu@lists.linux.dev>; Fri, 21 Mar 2025 02:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742523099; cv=none; b=P2JSKq3JICCk1u6r8yzGxXN7L555p+ol0Db8GTMWyOETCts619gm8od1TdMOAS+u0xAJ7rrSUeu3hOMl1Fh7Vb2OrziSStpN1rLK6kxpRF7lK4r7DE87X2bmRwXl+xAgb/YzweYersmOKyoKOFu7kjx8/bIIj0LCfbXe5MF4aFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742523099; c=relaxed/simple;
	bh=ArQjv3KOMdmzJaSmyIcZmaHhCrsbH4cvZZmFXgBsP/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ChTWyP82LSNQKXk/fMai7zbinoKcNGPiJQK3tk0Xnxtrih2MpvuWmwzhOW4mVboOR6bcc5dOR1BrEdWIP9SLDOcIgyYR5nFuOtlhQXCx37srXfAmhQNe99M8JUiNWked+4vkYNJ3sOE46ShVlGSMNmNea9XzJtf1GORijaMP0fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B53fg7U6; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B53fg7U6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742523096; x=1774059096;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ArQjv3KOMdmzJaSmyIcZmaHhCrsbH4cvZZmFXgBsP/Q=;
  b=B53fg7U6ZUkEpfGZeBsaqItV1d3aOwsdL/wdDMuyAN1j39eZ+rGMyK5Y
   LN4qv9vcxnOhzNSakhozv/9n5zG1NZTUWXG9inLOKIWiUJ7l7bkNDfz7t
   ZnF+Guxs4W8NSqfJ921IYuJ7IcSShmxAZFCA5VJEmCCZfm64LBTgSynhB
   QWx03+iHqZMS7XNScI0Wct5pIyAKNRHSXxIzlNc2qbHj3a0nmP37mHjkO
   uHYfoT0B4lObXiLYxkcWtbj6e03fvQTgTT+PKpka+2Np+kZFvCX+oEZcO
   QxTfgUa7451tTcud6LurVxlcbvcZhTojt7p70f7dWOM4ynZAclOA/1vlB
   Q==;
X-CSE-ConnectionGUID: 2o16GIIRQdKxt4ygY/MjvA==
X-CSE-MsgGUID: fQh6AiL7SCi6mvB/yGOoLA==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="53998236"
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="53998236"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 19:11:36 -0700
X-CSE-ConnectionGUID: E6twKdF/T2KoDc5u/aFzQw==
X-CSE-MsgGUID: f0NVAP4jQGuKvuvx1rkrUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="123083651"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 19:11:32 -0700
Message-ID: <787bebc3-a3b1-4f0f-9729-49f065f88bb6@linux.intel.com>
Date: Fri, 21 Mar 2025 10:08:01 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] iommu: make inclusion of riscv directory conditional
To: Rolf Eike Beer <eb@emlix.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 Bert Karwatzki <spasswolf@web.de>, Jerry Snitselaar <jsnitsel@redhat.com>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Tomasz Jeznach <tjeznach@rivosinc.com>, Nick Kossifidis <mick@ics.forth.gr>,
 Sebastien Boeuf <seb@rivosinc.com>, Palmer Dabbelt <palmer@rivosinc.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>
References: <12652899.O9o76ZdvQC@devpool47.emlix.com>
 <2799755.mvXUDI8C0e@devpool47.emlix.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <2799755.mvXUDI8C0e@devpool47.emlix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/20/25 17:16, Rolf Eike Beer wrote:
> Nothing in there is active if CONFIG_RISCV_IOMMU is not enabled, so the whole
> directory can depend on that switch as well.
> 
> Fixes: 5c0ebbd3c6c6 ("iommu/riscv: Add RISC-V IOMMU platform device driver")
> Signed-off-by: Rolf Eike Beer<eb@emlix.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
