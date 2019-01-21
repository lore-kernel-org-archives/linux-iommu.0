From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH 0/3] iommu/arm-smmu: Add support to use Last level cache
Date: Mon, 21 Jan 2019 08:26:02 +0100
Message-ID: <CAKv+Gu8P-5hxZ8+OV_xSZteTvCLw-Sc-=KJM1i=3aWajcS9bUw@mail.gmail.com>
References: <20190121055335.15430-1-vivek.gautam@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190121055335.15430-1-vivek.gautam@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Vivek Gautam <vivek.gautam@codeaurora.org>
Cc: Will Deacon <will.deacon@arm.com>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org, pdaly@codeaurora.org, linux-arm-msm@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, tfiga@chromium.org, jcrouse@codeaurora.org, pratikp@codeaurora.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, 21 Jan 2019 at 06:54, Vivek Gautam <vivek.gautam@codeaurora.org> wrote:
>
> Qualcomm SoCs have an additional level of cache called as
> System cache, aka. Last level cache (LLC). This cache sits right
> before the DDR, and is tightly coupled with the memory controller.
> The clients using this cache request their slices from this
> system cache, make it active, and can then start using it.
> For these clients with smmu, to start using the system cache for
> buffers and, related page tables [1], memory attributes need to be
> set accordingly. This series add the required support.
>

Does this actually improve performance on reads from a device? The
non-cache coherent DMA routines perform an unconditional D-cache
invalidate by VA to the PoC before reading from the buffers filled by
the device, and I would expect the PoC to be defined as lying beyond
the LLC to still guarantee the architected behavior.



> This change is a realisation of following changes from downstream msm-4.9:
> iommu: io-pgtable-arm: Support DOMAIN_ATTRIBUTE_USE_UPSTREAM_HINT[2]
> iommu: io-pgtable-arm: Implement IOMMU_USE_UPSTREAM_HINT[3]
>
> Changes since v2:
>  - Split the patches into io-pgtable-arm driver and arm-smmu driver.
>  - Converted smmu domain attributes to a bitmap, so multiple attributes
>    can be managed easily.
>  - With addition of non-coherent page table mapping support [4], this
>    patch series now aligns with the understanding of upgrading the
>    non-coherent devices to use some level of outer cache.
>  - Updated the macros and comments to reflect the use of QCOM_SYS_CACHE.
>  - QCOM_SYS_CACHE can still be used at stage 2, so that doens't depend on
>    stage-1 mapping.
>  - Added change to disable the attribute from arm_smmu_domain_set_attr()
>    when needed.
>  - Removed the page protection controls for QCOM_SYS_CACHE at the DMA API
>    level.
>
> Goes on top of the non-coherent page tables support patch series [4]
>
> [1] https://patchwork.kernel.org/patch/10302791/
> [2] https://source.codeaurora.org/quic/la/kernel/msm-4.9/commit/?h=msm-4.9&id=bf762276796e79ca90014992f4d9da5593fa7d51
> [3] https://source.codeaurora.org/quic/la/kernel/msm-4.9/commit/?h=msm-4.9&id=d4c72c413ea27c43f60825193d4de9cb8ffd9602
> [4] https://lore.kernel.org/patchwork/cover/1032938/
>
> Vivek Gautam (3):
>   iommu/arm-smmu: Move to bitmap for arm_smmu_domain atrributes
>   iommu/io-pgtable-arm: Add support to use system cache
>   iommu/arm-smmu: Add support to use system cache
>
>  drivers/iommu/arm-smmu.c       | 28 ++++++++++++++++++++++++----
>  drivers/iommu/io-pgtable-arm.c | 15 +++++++++++++--
>  drivers/iommu/io-pgtable.h     |  4 ++++
>  include/linux/iommu.h          |  2 ++
>  4 files changed, 43 insertions(+), 6 deletions(-)
>
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
