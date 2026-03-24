Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E902019D065
	for <iommu@lists.linux.dev>; Tue, 24 Mar 2026 05:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774330318; cv=none; b=BUmwtQC1FmnQ+IGj85rxdOa9K2C7YEwfLAe/UuzRlgdUDxnA79pQ76sGlPloMK88xk0fPrltcl3V4IW9n6B2FM3EAtgy3CPf0Pv6jc/2UN0ObevjY+QE6Zv6HRe0SOhYOrnaHHqe0PtkR+CUJl5SqkalLBlTRDmkSmLVZiBBmrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774330318; c=relaxed/simple;
	bh=RuOVmcFujF9Tc5k2xlfFtyBgAS1cdd5ce6ML0XBXbS0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nu1MJdM4PEx3LBlslvtxkz1F/KV73zzpfk/R7oP12o6UodA1p0MfK+O0BmN1cl4+GilKV8Ikvk7qLt3nkVJFTVjNffsKDdwHyvG9petslGZWuRpfsAAqHUdDhLhY0vouE/MiibP9juyaMA8QU8nK9e50iSICjaY3IfJbNxgJ1YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ETY9VW54; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ETY9VW54"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774330315; x=1805866315;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RuOVmcFujF9Tc5k2xlfFtyBgAS1cdd5ce6ML0XBXbS0=;
  b=ETY9VW54R926XpW6ltMx9CG5uHLluDImg/dRHoC6y3wTzrdAkbopY7xv
   2Q13FgKps3ruiDN5PcgAam8ipsfxWgNyxn4d88SHtNxGCeejHjr0Qvg7W
   HoiwDQZ3cKoDXUvk27uOE2j/1UfZhCR1c+b3TrQD5f/SkQB/IuuQtDULf
   FQtbk7COh5ItGVHr99BNfMT3wZTDmQmHo4jRNypqKDRR9mOZLt0VEMWE+
   Io4YEY2no2CwZsw11aN6i3EqFkdkndja6UmJyVOYZqi/YtOkgQT/ukB9A
   N9gjDlrS2HEecD3ZAUF4S2/IFjVAQ8mGWvPy2OpEfasL25uIWJOnbKC4K
   g==;
X-CSE-ConnectionGUID: qqAKibVnR4CQqmN4zj3RmQ==
X-CSE-MsgGUID: Bgt4bh23QwSviv6O6rU2Hw==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="86414594"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="86414594"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 22:31:54 -0700
X-CSE-ConnectionGUID: YtLBIA7uQUmUG49WF7QhYA==
X-CSE-MsgGUID: UvrK3qJFTtunlHID1aYfIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="223325921"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 22:31:53 -0700
Message-ID: <4a68ee46-45ff-43bb-bda2-88badcc319ce@linux.intel.com>
Date: Tue, 24 Mar 2026 13:30:41 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] iommu: Lift and generalize the STE/CD update code
 from SMMUv3
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Will Deacon <will@kernel.org>, Samiullah Khawaja <skhawaja@google.com>,
 Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
 Kevin Tian <kevin.tian@intel.com>, Dmytro Maluka <dmaluka@chromium.org>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260309060648.276762-1-baolu.lu@linux.intel.com>
 <20260309060648.276762-2-baolu.lu@linux.intel.com>
 <aa9W4ZKYWHr9-UNy@google.com> <aa9fQchZJER8QvY0@google.com>
 <61267acf-e42e-4d1e-9942-e241ccffa606@linux.intel.com>
 <abfStwmSjgy--e4H@willie-the-truck>
 <e89a6ce3-d0a9-4e91-9786-83c2bdb2efd3@linux.intel.com>
 <20260323125555.GC7340@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260323125555.GC7340@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/23/26 20:55, Jason Gunthorpe wrote:
> On Wed, Mar 18, 2026 at 11:10:12AM +0800, Baolu Lu wrote:
>>> Shouldn't we move the SMMU driver over to this, rather than copy-pasting
>>> everything? If not, then why is it in generic IOMMU code?
>> Yes. I will start to do this from the next version.
> I had written a draft already:
> 
> https://github.com/jgunthorpe/linux/commit/ 
> cda5c27a4020d162948259df9d3c8dd61196290a

Yeah, I will include this in the next version.

Thanks,
baolu
