Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792462619;
	b=KA5hYsfZofb9yE/3cK7Sz3X8QxUn7dcAvMP6IXMz31EV53xwkDYsPCZuPwlARL3lba8V
	 BkNPl/jhYv2AOFA+7fhPGDH1La9ln5DPfdDHaIcw5MUJhAlnj+kvJ5KTVvytY4hNQJQgD
	 eeM9IdpS1nnfAsNPQ+qdcZ8eO0p66D+SNZBU3I37EegakNdmKIHUeQugfYURACIZ/nRB6
	 BmnvM5S3ayCNuHvDSExNk58Rzd001gMtxU9XFn0hlorph1F3SvCNCWSQ9Rs4IrOMKBD2J
	 xFB3Uup70B9snxZivyBBed9afToq5P8Al19du7jF8wPfY9cUF/LjVSYu6fXYI0HzaHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792462619;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=1pPFgpir1OWU10pzSExtICnFtJBK2lqIaHmilT4ip1I=;
	b=0FVoTDUz6KIFtnknchj88QFdSDaQ7kih5c4vsNpPLsaWUSeJRsXXAU7zOJkS/v5ztlPS
	 lwQTA76vBdDa1CLjHqnnQTrDBOz2E8/oIxl2SkPjfjrSDdmqYxlOAnHomS0SJ6Jy0KSxZ
	 wyJUNRoiS5nkXlVdsKvGykSaY44d/VwuW4A48OLv8ja9b0QbdGTbshZ7tdgCULYYZIslV
	 URk5/q+j9kWHiYn6Cb0b2+w6xlwTvdKS8IpKKvUD7tIQqS3SdmumjjZjQFtFgN8DN+8eR
	 7UOHx4t/UlckYUkJKio7Uj5UJpSucE+K2pQxssHU8gzbflarSMp7oc1tO9iEzIubQgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mNSnfc9U;
	arc=none smtp.remote-ip=198.175.65.13
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8440B606A31A
	for <iommu@lists.linux.dev>; Tue, 20 Oct 2026 02:16:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8440B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mNSnfc9U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792462618; x=1823998618;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bmz39BVigYG+Gm5UlAHsCh014l79WZqidSvSMxlrEUc=;
  b=mNSnfc9U8IYukDuYyap7grRrYuFAT2P+KUTr4nEFb2g1lwg4UOyub/qF
   lJt1WNd5bjD2cgf/Ykrud+1q79KsXNqFbcPri1NJ0cNdUVFde172CHVM0
   c/uw9d9gN5ZWf8tVyM4EC9ljViSHxkXeXRfzqhHiBxaIX9+ak+bIun803
   gX3mn0SdYk7ssLRjUeqJwp8Rqz3stc7VaeZPZgZifzqolyLZywItgUhoV
   +qR/ZyqMRfdooIF9Mwn9NqjlYBSayVcihdHYVUj5qPCBfqmdnUX5tEraE
   XTMeJUreBahzddrjfBe6vsCZZdxpSqnEup6PH0HyzvPDTBYIhJzfeOEX8
   g==;
X-CSE-ConnectionGUID: 5rVOluFET0CXnjpyKm5zVg==
X-CSE-MsgGUID: MmUBextrTceCrckdQGdz0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1039520"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1039520"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 19:16:57 -0700
X-CSE-ConnectionGUID: TDM8AGf5R/6tn3Za74ZjIA==
X-CSE-MsgGUID: 41bPApv6RQGFL0RuIyyKCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="2732749"
Received: from blu2-desk.sh.intel.com (HELO [10.239.156.26]) ([10.239.156.26])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 19:16:53 -0700
Message-ID: <0dd026cb-09e5-46a7-b88a-9b57353f0637@linux.intel.com>
Date: Tue, 20 Oct 2026 10:16:51 +0800
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/18] iommu/vt-d: Clear unpreserved context entries
 during shutdown
To: Samiullah Khawaja <skhawaja@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
 Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 Pratyush Yadav <pratyush@kernel.org>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 David Matlack <dmatlack@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Pranjal Shrivastava <praan@google.com>, Vipin Sharma <vipinsh@google.com>
