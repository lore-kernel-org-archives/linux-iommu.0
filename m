Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F016257A
	for <iommu@lists.linux.dev>; Tue, 28 Jun 2022 11:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656414151; x=1687950151;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5uCybmEbGP1MC9vWgObj6veTZsOluHrJf+cNJQ0Uaw8=;
  b=jzsXHfGHPRAa4KLzGxT2YbK4lHU0JBFXaus1hPJSDruN2jYhEOnJr0Kh
   zaE8t7zp0rRFOF8tqyoFtxkvnS1Xj+j5oLH/4QPWBBWjO37CDljPoreuT
   YJSZJHCWJJR7zIm2w7BWzebBU/zH+W67otn8sT5Gy2tBS90kvJPjyqgb+
   m+P9SrX0ej7L8ovgmOXNm1EtqF7BCxnC8taZYxfZ14yfHLW+VzvvU8A/o
   NXMlfxuS0jmCX8W2pFPhb8igI7Vk0sUHU74nyvm1vOFOEcMyLCzyHJqQf
   +GxLbod0pfnTDf0RqnNwrZAP/fgMvDhFgPQNcolNMTtL/NMVqmen9OAyr
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="282444649"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="282444649"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 04:02:31 -0700
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="646867528"
Received: from ltang11-mobl1.ccr.corp.intel.com (HELO [10.249.169.64]) ([10.249.169.64])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 04:02:27 -0700
Message-ID: <85993f97-fd8c-07b7-9843-20d1b831f2eb@linux.intel.com>
Date: Tue, 28 Jun 2022 19:02:25 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Cc: baolu.lu@linux.intel.com, Eric Auger <eric.auger@redhat.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Pan, Jacob jun"
 <jacob.jun.pan@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v9 10/11] iommu: Per-domain I/O page fault handling
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 "Jiang, Dave" <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>
References: <20220621144353.17547-1-baolu.lu@linux.intel.com>
 <20220621144353.17547-11-baolu.lu@linux.intel.com>
 <BN9PR11MB52768181B0EB29DBCB11AEA68CB89@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52768181B0EB29DBCB11AEA68CB89@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Message-ID: <20220628110225.meRwKIbsbFgnOVv-CkpPU7oQUUYrdzXr1Kl27-iTM6Q@z>

On 2022/6/28 16:39, Tian, Kevin wrote:
>>   static void iopf_handle_group(struct work_struct *work)
>>   {
>>   	struct iopf_group *group;
>> +	struct iommu_domain *domain;
>>   	struct iopf_fault *iopf, *next;
>>   	enum iommu_page_response_code status =
>> IOMMU_PAGE_RESP_SUCCESS;
>>
>>   	group = container_of(work, struct iopf_group, work);
>> +	domain = iommu_get_domain_for_dev_pasid(group->dev,
>> +				group->last_fault.fault.prm.pasid);
>> +	if (!domain || !domain->iopf_handler)
>> +		status = IOMMU_PAGE_RESP_INVALID;
> Miss a comment on why no refcnt is required on domain as explained
> in the commit msg.

I had some comments around iommu_queue_iopf() in the previous patch. The
iommu_queue_iopf() is the generic page fault handler exposed by iommu
core, hence that's the right place to document this.

Post it below as well:

diff --git a/drivers/iommu/io-pgfault.c b/drivers/iommu/io-pgfault.c
index 1df8c1dcae77..aee9e033012f 100644
--- a/drivers/iommu/io-pgfault.c
+++ b/drivers/iommu/io-pgfault.c
@@ -181,6 +181,13 @@ static void iopf_handle_group(struct work_struct *work)
   * request completes, outstanding faults will have been dealt with by 
the time
   * the PASID is freed.
   *
+ * Any valid page fault will be eventually routed to an iommu domain 
and the
+ * page fault handler installed there will get called. The users of this
+ * handling framework should guarantee that the iommu domain could only be
+ * freed after the device has stopped generating page faults (or the iommu
+ * hardware has been set to block the page faults) and the pending page 
faults
+ * have been flushed.
+ *
   * Return: 0 on success and <0 on error.
   */
  int iommu_queue_iopf(struct iommu_fault *fault, void *cookie)

Best regards,
baolu
