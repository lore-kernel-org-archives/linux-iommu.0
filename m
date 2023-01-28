Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D7E3214
	for <iommu@lists.linux.dev>; Sat, 28 Jan 2023 08:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674893586; x=1706429586;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=uax4L7qvxMAgmGQzQYdiiNaZPSv/p+L14aW9R/QRqz4=;
  b=lfyPtvi9d9Lpw2/LNxnPWCA6ONkmwzsh7BpQcmbvaNEN6RrkEi+OVDZQ
   RQ0W89y+iDPQUR0TSrBFuMC3lbeMXYOkqSQSMI8Prhq8sgyRVrFkZ7Rgo
   CAo5UuQpV9e0uJHatvYFbfL9WSnbT+2i1i7Mk64t4j4C7JhgWTBsB6XPf
   Nz6TugYOdgwB+9ELVKZh785XlIwAPcl143YRwEDa25v5V41lQIjLuX2mN
   fUCslc2PqCnmfhWugfnydu/S7ZpctL+Zl4kO8VbUWKN+htm4ecbslr0Uw
   Z9IpRAmPu3oQIxHrxMu5IAiBySnkS/VnrE7a4yVa2sLT3Yss1emjRvamD
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="413495522"
X-IronPort-AV: E=Sophos;i="5.97,253,1669104000"; 
   d="scan'208";a="413495522"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2023 00:13:05 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="992338744"
X-IronPort-AV: E=Sophos;i="5.97,253,1669104000"; 
   d="scan'208";a="992338744"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.252.186.212]) ([10.252.186.212])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2023 00:12:55 -0800
Message-ID: <e5e68be8-7f64-c19c-ab0d-13e6f2fcbf33@linux.intel.com>
Date: Sat, 28 Jan 2023 16:12:45 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, hch@lst.de, jgg@nvidia.com
Subject: Re: [PATCH v2 4/8] iommu: Factor out some helpers
Content-Language: en-US
To: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org, will@kernel.org
References: <cover.1674753627.git.robin.murphy@arm.com>
 <959a1e8d598c0a82f94123e017cafb273784f848.1674753627.git.robin.murphy@arm.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <959a1e8d598c0a82f94123e017cafb273784f848.1674753627.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/1/27 2:26, Robin Murphy wrote:
> The pattern for picking the first device out of the group list is
> repeated a few times now, so it's clearly worth factoring out to hide
> the group_device detail from places that don't need to know. Similarly,
> the safety check for dev_iommu_ops() at public interfaces starts looking
> a bit repetitive, and might not be completely obvious at first glance,
> so let's factor that out for clarity as well, in preparation for more
> uses of both.
> 
> Signed-off-by: Robin Murphy<robin.murphy@arm.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
