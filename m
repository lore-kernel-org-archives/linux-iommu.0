Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FE4A23
	for <iommu@lists.linux.dev>; Sat, 11 Feb 2023 03:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676086971; x=1707622971;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Mb6jH6AmOE4FzUbSjuwgu/iwgBs2C4fgrjOWh5cufe0=;
  b=KhMGiknLAQguc3DTVCqAoSCJ8xUtFuALnndZ5Ge8Ri2zV+vaX6z01WkH
   Fb8OgDKYqJk9O8d5O7fjPkrpd4SlZRzuwo0cYSwc87vvPYqKsdGiYnvHl
   KOUR8Qfs9ubNwiwTiaiS8lnZIZ7i38mBesgnLvsi+nE3vx8m2VVEgrwho
   jBgUftFGh2L/0Vb8z6e0iRez775WGqTRtL8MTK5EjWBpUPNLN5v77mpGq
   3Q1NPa+CUBjbAZJ7MMM2UEFaEeLwAQHiAYivAS9KBR4RQONdPLdQK0pAm
   6huKq3rA5ZbFbxG1N3IHENQ7OaFRjypXionxGLQ4zMKWabbadqKRwDtqw
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="331883147"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="331883147"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 19:42:51 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="842224646"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="842224646"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.249.168.175]) ([10.249.168.175])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 19:42:46 -0800
Message-ID: <8665f299-fd4f-738a-6492-59f0deef444f@linux.intel.com>
Date: Sat, 11 Feb 2023 11:42:44 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Cc: baolu.lu@linux.intel.com, "cohuck@redhat.com" <cohuck@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
 "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
 "yi.y.sun@linux.intel.com" <yi.y.sun@linux.intel.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>, "lulu@redhat.com" <lulu@redhat.com>,
 "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH 1/6] iommu: Add new iommu op to get iommu hardware
 information
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "joro@8bytes.org" <joro@8bytes.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>
References: <20230209041642.9346-1-yi.l.liu@intel.com>
 <20230209041642.9346-2-yi.l.liu@intel.com>
 <BN9PR11MB5276CB88298F97177A7AAF448CDE9@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276CB88298F97177A7AAF448CDE9@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/2/10 15:28, Tian, Kevin wrote:
>> From: Liu, Yi L<yi.l.liu@intel.com>
>> Sent: Thursday, February 9, 2023 12:17 PM
>> @@ -223,6 +224,11 @@ struct iommu_iotlb_gather {
>>   /**
>>    * struct iommu_ops - iommu ops and capabilities
>>    * @capable: check capability
>> + * @hw_info: IOMMU hardware capabilities. The type of the returned data
>> is
> is it 'info' or 'capability'?

hw_info. IOMMU core does not care about specific content, so it is not
necessary to define it as capability or anything else.

Perhaps we need to change the comments a bit, say, "IOMMU hardware
information"?

Best regards,
baolu

