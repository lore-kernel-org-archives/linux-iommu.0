Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC4E4C6D
	for <iommu@lists.linux.dev>; Mon, 15 Apr 2024 05:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713159200; cv=none; b=uSc9PaM9BjYYzgI4PGy5H1iyuPO+78vgceeGTJGOhNW07ByUMHFQ793U6iU7+S/k2e+/ez5ZTPaYVDhNPoq/Zk97pdS4glL9ZRCCb3p5Dt0k6iZtjvEeCnhEj04FIWB9biSjAVQ5wfzC76US/MDvWWd5i8wWBtRt/5q8KHOHf+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713159200; c=relaxed/simple;
	bh=ZK25Kudw4g+EfZ0RevMldsCZXhFVhE3vYF/7miWSlBU=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Hw2HhZcJGKzdclP7l1pms+Lvyrfbqbue3qDrj149X9IFyiDotT1LZp5XQseRtQkUj/nBKzKII45DkMV3D8HdGjumAOfPdycwDhx3CXOcfPS+t0TmHgeoTkNdI54yZVhIt4lTz52Mro9AU0ZS4ybQBd1SZ7hjY7mMudFlelZitto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hxYozdaR; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hxYozdaR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713159200; x=1744695200;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZK25Kudw4g+EfZ0RevMldsCZXhFVhE3vYF/7miWSlBU=;
  b=hxYozdaRf97q03lKsHoz6C+4ZTB0CG/hqoUZGprZVzUSCxjc1t8HRtud
   DLGr7dMUGen0Frj1Ar32iufGao0R2mnyuc04G9kcMTaiv1/bSsOj3f+AB
   vJu93nsO786BlTtFxuxMxSwoWmhbqNmng7g3GTAwyXbrV35pjx2X5lKcz
   uF8Dt9+fz56n5EZCypVzP57Yjr3dyueWoCPr0YNjdHRMUf0WPLsUvqGNr
   ceNxrIbK8CKDlrKBQw8me6JjYnv8sfejV3Rdgi4oEJh1mp2ajdV2lsECx
   j0GU43b2noD1yRZYrkUzujDyWn23yD86xNNESS/fT1yxK4Lr8IaoNP+ef
   g==;
X-CSE-ConnectionGUID: RR8E/TwuSEeTbQeujp8yWQ==
X-CSE-MsgGUID: Rrs6PmqcRH+aNv6lUqdxdw==
X-IronPort-AV: E=McAfee;i="6600,9927,11044"; a="19129740"
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="19129740"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2024 22:33:19 -0700
X-CSE-ConnectionGUID: mb9YmG9WS1OG/i2nU/YyaA==
X-CSE-MsgGUID: LP55kDyXSzWe2GxEgwQAaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="26602248"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa005.jf.intel.com with ESMTP; 14 Apr 2024 22:33:15 -0700
Message-ID: <3cfb2bb1-3d66-450d-b561-f8f0939645ba@linux.intel.com>
Date: Mon, 15 Apr 2024 13:32:03 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, alex.williamson@redhat.com,
 robin.murphy@arm.com, eric.auger@redhat.com, nicolinc@nvidia.com,
 kvm@vger.kernel.org, chao.p.peng@linux.intel.com, iommu@lists.linux.dev,
 zhenzhong.duan@intel.com, jacob.jun.pan@intel.com
Subject: Re: [PATCH v2 01/12] iommu: Pass old domain to set_dev_pasid op
To: Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org, jgg@nvidia.com,
 kevin.tian@intel.com
References: <20240412081516.31168-1-yi.l.liu@intel.com>
 <20240412081516.31168-2-yi.l.liu@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240412081516.31168-2-yi.l.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/12/24 4:15 PM, Yi Liu wrote:
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 40dd439307e8..1e5e9249c93f 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -631,7 +631,7 @@ struct iommu_ops {
>   struct iommu_domain_ops {
>   	int (*attach_dev)(struct iommu_domain *domain, struct device *dev);
>   	int (*set_dev_pasid)(struct iommu_domain *domain, struct device *dev,
> -			     ioasid_t pasid);
> +			     ioasid_t pasid, struct iommu_domain *old);

Is it possible to add another op to replace a domain for pasid? For
example,

	int (*replace_dev_pasid)(domain, dev, pasid, old_domain)

Best regards,
baolu
