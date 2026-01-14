Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FF53793DD
	for <iommu@lists.linux.dev>; Wed, 14 Jan 2026 08:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768379251; cv=none; b=ZmebdY6LoAie24L9luVRPUJbR6/EDOZy+xg7kucVfsZOHJn9vMUxJ3cXz95E0Tozipw95WL3OAdkeC5Y0jKvnadKbmTryompWXOjzGjIIKIVNykaBFdNY/xJwDmjwPTuBaXJjBv9c61499a4Y51IB9YlrIa7d9enw0hjExVtuj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768379251; c=relaxed/simple;
	bh=/05pSK55aXyTaCMunIhX8Maz8p4HxppctsWggZxAvv4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tY3p38713NdJShv2GNgYze0aSGjBRvKyHA9ZnV7jFqRDvKagCjRNTDA5kKW9pUSGi3oBqNnyH8jQ8zlHJOemiuXf1K0NB6/MQHIfTEe6mZ6wWHWDUlynXR1VU9jR40U2m2GFzrCv8Ns2cXeOudzKftX81u7L6OKowfdx2T/uZH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FIG9ER1T; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FIG9ER1T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768379247; x=1799915247;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/05pSK55aXyTaCMunIhX8Maz8p4HxppctsWggZxAvv4=;
  b=FIG9ER1TSeSKHY8AipldAN2+pnAIalLjnDLffo63NErJe2KQdRnzByPT
   uWTHnp7ZiFTzF/Z9WmgEc3YUap2NiX/rM9XR+YYERhfRVNelllFU3ojKo
   0JgiVZoTxy4alMMPm/L8dq0qzJaFnXsd2FQUiX6obw0t2HNha/BC5GSE2
   JYvp835UH/kqB/hQBULIup8D/2eZdZYLTTWbZQrNgnXkbS8IkHOyO84aH
   TE9IFzGo68CAeQ31o/6phxb5XrLQs2ESJwXDIv54EfTdo2cz+AJ4Druk1
   erlF12zkVSqi2HzwxJRWvUQB5RU6yj7dWGu+RmgpNlq1jIbLI7N3Rvhxt
   g==;
X-CSE-ConnectionGUID: t7oGI1TNQb+JFPZBDObOZw==
X-CSE-MsgGUID: Naty89cKTMe9ZNv7DP8tUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="69574594"
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; 
   d="scan'208";a="69574594"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 00:27:25 -0800
X-CSE-ConnectionGUID: mdmoWojeQWyPdxU5bRzZdg==
X-CSE-MsgGUID: AzssASySS7OVZkV+kKoFmg==
X-ExtLoop1: 1
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 00:27:22 -0800
Message-ID: <b27918af-dfb8-4ec1-8d54-3fe5919ba0ed@linux.intel.com>
Date: Wed, 14 Jan 2026 16:27:29 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] iommu/vt-d: Clear Present bit before tearing down
 PASID entry
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@nvidia.com>
Cc: Dmytro Maluka <dmaluka@chromium.org>,
 Samiullah Khawaja <skhawaja@google.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260113030052.977366-1-baolu.lu@linux.intel.com>
 <20260113030052.977366-3-baolu.lu@linux.intel.com>
 <BN9PR11MB52765D0E2B4A39CA857900ED8C8FA@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52765D0E2B4A39CA857900ED8C8FA@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/14/26 15:32, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Tuesday, January 13, 2026 11:01 AM
>>
>> The Intel VT-d Scalable Mode PASID table entry consists of 512 bits (64
>> bytes). When tearing down an entry, the current implementation zeros the
>> entire 64-byte structure immediately.
>>
>> However, the IOMMU hardware may fetch these 64 bytes using multiple
>> internal transactions (e.g., four 128-bit bursts). If a hardware fetch
>> occurs simultaneously with the CPU zeroing the entry, the hardware could
>> observe a "torn" entry — where some chunks are zeroed and others still
>> contain old data — leading to unpredictable behavior or spurious faults.
>>
>> Follow the "Guidance to Software for Invalidations" in the VT-d spec
>> (Section 6.5.3.3) by implementing a proper ownership handshake:
>>
>> 1. Clear only the 'Present' (P) bit of the PASID entry. This tells the
>>     hardware that the entry is no longer valid.
>> 2. Execute the required invalidation sequence (PASID cache, IOTLB, and
>>     Device-TLB flush) to ensure the hardware has released all cached
>>     references to the entry.
>> 3. Only after the flushes are complete, zero out the remaining fields of
>>     the PASID entry.
>>
>> Additionally, add an explicit clflush in intel_pasid_clear_entry() to
>> ensure that the cleared entry is visible to the IOMMU on systems where
>> memory coherency (ecap_coherent) is not supported.
>>
> 
> better split the clflush part into a separate patch

