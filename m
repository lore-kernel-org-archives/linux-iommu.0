Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D26E205513
	for <iommu@lists.linux.dev>; Thu, 12 Dec 2024 06:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733986673; cv=none; b=N1md/OFBn/FpIH5CSB9ZWPNjElJ4OUMi28BIEkM0OFHiQjzk0BGvooanPT+dG+Dx6qo6q+oHvHP2YZ7O+HDJBWiA6bJKag4EQxcq9Rgqrcm2KINcTYG15ENq/4dwse3pmjTumLNyiN/CNdGbF56uXho475sYo6WnjXWS9cs0054=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733986673; c=relaxed/simple;
	bh=vybHcST6ntoDWy3VwtFCpJeXat9TBk2Da94y5UgeGRQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HtX8B2SinPgzv1XJyhKICRdVUXK5snWkGmvVqBdFwWtyh1Zwyhf/DX34U/KaufGQA3R/UULkdQ84E6aceFBWkBRRRx1EKE2oQd7sE7Zh7hWb0wYGEIbdTBjQt/BYISF0PkSMyqK3UvGU3Q4UtbaqE/M+VO+90QqmnOh/l+dJBNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zv4XcVO6; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zv4XcVO6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733986670; x=1765522670;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vybHcST6ntoDWy3VwtFCpJeXat9TBk2Da94y5UgeGRQ=;
  b=Zv4XcVO6txBzp2NY+x7XxlKzJ848qzy887xUkM242SnVtMRvIJ8I0NgC
   gJnFc/g4zJx0bNGp7EA721DvhMI8wxXZ/1DVJFl1eygZQvJuWVEBDHa/c
   y0XWwUURVV0sfnpBeNAftOr8kxuFzo6LvKilgnSyP53yIdHrFj8E56c8N
   omfIqXzNTVY4DvtKtDPDZXy2IgGkk0vP4U78Y3ySlo/1RofUGJghP+J7d
   AL46iXKUOPoPJv4GsCYY6MtyBu2VoBDcnHkk1YWgSNspTIT0EtZrmYZ+i
   rJHP2bgyv8Q2uiQxo3Q/Ioc4GNF1fOS2Oh7MMHu2zuIvEYCG+s4FcRxA7
   w==;
X-CSE-ConnectionGUID: fozqkVkKS72xznc61jyY2w==
X-CSE-MsgGUID: aXSUUXuNQSKBr74EGeWgsA==
X-IronPort-AV: E=McAfee;i="6700,10204,11283"; a="51920219"
X-IronPort-AV: E=Sophos;i="6.12,227,1728975600"; 
   d="scan'208";a="51920219"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 22:57:49 -0800
X-CSE-ConnectionGUID: yEDmbbPGTOma0SUhG2F1SA==
X-CSE-MsgGUID: vmQ8wgXESPCNU6HTYty9Vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="100686496"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.241.18]) ([10.124.241.18])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 22:57:46 -0800
Message-ID: <27c37e1d-7812-40db-a75f-d1641b5674d8@linux.intel.com>
Date: Thu, 12 Dec 2024 14:57:42 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Dan Carpenter <dan.carpenter@linaro.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] iommu/vt-d: Avoid draining PRQ in sva mm release path
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>
References: <20241212021529.1104745-1-baolu.lu@linux.intel.com>
 <BN9PR11MB5276682CEF64D6D21658893D8C3F2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276682CEF64D6D21658893D8C3F2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/12/12 14:18, Tian, Kevin wrote:
