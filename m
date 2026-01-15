Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C702848BE
	for <iommu@lists.linux.dev>; Thu, 15 Jan 2026 02:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768445117; cv=none; b=dMgLgzxdCcwni0Zug/QGjrvM2QqE0GbqhE32zXo013TMQo7ttH1wWbGQSLsnNKuBMyNe7+3iSovPiTi77I1QTRba9IRnG67sCcaufzmArADtLL4OyFY/BoNEH22eFos9jBmvUVBQtpeifWO02X2f7D/QhpsQpCm8dH/sgc421D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768445117; c=relaxed/simple;
	bh=OEuNYHOUzw3wHyni+D17LrNAnpZtaWcnstAKbHR3Ge0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bzliKvEFcg4zR1kmD2kq0jPLbavhGzSSHEUJIOTsOsiZRSIMsOxIod3oPj+ec/Jor3GCak4uTY+uWxoH3DHaUdGCnBtiqBlvqu6yjvfX30rGwxNgdN5DRwVUJICbemkMLmfi8PC5fkV4/usxb2Yit2BAsIJEzCSPKFP4ZssejaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BhZsis0y; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BhZsis0y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768445112; x=1799981112;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OEuNYHOUzw3wHyni+D17LrNAnpZtaWcnstAKbHR3Ge0=;
  b=BhZsis0yLAAOqNogvyQHuavn/kaSzCQBuUmWtkPMhL5FlSzXQio+6N+O
   l/VZwhRZSsHq3kV/+sX1y/NEJRVJYcAnJFNuWkFWTxY/ygU8b0qnw/YKo
   /CY3qABFHC3uma9TDW8UD1XamB3YIKaBDaVX0vHh3X0FR7H1VamWpYEha
   AkYpcHdXWAgCs9pAG/89DQUnlbT20X63VTc5opn2MWBIozonLQWtAogEa
   DjU+SvLsrcZrSlaH5lNfUO3d6c0RZ5gxeJ57/zoA6ZfY+FkwRwTIyArHO
   6XBBi1qMGfsB4arq8EWxvjAMuf3ccmSYUpESgQOAfR2JQNDqAHXvTZQQd
   A==;
X-CSE-ConnectionGUID: jkFnNVdqTOyoua9mCdgOEA==
X-CSE-MsgGUID: GNSpnFwCT0KRwDmUlNjziQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="69837793"
X-IronPort-AV: E=Sophos;i="6.21,226,1763452800"; 
   d="scan'208";a="69837793"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 18:45:10 -0800
X-CSE-ConnectionGUID: ZkRo0lG+Snmar7CP0HuOtA==
X-CSE-MsgGUID: tEt/Bu7oSGCckyDWdu2ZyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,226,1763452800"; 
   d="scan'208";a="204730275"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 18:45:07 -0800
Message-ID: <6c1888bb-83ff-4121-baef-4c3c93dcbf58@linux.intel.com>
Date: Thu, 15 Jan 2026 10:45:12 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] iommu/vt-d: Clear Present bit before tearing down
 PASID entry
To: Dmytro Maluka <dmaluka@chromium.org>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
 Aashish Sharma <aashish@aashishsharma.net>
References: <20260113030052.977366-1-baolu.lu@linux.intel.com>
 <20260113030052.977366-3-baolu.lu@linux.intel.com>
 <aWaeUJcAFQ_vbJtd@google.com>
 <8e232d7f-9436-401e-9abc-308492a1fcbf@linux.intel.com>
 <aWd6KIGBiE-nL2IT@mitya-t14-2025>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <aWd6KIGBiE-nL2IT@mitya-t14-2025>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/14/26 19:12, Dmytro Maluka wrote:
> On Wed, Jan 14, 2026 at 01:38:13PM +0800, Baolu Lu wrote:
>> On 1/14/26 03:34, Dmytro Maluka wrote:
>>> On Tue, Jan 13, 2026 at 11:00:47AM +0800, Lu Baolu wrote:
>>>> +	intel_pasid_clear_entry(iommu, dev, pasid, fault_ignore);
>>> Is it safe to do this with iommu->lock already unlocked?
>>
>> Yes, it is. The PASID entry lifecycle is serialized by the iommu_group-
>>> mutex in the iommu core, which ensures that no other thread can attempt
>> to allocate or setup this same PASID until intel_pasid_tear_down_entry()
>> has returned.
>>
>> The iommu->lock is held during the initial transition (P->0) to ensure
>> atomicity against other hardware-table walkers, but once the P bit is
>> cleared and the caches are flushed, the final zeroing of the 'dead'
>> entry does not strictly require the spinlock because the PASID remains
>> reserved in software until the function completes.
> 
> Ok. Just to understand: "other hardware-table walkers" means some
> software walkers, not hardware ones? Which software walkers are those?
> (I can't imagine how holding a spinlock could prevent the hardware from
> walking those tables. :))

You are right. A spinlock doesn't stop the hardware. The spinlock
serializes software threads to ensure the hardware walker always sees a
consistent entry.

When a PASID entry is active (P=1), other kernel paths might modify
the control bits in-place. For example:

void intel_pasid_setup_page_snoop_control(struct intel_iommu *iommu,
                                           struct device *dev, u32 pasid)
{
         struct pasid_entry *pte;
         u16 did;

         spin_lock(&iommu->lock);
         pte = intel_pasid_get_entry(dev, pasid);
         if (WARN_ON(!pte || !pasid_pte_is_present(pte))) {
                 spin_unlock(&iommu->lock);
                 return;
         }

         pasid_set_pgsnp(pte);
         did = pasid_get_domain_id(pte);
         spin_unlock(&iommu->lock);

         intel_pasid_flush_present(iommu, dev, pasid, did, pte);
}

In this case, the iommu->lock ensures that if two threads try to modify
the same active entry, they don't interfere with each other and leave
the entry in a 'torn' state for the IOMMU hardware to read.

In intel_pasid_tear_down_entry(), once the PASID entry is deactivated
(setting P=0 and flushing caches), the entry is owned exclusively  by
the teardown thread until it is re-configured. That's the reason why the
final zeroing doesn't need the spinlock.

Thanks,
baolu
