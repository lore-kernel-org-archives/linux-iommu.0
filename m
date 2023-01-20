Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5686520FD
	for <iommu@lists.linux.dev>; Fri, 20 Jan 2023 16:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674233688; x=1705769688;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=L5adZLDfpzZ5TjZGsFBthPz0tUNZi5rcH/sfXtmD1yM=;
  b=bF39oWarPEO5goET8kysBBXhFsQeL8/gxgXcRoQIv358N0p0E78bG6vw
   tCXyIhudgKeoPx4bl9IeirU7Ob9zzc5PxA0RFj0V3RqSDRYXM6xafTnmy
   DU5cMMpOaCxi5JSBqcqlWvHFsuoU6J7mr9giHjWHRr1ehe379pnKmSuul
   YT2OoJCdQvXtsuGmNs7AxKSfaA7/bgV8dP1P3iYGnGPq92aOjOx0Y3fqb
   GDnIlEjs0BodEAKUyWSL1QpUmU1NkIs+xdlVdtVjBGxVYM+BndfYCvCfe
   R8+EIBIh6I346kBWWdftfB90Xq21gOnt8tfAC+zeT8Wk32CklwqylphqJ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="324315176"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="324315176"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 08:54:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="638207825"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="638207825"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orsmga006.jf.intel.com with ESMTP; 20 Jan 2023 08:54:45 -0800
From: kan.liang@linux.intel.com
To: joro@8bytes.org,
	will@kernel.org,
	baolu.lu@linux.intel.com,
	dwmw2@infradead.org,
	robin.murphy@arm.com,
	robert.moore@intel.com,
	rafael.j.wysocki@intel.com,
	lenb@kernel.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: yu-cheng.yu@intel.com,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V3 0/7] iommu/vt-d: Support performance monitoring for IOMMU
Date: Fri, 20 Jan 2023 08:54:01 -0800
Message-Id: <20230120165408.500511-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

Changes since V2:
- Move ecmd_submit_sync() to iommu.c to avoid #ifdef CONFIG_INTEL_IOMMU

Changes since V1:
- The cap and ecap registers are always in the first page. It's not
  necessary to use the reg size in dmar_validate_one_drhd(). (Patch 1)
- Move reg_size up and pair it with reg_base_addr in struct
  dmar_drhd_unit (Patch 1)
- Update the year of Copyright (Patch 2)
- Return 0 if PMS is not supported (Patch 2)
- Refine the comments and add a pr_warn for per-counter capabilities
  check (Patch 2)
- Remove unnecessary iommu_pmu->num_cntr = i (Patch 2)
- Remove has_ob of ecmd_submit_sync() (Patch 3)
- Remove the helpers from non-INTEL_IOMMU. (Patch 3)
- Still keep #ifdef CONFIG_INTEL_IOMMU for ecmd_submit_sync() to
  avoid compile warning with non-INTEL_IOMMU config.
- Use pr_warn_once() to replace WARN_ONCE() (Patch 4 & 6)
- Free iommu PMU if it fails to be registered. (Patch 4)
- Remove unnecessary 'handled' variable. (Patch 6)

A performance monitoring infrastructure, perfmon, is introduced with
the VT-d Spec 4.0. The purpose of perfmon is to support collection of
information about key events occurring during operation of the remapping
hardware, to aid performance tuning and debug. The patch series is to
support the perfmon for IOMMU.

To facilitate the perfmon support, the patch series also supports two
new generic features of VT-d Spec 4.0.
- Support the 'size' field to retrieve the accurate size of the register
  set for each dmar device from DRHD. (Patch 1)
- Support the new Enhanced Command Interface. (Patch 3)

With the patch series, users can collect the performance data of IOMMU
via Linux perf tool. For example,

 $ perf stat -e dmar0/iommu_requests,filter_ats=0/ -a sleep 1

 Performance counter stats for 'system wide':

              2135      dmar0/iommu_requests,filter_ats=0/

       1.001087695 seconds time elapsed

The IOMMU PMUs can be found under /sys/bus/event_source/devices/dmar*

The available filters and event format can be found at the format folder
 $ ls /sys/bus/event_source/devices/dmar0/format/
event  event_group  filter_ats  filter_page_table

The supported events can be found at the events folder

 $ ls /sys/bus/event_source/devices/dmar0/events/
ats_blocked        int_cache_hit_nonposted  iommu_mrds
pasid_cache_lookup
ctxt_cache_hit     int_cache_hit_posted     iommu_requests
pg_req_posted
ctxt_cache_lookup  int_cache_lookup         iotlb_hit
pw_occupancy
fs_nonleaf_hit     iommu_clocks             iotlb_lookup
ss_nonleaf_hit
fs_nonleaf_lookup  iommu_mem_blocked        pasid_cache_hit
ss_nonleaf_lookup

Kan Liang (7):
  iommu/vt-d: Support size of the register set in DRHD
  iommu/vt-d: Retrieve IOMMU perfmon capability information
  iommu/vt-d: Support Enhanced Command Interface
  iommu/vt-d: Add IOMMU perfmon support
  iommu/vt-d: Support cpumask for IOMMU perfmon
  iommu/vt-d: Add IOMMU perfmon overflow handler support
  iommu/vt-d: Enable IOMMU perfmon support

 .../sysfs-bus-event_source-devices-iommu      |  32 +
 drivers/iommu/intel/Kconfig                   |   9 +
 drivers/iommu/intel/Makefile                  |   1 +
 drivers/iommu/intel/dmar.c                    |  33 +-
 drivers/iommu/intel/iommu.c                   |  59 ++
 drivers/iommu/intel/iommu.h                   | 101 +-
 drivers/iommu/intel/perfmon.c                 | 860 ++++++++++++++++++
 drivers/iommu/intel/perfmon.h                 |  65 ++
 drivers/iommu/intel/svm.c                     |   2 +-
 include/acpi/actbl1.h                         |   2 +-
 include/linux/cpuhotplug.h                    |   1 +
 include/linux/dmar.h                          |   1 +
 12 files changed, 1159 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-event_source-devices-iommu
 create mode 100644 drivers/iommu/intel/perfmon.c
 create mode 100644 drivers/iommu/intel/perfmon.h

-- 
2.35.1

