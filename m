Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFAF1376
	for <iommu@lists.linux.dev>; Fri,  5 May 2023 02:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683255562; x=1714791562;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+6Ksxw8NnDuZ6E01rOeUZM6j9Ahu/Zzr4rk7clJ2PuI=;
  b=AdE4CWcrvIPjNl8xWsuASTyZFFNTEQM+s+Moit9kPo1gMjwGaGeCL6CG
   ne8DZWNJyz/V7/pfk+ph1l5bIjB8009rQbWX1QxlYnWBPcbvp3dX3lhst
   ys1stFybDUC2fLbu3xf9FMHrfpWlwQDEx1soVU4bO9/zGmXLjjrLO1rpN
   FXqbllxDBCOKNCWhkchnxTNHxxxH8GFk53kcX5obYJNOdW4/Q02rwVE1Y
   CZNmCbUnfREl5DMf7OAPXPoxups8O1XXGVYKRtOslL6AiqjyndQgRL+zA
   lhyVJPTXVLP/bwGROQG2Q95U4b2sf77oZ5TwSZcfdYHG/A1w2Gdy2ni/f
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="347935665"
X-IronPort-AV: E=Sophos;i="5.99,250,1677571200"; 
   d="scan'208";a="347935665"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2023 19:59:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="762232080"
X-IronPort-AV: E=Sophos;i="5.99,250,1677571200"; 
   d="scan'208";a="762232080"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmsmga008.fm.intel.com with ESMTP; 04 May 2023 19:59:00 -0700
Message-ID: <35ceffc2-e306-6215-e90a-43548f6feca6@linux.intel.com>
Date: Fri, 5 May 2023 10:58:38 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc: baolu.lu@linux.intel.com, LKML <linux-kernel@vger.kernel.org>,
 iommu@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
 dmaengine@vger.kernel.org, vkoul@kernel.org, Will Deacon <will@kernel.org>,
 David Woodhouse <dwmw2@infradead.org>, Raj Ashok <ashok.raj@intel.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
 "Yu, Fenghua" <fenghua.yu@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Tony Luck <tony.luck@intel.com>, "Zanussi, Tom" <tom.zanussi@intel.com>,
 narayan.ranganathan@intel.com
Subject: Re: [PATCH v5 6/7] iommu/vt-d: Implement set_dev_pasid domain op
Content-Language: en-US
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
References: <20230427174937.471668-1-jacob.jun.pan@linux.intel.com>
 <20230427174937.471668-7-jacob.jun.pan@linux.intel.com>
 <76c98e62-1cac-2ab6-7721-08ec2c1fceb8@linux.intel.com>
 <20230504160334.496085db@jacob-builder>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230504160334.496085db@jacob-builder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/5/23 7:03 AM, Jacob Pan wrote:
>>> +static int intel_iommu_attach_device_pasid(struct iommu_domain *domain,
>>> +					   struct device *dev,
>>> ioasid_t pasid) +{
>>> +	struct device_domain_info *info = dev_iommu_priv_get(dev);
>>> +	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
>>> +	struct intel_iommu *iommu = info->iommu;
>>> +	int ret;
>>> +
>>> +	if (!pasid_supported(iommu))
>>> +		return -ENODEV;
>>> +
>>> +	ret = prepare_domain_attach_device(domain, dev);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	/*
>>> +	 * Most likely the device context has already been set up,
>>> will only
>>> +	 * take a domain ID reference. Otherwise, device context will
>>> be set
>>> +	 * up here.
>> The "otherwise" case is only default domain deferred attaching case,
>> right?
> it might be the only case so far, but my intention is to be general. i.e.
> no ordering requirements. I believe it is more future proof in case
> device_attach_pasid called before device_attach.

Let's put aside deferred attach and talk about it later.

The device's context entry is configured when the default domain is
being attached to the device. And, the default domain attaching is in
the iommu probe_device path. It always happens before set_device_pasid
which is designed to be called by the device driver. So the real
situation is that when the device driver calls set_device_pasid, the
context entry should already have been configured.

Then let's pick up the deferred attach case. It is a workaround for
kdump (Documentation/admin-guide/kdump/kdump.rst). I don't think PASID
feature is functionally required by any kdump capture kernel as its
main purpose is to dump the memory of a panic kernel.

In summary, it seems to be reasonable for the vt-d driver to return
-EBUSY when a device's context was copied. The idxd driver should
continue to work without kernel DMA with PASID support.

	if (context_copied(iommu, bus, devfn))
		return -EBUSY;

Make things general is always good, but this doesn't mean that we need
to make the code complex to support cases that do not exist or are not
used. Thoughts?

Best regards,
baolu
