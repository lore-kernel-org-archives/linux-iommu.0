Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3792908
	for <iommu@lists.linux.dev>; Sat, 28 Jan 2023 08:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674893079; x=1706429079;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PSAi4wQVJq8gb0ftJa1PBZZBA8rw8csOD0sJ4uctJ38=;
  b=lIKH3gJoSmWtavRytw/5hi3sUgfCiClDeFPgwxJQPKTS/UsXE4NA1xHa
   u2Xf1tNEc5eXbmuZSYDno0d1YeYa/PTtzAGJooefJ+t1ECE/pbzecinOM
   Jj3Dw1SOEwfk9UVms0Vc2nP+TwHFJzEb6XaWMOQ+ecaGYoT7MLpuOqII+
   430eHB+r4NK1fC+3lZxvQ/o5mmi9eUUwfK80OpqNFTIxJET3wfIEezHUa
   bjgCnaT37dJaZo1qmm+5vD91fjYJEAN3QnFhjEwQ05KepwgY1zPNlANbI
   tM48WmIScZ5g2zuDrR7uq+LffiqFOOU0kGoeXQMmXSgy0oI7c3YGDf8vl
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="327290274"
X-IronPort-AV: E=Sophos;i="5.97,253,1669104000"; 
   d="scan'208";a="327290274"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2023 00:04:38 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="732129387"
X-IronPort-AV: E=Sophos;i="5.97,253,1669104000"; 
   d="scan'208";a="732129387"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.252.186.212]) ([10.252.186.212])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2023 00:04:36 -0800
Message-ID: <0ff36f80-652a-655d-ba9c-222b5aa79f72@linux.intel.com>
Date: Sat, 28 Jan 2023 16:04:32 +0800
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
Subject: Re: [PATCH v2 2/8] iommu: Validate that devices match domains
Content-Language: en-US
To: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org, will@kernel.org
References: <cover.1674753627.git.robin.murphy@arm.com>
 <0f78ba36a7b31a0d534416e56ea0f1af0efc2659.1674753627.git.robin.murphy@arm.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <0f78ba36a7b31a0d534416e56ea0f1af0efc2659.1674753627.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/1/27 2:26, Robin Murphy wrote:
> Before we can allow drivers to coexist, we need to make sure that one
> driver's domain ops can't misinterpret another driver's dev_iommu_priv
> data. To that end, add a token to the domain so we can remember how it
> was allocated - for now this may as well be the device ops, since they
> still correlate 1:1 with drivers. We can trust ourselves for internal
> default domain attachment, so add the check where it covers both the
> external attach interfaces.
> 
> Signed-off-by: Robin Murphy<robin.murphy@arm.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
