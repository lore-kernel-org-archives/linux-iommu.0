Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2458BA4C
	for <iommu@lists.linux.dev>; Wed, 31 May 2023 03:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685503088; x=1717039088;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Z5KPRQqcSl7oA4NUBRtHPzSrsVgDatuhRE5sn4VWXVY=;
  b=dRiIoLAyoyf7ZAVP2d7vaK+gYwYm3UakCxZZSb4XWlcBX+g+wZtj9fhu
   Nwd6wE1LR4c8rm1B7lMEeHqsUTuw2loYVAHRaH2Cjr2fvwwipnVzikHLD
   mGHzFxqbn4Q7axp+2c9le+3IbNVMII0PCXl8e1vxciOkqdGy0uaeVAsk5
   PjLTwIjsTlDtjGf56D5nHOi/EpCi7nQCN0ilcsIdqq00u+PPdIIwiWSGr
   bCvB4CK0V6deJ7RSX3vQ9c3ev3+3oTyv7ZfEcgGANcGYnacshNS/zcHuf
   5yYMp0OZPYt7TQa5gg04P2iplX3oDG5eOtaxuBbT8tQgEahXprFv68x9Q
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="334740879"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="334740879"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 20:18:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="706702506"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="706702506"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orsmga002.jf.intel.com with ESMTP; 30 May 2023 20:18:02 -0700
Message-ID: <e3034e4d-eabf-b8cc-b0be-916d1355edce@linux.intel.com>
Date: Wed, 31 May 2023 11:17:08 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Cc: baolu.lu@linux.intel.com, Kevin Tian <kevin.tian@intel.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>, iommu@lists.linux.dev,
 linux-kselftest@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCHES 00/17] IOMMUFD: Deliver IO page faults to user space
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20230530053724.232765-1-baolu.lu@linux.intel.com>
 <ZHaV3GwYXCvfNUBn@ziepe.ca>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <ZHaV3GwYXCvfNUBn@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/31/23 8:33 AM, Jason Gunthorpe wrote:
> On Tue, May 30, 2023 at 01:37:07PM +0800, Lu Baolu wrote:
>> Hi folks,
>>
>> This series implements the functionality of delivering IO page faults to
>> user space through the IOMMUFD framework. The use case is nested
>> translation, where modern IOMMU hardware supports two-stage translation
>> tables. The second-stage translation table is managed by the host VMM
>> while the first-stage translation table is owned by the user space.
>> Hence, any IO page fault that occurs on the first-stage page table
>> should be delivered to the user space and handled there. The user space
>> should respond the page fault handling result to the device top-down
>> through the IOMMUFD response uAPI.
>>
>> User space indicates its capablity of handling IO page faults by setting
>> a user HWPT allocation flag IOMMU_HWPT_ALLOC_FLAGS_IOPF_CAPABLE. IOMMUFD
>> will then setup its infrastructure for page fault delivery. Together
>> with the iopf-capable flag, user space should also provide an eventfd
>> where it will listen on any down-top page fault messages.
>>
>> On a successful return of the allocation of iopf-capable HWPT, a fault
>> fd will be returned. User space can open and read fault messages from it
>> once the eventfd is signaled.
> 
> This is a performance path so we really need to think about this more,
> polling on an eventfd and then reading a different fd is not a good
> design.
> 
> What I would like is to have a design from the start that fits into
> io_uring, so we can have pre-posted 'recvs' in io_uring that just get
> completed at high speed when PRIs come in.
> 
> This suggests that the PRI should be delivered via read() on a single
> FD and pollability on the single FD without any eventfd.

Good suggestion. I will head in this direction.

>> Besides the overall design, I'd like to hear comments about below
>> designs:
>>
>> - The IOMMUFD fault message format. It is very similar to that in
>>    uapi/linux/iommu which has been discussed before and partially used by
>>    the IOMMU SVA implementation. I'd like to get more comments on the
>>    format when it comes to IOMMUFD.
> 
> We have to have the same discussion as always, does a generic fault
> message format make any sense here?
> 
> PRI seems more likely that it would but it needs a big carefull cross
> vendor check out.

Yeah, good point.

As far as I can see, there are at least three types of IOPF hardware
implementation.

- PCI/PRI: Vendors might have their own additions. For example, VT-d 3.0
   allows root-complex integrated endpoints to carry device specific
   private data in their page requests. This has been removed from the
   spec since v4.0.

- DMA stalls.

- Device-specific (non-PRI, not through IOMMU).

Does IOMMUFD want to support the last case?

Best regards,
baolu