>> From: Lu Baolu<baolu.lu@linux.intel.com>
>> Sent: Thursday, December 12, 2024 10:15 AM
>>
>> When a PASID is used for SVA by a device, it's possible that the PASID
>> entry is cleared before the device flushes all ongoing DMA requests and
>> removes the SVA domain. This can occur when an exception happens and
>> the
>> process terminates before the device driver stops DMA and calls the
>> iommu driver to unbind the PASID.
>>
>> There's no need to drain the PRQ in the mm release path. Instead, the PRQ
>> will be drained in the SVA unbind path.
>>
>> Unfortunately, commit c43e1ccdebf2 ("iommu/vt-d: Drain PRQs when
>> domain
>> removed from RID") changed this behavior by unconditionally draining the
>> PRQ in intel_pasid_tear_down_entry(). This can lead to a potential
>> sleeping-in-atomic-context issue.
>>
>> Smatch static checker warning:
>>
>> 	drivers/iommu/intel/prq.c:95 intel_iommu_drain_pasid_prq()
>> 	warn: sleeping in atomic context
>>
>> To avoid this issue, prevent draining the PRQ in the SVA mm release path
>> and restore the previous behavior.
>>
>> Fixes: c43e1ccdebf2 ("iommu/vt-d: Drain PRQs when domain removed from
>> RID")
>> Reported-by: Dan Carpenter<dan.carpenter@linaro.org>
>> Closes:https://lore.kernel.org/linux-iommu/c5187676-2fa2-4e29-94e0-
>> 4a279dc88b49@stanley.mountain/
>> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/intel/pasid.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
>> index 0f2a926d3bd5..5b7d85f1e143 100644
>> --- a/drivers/iommu/intel/pasid.c
>> +++ b/drivers/iommu/intel/pasid.c
>> @@ -265,7 +265,8 @@ void intel_pasid_tear_down_entry(struct
>> intel_iommu *iommu, struct device *dev,
>>   		iommu->flush.flush_iotlb(iommu, did, 0, 0,
>> DMA_TLB_DSI_FLUSH);
>>
>>   	devtlb_invalidation_with_pasid(iommu, dev, pasid);
>> -	intel_iommu_drain_pasid_prq(dev, pasid);
>> +	if (!fault_ignore)
>> +		intel_iommu_drain_pasid_prq(dev, pasid);
>>   }
>>
> As a regression fix:
> 
> Reviewed-by: Kevin Tian<kevin.tian@intel.com>
> 
> But I doubt whether it's working as expected. According to the
> description and code, intel_pasid_tear_down_entry() is called
> twice: the 1st in the mm release path and the 2nd in the unbind
> path. PRQ draining is skipped in the former.
> 
> But intel_pasid_tear_down_entry() has a check at the beginning:
> 
> 	pte = intel_pasid_get_entry(dev, pasid);
> 	if (WARN_ON(!pte) || !pasid_pte_is_present(pte)) {
> 		spin_unlock(&iommu->lock);
> 		return;
> 	}
> 
> The 1st invocation already clears the pasid entry with FPD set.
> 
> Then the 2nd invocation will return early instead of moving to
> the point of PRQ draining.

You are right.

We need to clear the Fault Processing Disabled bit in the unbind path if
it is set and drain the PRQ. What about below code?

diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 5b7d85f1e143..45bd1b689674 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -244,11 +244,25 @@ void intel_pasid_tear_down_entry(struct 
intel_iommu *iommu, struct device *dev,

  	spin_lock(&iommu->lock);
  	pte = intel_pasid_get_entry(dev, pasid);
-	if (WARN_ON(!pte) || !pasid_pte_is_present(pte)) {
+	if (WARN_ON(!pte)) {
  		spin_unlock(&iommu->lock);
  		return;
  	}

+	if (!pasid_pte_is_present(pte)) {
+		if (!pasid_pte_is_fault_disabled(pte)) {
+			WARN_ON(READ_ONCE(pte->val[0]) != 0);
+			spin_unlock(&iommu->lock);
+			return;
+		}
+
+		pasid_clear_entry(pe);
+		spin_unlock(&iommu->lock);
+		intel_iommu_drain_pasid_prq(dev, pasid);
+
+		return;
+	}
+
  	did = pasid_get_domain_id(pte);
  	pgtt = pasid_pte_get_pgtt(pte);
  	intel_pasid_clear_entry(dev, pasid, fault_ignore);
diff --git a/drivers/iommu/intel/pasid.h b/drivers/iommu/intel/pasid.h
index 082f4fe20216..668d8ece6b14 100644
--- a/drivers/iommu/intel/pasid.h
+++ b/drivers/iommu/intel/pasid.h
@@ -73,6 +73,12 @@ static inline bool pasid_pte_is_present(struct 
pasid_entry *pte)
  	return READ_ONCE(pte->val[0]) & PASID_PTE_PRESENT;
  }

+/* Get FPD(Fault Processing Disable) bit of a PASID table entry */
+static inline bool pasid_pte_is_fault_disabled(struct pasid_entry *pte)
+{
+	return READ_ONCE(pte->val[0]) & PASID_PTE_FPD;
+}
+
  /* Get PGTT field of a PASID table entry */
  static inline u16 pasid_pte_get_pgtt(struct pasid_entry *pte)
  {

Thanks,
baolu
