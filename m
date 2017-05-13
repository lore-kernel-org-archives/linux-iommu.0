From: Geetha Akula <geethasowjanya.akula@gmail.com>
Subject: Re: [v6 1/3] ACPI/IORT: Fixup SMMUv3 resource size for Cavium
 ThunderX2 SMMUv3 model
Date: Sat, 13 May 2017 08:48:32 +0530
Message-ID: <CANHdaibjLJHB2KTEjheBDVY3k_dQw8HsiCObTesg5k2ynn3ZZQ@mail.gmail.com>
References: <1494592866-14076-2-git-send-email-gakula@caviumnetworks.com> <201705130808.K3USl83S%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <201705130808.K3USl83S%fengguang.wu@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: kbuild test robot <lkp@intel.com>
Cc: Geetha sowjanya <gakula@caviumnetworks.com>, kbuild-all@01.org, Will Deacon <will.deacon@arm.com>, Robin Murphy <robin.murphy@arm.com>, lorenzo.pieralisi@arm.com, Hanjun Guo <hanjun.guo@linaro.org>, sudeep.holla@arm.com, iommu@lists.linux-foundation.org, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, jcm@redhat.com, linux-kernel@vger.kernel.org, Robert Richter <robert.richter@cavium.com>, catalin.marinas@arm.com, Sunil Goutham <sgoutham@cavium.com>, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, devel@acpica.org, Linu Cherian <linu.cherian@cavium.com>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, Geetha Sowjanya <geethasowjanya.akula@cavium.com>
List-Id: iommu@lists.linux-foundation.org

On Sat, May 13, 2017 at 6:03 AM, kbuild test robot <lkp@intel.com> wrote:
> Hi Linu,
>
> [auto build test ERROR on arm64/for-next/core]
> [also build test ERROR on v4.11 next-20170512]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Geetha-sowjanya/Cavium-ThunderX2-SMMUv3-errata-workarounds/20170513-065956
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
> config: arm64-defconfig (attached as .config)
> compiler: aarch64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
> reproduce:
>         wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=arm64
>
> All errors (new ones prefixed by >>):
>
>    drivers/acpi/arm64/iort.c: In function 'arm_smmu_v3_init_resources':
>>> drivers/acpi/arm64/iort.c:777:21: error: 'ACPI_IORT_SMMU_CAVIUM_CN99XX' undeclared (first use in this function)
>      if (smmu->model == ACPI_IORT_SMMU_CAVIUM_CN99XX)
>                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    drivers/acpi/arm64/iort.c:777:21: note: each undeclared identifier is reported only once for each function it appears in
>
> vim +/ACPI_IORT_SMMU_CAVIUM_CN99XX +777 drivers/acpi/arm64/iort.c
>
>    771          smmu = (struct acpi_iort_smmu_v3 *)node->node_data;
>    772
>    773          /*
>    774           * Override the size, for Cavium ThunderX2 implementation
>    775           * which doesn't support the page 1 SMMU register space.
>    776           */
>  > 777          if (smmu->model == ACPI_IORT_SMMU_CAVIUM_CN99XX)
>    778                  size = SZ_64K;
>    779
>    780          res[num_res].start = smmu->base_address;
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

As menctioned in cover letter this patchset is based on Robin' s latest
patch "Update SMMU models for IORT rev. C" .
     https://www.spinics.net/lists/arm-kernel/msg580728.html



Thank you,
Geetha.
