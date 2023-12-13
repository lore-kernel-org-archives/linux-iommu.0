Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F39065C
	for <iommu@lists.linux.dev>; Wed, 13 Dec 2023 02:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nCBuKH9g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702435696; x=1733971696;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XkdNVmO59LJAx7n20c7rawpOcenfvchnrFiaKUg5SEg=;
  b=nCBuKH9g6WVlcEXsfagEMQQNQyZM2nE0fj1SM6vTDEqubW/K5HEufQo1
   LWyw5l8gOhEWaZ3p9Ud02gEs5BtTbIvte1a5ZIuIldPMtxVOoFirA6gnD
   U+C5gmm5MNGNq4C/Hx5pxhmU3OWCVPRx16nPpiYuSM3RUWPGR7LC6aub3
   iFnGa/KqUz1Ky8ctND0CRLv3zhAsvuyPs+uBPgwEH0D+7G6/3r10yT/wk
   mAEbDC03632y1XOQK4UcLW3OZP2yowQyVy0Xa4RnQSF/Z3jbZm51K0eop
   LmKdXeTxOOkM608Zqpye0D6sbfJhMrlVgY6PK8GP8wJDL15TyA3zyAe74
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="481105426"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="481105426"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 18:48:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="864446798"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="864446798"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Dec 2023 18:48:12 -0800
Message-ID: <d16460ff-f46f-4b20-8173-a81ac413b56d@linux.intel.com>
Date: Wed, 13 Dec 2023 10:43:32 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/6] iommu/vt-d: Remove 1:1 mappings from identity
 domain
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>
References: <20231205012203.244584-1-baolu.lu@linux.intel.com>
 <20231205012203.244584-5-baolu.lu@linux.intel.com>
 <BN9PR11MB52761FF9AB496B422596DDDF8C8AA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <1161d8aa-9fcc-4e9e-a7d3-c461fee19a54@linux.intel.com>
 <BN9PR11MB5276AC40C423A0BAAE9F40A98C8FA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <bef0f903-3665-492f-8999-fe759be5fed4@linux.intel.com>
 <BN9PR11MB5276614392E99F75B6A592C68C8DA@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276614392E99F75B6A592C68C8DA@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/13/23 10:20 AM, Tian, Kevin wrote:
>>> 	if (!dmar_map_gfx)
>>> 		iommu_identity_mapping |= IDENTMAP_GFX;
>> So with above cleaned up, we have no need to worry about drivers that
>> are not capable of handling remapped dma address any more.
>>
>> Did I miss anything?
> I prefer to removing IDENTMAP_GFX in this series and put a comment
> explaining why Azalia device has no problem.
> 
> Then send a separate patch to remove the GFX workaround option.
> If there is any valid usage still relying on that, it's easy to revert.

Agreed. We should be more cautious. Perhaps I will postpone this series
to a time when we are sure that graphic drivers are okay with this
change. As a first step, perhaps we can make a change to remove the
workaround for graphic drivers, so that any hidden bugs in the graphic
driver could be reported.

The patch looks like,

iommu/vt-d: Remove INTEL_IOMMU_BROKEN_GFX_WA

Commit 62edf5dc4a524 ("intel-iommu: Restore DMAR_BROKEN_GFX_WA option for
broken graphics drivers") was introduced 24 years ago as a temporary
workaround for graphics drivers that used physical addresses for DMA and
avoided DMA APIs. This workaround was disabled by default.

As 24 years have passed, it is expected that graphics driver developers
have migrated their drivers to use kernel DMA APIs. Therefore, this
workaround is no longer required and could been removed.

Suggested-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
  drivers/iommu/intel/iommu.c | 10 ----------
  drivers/iommu/intel/Kconfig | 11 -----------
  2 files changed, 21 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 84b78e42a470..27b8638291f2 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2357,9 +2357,6 @@ static int device_def_domain_type(struct device *dev)

  		if ((iommu_identity_mapping & IDENTMAP_AZALIA) && IS_AZALIA(pdev))
  			return IOMMU_DOMAIN_IDENTITY;
-
-		if ((iommu_identity_mapping & IDENTMAP_GFX) && IS_GFX_DEVICE(pdev))
-			return IOMMU_DOMAIN_IDENTITY;
  	}

  	return 0;
@@ -2660,13 +2657,6 @@ static int __init init_dmars(void)
  		iommu_set_root_entry(iommu);
  	}

-#ifdef CONFIG_INTEL_IOMMU_BROKEN_GFX_WA
-	dmar_map_gfx = 0;
-#endif
-
-	if (!dmar_map_gfx)
-		iommu_identity_mapping |= IDENTMAP_GFX;
-
  	check_tylersburg_isoch();

  	ret = si_domain_init(hw_pass_through);
diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
index 012cd2541a68..d2d34eb28d94 100644
--- a/drivers/iommu/intel/Kconfig
+++ b/drivers/iommu/intel/Kconfig
@@ -64,17 +64,6 @@ config INTEL_IOMMU_DEFAULT_ON
  	  one is found. If this option is not selected, DMAR support can
  	  be enabled by passing intel_iommu=on to the kernel.

-config INTEL_IOMMU_BROKEN_GFX_WA
-	bool "Workaround broken graphics drivers (going away soon)"
-	depends on BROKEN && X86
-	help
-	  Current Graphics drivers tend to use physical address
-	  for DMA and avoid using DMA APIs. Setting this config
-	  option permits the IOMMU driver to set a unity map for
-	  all the OS-visible memory. Hence the driver can continue
-	  to use physical addresses for DMA, at least until this
-	  option is removed in the 2.6.32 kernel.
-
  config INTEL_IOMMU_FLOPPY_WA
  	def_bool y
  	depends on X86

Best regards,
baolu
