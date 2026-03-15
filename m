Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A5923B638
	for <iommu@lists.linux.dev>; Sun, 15 Mar 2026 08:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773562357; cv=none; b=EJuJeP30vcOiIizcizaVHKfX99j/SM3FbJHI02Ym9L0HyZ6hPAxJOvvDGmiMD64HKtwPqQU1GtvblMMKuECku6BV54vahzewr2/Ody3Inw/dY7cIdkarlpjv7gW7bZpBg7g/pEs3G2zqaKTRMmqfKQmf4MAfcxhXC4+TQhd9qhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773562357; c=relaxed/simple;
	bh=WOGa+JBsg7DDNyPyTXGhW7Us7QFxbkUGdrt1Cwr7864=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R/Eue6WSa5oIjHHxP2H9VzU+9OC2Jz6iptzcdPeMgi9FdzEiFFZDXDNKrvDs8hWfhuBoh3lVebczWVl+9bbrC6xjPHvI9eTNeNiJZwZcyDXQaDj7LQ1ANHFPQ8Ma9vPS9d0KUlTULS3c5tnz7oQjcXkUm2WG5ef0PuPrqah0DAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LnfouWoV; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LnfouWoV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773562356; x=1805098356;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WOGa+JBsg7DDNyPyTXGhW7Us7QFxbkUGdrt1Cwr7864=;
  b=LnfouWoVu1jk1pfSepDwWexWSi2cCjlLY8sRTlJ8hzmq3/fKLW1WxGBd
   7bzec31EICcXFBSKTFkvJAbWyX0sRSDQUJb+fZ16MPVJn+VnXEwhd7qW0
   wEYLJ3ND/++5AfhDl9DDnH1mOSBeDQF8jcwV6inXGr4A5p18oe1feddQ1
   PUeEXFjGnn2WEDsq5mxK65S4L0VsAxH363my0OuCR3nLuJbUfa+jmjrbw
   89mVdVrid6Sr67sUZe0oHNK7G2wHkPkqz6uiJVbDlR+iwPfnKKUgfwc1H
   LscHT2no/ZQBNxde85cGfUxTSW8VjbOqwtatJ7z25/4sOE8I4d6M2H9p3
   g==;
X-CSE-ConnectionGUID: 3O5DhztpT3+y4XUZic+Y8A==
X-CSE-MsgGUID: M2n4O2OdR7GZnfIvm9q0zg==
X-IronPort-AV: E=McAfee;i="6800,10657,11729"; a="62175520"
X-IronPort-AV: E=Sophos;i="6.23,119,1770624000"; 
   d="scan'208";a="62175520"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2026 01:12:35 -0700
X-CSE-ConnectionGUID: 5ZL6Rq5mTQ2PbMyniYt0QQ==
X-CSE-MsgGUID: RqCIhMqYSpyRRCa0j26rvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,119,1770624000"; 
   d="scan'208";a="259486973"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2026 01:12:33 -0700
Message-ID: <5c7503bd-e9e8-41b8-b275-3317912cc83c@linux.intel.com>
Date: Sun, 15 Mar 2026 16:11:36 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] iommu/vt-d: Add entry_sync support for PASID entry
 updates
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
 Dmytro Maluka <dmaluka@chromium.org>, Samiullah Khawaja
 <skhawaja@google.com>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260309060648.276762-1-baolu.lu@linux.intel.com>
 <20260309060648.276762-3-baolu.lu@linux.intel.com>
 <20260309134116.GE3717316@nvidia.com>
 <4fbe6dcf-1105-4efc-b755-81a5bfb74090@linux.intel.com>
 <20260312114438.GG1448102@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260312114438.GG1448102@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/12/26 19:44, Jason Gunthorpe wrote:
> On Thu, Mar 12, 2026 at 03:50:03PM +0800, Baolu Lu wrote:
>> If I understand your remark correctly, the driver should only need the
>> following in the sync callback:
>>
>> - clflush (if non-coherent) to ensure the entry is in physical memory.
>> - PASID cache invalidation to force the hardware to re-read the entry.
> 
> Yes
> 
>> - Device-TLB invalidation to drop local device caches.
> 
> I have prefered to keep this outside the entry_set system since it has
> nothing to do with updating the context entry.
> 
> There should be only one ATS flush after the new entry is installed.

Okay, I will move the devtlb_invalidation_with_pasid() calls outside of
the entry_sync system, right after the call to the writer returns.

> 
>>> ATC invalidations should always be done after the PASID entry is
>>> written. During a hitless update both translations are unpredictably
>>> combined, this is unavoidable and OK.
>>
>> The VT-d spec (Sections 6.5.2.5 and 6.5.2.6) explicitly mandates that an
>> IOTLB invalidation must precede the Device-TLB invalidation. If we only
>> do the device-TLB invalidation in the sync callback, we risk the device
>> re-fetching a stale translation from the IOMMU's internal IOTLB.
> 
> It is a little weird that is says that, that is worth checking into.
> 
> The other text is clear that the IOTLB is cached by DID,PASID only, so
> if the new PASID entry has a DID,PASID which is already coherent in
> the IOTLB it should not need any IOTLB flushing.
> 
> ie flushing the PASID table should immediately change any ATC fetches
> from using DID,old_PASID to DID,new_PASID.
> 
> If there is some issue where the PASID flush doesn't fence everything
> (ie an ATC fetch of DID,old_PASID can be passed by an ATC invalidation)
> then you may need IOTLB invalidations not to manage coherence but to
> manage ordering. That is an important detail if true.

On Intel hardware, the PASID-cache and IOTLB are not inclusive. A PASID-
cache invalidation forces a re-fetch of the pasid entry, but it does not
automatically purge downstream IOTLB entries. The spec-mandated IOTLB
flush serves as a synchronization barrier to ensure that in-flight
translation requests are drained and the internal IOMMU state is
consistent before the invalidation request is sent over PCIe to the
device's ATC.

Without this "IOTLB -> Wait Descriptor -> ATC" sequence, there is a risk
that the device re-populates its ATC from a stale entry still residing
in the IOMMU's internal IOTLB, even after the PASID entry itself has
been updated.

Thanks,
baolu
