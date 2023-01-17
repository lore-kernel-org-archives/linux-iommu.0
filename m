Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C255A1FB2
	for <iommu@lists.linux.dev>; Tue, 17 Jan 2023 08:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673943157; x=1705479157;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4cVsvcHZOuTyOZVcrN6WYDuJRfsdenPtfqYqTQoPctA=;
  b=K9QmwRtdLVSrnlLNGezuk0opEUkN8cRNqdx24sn8ozs8L9IY5J0e+0rN
   PStSyEJ7txbVgQPE8vQVzWS/LeMLxCIvG1NWXCmgCOxOv9t0BTPqJ4HdZ
   5cqXocc/oQBoAwprWBy45ZUB1zb++WVQzrIMNlWXX1gKunrZw/iPED3Dj
   5+tEC4Z/wp/2Y29iTLkL0YKhkJoC+lCxM6giG65I6SMjSZlwrJBZ1rtcY
   7L+1S5Y7hyGT8aTt8PPbn/gD5t5I2+nJa5LCI+5k7TlnLtrCgPJu7Oxis
   dv24UTqtMJ2pB5fe6m+qriQLEoP/KoQgQtvMPv9WivDDhuN+/9GpCMB5t
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="389138230"
X-IronPort-AV: E=Sophos;i="5.97,222,1669104000"; 
   d="scan'208";a="389138230"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 00:12:21 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="801653024"
X-IronPort-AV: E=Sophos;i="5.97,222,1669104000"; 
   d="scan'208";a="801653024"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.252.187.178]) ([10.252.187.178])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 00:12:18 -0800
Message-ID: <214ee67e-19f5-265f-63be-f8a6108d25d1@linux.intel.com>
Date: Tue, 17 Jan 2023 16:12:16 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Cc: baolu.lu@linux.intel.com
Subject: Re: [PATCH 4/7] iommu/vt-d: Add IOMMU perfmon support
To: "Liang, Kan" <kan.liang@linux.intel.com>, joro@8bytes.org,
 will@kernel.org, dwmw2@infradead.org, robin.murphy@arm.com,
 robert.moore@intel.com, rafael.j.wysocki@intel.com, lenb@kernel.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20230111202504.378258-1-kan.liang@linux.intel.com>
 <20230111202504.378258-5-kan.liang@linux.intel.com>
 <05624df9-bea1-5e95-55d6-02ac2d93c68c@linux.intel.com>
 <dd68ac33-f418-cc1a-9ce7-3cdc97282771@linux.intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <dd68ac33-f418-cc1a-9ce7-3cdc97282771@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2023/1/16 23:12, Liang, Kan wrote:
>>> +static void iommu_pmu_start(struct perf_event *event, int flags)
>>> +{
>>> +    struct iommu_pmu *iommu_pmu = iommu_event_to_pmu(event);
>>> +    struct intel_iommu *iommu = iommu_pmu->iommu;
>>> +    struct hw_perf_event *hwc = &event->hw;
>>> +    u64 count;
>>> +
>>> +    if (WARN_ON_ONCE(!(hwc->state & PERF_HES_STOPPED)))
>>> +        return;
>>> +
>>> +    if (WARN_ON_ONCE(hwc->idx < 0 || hwc->idx >= IOMMU_PMU_IDX_MAX))
>>> +        return;
>>> +
>>> +    if (flags & PERF_EF_RELOAD)
>>> +        WARN_ON_ONCE(!(event->hw.state & PERF_HES_UPTODATE));
>>> +
>>> +    hwc->state = 0;
>>> +
>>> +    /* Always reprogram the period */
>>> +    count = dmar_readq(iommu_event_base(iommu_pmu, hwc->idx));
>>> +    local64_set((&hwc->prev_count), count);
>>> +
>>> +    ecmd_submit_sync(iommu, DMA_ECMD_ENABLE, hwc->idx, false, 0);
>> What happens when emcmd_submit_sync() returns an error? How should we
>> handle this case? The same queestion to other places in this patch.
>>
> The existing perf_event subsystem doesn't handle the error, because
> other PMUs never trigger such errors. Perf usually check all the PMU
> counters once at the beginning when registering/initializing them.
> 
> For IOMMU PMU, the error will be ignored. I think it should be OK. Because
> - It's a corner case, which is very unlikely to happen.
> - The worst case is that the user will get <not count> with perf
> command, which can the user some hints.
> 
> If it's not good enough, I think we can add a WARN_ON_ONCE() here and
> everywhere for ecmd to dump the error in the dmesg.
> 
> What do you think?

No need for a WARN() here. If the hardware is stuck, there should be
warnings everywhere.

It's fine to me if you add above comments around the code.

--
Best regards,
baolu
