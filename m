Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519DC4084E
	for <iommu@lists.linux.dev>; Sat, 10 Aug 2024 08:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723276907; cv=none; b=HqrN5NkXlZf+U2G2tehX6os6vV3SGApErPjzDz5mh48vDgDjK1zjpvH5nRBXfV+vZ2D7jfgCrUw097uX6N0uUyX1uLXKhwKcfSkWJpJDg6/wrRC6MJVK1qyTc6+XGph97RqUXBNXjtbmRQtVUnwbsmFitHrTEtSgDaYh3/bNX4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723276907; c=relaxed/simple;
	bh=c+CJovE+gLPKtjvQnFrMWaI+AeS8CqQwtZI2+oA+4Y8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ROF69Pk/AOaLtbmY81pn6VES2jTXFa43jQ90xY9bFUZwv99Z0+BLanNczsnNa3ULI27jCPyz1FlFeqP5wVsrkdjQ6reyc2hYMTnM2P+jidtdggJFZ0ERVwsrOAJpES0TsnRpc/10CfuCVpJS4ermurMz80WHkcNZaSL0gx6Wz7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AJ7nNX09; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AJ7nNX09"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723276906; x=1754812906;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=c+CJovE+gLPKtjvQnFrMWaI+AeS8CqQwtZI2+oA+4Y8=;
  b=AJ7nNX09fnJ/rhKjff4XH0QoIwVqdCh3vFI25CH895doEQylTox74+nf
   GZB2pktcQ2EiLskp1VOdYTDygW7QW0QXrUsyzE8WsXjyuD6XCHSe3y37B
   gKAsssGeZ6CUjDcWzQIMiZeLf2JQQr3BazPsNUKsM8iSTH4ZWPbSsoddR
   cOvzctwZiDJ3HXFmVWjHa0om6MxH3kJ6KHZ9r8EAupBiUc6fYupEE5a7W
   2pysQWDCHJjGEUzjjij1gRMMYKckEEaedK8/Z5Fx9VcsmH06X3CXRv0Ey
   leGHe0qXwrprz8GZKb/5AP4RMvFRs7EWcW7USZcY3OgtqUvzH8jHNzoGV
   A==;
X-CSE-ConnectionGUID: EFqaGDjYSJytqMn81i3CTg==
X-CSE-MsgGUID: 2w0kkZmJTfSqN7rM83d+FA==
X-IronPort-AV: E=McAfee;i="6700,10204,11159"; a="21114571"
X-IronPort-AV: E=Sophos;i="6.09,278,1716274800"; 
   d="scan'208";a="21114571"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2024 01:01:46 -0700
X-CSE-ConnectionGUID: sqJs9jS+S2mIhpseeprKPg==
X-CSE-MsgGUID: H3zelhV9Tnu4pfhyaKV2oA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,278,1716274800"; 
   d="scan'208";a="58016196"
Received: from lizhiqua-mobl.ccr.corp.intel.com (HELO [10.124.240.228]) ([10.124.240.228])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2024 01:01:43 -0700
Message-ID: <8f5ee898-162a-49f6-9044-7e3ef6dafe1e@linux.intel.com>
Date: Sat, 10 Aug 2024 16:01:40 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v4 6/7] iommu/vt-d: Add support for static identity domain
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>
References: <20240809055431.36513-1-baolu.lu@linux.intel.com>
 <20240809055431.36513-7-baolu.lu@linux.intel.com>
 <BN9PR11MB5276BCEC41AA08D80CE985F18CBA2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276BCEC41AA08D80CE985F18CBA2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/8/9 16:29, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Friday, August 9, 2024 1:55 PM
>>
>> +static int context_setup_pass_through(struct device *dev, u8 bus, u8 devfn)
>> +{
>> +	struct device_domain_info *info = dev_iommu_priv_get(dev);
>> +	struct intel_iommu *iommu = info->iommu;
>> +	struct context_entry *context;
>> +
>> +	spin_lock(&iommu->lock);
>> +	context = iommu_context_addr(iommu, bus, devfn, 1);
>> +	if (!context) {
>> +		spin_unlock(&iommu->lock);
>> +		return -ENOMEM;
>> +	}
>> +
>> +	if (context_present(context) && !context_copied(iommu, bus, devfn))
>> {
>> +		spin_unlock(&iommu->lock);
>> +		return 0;
>> +	}
> 
> Is it a valid case to setup passthrough on a present entry?

It's valid but unnecessary.

Since the context is present, it indicates that the configuration has
already been setup by a PCI aliased device. The iommu group mandates
that all PCI aliased devices must be attached to the same iommu domain.
Consequently, there's no need for additional configuration.

While it's feasible to remove this line of code due to the check in the
pci_for_each_dma_alias() callback:

static int context_setup_pass_through_cb(struct pci_dev *pdev, u16 
alias, void *data)
{
         struct device *dev = data;

         if (dev != &pdev->dev)
                 return 0;

         return context_setup_pass_through(dev, PCI_BUS_NUM(alias), 
alias & 0xff);
}

But it's in the original code, I've retained it to prevent any potential
regression.

Thanks,
baolu
