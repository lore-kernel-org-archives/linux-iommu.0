Received: from mgamail.intel.com (unknown [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF9853A6
	for <iommu@lists.linux.dev>; Wed,  2 Aug 2023 08:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690963781; x=1722499781;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ki0hcyOchnwZdsu/iCxnKTRMwPrBS92kVd7zfRstuOg=;
  b=KxlruH/ojtufURV402oZc6w9HUVoVhGSdRrEILVl5yn0thpakDv5Fz4r
   HJZZ9v8sQvOsXPGojCB4HgCOOBYmRPiMLSCNVCzn/gUylY+hyVAh+0hOE
   FReD38LC3xLHqXgQ+eIrw6xZeRoK5xQS/wWrumbaWBZRucs0rczucmWdn
   rSnkrlXvOz6xPPRBHNDM7l8MZkyDDPdM9TTGzsjSMlB9ZKihwcF4eH/QW
   O21F+gl2WT203Rji1v0c26V28Q5S8DX5ZPtSo9Jo0VI5Qu4xzAQiF5n9T
   zQH4hM3v0TTtnqT+oWVNjCekIXIojfprRZlVduaEYJ95qScqDLw1L7ukB
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="359557966"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="359557966"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 01:09:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="678978681"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="678978681"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.213.137]) ([10.254.213.137])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 01:09:34 -0700
Message-ID: <17e403c0-f2f8-c3d4-9dd0-3a812be79b4a@linux.intel.com>
Date: Wed, 2 Aug 2023 16:09:32 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
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
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v4 04/12] iommu/vt-d: Add helper to setup pasid nested
 translation
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "joro@8bytes.org" <joro@8bytes.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>
References: <20230724111335.107427-1-yi.l.liu@intel.com>
 <20230724111335.107427-5-yi.l.liu@intel.com>
 <BN9PR11MB5276C84A20C48B4041BE07B78C0BA@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276C84A20C48B4041BE07B78C0BA@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/8/2 15:10, Tian, Kevin wrote:
>> +
>> +	pasid_set_slptr(pte, virt_to_phys(pgd));
>> +	pasid_set_fault_enable(pte);
>> +	pasid_set_domain_id(pte, did);
>> +	pasid_set_address_width(pte, s2_domain->agaw);
>> +	pasid_set_page_snoop(pte, !!ecap_smpwc(iommu->ecap));
>> +	pasid_set_translation_type(pte, PASID_ENTRY_PGTT_NESTED);
>> +	pasid_set_present(pte);
>> +	spin_unlock(&iommu->lock);
>> +
> this lacks of handling of force_snooping

If stage-2 domain has force_snooping attribute set, then we should set
the bit field in the pasid entry, right?

How about below additional change?

diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 19ac4084913b..86db81ec91f1 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -827,6 +827,9 @@ int intel_pasid_setup_nested(struct intel_iommu 
*iommu, struct device *dev,
         if (s1_cfg->flags & IOMMU_VTD_S1_EAFE)
                 pasid_set_eafe(pte);

+       if (s2_domain>force_snooping)
+               pasid_set_pgsnp(pte);
+
         pasid_set_slptr(pte, virt_to_phys(pgd));
         pasid_set_fault_enable(pte);
         pasid_set_domain_id(pte, did);

Best regards,
baolu
