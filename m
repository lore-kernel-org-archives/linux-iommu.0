Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA8113C908
	for <iommu@lists.linux.dev>; Fri,  9 Oct 2026 00:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791506616; cv=none; b=LL2lfdXIFCBPFRu2oPe/1Pdnk4OVcHCfFSB0iXyKlQkgrY+Zpi+/WIPjM1y8S59qxGfVgRqdRHS7GurwQD+z4lDjrt0RJCJfDwM2rzXqOfwGCs4HTKAqSTv/4jU2WaLDm4yz48qHpLCxyOUQh6nEdLXKT/OkTw7vIchc0HAdyK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791506616; c=relaxed/simple;
	bh=spHe8RhyRKTtu92HRWECLnII7XBoQ+8StzueK5Sytk0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GqVAjq5YB15mUyRcdApPdXwUvFWVXmkuhZiJHLIi7ucRNb+yFZ9kWp/fuGpeapIPznAuSMn7e6HCO+yItdzLHV/bZWMg9K+arw3DvkFfoaMUZUsWGWhVdb4vuCEAZzhtcg9hZMDCTtq/yuYdsDXbvThWaw1VR40YA/WKNiT5CrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O2X9F/mJ; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O2X9F/mJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791506614; x=1823042614;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=spHe8RhyRKTtu92HRWECLnII7XBoQ+8StzueK5Sytk0=;
  b=O2X9F/mJh7TXnYWimfA4Btzjk4s70qrBQ5y7aFl897lhqnQ7CQSnDSEd
   KMqcqJqHjBwCRyNqDMijya/5VQsLn7YJhNxSxf+snccRSREJ9R16kDwok
   gp1GnijE3+sNKvbk/GMZ1rvZ07RLtHZra6sbK0ItMRO5k/N5JkJOyD1S2
   gU1MMlu+m0+eAji3w739toHeqgtEGp0ISbar8Vi2BiNEserqNZQ7bw8vI
   mQm8h+AHM2X2bgrYS+A2/2FQN05QjLGnl3RWeI1bK9R/SsxcjT8kHiV3N
   TYmD2EVsqMJBk0EslgLfGbJSAWCry5StXB133zhvPN6sPL5N9oTM3LxwV
   w==;
X-CSE-ConnectionGUID: O0KsS6yySMi4L6/eBgzXOA==
X-CSE-MsgGUID: wdyVst1zRjySB6x0394WCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11929"; a="312749"
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="312749"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 17:43:33 -0700
X-CSE-ConnectionGUID: Xz/PdWYaRqCUmrQekPp+uA==
X-CSE-MsgGUID: ptPKg3yUTfqf+cQlu0CM1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="282983"
Received: from blu2-desk.sh.intel.com (HELO [10.239.156.26]) ([10.239.156.26])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 17:43:29 -0700
Message-ID: <c724012c-13e1-41de-b7e3-1fb08d9b9d8c@linux.intel.com>
Date: Fri, 9 Oct 2026 08:43:26 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/18] iommu/vt-d: Clear unpreserved context entries
 during shutdown
To: Samiullah Khawaja <skhawaja@google.com>,
 David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
 Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 Pratyush Yadav <pratyush@kernel.org>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 David Matlack <dmatlack@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Pranjal Shrivastava <praan@google.com>, Vipin Sharma <vipinsh@google.com>
References: <20260921004834.2601285-1-skhawaja@google.com>
 <20260921004834.2601285-9-skhawaja@google.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260921004834.2601285-9-skhawaja@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/21/26 08:48, Samiullah Khawaja wrote:
