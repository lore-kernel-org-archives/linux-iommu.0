Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE80384
	for <iommu@lists.linux.dev>; Wed, 13 Sep 2023 02:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694572102; x=1726108102;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ADJXPAGxhH/KIzMbrba+LZ+A/B+nI3RN78Cnn9H+UvU=;
  b=IqWeQETuRGQngaj4iSVuIGyMc3ng49owTwjpuilikPx9zbyX+qw1HzzH
   ipQJfO+QEQxgguOQBvScMw5OEYfaAcey+9l0kv7D6taQ7zeGex2tPC2ew
   ObIC2lwCBCDgk7KQeYl6xeiGoEUaG0r9O3S3enXp7526OMUcaxBxQHO8V
   sIoJIXevo+XPwlgm5hLcVNgT+CenspMnlDQVvOfpeeQPAgyKh0vXphMRA
   dcVG/nsjm77/N6J9N5UHljW3jbcSv6+uLNW9ifnklPnHkUbA33Rk9zKBW
   47wEIxfnGdlogGiinZM2H/TpQTjWIETJ1aSjvVqNIic9/n/pEWsDPHzFR
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="377454861"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="377454861"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 19:28:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="693689531"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="693689531"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orsmga003.jf.intel.com with ESMTP; 12 Sep 2023 19:28:17 -0700
Message-ID: <0f4fb712-28e3-8620-6a65-59c9b9d77740@linux.intel.com>
Date: Wed, 13 Sep 2023 10:25:16 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc: baolu.lu@linux.intel.com, Michael Shavit <mshavit@google.com>,
 Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/6] iommu/vt-d: Remove mm->pasid in
 intel_sva_bind_mm()
Content-Language: en-US
To: Tina Zhang <tina.zhang@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Kevin Tian <kevin.tian@intel.com>
References: <20230912125936.722348-1-tina.zhang@intel.com>
 <20230912125936.722348-3-tina.zhang@intel.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230912125936.722348-3-tina.zhang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/12/23 8:59 PM, Tina Zhang wrote:
> The pasid is passed in as a parameter through .set_dev_pasid() callback.
> Thus, intel_sva_bind_mm() can directly use it instead of retrieving the
> pasid value from mm->pasid.
> 
> Suggested-by: Lu Baolu<baolu.lu@linux.intel.com>
> Signed-off-by: Tina Zhang<tina.zhang@intel.com>
> ---
>   drivers/iommu/intel/svm.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)

The intel_svm_bind_mm() could be further merged into
intel_svm_set_dev_pasid(). It's fine if you keep it as is since we need
more cleanup and refactoring work after this series get merged.

So,

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
