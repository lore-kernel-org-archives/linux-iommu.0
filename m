Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E2B24EAB3
	for <iommu@lists.linux.dev>; Tue, 29 Apr 2025 06:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745909698; cv=none; b=bs0Fer/Tf4RKEInuu/MLsn+xzVNiagTOH5iVCrNIWPpxDJ+dg1dW1nW6hei7BIERqGxJX7E9oKeoaSeSGEIctBm37XcJOuENFWnumTjPOxn/yaGrI7bBctaintLTBh5YA/wixdDsQflgqM/EbAp2l7RtFTFKDrRQ8S08TKASNiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745909698; c=relaxed/simple;
	bh=PpZtbA9kdwBRA3jbs9L3Dv6eNjFnhgwGX0jsrHH7Kxo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PQ5lG/nB8JrOCQZ4P7QBerYarZXo7ks5mZPGDzIEZnfr7BrsqQ+58g7JuFNYjOeAXPZLs3ej/txerHdYBKopJB7R/kpsd0LvbImL+ltExsFxv0n2I3XEzgxgUgCd7Nke9PyZLWjTch0PromITvIuUTzqZ3vAwFjwna9Z0YVL6rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QaOJc6KY; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QaOJc6KY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745909697; x=1777445697;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PpZtbA9kdwBRA3jbs9L3Dv6eNjFnhgwGX0jsrHH7Kxo=;
  b=QaOJc6KYctkhbpWwi21l52OsEiLFQQN3+dHolAm76KLY5RfRhr/wNMk7
   wlDFrm0amyz9cJZ21mBJGrEkTawGajsqA6yD9m3EbxzofbX89xLNgAh0z
   oQTyMLNUYgMtt0Id5Edz5IsXnNcSk4DnIJ7RmT1zZzsf1GHQ789wA863s
   rV/dnVMaAs8FVCPcTHiTmn8Q3K3SJ9oI1kqiCBGmiuFrgXs/pMjGXUl4s
   oI1pcJGj4F93kzXEBFEoQjlQW9BbhzQjY+GMIAlU0PZTrJSP4swKIMcMI
   X2ry0XIOYIjpwsruAd6n6AOmdXsNzPPnamjRBX70ALEJpkcBOlkS6DP50
   g==;
X-CSE-ConnectionGUID: 3bg2XCUJSBmJGN24ZkkXiQ==
X-CSE-MsgGUID: sFahboUPQ36xelWX7/m3Sg==
X-IronPort-AV: E=McAfee;i="6700,10204,11417"; a="70023584"
X-IronPort-AV: E=Sophos;i="6.15,248,1739865600"; 
   d="scan'208";a="70023584"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2025 23:54:55 -0700
X-CSE-ConnectionGUID: 9eL1swR/S7aR3gcphn1kQg==
X-CSE-MsgGUID: 8dVE5jmeSmOYAhK9/+H+3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,248,1739865600"; 
   d="scan'208";a="134695028"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2025 23:54:51 -0700
Message-ID: <446b94d5-3192-448e-9f29-de1e04bbd517@linux.intel.com>
Date: Tue, 29 Apr 2025 14:50:39 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/riscv: fix use after free of riscv_iommu_domain
To: BillXiang <xiangwencheng@lanxincomputing.com>, tjeznach@rivosinc.com
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 alex@ghiti.fr, iommu@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250429034007.578-1-xiangwencheng@lanxincomputing.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20250429034007.578-1-xiangwencheng@lanxincomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/29/25 11:40, BillXiang wrote:
> The function vfio_group_detach_container begins by calling
> vfio_iommu_type1_detach_group, which may subsequently calls

I don't follow here. vfio_iommu_type1_detach_group() will eventually
call riscv_iommu_attach_blocking_domain() and info->domain has been
cleared there:

static int riscv_iommu_attach_blocking_domain(struct iommu_domain 
*iommu_domain,
                                               struct device *dev)
{
         struct riscv_iommu_device *iommu = dev_to_iommu(dev);
         struct riscv_iommu_info *info = dev_iommu_priv_get(dev);

         /* Make device context invalid, translation requests will fault 
w/ #258 */
         riscv_iommu_iodir_update(iommu, dev, RISCV_IOMMU_FSC_BARE, 0);
         riscv_iommu_bond_unlink(info->domain, dev);
         info->domain = NULL;

         return 0;
}

Perhaps I overlooked anything?

> riscv_iommu_free_paging_domain to release the riscv_iommu_domain.
> Then, iommu_group_release_dma_owner is triggered, which results in
> the execution of riscv_iommu_attach_paging_domain and
> riscv_iommu_bond_unlink(info->domain). However, the info->domain
> had been freed beforehand but was not set to NULL, leading to errors.
> 
> This commit resolves the issue by setting info->domain to NULL within
> riscv_iommu_bond_unlink, a function that is called by
> riscv_iommu_attach_blocking_domain before the domain was freed.
> 
> Signed-off-by: BillXiang<xiangwencheng@lanxincomputing.com>
> ---
>   drivers/iommu/riscv/iommu.c | 14 +++++++++++++-
>   1 file changed, 13 insertions(+), 1 deletion(-)

Thanks,
baolu
