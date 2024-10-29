Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C93201008
	for <iommu@lists.linux.dev>; Tue, 29 Oct 2024 03:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730171577; cv=none; b=TquSzvzQOmJbSjqqHhXiSQnXISXUeXE2bXNT/1UBJlql3BPKkweN+Nlf8T2ueXdRC1daK2vcMi199LiiEyAMMP2aLkyoaaPz4MAScETrMdMBpsRXYAtx/0M0xu1lhBPCYuGJQ/fFjDzbDCVzBNkFlUAjlW3FweGlAr4SUJ3kzQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730171577; c=relaxed/simple;
	bh=P/q0dCIABZapq4WLCK27WtlgxtAD5kVNeAPyCweWUas=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rpwS3IaiB6wtcfAxNEbbDFAQIqxwUZx6e3X+Ahm3Cb2Trns5y2bje8SnmwnYwW8f4eoqj7Tn0A14mK3bKPRvYEDpTJO0fjhWnywII6LpTBAInnNjIiqW65+BDdwr9aRafLhHFPxZ+JDeVSVWgV/nGpJgT5A3isB8AgaLiqftjzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hGy2LS36; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hGy2LS36"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730171575; x=1761707575;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=P/q0dCIABZapq4WLCK27WtlgxtAD5kVNeAPyCweWUas=;
  b=hGy2LS36Tz5B1IopXO078BGS9H81Lva6h5XzYoxiEFQQneUK8SbjV5BX
   4Bm7iWmf/tZ06cm5ouuPaYNA7lFMaA1l1ZU5eyxTI/RmpjBKjQJftxbWy
   IXimp03hAvhi8J/PQUKMPZ9yRN2XubNTRplDNhRc7XG8UMKlbji+YZBRg
   hNq4b78/A85WntfP5JEBsEsJEvjQS+JHNByza4N/kwfnt7fZugFD4Y4lj
   88tsWypsax1viiXvgHKvnRqWXiBkQAGS6z30UGowpnJ2aLPJr3LPrSKyY
   k3S29WiHlGbLuHoLxxyWe5K63VAtepOoSvE+w5C7fv7ArUSxoag+IN+hV
   A==;
X-CSE-ConnectionGUID: KwOnFiDgTYO57HBccoyHUw==
X-CSE-MsgGUID: m1f7/XciRxuL8fd/u6G/Gg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="33487890"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="33487890"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 20:12:54 -0700
X-CSE-ConnectionGUID: elxMJ+E8RaCrmc2Cexcz3Q==
X-CSE-MsgGUID: CZbv/3tPSYq0EIKaZFpN6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,240,1725346800"; 
   d="scan'208";a="86423589"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.238.0.51]) ([10.238.0.51])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 20:12:51 -0700
Message-ID: <bbd95589-f4c9-4dcf-939b-c3c407eeed21@linux.intel.com>
Date: Tue, 29 Oct 2024 11:12:49 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, David Woodhouse <dwmw2@infradead.org>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Kevin Tian <kevin.tian@intel.com>, Klaus Jensen <its@irrelevant.dk>,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 Klaus Jensen <k.jensen@samsung.com>
Subject: Re: [PATCH v4 2/5] iommu/vt-d: Remove the pasid present check in
 prq_event_thread
To: Joel Granados <joel.granados@kernel.org>, Yi Liu <yi.l.liu@intel.com>
References: <20241015-jag-iopfv8-v4-0-b696ca89ba29@kernel.org>
 <20241015-jag-iopfv8-v4-2-b696ca89ba29@kernel.org>
 <90c772ce-6d2d-4a1d-bfec-5a7813be43e4@intel.com>
 <ujexsgcpvcjux2ugfes6mzjxl53j3icarfbu25imhzliqskyv6@l7f42nv4fhmy>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <ujexsgcpvcjux2ugfes6mzjxl53j3icarfbu25imhzliqskyv6@l7f42nv4fhmy>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/10/28 18:24, Joel Granados wrote:
