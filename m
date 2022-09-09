Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35869622
	for <iommu@lists.linux.dev>; Fri,  9 Sep 2022 01:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662686647; x=1694222647;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=64BJSJ2yfINcX/nSs4j1hGHQg35SOOPoG0+S+Eesxf4=;
  b=f7w17fWe3qNk12E3neweLl8dC6c8YVmnhKOm5iPXubA9fTXKpKyf2L1f
   EeRnRpT0flxiAexPTQtFc0gmczT05Zols2o8PL/jOPQrql0WzVn9cA87B
   cuqBRX4CKRuQO3KfEP6AJEzRjJfjsDBXKNX7FLsqjoq7GrKgPAs7UiZfZ
   CkBfMfasVSnQul6Vr3Ph9eAHUEfcTEa5VGgYpntrf9ko0T67xFsn4s0Ti
   U3++O0yyHYQClSRj8xA1gZkMKfFHZ3nAmCF5mOpfI89kq5nMgunQKJ7vS
   jsivPl+GdGMYoE65htCZIlD/IZ3O1nXjTa0dtEX/SQRPXpicUBHZuX6Vb
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10464"; a="359095304"
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="359095304"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 18:24:06 -0700
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="676955360"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.214.159]) ([10.254.214.159])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 18:24:04 -0700
Message-ID: <0d70e245-e360-ddc1-eb03-67ffbc6c1a47@linux.intel.com>
Date: Fri, 9 Sep 2022 09:24:02 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Cc: baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
 Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
 suravee.suthikulpanit@amd.com
Subject: Re: [PATCH v3 0/9] iommu/amd: Add Generic IO Page Table Framework
 Support for v2 Page Table
Content-Language: en-US
To: Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@nvidia.com>
References: <20220825063939.8360-1-vasant.hegde@amd.com>
 <77d2ea43-9752-b5f3-78ef-8cdae944eee4@amd.com>
 <05f9784b-15b6-2a9b-2d9e-19e1430f74e2@arm.com> <YxintMDEmzSXJUl5@8bytes.org>
 <YxjMQpGYaHfsiuL+@nvidia.com> <YxneJ2RqaatKmoYT@8bytes.org>
 <c11bd109-65cd-39b3-6d7e-2b29208ca2ca@arm.com> <Yxnr1gBIGwdinIkr@nvidia.com>
 <YxnuYTrkC5yoHH84@8bytes.org> <c48211fe-00b1-e679-21b8-00a85bba599a@arm.com>
 <Yxn1IcWk+61ddiCn@nvidia.com> <7b30a064-754e-0528-5142-8446ab5bdc95@arm.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <7b30a064-754e-0528-5142-8446ab5bdc95@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2022/9/8 23:23, Robin Murphy wrote:
> 
>> I can't think of a use case for nesting the PASID under the RID, in
>> every scenario this seems to be problematic. Glad to see it is undone
>> with the new HW.
> 
> I assume you mean you can't think of a use-case for having the RID 
> bypass stage 1/guest translation, since "nesting the PASID under the 
> RID" is basically just how PASIDs work. AMD phrases it as "An upstream 
> packet with a valid PASID in the PASID TLP prefix contains a canonical 
> GVA; an upstream packet without a valid PASID in the PASID TLP prefix or 
> with no PASID TLP prefix and an untranslated address contains a GPA". So 
> GVA->GPA is per-PASID, then GPA->PA is for the entire RID, which is 
> exactly how SMMU stage 1/2 work as well. As far as I'm aware that's 
> standard for Intel too, until SIOV where they can carry the PASID 
> through to the second level also.

Yes. That's something called ECS mode in VT-d 2.x spec. Then Scalable
Mode began to appear in 3.x and replaced the previous ECS. Intel has no
real ECS hardware implementation in the shipping products.

Best regards,
baolu
