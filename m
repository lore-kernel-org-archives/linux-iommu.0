Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0580538382
	for <iommu@lists.linux.dev>; Thu, 15 Aug 2024 04:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723697285; cv=none; b=a4GEoRPOFOaQXFN6xyXY7SoBipuJPbWrN7tlM9haiLSYdmq7i0tdUekVXQ7Q4X5G4C2EYyWHt24LgROqNYOhXrvv39JjXP+guDxGS+UTQtLq4W9Udvk+DlvDNAcWbv8BDDo076LH4TILy9EqP3xGtJ67NvBIsvRhRJnIai+vgN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723697285; c=relaxed/simple;
	bh=qG4XL9eNXoz4AQcC/hNvY1JzoRhsfmUgITFkEfpt9AE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VzIRM6uip8SbVFNGrjdZPsF9HaTN/hHD9nan9cwxTn3uInNV+SRIwkAJSmsm98emsDdTvIYf6otueRp0zb3KlAENXAVY+63cey+KVLF1s2x3rI8r28cIty/80hOY3s1pRet5XKOve82q920lYqJjIsb9Ykvug061mxpyMCjUmBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lmA5Pbgj; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lmA5Pbgj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723697283; x=1755233283;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qG4XL9eNXoz4AQcC/hNvY1JzoRhsfmUgITFkEfpt9AE=;
  b=lmA5Pbgjeus8Y0vRQ2MyEylmZkTtuUdVmbdH1m2ja3jbmT0sCf+SR4Ja
   swV+5ETdtqr7NfoQrDY8tiYBzwM7Kkkama2BhXk1GqyYWGzZyEl2uTAoU
   FrCnyt/MURRjiGgW9oEoIOx+QAcP7KNNoIALF+cEVU7A1A429sWTPrJmk
   EeMtCt+8pYp52WLIN32X+GQzYDoZRenF7yWeBCN07G0wWOJZWfDtzmc5U
   pnH6brlmpKwCbcnucYYWhaOPs/ad+qVyNg68RgTgt5n2BuMZN870Vmp35
   rHIUjbsBgqfaMPt8hcr06fyJn3mlw8MaiY2Nkfcz9oAq+7LxeNZ2dxrtX
   g==;
X-CSE-ConnectionGUID: Rn23OhLxRIKMIYQ88DilTA==
X-CSE-MsgGUID: hyDVdYFGSfy5F9QWOCiJig==
X-IronPort-AV: E=McAfee;i="6700,10204,11164"; a="39401828"
X-IronPort-AV: E=Sophos;i="6.10,147,1719903600"; 
   d="scan'208";a="39401828"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 21:48:02 -0700
X-CSE-ConnectionGUID: GYD9jhS4TG6eB4gezuPKFA==
X-CSE-MsgGUID: F53mHYkJRDSqnNOwB6tbSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,147,1719903600"; 
   d="scan'208";a="59089270"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.229.145]) ([10.124.229.145])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 21:48:01 -0700
Message-ID: <4ff133f3-e541-4a0f-a72c-ce682720e6df@linux.intel.com>
Date: Thu, 15 Aug 2024 12:47:58 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Jacob Pan <jacob.jun.pan@linux.intel.com>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] iommu/vt-d: Add helper to flush caches for context
 change
To: Alex Williamson <alex.williamson@redhat.com>
References: <20240702130839.108139-1-baolu.lu@linux.intel.com>
 <20240702130839.108139-7-baolu.lu@linux.intel.com>
 <20240814162726.5efe1a6e.alex.williamson@redhat.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240814162726.5efe1a6e.alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/8/15 6:27, Alex Williamson wrote:
> Hi Baolu,

Hi Alex,

> This appears to be non-functional and breaks device assignment...

Yes. This is broken. Thanks for pointing it out.

