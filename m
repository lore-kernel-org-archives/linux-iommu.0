Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB74E29DB9A
	for <iommu@lists.linux.dev>; Wed, 10 Jun 2026 03:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781061574; cv=none; b=D/BTMiYWIY2/wEa24C+RzQGB5ZFVNSWL9lUmRzEd0f/DZTe8Vsnv5pl3faQ901R/CPg1pB6v+O0g0JIt8JmHRUMiHHMGzgsaENIqm0L9I/rogO70/0lOLGqQb1OFLykGlZ3e4UqQdgFQ+lcC82etV/HBMVecEAf6KA6zo8hyd7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781061574; c=relaxed/simple;
	bh=exbgEJQ4JpJtyxg7lcrIa73JtRy+9hzGS5/TT2IIOho=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wkzw/2/VFmcltVylH26ujJAmNNojoggCFDLXEwZWD23lgwQW6TLWSlniH+CXErY0M0o8NeNqnklzuOpbLSdyysmeEcSpsp5SAxq17SEyIIHJllAW1BjglD8vKSFd7qlAu/3+RdXcIEpQfdfZoyt9UeKzvKdTzEbmYH+3sg+onMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V3aphE39; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V3aphE39"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781061573; x=1812597573;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=exbgEJQ4JpJtyxg7lcrIa73JtRy+9hzGS5/TT2IIOho=;
  b=V3aphE39pD8fugyS0zQH8uH+iG4KoP4j/ww8MEbYbye4wmpvQVdpuq7I
   u/KKM43pNmeuFE3/C8lN4Ha9CkkQMp0M2LpptJRk4JJBXMgrAu30XzJCY
   95BhJlT0mOwvq7T7fucEwg4YxTI39stMTlQxuZdA+lB17+BLEFzyAyajs
   kKnCUWTRyJWj5/l7/FqWX5hwWZpSm0wFp3Z37avWB1u8H2+hCuR48+j1Q
   TjSuMzpbIjzcZxQ8hy1BsIw48/6qLBrR+9rI0O4f++TqAQVMD26qXqkLN
   0+nWyx3Fp2PZwL9kJ9HXMIhg9dh9kpqquB0lvP9JV+NYRmnnuyyEun6yy
   g==;
X-CSE-ConnectionGUID: hhnE3V1iRLWTfjBLwnQvRg==
X-CSE-MsgGUID: GIt6i0xqRDS9zfRXh3u2Ig==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="84413794"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="84413794"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 20:19:32 -0700
X-CSE-ConnectionGUID: L1aE+6sZQB6LuwYQrTII0w==
X-CSE-MsgGUID: xeqaVAr7RL6fBGnnmy0o4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="249967784"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 20:19:28 -0700
Message-ID: <afbaa5d0-a23f-47df-a56d-dcef98ecf6db@linux.intel.com>
Date: Wed, 10 Jun 2026 11:18:21 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/4] iommufd/selftest: Add invalidation entry_num and
 entry_len boundary tests
To: Nicolin Chen <nicolinc@nvidia.com>, Will Deacon <will@kernel.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Shuah Khan <shuah@kernel.org>, Pranjal Shrivastava <praan@google.com>,
 Kees Cook <kees@kernel.org>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <cover.1780521606.git.nicolinc@nvidia.com>
 <9ae78ed8e64afbb2f2df27d03466380061adf7d9.1780521606.git.nicolinc@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <9ae78ed8e64afbb2f2df27d03466380061adf7d9.1780521606.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/4/26 05:26, Nicolin Chen wrote:
> Test that the cache invalidation ioctl rejects an oversized entry_len and
> an oversized entry_num, covering the CPU soft-lockup paths the caps close.
> 
> Assisted-by:Claude:claude-opus-4-8
> Signed-off-by: Nicolin Chen<nicolinc@nvidia.com>
> ---
>   tools/testing/selftests/iommu/iommufd.c | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
