Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B35A65F
	for <iommu@lists.linux.dev>; Tue, 31 Jan 2023 07:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675151166; x=1706687166;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XNCQujARwuJwXRY5SFqhJMHVKPgrkRp65A0eKgK5PGw=;
  b=ljFFWFVcRmqma8txefcYbFjW3AEQ6+tdxxTExKlJO/icIFxY7LHRmyYv
   2S3v4lXAgvfqPsgtsacuTrzvRyN2h45aAV9hK1daIGvIW8Q8jPdxuY2N9
   sAMRI9OzEQR1401csOcfoDAETj1TAkacNv9aRXM+/8Y3cOg90ijDdPBfL
   B5O9rqQO/wNidP78YVe6KIpagXwfGA2Bwny9VZsfkveGhNJxF6QjrKmgU
   5wWMBtVMg+AqQmX4qaoiHtiM4rDvAB5C1aU0z425FijjGi/Npj7aXt5s0
   aUOmQxqCRAMQDN6SnwpsVWM9EaNqvcAJPj3I4ZZJqjn2yOVs6xkj7cVTm
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="315736582"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="315736582"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 23:45:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="657775506"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="657775506"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga007.jf.intel.com with ESMTP; 30 Jan 2023 23:45:51 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: kan.liang@linux.intel.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 00/12] [PULL REQUEST] Intel IOMMU updates for Linux v6.3
Date: Tue, 31 Jan 2023 15:37:28 +0800
Message-Id: <20230131073740.378984-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Joerg,

This includes patches queued for v6.3. It includes:

 - Add Intel IOMMU performance monitoring support
 - Set No Execute Enable bit in PASID table entry
 - Cleanups

The whole series is based on v6.2-rc6 and also available at:
https://github.com/LuBaolu/intel-iommu/commits/vtd-update-for-v6.3

Please pull them for x86/vt-d branch.

Best regards,
Baolu

Kan Liang (7):
  iommu/vt-d: Support size of the register set in DRHD
  iommu/vt-d: Retrieve IOMMU perfmon capability information
  iommu/vt-d: Support Enhanced Command Interface
  iommu/vt-d: Add IOMMU perfmon support
  iommu/vt-d: Support cpumask for IOMMU perfmon
  iommu/vt-d: Add IOMMU perfmon overflow handler support
  iommu/vt-d: Enable IOMMU perfmon support

Lu Baolu (5):
  iommu/vt-d: Remove include/linux/intel-svm.h
  iommu/vt-d: Remove unused fields in svm structures
  iommu/vt-d: Remove users from intel_svm_dev
  iommu/vt-d: Remove sva from intel_svm_dev
  iommu/vt-d: Set No Execute Enable bit in PASID table entry

 include/linux/cpuhotplug.h                    |   1 +
 include/linux/dmar.h                          |   1 +
 include/linux/intel-svm.h                     |  16 -
 drivers/iommu/intel/iommu.h                   | 113 ++-
 drivers/iommu/intel/perfmon.h                 |  64 ++
 include/acpi/actbl1.h                         |   2 +-
 drivers/iommu/intel/dmar.c                    |  33 +-
 drivers/iommu/intel/iommu.c                   |  60 +-
 drivers/iommu/intel/pasid.c                   |  11 +
 drivers/iommu/intel/perfmon.c                 | 877 ++++++++++++++++++
 drivers/iommu/intel/svm.c                     |  90 +-
 .../sysfs-bus-event_source-devices-iommu      |  37 +
 MAINTAINERS                                   |   1 -
 drivers/iommu/intel/Kconfig                   |  11 +
 drivers/iommu/intel/Makefile                  |   1 +
 15 files changed, 1234 insertions(+), 84 deletions(-)
 delete mode 100644 include/linux/intel-svm.h
 create mode 100644 drivers/iommu/intel/perfmon.h
 create mode 100644 drivers/iommu/intel/perfmon.c
 create mode 100644 Documentation/ABI/testing/sysfs-bus-event_source-devices-iommu

-- 
2.34.1

