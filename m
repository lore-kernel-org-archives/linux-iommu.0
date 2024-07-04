Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F8018637
	for <iommu@lists.linux.dev>; Thu,  4 Jul 2024 03:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720062157; cv=none; b=Kj2XgvRjI1RgE8dBPt8eytu8Dx1M37XAqv0CIFeViKaxrgblRQrbiDmHieEkBSgH9TuDabReCZA0RgJsZW+Har3SHzZqan7aKWzG2jBOwWCapWsAp2O4CcNg5mZBJMl195NRzoqPYzuwjqvsyCz6nVge6UZGSW7m1WHZP09zwGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720062157; c=relaxed/simple;
	bh=+kcZ1X9JjlxsvYhu42cGMpuRp/ZGcCJLflR2cd6Au/8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bQLQ4YlZrrZAfJH3TSWA2ugaOE6zGbLLWr+PYb+jkgGpTukfzoilrYQTsVJvNlajTMMXRw31OY2j4l4QnpKYoRQZTiJBC9q71dHntHQGG48jCEIVFtDxCD0OIl2OaY0IbFzY+ZZDEtzq6WhCWN8tK+LxnHLiS0u8g2arVfltq/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bl3zAErQ; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bl3zAErQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720062156; x=1751598156;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+kcZ1X9JjlxsvYhu42cGMpuRp/ZGcCJLflR2cd6Au/8=;
  b=Bl3zAErQl42izIzPM3FTI9zo1U14ah4dGqsmO8REmj9WeyBXHs7MoiFZ
   lx3vUFyRvIkYt+50COZ5a1FAyhgOkVCXhTsRmZaakytYNtLC48AX3AIgD
   pAHgN0L5dejrdbULDg6K0JIa5LYtWGbKjSJDN3fpI+htiDLWPPaJ2WNrg
   25W2H6yQdvVT+YzXy+ehMwSjELvnBhqGEO2WYdj/GAJR9O8jKYOJZHq6f
   I9znLik5At2bztvHN2ejCrL3qMwo8md/1AaZhISNPCHy1wJKSJq5ibeuV
   CvbCj1JhI9BZGSihEY+dFjRM2GSihaZuCeL1CJfXcGd7gqClVYZRL7y5P
   Q==;
X-CSE-ConnectionGUID: 13CPflNrSKiNxQdNDSKWJA==
X-CSE-MsgGUID: Y78HijJeTjG5ZChIVegOWQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11122"; a="17459194"
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="17459194"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 20:02:36 -0700
X-CSE-ConnectionGUID: ry6BGg4WQ02kI5AnyNuMqA==
X-CSE-MsgGUID: dJblXAP8QI2e5VpUwXL21g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="77188479"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa002.jf.intel.com with ESMTP; 03 Jul 2024 20:02:32 -0700
Message-ID: <309e37d1-6066-4ba1-b30c-402a3c3e7c76@linux.intel.com>
Date: Thu, 4 Jul 2024 10:59:45 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Jason Gunthorpe <jgg@ziepe.ca>,
 Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, Yi Liu
 <yi.l.liu@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v8 06/10] iommufd: Add iommufd fault object
To: Nicolin Chen <nicolinc@nvidia.com>
References: <20240702063444.105814-1-baolu.lu@linux.intel.com>
 <20240702063444.105814-7-baolu.lu@linux.intel.com>
 <ZoXZZ2SJ/WdlMJaX@Asurada-Nvidia>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <ZoXZZ2SJ/WdlMJaX@Asurada-Nvidia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/4/24 7:06 AM, Nicolin Chen wrote:
> Hi Baolu,

Hi Nicolin,

> On Tue, Jul 02, 2024 at 02:34:40PM +0800, Lu Baolu wrote:
> 
>> An iommufd fault object provides an interface for delivering I/O page
>> faults to user space. These objects are created and destroyed by user
>> space, and they can be associated with or dissociated from hardware page
>> table objects during page table allocation or destruction.
>>
>> User space interacts with the fault object through a file interface. This
>> interface offers a straightforward and efficient way for user space to
>> handle page faults. It allows user space to read fault messages
>> sequentially and respond to them by writing to the same file. The file
>> interface supports reading messages in poll mode, so it's recommended that
>> user space applications use io_uring to enhance read and write efficiency.
>>
>> A fault object can be associated with any iopf-capable iommufd_hw_pgtable
>> during the pgtable's allocation. All I/O page faults triggered by devices
>> when accessing the I/O addresses of an iommufd_hw_pgtable are routed
>> through the fault object to user space. Similarly, user space's responses
>> to these page faults are routed back to the iommu device driver through
>> the same fault object.
> There is a need for VIOMMU object to report HW fault to VMM. For
> example, a HW-accelerated VCMDQ may encounter HW errors. HW will
> raise an IRQ to the host kernel and the host kernel will forward
> it to the guest. I think we can have a viommu->fault, similar to
> the hwpt->fault introduced by this series. This viommu->fault can
> also benefit nested IOMMU for reporting translation error.
> 
> I learned that this hwpt->fault is exclusively for IOPF/PRI. And
> Jason suggested me to add a different one for VIOMMU. Yet, after
> taking a closer look, I found the fault object in this series is
> seemingly quite generic at the uAPI level: its naming/structure,
> and the way how it's allocated and passed to hwpt, despite being
> highly correlated with IOPF in its fops code. So, I feel that we
> might have a chance of reusing it for different fault types:
> 
> +enum iommu_fault_type {
> +	IOMMU_FAULT_TYPE_HWPT_IOPF,
> +	IOMMU_FAULT_TYPE_VIOMMU_IRQ,
> +};
> 
>   struct iommu_fault_alloc {
>   	__u32 size;
>   	__u32 flags;
> +	__u32 type;  /* enum iommu_fault_type */
>   	__u32 out_fault_id;
>   	__u32 out_fault_fd;
>   };
> 
> I understand that this is already v8. So, maybe we can, for now,
> apply the small diff above with an IOMMU_FAULT_TYPE_HWPT_IOPF type
> check in the ioctl handler. And a decoupling for the iopf fops in
> the ioctl handler can come later in the viommu series:
> 	switch (type) {
> 	case IOMMU_FAULT_TYPE_HWPT_IOPF:
> 		filep = anon_inode_getfile("[iommufd-pgfault]",
> 					   &iommufd_fault_fops_iopf);
> 	case IOMMU_FAULT_TYPE_VIOMMU_IRQ:
> 		filep = anon_inode_getfile("[iommufd-viommu-irq]",
> 					   &iommufd_fault_fops_viommu);
> 	default:
> 		return -EOPNOSUPP;
> 	}
> 
> Since you are the designer here, I think you have a better 10000
> foot view -- maybe I am missing something here implying that the
> fault object can't be really reused by viommu.
> 
> Would you mind sharing some thoughts here?

I think this is a choice between "two different objects" vs. "same
object with different FD interfaces". If I understand it correctly, your
proposal of unrecoverable fault delivery is not limited to vcmdq, but
generic to all unrecoverable events that userspace should be aware of
when the passed-through device is affected.

 From a hardware architecture perspective, the interfaces for
unrecoverable events don't always match the page faults. For example,
VT-d architecture defines a PR queue for page faults, but uses a
register set to report unrecoverable events. The 'reason', 'request id'
and 'pasid' fields of the register set indicate what happened on the
hardware. New unrecoverable events will not be reported until the
previous one has been fetched.

With the above being said, I have no strong opinions between these two
choices. Jason and Kevin should have more insights.

Thanks,
baolu
