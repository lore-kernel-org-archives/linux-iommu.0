Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF997EF09
	for <iommu@lists.linux.dev>; Thu,  5 Dec 2024 02:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733364915; cv=none; b=VmQ6sD5DZeSZVQX/bED1eXVRs4DRLU64J9Qv8Be5i36fRLZjuK/WYeuV9g4EVQsqg6+aRxVNpCaP+0wW6x4q9aCpYVEMoWBfYjeLxj/QFVr0h71Ifjdezd6mPryWi+QGlm/48CoaADADWBDpTGS/SXaZ8lIktf9yf9Xr4UfNYQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733364915; c=relaxed/simple;
	bh=+XMr2qI3RgCXJth7UCtE7+gEHUEIQIV1Ynqs7tzEIDU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pgnl7EAMofbmK25Z74mUtZykRixtq/7MlYfCcErnJDVEPyKm9KVnM0Zc1uvK960Fq7FNFQto1vS8IftUiYsaNy0EruVW/wLG1tm+STUTMCI4SmQY1N0ee/a2PmFzb0/mC/lELntxw+b5g51E8whqdCICOTcvaGvfV25Fq7MqwQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mHLuNAtk; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mHLuNAtk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733364914; x=1764900914;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+XMr2qI3RgCXJth7UCtE7+gEHUEIQIV1Ynqs7tzEIDU=;
  b=mHLuNAtkAtl5czBZgbv1LhFR9jPEnF5EslLBNmzToHe79b7vy2YVF04e
   rI3no7xjVmU7mEGoInT+hjlVaiifuZgrJcqeAOg0lwv9wn6ts8iTYrJaX
   DHy2LJzuoFM9bXHM4q4YWjdkwTna6k1+Uix2AQvQbLggJezgeWszvkBOl
   AWwT30sK44KEwEQGyrQas/7F0FJVNRLkrEAfOBWj/dv45gRv/lEuQ0yna
   Yemvc/h+Ob/KsSM4DXJM5rOCt5ZtzB/fMMxQUJ60eEGAiPrhogOon44kq
   J94ZNN6hOb5Sn6z72di0XojdnYXPKs9vODxdHATG6iNKBYG+NMiOhgjIk
   Q==;
X-CSE-ConnectionGUID: hqyqSxTxTJKZ2nboloBb1A==
X-CSE-MsgGUID: Vbts8EwhQRKCcz61qt8xsw==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="45034343"
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; 
   d="scan'208";a="45034343"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 18:15:14 -0800
X-CSE-ConnectionGUID: nK5JC30FRNyQHWXSITb5cQ==
X-CSE-MsgGUID: KA/LbP2ES463SJcn4Q+LKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; 
   d="scan'208";a="93844581"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 18:15:11 -0800
Message-ID: <88b3bd3d-f5e0-436d-a738-32141bae9d15@linux.intel.com>
Date: Thu, 5 Dec 2024 10:13:48 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/7] iommu: Prevent pasid attach if no
 ops->remove_dev_pasid
To: Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org, jgg@nvidia.com,
 kevin.tian@intel.com
Cc: eric.auger@redhat.com, nicolinc@nvidia.com, kvm@vger.kernel.org,
 chao.p.peng@linux.intel.com, iommu@lists.linux.dev,
 zhenzhong.duan@intel.com, vasant.hegde@amd.com, will@kernel.org
References: <20241204122928.11987-1-yi.l.liu@intel.com>
 <20241204122928.11987-2-yi.l.liu@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20241204122928.11987-2-yi.l.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/4/24 20:29, Yi Liu wrote:
> driver should implement both set_dev_pasid and remove_dev_pasid op, otherwise
> it is a problem how to detach pasid. In reality, it is impossible that an
> iommu driver implements set_dev_pasid() but no remove_dev_pasid() op. However,
> it is better to check it.
> 
> Move the group check to be the first as dev_iommu_ops() may fail when there
> is no valid group. Also take the chance to remove the dev_has_iommu() check
> as it is duplicated to the group check.
> 
> Reviewed-by: Jason Gunthorpe<jgg@nvidia.com>
> Signed-off-by: Yi Liu<yi.l.liu@intel.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
