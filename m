From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH 3/3] iommu/amd: Add support for IOMMU XT mode
Date: Sat, 23 Jun 2018 12:01:04 +0800
Message-ID: <201806231014.Os3JIL8Q%fengguang.wu@intel.com>
References: <1529686927-7665-4-git-send-email-suravee.suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1529686927-7665-4-git-send-email-suravee.suthikulpanit@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: kbuild-all@01.org, iommu@lists.linux-foundation.org, x86@kernel.org, linux-kernel@vger.kernel.org, joro@8bytes.org, jroedel@suse.de, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
List-Id: iommu@lists.linux-foundation.org

Hi Suravee,

I love your patch! Perhaps something to improve:

[auto build test WARNING on iommu/next]
[also build test WARNING on v4.18-rc1 next-20180622]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Suravee-Suthikulpanit/iommu-amd-Enable-x2APIC-support/20180623-032902
base:   https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git next
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