Perhaps I can fix it by passing domain id to the helper? Something like
below:

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 01002ae2a091..b3b295e60626 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -1152,7 +1152,7 @@ void cache_tag_flush_range_np(struct dmar_domain 
*domain, unsigned long start,

  void intel_context_flush_present(struct device_domain_info *info,
  				 struct context_entry *context,
-				 bool affect_domains);
+				 u16 did, bool affect_domains);

  #ifdef CONFIG_INTEL_IOMMU_SVM
  void intel_svm_check(struct intel_iommu *iommu);
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 159da629349c..34006b6e89eb 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1903,6 +1903,7 @@ static void domain_context_clear_one(struct 
device_domain_info *info, u8 bus, u8
  {
  	struct intel_iommu *iommu = info->iommu;
  	struct context_entry *context;
+	u16 did;

  	spin_lock(&iommu->lock);
  	context = iommu_context_addr(iommu, bus, devfn, 0);
@@ -1911,10 +1912,11 @@ static void domain_context_clear_one(struct 
device_domain_info *info, u8 bus, u8
  		return;
  	}

+	did = context_domain_id(context);
  	context_clear_entry(context);
  	__iommu_flush_cache(iommu, context, sizeof(*context));
  	spin_unlock(&iommu->lock);
-	intel_context_flush_present(info, context, true);
+	intel_context_flush_present(info, context, did, true);
  }

  static int domain_setup_first_level(struct intel_iommu *iommu,
@@ -4077,6 +4079,7 @@ static int context_flip_pri(struct 
device_domain_info *info, bool enable)
  	struct intel_iommu *iommu = info->iommu;
  	u8 bus = info->bus, devfn = info->devfn;
  	struct context_entry *context;
+	u16 did;

  	spin_lock(&iommu->lock);
  	if (context_copied(iommu, bus, devfn)) {
@@ -4089,6 +4092,7 @@ static int context_flip_pri(struct 
device_domain_info *info, bool enable)
  		spin_unlock(&iommu->lock);
  		return -ENODEV;
  	}
+	did = context_domain_id(context);

  	if (enable)
  		context_set_sm_pre(context);
@@ -4097,7 +4101,7 @@ static int context_flip_pri(struct 
device_domain_info *info, bool enable)

  	if (!ecap_coherent(iommu->ecap))
  		clflush_cache_range(context, sizeof(*context));
-	intel_context_flush_present(info, context, true);
+	intel_context_flush_present(info, context, did, true);
  	spin_unlock(&iommu->lock);

  	return 0;
diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 5792c817cefa..b51fc268dc84 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -683,6 +683,7 @@ static void device_pasid_table_teardown(struct 
device *dev, u8 bus, u8 devfn)
  	struct device_domain_info *info = dev_iommu_priv_get(dev);
  	struct intel_iommu *iommu = info->iommu;
  	struct context_entry *context;
+	u16 did;

  	spin_lock(&iommu->lock);
  	context = iommu_context_addr(iommu, bus, devfn, false);
@@ -691,10 +692,11 @@ static void device_pasid_table_teardown(struct 
device *dev, u8 bus, u8 devfn)
  		return;
  	}

+	did = context_domain_id(context);
  	context_clear_entry(context);
  	__iommu_flush_cache(iommu, context, sizeof(*context));
  	spin_unlock(&iommu->lock);
-	intel_context_flush_present(info, context, false);
+	intel_context_flush_present(info, context, did, false);
  }

  static int pci_pasid_table_teardown(struct pci_dev *pdev, u16 alias, 
void *data)
@@ -885,10 +887,9 @@ static void __context_flush_dev_iotlb(struct 
device_domain_info *info)
   */
  void intel_context_flush_present(struct device_domain_info *info,
  				 struct context_entry *context,
-				 bool flush_domains)
+				 u16 did, bool flush_domains)
  {
  	struct intel_iommu *iommu = info->iommu;
-	u16 did = context_domain_id(context);
  	struct pasid_entry *pte;
  	int i;

Thanks,
baolu
