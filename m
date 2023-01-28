Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0AF2570
	for <iommu@lists.linux.dev>; Sat, 28 Jan 2023 07:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674889817; x=1706425817;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Pgk2+RRbQUnCdx9LsYP+8gwo7QXNoVTuyyGXhYEw6uc=;
  b=TMTAvNoxGNYk2y8YR/KeI5gIE3RJJ9x7pMx99ejZbrNoXfFZ6ywx11XU
   c9SIJ/vN56epxzqdFHiDQbs5dW7qTrwt+8YlDbul0mMJ3LfiMgnYKbsaS
   cCgMADJTWkT7edBSFJ3ytwccKjpTv4z02t7CxWyITDAfo+5ZnxITd++Uq
   nbYh3bG54Os8FBevyIaXQnGpRavkEFGD8fy7bu3wG3699BwrAwkj3aJnl
   m5ctWlcuR7bMywJMCBfUiASHwrGyY7xpvo2++glbQrn3RLEI72rkQSiGj
   vb0XoDAnXNW+SjJeiGcHm0qhsbFVKUldezfUhaZcWfjs98c0ELf4zKK+k
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="324964356"
X-IronPort-AV: E=Sophos;i="5.97,253,1669104000"; 
   d="scan'208";a="324964356"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 23:10:16 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="806077918"
X-IronPort-AV: E=Sophos;i="5.97,253,1669104000"; 
   d="scan'208";a="806077918"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.252.186.212]) ([10.252.186.212])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 23:10:12 -0800
Message-ID: <723f8070-1f03-dcab-4592-bceaf9cbdf07@linux.intel.com>
Date: Sat, 28 Jan 2023 15:10:09 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Cc: baolu.lu@linux.intel.com, yu-cheng.yu@intel.com
Subject: Re: [PATCH V3 0/7] iommu/vt-d: Support performance monitoring for
 IOMMU
Content-Language: en-US
To: kan.liang@linux.intel.com, joro@8bytes.org, will@kernel.org,
 dwmw2@infradead.org, robin.murphy@arm.com, robert.moore@intel.com,
 rafael.j.wysocki@intel.com, lenb@kernel.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20230120165408.500511-1-kan.liang@linux.intel.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230120165408.500511-1-kan.liang@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/1/21 0:54, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> Changes since V2:
> - Move ecmd_submit_sync() to iommu.c to avoid #ifdef CONFIG_INTEL_IOMMU
> 
> Changes since V1:
> - The cap and ecap registers are always in the first page. It's not
>    necessary to use the reg size in dmar_validate_one_drhd(). (Patch 1)
> - Move reg_size up and pair it with reg_base_addr in struct
>    dmar_drhd_unit (Patch 1)
> - Update the year of Copyright (Patch 2)
> - Return 0 if PMS is not supported (Patch 2)
> - Refine the comments and add a pr_warn for per-counter capabilities
>    check (Patch 2)
> - Remove unnecessary iommu_pmu->num_cntr = i (Patch 2)
> - Remove has_ob of ecmd_submit_sync() (Patch 3)
> - Remove the helpers from non-INTEL_IOMMU. (Patch 3)
> - Still keep #ifdef CONFIG_INTEL_IOMMU for ecmd_submit_sync() to
>    avoid compile warning with non-INTEL_IOMMU config.
> - Use pr_warn_once() to replace WARN_ONCE() (Patch 4 & 6)
> - Free iommu PMU if it fails to be registered. (Patch 4)
> - Remove unnecessary 'handled' variable. (Patch 6)
> 
> A performance monitoring infrastructure, perfmon, is introduced with
> the VT-d Spec 4.0. The purpose of perfmon is to support collection of
> information about key events occurring during operation of the remapping
> hardware, to aid performance tuning and debug. The patch series is to
> support the perfmon for IOMMU.
> 
> To facilitate the perfmon support, the patch series also supports two
> new generic features of VT-d Spec 4.0.
> - Support the 'size' field to retrieve the accurate size of the register
>    set for each dmar device from DRHD. (Patch 1)
> - Support the new Enhanced Command Interface. (Patch 3)
> 
> With the patch series, users can collect the performance data of IOMMU
> via Linux perf tool. For example,
> 
>   $ perf stat -e dmar0/iommu_requests,filter_ats=0/ -a sleep 1
> 
>   Performance counter stats for 'system wide':
> 
>                2135      dmar0/iommu_requests,filter_ats=0/
> 
>         1.001087695 seconds time elapsed
> 
> The IOMMU PMUs can be found under /sys/bus/event_source/devices/dmar*
> 
> The available filters and event format can be found at the format folder
>   $ ls /sys/bus/event_source/devices/dmar0/format/
> event  event_group  filter_ats  filter_page_table
> 
> The supported events can be found at the events folder
> 
>   $ ls /sys/bus/event_source/devices/dmar0/events/
> ats_blocked        int_cache_hit_nonposted  iommu_mrds
> pasid_cache_lookup
> ctxt_cache_hit     int_cache_hit_posted     iommu_requests
> pg_req_posted
> ctxt_cache_lookup  int_cache_lookup         iotlb_hit
> pw_occupancy
> fs_nonleaf_hit     iommu_clocks             iotlb_lookup
> ss_nonleaf_hit
> fs_nonleaf_lookup  iommu_mem_blocked        pasid_cache_hit
> ss_nonleaf_lookup
> 
> Kan Liang (7):
>    iommu/vt-d: Support size of the register set in DRHD
>    iommu/vt-d: Retrieve IOMMU perfmon capability information
>    iommu/vt-d: Support Enhanced Command Interface
>    iommu/vt-d: Add IOMMU perfmon support
>    iommu/vt-d: Support cpumask for IOMMU perfmon
>    iommu/vt-d: Add IOMMU perfmon overflow handler support
>    iommu/vt-d: Enable IOMMU perfmon support
> 
>   .../sysfs-bus-event_source-devices-iommu      |  32 +
>   drivers/iommu/intel/Kconfig                   |   9 +
>   drivers/iommu/intel/Makefile                  |   1 +
>   drivers/iommu/intel/dmar.c                    |  33 +-
>   drivers/iommu/intel/iommu.c                   |  59 ++
>   drivers/iommu/intel/iommu.h                   | 101 +-
>   drivers/iommu/intel/perfmon.c                 | 860 ++++++++++++++++++
>   drivers/iommu/intel/perfmon.h                 |  65 ++
>   drivers/iommu/intel/svm.c                     |   2 +-
>   include/acpi/actbl1.h                         |   2 +-
>   include/linux/cpuhotplug.h                    |   1 +
>   include/linux/dmar.h                          |   1 +
>   12 files changed, 1159 insertions(+), 7 deletions(-)
>   create mode 100644 Documentation/ABI/testing/sysfs-bus-event_source-devices-iommu
>   create mode 100644 drivers/iommu/intel/perfmon.c
>   create mode 100644 drivers/iommu/intel/perfmon.h

Thanks for the work. The overall looks good to me now. But I am still
seeing some code style issues after running "./scripts/checkpatch.pl
--strict" scripts.

Can you please fix those issues and post a v4?

Best regards,
baolu

