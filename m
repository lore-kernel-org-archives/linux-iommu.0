Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425BF19B
	for <iommu@lists.linux.dev>; Sun, 24 Jul 2022 08:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658651969; x=1690187969;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ziLiSEQbzWjCi7B0eTZt1SCYgRe+J/hqHUnOduqyHUc=;
  b=eLVNLvOKN1cwhjLbT1CeC5W7cZ7adsstdprpEONEnO2x7FOzjvECgjTr
   RRFpQWE3H90boniAesXROQrVPGPW2HxueOZ8sXHnppcICJW/ZfLXoD9HU
   w6QFChfLsUhfbZuWd7WFMJSddv/WVEmT9lm9T25394J0q5kmKK3/LNq14
   1e5YCCJuH7YZa4luQklqJ3vl+9RPIjDn3PwOzEeHPKYRDw2d+roDNBT4p
   NlDdWOAOQvIDXd1gkSMN6hxhiM/6/PcDYdIf9dQ7K9fZKr3HB4EEAg+8E
   sE5JXh6Bg7dkbwXazNwKbQlmSkQHXV2x6lcldOaYA7wIRh3fNvzLkZt1H
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10417"; a="285075435"
X-IronPort-AV: E=Sophos;i="5.93,190,1654585200"; 
   d="scan'208";a="285075435"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2022 01:39:28 -0700
X-IronPort-AV: E=Sophos;i="5.93,190,1654585200"; 
   d="scan'208";a="657758458"
Received: from zjiang1-mobl.ccr.corp.intel.com (HELO [10.249.170.155]) ([10.249.170.155])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2022 01:39:23 -0700
Message-ID: <b31ce6fd-4202-e7bb-61de-3120c1e06825@linux.intel.com>
Date: Sun, 24 Jul 2022 16:39:21 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Cc: baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
 Christoph Hellwig <hch@infradead.org>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
 Eric Auger <eric.auger@redhat.com>, Liu Yi L <yi.l.liu@intel.com>,
 Jacob jun Pan <jacob.jun.pan@intel.com>,
 Zhangfei Gao <zhangfei.gao@linaro.org>, Zhu Tony <tony.zhu@intel.com>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v10 04/12] iommu: Add attach/detach_dev_pasid iommu
 interface
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
References: <20220705050710.2887204-1-baolu.lu@linux.intel.com>
 <20220705050710.2887204-5-baolu.lu@linux.intel.com>
 <20220723141118.GD79279@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220723141118.GD79279@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2022/7/23 22:11, Jason Gunthorpe wrote:
>> +	xa_erase(&group->pasid_array, pasid);
> It is worth checking that the value returned from xa_erase is domain
> and WARN_ON if not, since we are passing domain in..

Yes, will do like this:

WARN_ON(xa_erase(&group->pasid_array, pasid) != domain);

Best regards,
baolu
