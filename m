Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13ED7208AD
	for <iommu@lists.linux.dev>; Tue,  5 Nov 2024 01:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730771452; cv=none; b=B5CrtlT1043R8IKc+dGc8RKJ7TvTZbv3MxrF26xwvtBnoCyKU5oZJ0MmQS7l9CmS7JQJh1erC/MLzbamVlyDk58BnQIDBnzx8rf3RXbV8k0/zFQmH+ciWFN1PiMpjARt0eKVQU5wNiS5kmp+l3CREMDFH8zuSfdo/pCOe2wXkB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730771452; c=relaxed/simple;
	bh=hw2c58opUVBWYjcA+XcykErIcKdhASNWY64LM/N6UzU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sKVotNxeeF+WYcoUl0dR+RE+ext62wamJpJce5x6C2hsggXApFg+G0lfZN2SW8gYIU15Fa0Ev4ySUPS+nYE2nNfS1hcg3mL/BwMSdycmFu6RfoQnGfi1qkX8rMxXnscW4pWr7KZh8sLCoNiWzJIRz9tq/LncUWQdzdQPIIYiXto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MkkznpTB; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MkkznpTB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730771451; x=1762307451;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hw2c58opUVBWYjcA+XcykErIcKdhASNWY64LM/N6UzU=;
  b=MkkznpTBt6F/6QOkLVu87rG8E4R1YYkRuati8+AzxCFreoAmxaG8gqiG
   Zw8ZEYXFKpn8And8o6F2oRjMk71O/bs+j6XrkE3N+jq2dJMPon7jbiXPz
   MABG4294HxjfqnDxyBoAfRf3jlQ1BGyjQCHFOyTuX4XNr4LzLTnTX0o0D
   /L9E95aXc4aWb496I1fhU6SxP/eN0/18AGw/nGaYmRNzrZnn0eVzlx1EF
   Iruq6YhC2o8pibwQQygx3nHa8cmLQsmdEP7pJQiiaX8h1rHBQVBSnwegF
   qU47TitiYk5X3+RnkCckLq26Y+4+VogRH40gAjQpZVvylTXRYMplQJFYm
   Q==;
X-CSE-ConnectionGUID: pRG3EP8RQNCNtjRaDXNClw==
X-CSE-MsgGUID: S2PwumqgTk6OcuC2QsAWvg==
X-IronPort-AV: E=McAfee;i="6700,10204,11246"; a="33335330"
X-IronPort-AV: E=Sophos;i="6.11,258,1725346800"; 
   d="scan'208";a="33335330"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 17:50:50 -0800
X-CSE-ConnectionGUID: A4n3xeyLSpuICABfTnPBQQ==
X-CSE-MsgGUID: C5pKxbgSSNqle3WSkIuGTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,258,1725346800"; 
   d="scan'208";a="84256850"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 17:50:47 -0800
Message-ID: <1378398b-4403-4e78-a5e5-3d35f911d6a3@linux.intel.com>
Date: Tue, 5 Nov 2024 09:50:01 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/13] iommu/vt-d: Add a helper to flush cache for
 updating present pasid entry
To: Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org, jgg@nvidia.com,
 kevin.tian@intel.com
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, nicolinc@nvidia.com,
 kvm@vger.kernel.org, chao.p.peng@linux.intel.com, iommu@lists.linux.dev,
 zhenzhong.duan@intel.com, vasant.hegde@amd.com, will@kernel.org
References: <20241104131842.13303-1-yi.l.liu@intel.com>
 <20241104131842.13303-3-yi.l.liu@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20241104131842.13303-3-yi.l.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/4/24 21:18, Yi Liu wrote:
> There are more paths that need to flush cache for present pasid entry
> after adding pasid replacement. Hence, add a helper for it. Per the
> VT-d spec, the changes to the fields other than SSADE and P bit can
> share the same code. So intel_pasid_setup_page_snoop_control() is the
> first user of this helper.
> 
> No functional change is intended.
> 
> Signed-off-by: Yi Liu<yi.l.liu@intel.com>
> ---
>   drivers/iommu/intel/pasid.c | 54 ++++++++++++++++++++++++-------------
>   1 file changed, 36 insertions(+), 18 deletions(-)

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