Ah, the commit message is a bit confusing. Previously, 
intel_pasid_clear_entry() was followed by a clflush. Now that we've 
moved the clearing logic after the cache invalidation, an explicit 
clflush is required. Instead of splitting this into a separate patch, 
how about amending the commit message to make this clear.

Or, keep intel_pasid_clear_entry() untouched like the following:

iommu/vt-d: Clear Present bit before tearing down PASID entry

The Intel VT-d Scalable Mode PASID table entry consists of 512 bits (64
bytes). When tearing down an entry, the current implementation zeros the
entire 64-byte structure immediately.

However, the IOMMU hardware may fetch these 64 bytes using multiple
internal transactions (e.g., four 128-bit bursts). If a hardware fetch
occurs simultaneously with the CPU zeroing the entry, the hardware could
observe a "torn" entry — where some chunks are zeroed and others still
contain old data — leading to unpredictable behavior or spurious faults.

Follow the "Guidance to Software for Invalidations" in the VT-d spec
(Section 6.5.3.3) by implementing a proper ownership handshake:

1. Clear only the 'Present' (P) bit of the PASID entry. This tells the
    hardware that the entry is no longer valid.
2. Execute the required invalidation sequence (PASID cache, IOTLB, and
    Device-TLB flush) to ensure the hardware has released all cached
    references to the entry.
3. Only after the flushes are complete, zero out the remaining fields of
    the PASID entry.

Fixes: 0bbeb01a4faf ("iommu/vt-d: Manage scalalble mode PASID tables")
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
  drivers/iommu/intel/pasid.h | 12 ++++++++++++
  drivers/iommu/intel/pasid.c |  6 +++++-
  2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/pasid.h b/drivers/iommu/intel/pasid.h
index b4c85242dc79..35de1d77355f 100644
--- a/drivers/iommu/intel/pasid.h
+++ b/drivers/iommu/intel/pasid.h
@@ -237,6 +237,18 @@ static inline void pasid_set_present(struct 
pasid_entry *pe)
  	pasid_set_bits(&pe->val[0], 1 << 0, 1);
  }

+/*
+ * Clear the Present (P) bit (bit 0) of a scalable-mode PASID table entry.
+ * This initiates the transition of the entry's ownership from hardware
+ * to software. The caller is responsible for fulfilling the invalidation
+ * handshake recommended by the VT-d spec, Section 6.5.3.3 (Guidance to
+ * Software for Invalidations).
+ */
+static inline void pasid_clear_present(struct pasid_entry *pe)
+{
+	pasid_set_bits(&pe->val[0], 1 << 0, 0);
+}
+
  /*
   * Setup Page Walk Snoop bit (Bit 87) of a scalable mode PASID
   * entry.
diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 298a39183996..3a8ec5eba83e 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -272,7 +272,7 @@ void intel_pasid_tear_down_entry(struct intel_iommu 
*iommu, struct device *dev,

  	did = pasid_get_domain_id(pte);
  	pgtt = pasid_pte_get_pgtt(pte);
-	intel_pasid_clear_entry(dev, pasid, fault_ignore);
+	pasid_clear_present(pte);
  	spin_unlock(&iommu->lock);

  	if (!ecap_coherent(iommu->ecap))
@@ -286,6 +286,10 @@ void intel_pasid_tear_down_entry(struct intel_iommu 
*iommu, struct device *dev,
  		iommu->flush.flush_iotlb(iommu, did, 0, 0, DMA_TLB_DSI_FLUSH);

  	devtlb_invalidation_with_pasid(iommu, dev, pasid);
+	intel_pasid_clear_entry(dev, pasid, fault_ignore);
+	if (!ecap_coherent(iommu->ecap))
+		clflush_cache_range(pte, sizeof(*pte));
+
  	if (!fault_ignore)
  		intel_iommu_drain_pasid_prq(dev, pasid);
  }
-- 
2.43.0

Thanks,
baolu
