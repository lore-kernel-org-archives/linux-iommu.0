Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5918EDF5C
	for <iommu@lists.linux.dev>; Tue,  5 Nov 2024 03:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730775729; cv=none; b=Dv0lZuCxgbYvKqZAzWCLEQ7hkb78PQopowf3yehnyyGussr6h/fYgOCW0aWNNW0Ac5C7fGqK2wzJbUq/oYAyPGvComVoQ68Zz4ejSFpYr8IDh3at7auuKlLX5eYo0iE5jUkFDU9HTwtlZXexiiqAUYmZZd4FwcLsr4/noJJNX3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730775729; c=relaxed/simple;
	bh=xOyHRk6dZ370hSDPEJqFXnvrXVt9qVejZl6TH92mHgQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bV6MIcNA/tKlSrBjxqbE+Yt0FkXwBE2Ka6UUzRZxDqT/SQe80NfvBYviUFXd9hbG/JN/KsNBLfrPxXElrBs4lnW/uUwkhvaHy0ofYfrLvrpK3fdQ/8lGfbkzNYn4BZqT4Bf2Vjn5ej6MFVRypshpcZDe9EzgDVO/SJLp+JbQVII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UdTaG4G1; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UdTaG4G1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730775728; x=1762311728;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xOyHRk6dZ370hSDPEJqFXnvrXVt9qVejZl6TH92mHgQ=;
  b=UdTaG4G1mkWonQInF05l6546sZSRDeYm5XP+os+Err5S9cd+N0ctPIPL
   V1OrvjdFSFWK30qJe8MN9/QznpKMPISqLnBufklX2nq4Jxh3fHupOCS/a
   ZwxZ2GncM0N1z3OCoi8aJH1xv3Fx6JIbX7NkH/YSXaRd+Cr8H45O2S+tE
   O27SRbN2GqwGBVnYxGu2kZgTJXEH3y3SbSQCt8+OvP5l7YXeFsZWk7e7x
   kKU/pp9bKYRKu/B7qI/z9GK6Y1a3wmblxXPlB7jVcC8YvZMqFQIFhsYjI
   BUgfKiF7tKYiV4rfaCH4ZPKO3qhby7zB7Q74TMbvjSxWbhJ8BDtjrbRRN
   Q==;
X-CSE-ConnectionGUID: joyktDMnQ66HGsgnk1xXHA==
X-CSE-MsgGUID: tWyO4WW6SC+fN8prQPlAfw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="41608563"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="41608563"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 19:02:07 -0800
X-CSE-ConnectionGUID: yE2RGwAFRe6jSTePUNMYZg==
X-CSE-MsgGUID: gTkP07R1QtCyUgp6Rr62Vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,258,1725346800"; 
   d="scan'208";a="83739207"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 19:00:10 -0800
Message-ID: <f82a51fa-ae70-435c-a633-a5423819335d@linux.intel.com>
Date: Tue, 5 Nov 2024 10:59:23 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/13] iommu/vt-d: Make intel_iommu_set_dev_pasid() to
 handle domain replacement
To: Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org, jgg@nvidia.com,
 kevin.tian@intel.com
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, nicolinc@nvidia.com,
 kvm@vger.kernel.org, chao.p.peng@linux.intel.com, iommu@lists.linux.dev,
 zhenzhong.duan@intel.com, vasant.hegde@amd.com, will@kernel.org
References: <20241104131842.13303-1-yi.l.liu@intel.com>
 <20241104131842.13303-7-yi.l.liu@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20241104131842.13303-7-yi.l.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/4/24 21:18, Yi Liu wrote:
> Let intel_iommu_set_dev_pasid() call the pasid replace helpers hence be
> able to do domain replacement.
> 
> Signed-off-by: Yi Liu<yi.l.liu@intel.com>
> ---
>   drivers/iommu/intel/iommu.c | 17 +++++++++++------
>   drivers/iommu/intel/pasid.h | 11 +++++++++++
>   2 files changed, 22 insertions(+), 6 deletions(-)

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