> On Mon, Oct 28, 2024 at 03:50:46PM +0800, Yi Liu wrote:
>> On 2024/10/16 05:08, Joel Granados wrote:
>>> From: Klaus Jensen<k.jensen@samsung.com>
>>>
>>> PASID is not strictly needed when handling a PRQ event; remove the check
>>> for the pasid present bit in the request. This change was not included
>>> in the creation of prq.c to emphasize the change in capability checks
>>> when handing PRQ events.
>>>
>>> Signed-off-by: Klaus Jensen<k.jensen@samsung.com>
>>> Reviewed-by: Kevin Tian<kevin.tian@intel.com>
>>> Signed-off-by: Joel Granados<joel.granados@kernel.org>
>> looks like the PRQ draining is missed for the PRI usage. When a pasid
>> entry is destroyed, it might need to add helper similar to the
>> intel_drain_pasid_prq() to drain PRQ for the non-pasid usage.
> These types of user space PRIs (non-pasid, non-svm) are created by
> making use of iommufd_hwpt_replace_device. Which adds an entry to the
> pasid_array indexed on IOMMU_NO_PASID (0U) via the following path:
> 
> iommufd_hwpt_replace_device
>    -> iommufd_fault_domain_repalce_dev
>      -> __fault_domain_replace_dev
>        -> iommu_replace_group_handle
            -> __iommu_group_set_domain
              -> intel_iommu_attach_device
                 -> device_block_translation
                   -> intel_pasid_tear_down_entry(IOMMU_NO_PASID)

Here a domain is removed from the pasid entry, hence we need to flush
all page requests that are pending in the IOMMU page request queue or
the PCI fabric.

>          -> xa_reserve(&group->pasid_array, IOMMU_NO_PASID, GFP_KERNEL);
> 
> It is my understanding that this will provide the needed relation
> between the device and the prq in such a way that when  remove_dev_pasid
> is called, intel_iommu_drain_pasid_prq will be called with the
> appropriate pasid value set to IOMMU_NO_PASID. Please correct me if I'm
> mistaken.

Removing a domain from a RID and a PASID are different paths.
Previously, this IOMMU driver only supported page requests on PASID
(non-IOMMU_NO_PASID). It is acceptable that it does not flush the PRQ in
the domain-removing RID path.

With the changes made in this series, the driver now supports page
requests for RID. It should also flush the PRQ when removing a domain
from a PASID entry for IOMMU_NO_PASID.

> 
> Does this answer your question? Do you have a specific path that you are
> looking at where a specific non-pasid drain is needed?

Perhaps we can simply add below change.

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index e860bc9439a2..a24a42649621 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4283,7 +4283,6 @@ static void intel_iommu_remove_dev_pasid(struct 
device *dev, ioasid_t pasid,
         intel_iommu_debugfs_remove_dev_pasid(dev_pasid);
         kfree(dev_pasid);
         intel_pasid_tear_down_entry(iommu, dev, pasid, false);
-       intel_drain_pasid_prq(dev, pasid);
  }

  static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 2e5fa0a23299..8639f3eb4264 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -265,6 +265,7 @@ void intel_pasid_tear_down_entry(struct intel_iommu 
*iommu, struct device *dev,
                 iommu->flush.flush_iotlb(iommu, did, 0, 0, 
DMA_TLB_DSI_FLUSH);

         devtlb_invalidation_with_pasid(iommu, dev, pasid);
+       intel_drain_pasid_prq(dev, pasid);
  }

  /*
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 078d1e32a24e..ff88f31053d1 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -304,9 +304,6 @@ void intel_drain_pasid_prq(struct device *dev, u32 
pasid)
         int qdep;

         info = dev_iommu_priv_get(dev);
-       if (WARN_ON(!info || !dev_is_pci(dev)))
-               return;
-
         if (!info->pri_enabled)
                 return;

Generally, intel_drain_pasid_prq() should be called if

- a translation is removed from a pasid entry; and
- PRI on this device is enabled.

Thought?

--
baolu
