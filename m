Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3045CA3B
	for <iommu@lists.linux.dev>; Tue, 23 Aug 2022 07:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661239991; x=1692775991;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nlUMuSoXu7uI2fet/FjE+vAKf53pL4Yjk/EYF4av+Jo=;
  b=F9DqKPhgOdpgeUNCY+MAbQbTPqxl/VE5dE70xFZEQMQ3Ec1yC/iRnS0b
   cLCed+yEAtBOz5O0bDe+SmI+1D3H2iXoRqvyenMWhV7x4FrFXUVSQAGgl
   RSk9oHAsBbf+YPuFVckLVgCTC6r3ZzUCwxquSPrrTfCeYbEFDJg5peYtu
   0dLxr0lMT0XvyhVOTw0lYa5iKkxKdOP+9to7FBG4LWnFjdOEy0zmHSzBu
   ez09RGNl/SU7uNp8V9AHFxYzdqKsRZwfW0D5UuiGFYQSf3GaUtj9HDGdj
   Uk2gHVUFpQruOWkQ64/syP6RbTeTh3qBUNz0K4ffN9laKWN+R8vy2BMpo
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="379905958"
X-IronPort-AV: E=Sophos;i="5.93,256,1654585200"; 
   d="scan'208";a="379905958"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 00:33:10 -0700
X-IronPort-AV: E=Sophos;i="5.93,256,1654585200"; 
   d="scan'208";a="642345669"
Received: from xujinlon-mobl.ccr.corp.intel.com (HELO [10.254.211.102]) ([10.254.211.102])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 00:33:05 -0700
Message-ID: <4e958e77-be17-4428-2fc3-48c1e66914fa@linux.intel.com>
Date: Tue, 23 Aug 2022 15:33:04 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Cc: baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
 Christoph Hellwig <hch@infradead.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
 Eric Auger <eric.auger@redhat.com>, Liu Yi L <yi.l.liu@intel.com>,
 Jacob jun Pan <jacob.jun.pan@intel.com>,
 Zhangfei Gao <zhangfei.gao@linaro.org>, Zhu Tony <tony.zhu@intel.com>,
 iommu@lists.linux.dev, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 07/13] iommu/vt-d: Add SVA domain support
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
References: <20220817012024.3251276-1-baolu.lu@linux.intel.com>
 <20220817012024.3251276-8-baolu.lu@linux.intel.com>
 <Yv5AQkcbhtaKFs1I@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <Yv5AQkcbhtaKFs1I@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2022/8/18 21:36, Jason Gunthorpe wrote:
> On Wed, Aug 17, 2022 at 09:20:18AM +0800, Lu Baolu wrote:
> 
>> +static int intel_svm_set_dev_pasid(struct iommu_domain *domain,
>> +				   struct device *dev, ioasid_t pasid)
>> +{
>> +	struct device_domain_info *info = dev_iommu_priv_get(dev);
>> +	struct intel_iommu *iommu = info->iommu;
>> +	struct iommu_sva *sva;
>> +	int ret = 0;
>> +
>> +	mutex_lock(&pasid_mutex);
>> +	/*
>> +	 * Detach the domain if a blocking domain is set. Check the
>> +	 * right domain type once the IOMMU driver supports a real
>> +	 * blocking domain.
>> +	 */
>> +	if (!domain || domain->type == IOMMU_DOMAIN_UNMANAGED) {
>> +		intel_svm_unbind_mm(dev, pasid);
> 
> See, I think this is exactly the wrong way to use the ops
> 
> The blockin domain ops should have its own function that just
> unconditionally calls intel_svm_unbind_mm()
> 
>> +	} else {
>> +		struct mm_struct *mm = domain->mm;
>> +
>> +		sva = intel_svm_bind_mm(iommu, dev, mm);
>> +		if (IS_ERR(sva))
>> +			ret = PTR_ERR(sva);
> 
> And similarly the SVA domain should have its own op that does this SVM
> call.
> 
> Muxing the ops with tests on the domain is an anti-pattern. In fact I
> would say any time you see an op testing the domain->type it is very
> suspicious.

Both agreed. Will fix them in the next version.

Best regards,
baolu