> During normal shutdown the iommu translation is disabled. Since the root
> table is preserved during live update, it needs to be cleaned up and the
> context entries of the unpreserved devices and root entries for the
> unpreserved context tables need to be cleared.
> 
> This is required because during kexec reboot and shutdown the devices do
> not go through the release flow, so there might be stale entries in the
> root table and context tables. Also note that new unpreserved context
> tables for unpreserved devices might have been added after preservation,
> so the root table entries for unpreserved context tables also need to
> removed.
> 
> Signed-off-by: Samiullah Khawaja<skhawaja@google.com>
> ---
>   drivers/iommu/intel/iommu.c      |  15 +++-
>   drivers/iommu/intel/iommu.h      |   5 ++
>   drivers/iommu/intel/liveupdate.c | 139 +++++++++++++++++++++++++++++++
>   3 files changed, 157 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 4bfc2f173010..474c926172c5 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -1852,6 +1852,14 @@ static int iommu_suspend(void *data)
>   
>   	iommu_flush_all();
>   
> +	/*
> +	 * Note that IOMMU suspend doesn't affect live update. The state
> +	 * preserved during live update is not released and remains valid during
> +	 * suspend and reused during IOMMU resume.
> +	 *
> +	 * Also note deployment of suspend/resume and live updated use case
> +	 * should be mostly mutually exclusive.
> +	 */
>   	for_each_active_iommu(iommu, drhd) {
>   		iommu_disable_translation(iommu);
>   
> @@ -2397,8 +2405,11 @@ void intel_iommu_shutdown(void)
>   		/* Disable PMRs explicitly here. */
>   		iommu_disable_protect_mem_regions(iommu);
>   
> -		/* Make sure the IOMMUs are switched off */
> -		iommu_disable_translation(iommu);
> +		/* Make sure the IOMMUs are switched off if not preserved. */
> +		if (iommu_preserved_state(&iommu->iommu))
> +			clear_unpreserved_context_entries(iommu);
> +		else
> +			iommu_disable_translation(iommu);
>   	}
>   }
>   
> diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
> index 785057236e7c..4feb5bd76b18 100644
> --- a/drivers/iommu/intel/iommu.h
> +++ b/drivers/iommu/intel/iommu.h
> @@ -1307,6 +1307,11 @@ int intel_iommu_preserve(struct iommu_device *iommu,
>   			 struct iommu_hw_ser *iommu_ser);
>   void intel_iommu_unpreserve(struct iommu_device *iommu,
>   			    struct iommu_hw_ser *iommu_ser);
> +void clear_unpreserved_context_entries(struct intel_iommu *iommu);
> +#else
> +static inline void clear_unpreserved_context_entries(struct intel_iommu *iommu)
> +{
> +}
>   #endif
>   
>   #ifdef CONFIG_INTEL_IOMMU_SVM
> diff --git a/drivers/iommu/intel/liveupdate.c b/drivers/iommu/intel/liveupdate.c
> index 0837bb889fed..501dc0e9cc0a 100644
> --- a/drivers/iommu/intel/liveupdate.c
> +++ b/drivers/iommu/intel/liveupdate.c
> @@ -77,6 +77,145 @@ static int preserve_context_table(struct intel_iommu *iommu,
>   	return 0;
>   }
>   
> +static void clear_unpreserved_context_root_entries(struct intel_iommu *iommu,
> +						   struct iommu_hw_ser *ser)
> +{
> +	struct root_entry *root;
> +	int i;
> +
> +	/*
> +	 * Individual invalidations for each context table removal are not
> +	 * needed as we issue global invalidations later.
> +	 */
> +	for (i = 0; i < ROOT_ENTRY_NR; i++) {
> +		root = &iommu->root_entry[i];
> +
> +		if (!is_context_table_preserved(iommu, ser, i, 0) && (root->lo & 1)) {
> +			root->lo = 0;
> +			__iommu_flush_cache(iommu,
> +					    &root->lo,
> +					    sizeof(root->lo));
> +		}
> +
> +		if (!sm_supported(iommu))
> +			continue;
> +
> +		if (!is_context_table_preserved(iommu, ser, i, 0x80) && (root->hi & 1)) {
> +			root->hi = 0;
> +			__iommu_flush_cache(iommu,
> +					    &root->hi,
> +					    sizeof(root->hi));
> +		}
> +	}
> +}
> +
> +static void clear_unpreserved_context(struct device_domain_info *info, u8 bus, u8 devfn)
> +{
> +	struct context_entry *context;
> +
> +	/*
> +	 * This cleanup is done during shutdown, so it should be fine to only
> +	 * clear the entries here and issue one global invalidation later to
> +	 * invalidate all cleared entries.
> +	 *
> +	 * Note that the device IOTLB invalidation for unpreserved devices is
> +	 * skipped this way, but that should not be needed as the devices are
> +	 * quiesced at this point. This should improve the performance of the
> +	 * cleanup process and avoids any invalidation timeouts because drivers
> +	 * might have moved devices to D3 state.

I don't quite follow why device-TLB flushes could be skipped when the
device is quiesced. Nothing guarantees that an unpreserved device that
has ATS enabled doesn't carry stale cache entries. It may keep
translations to memory that the next kernel reuses.

I would suggest at least a global device-TLB flush for ATS-enabled
unpreserved devices, or is there anything I've overlooked?

> +	 *
> +	 * The iommu lock is not needed as the context tables are never removed
> +	 * and the new ones are not added during shutdown.
> +	 */
> +	context = iommu_context_addr(info->iommu, bus, devfn, 0);
> +	if (context) {
> +		/*
> +		 * Individual invalidations are not needed as we issue global
> +		 * invalidations later once all the cleanups are done.
> +		 */
> +		context_clear_present(context);
> +		__iommu_flush_cache(info->iommu, context, sizeof(*context));
> +		context_clear_entry(context);
> +		__iommu_flush_cache(info->iommu, context, sizeof(*context));
> +	}
> +}

[-snipped-]

Thanks,
baolu
