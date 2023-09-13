Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38961A20
	for <iommu@lists.linux.dev>; Wed, 13 Sep 2023 04:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694578926; x=1726114926;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lDUFd1i9jggMQ9Rw/BId4bbvDd8bdBeI/vdRkY9c8LY=;
  b=IZtmWH5XWAupBLkW2DuF9KPYO18u1D33RSmcbb3KMrLwu0yD8KqS5mb/
   Pt6yXLUZqc98bv6FB9ikIYT1HZ+FdA+o0jSJTEToqIBE/odlw9HjHS8OC
   LztpwBc5ncW5I9MNtgCXRQB8C/jRVezJIokERTGvPQiKTOalTTlcwcjkg
   ZhSAJZmLY12LCCVzaKH6q2iv1VQ9YyjbEN9PxyNrlJKWzY6BKx5i8WmdK
   IPZnWJjXGDH3hcNnA/iBtzHW6iq9HncAVEij46yy/gZa2ZoTypMnuqEAi
   QbBZCLSkJdY9xqHyHb3W+EhVU/KyCo4pMRtf8xvBP1ihXGy5e3ms83vGS
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="382367994"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="382367994"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 21:22:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="747161091"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="747161091"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmsmga007.fm.intel.com with ESMTP; 12 Sep 2023 21:22:03 -0700
Message-ID: <121076ed-479f-53a8-33ea-0bbdbf8a9765@linux.intel.com>
Date: Wed, 13 Sep 2023 12:19:05 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev, joro@8bytes.org,
 suravee.suthikulpanit@amd.com, wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v2 10/11] iommu/amd: Add IO page fault notifier handler
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
References: <20230911121046.1025732-1-vasant.hegde@amd.com>
 <20230911121046.1025732-11-vasant.hegde@amd.com> <ZQCyHS9VFXZyAK4P@ziepe.ca>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <ZQCyHS9VFXZyAK4P@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/13/23 2:46 AM, Jason Gunthorpe wrote:
>> +static void iommu_call_iopf_notifier(struct amd_iommu *iommu, u64 *raw)
>> +{
>> +	struct iopf_fault event;
>> +	struct pci_dev *pdev;
>> +	int ret = -EINVAL;
>> +	u16 devid = PPR_DEVID(raw[0]);
>> +
>> +	if (PPR_REQ_TYPE(raw[0]) != PPR_REQ_FAULT) {
>> +		pr_err_ratelimited("Unknown PPR request received\n");
>> +		return;
>> +	}
>> +
>> +	if (!ppr_is_valid(iommu, raw))
>> +		goto out;
>> +
>> +	pdev = pci_get_domain_bus_and_slot(iommu->pci_seg->id, PCI_BUS_NUM(devid),
>> +					   devid & 0xff);
>> +	if (!pdev)
>> +		goto out;
> Lu, here is another case where the core PRI code could make use of a
> core helper for a getting from the RID to the iommu world.
> 

Yeah! It's common for PCI/PRI. ARM SMMUv3 probably will also implement
PCI/PRI in the future.

AMD IOMMU driver also calls pci_get_domain_bus_and_slot() in the path of 
handling a DMA fault (unrecoverable fault). I don't think this is a
performance critical path, so we only need the common code to to serve
the PRI case. What's your opinion?

Best regards,
baolu
