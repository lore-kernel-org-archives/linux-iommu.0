Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4384228E35
	for <iommu@lists.linux.dev>; Wed, 13 Dec 2023 13:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e9zdn/n/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702473978; x=1734009978;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+kY9QgK8FMlrrYySDrLuoBvhnlDhlG8yb7Ov4BOpYak=;
  b=e9zdn/n/+VW1yCWMZBBKwaV56kyVOnfItV3+ST3wPaYIVbtfPm5wtSwC
   h4O3YQX9Bel+7KbXmc9by0/hTytPiIcwPzPCqdiznhCDmB39mg30osEBh
   yDw8pXS2Hlbuc5IukcbIN2lhbufCaxBJ3z8MFGd5dCmnq9vM3oDKYlwdc
   klq6YXD7LnIw4TzcyhVsabH95oZQhQ6e+fNA7l5hzrcepaGnC+gwCkEj6
   BJZSGftruJTV/rymqhke6jxTGpd5AEVX7uufYoIOS9gttEcnql8tn4q1/
   b8G5k31PpryXiP5TQw7Evfrb5DK+nTc5q4FPC03/LeBGHd9icPV9CWEYD
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="1818077"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="1818077"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 05:26:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="773949973"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="773949973"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.212.246]) ([10.254.212.246])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 05:26:12 -0800
Message-ID: <9d30d670-d4ac-4af1-9177-88fde952ed3e@linux.intel.com>
Date: Wed, 13 Dec 2023 21:26:09 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, dan.carpenter@linaro.org,
 kernel-janitors@vger.kernel.org, error27@gmail.com
Subject: Re: [PATCH] iommu/sva: Fix memory leak in iommu_sva_bind_device()
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20231213111450.2487861-1-harshit.m.mogalapalli@oracle.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20231213111450.2487861-1-harshit.m.mogalapalli@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/12/13 19:14, Harshit Mogalapalli wrote:
> Free the handle when the domain allocation fails before unlocking and
> returning.
> 
> Fixes: 092edaddb660 ("iommu: Support mm PASID 1:n with sva domains")
> Signed-off-by: Harshit Mogalapalli<harshit.m.mogalapalli@oracle.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
