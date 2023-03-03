Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6081FB3
	for <iommu@lists.linux.dev>; Fri,  3 Mar 2023 09:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677837469; x=1709373469;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dA37+VbNhDthKXVJxlFIvcQryB+hn/AJidWA2VvbN90=;
  b=intWZVkQpwZBTaTtl9USh4/XjTVP1unr8CP2BIHfnozAVSbrrthOAQsJ
   DMH7mw9NC6A96eBcNKoguLYoV7o94ACdn5v0+8wBXSG5XqPMKQyy+cjyN
   RWYoeYzvkk+ggJeQ3kNOuOjR0JG4ismtJaNkEJjclqKRG0IURA8YfHQEl
   MNnW7/ArxyjocuJOJAhxwaG2a6WELi+pUq46bgy3Yh4i+Va/86Y8V9lZx
   DBUl6veQ2BLGWVOxwZPHXcdz9cgkCMCPraDxj97y5tyFeQ1bGZ3n9xZqu
   Kl7Lj2QdbX6gyhhl3XfeOVGbrgpL3EgbtGp2AUHR0CTK41/E07wzn24EU
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="335031685"
X-IronPort-AV: E=Sophos;i="5.98,230,1673942400"; 
   d="scan'208";a="335031685"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2023 01:57:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="744183445"
X-IronPort-AV: E=Sophos;i="5.98,230,1673942400"; 
   d="scan'208";a="744183445"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.208.51]) ([10.254.208.51])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2023 01:57:43 -0800
Message-ID: <3b2c6fe9-821f-9b84-acb6-777e8517a0fc@linux.intel.com>
Date: Fri, 3 Mar 2023 17:57:41 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Cc: baolu.lu@linux.intel.com, Jacob Pan <jacob.jun.pan@linux.intel.com>,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
 Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Dave Hansen <dave.hansen@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
 X86 Kernel <x86@kernel.org>, bp@alien8.de, "H. Peter Anvin" <hpa@zytor.com>,
 Peter Zijlstra <peterz@infradead.org>, corbet@lwn.net, vkoul@kernel.org,
 dmaengine@vger.kernel.org, linux-doc@vger.kernel.org,
 Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
 David Woodhouse <dwmw2@infradead.org>, Raj Ashok <ashok.raj@intel.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
 "Yu, Fenghua" <fenghua.yu@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Kirill Shutemov <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v4 3/6] iommu/sva: Stop using ioasid_set for SVA
Content-Language: en-US
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20230301235646.2692846-1-jacob.jun.pan@linux.intel.com>
 <20230301235646.2692846-4-jacob.jun.pan@linux.intel.com>
 <3b7fb4d3-1fe9-a3be-46ad-c271be9f96c7@linux.intel.com>
 <20230302091707.58d59964@jacob-builder>
 <794c7dad-2e62-3afa-ea10-92179b0d1659@linux.intel.com>
 <20230303093235.GB361458@myrica>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230303093235.GB361458@myrica>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/3/3 17:32, Jean-Philippe Brucker wrote:
>> I suppose the common thing is reserving some kind of special PASIDs.
> Are you planning to use RID_PASID != 0 in VT-d?  Otherwise we could just
> communicate min_pasid from the IOMMU driver the same way we do max_pasid.
> 
> Otherwise I guess re-introduce a lighter ioasid_alloc() that the IOMMU
> driver calls to reserve PASID0/RID_PASID.

Yes. We probably will use a non-zero RID_PASID in the future. An
interface to reserve (or allocate) a PASID from iommu_global_pasid_ida
should work then.

Best regards,
baolu
