Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26FD2DEA68
	for <iommu@lists.linux.dev>; Wed,  1 Apr 2026 07:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775027491; cv=none; b=rinLVZB4M5zjkULW22lvGRR6JtrDTOvpazq4+RLMr0mhtmybbePzTxGgpWO227jPE+2zhLq1/RhQi/0naD6NfpgtkxAXO2cV2wgRBaUatgxtC3NGW2w3OqGJ2pQ2SgkN3nnShwE6OPvr4QjFe7Ik/4O+xLWdOzJUETrIJa4TCaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775027491; c=relaxed/simple;
	bh=0TiuTlraGMKMYE6mFmz/CQQ5voSfC24rcMPYPBMPAMA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BMg7YuUJcBm55l+o8xwugGUxJ9x1Fbk0vkENX7IaiIcJjoJ5Zk5PCc++/o1Wa8AlsrPt/SHR3IeYjdZSCDvLLansUNGDHq7Jmrd3hPHCMTZF2JBY2SxPHi1ic7WvfeI4tXXHfhlgLJRL7vNYAhwW65MdOBMGnPYkN1BlgrQrR1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IBwXm+2I; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IBwXm+2I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775027490; x=1806563490;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0TiuTlraGMKMYE6mFmz/CQQ5voSfC24rcMPYPBMPAMA=;
  b=IBwXm+2IDJEdm1mKn3SyPsxqtYSiysRg8ZX9jJFVzJx8yLRtDk4ZUcIx
   bFINqCtz6xATXku5I/R7tc1dQxfM6jt6Qv3jCddebzQUl/9jd9x18vtST
   aNG41n9DIxfWvdvwl5oL3aQrzC595QEz9OHp5msNuIVk+Mg3Eku4ibOcL
   awLSn0LA8OCiTyyfm2xQ2OR2NezHakJkJxCRL1m87XAsBsVAuLwkuR0lS
   2uYv5vFUBOR392QN4tSIvaGBuAELRVaIoWsAVpX6dCnHmD+3HGKmlm+8r
   khVesnkbspykx7wCqzqkIXTzquOsrqFQ7uUwgooBa05j/dr9b0XOxNiy6
   g==;
X-CSE-ConnectionGUID: h/+k7HcZTxa7EJmdKA/mbg==
X-CSE-MsgGUID: fYJOv9yMR6WdB6wPHIfkvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="93637910"
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="93637910"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 00:11:29 -0700
X-CSE-ConnectionGUID: QApIE9Y9RCatOrV9BhY51A==
X-CSE-MsgGUID: F/uqJu7/RJqWKUA0+j3a5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="225762783"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 00:11:27 -0700
Message-ID: <f6336284-a792-491e-95e4-2459112989cc@linux.intel.com>
Date: Wed, 1 Apr 2026 15:10:01 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/2] iommu/vt-d: Remove dmar_readl(), etc
To: Bjorn Helgaas <helgaas@kernel.org>, David Woodhouse
 <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
References: <20260217214438.3395039-1-bhelgaas@google.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260217214438.3395039-1-bhelgaas@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/18/26 05:44, Bjorn Helgaas wrote:
> Remove dmar_readl() and similar wrappers because they add nothing over
> readl() and are used inconsistently.
> 
> dmar_writel() and dmar_writeq() swapped the order of the address and value
> parameters, so I put those changes in a separate patch for ease of
> reviewing.  I'm happy to squash them if desired.
> 
> Bjorn Helgaas (2):
>    iommu/vt-d: Remove dmar_readl() and dmar_readq()
>    iommu/vt-d: Remove dmar_writel() and dmar_writeq()

Queued for iommu/next.

Thanks,
baolu