References: <20260921004834.2601285-1-skhawaja@google.com>
 <20260921004834.2601285-9-skhawaja@google.com>
 <c724012c-13e1-41de-b7e3-1fb08d9b9d8c@linux.intel.com>
 <asmC5Ow_VYtvgGOQ@google.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <asmC5Ow_VYtvgGOQ@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/10/26 08:32, Samiullah Khawaja wrote:
> On Fri, Oct 09, 2026 at 08:43:26AM +0800, Baolu Lu wrote:
>> On 9/21/26 08:48, Samiullah Khawaja wrote:
>>> During normal shutdown the iommu translation is disabled. Since the root
>>> table is preserved during live update, it needs to be cleaned up and the
>>> context entries of the unpreserved devices and root entries for the
>>> unpreserved context tables need to be cleared.
>>>
>>> This is required because during kexec reboot and shutdown the devices do
>>> not go through the release flow, so there might be stale entries in the
>>> root table and context tables. Also note that new unpreserved context
>>> tables for unpreserved devices might have been added after preservation,
>>> so the root table entries for unpreserved context tables also need to
>>> removed.
>>>
>>> Signed-off-by: Samiullah Khawaja<skhawaja@google.com>
>>> ---
>>>  drivers/iommu/intel/iommu.c      |  15 +++-
>>>  drivers/iommu/intel/iommu.h      |   5 ++
>>>  drivers/iommu/intel/liveupdate.c | 139 +++++++++++++++++++++++++++++++
>>>  3 files changed, 157 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>>> index 4bfc2f173010..474c926172c5 100644
>>> --- a/drivers/iommu/intel/iommu.c
>>> +++ b/drivers/iommu/intel/iommu.c
>>> @@ -1852,6 +1852,14 @@ static int iommu_suspend(void *data)
>>>      iommu_flush_all();
>>> +    /*
>>> +     * Note that IOMMU suspend doesn't affect live update. The state
>>> +     * preserved during live update is not released and remains 
>>> valid during
>>> +     * suspend and reused during IOMMU resume.
>>> +     *
>>> +     * Also note deployment of suspend/resume and live updated use case
>>> +     * should be mostly mutually exclusive.
>>> +     */
>>>      for_each_active_iommu(iommu, drhd) {
>>>          iommu_disable_translation(iommu);
>>> @@ -2397,8 +2405,11 @@ void intel_iommu_shutdown(void)
>>>          /* Disable PMRs explicitly here. */
>>>          iommu_disable_protect_mem_regions(iommu);
>>> -        /* Make sure the IOMMUs are switched off */
>>> -        iommu_disable_translation(iommu);
>>> +        /* Make sure the IOMMUs are switched off if not preserved. */
>>> +        if (iommu_preserved_state(&iommu->iommu))
>>> +            clear_unpreserved_context_entries(iommu);
>>> +        else
>>> +            iommu_disable_translation(iommu);
>>>      }
>>>  }
>>> diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
>>> index 785057236e7c..4feb5bd76b18 100644
>>> --- a/drivers/iommu/intel/iommu.h
>>> +++ b/drivers/iommu/intel/iommu.h
>>> @@ -1307,6 +1307,11 @@ int intel_iommu_preserve(struct iommu_device 
>>> *iommu,
>>>               struct iommu_hw_ser *iommu_ser);
>>>  void intel_iommu_unpreserve(struct iommu_device *iommu,
>>>                  struct iommu_hw_ser *iommu_ser);
>>> +void clear_unpreserved_context_entries(struct intel_iommu *iommu);
>>> +#else
>>> +static inline void clear_unpreserved_context_entries(struct 
>>> intel_iommu *iommu)
>>> +{
>>> +}
>>>  #endif
>>>  #ifdef CONFIG_INTEL_IOMMU_SVM
>>> diff --git a/drivers/iommu/intel/liveupdate.c b/drivers/iommu/intel/ 
>>> liveupdate.c
>>> index 0837bb889fed..501dc0e9cc0a 100644
>>> --- a/drivers/iommu/intel/liveupdate.c
>>> +++ b/drivers/iommu/intel/liveupdate.c
>>> @@ -77,6 +77,145 @@ static int preserve_context_table(struct 
>>> intel_iommu *iommu,
>>>      return 0;
>>>  }
>>> +static void clear_unpreserved_context_root_entries(struct 
>>> intel_iommu *iommu,
>>> +                           struct iommu_hw_ser *ser)
>>> +{
>>> +    struct root_entry *root;
>>> +    int i;
>>> +
>>> +    /*
>>> +     * Individual invalidations for each context table removal are not
>>> +     * needed as we issue global invalidations later.
>>> +     */
>>> +    for (i = 0; i < ROOT_ENTRY_NR; i++) {
>>> +        root = &iommu->root_entry[i];
>>> +
>>> +        if (!is_context_table_preserved(iommu, ser, i, 0) && (root- 
>>> >lo & 1)) {
>>> +            root->lo = 0;
>>> +            __iommu_flush_cache(iommu,
>>> +                        &root->lo,
>>> +                        sizeof(root->lo));
>>> +        }
>>> +
>>> +        if (!sm_supported(iommu))
>>> +            continue;
>>> +
>>> +        if (!is_context_table_preserved(iommu, ser, i, 0x80) && 
>>> (root->hi & 1)) {
>>> +            root->hi = 0;
>>> +            __iommu_flush_cache(iommu,
>>> +                        &root->hi,
>>> +                        sizeof(root->hi));
>>> +        }
>>> +    }
>>> +}
>>> +
>>> +static void clear_unpreserved_context(struct device_domain_info 
>>> *info, u8 bus, u8 devfn)
>>> +{
>>> +    struct context_entry *context;
>>> +
>>> +    /*
>>> +     * This cleanup is done during shutdown, so it should be fine to 
>>> only
>>> +     * clear the entries here and issue one global invalidation 
>>> later to
>>> +     * invalidate all cleared entries.
>>> +     *
>>> +     * Note that the device IOTLB invalidation for unpreserved 
>>> devices is
>>> +     * skipped this way, but that should not be needed as the 
>>> devices are
>>> +     * quiesced at this point. This should improve the performance 
>>> of the
>>> +     * cleanup process and avoids any invalidation timeouts because 
>>> drivers
>>> +     * might have moved devices to D3 state.
>>
>> I don't quite follow why device-TLB flushes could be skipped when the
>> device is quiesced. Nothing guarantees that an unpreserved device that
>> has ATS enabled doesn't carry stale cache entries. It may keep
>> translations to memory that the next kernel reuses.
> 
> I agree with your assessment, the device-TLB might still have stale
> entries. But this assumption is based on the existing kexec reboot
> behaviour. That is, during normal shutdown the iommu translation is
> disabled but the device-TLB invalidations are not issued either. The
> unpreserved devices go through the same flow in the next kernel as they
> do after a normal kexec reboot. I will update the comment to add this
> detail.

I guess device-TLB invalidation is omitted during a normal kexec reboot
because the device will be reset or re-initialized during shutdown or
probe, which usually clears the ATC as a side effect. But I don't think
that's guaranteed. Anyway, this might be a pre-existing issue and not
specific to this series.

>>
>> I would suggest at least a global device-TLB flush for ATS-enabled
>> unpreserved devices, or is there anything I've overlooked?
> 
> This might be tricky as this late during shutdown some devices might
> already be in a low power state, and sending them device-TLB
> invalidations would cause invalidation timeouts. Even if that doesn't
> happen, it will still add to the shutdown time.

Okay, fair enough.

>>
>>> +     *
>>> +     * The iommu lock is not needed as the context tables are never 
>>> removed
>>> +     * and the new ones are not added during shutdown.
>>> +     */
>>> +    context = iommu_context_addr(info->iommu, bus, devfn, 0);
>>> +    if (context) {
>>> +        /*
>>> +         * Individual invalidations are not needed as we issue global
>>> +         * invalidations later once all the cleanups are done.
>>> +         */
>>> +        context_clear_present(context);
>>> +        __iommu_flush_cache(info->iommu, context, sizeof(*context));
>>> +        context_clear_entry(context);
>>> +        __iommu_flush_cache(info->iommu, context, sizeof(*context));
>>> +    }
>>> +}
>>
>> [-snipped-]
>>
>> Thanks,
>> baolu
>>
> 
> Thanks,
> Sami

Thanks,
baolu
