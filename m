From: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: Parental Leave and IOMMU Maintenance
Date: Thu, 26 Oct 2017 00:10:43 +0200
Message-ID: <20171026001028.4d54ec4b@t450s.home>
References: <20171022130604.343fqhqb6ca4g3vj@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171022130604.343fqhqb6ca4g3vj@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, Will Deacon <will.deacon@arm.com>, Robin Murphy <robin.murphy@arm.com>
List-Id: iommu@lists.linux-foundation.org

On Sun, 22 Oct 2017 15:06:05 +0200
Joerg Roedel <joro@8bytes.org> wrote:

> Hi,
> 
> after the birth of my second son last week I am taking a parental leave
> until the end of the year. During this time Alex Williamson will take
> over the maintenance of the IOMMU-code in the Linux kernel.
> 
> I will be back in January 2018. Until then please send all iommu patches
> and fixes to Alex. He will review them and decide what is ready to go
> upstream. And don't send anything to him that you wouldn't send me ;)
> 
> Bye bye and see you all next year!

On that note, I've just updated my next branch[1] to include the
patches below.  This is Joerg's last merge to his next branch:

a593472591a5 Merge branches 'iommu/fixes', 'arm/omap', 'arm/exynos', 'x86/amd', 'x86/vt-d' and 'core' into next

Will's pull request:

18b0f1ccdb82 Merge branch 'for-joerg/arm-smmu/updates' of git://git.kernel.org/pub/scm/linux/kernel/git/will/linux into iommu/arm/smmu

Plus a few iommu and vfio patches that I've pulled from the list since
those.  I'm making more of an effort to use branches than I do for just
vfio such that I can keep things separated for Joerg's return and
provide separate pull requests to Linus for vfio and iommu with a
minimum of sha1 breakage.  I'd ask the other sub-maintainers and
contributors to be extra proactive in providing reviews and pointing
out patches that I'm missing while Joerg is away.  I appreciate any
help in making this as smooth as possible for everyone.  Thanks,

Alex

--

Alex Williamson (6):
      vfio/pci: Virtualize Maximum Payload Size
      vfio/pci: Virtualize Maximum Read Request Size
      Merge branch 'next' of git://git.kernel.org/.../joro/iommu into iommu/next
      Merge branch 'for-joerg/arm-smmu/updates' of git://git.kernel.org/.../will/linux into iommu/arm/smmu
      iommu/amd: Fix alloc_irq_index() increment
      Merge branches 'vfio/fixes', 'vfio/platform', 'iommu/arm/smmu' and 'iommu/updates' into next-20171025

Alexey Kardashevskiy (1):
      vfio/spapr: Add cond_resched() for huge updates

Anup Patel (1):
      vfio: platform: reset: Add Broadcom FlexRM reset module

Bhumika Goyal (1):
      vfio-mdev/samples: make mdev_fops const and static

Christos Gkekas (1):
      iommu/vt-d: Delete unnecessary check in domain_context_mapping_one()

Colin Ian King (1):
      iommu/amd: remove unused variable flush_addr

Dan Carpenter (1):
      vfio/type1: silence integer overflow warning

Feng Kan (1):
      iommu/arm-smmu: Enable bypass transaction caching for ARM SMMU 500

Joerg Roedel (4):
      iommu/vt-d: Don't register bus-notifier under dmar_global_lock
      iommu/amd: Add align parameter to alloc_irq_index()
      iommu/amd: Enforce alignment for MSI IRQs
      Merge branches 'iommu/fixes', 'arm/omap', 'arm/exynos', 'x86/amd', 'x86/vt-d' and 'core' into next

Marek Szyprowski (1):
      iommu/exynos: Rework runtime PM links management

Robin Murphy (15):
      iommu/iova: Extend rbtree node caching
      iommu/iova: Add rbtree anchor node
      iommu/iova: Simplify cached node logic
      iommu/iova: Simplify domain destruction
      iommu/iova: Make rcache limit_pfn handling more robust
      iommu/iova: Try harder to allocate from rcache magazine
      iommu/iova: Don't try to copy anchor nodes
      iommu/io-pgtable-arm: Convert to IOMMU API TLB sync
      iommu/io-pgtable-arm-v7s: Convert to IOMMU API TLB sync
      iommu/arm-smmu: Remove ACPICA workarounds
      iommu/arm-smmu-v3: Correct COHACC override message
      iommu/arm-smmu-v3: Specialise CMD_SYNC handling
      iommu/arm-smmu-v3: Forget about cmdq-sync interrupt
      iommu/arm-smmu-v3: Use CMD_SYNC completion MSI
      iommu/arm-smmu-v3: Use burst-polling for sync completion

Suman Anna (2):
      iommu/omap: Change the attach detection logic
      iommu/omap: Add support to program multiple iommus

Tomasz Nowicki (1):
      iommu/iova: Make rcache flush optional on IOVA allocation failure

Will Deacon (3):
      iommu/arm-smmu-v3: Ensure we sync STE when only changing config field
      iommu/arm-smmu-v3: Split arm_smmu_cmdq_issue_sync in half
      iommu/arm-smmu-v3: Consolidate identical timeouts

Yisheng Xie (1):
      iommu/arm-smmu-v3: Avoid ILLEGAL setting of STE.S1STALLD and CD.S

Zhen Lei (3):
      iommu/iova: Optimise rbtree searching
      iommu/iova: Optimise the padding calculation
      iommu/iova: Make dma_32bit_pfn implicit


[1] git://github.com/awilliam/linux-vfio.git
